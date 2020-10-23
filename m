Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 022272978EF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 23:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756730AbgJWVbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 17:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756723AbgJWVbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 17:31:21 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8D7C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 14:31:21 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id k9so2768017qki.6
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 14:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1c4IkRJRrvWLTTRxNMeGeo3YFy3KCCWwcysesoNk1vY=;
        b=lcXASlq7el+cdEw25UPAOyyvNimXDgX4vLmuBoRe+I+h+VeJ4ikFomBxnQIYJS+qsO
         dXBZmiaCI6OGsUoobSnHwx9EsrqGlK6dt/SJGRlr7RT27VmDjh+xxUuDCoz9puiFQ0J/
         FgdxfiOOoCwHsSGVA6D84BHrpv5kf5YKt1ngA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1c4IkRJRrvWLTTRxNMeGeo3YFy3KCCWwcysesoNk1vY=;
        b=qWPF80dqn7X7p/V7dY5+xdspB6Oj+CNtr0Un4YKJ6tXUI4mw06H2eprWCvnNcdzpGg
         BNdDZ8EEk2i+ElC8EhZxssT3jEMZWWSX71hD+pxZEEmFMKfINRPvWZrJzQNe+vaRi4fC
         uLxGS0oSOZcg1VzI7BhCtxA1M+G+OcritjJ1cSPOKy9nK7wO8wa76V6QyTUN1fI6DxRI
         vnk5pIxQkgNc5qy5iU9cdtrrSOwubfhVJBIkTBpFmYTVN4vzIOkcLYaB41pR3zrefrgM
         Q7sOBVPK/QtXsgpVf6AbamwcNUiyPkH/FeQQDyIHgfBIY/3z+vRQ2C4ThoYdacuzOXVz
         v8yg==
X-Gm-Message-State: AOAM5306fxw7eL9/kJNSRy9S6PBS3Mzn3/wCRtpf4WdJSXVaqKW4wn7z
        +l4opk3O3C8ir/UecxxrsG1rVA==
X-Google-Smtp-Source: ABdhPJwD4aXToXasUZDGpXE+8MKPO7sW6PZpp09HnkGveyl6/N1V3C//K1GRpKOryhVecjeUKEKwTw==
X-Received: by 2002:a37:9ed0:: with SMTP id h199mr3120621qke.407.1603488680042;
        Fri, 23 Oct 2020 14:31:20 -0700 (PDT)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id d14sm1729398qtr.62.2020.10.23.14.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 14:31:19 -0700 (PDT)
Date:   Fri, 23 Oct 2020 17:31:18 -0400
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
Message-ID: <20201023213118.GD3563800@google.com>
References: <20201020014336.2076526-1-joel@joelfernandes.org>
 <20201020014336.2076526-7-joel@joelfernandes.org>
 <20201023135129.GS2611@hirez.programming.kicks-ass.net>
 <20201023135400.GA2651@hirez.programming.kicks-ass.net>
 <20201023175724.GA3563800@google.com>
 <20201023192654.GH2974@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201023192654.GH2974@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 23, 2020 at 09:26:54PM +0200, Peter Zijlstra wrote:
> On Fri, Oct 23, 2020 at 01:57:24PM -0400, Joel Fernandes wrote:
> > On Fri, Oct 23, 2020 at 03:54:00PM +0200, Peter Zijlstra wrote:
> > > On Fri, Oct 23, 2020 at 03:51:29PM +0200, Peter Zijlstra wrote:
> > > > On Mon, Oct 19, 2020 at 09:43:16PM -0400, Joel Fernandes (Google) wrote:
> > > > > +			/*
> > > > > +			 * If this sibling doesn't yet have a suitable task to
> > > > > +			 * run; ask for the most elegible task, given the
> > > > > +			 * highest priority task already selected for this
> > > > > +			 * core.
> > > > > +			 */
> > > > > +			p = pick_task(rq_i, class, max);
> > > > > +			if (!p) {
> > > > > +				/*
> > > > > +				 * If there weren't no cookies; we don't need to
> > > > > +				 * bother with the other siblings.
> > > > > +				 * If the rest of the core is not running a tagged
> > > > > +				 * task, i.e.  need_sync == 0, and the current CPU
> > > > > +				 * which called into the schedule() loop does not
> > > > > +				 * have any tasks for this class, skip selecting for
> > > > > +				 * other siblings since there's no point. We don't skip
> > > > > +				 * for RT/DL because that could make CFS force-idle RT.
> > > > > +				 */
> > > > > +				if (i == cpu && !need_sync && class == &fair_sched_class)
> > > > > +					goto next_class;
> > > > > +
> > > > > +				continue;
> > > > > +			}
> > > > 
> > > > I'm failing to understand the class == &fair_sched_class bit.
> > 
> > The last line in the comment explains it "We don't skip for RT/DL because
> > that could make CFS force-idle RT.".
> 
> Well, yes, but it does not explain how this can come about, now does it.

Sorry, I should have made it a separate commit with the below explanation. Oh
well, live and learn!

> > Even if need_sync == false, we need to go look at other CPUs (non-local
> > CPUs) to see if they could be running RT.
> > 
> > Say the RQs in a particular core look like this:
> > Let CFS1 and CFS2 be 2 tagged CFS tags. Let RT1 be an untagged RT task.
> > 
> > rq0	       rq1
> > CFS1 (tagged)  RT1 (not tag)
> > CFS2 (tagged)
> > 
> > Say schedule() runs on rq0. Now, it will enter the above loop and
> > pick_task(RT) will return NULL for 'p'. It will enter the above if() block
> > and see that need_sync == false and will skip RT entirely.
> > 
> > The end result of the selection will be (say prio(CFS1) > prio(CFS2)):
> > rq0		rq1
> > CFS1		IDLE
> > 
> > When it should have selected:
> > rq0		r1
> > IDLE		RT
> > 
> > I saw this issue on real-world usecases in ChromeOS where an RT task gets
> > constantly force-idled and breaks RT. The "class == &fair_sched_class" bit
> > cures it.
> 
> Ah, I see. The thing is, this looses the optimization for a bunch of
> valid (and arguably common) scenarios. The problem is that the moment we
> end up selecting a task with a cookie we've invalidated the premise
> under which we ended up with the selected task.
> 
> How about this then?

This does look better. It makes sense and I think it will work. I will look
more into it and also test it.

BTW, as further optimization in the future, isn't it better for the
schedule() loop on 1 HT to select for all HT *even if* need_sync == false to
begin with?  i.e. no cookied tasks are runnable.

That way the pick loop in schedule() running on other HTs can directly pick
what was pre-selected for it via:
        if (rq->core->core_pick_seq == rq->core->core_task_seq &&
            rq->core->core_pick_seq != rq->core_sched_seq &&
            rq->core_pick)
.. which I think is more efficient. Its just a thought and may not be worth doing.

thanks,

 - Joel


> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4709,6 +4709,7 @@ pick_next_task(struct rq *rq, struct tas
>  	need_sync = !!rq->core->core_cookie;
> 
>  	/* reset state */
> +reset:
>  	rq->core->core_cookie = 0UL;
>  	for_each_cpu(i, smt_mask) {
>  		struct rq *rq_i = cpu_rq(i);
> @@ -4748,14 +4749,8 @@ pick_next_task(struct rq *rq, struct tas
>  				/*
>  				 * If there weren't no cookies; we don't need to
>  				 * bother with the other siblings.
> -				 * If the rest of the core is not running a tagged
> -				 * task, i.e.  need_sync == 0, and the current CPU
> -				 * which called into the schedule() loop does not
> -				 * have any tasks for this class, skip selecting for
> -				 * other siblings since there's no point. We don't skip
> -				 * for RT/DL because that could make CFS force-idle RT.
>  				 */
> -				if (i == cpu && !need_sync && !p->core_cookie)
> +				if (i == cpu && !need_sync)
>  					goto next_class;
> 
>  				continue;
> @@ -4765,7 +4760,17 @@ pick_next_task(struct rq *rq, struct tas
>  			 * Optimize the 'normal' case where there aren't any
>  			 * cookies and we don't need to sync up.
>  			 */
> -			if (i == cpu && !need_sync && !p->core_cookie) {
> +			if (i == cpu && !need_sync) {
> +				if (p->core_cookie) {
> +					/*
> +					 * This optimization is only valid as
> +					 * long as there are no cookies
> +					 * involved.
> +					 */
> +					need_sync = true;
> +					goto reset;
> +				}
> +
>  				next = p;
>  				goto done;
>  			}
> @@ -4805,7 +4810,6 @@ pick_next_task(struct rq *rq, struct tas
>  					 */
>  					need_sync = true;
>  				}
> -
>  			}
>  		}
>  next_class:;
> 
