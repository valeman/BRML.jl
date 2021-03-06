using FactCheck
using BRML


facts("Testing General Functions") do
    include("test_data.jl")

    context("argmin / argmax") do
        @fact argmin([]) => :throws
        @fact argmin([]) => :throws

        @fact argmin(scalar) => (1, 5)
        @fact argmax(scalar) => (1, 5)

        @fact argmin(array) => (3, 16)
        @fact argmax(array) => (2, 33)

        @fact argmin(vector) => (1, 11)
        @fact argmax(vector) => (2, 33)

        @fact argmin(matrix) => ([1 1 2], [12 2 26])
        @fact argmax(matrix) => ([2 2 1], [41 5 44])
    end

    context("logsumexp") do
        @fact logsumexp([]) => :throws
        @fact logsumexp(scalar) => 5
        @fact logsumexp(array) => roughly(33.002)
        @fact logsumexp(vector) => roughly(33)
        @fact logsumexp(matrix) => roughly([41 5.05 44], atol=0.01)
    end

    context("avgSigmaGauss") do
        @fact avgSigmaGauss(0, 0) => 0.5
        @fact avgSigmaGauss(0.2, 0.3) => roughly(0.547, atol=0.01)
    end

    context("cap") do
        @fact cap(-3, 2) => -2
        @fact cap([-5:5], 1) => [-1,-1,-1,-1,-1,0,1,1,1,1,1]
    end

    context("dirRand") do
        x = dirRand([1:10], 5)
        for i=1:5
            @fact sum(x[:,i]) => roughly(1)
        end
    end

    context("normP") do
        @fact normP(vector) => [1/6, 1/2, 1/3]
        @fact normP(matrix) => roughly([0.0923 0.0154 0.338; 0.315 0.0385 0.2],
                                         atol=0.01)
    end

    context("sigma") do
        @fact sigma(vector) => roughly([0.999, 1, 1], atol=0.01)
        @fact sigma(matrix) => roughly([0.999 0.88 1; 1 0.993 1], atol=0.01)
    end
end
