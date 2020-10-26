Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F210B298974
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 10:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422438AbgJZJeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 05:34:16 -0400
Received: from merlin.infradead.org ([205.233.59.134]:44796 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1422404AbgJZJco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 05:32:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xYnqarQyNP/7EhsPbXj9UJ6ZEt6C1RbG7PPs0VREkdo=; b=oLVJlpWd2RutgV241i8hJEEJc7
        j4A9XYGev+VkLX3n0JOZ+m18veu5IR/iHL+TyB9pORUJAVtZj+FJULrxTj+5KQLNZTvmjjFkixIDU
        e5/Pb0xHfZop2kQ9lS+R9YVCuwyhzxYlaMBlEIgnofEfdTyZ1XjfeEoxxrGUjbuxROrQP49EOi387
        XsPqwVHKqSd5sXJafJgf22wga5WF3+ziDiWHAhHyYc92g5f5oju50vF2PtetAApdAKdZGB6atSwDS
        G3tL595WCTEtMyXGz+BBQ1AX5g26Z7xm32ck+Pv5v+eAmwW2Jr0dCFhd/miqaNg5jZWeNLYLHzScX
        EsaRQ97w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kWyqn-0001BG-NE; Mon, 26 Oct 2020 09:31:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 437243010D2;
        Mon, 26 Oct 2020 10:31:31 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 326C120325EC8; Mon, 26 Oct 2020 10:31:31 +0100 (CET)
Date:   Mon, 26 Oct 2020 10:31:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joel Fernandes <joel@joelfernandes.org>
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
Message-ID: <20201026093131.GF2628@hirez.programming.kicks-ass.net>
References: <20201020014336.2076526-1-joel@joelfernandes.org>
 <20201020014336.2076526-7-joel@joelfernandes.org>
 <20201023135129.GS2611@hirez.programming.kicks-ass.net>
 <20201023135400.GA2651@hirez.programming.kicks-ass.net>
 <20201023175724.GA3563800@google.com>
 <20201023192654.GH2974@worktop.programming.kicks-ass.net>
 <20201023213118.GD3563800@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201023213118.GD3563800@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 23, 2020 at 05:31:18PM -0400, Joel Fernandes wrote:
> On Fri, Oct 23, 2020 at 09:26:54PM +0200, Peter Zijlstra wrote:

> > How about this then?
> 
> This does look better. It makes sense and I think it will work. I will look
> more into it and also test it.

Hummm... Looking at it again I wonder if I can make something like the
below work.

(depends on the next patch that pulls core_forceidle into core-wide
state)

That would retain the CFS-cgroup optimization as well, for as long as
there's no cookies around.

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4691,8 +4691,6 @@ pick_next_task(struct rq *rq, struct tas
 		return next;
 	}
 
-	put_prev_task_balance(rq, prev, rf);
-
 	smt_mask = cpu_smt_mask(cpu);
 
 	/*
@@ -4707,14 +4705,25 @@ pick_next_task(struct rq *rq, struct tas
 	 */
 	rq->core->core_task_seq++;
 	need_sync = !!rq->core->core_cookie;
-
-	/* reset state */
-reset:
-	rq->core->core_cookie = 0UL;
 	if (rq->core->core_forceidle) {
 		need_sync = true;
 		rq->core->core_forceidle = false;
 	}
+
+	if (!need_sync) {
+		next = __pick_next_task(rq, prev, rf);
+		if (!next->core_cookie) {
+			rq->core_pick = NULL;
+			return next;
+		}
+		put_prev_task(next);
+		need_sync = true;
+	} else {
+		put_prev_task_balance(rq, prev, rf);
+	}
+
+	/* reset state */
+	rq->core->core_cookie = 0UL;
 	for_each_cpu(i, smt_mask) {
 		struct rq *rq_i = cpu_rq(i);
 
@@ -4744,35 +4752,8 @@ pick_next_task(struct rq *rq, struct tas
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
-					 * involved.
-					 */
-					need_sync = true;
-					goto reset;
-				}
-
-				next = p;
-				goto done;
-			}
 
 			rq_i->core_pick = p;
 
