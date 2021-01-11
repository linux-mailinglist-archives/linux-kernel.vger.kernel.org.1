Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D099E2F247D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 02:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391487AbhALAYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 19:24:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:60282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403775AbhAKXFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 18:05:19 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5712522D05;
        Mon, 11 Jan 2021 23:04:38 +0000 (UTC)
Date:   Mon, 11 Jan 2021 18:04:36 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH] tracing: Merge irqflags + preemt counter, add RT
 bits
Message-ID: <20210111180436.475bab08@gandalf.local.home>
In-Reply-To: <20201216172205.gvpizdw4kzpn326q@linutronix.de>
References: <20201216172205.gvpizdw4kzpn326q@linutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Dec 2020 18:22:05 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> PREEMPT_RT never reported "serving softirq". I took a look to see if it
> could be changed. The tracing infrastructure examinates the preemtion
                                                           "preemption"

> counter for that. PREEMPT_RT does not change the preemption counter
> while disabling the bottom half or serving the softirqs in order to
> remain preemptible. The in_serving_softirq() macro and the SOFTIRQ_OFFSET
> define are still working but not on the preempt-counter.
> I started to look how to integrate the RT bits regarding softirq.
> 
> The state of the interrupts (irqflags) and the preemption counter are
> passed down to tracing_generic_entry_update(). However only one bit of
> irqflags is actually required: The on/off state.
> The irqflags and the preemption counter could be evaluated early and the
> information stored in an integer `trace_ctx'.
> tracing_generic_entry_update() would use the upper bits as the
> TRACE_FLAG_* and the lower 16bit as the preemption counter (considering
> that 1 must be substracted from the counter in some cases).
> 
> Whith this change the preemption counter is read in one place and the
  "With"

> relevant RT bits for softirq can be set there.
> 
> The actual preemption value is not used except for the tracing record.
> The `irqflags' is also not used except for the _irqsave() locking in a
> few spots.

Which spots?

> As part of the patch I added __ to trace_event_buffer_commit() while
> evaluating trace_event_buffer() for the struct trace_event_buffer usage
> regarding the `pc' and `flags' members. It appears that those two can
> also be merged into the `trace_ctx' integer.

Looks like you did change the trace_event_buffer. I don't understand why
the "__" was added?


> With this change the callchain passes one argument less and evaluates
> the flags early. A build with all tracers enabled on x86-64 with and
> without the patch:
> 
>     text     data      bss      dec      hex    filename
> 24301717 22148594 13996284 60446595  39a5783 vmlinux.old
> 24301248 22148850 13996284 60446382  39a56ae vmlinux.new
> 
> data increased by 256 bytes, text shrank by 469 bytes.
> 

> -void
> -tracing_generic_entry_update(struct trace_entry *entry, unsigned short type,
> -			     unsigned long flags, int pc)
> +static unsigned int __tracing_gen_ctx_flags(unsigned long irqflags)
>  {
> -	struct task_struct *tsk = current;
> +	unsigned int trace_flags = 0;
> +	unsigned int pc;
> +
> +	pc = preempt_count();
>  
> -	entry->preempt_count		= pc & 0xff;
> -	entry->pid			= (tsk) ? tsk->pid : 0;
> -	entry->type			= type;
> -	entry->flags =
>  #ifdef CONFIG_TRACE_IRQFLAGS_SUPPORT
> -		(irqs_disabled_flags(flags) ? TRACE_FLAG_IRQS_OFF : 0) |
> +	if (irqs_disabled_flags(irqflags))
> +		trace_flags |= TRACE_FLAG_IRQS_OFF;
>  #else
> -		TRACE_FLAG_IRQS_NOSUPPORT |
> +		trace_flags |= TRACE_FLAG_IRQS_NOSUPPORT;
>  #endif
> -		((pc & NMI_MASK    ) ? TRACE_FLAG_NMI     : 0) |
> -		((pc & HARDIRQ_MASK) ? TRACE_FLAG_HARDIRQ : 0) |
> -		((pc & SOFTIRQ_OFFSET) ? TRACE_FLAG_SOFTIRQ : 0) |
> -		(tif_need_resched() ? TRACE_FLAG_NEED_RESCHED : 0) |
> -		(test_preempt_need_resched() ? TRACE_FLAG_PREEMPT_RESCHED : 0);

Note, the above was a result of playing around with seeing how the compiler
optimized the above. Have you seen how the below logic looks as assembly?
This is a very hot path.

> +
> +	if (pc & NMI_MASK)
> +		trace_flags |= TRACE_FLAG_NMI;
> +	if (pc & HARDIRQ_MASK)
> +		trace_flags |= TRACE_FLAG_HARDIRQ;
> +
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
> +		if (in_serving_softirq())
> +			trace_flags |= TRACE_FLAG_SOFTIRQ;
> +	} else {
> +		if (pc & SOFTIRQ_OFFSET)
> +			trace_flags |= TRACE_FLAG_SOFTIRQ;
> +	}
> +	if (tif_need_resched())
> +		trace_flags |= TRACE_FLAG_NEED_RESCHED;
> +	if (test_preempt_need_resched())
> +		trace_flags |= TRACE_FLAG_PREEMPT_RESCHED;
> +	return (trace_flags << 16) | (pc & 0xff);
> +}

Can you break this into two patches. One that adds the trace_ctx and merges
the flags and pc, and another patch that only updates to add the RT bits.

Thanks!

-- Steve

> +
> +unsigned int _tracing_gen_ctx_flags(unsigned long irqflags)
> +{
> +	return __tracing_gen_ctx_flags(irqflags);
> +}
> +
> +unsigned int tracing_gen_ctx_flags(void)
> +{
> +	unsigned long irqflags;
> +
>
