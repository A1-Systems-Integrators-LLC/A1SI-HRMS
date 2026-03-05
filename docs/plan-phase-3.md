# Phase 3 -- Approval Workflows

## Scope

Timesheet submission/approval lifecycle, supervisor approval/rejection, employee edit confirmation, RBAC-based exemptions, shift scheduling with push notifications.

## Issues

- #10 -- Timesheet Submission & Supervisor Approval Flow
- #11 -- Shift Scheduling & Mobile Push Notifications
- #12 -- Epic

## Key Decisions

- **State machine**: draft -> submitted -> approved/rejected -> resubmit cycle
- **Audit trail**: every approval action recorded (actor, action, timestamp, comment)
- **Exemption flag**: certain employees (owner, admin) skip approval requirement
- **Supervisor edit flow**: edits by supervisor require employee confirmation
- **Push notifications via FCM**: Firebase Cloud Messaging for Android, APNs relay via Firebase for iOS

## Dependencies

Phase 2 (time entries must exist for approval to work)
Phase 1 (push notification infrastructure from P1-F4)
