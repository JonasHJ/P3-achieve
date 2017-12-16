#ifndef CRUST_CRUSTALGORITHM_H
#define CRUST_CRUSTALGORITHM_H

#define ALGORITH_DEBUG 1

#include "CrustCrawler.h"
#include "CrustController.h"

enum State {waiting, running, error, testing}; // State of the program
enum Phase {goToCup, goToMouth, goBackToCup, goToHome};

struct Point {
    double theta[3];
};

class CrustAlgorithm : public CrustController {
private:
    Phase phase;
    Point *from, *to;
    Point points[5];
    unsigned char testing_servo;
    unsigned long time_i; // [ms]
    unsigned long time_cur; // [ms]
    double desired_pos[3], desired_vel[3], desired_acc[3];

public:
    State state = waiting;
    CrustAlgorithm(CrustCrawler *crust);

    void run();
    void beginTest(unsigned char);
    void motionTo(Point*, unsigned int);
    void holdPos();
    void holdTestPos(unsigned char servo_id);
    void nextPhase();
};


#endif //CRUST_CRUSTALGORITHM_H
