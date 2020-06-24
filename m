Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7433207CB0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jun 2020 22:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406422AbgFXUMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jun 2020 16:12:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:52436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406382AbgFXUMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 16:12:30 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 704BF214D8;
        Wed, 24 Jun 2020 20:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593029549;
        bh=A/PWzn/Vgn/G2nP7MVtJX0MzzVuuQ12qSrEPDu13suE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yMu3jdXVtsGu3nvHhWaUww+aMfcmHsqc71ASFlP4Pm/sjjnKm5633fVR4G0bjMGg0
         IMY8ZxAqMQI1BX1fpMq3yRkHhx7y/wmAGgOaI3dByMhauWbu0ra9kVpGvGjT4TZFch
         Jr20O73U4hEtHcV6m2iuUDbBI+oGUmkO+cdxmyso=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 07/17] rcu/tree: Move kfree_rcu_cpu locking/unlocking to separate functions
Date:   Wed, 24 Jun 2020 13:12:16 -0700
Message-Id: <20200624201226.21197-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200624201200.GA28901@paulmck-ThinkPad-P72>
References: <20200624201200.GA28901@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

Introduce helpers to lock and unlock per-cpu "kfree_rcu_cpu"
structures. That will make kfree_call_rcu() more readable
and prevent programming errors.

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 519a3f5..edc512e 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3017,6 +3017,27 @@ debug_rcu_bhead_unqueue(struct kfree_rcu_bulk_data *bhead)
 #endif
 }
 
+static inline struct kfree_rcu_cpu *
+krc_this_cpu_lock(unsigned long *flags)
+{
+	struct kfree_rcu_cpu *krcp;
+
+	local_irq_save(*flags);	// For safely calling this_cpu_ptr().
+	krcp = this_cpu_ptr(&krc);
+	if (likely(krcp->initialized))
+		raw_spin_lock(&krcp->lock);
+
+	return krcp;
+}
+
+static inline void
+krc_this_cpu_unlock(struct kfree_rcu_cpu *krcp, unsigned long flags)
+{
+	if (likely(krcp->initialized))
+		raw_spin_unlock(&krcp->lock);
+	local_irq_restore(flags);
+}
+
 /*
  * This function is invoked in workqueue context after a grace period.
  * It frees all the objects queued on ->bhead_free or ->head_free.
@@ -3242,11 +3263,7 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 	struct kfree_rcu_cpu *krcp;
 	void *ptr;
 
-	local_irq_save(flags);	// For safely calling this_cpu_ptr().
-	krcp = this_cpu_ptr(&krc);
-	if (krcp->initialized)
-		raw_spin_lock(&krcp->lock);
-
+	krcp = krc_this_cpu_lock(&flags);
 	ptr = (void *)head - (unsigned long)func;
 
 	// Queue the object but don't yet schedule the batch.
@@ -3277,9 +3294,7 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 	}
 
 unlock_return:
-	if (krcp->initialized)
-		raw_spin_unlock(&krcp->lock);
-	local_irq_restore(flags);
+	krc_this_cpu_unlock(krcp, flags);
 }
 EXPORT_SYMBOL_GPL(kfree_call_rcu);
 
-- 
2.9.5

