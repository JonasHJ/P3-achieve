function inv_M = crust_getInertiaInv( theta )
% This function calculates the inverse of the mass matrix term in the EoM.

inv_M = inv(crust_getInertia(theta));

end

