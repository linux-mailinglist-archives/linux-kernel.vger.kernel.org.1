Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73C0527A8AC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 09:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgI1HcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 03:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgI1HcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 03:32:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1339CC0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 00:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9a4RQ/cVE8L9jRWNlJ9jl2x1mUr9n344j0WMZjuDA5s=; b=aZUJAjjmdP/OsenQWBHc6mHLmD
        wUWPfx0OuGGuItQ8dnzsPdhenqd0uKm2ziu731VRm3PGPK1Ajck7Rod1Xag7kANv3RJrg+TDQrR7q
        4uXD2+FaPtg9dqtPeeqnLlIdUMY8hncZygc8hy8284KxTntU8ImrhrmCoXG1LGpW8qDsWOm0vhfMt
        /oXesj5Rf2hfbjpWIkfAv/72ZyuCoaH7nicXiY2A7O9dyeUQftM50dzmttUpdmqruGs2MyF6fNdV8
        RmT8/tiGtY4sYeGyXRHSMcaKoolyZTKnWr+vL2v6UmB9Qj/JUOB3YNgdIVh4v6LHS14yfBP4SzSOz
        jSedQIeQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kMndm-0007Qh-PS; Mon, 28 Sep 2020 07:32:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5CDE9300F7A;
        Mon, 28 Sep 2020 09:32:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0AB142019499B; Mon, 28 Sep 2020 09:32:03 +0200 (CEST)
Date:   Mon, 28 Sep 2020 09:32:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     linux-kernel@vger.kernel.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, songmuchun@bytedance.com
Subject: Re: [PATCH 2/2] sched: mark PRINTK_DEFERRED_CONTEXT_MASK in
 __schedule()
Message-ID: <20200928073202.GA2611@hirez.programming.kicks-ass.net>
References: <20200927161130.33172-1-zhouchengming@bytedance.com>
 <20200927161130.33172-2-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200927161130.33172-2-zhouchengming@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 12:11:30AM +0800, Chengming Zhou wrote:
> The WARN_ON/WARN_ON_ONCE with rq lock held in __schedule() should be
> deferred by marking the PRINTK_DEFERRED_CONTEXT_MASK, or will cause
> deadlock on rq lock in the printk path.

It also shouldn't happen in the first place, so who bloody cares.

> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  kernel/sched/core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 2d95dc3f4644..81d8bf614225 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4444,6 +4444,7 @@ static void __sched notrace __schedule(bool preempt)
>  	 */
>  	rq_lock(rq, &rf);
>  	smp_mb__after_spinlock();
> +	printk_deferred_enter();
>  
>  	/* Promote REQ to ACT */
>  	rq->clock_update_flags <<= 1;
> @@ -4530,6 +4531,7 @@ static void __sched notrace __schedule(bool preempt)
>  		rq_unlock_irq(rq, &rf);
>  	}
>  
> +	printk_deferred_exit();
>  	balance_callback(rq);
>  }

NAK printk_deferred is an abomination, kill that.
