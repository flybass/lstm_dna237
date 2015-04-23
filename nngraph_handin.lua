require 'nngraph'
require 'torch'


x_1 = torch.rand(5)
x_2 = torch.rand(5)
x_3 = torch.rand(10)

x1 = nn.Identity()()
x2 = nn.Identity()()
x3 = nn.Identity()()
xlin = nn.Linear(10,5)({x3})

el_m = nn.CMulTable()({x2,xlin})
el_p = nn.CAddTable()({x1,el_m})

gmod = nn.gModule({x1,x2,x3},{el_p})

print ('Computed from gmod')
print (gmod:updateOutput({x_1,x_2,x_3}))
print ('Computed by torch linalg methods')
print (torch.cmul(gmod:parameters()[1] * x_3 + gmod:parameters()[2], x_2) + x_1)
