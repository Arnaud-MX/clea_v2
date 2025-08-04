# Animation d'arrière-plan Cléa

## Utilisation

Le widget `AnimatedBackground` fournit une animation d'arrière-plan fluide et moderne pour l'application Cléa, avec des formes organiques flottantes et des dégradés subtils.

### Import
```dart
import 'package:clea/widgets/animated_background.dart';
```

### Usage basique
```dart
AnimatedBackground(
  child: YourContentWidget(),
)
```

### Intensités disponibles

#### `BackgroundIntensity.normal` (par défaut)
Parfait pour les écrans d'accueil et d'onboarding
```dart
AnimatedBackground(
  intensity: BackgroundIntensity.normal,
  child: YourContentWidget(),
)
```

#### `BackgroundIntensity.subtle`
Idéal pour les écrans avec beaucoup de contenu (tableaux de bord, formulaires)
```dart
AnimatedBackground(
  intensity: BackgroundIntensity.subtle,
  child: YourContentWidget(),
)
```

#### `BackgroundIntensity.dynamic`
Pour les écrans de célébration ou d'accomplissement
```dart
AnimatedBackground(
  intensity: BackgroundIntensity.dynamic,
  child: YourContentWidget(),
)
```

### Désactiver l'animation
```dart
AnimatedBackground(
  enableAnimation: false,
  child: YourContentWidget(),
)
```

## Caractéristiques techniques

- **Durée du cycle complet** : 15-30 secondes
- **Couleurs** : Basées sur le thème de l'app (bleu clair, blanc, gris perle)
- **Performance** : Optimisé pour mobile avec des animations fluides
- **Lisibilité** : Compatible avec du texte blanc ou noir par-dessus
- **Style** : Minimaliste, premium, inspiré d'Apple

## Thème visuel

L'animation évoque :
- Finance personnelle et sérénité
- Évolution et progression
- Sécurité et confiance
- Modernité et élégance

## Implementation

L'animation utilise :
- `CustomPainter` pour les formes organiques
- Plusieurs `AnimationController` avec des cycles différents
- Courbes de Bézier pour des transitions fluides
- Effets de halo avec `MaskFilter.blur`
- Dégradés radiaux animés