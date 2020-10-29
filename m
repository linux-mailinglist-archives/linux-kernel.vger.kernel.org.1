Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D545829ECE9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 14:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgJ2N3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 09:29:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:50710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725771AbgJ2N3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 09:29:23 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C63B52075E;
        Thu, 29 Oct 2020 13:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603978162;
        bh=qMuVUojoVJpV6GTyDuqU9TcYHFPWdln58YSqRnl+T6c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dwyRZiaOkYJj8mN0/UvOMedu85YIRIBwCnwx+Hdg/xIj/qwrpMC1ZcySOVPETrTNe
         bEV5XIESmKrg5UXJNcSde4ejQu4mtioX7SdZmZknSlMscQp9O7pqSRDvVkhiX3gzLP
         f4CyL2AF5AqTDGLE2n627AVeKHPANgtCSMkj4BSk=
Date:   Thu, 29 Oct 2020 22:29:18 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>
Subject: Re: [RFC][PATCH 0/3 v3] ftrace: Add access to function arguments
 for all callbacks
Message-Id: <20201029222918.7d0625ec4ca47e6f1d64c75b@kernel.org>
In-Reply-To: <20201029000816.272878754@goodmis.org>
References: <20201029000816.272878754@goodmis.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Oct 2020 20:08:16 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> This is something I wanted to implement a long time ago, but held off until
> there was a good reason to do so. Now it appears that having access to the
> arguments of the function by default is very useful. As a bonus, because
> arguments must be saved regardless before calling a callback, because they
> need to be restored before returning back to the start of the traced
> function, there's not much work to do to have them always be there for
> normal function callbacks.
> 
> The basic idea is that if CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS is set, then
> all callbacks registered to ftrace can use the regs parameter for the stack
> and arguments (kernel_stack_pointer(regs), regs_get_kernel_argument(regs, n)),
> without the need to set REGS that causes overhead by saving all registers as
> REGS simulates a breakpoint.
> 
> This could be extended to move the REGS portion to kprobes itself, and
> remove the SAVE_REGS flag completely, but for now, kprobes still uses the
> full SAVE_REGS support.

Yeah, I would like to keep using the SAVE_REGS support until SAVE_ARGS
implemented on all arch. But in parallel, I will prepare generic
kprobe-on-ftrace handler.

> The last patch extends the WITH_ARGS to allow default function tracing to
> modify the instruction pointer, where livepatching for x86 no longer needs
> to save all registers.
> 
> The idea of this approach is to give enough information to a callback that
> it could retrieve all arguments, which includes the stack pointer and
> instruction pointer.
> 
> This can also be extended to modify the function graph tracer to use the
> function tracer instead of having a separate trampoline.

Anyway, this series (3 patches) looks good to me.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!

> 
> Changes since v2:
> 
>  - Change all callback args to use struct ftrace_regs, and if something
>    requires the full regs, it must use the ftrace_get_regs() helper macro,
>    which will return NULL if the regs isn't full (FL_SAVE_REGS set).
>    This addresses a concern by both Peter Zijlsta and Thomas Gleixner that
>    a partially filled pt_regs may be used inappropriately.
> 
>  - No test patch in this version.
> 
>  - Use case using livepatching is added. This passes the test_livepatch.sh
>    selftest.
> 
> Steven Rostedt (VMware) (3):
>       ftrace: Have the callbacks receive a struct ftrace_regs instead of pt_regs
>       ftrace/x86: Allow for arguments to be passed in to ftrace_regs by default
>       livepatching: Use the default ftrace_ops instead of REGS when ARGS is available
> 
> ----
>  arch/powerpc/include/asm/livepatch.h |  4 +++-
>  arch/s390/include/asm/livepatch.h    |  5 ++++-
>  arch/x86/Kconfig                     |  1 +
>  arch/x86/include/asm/ftrace.h        | 18 ++++++++++++++++++
>  arch/x86/include/asm/livepatch.h     |  4 ++--
>  arch/x86/kernel/ftrace_64.S          | 15 +++++++++++++--
>  arch/x86/kernel/kprobes/ftrace.c     |  3 ++-
>  include/linux/ftrace.h               | 28 ++++++++++++++++++++++++++--
>  include/linux/kprobes.h              |  2 +-
>  kernel/livepatch/patch.c             | 10 ++++++----
>  kernel/trace/Kconfig                 |  9 +++++++++
>  kernel/trace/ftrace.c                | 27 +++++++++++++++------------
>  kernel/trace/trace_event_perf.c      |  2 +-
>  kernel/trace/trace_functions.c       |  9 ++++-----
>  kernel/trace/trace_irqsoff.c         |  2 +-
>  kernel/trace/trace_sched_wakeup.c    |  2 +-
>  kernel/trace/trace_selftest.c        | 20 +++++++++++---------
>  kernel/trace/trace_stack.c           |  2 +-
>  18 files changed, 119 insertions(+), 44 deletions(-)


-- 
Masami Hiramatsu <mhiramat@kernel.org>
