Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 937291AAF76
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 19:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410938AbgDORYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 13:24:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:37904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410924AbgDORYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 13:24:05 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3025320784;
        Wed, 15 Apr 2020 17:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586971445;
        bh=Ze4jnx2Vzf6V3iemk5t65kRGUKjcmimAP2gSWAbUpLs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=snvfrSo/E/BkGNsbNyGip7QCT1X43qrVrwFz6NPR23pAQbh6Ttc7TdAjlfkWPl2Pb
         cZ4czog4a1GW4qE5auentFXq9xvVCJEvc/BEwpq6cW1+Spnv1mf+hjK6lq/JS65Msu
         vGcJP4KoM3q+tMIOqaYcE+XQcxiSXiKpa5e8EiJ8=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 1/3] rcu: Use data_race() for RCU expedited CPU stall-warning prints
Date:   Wed, 15 Apr 2020 10:24:01 -0700
Message-Id: <20200415172403.9647-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415172341.GA9519@paulmck-ThinkPad-P72>
References: <20200415172341.GA9519@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Although the accesses used to determine whether or not an expedited
stall should be printed are an integral part of the concurrency algorithm
governing use of the corresponding variables, the values that are simply
printed are ancillary.  As such, it is best to use data_race() for these
accesses in order to provide the greatest latitude in the use of KCSAN
for the other accesses that are an integral part of the algorithm.  This
commit therefore changes the relevant uses of READ_ONCE() to data_race().

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_exp.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 1a617b9..e1a7986 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -542,8 +542,8 @@ static void synchronize_rcu_expedited_wait(void)
 		}
 		pr_cont(" } %lu jiffies s: %lu root: %#lx/%c\n",
 			jiffies - jiffies_start, rcu_state.expedited_sequence,
-			READ_ONCE(rnp_root->expmask),
-			".T"[!!rnp_root->exp_tasks]);
+			data_race(rnp_root->expmask),
+			".T"[!!data_race(rnp_root->exp_tasks)]);
 		if (ndetected) {
 			pr_err("blocking rcu_node structures:");
 			rcu_for_each_node_breadth_first(rnp) {
@@ -553,8 +553,8 @@ static void synchronize_rcu_expedited_wait(void)
 					continue;
 				pr_cont(" l=%u:%d-%d:%#lx/%c",
 					rnp->level, rnp->grplo, rnp->grphi,
-					READ_ONCE(rnp->expmask),
-					".T"[!!rnp->exp_tasks]);
+					data_race(rnp->expmask),
+					".T"[!!data_race(rnp->exp_tasks)]);
 			}
 			pr_cont("\n");
 		}
-- 
2.9.5

