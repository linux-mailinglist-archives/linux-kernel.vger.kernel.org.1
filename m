Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD7D2D182C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 19:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgLGSGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 13:06:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbgLGSGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 13:06:25 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4435C061749
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 10:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hqhNNeuHIOFZyPiLNtUO49By4xky1pUdsNSXoohKAXg=; b=V6o30UJoArkIeo6FSY7xxe2CsQ
        skhbhg6sbfReA+dCDG4LdxWK4i+waESNonbWOmAcdtO6/Bu2adVCYTucd09krKUzA7oIa2g8bwv5u
        7VgG9xO5hPN+bajkspSigmknhinOL7IUqnmqFdY0KGmpxPEuucTd26CKNCscs8lkSdPfHTP7PCIch
        OxBb6pkV/j6k/OfPk3NyjBsldB6fGSwbGFyvUkNzFAUNgqq/wEU7LGHLaAhCLdN76x0oJO9qWU0nc
        X3inzyoY/mlOxXJLhxdKY2IICi5buGVkQ3ZQu6iSJJmFDbDuc0hXSdmcKnlBy+m56HAAlJkNO6o0D
        lyp9FP7A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmKsz-0007tj-HX; Mon, 07 Dec 2020 18:05:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E24CE304D28;
        Mon,  7 Dec 2020 19:05:18 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CF16E20819142; Mon,  7 Dec 2020 19:05:18 +0100 (CET)
Date:   Mon, 7 Dec 2020 19:05:18 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Aubrey Li <aubrey.li@linux.intel.com>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        mgorman@techsingularity.net, qais.yousef@arm.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        tim.c.chen@linux.intel.com, linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@suse.de>, Jiang Biao <benbjiang@gmail.com>
Subject: Re: [RFC PATCH v5] sched/fair: select idle cpu from idle cpumask for
 task wakeup
Message-ID: <20201207180518.GR3040@hirez.programming.kicks-ass.net>
References: <20201118043113.53128-1-aubrey.li@linux.intel.com>
 <20201207154838.GP3040@hirez.programming.kicks-ass.net>
 <jhjtusxtv7b.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhjtusxtv7b.mognet@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 04:52:24PM +0000, Valentin Schneider wrote:
> 
> On 07/12/20 15:48, Peter Zijlstra wrote:
> > On Wed, Nov 18, 2020 at 12:31:13PM +0800, Aubrey Li wrote:
> >> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> >> index f324dc36fc43..6f5947673e66 100644
> >> --- a/kernel/sched/idle.c
> >> +++ b/kernel/sched/idle.c
> >> @@ -163,6 +163,7 @@ static void cpuidle_idle_call(void)
> >>       */
> >>
> >>      if (cpuidle_not_available(drv, dev)) {
> >> +		update_idle_cpumask(this_rq(), true);
> >>              tick_nohz_idle_stop_tick();
> >>
> >>              default_idle_call();
> >> @@ -193,6 +194,7 @@ static void cpuidle_idle_call(void)
> >>                      max_latency_ns = dev->forced_idle_latency_limit_ns;
> >>              }
> >>
> >> +		update_idle_cpumask(this_rq(), true);
> >>              tick_nohz_idle_stop_tick();
> >>
> >>              next_state = cpuidle_find_deepest_state(drv, dev, max_latency_ns);
> >> @@ -205,10 +207,12 @@ static void cpuidle_idle_call(void)
> >>               */
> >>              next_state = cpuidle_select(drv, dev, &stop_tick);
> >>
> >> -		if (stop_tick || tick_nohz_tick_stopped())
> >> +		if (stop_tick || tick_nohz_tick_stopped()) {
> >> +			update_idle_cpumask(this_rq(), true);
> >>                      tick_nohz_idle_stop_tick();
> >
> > We already have a callback in tick_nohz_idle_stop_tick(), namely
> > nohz_balance_enter_idle().
> 
> That's a no-op for !NO_HZ_COMMON though. For similar reasons, Aubrey moved
> the clearing of the cpumask to scheduler_tick().
> 
> Are you saying this mechanism should only be driven for NO_HZ kernels?

IFF it keys off of the tick being stopped, then yes. But as said in the
other email, I think that's a very dubious thing to begin with.
