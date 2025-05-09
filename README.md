# Rapport du Projet d'Amélioration du Protocole RIP avec OMNeT++ et INET Framework

## Introduction
L’objectif de ce projet était de mettre en œuvre et d’améliorer le protocole de routage RIP (Routing Information Protocol) en utilisant l’environnement de simulation OMNeT++ et le framework INET. Le RIP est un protocole de routage simple basé sur l’algorithme de "Distance-Vector Routing". L’objectif était d’améliorer ses performances grâce à des techniques comme Split Horizon et l’optimisation des intervalles de mise à jour.

---

## Travaux Réalisés
### 1. Configuration de l’Environnement de Travail :
- Installation d’OMNeT++ et du framework INET (des problèmes techniques rencontrés lors de l’installation ont nécessité du temps supplémentaire).
- Création d’un nouveau projet OMNeT++ et configuration des dépendances avec INET.

### 2. Création de la Topologie Réseau :
- Une petite topologie réseau a été conçue, incluant :
  - Router1 et Router2 configurés avec le protocole RIP.
  - Host1 et Host2 pour tester l'échange de données.
- La topologie a été définie dans le fichier NED comme suit :
ned name=RIPNetwork.ned
import inet.networklayer.autorouting.FlatNetworkConfigurator;
import inet.networklayer.rip.RIP;

network RIPNetwork {
    submodules:
        configurator: FlatNetworkConfigurator;
        router1: Router {
            rip: RIP;
        }
        router2: Router {
            rip: RIP;
        }
        host1: StandardHost;
        host2: StandardHost;
    connections:
        // Définissez vos connexions ici (ex: Ethernet, PPP, etc.)
}

### 3. Configuration de RIP :
- Les paramètres de configuration de RIP ont été définis dans le fichier `omnetpp.ini` comme suit :
ini name=omnetpp.ini
[General]
network = RIPNetwork
sim-time-limit = 1000s

# Configuration du protocole RIP
*.router.hasRip = true  # Activer le module RIP
*.router.rip.updateInterval = 30s
*.router.rip.routeTimeout = 180s
*.router.rip.routeGarbageCollectionTime = 120s

# Configuration IPv4
.configurator.addStaticRoutes = false  # Désactiver les routes statiques pour utiliser RIP
.configurator.addDefaultRoutes = false
**.configurator.config = xmldoc("ipv4_config.xml")

# Génération de trafic
*.host1.numApps = 1
*.host1.app[0].typename = "UdpBasicApp"
*.host1.app[0].destAddresses = "host2"
*.host1.app[0].destPort = 5000
*.host1.app[0].messageLength = 1000B
*.host1.app[0].sendInterval = 1s
*.host1.app[0].startTime = 10s

*.host2.numApps = 1
*.host2.app[0].typename = "UdpEchoApp"
*.host2.app[0].localPort = 5000

- Les paramètres supplémentaires ont été définis dans le fichier **ipv4_config.xml :
```xml name=ipv4_config.xml
<ripConfig>
    <interface hosts="router*" names="eth*" metric="1" mode="splitHorizon"/>
    <timers
        routeTimeout="180s"
        routeGarbageCollection="120s"
        updateInterval="30s"
    />
</ripConfig>
```

### 4. **Tests de Base :
- Une application UDP a été configurée pour échanger des messages entre Host1 et Host2 via les routeurs.
- La simulation a été exécutée, et les mises à jour des tables de routage ont été observées.

---

## Difficultés Rencontrées
1. Problèmes avec l'installation d'OMNeT++ et d'INET Framework :
   - La compatibilité entre les versions a posé des problèmes, ce qui a retardé le début du projet.
2. Manque de temps :
   - Le temps limité n’a pas permis d’achever les améliorations prévues ou d’intégrer des fonctionnalités supplémentaires comme :
     - Route Poisoning pour améliorer la stabilité du réseau.
     - L’analyse des performances avec des indicateurs comme le temps de convergence et le taux de livraison des paquets.
3. Configuration complexe :
   - La configuration des intervalles de mise à jour et des paramètres réseau a nécessité de nombreux ajustements.

---

## Améliorations Proposées
Si nous avions eu plus de temps, nous aurions entrepris les tâches suivantes :
1. Optimisation des Performances :
   - Ajouter des fonctionnalités comme Split Horizon pour éviter les boucles de routage.
   - Réduire le temps de convergence et améliorer l’efficacité globale.
2. Analyse des Performances :
   - Mesurer les indicateurs clés tels que :
     - Temps de Convergence.
     - Délai de bout en bout (End-to-End Delay).
     - Taux de Livraison des Paquets.
3. Extension de la Topologie :
   - Ajouter davantage de routeurs et d’hôtes pour tester l’évolutivité du protocole.

---

## Conclusion
Malgré les contraintes de temps et les défis techniques, nous avons réussi à configurer une petite topologie pour tester les fonctionnalités de base du protocole RIP. Toutefois, plusieurs améliorations restent à implémenter pour pleinement exploiter les capacités du protocole. Ce projet constitue une base solide pour des travaux futurs dans le domaine des protocoles de routage.

---

## Annexes
1. Fichiers du projet :
   - RIPNetwork.ned
   - omnetpp.ini
   - config.xml
   
## By
- Amar Abdeldjalil Bouakaz
- Adem Kolli
- Sarah Djerrab
- Hanna Bouhouita Guermèch
- Fairouz Cheikh-Bassa 
- Tasnim Bagha
- Khaoula Merah
