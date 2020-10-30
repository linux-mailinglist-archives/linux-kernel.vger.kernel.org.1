Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E10032A1054
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 22:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgJ3VkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 17:40:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:46844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727496AbgJ3VkQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 17:40:16 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16E3C22263;
        Fri, 30 Oct 2020 21:40:15 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kYc85-00645q-4g; Fri, 30 Oct 2020 17:40:13 -0400
Message-ID: <20201030213142.096102821@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 30 Oct 2020 17:31:42 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Subject: [PATCH 00/11 v2] ftrace: Have callbacks handle their own recursion
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I found that having the ftrace infrastructure use its own trampoline to
handle recursion and RCU by defaulte unless the ftrace_ops set the
appropriate flags, was an issue that nobody set those flags. But then their
callbacks would suffer from an unnecessary overhead instead of simply
handling the recursion itself.

This series makes it mandatory that ftrace callbacks handle recursion or set
a flag asking ftrace to do it for it. It also creates helper functions to
help these callbacks to have recursion protection.

Changes since v1:

 - Reworded the paragraph that talks about the ftrace_ops default recursion
   in the change logs so that it makes more sense (recommend by Petr Mladek)

 - Rebased on fixes that will be sent upstream as soon as my testing is
   complete, that fixes the recursion logic. NMIs no longer trigger
   false recursion positives, and also logic to handle transitions
   between context that also causes false positives. These fixes are
   not part of this series, but will be added before these patches.

 - Added code to create a "recursed_functions" file in tracefs, that
   lists the functions that triggered recursion. This was how I detected
   the bugs from before. If you enable CONFIG_FTRACE_RECORD_RECURSION
   it will add this logic. If you also enable FTRACE_STARTUP_TEST,
   one of the tests triggers a recursion, and this will be shown in
   the file after boot up (to test if it actually works).

  # cat recursed_functions
  ftrace_ops_assist_func+0x84/0x160:	trace_selftest_dynamic_test_func+0x0/0x10

Steven Rostedt (VMware) (11):
      ftrace: Move the recursion testing into global headers
      ftrace: Add ftrace_test_recursion_trylock() helper function
      ftrace: Optimize testing what context current is in
      pstore/ftrace: Add recursion protection to the ftrace callback
      kprobes/ftrace: Add recursion protection to the ftrace callback
      livepatch/ftrace: Add recursion protection to the ftrace callback
      livepatch: Trigger WARNING if livepatch function fails due to recursion
      perf/ftrace: Add recursion protection to the ftrace callback
      perf/ftrace: Check for rcu_is_watching() in callback function
      ftrace: Reverse what the RECURSION flag means in the ftrace_ops
      ftrace: Add recording of functions that caused recursion

----
 Documentation/trace/ftrace-uses.rst   |  84 +++++++++---
 arch/csky/kernel/probes/ftrace.c      |  12 +-
 arch/parisc/kernel/ftrace.c           |  13 +-
 arch/powerpc/kernel/kprobes-ftrace.c  |  11 +-
 arch/s390/kernel/ftrace.c             |  13 +-
 arch/x86/kernel/kprobes/ftrace.c      |  12 +-
 fs/pstore/ftrace.c                    |   6 +
 include/linux/ftrace.h                |  13 +-
 include/linux/trace_recursion.h       | 243 ++++++++++++++++++++++++++++++++++
 kernel/livepatch/patch.c              |   5 +
 kernel/trace/Kconfig                  |  25 ++++
 kernel/trace/Makefile                 |   1 +
 kernel/trace/fgraph.c                 |   3 +-
 kernel/trace/ftrace.c                 |  24 ++--
 kernel/trace/trace.h                  | 177 -------------------------
 kernel/trace/trace_event_perf.c       |  13 +-
 kernel/trace/trace_events.c           |   1 -
 kernel/trace/trace_functions.c        |  14 +-
 kernel/trace/trace_output.c           |   6 +-
 kernel/trace/trace_output.h           |   1 +
 kernel/trace/trace_recursion_record.c | 220 ++++++++++++++++++++++++++++++
 kernel/trace/trace_selftest.c         |   7 +-
 kernel/trace/trace_stack.c            |   1 -
 23 files changed, 656 insertions(+), 249 deletions(-)
 create mode 100644 include/linux/trace_recursion.h
 create mode 100644 kernel/trace/trace_recursion_record.c
