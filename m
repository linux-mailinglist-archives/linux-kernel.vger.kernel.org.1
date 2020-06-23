Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD8B920455C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 02:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731843AbgFWAay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 20:30:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:55748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731710AbgFWAaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:30:21 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42287208FE;
        Tue, 23 Jun 2020 00:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592872220;
        bh=MrZxr8/zY8WIE42EIkUZiZo/6KE2/yUgAqOmiUMCwmk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eYGvW83vPx+lm8fbV67OGS/W0TW7hS6YdcRJIUrX7zSxn1NFfj7JW9WDQqriGQI3g
         5Q/PGmwhJq8HNWjSwuc9jo+KPfOXPbYsahlcOf3rg2JfpOSdGMM1/Lyrvb4jmldC0y
         Njyq9nT0VuUZyyo+TaG/cN/QCggpCYNE4USRWFiU=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 25/30] refperf: Add test for RCU Tasks Trace readers.
Date:   Mon, 22 Jun 2020 17:30:08 -0700
Message-Id: <20200623003013.26252-25-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623002941.GA26089@paulmck-ThinkPad-P72>
References: <20200623002941.GA26089@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds testing for RCU Tasks Trace readers to the refperf module.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refperf.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/refperf.c b/kernel/rcu/refperf.c
index 49fffb9..da7de9a 100644
--- a/kernel/rcu/refperf.c
+++ b/kernel/rcu/refperf.c
@@ -25,6 +25,7 @@
 #include <linux/notifier.h>
 #include <linux/percpu.h>
 #include <linux/rcupdate.h>
+#include <linux/rcupdate_trace.h>
 #include <linux/reboot.h>
 #include <linux/sched.h>
 #include <linux/spinlock.h>
@@ -157,7 +158,6 @@ static struct ref_perf_ops rcu_ops = {
 	.name		= "rcu"
 };
 
-
 // Definitions for SRCU ref perf testing.
 DEFINE_STATIC_SRCU(srcu_refctl_perf);
 static struct srcu_struct *srcu_ctlp = &srcu_refctl_perf;
@@ -192,6 +192,35 @@ static struct ref_perf_ops srcu_ops = {
 	.name		= "srcu"
 };
 
+// Definitions for RCU Tasks Trace ref perf testing.
+static void rcu_trace_ref_perf_read_section(const int nloops)
+{
+	int i;
+
+	for (i = nloops; i >= 0; i--) {
+		rcu_read_lock_trace();
+		rcu_read_unlock_trace();
+	}
+}
+
+static void rcu_trace_ref_perf_delay_section(const int nloops, const int udl, const int ndl)
+{
+	int i;
+
+	for (i = nloops; i >= 0; i--) {
+		rcu_read_lock_trace();
+		un_delay(udl, ndl);
+		rcu_read_unlock_trace();
+	}
+}
+
+static struct ref_perf_ops rcu_trace_ops = {
+	.init		= rcu_sync_perf_init,
+	.readsection	= rcu_trace_ref_perf_read_section,
+	.delaysection	= rcu_trace_ref_perf_delay_section,
+	.name		= "rcu-trace"
+};
+
 // Definitions for reference count
 static atomic_t refcnt;
 
@@ -584,7 +613,7 @@ ref_perf_init(void)
 	long i;
 	int firsterr = 0;
 	static struct ref_perf_ops *perf_ops[] = {
-		&rcu_ops, &srcu_ops, &refcnt_ops, &rwlock_ops, &rwsem_ops,
+		&rcu_ops, &srcu_ops, &rcu_trace_ops, &refcnt_ops, &rwlock_ops, &rwsem_ops,
 	};
 
 	if (!torture_init_begin(perf_type, verbose))
-- 
2.9.5

