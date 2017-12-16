#include "CrustKinematics.h"
#include "CrustCrawler.h"

/* wrap x -> [0,max) */
double wrapMax(double x, double max) {
    /* integer math: `(max + x % max) % max` */
    return fmod(max + fmod(x, max), max);
}
/* wrap x -> [min,max) */
double wrapMinMax(double x, double min, double max) {
    return min + wrapMax(x - min, max - min);
}
double wrapToPi(double x) {
    return wrapMinMax(x, -M_PI, +M_PI);
}

void CrustKinematics::ikine(const double *Pos, double *q, int sol) {
    calcAngles(Pos);
    q[0] = new_theta[0][sol];
    q[1] = new_theta[1][sol];
    q[2] = new_theta[2][sol];
}

void CrustKinematics::calcAngles(const double Pos[3]) {
    // Position of wrist
    const double pw_x = Pos[0];
    const double pw_y = Pos[1];
    const double pw_z = Pos[2];

    // **Theta 1**
    const double theta1 = atan2(pw_y, pw_x);
    for (int i = 0; i < sol; i++) {
        if (i < sol/2) {
            new_theta[0][i] = theta1;
        } else {
            new_theta[0][i] = wrapToPi(M_PI + theta1);
        }
    }



    // **Theta 3**
    double r[sol];
    const double r_temp = sqrt(pow(pw_x, 2) + pow(pw_y, 2));

    for (int i = 0; i < sol; i++) {
        if (i < sol/2) {
            r[i] = r_temp;
        } else {
            r[i] = -r_temp; // When elbow goes back over the shoulder
        }
    }

    const double h = -pw_z;

    for (int i = 0; i < sol; i++) {
        const double c3 = (pow(r[i], 2) + pow(h, 2) - pow(CrustCrawler::l[1], 2) - pow(CrustCrawler::l[2], 2)) / (2 * CrustCrawler::l[1] * CrustCrawler::l[2]);
        const double s3 = sqrt(1 - pow(c3, 2));

        if (isnan(s3)) // If angle unsolvable solution is invalid
            validSol[i] = false;

        if (i == 0 || i == 2) // Elbow down
            new_theta[2][i] = atan2(s3, c3);
        else // Elbow up
            new_theta[2][i] = atan2(-s3, c3);
    }


    // **Theta 2**
    for (int i = 0; i < sol; i++) {
        const double k1 = CrustCrawler::l[1] + CrustCrawler::l[2] * cos(new_theta[2][i]);
        const double k2 = CrustCrawler::l[2] * sin(new_theta[2][i]);

        new_theta[1][i] = wrapToPi(atan2(k1 * h - k2 * r[i], k1 * r[i] + k2 * h) + M_PI_2);
    }


    //CrustKinematics::filterLimits();
}

// Loops through the new_theta array with all solutions and checks if any value is over/under the limit for that specific
// joint. If any new_theta value is over/under the limit, set the validSol array element to false.
void CrustKinematics::filterLimits() {
    for(int i = 0; i < joints; i++) {
        // Find out-of-range solutions
        for(int j = 0; j < sol; i++) {
            // If the new_theta value is under the lower limit or over the upper limit
            if(new_theta[i][j] < CrustCrawler::A_lim[i][0] || new_theta[i][j] > CrustCrawler::A_lim[i][1])
                validSol[i] = false; // Set entire solution to invalid
        }
    }
}

// Forward kinematics. Gives [x, y, z] for a given [theta1, theta2, theta3]
void CrustKinematics::fkine(const double q[3], double Pos[3]) {
    Pos[0] = cos(q[0])*(CrustCrawler::l[2]*sin(q[1] + q[2]) + CrustCrawler::l[1]*sin(q[1]));
    Pos[1] = sin(q[0])*(CrustCrawler::l[2]*sin(q[1] + q[2]) + CrustCrawler::l[1]*sin(q[1]));
    Pos[2] = CrustCrawler::l[2]*cos(q[1] + q[2]) + CrustCrawler::l[1]*cos(q[1]);
}


// poly trajectory with 0 initial and final vel and acc.
// Gives a desired pos, vel, acc for all joints
void CrustKinematics::poly_traj(const double q_i[3], const double q_f[3], const double &t_f, const double &t,
                                double q_pos[3], double q_vel[3], double q_acc[3]) {
    for (int i = 0; i < 3; i++) {
        q_pos[i] = q_i[i] + (pow(t,5)*(12*q_f[i] - 12*q_i[i]))/(2*pow(t_f,5)) + (pow(t,3)*(20*q_f[i] - 20*q_i[i]))/(2*pow(t_f,3)) - (pow(t,4)*(30*q_f[i] - 30*q_i[i]))/(2*pow(t_f,4));
        q_vel[i] = (5*pow(t,4)*(12*q_f[i] - 12*q_i[i]))/(2*pow(t_f,5)) + (3*pow(t,2)*(20*q_f[i] - 20*q_i[i]))/(2*pow(t_f,3)) - (2*pow(t,3)*(30*q_f[i] - 30*q_i[i]))/pow(t_f,4);
        q_acc[i] = (10*pow(t,3)*(12*q_f[i] - 12*q_i[i]))/pow(t_f,5) - (6*pow(t,2)*(30*q_f[i] - 30*q_i[i]))/pow(t_f,4) + (3*t*(20*q_f[i] - 20*q_i[i]))/pow(t_f,3);
    }
}

