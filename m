Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3345204556
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 02:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731697AbgFWAae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 20:30:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:55174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731668AbgFWAaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:30:18 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06B5520857;
        Tue, 23 Jun 2020 00:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592872218;
        bh=nyQeh8flDROkmEBHFnAc9Eq59qY4dCjQxdLV3qah2e0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hsqwPVg5yx/RCuesFx6eSikjWbGZRPo/d4MnxOZuZMUdHh9x0DCLNRVd6FGpHmsor
         MtI0+NztI0tddqNAip1RXGnzFhMDsdXPgqJLhVI/m03ulV+LQG2rzHeOxxYZvtkOjr
         8SVzmL+IxqU5ETmecyTVrk8+++kR2Y3qazGI4uhI=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 14/30] refperf: Convert reader_task structure's "start" field to int
Date:   Mon, 22 Jun 2020 17:29:57 -0700
Message-Id: <20200623003013.26252-14-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623002941.GA26089@paulmck-ThinkPad-P72>
References: <20200623002941.GA26089@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit converts the reader_task structure's "start" field to int
in order to demote a full barrier to an smp_load_acquire() and also to
simplify the code a bit.  While in the area, and to enlist the compiler's
help in ensuring that nothing was missed, the field's name was changed
to start_reader.

Also while in the area, change the main_func() store to use
smp_store_release() to further fortify against wait/wake races.

Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refperf.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/refperf.c b/kernel/rcu/refperf.c
index 8815ccf..2fd3ed1 100644
--- a/kernel/rcu/refperf.c
+++ b/kernel/rcu/refperf.c
@@ -80,7 +80,7 @@ torture_param(bool, shutdown, REFPERF_SHUTDOWN,
 
 struct reader_task {
 	struct task_struct *task;
-	atomic_t start;
+	int start_reader;
 	wait_queue_head_t wq;
 	u64 last_duration_ns;
 };
@@ -243,7 +243,7 @@ ref_perf_reader(void *arg)
 	VERBOSE_PERFOUT("ref_perf_reader %ld: waiting to start next experiment on cpu %d", me, smp_processor_id());
 
 	// Wait for signal that this reader can start.
-	wait_event(rt->wq, (atomic_read(&nreaders_exp) && atomic_read(&rt->start)) ||
+	wait_event(rt->wq, (atomic_read(&nreaders_exp) && smp_load_acquire(&rt->start_reader)) ||
 			   torture_must_stop());
 
 	if (torture_must_stop())
@@ -252,8 +252,7 @@ ref_perf_reader(void *arg)
 	// Make sure that the CPU is affinitized appropriately during testing.
 	WARN_ON_ONCE(smp_processor_id() != me);
 
-	smp_mb__before_atomic();
-	atomic_dec(&rt->start);
+	WRITE_ONCE(rt->start_reader, 0);
 
 	VERBOSE_PERFOUT("ref_perf_reader %ld: experiment %d started", me, exp_idx);
 
@@ -372,7 +371,7 @@ static int main_func(void *arg)
 		exp_idx = exp;
 
 		for (r = 0; r < nreaders; r++) {
-			atomic_set(&reader_tasks[r].start, 1);
+			smp_store_release(&reader_tasks[r].start_reader, 1);
 			wake_up(&reader_tasks[r].wq);
 		}
 
-- 
2.9.5

