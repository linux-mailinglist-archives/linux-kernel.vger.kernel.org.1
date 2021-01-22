Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 836D7300FB5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 23:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730914AbhAVWOU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 22 Jan 2021 17:14:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:35260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730916AbhAVWId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 17:08:33 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1667023B06;
        Fri, 22 Jan 2021 22:07:52 +0000 (UTC)
Date:   Fri, 22 Jan 2021 17:07:50 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/3] tracing: Merge irqflags + preempt counter.
Message-ID: <20210122170750.600b2372@gandalf.local.home>
In-Reply-To: <20210112230057.2374308-2-bigeasy@linutronix.de>
References: <20210112230057.2374308-1-bigeasy@linutronix.de>
        <20210112230057.2374308-2-bigeasy@linutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jan 2021 00:00:55 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> The state of the interrupts (irqflags) and the preemption counter are
> both passed down to tracing_generic_entry_update(). Only one bit of
> irqflags is actually required: The on/off state. The complete 32bit
> of the preemption counter isn't needed. Just whether of the upper bits
> (softirq, hardirq and NMI) are set and the preemption depth is needed.
> 
> The irqflags and the preemption counter could be evaluated early and the
> information stored in an integer `trace_ctx'.
> tracing_generic_entry_update() would use the upper bits as the
> TRACE_FLAG_* and the lower 8bit as the disabled-preemption depth
> (considering that one must be substracted from the counter in one
> special cases).
> 
> The actual preemption value is not used except for the tracing record.
> The `irqflags' variable is mostly used only for the tracing record. An
> exception here is for instance wakeup_tracer_call() or
> probe_wakeup_sched_switch() which explicilty disable interrupts and use
> that `irqflags' to save (and restore) the IRQ state and to record the
> state.
> 
> Struct trace_event_buffer has also the `pc' and flags' members which can
> be replaced with `trace_ctx' since their actual value is not used
> outside of trace recording.
> 
> This will reduce tracing_generic_entry_update() to simply assign values
> to struct trace_entry. The evaluation of the TRACE_FLAG_* bits is moved
> to _tracing_gen_ctx_flags() which replaces preempt_count() and
> local_save_flags() invocations.
> 
> As an example, ftrace_syscall_enter() may invoke:
> - trace_buffer_lock_reserve() -> … -> tracing_generic_entry_update()
> - event_trigger_unlock_commit()
>   -> ftrace_trace_stack() -> … -> tracing_generic_entry_update()
>   -> ftrace_trace_userstack() -> … -> tracing_generic_entry_update()  
> 
> In this case the TRACE_FLAG_* bits were evaluated three times. By using
> the `trace_ctx' they are evaluated once and assigned three times.
> 
> A build with all tracers enabled on x86-64 with and without the patch:
> 
>     text     data      bss      dec      hex    filename
> 21970669 17084168  7639260 46694097  2c87ed1 vmlinux.old
> 21970293 17084168  7639260 46693721  2c87d59 vmlinux.new
> 
> text shrank by 379 bytes, data remained constant.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  include/linux/trace_events.h         |  25 +++-
>  kernel/trace/blktrace.c              |  17 +--
>  kernel/trace/trace.c                 | 208 ++++++++++++++-------------
>  kernel/trace/trace.h                 |  38 +++--
>  kernel/trace/trace_branch.c          |   6 +-
>  kernel/trace/trace_event_perf.c      |   5 +-
>  kernel/trace/trace_events.c          |  18 +--
>  kernel/trace/trace_events_inject.c   |   6 +-
>  kernel/trace/trace_functions.c       |  28 ++--
>  kernel/trace/trace_functions_graph.c |  32 ++---
>  kernel/trace/trace_hwlat.c           |   7 +-
>  kernel/trace/trace_irqsoff.c         |  86 +++++------
>  kernel/trace/trace_kprobe.c          |  10 +-
>  kernel/trace/trace_mmiotrace.c       |  14 +-
>  kernel/trace/trace_sched_wakeup.c    |  71 +++++----
>  kernel/trace/trace_syscalls.c        |  20 ++-
>  kernel/trace/trace_uprobe.c          |   4 +-
>  17 files changed, 287 insertions(+), 308 deletions(-)
> 
> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> index d321fe5ad1a14..aa9123878e126 100644
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -148,17 +148,29 @@ enum print_line_t {
>  
>  enum print_line_t trace_handle_return(struct trace_seq *s);
>  
> -void tracing_generic_entry_update(struct trace_entry *entry,
> -				  unsigned short type,
> -				  unsigned long flags,
> -				  int pc);
> +static inline void tracing_generic_entry_update(struct trace_entry *entry,
> +						unsigned short type,
> +						unsigned int trace_ctx)
> +{
> +	struct task_struct *tsk = current;
> +
> +	entry->preempt_count		= trace_ctx & 0xff;
> +	entry->pid			= (tsk) ? tsk->pid : 0;
> +	entry->type			= type;
> +	entry->flags =			trace_ctx >> 16;
> +}
> +
> +unsigned int _tracing_gen_ctx_flags(unsigned long irqflags);
> +unsigned int tracing_gen_ctx_flags(void);
> +unsigned int tracing_gen_ctx_flags_dect(void);

Since I'm now trying to avoid underscore functions when possible, the above
should be:

_tracing_gen_ctx_flags()   --> tracing_gen_ctx_flags()
tracing_gen_ctx_flags()    --> tracing_gen_ctx()
tracing_gen_ctx_flags_dect --> tracing_gen_ctx_dec()

Note, "_dec()" should be used instead of "_dect()" as "_dec" is commonly
used around the kernel, and I had really no idea what "_dect" was, until I
looked at the two functions.

And looking at the implementation, I wonder if we should make this into
static inlines in the header as follows:

unsigned int tracing_gen_ctx_irq_test(int irqs_status);

#ifdef CONFIG_TRACE_IRQFLAGS_SUPPORT
static inline unsigned int tracing_gen_ctx_flags(unsigned long irqflags)
{
	unsigned int irq_status = irqs_disabled(irqflags) ?
		TRACE_FLAG_IRQS_OFF : 0;
	return tracing_gen_ctx_irq_test(irq_status);
}
static inline unsigned int tracing_gen_ctx(void)
{
	unsigned long irqflags;

	local_save_flags(irqflags);
	return tracing_gen_ctx_flags(irqflags);
}
#else
static inline unsigned int tracing_gen_ctx_flags(unsigned long irqflags)
{
	return tracing_gen_ctx_irq_test(TRACE_FLAG_IRQS_NOSUPPORT);
}
static inline unsigned int tracing_gen_ctx(void)
{
	return tracing_gen_ctx_irq_test(TRACE_FLAG_IRQS_NOSUPPORT);
}
#endif

static inline unsigned int tracing_gen_ctx_dec(void)
{
	unsigned int trace_ctx;

	trace_ctx = tracing_gen_ctx();
	/*** Comment about buffer_reserve here ***/
	if (IS_ENABLED(CONFIG_PREEMPTION))
		trace_ctx--;
	return trace_ctx;
}

Then all you need to do is implement the tracing_gen_ctx_irq_test() without
adding and #ifdefs in it, and just or in the "irq_status" to trace_flags,
without any conditionals.

-- Steve

> +
>  struct trace_event_file;
>  
>  struct ring_buffer_event *
>  trace_event_buffer_lock_reserve(struct trace_buffer **current_buffer,
>  				struct trace_event_file *trace_file,
>  				int type, unsigned long len,
> -				unsigned long flags, int pc);
> +				unsigned int trace_ctx);
>  
>  #define TRACE_RECORD_CMDLINE	BIT(0)
>  #define TRACE_RECORD_TGID	BIT(1)
> @@ -232,8 +244,7 @@ struct trace_event_buffer {
>  	struct ring_buffer_event	*event;
>  	struct trace_event_file		*trace_file;
>  	void				*entry;
> -	unsigned long			flags;
> -	int				pc;
> +	unsigned int			trace_ctx;
>  	struct pt_regs			*regs;
>  };
>  
