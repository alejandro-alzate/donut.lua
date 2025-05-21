socket = require("socket")

k = 0
sin, cos, floor = math.sin, math.cos, math.floor

function main()
	A, B, i, j = 0, 0, 0, 0

	z = {}
	b = {}

	print("\27[2J")

	while true do
		for i = 0, 1760 do z[i] = 0.0 end
		for i = 0, 1760 do b[i] = " " end

		for j = 0, 6.28, 0.07 do
			for i = 0, 6.28, 0.07 do
				-- Floats. let them go nuts
				sini = sin(i)
				cosj = cos(j)
				sinA = sin(A)
				sinj = sin(j)
				cosA = cos(A)
				cosj2 = cosj + 2
				mess = 1 / (sini * cosj2 * sinA + sinj * cosA + 5)
				cosi = cos(i)
				cosB = cos(B)
				sinB = sin(B)
				t = sini * cosj2 * cosA - sinj * sinA

				-- These are ints and gotta be casted explicitly
				-- For lua there's not distiction between integers and floats
				-- But there are two instances where they are used as indexes
				x = floor(40 + 30 * mess * (cosi * cosj2 * cosB - t * sinB))
				y = floor(12 + 15 * mess * (cosi * cosj2 * sinB + t * cosB))
				o = floor(x + 80 * y)
				N = floor(
					8 *
					((sinj * sinA - sini * cosj * cosA) * cosB - sini * cosj * sinA - sinj * cosA - cosi * cosj * sinB))

				if 22 > y and y > 0 and x > 0 and 80 > x and mess > z[o] then
					z[o] = mess;
					local n = math.max(N, 1)
					b[o] = (".,-~:;=!*#$@"):sub(n, n)
				end
			end
		end

		print("\27[d")
		for k = 0, 1761 do
			io.stdout:write((k % 80 == 0 and "\n" or b[k]) or " ")
		end

		A = A + 0.04
		B = B + 0.02
		socket.sleep(0.01)
	end
end

main()
