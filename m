Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1FA92D1515
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 16:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgLGPtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 10:49:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgLGPtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 10:49:42 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDDFEC06179C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 07:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YhTuQpAuVhEXZKFT3p3qbp40M3jZi+iAS4Ki0D9kbgk=; b=wr3ouKempAHHE1O6HSg1PGu1E7
        qXyl3QyHhzb+ARRJX7ZxG+WW2NOZudStGTb9KayddDovSowmVo2YsdD6WfR9g/FyNzNdoKzFBdwbb
        6dHhXAjOx5IppkvN6kfTgEZ2Rz9sjRy2HtwXsHp+FXhH6AFyxjNDjVJF99U7AU7+vue9NNpyOvzZS
        z2CaS0htrRK6zS0XsdI61HWybueeVRG0w69ec7FHbO+t7+IJ6ke11t/d2s5UtQ3//jQJgOgIg9IWM
        mjDZhrS/d/GghG7sBA1lSZLMkvxmqfJCyqTSSyODtx53T7hVoAcitIgmGLSiAfXu3vAozc911CSnG
        pjJYrbig==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmIkl-0002zy-NT; Mon, 07 Dec 2020 15:48:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1AEFC304B92;
        Mon,  7 Dec 2020 16:48:39 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0A261200E4A0F; Mon,  7 Dec 2020 16:48:39 +0100 (CET)
Date:   Mon, 7 Dec 2020 16:48:38 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Aubrey Li <aubrey.li@linux.intel.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, mgorman@techsingularity.net,
        valentin.schneider@arm.com, qais.yousef@arm.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        tim.c.chen@linux.intel.com, linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@suse.de>, Jiang Biao <benbjiang@gmail.com>
Subject: Re: [RFC PATCH v5] sched/fair: select idle cpu from idle cpumask for
 task wakeup
Message-ID: <20201207154838.GP3040@hirez.programming.kicks-ass.net>
References: <20201118043113.53128-1-aubrey.li@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118043113.53128-1-aubrey.li@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 12:31:13PM +0800, Aubrey Li wrote:
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index f324dc36fc43..6f5947673e66 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -163,6 +163,7 @@ static void cpuidle_idle_call(void)
>  	 */
>  
>  	if (cpuidle_not_available(drv, dev)) {
> +		update_idle_cpumask(this_rq(), true);
>  		tick_nohz_idle_stop_tick();
>  
>  		default_idle_call();
> @@ -193,6 +194,7 @@ static void cpuidle_idle_call(void)
>  			max_latency_ns = dev->forced_idle_latency_limit_ns;
>  		}
>  
> +		update_idle_cpumask(this_rq(), true);
>  		tick_nohz_idle_stop_tick();
>  
>  		next_state = cpuidle_find_deepest_state(drv, dev, max_latency_ns);
> @@ -205,10 +207,12 @@ static void cpuidle_idle_call(void)
>  		 */
>  		next_state = cpuidle_select(drv, dev, &stop_tick);
>  
> -		if (stop_tick || tick_nohz_tick_stopped())
> +		if (stop_tick || tick_nohz_tick_stopped()) {
> +			update_idle_cpumask(this_rq(), true);
>  			tick_nohz_idle_stop_tick();

We already have a callback in tick_nohz_idle_stop_tick(), namely
nohz_balance_enter_idle().

