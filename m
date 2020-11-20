Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B29442BA5A4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 10:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbgKTJOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 04:14:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgKTJOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 04:14:02 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE082C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 01:14:01 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id c198so7766279wmd.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 01:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kvwCEr0uCbeNJuRr3wMhu/1mQPVgkP6nHNyJs6HnJ4c=;
        b=VSs5QW9gbqS90bef06xygx1KkfVuPGvFL3ry+8zEzh7l/o0/s94qUVyMu7s2BlbpYz
         tGFX/aZ6ccbllDJUa3Nx9Tdy67prUS3nEqkmhdKnE3n2MOEZ0FO5pQS1MZ0IJxeTk05f
         rKgRzKlY6k0aFGFYG2vTrl/heq1SSKmo/aD+/b7UKOPS/htbdYrvDvyJgSnQm5MZpG52
         8kaNcdXQmYPXM4i33Ovoq4P8MIAU1Uv1mJDSqSMvBmiRnwc7tjn6xK2Qp+WyorPdNHBF
         IKXZNS1WSVhoLh2rNtTTRc91SmfxhEKX8cfSLCS8VIBBDE8NNWFyYCkn00rb6/+SYEcv
         nKJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kvwCEr0uCbeNJuRr3wMhu/1mQPVgkP6nHNyJs6HnJ4c=;
        b=KlpU6LFpVOe50JIsh3ZGB7W+75fgZYBIe4SjFwAkE3JhXm9IQqcKcjHUwssLwCbLBB
         SxFh36HQVARxrayGmfyhTQ5z+m9o+VOf66OPd2czUyLblaGUQ4P+JVcJNhsdH7sxDp78
         8X7fs3gt/UQkdNhmpVP2cDzyLJpuOnDt1rtxzVBLn78dvZtTiy4QTWajKE2Tvw3bVTXn
         LgK3mQVeIQsGl855Nsa2aGGiRVlpxv8GhxaFKUqWYedWubM97W0SKixO1i3FFckMaxVY
         9xDpca128996Fxt6NMcHk79EmZtjxVJa3mtsdX7odRSaZEDqU9eJiT2E46Lh1iwj+xZY
         VELw==
X-Gm-Message-State: AOAM530aUvcwUROn1VuwQTiR8G2g2G9XzIRac7Z91qxxsx9KT/P+wcAo
        9djihSOScNvO9pKBtL2OIsiedw==
X-Google-Smtp-Source: ABdhPJwHp4JvxjfSTpge/GNmlAzeCIMRcqnK6kw0bsXIFbGv/YC0BfoDwmkQYFITrbIIFezCbGKP9w==
X-Received: by 2002:a7b:c309:: with SMTP id k9mr8587785wmj.14.1605863640397;
        Fri, 20 Nov 2020 01:14:00 -0800 (PST)
Received: from google.com ([2a00:79e0:d:210:f693:9fff:fef4:a7ef])
        by smtp.gmail.com with ESMTPSA id 34sm4801578wrq.27.2020.11.20.01.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 01:13:59 -0800 (PST)
Date:   Fri, 20 Nov 2020 09:13:56 +0000
From:   Quentin Perret <qperret@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        dietmar.eggemann@arm.com, patrick.bellasi@matbug.net,
        lenb@kernel.org, linux-kernel@vger.kernel.org,
        valentin.schneider@arm.com, ionela.voinescu@arm.com,
        viresh.kumar@linaro.org
Subject: Re: [RFC] Documentation/scheduler/schedutil.txt
Message-ID: <20201120091356.GA2653684@google.com>
References: <20201120075527.GB2414@hirez.programming.kicks-ass.net>
 <20201120085653.GA3092@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120085653.GA3092@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 20 Nov 2020 at 09:56:53 (+0100), Peter Zijlstra wrote:
> On Fri, Nov 20, 2020 at 08:55:27AM +0100, Peter Zijlstra wrote:
> >  - In saturated scenarios task movement will cause some transient dips,
> >    suppose we have a CPU saturated with 4 tasks, then when we migrate a task
> >    to an idle CPU, the old CPU will have a 'running' value of 0.75 while the
> >    new CPU will gain 0.25. This is inevitable and time progression will
> >    correct this. XXX do we still guarantee f_max due to no idle-time?

The sugov_cpu_is_busy() logic should mitigate that, but looking at it
again I just realized we don't apply it to the 'shared' update path. I
can't recall why. Anybody?

> Do we want something like this? Is the 1.5 threshold sane? (it's been too
> long since I looked at actual numbers here)
> 
> ---
> 
> diff --git a/kernel/sched/features.h b/kernel/sched/features.h
> index 68d369cba9e4..f0bed8902c40 100644
> --- a/kernel/sched/features.h
> +++ b/kernel/sched/features.h
> @@ -90,3 +90,4 @@ SCHED_FEAT(WA_BIAS, true)
>   */
>  SCHED_FEAT(UTIL_EST, true)
>  SCHED_FEAT(UTIL_EST_FASTUP, true)
> +SCHED_FEAT(UTIL_SAT, true)
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 590e6f27068c..bf70e5ed8ba6 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2593,10 +2593,17 @@ static inline unsigned long cpu_util_dl(struct rq *rq)
>  	return READ_ONCE(rq->avg_dl.util_avg);
>  }
>  
> +#define RUNNABLE_SAT (SCHED_CAPACITY_SCALE + SCHED_CAPACITY_SCALE/2)
> +
>  static inline unsigned long cpu_util_cfs(struct rq *rq)
>  {
>  	unsigned long util = READ_ONCE(rq->cfs.avg.util_avg);
>  
> +	if (sched_feat(UTIL_SAT)) {
> +		if (READ_ONCE(rq->cfs.avg.runnable_avg) > RUNNABLE_SAT)
> +			return SCHED_CAPACITY_SCALE;
> +	}
> +
>  	if (sched_feat(UTIL_EST)) {
>  		util = max_t(unsigned long, util,
>  			     READ_ONCE(rq->cfs.avg.util_est.enqueued));

Need to do the math again, but it's an interesting idea and would solve
a few things (e.g. reset the overutilized flag because of the 'gap' left
by a migration and such) ...

Thanks,
Quentin
