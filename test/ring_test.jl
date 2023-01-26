using AbstractAlgebra
using FHE

@testset "ring construction" begin
    S = Simple(11, [1, 0, 0, 0, 1], 5)
    x = S.generator
    # test modulus set up correctly
    @test S.ring(4x^5 + 9x^4 + 9x^3 + x^2) == 9*x^3 + x^2 + 7*x + 2
    (b, a), sk = key_gen(S, 5)
    println(b)
end