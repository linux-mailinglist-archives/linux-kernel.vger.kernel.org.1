Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0F42303694
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 07:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbhAZGbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 01:31:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729170AbhAYOHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 09:07:10 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0708BC0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 06:06:30 -0800 (PST)
Date:   Mon, 25 Jan 2021 15:05:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611583557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tssgOCX9V8//tH7pur/zKTn5bEYBdkZ41end9BNHSx0=;
        b=cJI+jCEZRM5CPW/js/7r8N0yPlUnlqDgVW8RuUPVD2wd63+M9lmqMybIvJKa6MjD3Uvj6Z
        mLEpKv3Wxscmb7fzVN253uS91MXk5hJQZvz08fYsHHGPMlJd05VGgiankcRg7F15gNeiON
        Ai71xSY19iiqUSS9UBJ0wk5kVTqq2p027Au3kw2RdIxhYbBFT6TcqK7eQw/9td84VhRwSC
        mByGmfSyxxpsD/UK8p+sE9DOrRCKba+Ra/XlIRABSxKbwUPZQ9BczFQErNQUvaUvdef3/g
        94vWStA02DARKUwE+mHefsg+FmR/c4s6ljdRgxZ9lWBzw9f/Ei51CzrU8ff7QA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611583557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tssgOCX9V8//tH7pur/zKTn5bEYBdkZ41end9BNHSx0=;
        b=qWVWxJtxfX8qBQ6nc1zJblspcAtHoRL9Jao8Qk9evv8S2HVDWDHyEDnuhaav1+LHqD4Bvh
        VJSKQd5Pd1OEtKCw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/3] tracing: Merge irqflags + preempt counter.
Message-ID: <20210125140551.hlpbreks4f7ytuza@linutronix.de>
References: <20210112230057.2374308-1-bigeasy@linutronix.de>
 <20210112230057.2374308-2-bigeasy@linutronix.de>
 <20210122170750.600b2372@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210122170750.600b2372@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-22 17:07:50 [-0500], Steven Rostedt wrote:
> On Wed, 13 Jan 2021 00:00:55 +0100
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> > +unsigned int _tracing_gen_ctx_flags(unsigned long irqflags);
> > +unsigned int tracing_gen_ctx_flags(void);
> > +unsigned int tracing_gen_ctx_flags_dect(void);
> 
> Since I'm now trying to avoid underscore functions when possible, the above
> should be:
> 
> _tracing_gen_ctx_flags()   --> tracing_gen_ctx_flags()
> tracing_gen_ctx_flags()    --> tracing_gen_ctx()
> tracing_gen_ctx_flags_dect --> tracing_gen_ctx_dec()
> 
> Note, "_dec()" should be used instead of "_dect()" as "_dec" is commonly
> used around the kernel, and I had really no idea what "_dect" was, until I
> looked at the two functions.

Okay, let me do the renames.

> And looking at the implementation, I wonder if we should make this into
> static inlines in the header as follows:
> 
> unsigned int tracing_gen_ctx_irq_test(int irqs_status);
> 
> #ifdef CONFIG_TRACE_IRQFLAGS_SUPPORT
> static inline unsigned int tracing_gen_ctx_flags(unsigned long irqflags)
> {
> 	unsigned int irq_status = irqs_disabled(irqflags) ?
> 		TRACE_FLAG_IRQS_OFF : 0;
> 	return tracing_gen_ctx_irq_test(irq_status);
> }
> static inline unsigned int tracing_gen_ctx(void)
> {
> 	unsigned long irqflags;
> 
> 	local_save_flags(irqflags);
> 	return tracing_gen_ctx_flags(irqflags);
> }
> #else
> static inline unsigned int tracing_gen_ctx_flags(unsigned long irqflags)
> {
> 	return tracing_gen_ctx_irq_test(TRACE_FLAG_IRQS_NOSUPPORT);
> }
> static inline unsigned int tracing_gen_ctx(void)
> {
> 	return tracing_gen_ctx_irq_test(TRACE_FLAG_IRQS_NOSUPPORT);
> }
> #endif
> 
> static inline unsigned int tracing_gen_ctx_dec(void)
> {
> 	unsigned int trace_ctx;
> 
> 	trace_ctx = tracing_gen_ctx();
> 	/*** Comment about buffer_reserve here ***/
> 	if (IS_ENABLED(CONFIG_PREEMPTION))
> 		trace_ctx--;
> 	return trace_ctx;
> }
> 
> Then all you need to do is implement the tracing_gen_ctx_irq_test() without
> adding and #ifdefs in it, and just or in the "irq_status" to trace_flags,
> without any conditionals.

You just moved that from one place to another. I had to move enum
trace_flag_type just before tracing_gen_ctx_irq_test() so it is
available by tracing_gen_ctx_flags(). I don't know if you earn by
inlining much, the gcc numbers for vmlinux:

    text      data      bss      dec filename
 24306853 21869070 14205180 60381103 vmlinux-rc5
 24306482 21869070 14205180 60380732 vmlinux-rc5-merge-irqflags
 24306852 21869070 14205180 60381102 vmlinux-rc5-merge-irqflags-inline

I know that a reduction by ~300 byte isn't exactly breath taking. I run
the test twice because the reduction in text by one byte looked odd but
it is what it is. Inlining only tracing_gen_ctx_dec() probably makes
sense especially since there is one user.

I can post the irqflags-merge and the inlinining as two seprate patches
and you can then decide if you merge the two patches or drop the
inlining.

> -- Steve

Sebastian
