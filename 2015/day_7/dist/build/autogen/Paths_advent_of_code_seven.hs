{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -fno-warn-implicit-prelude #-}
module Paths_advent_of_code_seven (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/linduxed/.cabal/bin"
libdir     = "/home/linduxed/.cabal/lib/x86_64-linux-ghc-8.0.1/advent-of-code-seven-0.1.0.0-FyIsYianrkl9zemvMmXjKa"
datadir    = "/home/linduxed/.cabal/share/x86_64-linux-ghc-8.0.1/advent-of-code-seven-0.1.0.0"
libexecdir = "/home/linduxed/.cabal/libexec"
sysconfdir = "/home/linduxed/.cabal/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "advent_of_code_seven_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "advent_of_code_seven_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "advent_of_code_seven_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "advent_of_code_seven_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "advent_of_code_seven_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
