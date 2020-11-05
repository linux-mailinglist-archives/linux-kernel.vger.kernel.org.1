Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 080192A8672
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 19:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731967AbgKESuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 13:50:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbgKESuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 13:50:22 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091B6C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 10:50:22 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id r7so2181109qkf.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 10:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sRzVU4QCj+G/NEOuuLkZgFLPxs16kEUOAR94xTqGuOI=;
        b=Ge5ba13VykYBRgKHhJqElioEsxyeQmTyYj6/9E1yxViZlGDrM0w5SzbIoRVuuVJUHd
         uZb1kwjXhEp9K/nbM8pGa2GMc9lQIIlhdv8T8G7EL/ogXrcYt+8URkmVWk6kPFzW5h2X
         7bjoM0xG3BOkcZ2AP7lVtXSYF0UaxWUm74GSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sRzVU4QCj+G/NEOuuLkZgFLPxs16kEUOAR94xTqGuOI=;
        b=AvOseQmH5DiujHe4KXy6/gbCqPtmFJFgTTtExB6erKDgSbjUffn558do+PQ57TVI+Y
         8WZZDPWb938D47UwXETaRpJDBmRAKFzpGFthV4Hy9KWs97HXzKvVvbPYVDqBT1OXCWWL
         1/VCX0furpRg3gpXJ33eQsvlNFxBs9GIGRumaIEsL3vzyvgKdJ0vZ3as5HdRmgsfsAMR
         HJgAkso3v4uVYke5z0peKX5717Wj8RGCT5X4Rpu8Q/WQTQ+uhkhT5F1sGdMCPyR69WEN
         Ie4txV1pp+KiI2/nquLhXP9HnwlTHeKd6kQFV+RXOZyfBm1AlVuy4rbwstlef97M7tFv
         OXyw==
X-Gm-Message-State: AOAM531PxbrzXOeFgUP/zC1DHRTzRgbLvJI5RnBxBA4k2EwaO4n64ehl
        Z7NAsrHztS3Hn+LU9URfsGcyZw==
X-Google-Smtp-Source: ABdhPJzj/b3B4IWqQPefE+U4u8lCXcyzwaIUSRdwNGIN+5maLwHwQ10GEUy6kmJb38eP/AbhJZQKkQ==
X-Received: by 2002:a37:6cd:: with SMTP id 196mr3448823qkg.228.1604602221073;
        Thu, 05 Nov 2020 10:50:21 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id u31sm1516736qtu.87.2020.11.05.10.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 10:50:20 -0800 (PST)
Date:   Thu, 5 Nov 2020 13:50:19 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        torvalds@linux-foundation.org, fweisbec@gmail.com,
        keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        pjt@google.com, rostedt@goodmis.org, derkling@google.com,
        benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>, jsbarnes@google.com,
        chris.hyser@oracle.com,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Aaron Lu <aaron.lu@linux.alibaba.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
Subject: Re: [PATCH v8 -tip 06/26] sched: Add core wide task selection and
 scheduling.
Message-ID: <20201105185019.GA2771003@google.com>
References: <20201020014336.2076526-1-joel@joelfernandes.org>
 <20201020014336.2076526-7-joel@joelfernandes.org>
 <20201023135129.GS2611@hirez.programming.kicks-ass.net>
 <20201023135400.GA2651@hirez.programming.kicks-ass.net>
 <20201023175724.GA3563800@google.com>
 <20201023192654.GH2974@worktop.programming.kicks-ass.net>
 <20201023213118.GD3563800@google.com>
 <20201026093131.GF2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026093131.GF2628@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 10:31:31AM +0100, Peter Zijlstra wrote:
> On Fri, Oct 23, 2020 at 05:31:18PM -0400, Joel Fernandes wrote:
> > On Fri, Oct 23, 2020 at 09:26:54PM +0200, Peter Zijlstra wrote:
> 
> > > How about this then?
> > 
> > This does look better. It makes sense and I think it will work. I will look
> > more into it and also test it.
> 
> Hummm... Looking at it again I wonder if I can make something like the
> below work.
> 
> (depends on the next patch that pulls core_forceidle into core-wide
> state)
> 
> That would retain the CFS-cgroup optimization as well, for as long as
> there's no cookies around.
> 
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4691,8 +4691,6 @@ pick_next_task(struct rq *rq, struct tas
>  		return next;
>  	}
>  
> -	put_prev_task_balance(rq, prev, rf);
> -
>  	smt_mask = cpu_smt_mask(cpu);
>  
>  	/*
> @@ -4707,14 +4705,25 @@ pick_next_task(struct rq *rq, struct tas
>  	 */
>  	rq->core->core_task_seq++;
>  	need_sync = !!rq->core->core_cookie;
> -
> -	/* reset state */
> -reset:
> -	rq->core->core_cookie = 0UL;
>  	if (rq->core->core_forceidle) {
>  		need_sync = true;
>  		rq->core->core_forceidle = false;
>  	}
> +
> +	if (!need_sync) {
> +		next = __pick_next_task(rq, prev, rf);

This could end up triggering pick_next_task_fair's newidle balancing;

> +		if (!next->core_cookie) {
> +			rq->core_pick = NULL;
> +			return next;
> +		}

.. only to realize here that pick_next_task_fair() that we have to put_prev
the task back as it has a cookie, but the effect of newidle balancing cannot
be reverted.

Would that be a problem as the newly pulled task might be incompatible and
would have been better to leave it alone?

TBH, this is a drastic change and we've done a lot of testing with the
current code and its looking good. I'm a little scared of changing it right
now and introducing regression. Can we maybe do this after the existing
patches are upstream?

thanks,

 - Joel


> +		put_prev_task(next);
> +		need_sync = true;
> +	} else {
> +		put_prev_task_balance(rq, prev, rf);
> +	}
> +
> +	/* reset state */
> +	rq->core->core_cookie = 0UL;
>  	for_each_cpu(i, smt_mask) {
>  		struct rq *rq_i = cpu_rq(i);
>  
> @@ -4744,35 +4752,8 @@ pick_next_task(struct rq *rq, struct tas
>  			 * core.
>  			 */
>  			p = pick_task(rq_i, class, max);
> -			if (!p) {
> -				/*
> -				 * If there weren't no cookies; we don't need to
> -				 * bother with the other siblings.
> -				 */
> -				if (i == cpu && !need_sync)
> -					goto next_class;
> -
> +			if (!p)
>  				continue;
> -			}
> -
> -			/*
> -			 * Optimize the 'normal' case where there aren't any
> -			 * cookies and we don't need to sync up.
> -			 */
> -			if (i == cpu && !need_sync) {
> -				if (p->core_cookie) {
> -					/*
> -					 * This optimization is only valid as
> -					 * long as there are no cookies
> -					 * involved.
> -					 */
> -					need_sync = true;
> -					goto reset;
> -				}
> -
> -				next = p;
> -				goto done;
> -			}
>  
>  			rq_i->core_pick = p;
>  
