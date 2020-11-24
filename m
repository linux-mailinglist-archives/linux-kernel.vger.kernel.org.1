Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0D972C2FF7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 19:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390924AbgKXSal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 13:30:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390718AbgKXSak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 13:30:40 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D59BC0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 10:30:40 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id ek7so11099074qvb.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 10:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qE+mlz7vaHNamyks+T6fnmjyxlDijK/IliQeVxUfJ7E=;
        b=WzZhpaNgLbsS4lgWNQRsvMsW1h6D7J+kWJi5NGJw9N4uQya5bMeDbRpayFRfuL91/i
         G3WPsygPujP32fX+VeEzR9GdDuCG1auM5NoIC7QYdZpB3J3vdSuYa4FWG62A2NzV/aju
         3TuG2u05XBVPNMs4PY8IvTuZAMm0Tsipdy4F0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qE+mlz7vaHNamyks+T6fnmjyxlDijK/IliQeVxUfJ7E=;
        b=o4cDyU/UT7iXi5niIZyvDXDUxjSNO+SN6jzk5Px3DoSlK3DqHo1+sCHkx2CC3orZyh
         W6ZJ5lx8mhpf6QQEG7uUx/cdrlkWfw5TAg2D7wKDmqM1awc9wDyIwJBqdDnZeifSRYEQ
         KL1Wb+weZ1kB9aisqBg1LbJr4mYK2bHU7OJ3SvSSpS5G2QFR+pQgIA8RSMFQvOA5a8ee
         AX10GzZ1PyvhsoM/ZbFRRz9LTav1D7Kiip50n0HcTGNpBL60blzXRgvdq19R5EtKMW5z
         /pFFUlwcYQhh5IQmgOQ22acfrvYHwjBH42tRRsFPpQrSk7ldLxyLZR7TPcuCSHugkHFN
         iqmA==
X-Gm-Message-State: AOAM531+P0A18sLpufgF0crMMB9mLtIlsxZhvX0VJM+XF8jL9OU9K9eu
        dJjZorHKNfwG2H7lkZD0JF1MMIyfyyuAcQ==
X-Google-Smtp-Source: ABdhPJyv5aFhmhLQOrN+O7tia+0mwM3cnfR0tlCavpeZATU7GOwqY41pjwmceBKFe5b5YbAANt3P5A==
X-Received: by 2002:ad4:5b82:: with SMTP id 2mr6128551qvp.28.1606242639558;
        Tue, 24 Nov 2020 10:30:39 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id x24sm13193330qkx.23.2020.11.24.10.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 10:30:38 -0800 (PST)
Date:   Tue, 24 Nov 2020 13:30:38 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Balbir Singh <bsingharora@gmail.com>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
        chris.hyser@oracle.com, Ben Segall <bsegall@google.com>,
        Josh Don <joshdon@google.com>, Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
Subject: Re: [PATCH -tip 10/32] sched: Fix priority inversion of cookied task
 with sibling
Message-ID: <20201124183038.GG1021337@google.com>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-11-joel@joelfernandes.org>
 <20201122224123.GE110669@balbir-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201122224123.GE110669@balbir-desktop>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 09:41:23AM +1100, Balbir Singh wrote:
> On Tue, Nov 17, 2020 at 06:19:40PM -0500, Joel Fernandes (Google) wrote:
> > From: Peter Zijlstra <peterz@infradead.org>
> > 
> > The rationale is as follows. In the core-wide pick logic, even if
> > need_sync == false, we need to go look at other CPUs (non-local CPUs) to
> > see if they could be running RT.
> > 
> > Say the RQs in a particular core look like this:
> > Let CFS1 and CFS2 be 2 tagged CFS tags. Let RT1 be an untagged RT task.
> > 
> > rq0            rq1
> > CFS1 (tagged)  RT1 (not tag)
> > CFS2 (tagged)
> > 
> > Say schedule() runs on rq0. Now, it will enter the above loop and
> > pick_task(RT) will return NULL for 'p'. It will enter the above if() block
> > and see that need_sync == false and will skip RT entirely.
> > 
> > The end result of the selection will be (say prio(CFS1) > prio(CFS2)):
> > rq0             rq1
> > CFS1            IDLE
> > 
> > When it should have selected:
> > rq0             r1
> > IDLE            RT
> > 
> > Joel saw this issue on real-world usecases in ChromeOS where an RT task
> > gets constantly force-idled and breaks RT. Lets cure it.
> > 
> > NOTE: This problem will be fixed differently in a later patch. It just
> >       kept here for reference purposes about this issue, and to make
> >       applying later patches easier.
> >
> 
> The changelog is hard to read, it refers to above if(), whereas there
> is no code snippet in the changelog.

Yeah sorry, it comes from this email where I described the issue:
http://lore.kernel.org/r/20201023175724.GA3563800@google.com

I corrected the changelog and appended the patch below. Also pushed it to:
https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git/log/?h=coresched

> Also, from what I can see following
> the series, p->core_cookie is not yet set anywhere (unless I missed it),
> so fixing it in here did not make sense just reading the series.

The interface patches for core_cookie are added later, that's how it is. The
infrastructure comes first here. It would also not make sense to add
interface first as well so I think the current ordering is fine.

---8<-----------------------

From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] sched: Fix priority inversion of cookied task with sibling

The rationale is as follows. In the core-wide pick logic, even if
need_sync == false, we need to go look at other CPUs (non-local CPUs) to
see if they could be running RT.

Say the RQs in a particular core look like this:
Let CFS1 and CFS2 be 2 tagged CFS tags. Let RT1 be an untagged RT task.

rq0            rq1
CFS1 (tagged)  RT1 (not tag)
CFS2 (tagged)

The end result of the selection will be (say prio(CFS1) > prio(CFS2)):
rq0             rq1
CFS1            IDLE

When it should have selected:
rq0             r1
IDLE            RT

Fix this issue by forcing need_sync and restarting the search if a
cookied task was discovered. This will avoid this optimization from
making incorrect picks.

Joel saw this issue on real-world usecases in ChromeOS where an RT task
gets constantly force-idled and breaks RT. Lets cure it.

NOTE: This problem will be fixed differently in a later patch. It just
      kept here for reference purposes about this issue, and to make
      applying later patches easier.

Reported-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/sched/core.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 4ee4902c2cf5..53af817740c0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5195,6 +5195,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	need_sync = !!rq->core->core_cookie;
 
 	/* reset state */
+reset:
 	rq->core->core_cookie = 0UL;
 	if (rq->core->core_forceidle) {
 		need_sync = true;
@@ -5242,14 +5243,8 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
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
-				if (i == cpu && !need_sync && class == &fair_sched_class)
+				if (i == cpu && !need_sync)
 					goto next_class;
 
 				continue;
@@ -5259,7 +5254,20 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 			 * Optimize the 'normal' case where there aren't any
 			 * cookies and we don't need to sync up.
 			 */
-			if (i == cpu && !need_sync && !p->core_cookie) {
+			if (i == cpu && !need_sync) {
+				if (p->core_cookie) {
+					/*
+					 * This optimization is only valid as
+					 * long as there are no cookies
+					 * involved. We may have skipped
+					 * non-empty higher priority classes on
+					 * siblings, which are empty on this
+					 * CPU, so start over.
+					 */
+					need_sync = true;
+					goto reset;
+				}
+
 				next = p;
 				goto done;
 			}
@@ -5299,7 +5307,6 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 					 */
 					need_sync = true;
 				}
-
 			}
 		}
 next_class:;
-- 
2.29.2.454.gaff20da3a2-goog

