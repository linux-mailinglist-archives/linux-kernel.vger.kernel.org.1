Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4BC20456B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 02:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731933AbgFWAbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 20:31:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:55236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731670AbgFWAaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:30:18 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3763720890;
        Tue, 23 Jun 2020 00:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592872218;
        bh=3XxXc/vNDqGq7CdQmSK0xiKg/uFoGBJdCE+lcZMiNG0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hfCcutqR4Zj8Ey3NlqfJgqRPVNHih4rhp5YP9bARscI2zhrHLhRTt5iXbJG9nU9Vk
         Fgs0+qmouLEm1EvA4CMUOEtvY3zUV4Ug+gSlo91/12FTlRA01Pi956I5CCWS/Go2NT
         3ObunPeBedG2j4jwfExFZ2rnsrZbM2sDKVUq6iKE=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 15/30] refperf: More closely synchronize reader start times
Date:   Mon, 22 Jun 2020 17:29:58 -0700
Message-Id: <20200623003013.26252-15-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623002941.GA26089@paulmck-ThinkPad-P72>
References: <20200623002941.GA26089@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Currently, readers are awakened individually.  On most systems, this
results in significant wakeup delay from one reader to the next, which
can result in the first and last reader having sole access to the
synchronization primitive in question.  If that synchronization primitive
involves shared memory, those readers will rack up a huge number of
operations in a very short time, causing large perturbations in the
results.

This commit therefore has the readers busy-wait after being awakened,
and uses a new n_started variable to synchronize their start times.

Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refperf.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/rcu/refperf.c b/kernel/rcu/refperf.c
index 2fd3ed1..234bb0e 100644
--- a/kernel/rcu/refperf.c
+++ b/kernel/rcu/refperf.c
@@ -99,6 +99,7 @@ static atomic_t nreaders_exp;
 
 // Use to wait for all threads to start.
 static atomic_t n_init;
+static atomic_t n_started;
 
 // Track which experiment is currently running.
 static int exp_idx;
@@ -253,6 +254,9 @@ ref_perf_reader(void *arg)
 	WARN_ON_ONCE(smp_processor_id() != me);
 
 	WRITE_ONCE(rt->start_reader, 0);
+	if (!atomic_dec_return(&n_started))
+		while (atomic_read_acquire(&n_started))
+			cpu_relax();
 
 	VERBOSE_PERFOUT("ref_perf_reader %ld: experiment %d started", me, exp_idx);
 
@@ -367,6 +371,7 @@ static int main_func(void *arg)
 
 		reset_readers();
 		atomic_set(&nreaders_exp, nreaders);
+		atomic_set(&n_started, nreaders);
 
 		exp_idx = exp;
 
-- 
2.9.5

