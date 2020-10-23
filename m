Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97E4B2977C1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 21:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753853AbgJWT2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 15:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750070AbgJWT2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 15:28:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3392C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 12:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SMzYJ4HmuSwXSTmcc18Yf6TgQ0PU6jqXVbmfJ9VGFWo=; b=WP5vCew0NONWkSMzdkjdtkcr4T
        Vhq55eHkYhRojxEiiX2qq5kBMBcsxKs2PzLHw76oGOhBrEike/fffyASZPpcTPhaxTgajgi3ySwGE
        59BzJTi2Qm3yv81iS/cVXLaR3cnKsWnB0xF9NfIG/WqcizZ8/nqxlpKvUnkjjdZmb9loNIeHS2si5
        Cp/ImFhyWeEWVJlcV4S6SrVrSZhz5o5UUJ9qarpPibHi856rRrQqGCVAOLMBzK8l/CuI/bvqQnWwe
        nlpoTAK5T4UWOJYi8WoqgNaX6b1uaoY5hqtL9E3FXXv5i5W1Uw3IELyn0Eid9eMkASePcADwC2G2W
        LZcpmnKw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kW2iG-0003pH-7N; Fri, 23 Oct 2020 19:26:56 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id C674F98104F; Fri, 23 Oct 2020 21:26:54 +0200 (CEST)
Date:   Fri, 23 Oct 2020 21:26:54 +0200
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
Message-ID: <20201023192654.GH2974@worktop.programming.kicks-ass.net>
References: <20201020014336.2076526-1-joel@joelfernandes.org>
 <20201020014336.2076526-7-joel@joelfernandes.org>
 <20201023135129.GS2611@hirez.programming.kicks-ass.net>
 <20201023135400.GA2651@hirez.programming.kicks-ass.net>
 <20201023175724.GA3563800@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201023175724.GA3563800@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 23, 2020 at 01:57:24PM -0400, Joel Fernandes wrote:
> On Fri, Oct 23, 2020 at 03:54:00PM +0200, Peter Zijlstra wrote:
> > On Fri, Oct 23, 2020 at 03:51:29PM +0200, Peter Zijlstra wrote:
> > > On Mon, Oct 19, 2020 at 09:43:16PM -0400, Joel Fernandes (Google) wrote:
> > > > +			/*
> > > > +			 * If this sibling doesn't yet have a suitable task to
> > > > +			 * run; ask for the most elegible task, given the
> > > > +			 * highest priority task already selected for this
> > > > +			 * core.
> > > > +			 */
> > > > +			p = pick_task(rq_i, class, max);
> > > > +			if (!p) {
> > > > +				/*
> > > > +				 * If there weren't no cookies; we don't need to
> > > > +				 * bother with the other siblings.
> > > > +				 * If the rest of the core is not running a tagged
> > > > +				 * task, i.e.  need_sync == 0, and the current CPU
> > > > +				 * which called into the schedule() loop does not
> > > > +				 * have any tasks for this class, skip selecting for
> > > > +				 * other siblings since there's no point. We don't skip
> > > > +				 * for RT/DL because that could make CFS force-idle RT.
> > > > +				 */
> > > > +				if (i == cpu && !need_sync && class == &fair_sched_class)
> > > > +					goto next_class;
> > > > +
> > > > +				continue;
> > > > +			}
> > > 
> > > I'm failing to understand the class == &fair_sched_class bit.
> 
> The last line in the comment explains it "We don't skip for RT/DL because
> that could make CFS force-idle RT.".

Well, yes, but it does not explain how this can come about, now does it.

> Even if need_sync == false, we need to go look at other CPUs (non-local
> CPUs) to see if they could be running RT.
> 
> Say the RQs in a particular core look like this:
> Let CFS1 and CFS2 be 2 tagged CFS tags. Let RT1 be an untagged RT task.
> 
> rq0	       rq1
> CFS1 (tagged)  RT1 (not tag)
> CFS2 (tagged)
> 
> Say schedule() runs on rq0. Now, it will enter the above loop and
> pick_task(RT) will return NULL for 'p'. It will enter the above if() block
> and see that need_sync == false and will skip RT entirely.
> 
> The end result of the selection will be (say prio(CFS1) > prio(CFS2)):
> rq0		rq1
> CFS1		IDLE
> 
> When it should have selected:
> rq0		r1
> IDLE		RT
> 
> I saw this issue on real-world usecases in ChromeOS where an RT task gets
> constantly force-idled and breaks RT. The "class == &fair_sched_class" bit
> cures it.

Ah, I see. The thing is, this looses the optimization for a bunch of
valid (and arguably common) scenarios. The problem is that the moment we
end up selecting a task with a cookie we've invalidated the premise
under which we ended up with the selected task.

How about this then?

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4709,6 +4709,7 @@ pick_next_task(struct rq *rq, struct tas
 	need_sync = !!rq->core->core_cookie;

 	/* reset state */
+reset:
 	rq->core->core_cookie = 0UL;
 	for_each_cpu(i, smt_mask) {
 		struct rq *rq_i = cpu_rq(i);
@@ -4748,14 +4749,8 @@ pick_next_task(struct rq *rq, struct tas
 				/*
 				 * If there weren't no cookies; we don't need to
 				 * bother with the other siblings.
-				 * If the rest of the core is not running a tagged
-				 * task, i.e.  need_sync == 0, and the current CPU
-				 * which called into the schedule() loop does not
-				 * have any tasks for this class, skip selecting for
-				 * other siblings since there's no point. We don't skip
-				 * for RT/DL because that could make CFS force-idle RT.
 				 */
-				if (i == cpu && !need_sync && !p->core_cookie)
+				if (i == cpu && !need_sync)
 					goto next_class;

 				continue;
@@ -4765,7 +4760,17 @@ pick_next_task(struct rq *rq, struct tas
 			 * Optimize the 'normal' case where there aren't any
 			 * cookies and we don't need to sync up.
 			 */
-			if (i == cpu && !need_sync && !p->core_cookie) {
+			if (i == cpu && !need_sync) {
+				if (p->core_cookie) {
+					/*
+					 * This optimization is only valid as
+					 * long as there are no cookies
+					 * involved.
+					 */
+					need_sync = true;
+					goto reset;
+				}
+
 				next = p;
 				goto done;
 			}
@@ -4805,7 +4810,6 @@ pick_next_task(struct rq *rq, struct tas
 					 */
 					need_sync = true;
 				}
-
 			}
 		}
 next_class:;

