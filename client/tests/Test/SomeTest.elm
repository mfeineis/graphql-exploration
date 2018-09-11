module Test.SomeTest exposing (suite)

import Expect
import Test exposing (Test, describe, test)


suite : Test
suite =
    describe "The test suite"
        [ test "that true is true" <|
            \_ ->
                Expect.equal True True
        ]
