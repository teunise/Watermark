-- Bullet drop implementation for a musket system

if gun:fire() then
    local bullet = gun:CreateProjectile("Bullet")
    bullet:SetPosition(gun:GetPosition())
    bullet:SetVelocity(gun:GetForwardVector() * 1000) -- Initial velocity of the bullet
    bullet:SetGravity(9.81) -- Gravity affecting the bullet
    bullet:SetDrag(0.3) -- Air drag
    bullet:SetAirFriction(0.1) -- Air friction

    -- Simulate bullet drop over time
    local bulletTime = 0 -- Time since the bullet was fired
    local bulletDrop = 9.81 -- Gravity in m/s^2

    game:GetService("RunService").Stepped:Connect(function(_, deltaTime)
        bulletTime = bulletTime + deltaTime
        local currentPosition = bullet:GetPosition()
        local velocity = bullet:GetVelocity()

        -- Update position and velocity with gravity
        local newVelocity = velocity - Vector3.new(0, bulletDrop * deltaTime, 0)
        local newPosition = currentPosition + newVelocity * deltaTime

        bullet:SetPosition(newPosition)
        bullet:SetVelocity(newVelocity)

        -- Stop simulation if the bullet hits something
        if bullet:HasCollided() then
            return
        end
    end)
end