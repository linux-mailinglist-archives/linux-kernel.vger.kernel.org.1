Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54EB0282E08
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 00:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgJDWOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 18:14:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:58990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726398AbgJDWON (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 18:14:13 -0400
Received: from tzanussi-mobl.hsd1.il.comcast.net (c-73-209-127-30.hsd1.il.comcast.net [73.209.127.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC7ED20678;
        Sun,  4 Oct 2020 22:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601849652;
        bh=fn0TXkwTfk0tA3F5BzhjXREJ/O2EuhLASY4Hb10HAIY=;
        h=From:To:Cc:Subject:Date:From;
        b=HqNGwPkGr/6X/4k5wu8ucb6bV0M8tQpKxWjmMoM49sXdIy2uGasrvwhk+6pETamVW
         UVsNHZnSI3GdR2vUbzwzAi3lDGZWn39Ao6UxCBiMfBDZRZ0+zPMvvjSfCjTqYA69Iu
         9f5ybjuUncxgNZdDtvhUQmLxF5e4/mxhp4tO4y0g=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org, axelrasmussen@google.com
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/7] tracing: Add dynamic strings for synthetic events
Date:   Sun,  4 Oct 2020 17:14:02 -0500
Message-Id: <cover.1601848695.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is v4 of the dynamic string support for synthetic events.

This version adds several patches addressing previous comments - a new
testcase for the dynamic synth event strings along with a patch adding
a blurb about the synthetic_events file, which should have been there
in any case, Steve's patch for preventing string printing overruns
(tracing: Change synthetic event string format to limit printed
length).

There's also a new patch (tracing: Save normal string variables) that
fixes a bug I found when adding the test case.  The problem it fixes
is only apparent when using the dynamic strings, although it could
also happen with static strings.  I wasn't able to produce the problem
with static strings, in any case.

Other changes include adding the BUILD_BUG_ON() to the (tracing:
Change STR_VAR_MAX_LEN) patch, and folding in Steve's
__set_synth_event_print_fmt() adding __get_str() calls for trace-cmd.

Thanks,

Tom


Previous versions text:

Hi,

This is v3 of the dynamic string support for synthetic events.

No code changes since v2, just added Fixes: tag for 'tracing: Fix
parse_synth_field() error handling' as suggested by Masami along with
his Reviewed-by, and Axel's Tested-bys.

Thanks,

Tom


Hi,

This is v2 of the dynamic string support for synthetic events.

v1 was missing some very important code in the in-kernel API functions
that should have reserved room for dynamic strings.  This adds it
along also some additional test code in the synth_event_gen_test
module that tests the dynamic strings for those APIs.

I also added Axel's changelog text to the 'tracing: Fix
parse_synth_field() error handling' patch and used ssize_t as he also
suggested.  Thanks, Axel!  I also noticed that the original patch
didn't use <= as it should have, so changed that as well.

Neither my command-line tests or the synth_event_gen_test module are
showing any problems at this point for me...

Tom

Original v1 text:

This patchset adds support for dynamic strings for synthetic events,
as requested by Axel Rasmussen.

Actually, the first two patches should be applied in any case - the
first just changes the current max string length and the second fixes
a bug I found while testing.

It works fine for my simple test cases, but I still need to do a lot
more testing, especially of the in-kernel API parts, which don't
affect Axel's use case.

Anyway, Axel, please try it out and send me your Tested-by: if it
works for you, and your broken testcase(s) if it doesn't. ;-)

Thanks,

Tom

The following changes since commit fdb46faeab2f3fa2b43a55059b33b8f98b2e1442:

  x86: Use tracepoint_enabled() for msr tracepoints instead of open coding it (2020-09-28 10:36:02 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git ftrace/synth-dynstring-v4

Steven Rostedt (1):
  tracing: Change synthetic event string format to limit printed length

Tom Zanussi (6):
  tracing: Change STR_VAR_MAX_LEN
  tracing: Fix parse_synth_field() error handling
  tracing: Save normal string variables
  tracing: Add support for dynamic strings to synthetic events
  tracing: Add README information for synthetic_events file
  selftests/ftrace: Add test case for synthetic event dynamic strings

 Documentation/trace/events.rst                |  15 +-
 Documentation/trace/histogram.rst             |  18 ++
 kernel/trace/synth_event_gen_test.c           |  18 +-
 kernel/trace/trace.c                          |   7 +-
 kernel/trace/trace_events_hist.c              |  45 ++-
 kernel/trace/trace_events_synth.c             | 256 +++++++++++++++---
 kernel/trace/trace_synth.h                    |   6 +-
 .../trigger-synthetic-event-dynstring.tc      |  31 +++
 8 files changed, 350 insertions(+), 46 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-dynstring.tc

-- 
2.17.1

