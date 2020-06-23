Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E692204545
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 02:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731698AbgFWAY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 20:24:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:51206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731628AbgFWAYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:24:46 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCF1420842;
        Tue, 23 Jun 2020 00:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592871885;
        bh=paXqSMIuYehYRZQr2uBs220dcpgonwW4zX+f2NFk3L0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xlUXaRTh99H9PXNSJ4tcDwrRgZnr2v0ujcyRixuD445XP/JFvyeQRV7mOEE3mKBNn
         jVM3dMikoI0S55QjOUvgfxFAsYNuzX5RGCH4GwBoByAWcSBnCgRNCj6jbbNvBzhRDU
         3Ed5hxnIfAzXl0JuFrr2CTpDS/ICBe4IYfVmTDd0=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 5/5] rcu-tasks: Fix code-style issues
Date:   Mon, 22 Jun 2020 17:24:43 -0700
Message-Id: <20200623002443.25954-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623002423.GA25869@paulmck-ThinkPad-P72>
References: <20200623002423.GA25869@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit declares trc_n_readers_need_end and trc_wait static and
replaced a "&" with "&&".  The "&" happened to work because the values
are bool, but accidents waiting to happen and all that...

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index d5c003c..828f222 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -737,8 +737,8 @@ EXPORT_SYMBOL_GPL(rcu_trace_lock_map);
 
 #ifdef CONFIG_TASKS_TRACE_RCU
 
-atomic_t trc_n_readers_need_end;	// Number of waited-for readers.
-DECLARE_WAIT_QUEUE_HEAD(trc_wait);	// List of holdout tasks.
+static atomic_t trc_n_readers_need_end;		// Number of waited-for readers.
+static DECLARE_WAIT_QUEUE_HEAD(trc_wait);	// List of holdout tasks.
 
 // Record outstanding IPIs to each CPU.  No point in sending two...
 static DEFINE_PER_CPU(bool, trc_ipi_to_cpu);
@@ -845,7 +845,7 @@ static bool trc_inspect_reader(struct task_struct *t, void *arg)
 	bool ofl = cpu_is_offline(cpu);
 
 	if (task_curr(t)) {
-		WARN_ON_ONCE(ofl & !is_idle_task(t));
+		WARN_ON_ONCE(ofl && !is_idle_task(t));
 
 		// If no chance of heavyweight readers, do it the hard way.
 		if (!ofl && !IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB))
-- 
2.9.5

