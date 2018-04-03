#plot
function disp_stocks(X, dates, names)
    n, d = size(X)

    figure()
    for i = 1:d
        plot(dates, X[:,i], label = names[i])
    end

    xlabel("dates")
    ylabel("Rate of return")
    ylim([-1., 1.])
    #title()
    #legend()
    legend(bbox_to_anchor=(1.05, 1), loc=2, borderaxespad=0.)
    show()

end


#random portfolio
function portfolio_scatter(r, Sig, num)
    n = length(r)
    randmu = zeros(num)
    randSig = zeros(num)
    figure()
    for i = 1:num
        k = 5
        #Random select 5 stocks
        inds = randperm(n);
        inds = inds[1:k]
        #Construct weights
        weight = rand(k); weight = weight ./ sum(weight)
        randmu[i] = dot(weight, r[inds])
        randSig[i] = sqrt( (weight' * Sig[inds, inds] * weight)[1,1] )
    end
    plot(randSig, randmu, "b+", markersize = 5)
    xlabel("Std. Dev.")
    ylabel("Expected Rate of Returen")

end

#display function
function disp_portfolios(Y, rates, sigs, names)
    n, num = size(Y)
    
    #Print table
    table_width = 12 + 7*num
    @printf "\n"
    @printf "%s" repeat("=",table_width)
    @printf "\n"
    @printf "%12s" "Portfolio"
    for i = 1:num
        @printf "%7.0f" i
    end
    @printf "\n"
    @printf "%s" repeat("-",table_width)
    @printf "\n"
    for ii = 1:n
        @printf "%6d%6s" ii names[ii]
        for j = 1:num
            @printf "%7.1f" 100*Y[ii,j] 
        end
        @printf "\n"
    end
    @printf "%s" repeat("-",table_width)
    @printf "\n"
    
    @printf "%12s" "E[Return] ="
    for i = 1:num
        @printf "%7.1f" 100*rates[i]
    end
    @printf "\n"
    @printf "%12s" "Std. Dev. ="
    for i = 1:num
        @printf "%7.1f" 100*sigs[i]
    end
    @printf "\n"
    @printf "%s" repeat("=",table_width)
    @printf "\n"
    
    
    #Pie Charts
    for ii = 1:num
        figure( ceil(ii/4) )
        subplot(2,2,(ii-1)%4+1)
        r = Y[:,ii]
        idx = find(r .> 1e-3)
        pie(Y[idx,ii],labels=names[idx],autopct="%1.1f%%")
        title_str = @sprintf "Portfolio %i\nE[Return] = %.1f%%, Std. Dev. = %.1f%%" ii 100*rates[ii] 100*sigs[ii]
        title( title_str, fontsize = 9.0 )
    end
        
end


