Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 504F62B722C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 00:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbgKQXUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 18:20:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728857AbgKQXUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 18:20:38 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49C1C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 15:20:37 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id a13so28677qkl.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 15:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uwgACvUC+jgEBROgGyLWrwdXgyZr1axLbHJ4ZXmNfrc=;
        b=LFUA6H8QqFGJvQcrbbvdVbwaQHXcRg7kWFYgU1iTJzjtLg0L48Hf0Ddh40olAaoaMq
         7QzzB/zvWBKjBcy4wEobySGjaXTlDsIeJOJzSjgVyUujiGNHVbCW7+1P5krm3I/1c6ST
         rfBJ+1HDLaVLyflPYRosDFaDqz6QE1sC1gnhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uwgACvUC+jgEBROgGyLWrwdXgyZr1axLbHJ4ZXmNfrc=;
        b=pN/J7OvnvTiMzl64Arj/k1FD0GpqCLMSafRo4lzMQ/c0Dm8tA+/EJg+9z9xJYuRf+O
         09ajlHWo8kUD4qoROu7nPc0A5T4eVgG5CjNqIDqq04twXyE3UABfp7GRCNJ3ZJXbyhZd
         que4pMP3AgToIuQWG7r8nh5hhV6RSzZAkwJd8hA0MAwDTHk9uVD5Z9wIttJH0trV27A+
         XPOWCR489cTd0gduqQNdh9zW3lOO06zQfLqP4Cr2NlrzyytBoQ+CpGA7BP708Rj3J9Kj
         rFlvfAEpXJSZjsfgsh68alpURvzj3vsjEqH+SkjD/SL4xlIqtxFER4XDDPDLVrSTNBQJ
         6xqA==
X-Gm-Message-State: AOAM531c2Sv1nvn47A9vAsccy3cP+GgtdLCn52HeJrxIIIvfz/m7vGq1
        cOyrISj34azY5CiTD4xiG5lIVw==
X-Google-Smtp-Source: ABdhPJwZW4823DMbklDPWeclOtfOgN12Qru3ZXDZpJ/N6X/gf0VH9qVFUdM8Smfh/3Jn/Y6X1k+sdw==
X-Received: by 2002:a37:9ed3:: with SMTP id h202mr2140866qke.126.1605655237107;
        Tue, 17 Nov 2020 15:20:37 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id d12sm14555544qtp.77.2020.11.17.15.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 15:20:36 -0800 (PST)
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
Subject: [PATCH -tip 12/32] sched: Simplify the core pick loop for optimized case
Date:   Tue, 17 Nov 2020 18:19:42 -0500
Message-Id: <20201117232003.3580179-13-joel@joelfernandes.org>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
In-Reply-To: <20201117232003.3580179-1-joel@joelfernandes.org>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The core pick loop grew a lot of warts over time to support
optimizations. Turns out that that directly doing a class pick before
entering the core-wide pick is better for readability. Make the changes.

Since this is a relatively new patch, make it a separate patch so that
it is easier to revert in case anyone reports an issue with it. Testing
shows it to be working for me.

Reviewed-by: Vineeth Pillai <viremana@linux.microsoft.com>
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/sched/core.c | 73 ++++++++++++++++-----------------------------
 1 file changed, 26 insertions(+), 47 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6aa76de55ef2..12e8e6627ab3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5180,6 +5180,15 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	put_prev_task_balance(rq, prev, rf);
 
 	smt_mask = cpu_smt_mask(cpu);
+	need_sync = !!rq->core->core_cookie;
+
+	/* reset state */
+	rq->core->core_cookie = 0UL;
+	if (rq->core->core_forceidle) {
+		need_sync = true;
+		fi_before = true;
+		rq->core->core_forceidle = false;
+	}
 
 	/*
 	 * core->core_task_seq, core->core_pick_seq, rq->core_sched_seq
@@ -5192,16 +5201,25 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	 * 'Fix' this by also increasing @task_seq for every pick.
 	 */
 	rq->core->core_task_seq++;
-	need_sync = !!rq->core->core_cookie;
 
-	/* reset state */
-reset:
-	rq->core->core_cookie = 0UL;
-	if (rq->core->core_forceidle) {
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
 		need_sync = true;
-		fi_before = true;
-		rq->core->core_forceidle = false;
 	}
+
 	for_each_cpu(i, smt_mask) {
 		struct rq *rq_i = cpu_rq(i);
 
@@ -5239,38 +5257,8 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
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
-				goto done;
-			}
 
 			rq_i->core_pick = p;
 
@@ -5298,18 +5286,9 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 						cpu_rq(j)->core_pick = NULL;
 					}
 					goto again;
-				} else {
-					/*
-					 * Once we select a task for a cpu, we
-					 * should not be doing an unconstrained
-					 * pick because it might starve a task
-					 * on a forced idle cpu.
-					 */
-					need_sync = true;
 				}
 			}
 		}
-next_class:;
 	}
 
 	rq->core->core_pick_seq = rq->core->core_task_seq;
-- 
2.29.2.299.gdc1121823c-goog

