module Control.Concurrent.ConLogger
       ( ConLogger
       , new
       , put
       ) where

import           Control.Applicative
import           Control.Concurrent      (forkIO)
import           Control.Concurrent.Chan (Chan, newChan, readChan, writeChan)
import           Control.Monad           (void)
import qualified Data.Text               as T (Text)
import qualified Data.Text.IO            as T (putStrLn)
import           Prelude                 hiding (log)

newtype ConLogger = ConLogger { conLogger :: Chan T.Text }

new :: IO ConLogger
new = do
  ch <- ConLogger <$> newChan
  void $ forkIO (runner ch)
  return ch

put :: ConLogger -> T.Text -> IO ()
put cl = writeChan (conLogger cl)

runner :: ConLogger -> IO ()
runner cl = do
  log <- readChan chan
  T.putStrLn log
  runner cl
  where
    chan = conLogger cl
