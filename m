Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D820204565
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 02:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731904AbgFWAba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 20:31:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:55336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731684AbgFWAaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:30:19 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1165F20720;
        Tue, 23 Jun 2020 00:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592872219;
        bh=vsWLwEM2zL/AkX3vJvTMHn7tUWtKduFj/He0315EYPM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PjM56YrgSiu1KZqRWHd5TbNP7lArjBUTCRoS5WM+6RavWNUP2n1fyM729HVYYjRBz
         YDJHcupZtQ9ex3p17JVKU5t09oWpyz4pa3Uige3ZmxwjL8EoIGK6wXTT7tYmIbPYxH
         HbJhdLwhx66p9y71Xu3PxhNOV1dupPoNFZhspSjw=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 19/30] refperf: Simplify initialization-time wakeup protocol
Date:   Mon, 22 Jun 2020 17:30:02 -0700
Message-Id: <20200623003013.26252-19-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623002941.GA26089@paulmck-ThinkPad-P72>
References: <20200623002941.GA26089@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit moves the reader-launch wait loop from ref_perf_init()
to main_func(), removing one layer of wakeup and allowing slightly
faster system boot.

Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refperf.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/kernel/rcu/refperf.c b/kernel/rcu/refperf.c
index 2d2d227..7839237 100644
--- a/kernel/rcu/refperf.c
+++ b/kernel/rcu/refperf.c
@@ -369,13 +369,14 @@ static int main_func(void *arg)
 		VERBOSE_PERFOUT_ERRSTRING("out of memory");
 		errexit = true;
 	}
-	atomic_inc(&n_init);
-
-	// Wait for all threads to start.
-	wait_event(main_wq, atomic_read(&n_init) == (nreaders + 1));
 	if (holdoff)
 		schedule_timeout_interruptible(holdoff * HZ);
 
+	// Wait for all threads to start.
+	atomic_inc(&n_init);
+	while (atomic_read(&n_init) < nreaders + 1)
+		schedule_timeout_uninterruptible(1);
+
 	// Start exp readers up per experiment
 	for (exp = 0; exp < nruns && !torture_must_stop(); exp++) {
 		if (errexit)
@@ -565,14 +566,6 @@ ref_perf_init(void)
 	firsterr = torture_create_kthread(main_func, NULL, main_task);
 	if (firsterr)
 		goto unwind;
-	schedule_timeout_uninterruptible(1);
-
-
-	// Wait until all threads start
-	while (atomic_read(&n_init) < nreaders + 1)
-		schedule_timeout_uninterruptible(1);
-
-	wake_up(&main_wq);
 
 	torture_init_end();
 	return 0;
-- 
2.9.5

