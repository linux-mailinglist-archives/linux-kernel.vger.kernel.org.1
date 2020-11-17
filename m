Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9682B7223
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 00:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728814AbgKQXUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 18:20:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728757AbgKQXUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 18:20:34 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7A0C0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 15:20:34 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id n132so50728qke.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 15:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2B+7I+GkvlqccJMxOn9O78ObTrnDCHzQYPn7mfVNg6M=;
        b=hTtHrI8fmDAY3YGXUTbuUG0Vda4EDFKODdogbm8FXj1vHBu6rRcvIP7a4UnqFQYfnJ
         RValtr5HrQxx4rAOM5quz+MMufdVeJgUWyhnkwCCMMNUyIA9MuoRKaHVho6gqrXO3voY
         IYlILCzyEqHxS3UPPFn4+TeswRgSERbSUvyXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2B+7I+GkvlqccJMxOn9O78ObTrnDCHzQYPn7mfVNg6M=;
        b=a4UcaPv9UR+3bjcWim6AZMu9Jv7X3jdsLfRZSHqbjZZe5H0mjPZQYUgSaW7OoDHpkI
         mNPGgEkOVq8bUNnYuy/5/VgyoqxDzQ03VE0Hw9zIl6rv+i9qj4KJQRv838zPdaRdyMiU
         PhUF43nRBmd7wMN+7+IZc7UnCGRa/pNit5FghnzO9EOINqivcICTy2gAk1SC00iL8O09
         0yO4asQUHOtfGCD/f+xToALh+Z3SjBJNiNolTliiMM2UTgQIAV6vaPKGeYEz01O2oTUK
         pvSIOl5IuYMwT+12BWIJ4yx0JU3MXSUXUlwlr2NrXqbMyDC49TMeL1Zzz9BnOu4qYsQU
         Rxtg==
X-Gm-Message-State: AOAM531TMY9lcC2KapS/L6qlIgCfGEqvlC3/IaP+/KBoQ2jlBSaJJmqr
        k9brbyr00G+wV+9aFHJc/fPsHC1GZ8iyLA==
X-Google-Smtp-Source: ABdhPJzOmSNEOgRXJe9apejEmfnoY7jGeiofN79qu9oRk4097uDyFEgiVGWKCdldi0SOeh1HsTe0ag==
X-Received: by 2002:ae9:dc45:: with SMTP id q66mr2008858qkf.407.1605655233560;
        Tue, 17 Nov 2020 15:20:33 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id d12sm14555544qtp.77.2020.11.17.15.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 15:20:33 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, torvalds@linux-foundation.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, joel@joelfernandes.org,
        vineeth@bitbyteword.org, Chen Yu <yu.c.chen@intel.com>,
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
Subject: [PATCH -tip 10/32] sched: Fix priority inversion of cookied task with sibling
Date:   Tue, 17 Nov 2020 18:19:40 -0500
Message-Id: <20201117232003.3580179-11-joel@joelfernandes.org>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
In-Reply-To: <20201117232003.3580179-1-joel@joelfernandes.org>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

The rationale is as follows. In the core-wide pick logic, even if
need_sync == false, we need to go look at other CPUs (non-local CPUs) to
see if they could be running RT.

Say the RQs in a particular core look like this:
Let CFS1 and CFS2 be 2 tagged CFS tags. Let RT1 be an untagged RT task.

rq0            rq1
CFS1 (tagged)  RT1 (not tag)
CFS2 (tagged)

Say schedule() runs on rq0. Now, it will enter the above loop and
pick_task(RT) will return NULL for 'p'. It will enter the above if() block
and see that need_sync == false and will skip RT entirely.

The end result of the selection will be (say prio(CFS1) > prio(CFS2)):
rq0             rq1
CFS1            IDLE

When it should have selected:
rq0             r1
IDLE            RT

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
2.29.2.299.gdc1121823c-goog

