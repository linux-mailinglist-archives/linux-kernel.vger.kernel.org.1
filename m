Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE78A2A8AD8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 00:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732644AbgKEXjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 18:39:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:43366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732415AbgKEXjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 18:39:37 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D30920885;
        Thu,  5 Nov 2020 23:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604619576;
        bh=VxqZILD6hfFBjZcyUnoqUf4A9OoB1cbecbAiGktMzHk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k+/kEkZxV9XwuE8/8vNN6XLAsHvFf7fjqXs34BwgnyEKdcmrm25I2B9byoPw/5Nge
         F06IG8Gg98r+sXkgMIxlqfdNVZjWP4P7M1uEOXciFC3ogbGPZ8erT1It97XXnhzTQf
         z2rg7lXvhpnSAQK3xQPbBnZaEuIoUMdhS1GMQvH4=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 4/4] rcu-tasks: Make the units of ->init_fract be jiffies
Date:   Thu,  5 Nov 2020 15:39:33 -0800
Message-Id: <20201105233933.20748-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201105233900.GA20676@paulmck-ThinkPad-P72>
References: <20201105233900.GA20676@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Currently, the units of ->init_fract are milliseconds while those of
->gp_sleep are jiffies.  For consistency with each other and with the
argument of schedule_timeout_idle(), this commit changes the units of
->init_fract to jiffies.

This change does affect the backoff algorithm, but only on systems where
HZ is not 1000, and even there the change makes more sense, given that the
current setup would "back off" to the same number of jiffies repeatedly.
In contrast, with this change, the number of jiffies waited increases
on each pass throught the loop in the rcu_tasks_wait_gp() function.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 0b45989..35bdcfd 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -335,8 +335,6 @@ static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
 
 	// Start off with initial wait and slowly back off to 1 HZ wait.
 	fract = rtp->init_fract;
-	if (fract > HZ)
-		fract = HZ;
 
 	while (!list_empty(&holdouts)) {
 		bool firstreport;
@@ -345,10 +343,10 @@ static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
 
 		/* Slowly back off waiting for holdouts */
 		set_tasks_gp_state(rtp, RTGS_WAIT_SCAN_HOLDOUTS);
-		schedule_timeout_idle(HZ/fract);
+		schedule_timeout_idle(fract);
 
-		if (fract > 1)
-			fract--;
+		if (fract < HZ)
+			fract++;
 
 		rtst = READ_ONCE(rcu_task_stall_timeout);
 		needreport = rtst > 0 && time_after(jiffies, lastreport + rtst);
@@ -557,7 +555,7 @@ EXPORT_SYMBOL_GPL(rcu_barrier_tasks);
 static int __init rcu_spawn_tasks_kthread(void)
 {
 	rcu_tasks.gp_sleep = HZ / 10;
-	rcu_tasks.init_fract = 10;
+	rcu_tasks.init_fract = HZ / 10;
 	rcu_tasks.pregp_func = rcu_tasks_pregp_step;
 	rcu_tasks.pertask_func = rcu_tasks_pertask;
 	rcu_tasks.postscan_func = rcu_tasks_postscan;
@@ -1178,12 +1176,12 @@ static int __init rcu_spawn_tasks_trace_kthread(void)
 {
 	if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB)) {
 		rcu_tasks_trace.gp_sleep = HZ / 10;
-		rcu_tasks_trace.init_fract = 10;
+		rcu_tasks_trace.init_fract = HZ / 10;
 	} else {
 		rcu_tasks_trace.gp_sleep = HZ / 200;
 		if (rcu_tasks_trace.gp_sleep <= 0)
 			rcu_tasks_trace.gp_sleep = 1;
-		rcu_tasks_trace.init_fract = HZ / 5;
+		rcu_tasks_trace.init_fract = HZ / 200;
 		if (rcu_tasks_trace.init_fract <= 0)
 			rcu_tasks_trace.init_fract = 1;
 	}
-- 
2.9.5

