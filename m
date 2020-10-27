Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E41BE29B6D1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 16:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1798435AbgJ0P05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 11:26:57 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37754 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1797514AbgJ0PYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 11:24:02 -0400
Received: by mail-qk1-f193.google.com with SMTP id z6so1505168qkz.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 08:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=3nqmBr114b5okwA5k9uJ1vPAHLO8H+vfANJqklNrSXc=;
        b=W8fpvPAsouN9KFKzgaMm8VBgkDik6zlqV13MYNlrVrK3HAp3tYCLHxcxqUJj0lVxif
         cAsVXdk7UnD3BPEwzcNudKGPTKlY8mkXc2YyDymjZ/5kGX3uomCtxh+VYLx8HuqS777J
         TPDT3MVwpELX5LL3FcHC3hS6i1Gzjb+XN42j4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=3nqmBr114b5okwA5k9uJ1vPAHLO8H+vfANJqklNrSXc=;
        b=Dy0fYk1yATwuhNDHCMcw/hmVuqP23OVEgbjHJ7WT/yasN57YTHLznSyEaobH3HOfIN
         Mh0ETSlbVoqKRf2R7cWzFN74cpx2/wxs1HSk/9NBh2Dq8nlcjFHhurLj6g2PztLB0+s0
         axYBaN8nCPCcP1mMVQoO2BJ8wFJ5zVvrh0In5fURkyD8fycG21HWN24wQgTw6tLF7acE
         2y9SPAE7R5c+syf5m42d87gJCT66uDQjmDPHsTDzpsEedaALPbGRjE45oQC6Dl4/s3yv
         hj5jFvjoTqENvSOdjeIdg5v3CCxFQoMZzNuzmkKG+7Ep2W2UGbydvxX/okNTmJXMAOaj
         /FaA==
X-Gm-Message-State: AOAM533aY//fXm8a3khCeJNfEnaH+sOwXDLPNq8WqzglFYoJi59zm5w0
        BsR3z1zFlWryyfr8fvkB7Q4wGg==
X-Google-Smtp-Source: ABdhPJzvQrk6vYYAgnRLYsMsqADTgHAh9Ctl6Y/bVrZssoHuefZ9zu2fAlGS08sOtdEALL+okmfsVQ==
X-Received: by 2002:a05:620a:1024:: with SMTP id a4mr2724731qkk.390.1603812240213;
        Tue, 27 Oct 2020 08:24:00 -0700 (PDT)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id q188sm896644qka.56.2020.10.27.08.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 08:23:59 -0700 (PDT)
Date:   Tue, 27 Oct 2020 11:23:58 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Vineeth Pillai <viremana@linux.microsoft.com>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Thomas Glexiner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
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
        graf@amazon.com, konrad.wilk@oracle.com,
        Dario Faggioli <dfaggioli@suse.com>,
        Paul Turner <pjt@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Patrick Bellasi <derkling@google.com>,
        =?utf-8?B?YmVuYmppYW5nKOiSi+W9qik=?= <benbjiang@tencent.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>,
        "Ning, Hongyu" <hongyu.ning@linux.intel.com>
Subject: Re: [PATCH v8 -tip 02/26] sched: Introduce sched_class::pick_task()
Message-ID: <20201027152358.GA929302@google.com>
References: <20201020014336.2076526-3-joel@joelfernandes.org>
 <8ea1aa61-4a1c-2687-9f15-1062d37606c7@linux.intel.com>
 <CAEXW_YT-pKJiA-APEtJv9QuyoYB0wNrH3EbAyc=3dwMfav+F6Q@mail.gmail.com>
 <a2b66294-6a66-b5c1-7706-29bc92f416f5@linux.intel.com>
 <20201023214702.GA3603399@google.com>
 <d9a70e58-f424-3957-9957-b89071480005@linux.intel.com>
 <4241e5ac-ecdf-8634-fa0d-dd6759e477e1@linux.microsoft.com>
 <8230ada7-839f-2335-9a55-b09f6a813e91@linux.microsoft.com>
 <20201026090131.GE2628@hirez.programming.kicks-ass.net>
 <20201027141911.GC771372@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201027141911.GC771372@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 10:19:11AM -0400, Joel Fernandes wrote:
> On Mon, Oct 26, 2020 at 10:01:31AM +0100, Peter Zijlstra wrote:
> > On Sat, Oct 24, 2020 at 08:27:16AM -0400, Vineeth Pillai wrote:
> > > 
> > > 
> > > On 10/24/20 7:10 AM, Vineeth Pillai wrote:
> > > > 
> > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > > index 93a3b874077d..4cae5ac48b60 100644
> > > > --- a/kernel/sched/fair.c
> > > > +++ b/kernel/sched/fair.c
> > > > @@ -4428,12 +4428,14 @@ pick_next_entity(struct cfs_rq *cfs_rq, struct
> > > > sched_entity *curr)
> > > >                         se = second;
> > > >         }
> > > > 
> > > > -       if (cfs_rq->next && wakeup_preempt_entity(cfs_rq->next, left) <
> > > > 1) {
> > > > +       if (left && cfs_rq->next &&
> > > > +                       wakeup_preempt_entity(cfs_rq->next, left) < 1) {
> > > >                 /*
> > > >                  * Someone really wants this to run. If it's not unfair,
> > > > run it.
> > > >                  */
> > > >                 se = cfs_rq->next;
> > > > -       } else if (cfs_rq->last && wakeup_preempt_entity(cfs_rq->last,
> > > > left) < 1) {
> > > > +       } else if (left && cfs_rq->last &&
> > > > +                       wakeup_preempt_entity(cfs_rq->last, left) < 1) {
> > > >                 /*
> > > >                  * Prefer last buddy, try to return the CPU to a
> > > > preempted task.
> > > > 
> > > > 
> > > > There reason for left being NULL needs to be investigated. This was
> > > > there from v1 and we did not yet get to it. I shall try to debug later
> > > > this week.
> > > 
> > > Thinking more about it and looking at the crash, I think that
> > > 'left == NULL' can happen in pick_next_entity for core scheduling.
> > > If a cfs_rq has only one task that is running, then it will be
> > > dequeued and 'left = __pick_first_entity()' will be NULL as the
> > > cfs_rq will be empty. This would not happen outside of coresched
> > > because we never call pick_tack() before put_prev_task() which
> > > will enqueue the task back.
> > > 
> > > With core scheduling, a cpu can call pick_task() for its sibling while
> > > the sibling is still running the active task and put_prev_task has yet
> > > not been called. This can result in 'left == NULL'.
> > 
> > Quite correct. Hurmph.. the reason we do this is because... we do the
> > update_curr() the wrong way around. And I can't seem to remember why we
> > do that (it was in my original patches).
> > 
> > Something like so seems the obvious thing to do, but I can't seem to
> > remember why we're not doing it :-(
> 
> The code below is just a refactor and not a functional change though, right?
> 
> i.e. pick_next_entity() is already returning se = curr, if se == NULL.
> 
> But the advantage of your refactor is it doesn't crash the kernel.
> 
> So your change appears safe to me unless I missed something.

I included it as patch appeneded below for testing, hopefully the commit
message is appropriate.

On a related note, this pattern is very similar to pick_next_task_fair()'s
!simple case. Over there it does check_cfs_rq_runtime() for throttling the
cfs_rq.  Should we also be doing that in pick_task_fair() ?
This bit:
                        /*
                         * This call to check_cfs_rq_runtime() will do the
                         * throttle and dequeue its entity in the parent(s).
                         * Therefore the nr_running test will indeed
                         * be correct.
                         */
                        if (unlikely(check_cfs_rq_runtime(cfs_rq))) {
                                cfs_rq = &rq->cfs;

                                if (!cfs_rq->nr_running)
                                        goto idle;

                                goto simple;
                        }

---8<-----------------------

From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] sched/fair: Fix pick_task_fair crashes due to empty rbtree

pick_next_entity() is passed curr == NULL during core-scheduling. Due to
this, if the rbtree is empty, the 'left' variable is set to NULL within
the function. This can cause crashes within the function.

This is not an issue if put_prev_task() is invoked on the currently
running task before calling pick_next_entity(). However, in core
scheduling, it is possible that a sibling CPU picks for another RQ in
the core, via pick_task_fair(). This remote sibling would not get any
opportunities to do a put_prev_task().

Fix it by refactoring pick_task_fair() such that pick_next_entity() is
called with the cfs_rq->curr. This will prevent pick_next_entity() from
crashing if its rbtree is empty.

Suggested-by: Vineeth Remanan Pillai <viremana@linux.microsoft.com>
Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/sched/fair.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 93a3b874077d..591859016263 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6975,15 +6975,10 @@ static struct task_struct *pick_task_fair(struct rq *rq)
 	do {
 		struct sched_entity *curr = cfs_rq->curr;
 
-		se = pick_next_entity(cfs_rq, NULL);
-
-		if (curr) {
-			if (se && curr->on_rq)
-				update_curr(cfs_rq);
+		if (curr && curr->on_rq)
+			update_curr(cfs_rq);
 
-			if (!se || entity_before(curr, se))
-				se = curr;
-		}
+		se = pick_next_entity(cfs_rq, curr);
 
 		cfs_rq = group_cfs_rq(se);
 	} while (cfs_rq);
-- 
2.29.0.rc2.309.g374f81d7ae-goog

