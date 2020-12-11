Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1339F2D81DD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 23:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388750AbgLKWUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 17:20:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728668AbgLKWUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 17:20:10 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F30DC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 14:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kP3/BqmKRqUCbIsMUPGHxHnJMu6Z51pTgfmbZ0jtzd0=; b=tpnPd7y4ubktUC/WbeXvaN/ndC
        RmPy4mVBc7myv3DXleUDq3w720VbfirLQJuWMfiMWAC4x2/wTQoHZNLZcHQ1JjwSNhfOIYMjbWcvR
        +jIhNXX0VSn73CNrwurZ+tGxdaxzs4Pr0GU3D2NfZNCiu9UOfDhbA5OP2D1tupMCoThzeQnWG0KzY
        Y0/tLZFQT38598HZMQ2bDR79K/WWA0fI2e5hTdC0hsg/3afXSnyFwCa92cV1g0rdZmtI2RvTf6+TH
        7m9lIdviXAZXrgftcjgeeI0MQmVGChdS3ZFVfiyw7oiJ7KivppPlQsw0wKTukVhf4TeJxWJzVllNu
        8xW6eSDg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1knqkm-0002Hn-PC; Fri, 11 Dec 2020 22:19:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9C316305815;
        Fri, 11 Dec 2020 23:19:05 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8A6CE20819150; Fri, 11 Dec 2020 23:19:05 +0100 (CET)
Date:   Fri, 11 Dec 2020 23:19:05 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     "Li, Aubrey" <aubrey.li@linux.intel.com>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        valentin.schneider@arm.com, qais.yousef@arm.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        tim.c.chen@linux.intel.com, linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@suse.de>, Jiang Biao <benbjiang@gmail.com>
Subject: Re: [RFC PATCH v7] sched/fair: select idle cpu from idle cpumask for
 task wakeup
Message-ID: <20201211221905.GV3040@hirez.programming.kicks-ass.net>
References: <20201209062404.175565-1-aubrey.li@linux.intel.com>
 <20201209143510.GO3371@techsingularity.net>
 <3802e27a-56ed-9495-21b9-7c4277065155@linux.intel.com>
 <20201210113441.GS3371@techsingularity.net>
 <31308700-aa28-b1f7-398e-ee76772b6b87@linux.intel.com>
 <20201210125833.GT3371@techsingularity.net>
 <20201211174442.GU3040@hirez.programming.kicks-ass.net>
 <20201211204337.GX3371@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201211204337.GX3371@techsingularity.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 11, 2020 at 08:43:37PM +0000, Mel Gorman wrote:
> One bug is in __select_idle_core() though. It's scanning the SMT mask,
> not select_idle_mask so it can return an idle candidate that is not in
> p->cpus_ptr.

D'0h.. luckily the benchmarks don't hit that :-)

> There are some other potential caveats.
> 
> This is a single pass so when test_idle_cores() is true, __select_idle_core
> is used to to check all the siblings even if the core is not idle. That
> could have been cut short if __select_idle_core checked *idle_cpu ==
> 1 and terminated the SMT scan if an idle candidate had already been found.

So I did that on purpose, so as to track the last/most-recent idle cpu,
with the thinking that that cpu has the higher chance of still being
idle vs one we checked earlier/longer-ago.

I suppose we benchmark both and see which is liked best.

> Second downside is related. If test_idle_cpus() was true but no idle
> CPU is found then __select_idle_core has been called enough to scan
> the entire domain. In this corner case, the new code does *more* work
> because the old code would have failed select_idle_core() quickly and
> then select_idle_cpu() would be throttled by SIS_PROP. I think this will
> only be noticable in the heavily overloaded case but if the corner case
> hits enough then the new code will be slower than the old code for the
> over-saturated case (i.e. hackbench with lots of groups).

Right, due to scanning siblings, even if the first inspected thread is
not idle, we scan more.

> The third potential downside is that the SMT sibling is not guaranteed to
> be checked due to SIS_PROP throttling but in the old code, that would have
> been checked by select_idle_smt(). That might result in premature stacking
> of runnable tasks on the same CPU. Similarly, as __select_idle_core may
> find multiple idle candidates, it will not pick the targets SMT sibling
> if it is idle like select_idle_smt would have.
> 
> That said, I am skeptical that select_idle_smt() matters all that often.

This, I didn't really believe in it either.


The benchmarks I started are mostly noise, with a few wins for
TCP_STREAM and UDP_RR around the 50% mark. Although I should run
longer variants to make sure.
