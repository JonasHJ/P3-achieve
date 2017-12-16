#ifndef CRUST_H
#define CRUST_H

#include <math.h>
#include "CrustDynamics.h"
#include "CrustKinematics.h"
#include "CrustInterface.h"

#define CRUSTCRAWLER_DEBUG 0

class CrustCrawler : public CrustDynamics, public CrustKinematics, public CrustInterface {
private:
    double theta[3];    // [rad] Current angles
    double d_theta[3];  // [rad/s]
    unsigned long last_update; // [ms] Time at last update

public:
    static constexpr double l[3] = {0, 0.22, 0.2779}; // [m] Link lengths
    static constexpr double A_lim[3][2] = {{-M_PI, M_PI}, // Limits on joints [rad] {min, max}
                                {-71.209*M_PI/180, 294.418*M_PI/180},
                                {-67.165*M_PI/180, 294.769*M_PI/180}};

    void begin(Dynamixel *servo);
    void update_theta();
    const double *get_theta();
    const double *get_d_theta();

};

#endif //CRUST_H
