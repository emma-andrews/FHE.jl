using AbstractAlgebra
using FHE

@testset "ring construction" begin
    S = Simple(11, [1, 0, 0, 0, 1], 9)
    x = S.generator
    y = S.pt_generator
    # test rings set up correctly
    @test S.ring(4x^5 + 9x^4 + 9x^3 + x^2) == 9*x^3 + x^2 + 7*x + 2
    @test S.pt_ring(11y^4 + 5) == 2y^4 + 5

    # generate keys. can't predict output value due to distributions and randomness used,
    # so check that the return values were populated with something
    (b, a), sk = key_gen(S, 5)
    @test typeof(b) != Nothing && typeof(a) != Nothing && typeof(sk) != Nothing

    (ct0, ct1) = encrypt(S, 5, (b, a))
    println(ct0)
    @test typeof(ct0) != Nothing && typeof(ct1) != Nothing
end