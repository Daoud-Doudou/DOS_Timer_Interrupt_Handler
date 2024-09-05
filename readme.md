Ce projet présente quatre programmes modulaires en assembleur pour DOS, utilisant l'interruption 1CH pour gérer les tâches périodiques. Chaque programme est conçu pour illustrer différentes fonctionnalités de gestion du temps et d'affichage de messages.

## Programmes

1. **`1_tache`** : Affiche le message `‘1 sec écoulée…’` toutes les secondes, démontrant la gestion simple d'une tâche périodique.

2. **`1_tache2`** : Similaire à `1_tache`, mais avec une durée d'exécution limitée à 5 minutes. Affiche le message `‘1 sec écoulée…’` toutes les secondes.

3. **`5_tache`** : Affiche cinq messages séquentiels toutes les secondes :
   - Message de la tâche 1 : `‘Tâche 1 est en cours d’exécution....’`
   - Message de la tâche 2 : `‘Tâche 2 est en cours d’exécution....’`
   - Message de la tâche 3 : `‘Tâche 3 est en cours d’exécution....’`
   - Message de la tâche 4 : `‘Tâche 4 est en cours d’exécution....’`
   - Message de la tâche 5 : `‘Tâche 5 est en cours d’exécution....’`

4. **`5_tache2`** : Similaire à `5_tache`, mais avec une durée d'exécution limitée à 5 minutes. Affiche les cinq messages séquentiels.

## Objectif

Ces programmes démontrent comment utiliser l'interruption 1CH pour contrôler l'exécution périodique des tâches et gérer les temporisations sous DOS. Ils sont conçus pour être des exemples pédagogiques de la manipulation des interruptions et des temporisations en mode réel.

## Installation

1. Assurez-vous d'avoir un environnement DOS ou un émulateur DOS configuré pour exécuter les programmes en assembleur.
2. Assemblez les fichiers source avec un assembleur compatible DOS (par exemple, MASM ou TASM).
3. Exécutez les programmes sur l'environnement DOS ou l'émulateur.
