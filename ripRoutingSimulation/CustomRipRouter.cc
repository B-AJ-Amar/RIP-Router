#include "inet/node/rip/RipRouter.h"
#include "inet/networklayer/common/InterfaceEntry.h"
#include "inet/common/ModuleAccess.h"

using namespace inet;

class CustomRipRouter : public RipRouter
{
  protected:
    virtual void receiveSignal(cComponent *source, simsignal_t signalID, cObject *obj, cObject *details) override {
        RipRouter::receiveSignal(source, signalID, obj, details);
        // When an interface changes, immediately trigger a RIP update
        if (signalID == NF_INTERFACE_STATE_CHANGED) {
            if (rip)
                rip->triggerUpdate();
        }
    }
};

Define_Module(CustomRipRouter);
