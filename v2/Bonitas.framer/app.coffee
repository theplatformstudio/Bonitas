# Import file "PHR_Desktop_Layout_1_4"
sketch = Framer.Importer.load("imported/PHR_Desktop_Layout_1_4@1x")

messages = sketch.$5_0_Messages
messages.centerX()
home = sketch.$1_0_Home_
home.centerX()
health = sketch.$2_0_Health_Allergies
health.centerX()
wellness = sketch.$3_0_Wellness_Finger_Prick
wellness.centerX()

HideViews = (views) ->
	for view in views
		view.visible = false

ShowViews = (views) ->
	for view in views
		view.visible = false

# Configure scrollview
scrollView = new ScrollComponent
	width: Screen.width
	height: Screen.height
	mouseWheelEnabled: true
home.parent = scrollView.content
scrollView.scrollHorizontal = false
scrollSpeed = 0.45
scrollView.speedY = scrollSpeed
scrollView.mouseWheelSpeedMultiplier = scrollSpeed

ToggleMessageView = (isOn) ->
	if (isOn == true)
		sketch.Inbox_SELECTED.visible = true
		sketch.Inbox.visible = false
		sketch.MessageBadge.visible = false
		viewsToHide = 
			[sketch.Home_SELECTED, 
			sketch.Health_SELECTED, 
			sketch.Wellness_SELECTED,
			home, health, wellness]
		HideViews(viewsToHide)
		messages.visible = true
		messages.parent = scrollView.content
	else
		sketch.Inbox_SELECTED.visible = false
		sketch.Inbox.visible = true

# Messages
sketch.Inbox_SELECTED.visible = false
sketch.Inbox.on Events.Click, ->
	toggle = !sketch.Inbox_SELECTED.visible
	ToggleMessageView(toggle)

# Configure banner
offsetX = sketch.Banner.parent.x + sketch.Banner.x
offsetY = sketch.Banner.parent.y + sketch.Banner.y
sketch.Banner.parent = 0
sketch.Banner.x = offsetX

sketch.FullProfile.on Events.Click, ->
	sketch.EmergencyContacts.visible = false
	sketch.FullProfile_Info.visible = true
	sketch.EmergencyNumber.visible = true

sketch.EmergencyContacts.visible = false
sketch.EmergencyNumber.on Events.Click, ->
	sketch.EmergencyContacts.visible = true
	sketch.FullProfile_Info.visible = false
	this.visible = false

HoverCardOver = (card, bg) ->
	card.visible = false
	bg.on Events.MouseOver, ->
		card.x = 0
		card.y = 0
		bg.addChild(card)
		card.visible = true
	bg.on Events.MouseOut, ->
		card.visible = false
# Overview 
HoverCardOver(sketch.hoverCard, sketch.OverviewRect)
HoverCardOver(sketch.hoverCard, sketch.OverviewRect)
HoverCardOver(sketch.hoverCard, sketch.ConsultationsRect)
HoverCardOver(sketch.hoverCard, sketch.PromotionRect)

# WellnessAtAGlance
HoverCardOver(sketch.WellnessAtAGlanceCard, sketch.BloodPressureRect)
HoverCardOver(sketch.WellnessAtAGlanceCard, sketch.CholesterolRect)
HoverCardOver(sketch.WellnessAtAGlanceCard, sketch.BloodSugarRect)
HoverCardOver(sketch.WellnessAtAGlanceCard, sketch.BodyWeightRect)

sketch.AddDeviceCircle.visible = false;
sketch.AddDeviceCircleEmpty1.on Events.MouseOver, ->
	sketch.AddDeviceCircle.x = sketch.AddDeviceCircleEmpty1.x
	sketch.AddDeviceCircle.y = sketch.AddDeviceCircleEmpty1.y
	sketch.AddDeviceCircle.visible = true
sketch.AddDeviceCircleEmpty1.on Events.MouseOut, ->
	sketch.AddDeviceCircle.visible = false

sketch.AddDeviceCircleEmpty2.on Events.MouseOver, ->
	sketch.AddDeviceCircle.x = sketch.AddDeviceCircleEmpty2.x
	sketch.AddDeviceCircle.y = sketch.AddDeviceCircleEmpty2.y
	sketch.AddDeviceCircle.visible = true
sketch.AddDeviceCircleEmpty2.on Events.MouseOut, ->
	sketch.AddDeviceCircle.visible = false

sketch.Home_SELECTED.visible = true
sketch.Health_SELECTED.visible = false
sketch.Wellness_SELECTED.visible = false

homeClicked = true
healthClicked = false
wellnessClicked = false

# Banner - click
sketch.Home.on Events.Click, ->
	ToggleMessageView(false)
	scrollView.scrollY = 0
	sketch.Home_SELECTED.visible = true
	sketch.Health_SELECTED.visible = false
	sketch.Wellness_SELECTED.visible = false	
	homeClicked = true
	healthClicked = false
	wellnessClicked = false
	home.visible = true
	HideViews([health, wellness, messages])
	home.parent = scrollView.content

sketch.Health.on Events.Click, ->
	ToggleMessageView(false)
	scrollView.scrollY = 0
	sketch.Home_SELECTED.visible = false
	sketch.Health_SELECTED.visible = true
	sketch.Wellness_SELECTED.visible = false
	homeClicked = false
	healthClicked = true	
	wellnessClicked = false
	health.visible = true
	HideViews([home, wellness, messages])
	health.parent = scrollView.content

sketch.Wellness.on Events.Click, ->
	ToggleMessageView(false)
	scrollView.scrollY = 0
	sketch.Home_SELECTED.visible = false
	sketch.Health_SELECTED.visible = false
	sketch.Wellness_SELECTED.visible = true
	homeClicked = false
	healthClicked = false
	wellnessClicked = true
	wellness.visible = true
	HideViews([home, health, messages])
	wellness.parent = scrollView.content

# Banner - Mouse over
sketch.Home.on Events.MouseOver, ->
	if !homeClicked
		sketch.Home_SELECTED.visible = true
sketch.Health.on Events.MouseOver, ->
	if !healthClicked 
		sketch.Health_SELECTED.visible = true
sketch.Wellness.on Events.MouseOver, ->
	if !wellnessClicked
		sketch.Wellness_SELECTED.visible = true

# Banner - Mouse out
sketch.Home.on Events.MouseOut, ->
	if !homeClicked
		sketch.Home_SELECTED.visible = false
	else
		sketch.Home_SELECTED.visible = true
sketch.Health.on Events.MouseOut, ->
	if !healthClicked
		sketch.Health_SELECTED.visible = false
	else
		sketch.Health_SELECTED.visible = true
sketch.Wellness.on Events.MouseOut, -> 	if !wellnessClicked
		sketch.Wellness_SELECTED.visible = false
	else
		sketch.Wellness_SELECTED.visible = true

# Add goal
sketch.AddGoal_SELECTED.visible = false
sketch.AddGoal.on Events.MouseOver, ->
	sketch.AddGoal_SELECTED.visible = true
sketch.AddGoal.on Events.MouseOut, ->
	sketch.AddGoal_SELECTED.visible = false

# View goal
sketch.ViewAllGoals_SELECTED.visible = false
sketch.ViewAllGoals.on Events.MouseOver, ->
	sketch.ViewAllGoals_SELECTED.visible = true
sketch.ViewAllGoals.on Events.MouseOut, ->
	sketch.ViewAllGoals_SELECTED.visible = false

MoveLayerToNewLayer = (destinationLayer, layerToMove) ->
	layerToMove.x = 0
	layerToMove.y = 0
	destinationLayer.addChild(layerToMove)

sketch.ConsultationsPage.visible = false
# Health sidebar
sketch.AllergiesSideRect.on Events.Click, ->
	MoveLayerToNewLayer(sketch.AllergiesSideRect, sketch.ActiveTabHealth)
	sketch.ConsultationsPage.visible = false
	sketch.AllergiesPage.visible = true
sketch.ConsultationSideRect.on Events.Click, ->
	MoveLayerToNewLayer(sketch.ConsultationSideRect, sketch.ActiveTabHealth)
	sketch.ConsultationsPage.visible = true
	sketch.AllergiesPage.visible = false	
sketch.ChroniceConditionSideRect.on Events.Click, ->
	MoveLayerToNewLayer(sketch.ChroniceConditionSideRect, sketch.ActiveTabHealth)
sketch.ChronicMedicationsSideRect.on Events.Click, ->
	MoveLayerToNewLayer(sketch.ChronicMedicationsSideRect, sketch.ActiveTabHealth)
sketch.HospitalisationsSideRect.on Events.Click, ->
	MoveLayerToNewLayer(sketch.HospitalisationsSideRect, sketch.ActiveTabHealth)
sketch.ImmunisationsSideRect.on Events.Click, ->
	MoveLayerToNewLayer(sketch.ImmunisationsSideRect, sketch.ActiveTabHealth)
sketch.PathologyResultSideRect.on Events.Click, ->
	MoveLayerToNewLayer(sketch.PathologyResultSideRect, sketch.ActiveTabHealth)	

sketch.ActivitySideRect.on Events.Click, ->
	MoveLayerToNewLayer(sketch.ActivitySideRect, sketch.ActiveTabWellness)
sketch.VitalMeasurementsSideRect.on Events.Click, ->
	MoveLayerToNewLayer(sketch.VitalMeasurementsSideRect, sketch.ActiveTabWellness)
sketch.FingerPrickMeasurementsSideRect.on Events.Click, ->
	MoveLayerToNewLayer(sketch.FingerPrickMeasurementsSideRect, sketch.ActiveTabWellness)
sketch.BodyMeasurementsSideRect.on Events.Click, ->
	MoveLayerToNewLayer(sketch.BodyMeasurementsSideRect, sketch.ActiveTabWellness)
sketch.RiskAssessmentsSideRect.on Events.Click, ->
	MoveLayerToNewLayer(sketch.RiskAssessmentsSideRect, sketch.ActiveTabWellness)
sketch.ReportsSideRect.on Events.Click, ->
	MoveLayerToNewLayer(sketch.ReportsSideRect, sketch.ActiveTabWellness)
sketch.DevicesSideRect.on Events.Click, ->
	MoveLayerToNewLayer(sketch.DevicesSideRect, sketch.ActiveTabWellness)