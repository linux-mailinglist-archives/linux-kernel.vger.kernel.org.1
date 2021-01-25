Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABFD303D72
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 13:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403847AbhAZKJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:09:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:43756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731383AbhAYTET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 14:04:19 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C49892067B;
        Mon, 25 Jan 2021 19:03:24 +0000 (UTC)
Date:   Mon, 25 Jan 2021 14:03:23 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/3] tracing: Merge irqflags + preempt counter.
Message-ID: <20210125140323.6b1ff20c@gandalf.local.home>
In-Reply-To: <20210125140551.hlpbreks4f7ytuza@linutronix.de>
References: <20210112230057.2374308-1-bigeasy@linutronix.de>
        <20210112230057.2374308-2-bigeasy@linutronix.de>
        <20210122170750.600b2372@gandalf.local.home>
        <20210125140551.hlpbreks4f7ytuza@linutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jan 2021 15:05:51 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> > Then all you need to do is implement the tracing_gen_ctx_irq_test() without
> > adding and #ifdefs in it, and just or in the "irq_status" to trace_flags,
> > without any conditionals.  
> 
> You just moved that from one place to another. I had to move enum
> trace_flag_type just before tracing_gen_ctx_irq_test() so it is
> available by tracing_gen_ctx_flags(). I don't know if you earn by
> inlining much, the gcc numbers for vmlinux:
> 
>     text      data      bss      dec filename
>  24306853 21869070 14205180 60381103 vmlinux-rc5
>  24306482 21869070 14205180 60380732 vmlinux-rc5-merge-irqflags
>  24306852 21869070 14205180 60381102 vmlinux-rc5-merge-irqflags-inline
> 
> I know that a reduction by ~300 byte isn't exactly breath taking. I run
> the test twice because the reduction in text by one byte looked odd but
> it is what it is. Inlining only tracing_gen_ctx_dec() probably makes
> sense especially since there is one user.

I was thinking about the inlining for two reasons. One was to consolidate
the logic in the header file, as they are small functions. And two, inlined
functions tend to be faster than non-inlined functions. Thus, I wasn't
looking at this from a size point of view, but since this is called by all
events, including function tracer, being efficient is a requirement.

> 
> I can post the irqflags-merge and the inlinining as two seprate patches
> and you can then decide if you merge the two patches or drop the
> inlining.

Feel free to send it as separate patches. I'd like to have the inlining.

Thanks!

-- Steve
