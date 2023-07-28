function onCreate()
	makeLuaSprite('ratroom', 'room', 0, 0)
	scaleObject('ratroom', 1, 1)
	setProperty('ratroom.antialiasing', false)
	setProperty('ratroom.alpha', 0.65)
	addLuaSprite('ratroom', false)

	makeLuaSprite('ratroomblood', 'room blood', 0, 0)
	scaleObject('ratroomblood', 1, 1)
	setProperty('ratroomblood.antialiasing', false)
	setProperty('ratroomblood.alpha', 0)
	addLuaSprite('ratroomblood', false)
	
	makeLuaSprite('roombloodopen', 'blood open', 0, 0)
	scaleObject('roombloodopen', 1, 1)
	setProperty('roombloodopen.antialiasing', false)
	setProperty('roombloodopen.alpha', 0)
	addLuaSprite('roombloodopen', false)

	makeLuaSprite('dead', 'cat dead', 150, 65)
	scaleObject('dead', 1, 1)
	setProperty('dead.antialiasing', false)
	setProperty('dead.alpha', 0)
	addLuaSprite('dead', false)

	precacheImage('white')
	precacheImage('characters/whatswrong')

	makeLuaSprite('bars', 'bars', -1500, 0);
    scaleObject('bars', 1, 1);
    setObjectCamera('bars', 'HUD');

    addLuaSprite('bars', false);

	makeAnimatedLuaSprite('blood', 'blood', 62, 122)
	addAnimationByPrefix('blood', 'blood1', 'blood blood1', 24, true)
	addAnimationByPrefix('blood', 'blood2', 'blood blood2', 24, true)
	addAnimationByPrefix('blood', 'blood3', 'blood blood3', 24, true)
	addAnimationByPrefix('blood', 'blood4', 'blood blood4', 24, true)
	addAnimationByPrefix('blood', 'blood5', 'blood blood5', 24, true)
	addAnimationByPrefix('blood', 'blood6', 'blood blood6', 24, true)
	addAnimationByPrefix('blood', 'blood7', 'blood blood7', 24, true)
	setProperty('blood.antialiasing', false)
	addLuaSprite('blood', false)
	setProperty('blood.alpha', 0)

	makeAnimatedLuaSprite('ratdie', 'ratdie', 65, 85)
	addAnimationByPrefix('ratdie', 'ratdie fall', 'ratdie fall', 24, true)
	addAnimationByPrefix('ratdie', 'ratdie hit', 'ratdie hit', 24, true)
	addAnimationByPrefix('ratdie', 'ratdie die', 'ratdie die', 24, true)

	setProperty('ratdie.alpha', 0)

	setProperty('ratdie.antialiasing', false)

	addLuaSprite('ratdie', false)

	setProperty('skipCountdown', true)

	setPropertyFromClass('GameOverSubstate', 'characterName', 'whatswrong')
	setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'vinnie')
	setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'vinnie')
	setPropertyFromClass('GameOverSubstate', 'endSoundName', '')
end

function onEndSong()
  if isStoryMode then
    addHaxeLibrary("CreditsState")
    addHaxeLibrary("MusicBeatState")
   runHaxeCode("MusicBeatState.switchState(new CreditsState())")
  return Function_Stop;
  end
end

function onGameOver()
	setProperty('camGame.alpha', 0.5)
	setProperty('camGame.zoom', 1.5)

	setProperty('boyfriend.x', -200)
	setProperty('boyfriend.y', -50)
	scaleObject('boyfriend', 2, 2)
end

function onCreatePost()
	setProperty('gf.alpha', 0)
	
	doTweenAlpha('bars', 'bars', 2, 2, 'quadOut')

	setProperty('camGame.alpha', 0)
	setProperty('camHUD.alpha', 0)

	addCharacterToList('catwalk', 'dad')
end

function opponentNoteHit()
	if getProperty('health') > 0.1 then
		setProperty('health', getProperty('health') - 0.015)
	end
end

function onUpdate()
	if dadName == 'rat-puppet-fight' then
		setObjectOrder('dad', getObjectOrder('boyfriend') - 100)
	elseif dadName == 'rat-rat-fight' or dadName == 'cat' then
		setObjectOrder('dad', getObjectOrder('boyfriend') + 100)
	end
end

function onStepHit()
	if curStep == 16 then
		doTweenAlpha('camHud', 'camHUD', 1, 1, 'quadOut')

		noteTweenAlpha('0', 0, 0, 0.01, 'quadOut')
		noteTweenAlpha('1', 1, 0, 0.01, 'quadOut')
		noteTweenAlpha('2', 2, 0, 0.01, 'quadOut')
		noteTweenAlpha('3', 3, 0, 0.01, 'quadOut')
	elseif curStep == 32 then
		doTweenAlpha('camgame', 'camGame', 1, 0.5, 'quadOut')
	elseif curStep == 160 then
		doTweenX('bars', 'bars', 0, 2.5, 'quadOut')
	elseif curStep == 288 then
		doTweenX('bars', 'bars', 1500, 2.5, 'quadIn')
	elseif curStep == 796 then
		setProperty('camGame.alpha', 0)
		doTweenX('bars', 'bars', 0, 0.1, 'quadOut')
	elseif curStep == 800 then
		setProperty('camGame.alpha', 1)
		setProperty('boyfriend.x', 77)
	elseif curStep == 824 then
		setProperty('camGame.alpha', 0)
	elseif curStep == 832 then
		setProperty('camGame.alpha', 1)
	elseif curStep == 856 then
		setProperty('camGame.alpha', 0)
	elseif curStep == 864 then
		setProperty('camGame.alpha', 1)
	elseif curStep == 936 then
		cameraSetTarget('boyfriend')
	elseif curStep == 944 then
		cameraSetTarget('dad')
	elseif curStep == 961 then
		cameraSetTarget('boyfriend')
	elseif curStep == 1000 then
		cameraSetTarget('dad')
	elseif curStep == 1008 then
		cameraSetTarget('boyfriend')
	elseif curStep == 1024 then
		cameraSetTarget('dad')
	elseif curStep == 1048 then
		setProperty('camGame.alpha', 0)
	elseif curStep == 1056 then
		setProperty('camGame.alpha', 1)
		setProperty('dad.alpha', 0)
		
		setProperty('ratdie.alpha', 1)
		objectPlayAnimation('ratdie', 'ratdie fall', true)
		doTweenX('ratfallX', 'ratdie', 55, 0.25, 'quadOut')
		setProperty('camHUD.alpha', 0)
	elseif curStep == 1064 then
		objectPlayAnimation('ratdie', 'ratdie hit', true)
		doTweenX('rathitX', 'ratdie', 45, 0.25, 'quadOut')
		doTweenY('rathitY', 'ratdie', 90, 0.25, 'quadOut')
		
		setProperty('room.alpha', 0)
		setProperty('ratroomblood.alpha', 0.65)
	elseif curStep == 1068 then
		doTweenY('rathitY', 'ratdie', 95, 0.3, 'quadIn')
		doTweenX('rathitX', 'ratdie', 47, 0.3, 'quadIn')
	elseif curStep == 1072 then
		objectPlayAnimation('ratdie', 'ratdie die', true)
		setProperty('ratdie.x', 61)

	elseif curStep == 1080 then
		setProperty('camGame.alpha', 0)
	elseif curStep == 1112 then
		doTweenAlpha('camGame', 'camGame', 1, 5, 'quadInOut')
		setProperty('blood.alpha', 1)
		objectPlayAnimation('blood', 'blood1', true)
	elseif curStep == 1128 then
		objectPlayAnimation('blood', 'blood2', true)
	elseif curStep == 1144 then
		objectPlayAnimation('blood', 'blood3', true)
		setProperty('dad.alpha', 1)
		setProperty('dad.x', 60)
		setProperty('dad.y', 140)

		setProperty('ratroomblood.alpha', 0)
		setProperty('roombloodopen.alpha', 0.65)
	elseif curStep == 1160 then
		objectPlayAnimation('blood', 'blood4', true)
	elseif curStep == 1176 then
		objectPlayAnimation('blood', 'blood5', true)

		setProperty('camGame.alpha', 0)
	elseif curStep == 1184 then
		setProperty('camGame.alpha', 1)
		setProperty('camHUD.alpha', 1)
		setProperty('dad.x', 100)
		setProperty('dad.y', 110)

		setProperty('boyfriend.x', 97)
		setProperty('boyfriend.y', 75)

		setProperty('ratroomblood.alpha', 0.65)
		setProperty('roombloodopen.alpha', 0)
		setObjectOrder('dad', getObjectOrder('boyfriend') + 100)
	elseif curStep == 1192 then
		objectPlayAnimation('blood', 'blood6', true)
	elseif curStep == 1208 then
		objectPlayAnimation('blood', 'blood7', true)
	elseif curStep == 1280 then
		setObjectOrder('dad', getObjectOrder('boyfriend') + 100)
		setProperty('dad.x', 100)
		setProperty('dad.y', 104)

		doTweenX('dadx', 'dad', 123, 0.75, 'linear')
	elseif curStep == 1288 then
		setObjectOrder('dad', getObjectOrder('boyfriend') - 100)
		doTweenY('dady', 'dad', 30, 1.5, 'linear')
	elseif curStep == 1296 then
		setProperty('boyfriend.x', 107)
		setProperty('boyfriend.y', 82)
	elseif curStep == 1304 then
		setProperty('dad.x', 123)
		setProperty('dad.y', 36)
	elseif curStep == 1424 then
		setProperty('boyfriend.x', 105)
		setProperty('boyfriend.y', 80)
		doTweenX('bfx', 'boyfriend', 115, 0.4, 'quadIn')
		doTweenY('bfy', 'boyfriend', 60, 0.4, 'quadIn')
	elseif curStep == 1428 then
		setProperty('dad.alpha', 0)
		setProperty('boyfriend.x', 112)
		setProperty('boyfriend.y', 28)
	elseif curStep == 1432 then
		setProperty('camGame.alpha', 0)
	elseif curStep == 1442 then
		setProperty('camGame.alpha', 1)
	elseif curStep == 1564 then
		setProperty('camGame.alpha', 0)
	elseif curStep == 1568 then
		setProperty('boyfriend.x', 126)
		setProperty('boyfriend.y', 39)
		setProperty('camGame.alpha', 1)
		setProperty('dead.alpha', 1)
	elseif curStep == 1704 then
		doTweenAlpha('camGamealpha', 'camGame', 0, 5, 'linear')
		doTweenAlpha('camHUDalpha', 'camHUD', 0, 5, 'linear')
	elseif curStep == 1840 then
		makeLuaSprite('whatswrongbitch', 'characters/whatswrong', -200, -100)
		setObjectCamera('whatswrongbitch', 'other')
		scaleObject('whatswrongbitch', 2.5, 2.5)
		setProperty('whatswrongbitch.alpha', 0)
		addLuaSprite('whatswrongbitch', true)
	elseif curStep == 1844 then
		doTweenAlpha('whatswrongbitchalpha', 'whatswrongbitch', 1, 4, 'quadIn')
	end
end