Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2659C204561
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 02:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731630AbgFWAbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 20:31:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:55780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731716AbgFWAaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:30:20 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 734892100A;
        Tue, 23 Jun 2020 00:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592872220;
        bh=kYiQhMrNluGmJ/gH/lJElNvisMeCFkHWqBFYmA0RsSw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KUd852T7roU9GgtDSLSmezRpfvEPxLihZ7g2DqSsaukAztKX4/YoxgwCSKw0mtp8t
         mCzEMKcL5+qlzuYD3JsCGsq8OWdhOW7n1B8WI1c9nDz8BJKccXcaUairBuLJLk4miR
         ESsi4+xBwAZgfchQf+BR/zlegUp/TWngip5eA7Zk=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 26/30] refperf: Add test for RCU Tasks readers
Date:   Mon, 22 Jun 2020 17:30:09 -0700
Message-Id: <20200623003013.26252-26-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623002941.GA26089@paulmck-ThinkPad-P72>
References: <20200623002941.GA26089@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds testing for RCU Tasks readers to the refperf module.
This also applies to RCU Rude readers, as both flavors have empty
(as in non-existent) read-side markers.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refperf.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/refperf.c b/kernel/rcu/refperf.c
index da7de9a..2bfdcdc 100644
--- a/kernel/rcu/refperf.c
+++ b/kernel/rcu/refperf.c
@@ -192,6 +192,31 @@ static struct ref_perf_ops srcu_ops = {
 	.name		= "srcu"
 };
 
+// Definitions for RCU Tasks ref perf testing: Empty read markers.
+// These definitions also work for RCU Rude readers.
+static void rcu_tasks_ref_perf_read_section(const int nloops)
+{
+	int i;
+
+	for (i = nloops; i >= 0; i--)
+		continue;
+}
+
+static void rcu_tasks_ref_perf_delay_section(const int nloops, const int udl, const int ndl)
+{
+	int i;
+
+	for (i = nloops; i >= 0; i--)
+		un_delay(udl, ndl);
+}
+
+static struct ref_perf_ops rcu_tasks_ops = {
+	.init		= rcu_sync_perf_init,
+	.readsection	= rcu_tasks_ref_perf_read_section,
+	.delaysection	= rcu_tasks_ref_perf_delay_section,
+	.name		= "rcu-tasks"
+};
+
 // Definitions for RCU Tasks Trace ref perf testing.
 static void rcu_trace_ref_perf_read_section(const int nloops)
 {
@@ -613,7 +638,8 @@ ref_perf_init(void)
 	long i;
 	int firsterr = 0;
 	static struct ref_perf_ops *perf_ops[] = {
-		&rcu_ops, &srcu_ops, &rcu_trace_ops, &refcnt_ops, &rwlock_ops, &rwsem_ops,
+		&rcu_ops, &srcu_ops, &rcu_trace_ops, &rcu_tasks_ops,
+		&refcnt_ops, &rwlock_ops, &rwsem_ops,
 	};
 
 	if (!torture_init_begin(perf_type, verbose))
-- 
2.9.5

