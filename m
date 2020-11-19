Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE3742B91E2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 12:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbgKSLv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 06:51:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbgKSLv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 06:51:58 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38268C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 03:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dY3xCz1US42IgUQKvQZydem55nNev0dCCyUsmh22YNA=; b=c075Zv/rt9hDk0DBiY3b9jGPqB
        mzkAi0MZcNSlkjxpMVH3kpo8s4csl9dZJvktJ5dvdqHJ/QY7UoroqjdUMkSXnNSxm4QB13j8dsSdT
        y/LlYYLB0MrH2mIuEVH8zpzhkK67Ec23tDdlu/SANoxS/ZywxjZpt3mmP0ZHGySU2my8Pq31qkJLU
        EQfuucPWrjF10uaiLJhqKT3PJTAOlGGVIuf8S18TVQv/qshjwJ6qeiSgimLQtFPGC7CRnwdERpLTr
        1+i74V5qMpMUtJ6MKXBzMUF53e1uqhGuoZsyNpHnse7W4Oh/CfKTp3zzySvn57K48jRnEYnkPusii
        V5Q5Xj0Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kfiTO-00015A-52; Thu, 19 Nov 2020 11:51:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 92B833060AE;
        Thu, 19 Nov 2020 12:51:32 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5A56820126362; Thu, 19 Nov 2020 12:51:32 +0100 (CET)
Date:   Thu, 19 Nov 2020 12:51:32 +0100
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
Message-ID: <20201119115132.GN3121378@hirez.programming.kicks-ass.net>
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
>  
>  	fire_sched_in_preempt_notifiers(current);
>  	/*

> +void __kmap_local_sched_out(void)
> +{
> +	struct task_struct *tsk = current;
> +	pte_t *kmap_pte = kmap_get_pte();
> +	int i;
> +
> +	/* Clear kmaps */
> +	for (i = 0; i < tsk->kmap_ctrl.idx; i++) {
> +	}
> +}
> +
> +void __kmap_local_sched_in(void)
> +{
> +	struct task_struct *tsk = current;
> +	pte_t *kmap_pte = kmap_get_pte();
> +	int i;
> +
> +	/* Restore kmaps */
> +	for (i = 0; i < tsk->kmap_ctrl.idx; i++) {
> +	}
> +}

So even in the optimal case, this adds an unconditional load of
tsk->kmap_ctrl.idx to schedule() (2 misses, one pre and one post).

Munging preempt-notifiers behind a static_branch, which in that same
optimal case, avoided touching curr->preempt_notifier, resulted in a
measurable performance improvement. See commit:

  1cde2930e154 ("sched/preempt: Add static_key() to preempt_notifiers")

Can we fudge some state in a cacheline we're already touching to avoid
this?
