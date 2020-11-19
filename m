Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 079842B9115
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 12:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgKSLeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 06:34:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgKSLeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 06:34:18 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DD8C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 03:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rumag3dHpHuMe0rg+pOJQ3aUonQAL+Na+4EVfJFAQb0=; b=M5D+rSN9r7GsrVp68HjjchZ8rq
        XE4dSggynqMnYzDZn3PuUoZS2DpmYlQac3l8OAGKzLa3KYLySWRtpaF6gRj/rax8ZLxC9mS0MwtEB
        3Gu08MkcPzRo+W1GnXAf8/0o3DfUjOytmJIKCOq04NsV1SvSNOH3r2T2LuoW2hALq/orPo/caxok1
        WnZSCgGTnVBWaQWujHKKnvthlqLwGgkqwHrAWgL8jI6cxbKdWK+3tTVwMeasLSUJnZsoOldpwsiqU
        c2WXnxrftEe9eBl02Y/GWApuEmP4dibS9D6DSl81UD8zsFNyNeXW2gExpZItjhLMoVNjPxZeC0ohx
        CifBhdXQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kfiCJ-0007jb-PM; Thu, 19 Nov 2020 11:33:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8A5893011C6;
        Thu, 19 Nov 2020 12:33:52 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6E0B6200DA727; Thu, 19 Nov 2020 12:33:52 +0100 (CET)
Date:   Thu, 19 Nov 2020 12:33:52 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [patch V4 5/8] sched: highmem: Store local kmaps in task struct
Message-ID: <20201119113352.GM3121378@hirez.programming.kicks-ass.net>
References: <20201118194838.753436396@linutronix.de>
 <20201118204007.372935758@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118204007.372935758@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 08:48:43PM +0100, Thomas Gleixner wrote:
> @@ -4073,6 +4089,7 @@ prepare_task_switch(struct rq *rq, struc
>  	perf_event_task_sched_out(prev, next);
>  	rseq_preempt(prev);
>  	fire_sched_out_preempt_notifiers(prev, next);
> +	kmap_local_sched_out();
>  	prepare_task(next);
>  	prepare_arch_switch(next);
>  }
> @@ -4139,6 +4156,7 @@ static struct rq *finish_task_switch(str
>  	finish_lock_switch(rq);
>  	finish_arch_post_lock_switch();
>  	kcov_finish_switch(current);
> +	kmap_local_sched_in();

This is asymmetric and deserves a comment. You do the sched_out with
IRQs disabled and rq->lock held, but do the sched_in with IRQs enabled
and rq->lock released.

I suppose doing it here reduces IRQ latency by however long it takes to
update and invalidate that handful of pages, is that worth the
asymmetry?

It mirrors preempt_notifiers I suppose, and they actually rely on this
asymmetry for something IIRC.

>  	fire_sched_in_preempt_notifiers(current);
>  	/*

