#include "CrustAlgorithm.h"

CrustAlgorithm::CrustAlgorithm(CrustCrawler *crust) : CrustController(crust) {

    // Set predefined points and save them in points[] array
    points[0] = {0}; // Home

    const double mouth[] = {0.33717, 0.35905, -0.03826}; // {x, y, z} [m]
    crust->ikine(mouth, points[1].theta, 1); // (Pos, theta, solution)

    const double cup[] = {-0.091273, -0.402675, -0.18722}; // {x, y, z} [m]
    crust->ikine(cup, points[2].theta, 1);  // (Pos, theta, solution)

    // Current pos
    points[4].theta[0] = crust->get_theta()[0];
    points[4].theta[1] = crust->get_theta()[1];
    points[4].theta[2] = crust->get_theta()[2];

    // Go to home
    phase = goToHome;
    from = &points[4]; // Current pos
    to = &points[0];   // Home
    state = running;
    time_i = millis();
}

/**
 * Runs the appropiate functions according to program state.
 */
void CrustAlgorithm::run() {

    switch(state){
        case waiting:
            time_i = millis();
            while (millis() < time_i+5000) // Wait 5 sec TODO:Check Myo
                holdPos();
            state = running;
            time_i = millis();
            break;
        case running:
            motionTo(to, 10*1000);
            break;
        case testing:
            holdTestPos(testing_servo);
            break;
        default:    // Error
            if(ALGORITH_DEBUG)
                Serial.println(F("--- Error in CrustAlgorithm ---"));
            delay(5000);
    }
}

/**
 * Moves the manipulator to a desired point.
 *
 * @param goal point with desired theta in radians
 * @param t_f time_final in milis
 */
void CrustAlgorithm::motionTo(Point *goal, unsigned int t_f) {
    // Calculate current time since motion start
    time_cur = (millis() - time_i);

    // Check if motion is done
    if(time_cur >= t_f) {
        nextPhase();
        return;
    }

    // Update desired_pos, desired_vel, desired_acc according to time in motion
    crust->poly_traj(from->theta, goal->theta, t_f/1000.0, time_cur/1000.0, desired_pos, desired_vel, desired_acc);

    // Read and update the current position and vel
    crust->update_theta();

    // Calculate the torque required
    update_tau(desired_pos, desired_vel, desired_acc, crust->get_theta(), crust->get_d_theta());

    // Convert the torque and send it to the servos
    crust->setTorque(get_tau());
}

/**
 * Calculates torque required to hold the last updated "current position".
 */
void CrustAlgorithm::holdPos() {
    // Read and update the current position and vel
    crust->update_theta();

    // Calculate the torque required.
    // desired_pos = current, desired_vel = 0, desired_acc = 0.
    update_tau(points[4].theta, {0}, {0}, crust->get_theta(), crust->get_d_theta());

    // Convert the torque and send it to the servos
    crust->setTorque(get_tau());
}

/**
 * Determians what the next phase is and sets the "to" and "from" points.
 */
void CrustAlgorithm::nextPhase() {
    // Update current position (points[4])
    points[4].theta[0] = crust->get_theta()[0];
    points[4].theta[1] = crust->get_theta()[1];
    points[4].theta[2] = crust->get_theta()[2];

    state = waiting;
    from = to;
    switch (phase) {
        case goToHome:
            phase = goToCup;
            to = &points[2];
            if(ALGORITH_DEBUG)
                Serial.println(F("Going to: cup"));
            break;
        case goToCup:
            phase = goToMouth;
            to = &points[1];
            if(ALGORITH_DEBUG)
                Serial.println(F("Going to: mouth"));
            break;
        case goToMouth:
            phase = goBackToCup;
            to = &points[2];
            if(ALGORITH_DEBUG)
                Serial.println(F("Going to: backToCup"));
            break;
        case goBackToCup:
            phase = goToHome;
            to = &points[0];
            if(ALGORITH_DEBUG)
                Serial.println(F("Going to: home"));
            break;
    }
}

/**
 * TODO:For testing purpose.
 */
void CrustAlgorithm::holdTestPos(unsigned char servo_id) {
    // Read and update the current position and vel
    crust->update_theta();


    time_cur = (millis() - time_i);
    Serial.print((time_cur/1000.0), 5);Serial.print('\t');
    unsigned long calc_start = millis();

    // Set all to 0
    for (int i = 0; i < 3; ++i) {
        points[4].theta[i] = 0;
    }

    // A*sin(w*t + phase)
    // Step
    if(time_cur < 5000) // Step after 5 sec
        points[4].theta[servo_id-1] = 0;
    else
        points[4].theta[servo_id-1] = 1;

    // Calculate the torque required.
    // desired_pos = current, desired_vel = 0, desired_acc = 0.
    update_tau(points[4].theta, {0}, {0}, crust->get_theta(), crust->get_d_theta());

    Serial.print((millis() - calc_start)/1000.0);Serial.print('\t');

    Serial.print(points[4].theta[servo_id-1], 5);Serial.print('\t'); // Desired
    Serial.print(crust->get_theta()[servo_id-1], 5);Serial.print('\t'); // Measured


    // Convert the torque and send it to the servos
    crust->setTorque(get_tau()[servo_id-1], servo_id); // (tau, servo_id)
}

/**
 * Sets the program to testing mode and only the servo_id is set to torque-mode.
 * @param servo_id
 */
void CrustAlgorithm::beginTest(unsigned char servo_id) {
    state = testing;
    testing_servo = servo_id;

    // Sets position of all joints and sets one servo back to torque-mode
    crust->setTestMode(testing_servo);

    // Start timing
    time_i = millis();
}