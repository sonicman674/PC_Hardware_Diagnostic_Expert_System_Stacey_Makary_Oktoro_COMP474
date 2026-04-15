;;; PC HARDWARE DIAGNOSTIC EXPERT SYSTEM - DRIVER / TEST SCRIPT

;;; Load order: facts.txt, rules.txt, then this driver.
;;; Then run: (reset) and (run-diagnosis)

(deffunction normalize-cf (?value)
  (if (or (< ?value 0.0) (> ?value 1.0)) then
      1.0
   else
      ?value))

(deffunction assert-optional-reading (?name ?value)
  (if (>= ?value 0) then
      (assert (sensor-reading (name ?name) (value ?value)))
      (printout t "  Added reading: " ?name " = " ?value crlf)
   else
      (printout t "  Skipped reading: " ?name crlf)))

(deffunction run-diagnosis ()
  "Interactive menu: user selects symptoms, assigns certainty factors, and enters fuzzy readings."
  (printout t crlf "========================================" crlf)
  (printout t "  PC HARDWARE DIAGNOSTIC EXPERT SYSTEM" crlf)
  (printout t "========================================" crlf)
  (printout t crlf "Step 1 - Select observed symptoms." crlf)
  (printout t "After each symptom, enter a certainty factor from 0.0 to 1.0." crlf)
  (printout t "Enter 0 when you are done selecting symptoms." crlf crlf)
  (printout t "  POWER & MOTHERBOARD:" crlf)
  (printout t "    1.  No power at all" crlf)
  (printout t "    2.  Shutdown under load" crlf)
  (printout t "    3.  POST beep codes" crlf)
  (printout t "    4.  Intermittent power" crlf)
  (printout t "    5.  Time/date resets" crlf)
  (printout t "    6.  System freezes under load" crlf)
  (printout t "  DISPLAY & GRAPHICS:" crlf)
  (printout t "    7.  No display output" crlf)
  (printout t "    8.  Screen artifacts" crlf)
  (printout t "    9.  Monitor not detected" crlf)
  (printout t "   10.  Driver crash/recovery" crlf)
  (printout t "  MEMORY & STORAGE:" crlf)
  (printout t "   11.  RAM not in BIOS" crlf)
  (printout t "   12.  Blue screen crashes" crlf)
  (printout t "   13.  Storage not detected" crlf)
  (printout t "   14.  Boot device not found" crlf)
  (printout t "   15.  Slow storage access" crlf)
  (printout t crlf "Enter symptom number or 0 to continue: ")
  (bind ?symptoms
    (create$ no-power-at-all shutdown-under-load post-beep-codes intermittent-power
             time-date-reset system-freezes-under-load no-display-output screen-artifacts
             monitor-not-detected driver-crash-recovery ram-not-in-bios blue-screen-crashes
             storage-not-detected boot-device-not-found slow-storage-access))
  (bind ?choice (read))
  (while (neq ?choice 0)
    (if (and (>= ?choice 1) (<= ?choice 15)) then
      (bind ?sid (nth$ ?choice ?symptoms))
      (printout t "Certainty factor for " ?sid " (0.0 to 1.0): ")
      (bind ?cf (normalize-cf (read)))
      (assert (reported-symptom (symptom-id ?sid) (observed yes) (user-cf ?cf)))
      (printout t "  Added symptom: " ?sid " with certainty " ?cf crlf)
     else
      (printout t "  Invalid menu choice ignored." crlf))
    (printout t "Next symptom number (or 0 to continue): ")
    (bind ?choice (read)))

  (printout t crlf "Step 2 - Enter optional quantitative readings for fuzzy reasoning." crlf)
  (printout t "Use -1 if you want to skip a reading." crlf crlf)

  (printout t "CPU temperature in degrees Celsius: ")
  (assert-optional-reading cpu-temperature (read))

  (printout t "GPU temperature in degrees Celsius: ")
  (assert-optional-reading gpu-temperature (read))

  (printout t "Voltage stability score (0 to 100, higher is better): ")
  (assert-optional-reading voltage-stability (read))

  (printout t "Storage health score (0 to 100, higher is better): ")
  (assert-optional-reading storage-health (read))

  (printout t "Boot time in seconds: ")
  (assert-optional-reading boot-time (read))

  (printout t crlf "Running diagnosis..." crlf crlf)
  (run)
  (printout t crlf))
