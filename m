Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8202A25805C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 20:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729517AbgHaSJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 14:09:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:55408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729257AbgHaSH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:07:56 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA760215A4;
        Mon, 31 Aug 2020 18:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598897273;
        bh=lLhLUNWMDU/FGyJuvsj8F4mXjAaTbtY5dc601D5+c44=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GxPkbmeUGD6lSFtZr9pLjxJ9aiS/ZC7i2vuC9R9rC6o41/ZVoopCBnoK7vK0YNiqe
         MXA/LQxLQjp6YAs8FW8EnFyhJi7fm2/NvYehJyOJSrI2S6rdw+zLN624JUBm5eW6n5
         IT5hG5wEFMUSpquIbBgmDfdvw9UDCw/BNGt8P0Ww=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 10/19] scftorture: Consolidate scftorture_invoke_one() check and kfree()
Date:   Mon, 31 Aug 2020 11:07:40 -0700
Message-Id: <20200831180749.843-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831180731.GA582@paulmck-ThinkPad-P72>
References: <20200831180731.GA582@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit moves checking of the ->scfc_out field and the freeing of
the scf_check structure down below the end of switch statement, thus
saving a few lines of code.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/scftorture.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index 0d7299d..f220cd3 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -289,7 +289,7 @@ static void scf_handler_1(void *scfc_in)
 static void scftorture_invoke_one(struct scf_statistics *scfp, struct torture_random_state *trsp)
 {
 	uintptr_t cpu;
-	int ret;
+	int ret = 0;
 	struct scf_check *scfcp = NULL;
 	struct scf_selector *scfsp = scf_sel_rand(trsp);
 
@@ -322,11 +322,7 @@ static void scftorture_invoke_one(struct scf_statistics *scfp, struct torture_ra
 			else
 				scfp->n_single_ofl++;
 			kfree(scfcp);
-		} else if (scfcp && scfsp->scfs_wait) {
-			if (WARN_ON_ONCE(!scfcp->scfc_out))
-				atomic_inc(&n_mb_out_errs); // Leak rather than trash!
-			else
-				kfree(scfcp);
+			scfcp = NULL;
 		}
 		break;
 	case SCF_PRIM_MANY:
@@ -341,12 +337,6 @@ static void scftorture_invoke_one(struct scf_statistics *scfp, struct torture_ra
 			scfcp->scfc_in = true;
 		}
 		smp_call_function_many(cpu_online_mask, scf_handler, scfcp, scfsp->scfs_wait);
-		if (scfcp) {
-			if (WARN_ON_ONCE(!scfcp->scfc_out))
-				atomic_inc(&n_mb_out_errs);  // Leak rather than trash!
-			else
-				kfree(scfcp);
-		}
 		break;
 	case SCF_PRIM_ALL:
 		if (scfsp->scfs_wait)
@@ -360,14 +350,14 @@ static void scftorture_invoke_one(struct scf_statistics *scfp, struct torture_ra
 			scfcp->scfc_in = true;
 		}
 		smp_call_function(scf_handler, scfcp, scfsp->scfs_wait);
-		if (scfcp) {
-			if (WARN_ON_ONCE(!scfcp->scfc_out))
-				atomic_inc(&n_mb_out_errs);  // Leak rather than trash!
-			else
-				kfree(scfcp);
-		}
 		break;
 	}
+	if (scfcp && scfsp->scfs_wait) {
+		if (WARN_ON_ONCE(!scfcp->scfc_out))
+			atomic_inc(&n_mb_out_errs); // Leak rather than trash!
+		else
+			kfree(scfcp);
+	}
 	if (use_cpus_read_lock)
 		cpus_read_unlock();
 	else
-- 
2.9.5

