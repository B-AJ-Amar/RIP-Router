
import inet.node.inet.StandardHost;
import CustomRipRouter;

network LoopNetwork
{
    types:
        channel C extends ned.DatarateChannel
        {
            datarate = 100Mbps;
            delay = 0.1us;
        }
    submodules:
        r[3]: CustomRipRouter;
        h[3]: StandardHost;
    connections:
        // Connexion chaque routeur à son hôte
        for i=0..2 {
            h[i].ethg++ <--> C <--> r[i].ethg++;
        }
        // Connexion des routeurs en boucle (triangle)
        r[0].ethg++ <--> C <--> r[1].ethg++;
        r[1].ethg++ <--> C <--> r[2].ethg++;
        r[2].ethg++ <--> C <--> r[0].ethg++;
}