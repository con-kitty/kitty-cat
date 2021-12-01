module Kitty.Cat.Plugin.Kitty (plugin) where

import Data.Monoid (Ap (..))
import qualified GhcPlugins
import Kitty.Cat.Hierarchy.Kitty (kittyHierarchy)
import Kitty.MakePlugin (makePlugin, neverAutoInterpret)
import Kitty.Plugin.Core.MakerMap (baseMakerMapFun)
import Kitty.Plugin.Hierarchy (First (..))
import qualified Kitty.Plugin.Hierarchy.ConCat as ConCat

plugin :: GhcPlugins.Plugin
plugin =
  makePlugin neverAutoInterpret baseMakerMapFun (const [])
    . getAp
    . fmap getFirst
    $ foldMap (Ap . fmap First) [ConCat.functionHierarchy, kittyHierarchy]
