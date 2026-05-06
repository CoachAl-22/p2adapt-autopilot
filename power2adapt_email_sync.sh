#!/bin/bash
# Power2ADAPT Email → Google Sheets sync
# Runs via launchd at 6am and 6pm daily

CLAUDE="/Users/alistairtait/.npm/_npx/becf7b9e49303068/node_modules/.bin/claude"
LOG="$HOME/scripts/power2adapt_email_sync.log"
unset CLAUDECODE
export PATH="/usr/local/bin:$PATH"

echo "$(date '+%Y-%m-%d %H:%M:%S') — Starting email sync" >> "$LOG"

$CLAUDE --print --dangerously-skip-permissions --no-session-persistence -p "Sync new Power2ADAPT client lead emails to Google Sheets. 1) List emails from TWO sources: a) info@ 'Client leads' folder (limit 50), b) info@ INBOX unread emails (limit 50). Combine and deduplicate by uid. 2) Get existing rows from spreadsheet 1VaZ3-6G2dZyR5hxFIubU8Y6HTJG_fSjZjQiZ06hyP18 sheet 'Power2ADAPT Client Leads' range B2:D500. 3) For each email not already in sheet (match on sender email + date): SKIP any email that is a payment receipt, payment confirmation, automated no-reply, or system notification (e.g. from ThinkSmart, Stripe, Xero, or any no-reply/donotreply address). INCLUDE any email that appears to be a genuine client lead based on these signals -- subject or body contains keywords like: enrol, enrolment, enroll, enrollment, re-enrol, re-enrolment, sign up, join, register, registration, program, programme, coaching, training, session, trial, assessment, speed, athlete, child, son, daughter, interested, information, enquiry, enquire, inquiry, cost, price, pricing, term, timetable, availability, book, booking, start, waitlist, wait list, how do I, can you, would like, looking for, keen to -- OR the sender is a real person (not automated) writing to info@power2adapt.com. For qualifying emails fetch full email then append a row with INSERT_ROWS: A=sender name, B=sender email, C=subject + 1-sentence summary, D=date as YYYY-MM-DD HH:MM:SS, E-H blank, I=key notes from body, J-L blank. Output count of new rows added or No new leads." >> "$LOG" 2>&1

echo "$(date '+%Y-%m-%d %H:%M:%S') — Sync complete" >> "$LOG"
