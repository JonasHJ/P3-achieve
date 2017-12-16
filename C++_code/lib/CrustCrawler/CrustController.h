#ifndef CRUST_CRUSTCONTROLLER_H
#define CRUST_CRUSTCONTROLLER_H

#include <math.h>
#include "CrustCrawler.h"

#define CONTROLLER_DEBUG 1

class CrustController {
protected:
    static constexpr double Kp = 3.25*3.25; // Wn^2
    static constexpr double Kv = 2*0.99*3.25; // 2*zeta*Wn

    double tau[3] = {0}; // Calculated torque
    CrustCrawler *crust; // Reference object

public:
    explicit CrustController(CrustCrawler *crust) : crust(crust) {}

    void update_tau(const double theta_des[3], const double d_theta_des[3], const double dd_theta_des[3],
                    const double theta[3], const double d_theta[3]);
    const double *get_tau();
};


#endif //CRUST_CRUSTCONTROLLER_H
