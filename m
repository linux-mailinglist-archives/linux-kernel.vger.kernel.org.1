Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7201027E397
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 10:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbgI3IUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 04:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgI3IUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 04:20:08 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C49C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 01:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dGo6Hzacst8W3YunzMcZXx1pw1z/iSKi8zRtqxheYh4=; b=lUoU4wJqMwIpwnF1QejJF6fTK+
        iyyG1aTqCIwLo2K5kIgDtkUjMC6bAV3zPR3C0KCG5z3ZlVkdMzBWX2wOAjog5RJc7k09D6KOStO+u
        uWewCLhvV07JtTr3cukXKOO1C93gzV1wsjwjfnvAeTeXid4RR+m+A50mzy8/cgNXFhtDwk9wnIio0
        aHrRVBrJ4q3JA4tM2oVJRenhQarbj7eENJd/jVnq42+ehbR6bnKi0NADqGfgvcCNOi/xigghqrcFz
        UkmTFc+16oJ+Ko3NeHS02ZMYfTLeqG9goLy9EpxtOsCogr3+D6RRZzeYSzU5CRmoxl0FyJeE8HR0L
        Yojj4sdg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kNXLC-00011O-02; Wed, 30 Sep 2020 08:19:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 71607303A02;
        Wed, 30 Sep 2020 10:19:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 543ED202A40A0; Wed, 30 Sep 2020 10:19:53 +0200 (CEST)
Date:   Wed, 30 Sep 2020 10:19:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     qianjun.kernel@gmail.com
Cc:     mingo@redhat.com, vincent.guittot@linaro.org,
        juri.lelli@redhat.com, linux-kernel@vger.kernel.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH 1/1] sched/fair: Fix the wrong sched_stat_wait time
Message-ID: <20200930081953.GU2628@hirez.programming.kicks-ass.net>
References: <20200930024712.88258-1-qianjun.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930024712.88258-1-qianjun.kernel@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 10:47:12AM +0800, qianjun.kernel@gmail.com wrote:
> From: jun qian <qianjun.kernel@gmail.com>
> 
> When the sched_schedstat changes from 0 to 1, some sched se maybe
> already in the runqueue, the se->statistics.wait_start will be 0.
> So it will let the (rq_of(cfs_rq)) - se->statistics.wait_start)
> wrong. We need to avoid this scenario.

Is this really the only problem there? Did you do a full audit of that
schedstat nonsense?

> Signed-off-by: jun qian <qianjun.kernel@gmail.com>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  kernel/sched/fair.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 658aa7a..dd7c3bb 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -908,6 +908,14 @@ static void update_curr_fair(struct rq *rq)

your git-diff is 'funny', it got the function ^ wrong.

>  	if (!schedstat_enabled())
>  		return;
>  
> +	/*
> +	 * When the sched_schedstat changes from 0 to 1, some sched se maybe
> +	 * already in the runqueue, the se->statistics.wait_start will be 0.
> +	 * So it will let the delta wrong. We need to avoid this scenario.
> +	 */
> +	if (unlikely(!schedstat_val(se->statistics.wait_start)))
> +		return;
> +
>  	delta = rq_clock(rq_of(cfs_rq)) - schedstat_val(se->statistics.wait_start);
>  
>  	if (entity_is_task(se)) {
> -- 
> 1.8.3.1
> 
