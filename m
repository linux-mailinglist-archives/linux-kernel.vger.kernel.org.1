Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC8D2A9F49
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 22:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbgKFVoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 16:44:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:59138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728193AbgKFVoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 16:44:05 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5CC52087E;
        Fri,  6 Nov 2020 21:44:04 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kb9Wd-007ix5-3Q; Fri, 06 Nov 2020 16:44:03 -0500
Message-ID: <20201106214234.618790276@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 06 Nov 2020 16:42:34 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 0/3 v4] ftrace: Add access to function arguments for all callbacks
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This is something I wanted to implement a long time ago, but held off until
there was a good reason to do so. Now it appears that having access to the
arguments of the function by default is very useful. As a bonus, because
arguments must be saved regardless before calling a callback, because they
need to be restored before returning back to the start of the traced
function, there's not much work to do to have them always be there for
normal function callbacks.

The basic idea is that if CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS is set, then
all callbacks registered to ftrace can use the regs parameter for the stack
and arguments (kernel_stack_pointer(regs), regs_get_kernel_argument(regs, n)),
without the need to set REGS that causes overhead by saving all registers as
REGS simulates a breakpoint.

This could be extended to move the REGS portion to kprobes itself, and
remove the SAVE_REGS flag completely, but for now, kprobes still uses the
full SAVE_REGS support.

The last patch extends the WITH_ARGS to allow default function tracing to
modify the instruction pointer, where livepatching for x86 no longer needs
to save all registers.

The idea of this approach is to give enough information to a callback that
it could retrieve all arguments, which includes the stack pointer and
instruction pointer.

This can also be extended to modify the function graph tracer to use the
function tracer instead of having a separate trampoline.

Changes since v3:
  Have live patching depend on HAVE_DYNAMIC_FTRACE_WITH_REGS *or*
  HAVE_DYNAMIC_FTRACE_WITH_ARGS


Steven Rostedt (VMware) (3):
      ftrace: Have the callbacks receive a struct ftrace_regs instead of pt_regs
      ftrace/x86: Allow for arguments to be passed in to ftrace_regs by default
      livepatch: Use the default ftrace_ops instead of REGS when ARGS is available

----
 arch/powerpc/include/asm/livepatch.h |  4 +++-
 arch/s390/include/asm/livepatch.h    |  5 ++++-
 arch/x86/Kconfig                     |  1 +
 arch/x86/include/asm/ftrace.h        | 18 ++++++++++++++++++
 arch/x86/include/asm/livepatch.h     |  4 ++--
 arch/x86/kernel/ftrace_64.S          | 15 +++++++++++++--
 arch/x86/kernel/kprobes/ftrace.c     |  3 ++-
 include/linux/ftrace.h               | 28 ++++++++++++++++++++++++++--
 include/linux/kprobes.h              |  2 +-
 kernel/livepatch/Kconfig             |  2 +-
 kernel/livepatch/patch.c             | 10 ++++++----
 kernel/trace/Kconfig                 |  9 +++++++++
 kernel/trace/ftrace.c                | 27 +++++++++++++++------------
 kernel/trace/trace_event_perf.c      |  2 +-
 kernel/trace/trace_functions.c       |  9 ++++-----
 kernel/trace/trace_irqsoff.c         |  2 +-
 kernel/trace/trace_sched_wakeup.c    |  2 +-
 kernel/trace/trace_selftest.c        | 20 +++++++++++---------
 kernel/trace/trace_stack.c           |  2 +-
 19 files changed, 120 insertions(+), 45 deletions(-)
