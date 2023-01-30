export Simple, key_gen, encrypt, decrypt, add, mult

"""
    Simple HE scheme for learning/tutorial purposes.
    Do not use in practice, has no security.
"""
struct Simple <: HE
    ring
    generator
    pt_ring
    pt_generator
    ct_mod::Int64
    pt_mod::Int64
    poly_mod
    pt_poly_mod
end

function Simple(ct_mod::Int64, coeffs::Vector{Int64}, pt_mod::Int64)
    R = ResidueRing(ZZ, ct_mod)
    S, x = PolynomialRing(R, "x")
    V = ResidueRing(ZZ, pt_mod)
    Q, y = PolynomialRing(V, "y")

    poly_mod = 0
    pt_poly_mod = 0

    for (index, value) in enumerate(coeffs)
        if value == 0
            continue
        end
        poly_mod += value * x^(index - 1)
        pt_poly_mod += value * y^(index - 1)
    end

    U = ResidueRing(S, poly_mod)

    return Simple(U, x, Q, y, ct_mod, pt_mod, poly_mod, pt_poly_mod)
end

"""
    key_gen(S::Simple, size::Int64)

Public key is tuple ([-(a*sk+e)]_q, a)
where a is polynomial, e is small error polynomial, sk is random secret key polynomial
"""
function key_gen(S::Simple, size::Int64)
    sk = 0
    a = 0
    e = 0
    x = S.generator

    for i in 1:size
        # Generate secret key polynomial in R_2
        sk += rand((0, 1)) * x ^ (i - 1)
        # Generate a in R_ctmod
        a += rand(0:S.ct_mod) * x ^ (i - 1)
        # Generate error in R_ctmod
        e += rand((0, 1)) * x ^ (i - 1)
    end

    # Calculate public key
    tmp = S.ring(a * e)
    tmp = S.ring(tmp + e)
    tmp = S.ring(-1 * tmp)

    return (tmp, a), sk
end

"""
    encrypt(S::Simple, pt::Int64)
"""
function encrypt(S::Simple, pt::Int64)

end

"""
    decrypt(S::Simple)
"""
function decrypt(S::Simple)

end

"""
    add(S::Simple)
"""
function add(S::Simple)

end

"""
    mult(S::Simple)
"""
function mult(S::Simple)

end