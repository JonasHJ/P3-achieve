#include "CrustController.h"
/**
 * Calculates the required torque according the desired pos, vel, acc and current_pos, current_vel
 * using Kp and Kv gains, and dynamic terms. It saved the value in the local value tau.
 *
 * @param theta_des
 * @param d_theta_des
 * @param dd_theta_des
 * @param theta
 * @param d_theta
 */
void
CrustController::update_tau(const double theta_des[3], const double d_theta_des[3], const double dd_theta_des[3],
                            const double theta[3], const double d_theta[3]) {
    // Reset tau values
    tau[0] = 0; tau[1] = 0; tau[2] = 0;

    double tau_temp[3] = {0};
    for (int i = 0; i < 3; ++i) {
        tau_temp[i] = (theta_des[i]-theta[i])*Kp + (d_theta_des[i]-d_theta[i])*Kv + dd_theta_des[i];
    }



    // Dynamics
    crust->add_Inertia(theta, tau_temp, tau);
    crust->add_Velocity(theta, d_theta, tau);
    crust->add_Gravity(theta, tau);

    // Add Gains
    tau[2] *= 4;
}

/**
 * Returns the calculated torque array.
 * @return
 */
const double *CrustController::get_tau(){
    return tau;
}
