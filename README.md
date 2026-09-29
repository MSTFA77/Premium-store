# Prime Shopping — Flutter Filtration Task

A modern, glassmorphic shopping app built for the Elevate Flutter Filtration Task.
Products are pulled from **two** public APIs, merged into one catalog, and can be
searched, filtered by category, favorited, and added to a cart.

## 🎥 Project Demo

Check out a video demonstration of the project in action:

https://github.com/user-attachments/assets/1bea5825-4ae1-4465-bbd4-ecee3da532a6

---


## Features

- **Product catalog** merged live from [fakestoreapi.com](https://fakestoreapi.com/products)
  and [dummyjson.com](https://dummyjson.com/products) into a single grid.
- **Search** by product title and **filter by category** (categories are derived from
  whatever both APIs return).
- **Favorites tab** — heart any product, review/remove favorites later.
- **Cart tab** — add products, adjust quantity, remove items, see a running total,
  and a mock checkout flow.
- **Bottom navigation bar** (Home / Favorites / Cart) with a live cart badge.
- **Modern glassmorphism UI** — frosted, blurred glass cards over a soft gradient
  backdrop, built with a single reusable `GlassContainer` widget.
- Graceful error/empty/loading states, pull-to-refresh, and partial-failure
  tolerance (if one API fails, the other's products still show).

## Architecture

Clean, feature-first architecture with an explicit data → domain → presentation
split per feature:

```
lib/
├── core/                         # Shared, cross-feature code
│   ├── api_error/                # Dio error → user-friendly message mapping
│   ├── constants/                # API base URLs & endpoints
│   ├── network/                  # Dio client factory
│   ├── di/                       # get_it service locator setup
│   ├── theme/                    # Colors, text styles, ThemeData
│   ├── utils/                    # Result<T> (Success / ResultFailure)
│   └── widgets/                  # GlassContainer, GradientBackground, state views
│
├── features/
│   ├── products/
│   │   ├── data/
│   │   │   ├── datasources/      # FakeStoreRemoteDataSource, DummyJsonRemoteDataSource
│   │   │   ├── models/           # ProductModel (API JSON → model)
│   │   │   └── repositories/     # ProductRepositoryImpl (merges both sources)
│   │   ├── domain/
│   │   │   ├── entities/         # ProductEntity (source-agnostic)
│   │   │   └── repositories/     # ProductRepository contract
│   │   └── presentation/
│   │       ├── cubit/            # ProductCubit + ProductState
│   │       ├── pages/            # HomePage
│   │       └── widgets/          # ProductCard, SearchField, CategoryFilter
│   │
│   ├── favorites/
│   │   └── presentation/         # FavoritesCubit + FavoritesState + FavoritesPage
│   │
│   └── cart/
│       ├── domain/entities/      # CartItemEntity
│       └── presentation/         # CartCubit + CartState + CartPage + CartItemCard
│
├── navigation/                   # MainNavigationPage + GlassBottomNavBar
└── main.dart
```

**Pattern:** MVI-style Cubit (bloc) per feature, repository pattern for data access,
and manual dependency injection via `get_it` (see `core/di/injection_container.dart`).
DI is wired manually rather than with `injectable` codegen so the project builds
immediately with `flutter pub get` — no `build_runner` step required.

### Why two API sources are merged

The task lists both `fakestoreapi.com/products` and `dummyjson.com/products`. Rather
than picking one, both are treated as first-class data sources behind the same
`ProductRemoteDataSource` contract, mapped to one shared `ProductEntity`, and merged
in the repository. IDs are prefixed (`fs_`, `dj_`) to stay unique once combined, and
if one API is unreachable the catalog still loads from whichever one succeeded.

## Getting started

1. Copy the contents of this `lib/` folder into your existing Flutter project
   (replacing the old `lib/`), and merge `pubspec.yaml`'s dependencies into yours.
2. Install packages:
   ```bash
   flutter pub get
   ```
3. Run the app:
   ```bash
   flutter run
   ```

## Tech stack

- Flutter, Dart 3 (sealed classes, pattern matching, records)
- `dio` — networking
- `flutter_bloc` / `cubit` — state management
- `get_it` — dependency injection
- `equatable` — value equality for states/entities
- `google_fonts`, `cached_network_image` — UI polish
