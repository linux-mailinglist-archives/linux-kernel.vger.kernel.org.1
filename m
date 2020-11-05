Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31B382A8988
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 23:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732495AbgKEWHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 17:07:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732295AbgKEWHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 17:07:45 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA7EC0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 14:07:45 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id f93so2288980qtb.10
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 14:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hPm+y961bfqbZOkNogoU0d9pQKUiaw2qg1d2MxvKSPI=;
        b=vN+tPcj3YsxO9AGsCgwPslkHx4Dze80O3pQkqN4vlI8guljm52XgXWIXJBGHuYzSa/
         rWxSGbd6QfbKbXDhOCiQFyz+XFGQxxbPLXRiRz6JoI/VJi/E9DXS0WbPRGyztwI+ngvL
         HuA8L/SACiqt1+ONEEvh5n+rxTeEi2TeqsXwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hPm+y961bfqbZOkNogoU0d9pQKUiaw2qg1d2MxvKSPI=;
        b=Fr5PzZpYl7VD4vx6haMYLrEtvOIBd7PKv0+eG3RQCReLVuLlX6pfTBk5csrZJ5470u
         2oR2cRQbN2nI5LZsqfM5kmG2Qd0qeRdnJsO3+2Hkph0Pan9uQy1wD3p/W/UBiVeP7HtH
         fKWtGGagCRndBWorHj99UB3SKvyUFnz6IUFEmct4ANWECqeooYbpSWpU6o6ydz+h85XY
         O4JjBEFBUtfmhq4DxHil/gFs744zdyNX5SZ9fFYPGfhcIMjH+djDdgaLs8/nYkz0e7EY
         SfktGfpOQmysVc7LUv4UGkdUeKbQXSoVBEEKa5WT3iTbDRvZmPyYobrdQ2UHpezXeiVy
         KZDQ==
X-Gm-Message-State: AOAM532o/V/KX53Kt1FPYEh1JsyBDSvLLNIRlwO65z2ZCzw1qUW6LBwi
        iyCSWDTgKDjLBb4Y9JILWrOniw==
X-Google-Smtp-Source: ABdhPJxIrXYdrlZ8wNnrP7wL+UzHFa8E7Xc7cDZyluAJPWN0n8FoGI1HxkdtSc2pNaUVfXaf9eFjCg==
X-Received: by 2002:ac8:7391:: with SMTP id t17mr3914510qtp.289.1604614064864;
        Thu, 05 Nov 2020 14:07:44 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id l16sm1761827qtr.21.2020.11.05.14.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 14:07:43 -0800 (PST)
Date:   Thu, 5 Nov 2020 17:07:43 -0500
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
        Tim Chen <tim.c.chen@intel.com>
Subject: Re: [PATCH v8 -tip 06/26] sched: Add core wide task selection and
 scheduling.
Message-ID: <20201105220743.GD2656962@google.com>
References: <20201020014336.2076526-1-joel@joelfernandes.org>
 <20201020014336.2076526-7-joel@joelfernandes.org>
 <20201023135129.GS2611@hirez.programming.kicks-ass.net>
 <20201023135400.GA2651@hirez.programming.kicks-ass.net>
 <20201023175724.GA3563800@google.com>
 <20201023192654.GH2974@worktop.programming.kicks-ass.net>
 <20201023213118.GD3563800@google.com>
 <20201026093131.GF2628@hirez.programming.kicks-ass.net>
 <20201105185019.GA2771003@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105185019.GA2771003@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 05, 2020 at 01:50:19PM -0500, Joel Fernandes wrote:
> On Mon, Oct 26, 2020 at 10:31:31AM +0100, Peter Zijlstra wrote:
> > On Fri, Oct 23, 2020 at 05:31:18PM -0400, Joel Fernandes wrote:
> > > On Fri, Oct 23, 2020 at 09:26:54PM +0200, Peter Zijlstra wrote:
> > 
> > > > How about this then?
> > > 
> > > This does look better. It makes sense and I think it will work. I will look
> > > more into it and also test it.
> > 
> > Hummm... Looking at it again I wonder if I can make something like the
> > below work.
> > 
> > (depends on the next patch that pulls core_forceidle into core-wide
> > state)
> > 
> > That would retain the CFS-cgroup optimization as well, for as long as
> > there's no cookies around.
> > 
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -4691,8 +4691,6 @@ pick_next_task(struct rq *rq, struct tas
> >  		return next;
> >  	}
> >  
> > -	put_prev_task_balance(rq, prev, rf);
> > -
> >  	smt_mask = cpu_smt_mask(cpu);
> >  
> >  	/*
> > @@ -4707,14 +4705,25 @@ pick_next_task(struct rq *rq, struct tas
> >  	 */
> >  	rq->core->core_task_seq++;
> >  	need_sync = !!rq->core->core_cookie;
> > -
> > -	/* reset state */
> > -reset:
> > -	rq->core->core_cookie = 0UL;
> >  	if (rq->core->core_forceidle) {
> >  		need_sync = true;
> >  		rq->core->core_forceidle = false;
> >  	}
> > +
> > +	if (!need_sync) {
> > +		next = __pick_next_task(rq, prev, rf);
> 
> This could end up triggering pick_next_task_fair's newidle balancing;
> 
> > +		if (!next->core_cookie) {
> > +			rq->core_pick = NULL;
> > +			return next;
> > +		}
> 
> .. only to realize here that pick_next_task_fair() that we have to put_prev
> the task back as it has a cookie, but the effect of newidle balancing cannot
> be reverted.
> 
> Would that be a problem as the newly pulled task might be incompatible and
> would have been better to leave it alone?
> 
> TBH, this is a drastic change and we've done a lot of testing with the
> current code and its looking good. I'm a little scared of changing it right
> now and introducing regression. Can we maybe do this after the existing
> patches are upstream?

After sleeping over it, I am trying something like the following. Thoughts?

Basically, I call pick_task() in advance. That's mostly all that's different
with your patch:

---8<-----------------------

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0ce17aa72694..366e5ed84a63 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5000,28 +5000,34 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	put_prev_task_balance(rq, prev, rf);
 
 	smt_mask = cpu_smt_mask(cpu);
-
-	/*
-	 * core->core_task_seq, core->core_pick_seq, rq->core_sched_seq
-	 *
-	 * @task_seq guards the task state ({en,de}queues)
-	 * @pick_seq is the @task_seq we did a selection on
-	 * @sched_seq is the @pick_seq we scheduled
-	 *
-	 * However, preemptions can cause multiple picks on the same task set.
-	 * 'Fix' this by also increasing @task_seq for every pick.
-	 */
-	rq->core->core_task_seq++;
 	need_sync = !!rq->core->core_cookie;
 
 	/* reset state */
-reset:
 	rq->core->core_cookie = 0UL;
 	if (rq->core->core_forceidle) {
 		need_sync = true;
 		fi_before = true;
 		rq->core->core_forceidle = false;
 	}
+
+	/*
+	 * Optimize for common case where this CPU has no cookies
+	 * and there are no cookied tasks running on siblings.
+	 */
+	if (!need_sync) {
+		for_each_class(class) {
+			next = class->pick_task(rq);
+			if (next)
+				break;
+		}
+
+		if (!next->core_cookie) {
+			rq->core_pick = NULL;
+			goto done;
+		}
+		need_sync = true;
+	}
+
 	for_each_cpu(i, smt_mask) {
 		struct rq *rq_i = cpu_rq(i);
 
@@ -5039,6 +5045,18 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 		}
 	}
 
+	/*
+	 * core->core_task_seq, core->core_pick_seq, rq->core_sched_seq
+	 *
+	 * @task_seq guards the task state ({en,de}queues)
+	 * @pick_seq is the @task_seq we did a selection on
+	 * @sched_seq is the @pick_seq we scheduled
+	 *
+	 * However, preemptions can cause multiple picks on the same task set.
+	 * 'Fix' this by also increasing @task_seq for every pick.
+	 */
+	rq->core->core_task_seq++;
+
 	/*
 	 * Try and select tasks for each sibling in decending sched_class
 	 * order.
@@ -5059,40 +5077,8 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 			 * core.
 			 */
 			p = pick_task(rq_i, class, max);
-			if (!p) {
-				/*
-				 * If there weren't no cookies; we don't need to
-				 * bother with the other siblings.
-				 */
-				if (i == cpu && !need_sync)
-					goto next_class;
-
+			if (!p)
 				continue;
-			}
-
-			/*
-			 * Optimize the 'normal' case where there aren't any
-			 * cookies and we don't need to sync up.
-			 */
-			if (i == cpu && !need_sync) {
-				if (p->core_cookie) {
-					/*
-					 * This optimization is only valid as
-					 * long as there are no cookies
-					 * involved. We may have skipped
-					 * non-empty higher priority classes on
-					 * siblings, which are empty on this
-					 * CPU, so start over.
-					 */
-					need_sync = true;
-					goto reset;
-				}
-
-				next = p;
-				trace_printk("unconstrained pick: %s/%d %lx\n",
-					     next->comm, next->pid, next->core_cookie);
-				goto done;
-			}
 
 			if (!is_task_rq_idle(p))
 				occ++;
