Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C584204554
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 02:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731639AbgFWAa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 20:30:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:55402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731667AbgFWAaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:30:18 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8AB22083B;
        Tue, 23 Jun 2020 00:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592872217;
        bh=gcsrvQt82tIqA0kDxinUmEZN2K/AwFRgqEUqjBE/FbY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QHVgrjQPkBtOvSTCX6XXvg7b9aO7FpTsN6jSD+mBKu1D0HH7Y2beuzJdxfsddWK6w
         BmTFONlYldodYb7SapO0lYLoJlNfO2B/oBLj2fNbvY2r/+63dAjFe+Z4B/uaXrItR5
         NrXzA9ne9QapVMkKFrPCga4jA1y6s2Yw/5Ojl40s=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 13/30] refperf: Tune reader measurement interval
Date:   Mon, 22 Jun 2020 17:29:56 -0700
Message-Id: <20200623003013.26252-13-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623002941.GA26089@paulmck-ThinkPad-P72>
References: <20200623002941.GA26089@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit moves a printk() out of the measurement interval, converts
a atomic_dec()/atomic_read() pair to atomic_dec_and_test(), and adds
a smp_mb__before_atomic() to avoid potential wake/wait hangs.  These
changes have the added benefit of reducing the number of loops required
for amortizing loop overhead for CONFIG_PREEMPT=n RCU measurements from
1,000,000 to 10,000.  This reduction in turn shortens the test, reducing
the probability of interference.

Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refperf.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/refperf.c b/kernel/rcu/refperf.c
index 0a900f3..8815ccf 100644
--- a/kernel/rcu/refperf.c
+++ b/kernel/rcu/refperf.c
@@ -252,15 +252,16 @@ ref_perf_reader(void *arg)
 	// Make sure that the CPU is affinitized appropriately during testing.
 	WARN_ON_ONCE(smp_processor_id() != me);
 
+	smp_mb__before_atomic();
 	atomic_dec(&rt->start);
 
+	VERBOSE_PERFOUT("ref_perf_reader %ld: experiment %d started", me, exp_idx);
+
 	// To prevent noise, keep interrupts disabled. This also has the
 	// effect of preventing entries into slow path for rcu_read_unlock().
 	local_irq_save(flags);
 	start = ktime_get_mono_fast_ns();
 
-	VERBOSE_PERFOUT("ref_perf_reader %ld: experiment %d started", me, exp_idx);
-
 	cur_ops->readsection(loops);
 
 	duration = ktime_get_mono_fast_ns() - start;
@@ -268,14 +269,12 @@ ref_perf_reader(void *arg)
 
 	rt->last_duration_ns = WARN_ON_ONCE(duration < 0) ? 0 : duration;
 
-	atomic_dec(&nreaders_exp);
+	if (atomic_dec_and_test(&nreaders_exp))
+		wake_up(&main_wq);
 
 	VERBOSE_PERFOUT("ref_perf_reader %ld: experiment %d ended, (readers remaining=%d)",
 			me, exp_idx, atomic_read(&nreaders_exp));
 
-	if (!atomic_read(&nreaders_exp))
-		wake_up(&main_wq);
-
 	if (!torture_must_stop())
 		goto repeat;
 end:
-- 
2.9.5

