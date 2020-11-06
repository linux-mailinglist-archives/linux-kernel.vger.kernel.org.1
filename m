Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0402A8D06
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 03:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbgKFCft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 21:35:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:40690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbgKFCfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 21:35:48 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D31552075A;
        Fri,  6 Nov 2020 02:35:47 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1karbO-007WIX-4X; Thu, 05 Nov 2020 21:35:46 -0500
Message-ID: <20201106023235.367190737@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 05 Nov 2020 21:32:35 -0500
From:   Steven Rostedt (VMware) <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Subject: [PATCH 00/11 v3] ftrace: Have callbacks handle their own recursion
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

Changes since v2:

 - Move get_kprobe() into preempt disabled sections for various archs
 - Use trace_recursion flags in current for protecting recursion of recursion recording
 - Make the recursion logic a little cleaner
 - Export GPL the recursion recording

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
 Documentation/trace/ftrace-uses.rst   |  84 ++++++++----
 arch/csky/kernel/probes/ftrace.c      |  12 +-
 arch/parisc/kernel/ftrace.c           |  16 ++-
 arch/powerpc/kernel/kprobes-ftrace.c  |  11 +-
 arch/s390/kernel/ftrace.c             |  16 ++-
 arch/x86/kernel/kprobes/ftrace.c      |  12 +-
 fs/pstore/ftrace.c                    |   6 +
 include/linux/ftrace.h                |  13 +-
 include/linux/trace_recursion.h       | 240 ++++++++++++++++++++++++++++++++++
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
 kernel/trace/trace_recursion_record.c | 236 +++++++++++++++++++++++++++++++++
 kernel/trace/trace_selftest.c         |   7 +-
 kernel/trace/trace_stack.c            |   1 -
 23 files changed, 673 insertions(+), 251 deletions(-)
 create mode 100644 include/linux/trace_recursion.h
 create mode 100644 kernel/trace/trace_recursion_record.c
