import inet.node.inet.StandardHost;
import CustomRipRouter;

network VeryLargeNetwork
{
    types:
        channel C extends ned.DatarateChannel
        {
            datarate = 100Mbps;
            delay = 0.1us;
        }
    //submodules:
      //  h1: StandardHost;
        //h2: StandardHost;
        //r[10]: CustomRipRouter { // 10 routeurs
          //  @display("p=54,58");
        //}
    //connections:
        //h1.ethg++ <--> C <--> r[0].ethg++;
      //  r[0].ethg++ <--> C <--> r[1].ethg++;
        //r[1].ethg++ <--> C <--> r[2].ethg++;
       // r[2].ethg++ <--> C <--> r[3].ethg++;
        //r[3].ethg++ <--> C <--> r[4].ethg++;
        //r[4].ethg++ <--> C <--> r[5].ethg++;
        //r[5].ethg++ <--> C <--> r[6].ethg++;
        //r[6].ethg++ <--> C <--> r[7].ethg++;
        //r[7].ethg++ <--> C <--> r[8].ethg++;
        //r[8].ethg++ <--> C <--> r[9].ethg++;
        //r[9].ethg++ <--> C <--> h2.ethg++;
        submodules:
        r0: CustomRipRouter;
        r1: CustomRipRouter;
        h[10]: StandardHost;
    connections:
       
        for i=0..4 {
            h[i].ethg++ <--> C <--> r0.ethg++;
        }
       
        for i=5..9 {
            h[i].ethg++ <--> C <--> r1.ethg++;
        }
       
        r0.ethg++ <--> C <--> r1.ethg++;
}
