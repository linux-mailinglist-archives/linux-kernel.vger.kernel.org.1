Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87CAE2DDAAB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 22:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731782AbgLQVPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 16:15:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:49766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729114AbgLQVPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 16:15:14 -0500
From:   Tom Zanussi <zanussi@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     rostedt@goodmis.org, axelrasmussen@google.com
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/5] tracing: More synthetic event error fixes
Date:   Thu, 17 Dec 2020 15:14:25 -0600
Message-Id: <cover.1608238451.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is v4 of the sythetic event error fix patchset.  As suggested by
Steve, I added a new pass that adds semicolons to 'old' commands that
may be missing them, in order to maintain backward compatibility.  All
commands are handled by the new and improved parsing code, but
commands missing the semicolons have them added before processing and
are therefore still valid.  At some point in the future, as new
features are added and we can require any command containing them to
require semicolons, this pass can be completely skipped by detecting
those features in the currently empty audit_old_buffer() hook.

Also, as a result, the patch adding semicolons to the selftests is no
longer necessary (selftests/ftrace: Add synthetic event field
separators) and has been dropped in this series.

Tom


v3 text:

Hi,

This is v3 of the sythetic event error fix patchset.  As suggested by
Masami, I split the 'tracing/dynevent: Delegate parsing to create
function' into two - one containing just the interface changes and the
second with the synthetic event parsing changes the first enabled.

I also replaced a couple argv_split() with strpbrk() as suggested by
Masami, along with removing the no-longer-used consume lines and
another line that tested ECANCELED that was no longer needed.

Also, removed a test case that was no longer needed since the commands
are now stripped of whitespace first.

Thanks, Masami, for the suggestions.

Tom

v2 text:

This is v2 of the previous sythetic event error fix patchset.

This version drops the original ([PATCH 1/4] tracing: Make
trace_*_run_command() more flexible) and (tracing: Use new
trace_run_command() options) patches and replaces them with Masami's
patch (tracing/dynevent: Delegate parsing to create function) [1].
The new version adds in all the synthetic event changes needed to
compile and use the new interface.

A new patch was also added (selftests/ftrace: Add synthetic event
field separators) that fixes more invalid synthetic event syntax I
found while testing.

I also added some more new checks to the synthetic event sytax error
testcase.

As before, I didn't see any problems running the entire ftrace
testsuite or the test modules that also use the things that were
touched here.

[1] https://lore.kernel.org/lkml/20201019001504.70dc3ec608277ed22060d2f7@kernel.org/

Thanks,

Tom


v1 text:

Hi,

This patchset addresses the synthetic event error anomalies reported
by Masami in the last patchset [1].

It turns out that most of the problems boil down to clunky separator
parsing; adding a couple new abilities to trace_run_command() and then
adapting the existing users seemed to me the best way to fix these
things, and also gets rid of some code.

Also, to make things easier for error display, I changed these to
preserve the original command string and pass it through the callback
instead of rebuilding it for error display.

I added some new error strings and removed unused ones as well, and
added a bunch of new test cases to the synthetic parser error test
case.

I didn't see any problems running the entire ftrace testsuite or the
test modules that also use the things that were touched here.

Thanks,

Tom

[1] https://lore.kernel.org/lkml/20201014110636.139df7be275d40a23b523b84@kernel.org/

The following changes since commit f6a694665f132cbf6e2222dd2f173dc35330a8aa:

  tracing: Offload eval map updates to a work queue (2020-12-15 09:29:14 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git ftrace/synth-fixes-v4

Masami Hiramatsu (1):
  tracing/dynevent: Delegate parsing to create function

Tom Zanussi (4):
  tracing: Rework synthetic event command parsing
  tracing: Update synth command errors
  tracing: Add a backward-compatibility check for synthetic event
    creation
  selftests/ftrace: Update synthetic event syntax errors

 kernel/trace/trace.c                          |  23 +-
 kernel/trace/trace.h                          |   3 +-
 kernel/trace/trace_dynevent.c                 |  35 +-
 kernel/trace/trace_dynevent.h                 |   4 +-
 kernel/trace/trace_events_synth.c             | 503 +++++++++++++++---
 kernel/trace/trace_kprobe.c                   |  33 +-
 kernel/trace/trace_probe.c                    |  17 +
 kernel/trace/trace_probe.h                    |   1 +
 kernel/trace/trace_uprobe.c                   |  17 +-
 .../trigger-synthetic_event_syntax_errors.tc  |  35 +-
 10 files changed, 521 insertions(+), 150 deletions(-)

-- 
2.17.1

