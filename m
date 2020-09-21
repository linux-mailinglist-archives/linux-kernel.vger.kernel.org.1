Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 904BD272411
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 14:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbgIUMoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 08:44:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:54214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726756AbgIUMoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 08:44:03 -0400
Received: from lenoir.home (lfbn-ncy-1-588-162.w81-51.abo.wanadoo.fr [81.51.203.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B234520EDD;
        Mon, 21 Sep 2020 12:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600692243;
        bh=xZ0hx4AOVge70VVr9D0jIARNWzbXrR8rdxUohQNP4dQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2PdeZDVxmwIFNASuR4Qa1c0GgmwKSU7gkLIBBtL8MZJl3jwAAbk19NAJJ1b5kXxdJ
         IXjxsH69YGpzHFr4MDSTZH70eq6ogNpwI268C6RZ/s2lP27SI1v38Ceek4X+3sIX2s
         I95b7QlM3fsCSVw15XUxFPNZ12y8flkxDn1LUqh8=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>
Subject: [RFC PATCH 02/12] rcu: Turn enabled/offload states into a common flag
Date:   Mon, 21 Sep 2020 14:43:41 +0200
Message-Id: <20200921124351.24035-3-frederic@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200921124351.24035-1-frederic@kernel.org>
References: <20200921124351.24035-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gather the segcblist properties in a common map to avoid spreading
booleans in the structure. And this prepares for the offloaded state to
be mutable on runtime.

Inspired-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
---
 include/linux/rcu_segcblist.h |  6 ++++--
 kernel/rcu/rcu_segcblist.c    |  6 +++---
 kernel/rcu/rcu_segcblist.h    | 23 +++++++++++++++++++++--
 3 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/include/linux/rcu_segcblist.h b/include/linux/rcu_segcblist.h
index b36afe7b22c9..dca2f39ee67f 100644
--- a/include/linux/rcu_segcblist.h
+++ b/include/linux/rcu_segcblist.h
@@ -63,6 +63,9 @@ struct rcu_cblist {
 #define RCU_NEXT_TAIL		3
 #define RCU_CBLIST_NSEGS	4
 
+#define SEGCBLIST_ENABLED	BIT(0)
+#define SEGCBLIST_OFFLOADED	BIT(1)
+
 struct rcu_segcblist {
 	struct rcu_head *head;
 	struct rcu_head **tails[RCU_CBLIST_NSEGS];
@@ -72,8 +75,7 @@ struct rcu_segcblist {
 #else
 	long len;
 #endif
-	u8 enabled;
-	u8 offloaded;
+	u8 flags;
 };
 
 #define RCU_SEGCBLIST_INITIALIZER(n) \
diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index 9a0f66133b4b..d131ef8940a0 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -152,7 +152,7 @@ void rcu_segcblist_init(struct rcu_segcblist *rsclp)
 	for (i = 0; i < RCU_CBLIST_NSEGS; i++)
 		rsclp->tails[i] = &rsclp->head;
 	rcu_segcblist_set_len(rsclp, 0);
-	rsclp->enabled = 1;
+	rcu_segcblist_set_flags(rsclp, SEGCBLIST_ENABLED);
 }
 
 /*
@@ -163,7 +163,7 @@ void rcu_segcblist_disable(struct rcu_segcblist *rsclp)
 {
 	WARN_ON_ONCE(!rcu_segcblist_empty(rsclp));
 	WARN_ON_ONCE(rcu_segcblist_n_cbs(rsclp));
-	rsclp->enabled = 0;
+	rcu_segcblist_clear_flags(rsclp, SEGCBLIST_ENABLED);
 }
 
 /*
@@ -172,7 +172,7 @@ void rcu_segcblist_disable(struct rcu_segcblist *rsclp)
  */
 void rcu_segcblist_offload(struct rcu_segcblist *rsclp)
 {
-	rsclp->offloaded = 1;
+	rcu_segcblist_set_flags(rsclp, SEGCBLIST_OFFLOADED);
 }
 
 /*
diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
index 492262bcb591..fc98761e3ee9 100644
--- a/kernel/rcu/rcu_segcblist.h
+++ b/kernel/rcu/rcu_segcblist.h
@@ -50,19 +50,38 @@ static inline long rcu_segcblist_n_cbs(struct rcu_segcblist *rsclp)
 #endif
 }
 
+static inline void rcu_segcblist_set_flags(struct rcu_segcblist *rsclp,
+					   int flags)
+{
+	rsclp->flags |= flags;
+}
+
+static inline void rcu_segcblist_clear_flags(struct rcu_segcblist *rsclp,
+					     int flags)
+{
+	rsclp->flags &= ~flags;
+}
+
+static inline bool rcu_segcblist_test_flags(struct rcu_segcblist *rsclp,
+					    int flags)
+{
+	return READ_ONCE(rsclp->flags) & flags;
+}
+
 /*
  * Is the specified rcu_segcblist enabled, for example, not corresponding
  * to an offline CPU?
  */
 static inline bool rcu_segcblist_is_enabled(struct rcu_segcblist *rsclp)
 {
-	return rsclp->enabled;
+	return rcu_segcblist_test_flags(rsclp, SEGCBLIST_ENABLED);
 }
 
 /* Is the specified rcu_segcblist offloaded?  */
 static inline bool rcu_segcblist_is_offloaded(struct rcu_segcblist *rsclp)
 {
-	return IS_ENABLED(CONFIG_RCU_NOCB_CPU) && rsclp->offloaded;
+	return IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
+		rcu_segcblist_test_flags(rsclp, SEGCBLIST_OFFLOADED);
 }
 
 /*
-- 
2.28.0

