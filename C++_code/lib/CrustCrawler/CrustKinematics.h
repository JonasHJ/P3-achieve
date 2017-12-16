#ifndef CRUST_CRUSTKINEMATICS_H
#define CRUST_CRUSTKINEMATICS_H
#include <stdint.h>
#include "math.h"

class CrustKinematics  {
private:
    static constexpr uint8_t joints = 3, sol = 4;


    void filterLimits();

public:
    double new_theta[3][4] = {{0}}; // [rad] Current angles
    bool validSol[4] = {true}; // Default all solutions are valid

    void calcAngles(const double Pos[3]);
    void ikine(const double Pos[3], double q[3], int sol);
    void fkine(const double q[3], double Pos[3]);
    void poly_traj(const double q_init[3], const double q_final[3], const double &t_final, const double &t_current,
                   double q_pos[3], double q_vel[3], double q_acc[3]);

};


#endif //CRUST_CRUSTKINEMATICS_H
