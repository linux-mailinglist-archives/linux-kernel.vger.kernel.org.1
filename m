Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1AE28E0F5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 15:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731046AbgJNNCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 09:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727141AbgJNNCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 09:02:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBA9C061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 06:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bm7PA40r+RqY1oWurw9dIUPe3pvqYwdNmKOFhvH6eko=; b=Gy7+1c9rLsZzNb3OHdE81B6L8M
        9OaRoEUdlKCQdpdzkxJFT3d3RqMXIhQFsCP9SqgCTGXad3kJmzh3xOXSPDvRURL0zIsiZiMDVy9/c
        H07W2windvDYxxDp8TFz6IS3dWq1D1VHfFa0T1T2arUbecekKqkpDsz1Mp1nKp1YHnmLYs/quBBLi
        g/jjHQIgLvuvJ7mzCRM/v8H6xwCW5OYqgBdsn6gcrnyXp1xh9IVgQ8MpqVjZDgDVS61kAEXVAnXPR
        v6/+9PU51PQ/U+vKPNHAxMZ1SK18sYFv29QsMqbozVdQzbrN8paTW2AghyQxvC6JMRv2pYA2isdvk
        pATlAwqA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kSgQD-0005rF-0G; Wed, 14 Oct 2020 13:02:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 876D530015A;
        Wed, 14 Oct 2020 15:02:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4C9C624BFBA83; Wed, 14 Oct 2020 15:02:23 +0200 (CEST)
Date:   Wed, 14 Oct 2020 15:02:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: Re: [PATCH] sched/cputime: correct account of irqtime
Message-ID: <20201014130223.GF2628@hirez.programming.kicks-ass.net>
References: <1602510644-24536-1-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1602510644-24536-1-git-send-email-kernelfans@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 09:50:44PM +0800, Pingfan Liu wrote:
> __do_softirq() may be interrupted by hardware interrupts. In this case,
> irqtime_account_irq() will account the time slice as CPUTIME_SOFTIRQ by
> mistake.
> 
> By passing irqtime_account_irq() an extra param about either hardirq or
> softirq, irqtime_account_irq() can handle the above case.

I'm not sure I see the scenario in which it goes wrong.

irqtime_account_irq() is designed such that we're called with the old
preempt_count on enter and the new preempt_count on exit. This way we'll
accumuate the delta to the previous context.

> @@ -68,7 +68,7 @@ void irqtime_account_irq(struct task_struct *curr)
>  	 */
>  	if (hardirq_count())
>  		irqtime_account_delta(irqtime, delta, CPUTIME_IRQ);
> -	else if (in_serving_softirq() && curr != this_cpu_ksoftirqd())
> +	else if (in_serving_softirq() && curr != this_cpu_ksoftirqd() && !hardirq)
>  		irqtime_account_delta(irqtime, delta, CPUTIME_SOFTIRQ);
>  }


