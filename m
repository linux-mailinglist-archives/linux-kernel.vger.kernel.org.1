Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72E2625805A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 20:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729501AbgHaSJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 14:09:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:55878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729268AbgHaSH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:07:56 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0270214D8;
        Mon, 31 Aug 2020 18:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598897274;
        bh=5uU93LRN8Lv8SLaPjUKtxlkj29bZNC1Fy86IybRO6Hg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tmqSIQQ0GPToBfYcGKKHQwjYm1IzHmRCM90pLQFgaTpSMjSYejzZGknWa6Vu9cT9g
         tLs3NyWHRPWfPOMZL34N3XmFQFJRExd371F6uVqsuJx7D6P+rWLH+QX+C67AcCtTg7
         qNvC7Fipn3Gq99wKDSLnWw+1lhw2Jl/d70z4vFlQ=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 11/19] scftorture: Consolidate scftorture_invoke_one() scf_check initialization
Date:   Mon, 31 Aug 2020 11:07:41 -0700
Message-Id: <20200831180749.843-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831180731.GA582@paulmck-ThinkPad-P72>
References: <20200831180731.GA582@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit hoists much of the initialization of the scf_check
structure out of the switch statement, thus saving a few lines of code.
The initialization of the ->scfc_in field remains in each leg of the
switch statement in order to more heavily stress memory ordering.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/scftorture.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index f220cd3..8ab72e5 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -299,8 +299,13 @@ static void scftorture_invoke_one(struct scf_statistics *scfp, struct torture_ra
 		preempt_disable();
 	if (scfsp->scfs_prim == SCF_PRIM_SINGLE || scfsp->scfs_wait) {
 		scfcp = kmalloc(sizeof(*scfcp), GFP_ATOMIC);
-		if (WARN_ON_ONCE(!scfcp))
+		if (WARN_ON_ONCE(!scfcp)) {
 			atomic_inc(&n_alloc_errs);
+		} else {
+			scfcp->scfc_cpu = -1;
+			scfcp->scfc_wait = scfsp->scfs_wait;
+			scfcp->scfc_out = false;
+		}
 	}
 	switch (scfsp->scfs_prim) {
 	case SCF_PRIM_SINGLE:
@@ -311,8 +316,6 @@ static void scftorture_invoke_one(struct scf_statistics *scfp, struct torture_ra
 			scfp->n_single++;
 		if (scfcp) {
 			scfcp->scfc_cpu = cpu;
-			scfcp->scfc_wait = scfsp->scfs_wait;
-			scfcp->scfc_out = false;
 			scfcp->scfc_in = true;
 		}
 		ret = smp_call_function_single(cpu, scf_handler_1, (void *)scfcp, scfsp->scfs_wait);
@@ -330,12 +333,8 @@ static void scftorture_invoke_one(struct scf_statistics *scfp, struct torture_ra
 			scfp->n_many_wait++;
 		else
 			scfp->n_many++;
-		if (scfcp) {
-			scfcp->scfc_cpu = -1;
-			scfcp->scfc_wait = true;
-			scfcp->scfc_out = false;
+		if (scfcp)
 			scfcp->scfc_in = true;
-		}
 		smp_call_function_many(cpu_online_mask, scf_handler, scfcp, scfsp->scfs_wait);
 		break;
 	case SCF_PRIM_ALL:
@@ -343,12 +342,8 @@ static void scftorture_invoke_one(struct scf_statistics *scfp, struct torture_ra
 			scfp->n_all_wait++;
 		else
 			scfp->n_all++;
-		if (scfcp) {
-			scfcp->scfc_cpu = -1;
-			scfcp->scfc_wait = true;
-			scfcp->scfc_out = false;
+		if (scfcp)
 			scfcp->scfc_in = true;
-		}
 		smp_call_function(scf_handler, scfcp, scfsp->scfs_wait);
 		break;
 	}
-- 
2.9.5

