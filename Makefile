SWIFT_RUN=xcrun --sdk macosx swift run --package-path CLI -c release
swift-format:
	$(SWIFT_RUN) swift-format -r ./Sources ./Tests -i
swift-format-lint:
	$(SWIFT_RUN) swift-format -r ./Sources ./Tests -m lint
swiftlint:
	$(SWIFT_RUN) swiftlint ./Sources ./Tests
xcodegen:
	$(SWIFT_RUN) xcodegen
