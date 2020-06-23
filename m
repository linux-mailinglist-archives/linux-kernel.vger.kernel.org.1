Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD98204553
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 02:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731765AbgFWAaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 20:30:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:55336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731656AbgFWAaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:30:18 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3413B207BC;
        Tue, 23 Jun 2020 00:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592872217;
        bh=ZDfG0P7ylzy19vMVGWl1TZy1vCbWxB7/o0OTYOQnG3Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gZQhR0XTjWdpIhXDG3G2Xqfq1N/OykxSvLpo6BGE0UmK8GzSsEwMQJYI6DKFhf5tr
         pBfpMKH6NeQUu/11IMJhLtYjorPwZjq4If3VAgScZlm6LY4rAe6QHtJ9QrUpKplQ4L
         XyOvWPW4EIHQ+smNQfNBFKX4rvKn8cTcKeta2FD8=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 10/30] refperf: Dynamically allocate experiment-summary output buffer
Date:   Mon, 22 Jun 2020 17:29:53 -0700
Message-Id: <20200623003013.26252-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623002941.GA26089@paulmck-ThinkPad-P72>
References: <20200623002941.GA26089@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Currently, the buffer used to accumulate the experiment-summary output
is fixed size, which will cause problems if someone decides to run
one hundred experiments.  This commit therefore dynamically allocates
this buffer.

Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refperf.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/refperf.c b/kernel/rcu/refperf.c
index 6324449..75b9cce 100644
--- a/kernel/rcu/refperf.c
+++ b/kernel/rcu/refperf.c
@@ -333,9 +333,10 @@ u64 process_durations(int n)
 // point all the timestamps are printed.
 static int main_func(void *arg)
 {
+	bool errexit = false;
 	int exp, r;
 	char buf1[64];
-	char buf[512];
+	char *buf;
 	u64 *result_avg;
 
 	set_cpus_allowed_ptr(current, cpumask_of(nreaders % nr_cpu_ids));
@@ -343,8 +344,11 @@ static int main_func(void *arg)
 
 	VERBOSE_PERFOUT("main_func task started");
 	result_avg = kzalloc(nruns * sizeof(*result_avg), GFP_KERNEL);
-	if (!result_avg)
+	buf = kzalloc(64 + nruns * 32, GFP_KERNEL);
+	if (!result_avg || !buf) {
 		VERBOSE_PERFOUT_ERRSTRING("out of memory");
+		errexit = true;
+	}
 	atomic_inc(&n_init);
 
 	// Wait for all threads to start.
@@ -354,7 +358,7 @@ static int main_func(void *arg)
 
 	// Start exp readers up per experiment
 	for (exp = 0; exp < nruns && !torture_must_stop(); exp++) {
-		if (!result_avg)
+		if (errexit)
 			break;
 		if (torture_must_stop())
 			goto end;
@@ -391,13 +395,13 @@ static int main_func(void *arg)
 	strcat(buf, "Threads\tTime(ns)\n");
 
 	for (exp = 0; exp < nruns; exp++) {
-		if (!result_avg)
+		if (errexit)
 			break;
 		sprintf(buf1, "%d\t%llu.%03d\n", exp + 1, result_avg[exp] / 1000, (int)(result_avg[exp] % 1000));
 		strcat(buf, buf1);
 	}
 
-	if (result_avg)
+	if (!errexit)
 		PERFOUT("%s", buf);
 
 	// This will shutdown everything including us.
@@ -412,6 +416,8 @@ static int main_func(void *arg)
 
 end:
 	torture_kthread_stopping("main_func");
+	kfree(result_avg);
+	kfree(buf);
 	return 0;
 }
 
-- 
2.9.5

