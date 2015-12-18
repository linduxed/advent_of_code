module Four (lowestSaltWithLeadingZeroes) where

import qualified Data.ByteString.Lazy.Char8 as BS
import qualified Data.Digest.Pure.MD5 as MD5
import qualified Data.Maybe as M
import           Data.List (find)

lowestSaltWithLeadingZeroes :: Int -> String -> Int
lowestSaltWithLeadingZeroes n key
    = fst $ M.fromJust $ find (hashHasFirstZeroes n . hash) saltHashPairs
      where
        hash = snd
        saltHashPairs = map (\n' -> (n', makeHash n')) [1..]
        makeHash salt = show $ MD5.md5 $ BS.pack $ (key ++ (show salt))

hashHasFirstZeroes :: Int -> String -> Bool
hashHasFirstZeroes n hash = all (== '0') $ take n hash
