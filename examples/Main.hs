{-# LANGUAGE OverloadedStrings #-}
module Main where

import           Control.Concurrent
import qualified Control.Concurrent.ConLogger as Log
import           Control.Monad
import qualified Data.Text                    as T

main :: IO ()
main = do
  logger <- Log.new
  replicateM_ 100 (thread logger)
  Log.put logger "Main"

thread :: Log.ConLogger -> IO ()
thread logger = replicateM_ 50 (Log.put logger "Thread")
