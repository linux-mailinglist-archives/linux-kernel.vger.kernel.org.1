Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE489243137
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Aug 2020 00:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbgHLW5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Aug 2020 18:57:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:48996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726637AbgHLW5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 18:57:36 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BC6322B45;
        Wed, 12 Aug 2020 22:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597273056;
        bh=8dX/jRRGYYoVQ4sfHAistYqVItFs5RRYfTXsC/iWNDc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eH9fW6h9Wp+mfejJk2PkC/aBga5X9fiV+ho31fP6NlqWsVTUx6pHesSCvRIjz0w+j
         qeLyD1wF7BOnF+tKc2mYyQQgWKN+CwZWjiNqteII9XAM7DYNz+4imJ4A9Nil4qw1FS
         YOY8vKYopXKqZ5dHqw6LRsbML1HE4rwbVe+hodR4=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        elver@google.com, dvyukov@google.com,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 08/12] rcu: IPI all CPUs at GP start for strict GPs
Date:   Wed, 12 Aug 2020 15:57:28 -0700
Message-Id: <20200812225732.20068-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200812225632.GA19759@paulmck-ThinkPad-P72>
References: <20200812225632.GA19759@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Currently, each CPU discovers the beginning of a given grace period
on its own time, which is again good for efficiency but bad for fast
grace periods.  This commit therefore uses on_each_cpu() to IPI each
CPU after grace-period initialization in order to inform each CPU of
the new grace period in a timely manner, but only in kernels build with
CONFIG_RCU_STRICT_GRACE_PERIOD=y.

Reported-by Jann Horn <jannh@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 4353a1a..a30d6f3 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1678,6 +1678,15 @@ static void rcu_gp_torture_wait(void)
 }
 
 /*
+ * Handler for on_each_cpu() to invoke the target CPU's RCU core
+ * processing.
+ */
+static void rcu_strict_gp_boundary(void *unused)
+{
+	invoke_rcu_core();
+}
+
+/*
  * Initialize a new grace period.  Return false if no grace period required.
  */
 static bool rcu_gp_init(void)
@@ -1805,6 +1814,10 @@ static bool rcu_gp_init(void)
 		WRITE_ONCE(rcu_state.gp_activity, jiffies);
 	}
 
+	// If strict, make all CPUs aware of new grace period.
+	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD))
+		on_each_cpu(rcu_strict_gp_boundary, NULL, 0);
+
 	return true;
 }
 
-- 
2.9.5

