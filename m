Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACE682E0228
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 22:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgLUVpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 16:45:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:58388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725833AbgLUVpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 16:45:15 -0500
Received: from localhost.localdomain (c-73-209-127-30.hsd1.il.comcast.net [73.209.127.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23D9B20DD4;
        Mon, 21 Dec 2020 21:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608587074;
        bh=eN6xnp+iyODNfFWc9c6H0530nE9D9RqLFp+IuYT3BJA=;
        h=From:To:Cc:Subject:Date:From;
        b=eM5eSUroi5pyvV8Odj7gGzNmMByhYiis/rQNIp5sqGdT0mt/zPTw8RHQsAx9yG1DD
         JeO+bMoQYLCzuvFnEm1m7QL/cOk4ChUfy0LDrUms5TY4m3sl68pz2dRow1FRyc6qYI
         YqlRZs3kSpp76t05XRhw0VMi/pAnbRbM1WKPQ7z5kJdAKORGpSYEDxjUR0rPT4xnbF
         lfwroF44NqCyRiESqjMQQbi8mmU3WcsMYU0JePr4KPNNqrC122T49dA1+tB2aZtstd
         oor4bxNauoNXt3VDo94cB3KGmcpLdNdwkJXvMuSqRueOdah6b8kj6RcLx3Cskdmv+B
         g3zuHI1lS62rQ==
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org, axelrasmussen@google.com
Cc:     mhiramat@kernel.org, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/5] tracing: More synthetic event error fixes
Date:   Mon, 21 Dec 2020 15:44:26 -0600
Message-Id: <cover.1608586464.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is v5 of the sythetic event error fix patchset.  This version is
the same as v4 but with a few variable-initialization fixes flagged by
Dan Carpenter and the kernel test robot.

Tom

v4 text:

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

  git://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git ftrace/synth-fixes-v5

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
 kernel/trace/trace_events_synth.c             | 501 +++++++++++++++---
 kernel/trace/trace_kprobe.c                   |  33 +-
 kernel/trace/trace_probe.c                    |  17 +
 kernel/trace/trace_probe.h                    |   1 +
 kernel/trace/trace_uprobe.c                   |  17 +-
 .../trigger-synthetic_event_syntax_errors.tc  |  35 +-
 10 files changed, 519 insertions(+), 150 deletions(-)

-- 
2.17.1

