Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8B12F2FDE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 14:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405964AbhALM7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 07:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405751AbhALM7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 07:59:07 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8FBC061795
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 04:58:26 -0800 (PST)
Date:   Tue, 12 Jan 2021 13:58:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610456304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VrkRg6OJzto/BZQ96RH2YXsxq/t8Namm3ZrsEbabhiw=;
        b=x8/kYgYsMP/WeSGE10AyHDgxQj2SU6H9B9+t75Iu6DlPJNC9OybHrwUZxbV6dJ4B8gNHH8
        z1FdoQ2pHPFTpRsRH7CPF7gpiAPf+DbbnVcA9OmLjDPy+XVHe4unKr9zaw3SFBj58ncl2U
        wHpuZ6R0aTkD5vZW3MjLF54dcvfp0qMjYV1A1hQmGkr7EZf22WIuRXwu53S8MaEFQl6TwG
        dh0GF3oQbgFU8UxekJB7co2AMlvDyms40JpLRZHEnFHxbO+EpD2a4YIGsokdvokyS+ZcaE
        wUiPKuL/S67xHsHOt+iENAdZHvmTQVhloKCIulT6zQ81yJZlx6n3mIzsHwcjqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610456304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VrkRg6OJzto/BZQ96RH2YXsxq/t8Namm3ZrsEbabhiw=;
        b=hrMVKQ6erlyJt+NiXI4ptodMJD4P9L4FFnlplS/8NkrrcTJuQFHGVwUA6O6UiigqWbVfma
        XgADLk+U8iy+aBAw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH] tracing: Merge irqflags + preemt counter, add RT bits
Message-ID: <20210112125823.gyrqof6frjtgccgm@linutronix.de>
References: <20201216172205.gvpizdw4kzpn326q@linutronix.de>
 <20210111180436.475bab08@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210111180436.475bab08@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-11 18:04:36 [-0500], Steven Rostedt wrote:
> > The actual preemption value is not used except for the tracing record.
> > The `irqflags' is also not used except for the _irqsave() locking in a
> > few spots.
> 
> Which spots?

Hmm. So I had memory of code sequences like
	spin_lock_irqsave(, flags);
	trace_buffer_lock_reserve(,, flags);

but I can't find them anymore. The only users of
_tracing_gen_ctx_flags() pass `0' as irqflags so I kept that instead
reading the actual irqfalgs.

> > As part of the patch I added __ to trace_event_buffer_commit() while
> > evaluating trace_event_buffer() for the struct trace_event_buffer usage
> > regarding the `pc' and `flags' members. It appears that those two can
> > also be merged into the `trace_ctx' integer.
> 
> Looks like you did change the trace_event_buffer. I don't understand why
> the "__" was added?

I added __ to trace_event_buffer_commit__() to ensure that I covered
every user and have not overseen one (which would result in a compile
error). This can can be reverted in the final submission.

> > -void
> > -tracing_generic_entry_update(struct trace_entry *entry, unsigned short type,
> > -			     unsigned long flags, int pc)
> > +static unsigned int __tracing_gen_ctx_flags(unsigned long irqflags)
> >  {
> > -	struct task_struct *tsk = current;
> > +	unsigned int trace_flags = 0;
> > +	unsigned int pc;
> > +
> > +	pc = preempt_count();
> >  
> > -	entry->preempt_count		= pc & 0xff;
> > -	entry->pid			= (tsk) ? tsk->pid : 0;
> > -	entry->type			= type;
> > -	entry->flags =
> >  #ifdef CONFIG_TRACE_IRQFLAGS_SUPPORT
> > -		(irqs_disabled_flags(flags) ? TRACE_FLAG_IRQS_OFF : 0) |
> > +	if (irqs_disabled_flags(irqflags))
> > +		trace_flags |= TRACE_FLAG_IRQS_OFF;
> >  #else
> > -		TRACE_FLAG_IRQS_NOSUPPORT |
> > +		trace_flags |= TRACE_FLAG_IRQS_NOSUPPORT;
> >  #endif
> > -		((pc & NMI_MASK    ) ? TRACE_FLAG_NMI     : 0) |
> > -		((pc & HARDIRQ_MASK) ? TRACE_FLAG_HARDIRQ : 0) |
> > -		((pc & SOFTIRQ_OFFSET) ? TRACE_FLAG_SOFTIRQ : 0) |
> > -		(tif_need_resched() ? TRACE_FLAG_NEED_RESCHED : 0) |
> > -		(test_preempt_need_resched() ? TRACE_FLAG_PREEMPT_RESCHED : 0);
> 
> Note, the above was a result of playing around with seeing how the compiler
> optimized the above. Have you seen how the below logic looks as assembly?
> This is a very hot path.

So it does what it did before but differently in different spots.
tracing_generic_entry_update() itself got smaller since it has been
reduced to value assignment only. The trace flags computing changed /
moved to a different place.

The old tracing_generic_entry_update() went from 0x1da0 to 0x1e25 which
are 0x85 bytes. The new __tracing_gen_ctx_flags() (without any of the RT
bits) goes from 0x1f70 to 0x1ff1 which are 0x81 bytes (x86-64, gcc-10).

On x86 the preemption counter is read twice. Once due to preempt_count()
at the top and once due to tif_need_resched(). This did not change.
It reads the `current' pointer once due to test_preempt_need_resched().
Previously it was read twice as well, once due to
test_preempt_need_resched() and another time due to current->pid. The
pid assignment moved to the other function.
The old code seemed to `or' the results into `eax' before the
assignment. Now there are a few `cmove' instructions stretched across
the whole function and returned at the end.

While looking at it just now I don't understand why it checks for
current == NULL. I traced it back to commit
   72829bc3d63cd ("ftrace: move enums to ftrace.h and make helper function global")

and it might have been added by accident.

> > +
> > +	if (pc & NMI_MASK)
> > +		trace_flags |= TRACE_FLAG_NMI;
> > +	if (pc & HARDIRQ_MASK)
> > +		trace_flags |= TRACE_FLAG_HARDIRQ;
> > +
> > +	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
> > +		if (in_serving_softirq())
> > +			trace_flags |= TRACE_FLAG_SOFTIRQ;
> > +	} else {
> > +		if (pc & SOFTIRQ_OFFSET)
> > +			trace_flags |= TRACE_FLAG_SOFTIRQ;
> > +	}
> > +	if (tif_need_resched())
> > +		trace_flags |= TRACE_FLAG_NEED_RESCHED;
> > +	if (test_preempt_need_resched())
> > +		trace_flags |= TRACE_FLAG_PREEMPT_RESCHED;
> > +	return (trace_flags << 16) | (pc & 0xff);
> > +}
> 
> Can you break this into two patches. One that adds the trace_ctx and merges
> the flags and pc, and another patch that only updates to add the RT bits.

Sure, I just wanted you to see the whole picture.
Thank you.

> Thanks!
> 
> -- Steve

Sebastian
