
#Alternate linear model fit. GLM package is a little nicer
x = u1[1:N]
X = [ones(length(x)) x]
y = ent_rain_df[1:N, :ent_anom]


linfit = X \ y

yhat = @. linfit[1] + linfit[2] * x;
println("Intercept = "*string(linfit[1])*"\nSlope = "*string(linfit[2]))

x = ent_rain_df[1:N, :rain_48_anom]
X = [ones(length(x)) x]
y = ent_rain_df[1:N, :ent_anom]

linfit = X \ y

yhat = @. linfit[1] + linfit[2] * x;

## Dimensional array fitting

