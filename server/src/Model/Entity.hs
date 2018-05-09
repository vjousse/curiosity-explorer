{-# LANGUAGE DeriveGeneric   #-}
module Model.Entity
    ( Entity(..)
    ) where

import qualified Data.Time as DT
import GHC.Generics
import Data.Aeson

data Entity = Entity
  { id         :: Int
  , title      :: String
  , description  :: String
  } deriving (Eq, Show, Generic)

instance FromJSON Entity
instance ToJSON Entity
