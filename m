Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2CBB20455E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 02:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731867AbgFWAbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 20:31:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:55718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731703AbgFWAaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:30:21 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 106A720FC3;
        Tue, 23 Jun 2020 00:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592872220;
        bh=02ER3ClrOYLxdVzXGnlH4+yezOa0TX9/pgbCrbD/jCs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eTXdU3C5uT5e4MqNRNbUb5SLCem2fklZGc6o58EyYlNSRu7hI9vnSLBVeuNmMA02Z
         Qn9lG3xSIoBmJofju93GYtqpaws+UxW1Feoyc8ZjslUj5uFfNguFne7YcOHmiIDOFI
         Es7qwIG4r1rINwk1OwY5Pj1VO4N8+vY9rC+oy3g8=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 24/30] refperf: Change readdelay module parameter to nanoseconds
Date:   Mon, 22 Jun 2020 17:30:07 -0700
Message-Id: <20200623003013.26252-24-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623002941.GA26089@paulmck-ThinkPad-P72>
References: <20200623002941.GA26089@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The current units of microseconds are too coarse, so this commit
changes the units to nanoseconds.  However, ndelay is used only for the
nanoseconds with udelay being used for whole microseconds.  For example,
setting refperf.readdelay=1500 results in a udelay(1) followed by an
ndelay(500).

Suggested-by: Akira Yokosawa <akiyks@gmail.com>
[ paulmck: Abstracted delay per Akira feedback and move from 80 to 100 lines. ]
[ paulmck: Fix names as suggested by kbuild test robot. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refperf.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/kernel/rcu/refperf.c b/kernel/rcu/refperf.c
index 80d4490..49fffb9 100644
--- a/kernel/rcu/refperf.c
+++ b/kernel/rcu/refperf.c
@@ -66,8 +66,8 @@ torture_param(long, loops, 10000, "Number of loops per experiment.");
 torture_param(int, nreaders, -1, "Number of readers, -1 for 75% of CPUs.");
 // Number of runs.
 torture_param(int, nruns, 30, "Number of experiments to run.");
-// Reader delay in microseconds, 0 for no delay.
-torture_param(int, readdelay, 0, "Read-side delay in microseconds.");
+// Reader delay in nanoseconds, 0 for no delay.
+torture_param(int, readdelay, 0, "Read-side delay in nanoseconds.");
 
 #ifdef MODULE
 # define REFPERF_SHUTDOWN 0
@@ -111,12 +111,20 @@ struct ref_perf_ops {
 	void (*init)(void);
 	void (*cleanup)(void);
 	void (*readsection)(const int nloops);
-	void (*delaysection)(const int nloops, const int ndelay);
+	void (*delaysection)(const int nloops, const int udl, const int ndl);
 	const char *name;
 };
 
 static struct ref_perf_ops *cur_ops;
 
+static void un_delay(const int udl, const int ndl)
+{
+	if (udl)
+		udelay(udl);
+	if (ndl)
+		ndelay(ndl);
+}
+
 static void ref_rcu_read_section(const int nloops)
 {
 	int i;
@@ -127,13 +135,13 @@ static void ref_rcu_read_section(const int nloops)
 	}
 }
 
-static void ref_rcu_delay_section(const int nloops, const int ndelay)
+static void ref_rcu_delay_section(const int nloops, const int udl, const int ndl)
 {
 	int i;
 
 	for (i = nloops; i >= 0; i--) {
 		rcu_read_lock();
-		udelay(ndelay);
+		un_delay(udl, ndl);
 		rcu_read_unlock();
 	}
 }
@@ -165,14 +173,14 @@ static void srcu_ref_perf_read_section(const int nloops)
 	}
 }
 
-static void srcu_ref_perf_delay_section(const int nloops, const int ndelay)
+static void srcu_ref_perf_delay_section(const int nloops, const int udl, const int ndl)
 {
 	int i;
 	int idx;
 
 	for (i = nloops; i >= 0; i--) {
 		idx = srcu_read_lock(srcu_ctlp);
-		udelay(ndelay);
+		un_delay(udl, ndl);
 		srcu_read_unlock(srcu_ctlp, idx);
 	}
 }
@@ -197,13 +205,13 @@ static void ref_refcnt_section(const int nloops)
 	}
 }
 
-static void ref_refcnt_delay_section(const int nloops, const int ndelay)
+static void ref_refcnt_delay_section(const int nloops, const int udl, const int ndl)
 {
 	int i;
 
 	for (i = nloops; i >= 0; i--) {
 		atomic_inc(&refcnt);
-		udelay(ndelay);
+		un_delay(udl, ndl);
 		atomic_dec(&refcnt);
 	}
 }
@@ -233,13 +241,13 @@ static void ref_rwlock_section(const int nloops)
 	}
 }
 
-static void ref_rwlock_delay_section(const int nloops, const int ndelay)
+static void ref_rwlock_delay_section(const int nloops, const int udl, const int ndl)
 {
 	int i;
 
 	for (i = nloops; i >= 0; i--) {
 		read_lock(&test_rwlock);
-		udelay(ndelay);
+		un_delay(udl, ndl);
 		read_unlock(&test_rwlock);
 	}
 }
@@ -269,13 +277,13 @@ static void ref_rwsem_section(const int nloops)
 	}
 }
 
-static void ref_rwsem_delay_section(const int nloops, const int ndelay)
+static void ref_rwsem_delay_section(const int nloops, const int udl, const int ndl)
 {
 	int i;
 
 	for (i = nloops; i >= 0; i--) {
 		down_read(&test_rwsem);
-		udelay(ndelay);
+		un_delay(udl, ndl);
 		up_read(&test_rwsem);
 	}
 }
@@ -292,7 +300,7 @@ static void rcu_perf_one_reader(void)
 	if (readdelay <= 0)
 		cur_ops->readsection(loops);
 	else
-		cur_ops->delaysection(loops, readdelay);
+		cur_ops->delaysection(loops, readdelay / 1000, readdelay % 1000);
 }
 
 // Reader kthread.  Repeatedly does empty RCU read-side
-- 
2.9.5

