import inet.common.misc.ThruputMeteringChannel;
import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;
import inet.networklayer.ipv4.RoutingTableRecorder;
import inet.node.ethernet.EthernetSwitch;
import inet.node.inet.StandardHost;
import CustomRipRouter;

network CustomRipNetwork
{
    parameters:
        @display("p=10,10;b=712,152");

    types:
        channel C extends ThruputMeteringChannel
        {
            delay = 0.1us;
            datarate = 100Mbps;
            thruputDisplayFormat = "#N";
        }

    submodules:
        rtr: RoutingTableRecorder {
            @display("p=100,300;is=s");
        }
        H1: StandardHost {
            parameters:
                @display("p=250,200;i=device/laptop");
            gates:
                ethg[1];
        }
        N1: EthernetSwitch {
            parameters:
                @display("p=400,200");
            gates:
                ethg[2];
        }
        R1: CustomRipRouter {
            parameters:
                @display("p=550,200");
            gates:
                ethg[2];
        }
        R2: CustomRipRouter {
            parameters:
                @display("p=700,200");
            gates:
                ethg[2];
        }
        N2: EthernetSwitch {
            parameters:
                @display("p=850,200");
            gates:
                ethg[2];
        }
        H2: StandardHost {
            parameters:
                @display("p=1000,200;i=device/laptop");
            gates:
                ethg[1];
        }
        
      configurator: Ipv4NetworkConfigurator {
          parameters:
                config = xml("<config>"+
                            "<interface among='H1 R1' address='192.168.1.x' netmask='255.255.255.0' />"+
                            "<interface among='H2 R2' address='192.168.2.x' netmask='255.255.255.0' />"+
                            "<interface among='R1 R2' address='192.168.60.x' netmask='255.255.255.0' />"+
                            "<route hosts='H1 H2' destination='*' netmask='0.0.0.0' interface='eth0' />"+
                            "</config>");
                addStaticRoutes = false;
                addDefaultRoutes = false;
                @display("p=100,100;is=s");
        }
        
      //  configurator: Ipv6NetworkConfigurator {
    //parameters:
      //  config = xml("<config>"+
        //             "<interface among='H1 R1' address='2001:db8:1::x' prefixLength='64' />"+
          //           "<interface among='H2 R2' address='2001:db8:2::x' prefixLength='64' />"+
            //         "<interface among='R1 R2' address='2001:db8:60::x' prefixLength='64' />"+
              //       "</config>");
       // addStaticRoutes = false;
        //addDefaultRoutes = false;
        //@display("p=100,100;is=s");
//}
    connections:
        H1.ethg[0] <--> C <--> N1.ethg[0];
        N1.ethg[1] <--> C <--> R1.ethg[0];
        R1.ethg[1] <--> C <--> R2.ethg[0];
        R2.ethg[1] <--> C <--> N2.ethg[0];
        N2.ethg[1] <--> C <--> H2.ethg[0];
}