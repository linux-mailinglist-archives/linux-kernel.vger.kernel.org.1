Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCCD02C50E9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 10:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389147AbgKZJIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 04:08:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389036AbgKZJId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 04:08:33 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7767EC0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 01:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2zXA8xrVRXPGgqB9cMk3pA+Z8nviwDoJP0B7lI7X6RU=; b=VEwDua+o40NYyE2dEiASgNcM1n
        Prr3FJf0uYJodu1QlSxpdqmB7nB5Mo6+Svjv5cNNjMxq4pVGPNGWRAg+wUqI+iP3J4bg6WeW7cZsd
        e4HLiuwjAWT0YRGkMdgblo3zH6otgS0weiEigKES7HkIIzDrYI4mAXE9aJr8eJqXaUaDQW2GtsX+a
        ldiVdCs8CPNDhw/GUgpApOPUccwRDdZUwbGdKCl/zjthdO785o0DPJFZ5Acle7mcmd3B6JswNWI1U
        t4G3oofD2QlQwor6rQRWvMBSgYXF5p0uR5O44XRHhE7wLFPwzGeHuqiz/dSi2Vdhjbdc2/qLaY4tP
        4eL3aY/Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kiDFB-0005yJ-Uk; Thu, 26 Nov 2020 09:07:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 73F393059DE;
        Thu, 26 Nov 2020 10:07:10 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 414A32CF9A1E7; Thu, 26 Nov 2020 10:07:10 +0100 (CET)
Date:   Thu, 26 Nov 2020 10:07:10 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        Paul Turner <pjt@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Patrick Bellasi <derkling@google.com>,
        Jiang Biao <benbjiang@tencent.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        OWeisse@umich.edu, Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>, jsbarnes@google.com,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Ben Segall <bsegall@google.com>, Josh Don <joshdon@google.com>,
        Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
Subject: Re: [PATCH -tip 02/32] sched: Introduce sched_class::pick_task()
Message-ID: <20201126090710.GF2414@hirez.programming.kicks-ass.net>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-3-joel@joelfernandes.org>
 <CAKfTPtDSnr85X90gpPvgOf94Adh_mvH2CGhkXXx4FHn6EkCErg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtDSnr85X90gpPvgOf94Adh_mvH2CGhkXXx4FHn6EkCErg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 05:28:36PM +0100, Vincent Guittot wrote:
> On Wed, 18 Nov 2020 at 00:20, Joel Fernandes (Google)

> > +#ifdef CONFIG_SMP
> > +static struct task_struct *pick_task_fair(struct rq *rq)
> > +{
> > +       struct cfs_rq *cfs_rq = &rq->cfs;
> > +       struct sched_entity *se;
> > +
> > +       if (!cfs_rq->nr_running)
> > +               return NULL;
> > +
> > +       do {
> > +               struct sched_entity *curr = cfs_rq->curr;
> > +
> > +               se = pick_next_entity(cfs_rq, NULL);
> 
> Calling pick_next_entity clears buddies. This is fine without
> coresched because the se will be the next one. But calling
> pick_task_fair doesn't mean that the se will be used

Urgh, nice one :/

> > +
> > +               if (curr) {
> > +                       if (se && curr->on_rq)
> > +                               update_curr(cfs_rq);
> > +
> 
> Shouldn't you check if cfs_rq is throttled ?

Hmm,... I suppose we do.

> > +                       if (!se || entity_before(curr, se))
> > +                               se = curr;
> > +               }
> > +
> > +               cfs_rq = group_cfs_rq(se);
> > +       } while (cfs_rq);
> > +
> > +       return task_of(se);
> > +}
> > +#endif

Something like so then?

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4354,6 +4354,8 @@ check_preempt_tick(struct cfs_rq *cfs_rq
 static void
 set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
+	clear_buddies(cfs_rq, se);
+
 	/* 'current' is not kept within the tree. */
 	if (se->on_rq) {
 		/*
@@ -4440,8 +4442,6 @@ pick_next_entity(struct cfs_rq *cfs_rq,
 		se = cfs_rq->last;
 	}
 
-	clear_buddies(cfs_rq, se);
-
 	return se;
 }
 
@@ -6982,20 +6982,29 @@ static void check_preempt_wakeup(struct
 #ifdef CONFIG_SMP
 static struct task_struct *pick_task_fair(struct rq *rq)
 {
-	struct cfs_rq *cfs_rq = &rq->cfs;
 	struct sched_entity *se;
-
+	struct cfs_rq *cfs_rq;
+       
+again:
+	cfs_rq = &rq->cfs;
 	if (!cfs_rq->nr_running)
 		return NULL;
 
 	do {
 		struct sched_entity *curr = cfs_rq->curr;
 
-		if (curr && curr->on_rq)
-			update_curr(cfs_rq);
+		/* When we pick for a remote RQ, we'll not have done put_prev_entity() */
+		if (curr) {
+			if (curr->on_rq)
+				update_curr(cfs_rq);
+			else
+				curr = NULL;
 
-		se = pick_next_entity(cfs_rq, curr);
+			if (unlikely(check_cfs_rq_runtime(cfs_rq)))
+				goto again;
+		}
 
+		se = pick_next_entity(cfs_rq, curr);
 		cfs_rq = group_cfs_rq(se);
 	} while (cfs_rq);
 
