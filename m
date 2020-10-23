Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4D292971A9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 16:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750834AbgJWOsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 10:48:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:33542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750780AbgJWOrc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 10:47:32 -0400
Received: from localhost.localdomain (unknown [176.167.163.208])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A755C22254;
        Fri, 23 Oct 2020 14:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603464451;
        bh=4nDVa8AWwZ+W9cuyfOQDOCLr65TDab1p9NGvByeim7c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wE+CoSVcT1zXnOr+FweFDGskNVo60+LKg1nnxtjBAWU/WXEVZ6PnQqq7ytY5nqHsS
         hh3xiwsQuPxM85TYSggeZ1yz+hqagTpxpXDef0n0Jq0hieoFuBLee80RQB3OnaokT7
         0hkth8s22C0OJakV31UYhNebuPTaaE9PpqBu+w3M=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>
Subject: [PATCH 14/16] rcu: Locally accelerate callbacks as long as offloading isn't complete
Date:   Fri, 23 Oct 2020 16:46:47 +0200
Message-Id: <20201023144649.53046-15-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201023144649.53046-1-frederic@kernel.org>
References: <20201023144649.53046-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The local callbacks processing checks if some callbacks need
acceleration. Keep that behaviour under nocb lock protection when
rcu_core() executes concurrently with GP/CB kthreads.

Inspired-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
---
 kernel/rcu/tree.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 45fad6977bea..4af5fed11885 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2673,7 +2673,6 @@ static __latent_entropy void rcu_core(void)
 	unsigned long flags;
 	struct rcu_data *rdp = raw_cpu_ptr(&rcu_data);
 	struct rcu_node *rnp = rdp->mynode;
-	const bool offloaded = rcu_segcblist_is_offloaded(&rdp->cblist);
 	const bool do_batch = !rcu_segcblist_completely_offloaded(&rdp->cblist);
 
 	if (cpu_is_offline(smp_processor_id()))
@@ -2694,11 +2693,11 @@ static __latent_entropy void rcu_core(void)
 
 	/* No grace period and unregistered callbacks? */
 	if (!rcu_gp_in_progress() &&
-	    rcu_segcblist_is_enabled(&rdp->cblist) && !offloaded) {
-		local_irq_save(flags);
+	    rcu_segcblist_is_enabled(&rdp->cblist) && do_batch) {
+		rcu_nocb_lock_irqsave(rdp, flags);
 		if (!rcu_segcblist_restempty(&rdp->cblist, RCU_NEXT_READY_TAIL))
 			rcu_accelerate_cbs_unlocked(rnp, rdp);
-		local_irq_restore(flags);
+		rcu_nocb_unlock_irqrestore(rdp, flags);
 	}
 
 	rcu_check_gp_start_stall(rnp, rdp, rcu_jiffies_till_stall_check());
-- 
2.25.1

