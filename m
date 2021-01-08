Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75F702EF8FD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 21:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbhAHUWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 15:22:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728694AbhAHUWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 15:22:44 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDFFC061380
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 12:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bw5Xer4Ybhizh77HcltjwUcBtD+6iJDpHkeVTArX14A=; b=VXo4Yifl3CsWRfWJ99e4iYVfN+
        JzhCTJJzJVXf6vACcrcIL9Znm+si25hhZ8imrJHmkUrWagPm9qZKLOI4UO3/LLLFe18yWsrVKBNHg
        KByMjJe2z12RCtBn3wcIxA68vyr+lZh2Duft/lkHZhfEqNyLhlJ+0y4vyXFVd3uWXXWTwahB09yOm
        ZviviUCTC0U21S3ZZzuuSdTKZ8FZhOlnw8OeDBAPNBHLbklSidyY49pkpQF9lTF6dSRBBW/ozXkzB
        /vOP0p/N6OhHKGOgGkqUZJXEaAzgD8xHK3hsK+sUxD3lhUYYwQtsLNzBR8XYzrhmp7ZW93Sy/ylBL
        ceApNzJA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kxyGc-0003Hu-Ik; Fri, 08 Jan 2021 20:21:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 648A83013E5;
        Fri,  8 Jan 2021 21:21:48 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 460762C7BCF2D; Fri,  8 Jan 2021 21:21:48 +0100 (CET)
Date:   Fri, 8 Jan 2021 21:21:48 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     "Li, Aubrey" <aubrey.li@linux.intel.com>,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        valentin.schneider@arm.com, qais.yousef@arm.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        tim.c.chen@linux.intel.com, benbjiang@gmail.com
Subject: Re: [RFC][PATCH 1/5] sched/fair: Fix select_idle_cpu()s cost
 accounting
Message-ID: <X/i+3G53+AH4FfM2@hirez.programming.kicks-ass.net>
References: <20201214164822.402812729@infradead.org>
 <20201214170017.877557652@infradead.org>
 <c4e31235-e1fb-52ac-99a8-ae943ee0de54@linux.intel.com>
 <20201215075911.GA3040@hirez.programming.kicks-ass.net>
 <20210108102738.GB3592@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210108102738.GB3592@techsingularity.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021 at 10:27:38AM +0000, Mel Gorman wrote:

> 1. avg_scan_cost is now based on the average scan cost of a rq but
>    avg_idle is still scaled to the domain size. This is a bit problematic
>    because it's comparing scan cost of a single rq with the estimated
>    average idle time of a domain. As a result, the scan depth can be much
>    larger than it was before the patch and led to some regressions.

> @@ -6164,25 +6164,25 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>  		 */
>  		avg_idle = this_rq()->avg_idle / 512;
>  		avg_cost = this_sd->avg_scan_cost + 1;
> -
> -		span_avg = sd->span_weight * avg_idle;
> -		if (span_avg > 4*avg_cost)
> -			nr = div_u64(span_avg, avg_cost);
> -		else
> +		nr = div_u64(avg_idle, avg_cost);
> +		if (nr < 4)
>  			nr = 4;

Oooh, could it be I simply didn't remember how that code was supposed to
work and should kick my (much) younger self for not writing a comment?

Consider:

       span_weight * avg_idle               avg_cost
  nr = ---------------------- = avg_idle / ----------
               avg_cost                    span_weigt

Where: avg_cost / span_weight ~= cost-per-rq


