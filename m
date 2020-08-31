Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9F0A258035
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 20:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729430AbgHaSEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 14:04:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:44596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728957AbgHaSEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:04:12 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABD3D21789;
        Mon, 31 Aug 2020 18:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598897051;
        bh=oZ2fipO2KKQzDwNjGc/xHiYFBawa1wLLlttLJTLRG6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FgqIXpWfusSq0O7Y2205A0LL5ZDYdJTt9R6POLjCNxSdaQfj1VoQYq8ZTSC6BDosv
         rCjxYBYMKtrvIlitZ/r00Ldz6Blw+N6OsCpJiZp5iUsSAr4T8tKA4z7KKIWZZFpXPv
         T0umb9iy7VmuOXJNMdHP0+dlij3iJ4VvZ+V5CcsQ=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 12/14] rcutorture: Hoist OOM registry up one level
Date:   Mon, 31 Aug 2020 11:04:04 -0700
Message-Id: <20200831180406.494-12-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831180348.GA416@paulmck-ThinkPad-P72>
References: <20200831180348.GA416@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Currently, registering and unregistering the OOM notifier is done
right before and after the test, respectively.  This will not work
well for multi-threaded tests, so this commit hoists this registering
and unregistering up into the rcu_torture_fwd_prog_init() and
rcu_torture_fwd_prog_cleanup() functions.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 2b3f04e..983f82f 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2110,13 +2110,11 @@ static int rcu_torture_fwd_prog(void *args)
 	do {
 		schedule_timeout_interruptible(fwd_progress_holdoff * HZ);
 		WRITE_ONCE(rcu_fwd_emergency_stop, false);
-		register_oom_notifier(&rcutorture_oom_nb);
 		if (!IS_ENABLED(CONFIG_TINY_RCU) ||
 		    rcu_inkernel_boot_has_ended())
 			rcu_torture_fwd_prog_nr(rfp, &tested, &tested_tries);
 		if (rcu_inkernel_boot_has_ended())
 			rcu_torture_fwd_prog_cr(rfp);
-		unregister_oom_notifier(&rcutorture_oom_nb);
 
 		/* Avoid slow periods, better to test when busy. */
 		stutter_wait("rcu_torture_fwd_prog");
@@ -2159,6 +2157,7 @@ static int __init rcu_torture_fwd_prog_init(void)
 	mutex_lock(&rcu_fwd_mutex);
 	rcu_fwds = rfp;
 	mutex_unlock(&rcu_fwd_mutex);
+	register_oom_notifier(&rcutorture_oom_nb);
 	return torture_create_kthread(rcu_torture_fwd_prog, rfp, fwd_prog_task);
 }
 
@@ -2171,6 +2170,7 @@ static void rcu_torture_fwd_prog_cleanup(void)
 	mutex_lock(&rcu_fwd_mutex);
 	rcu_fwds = NULL;
 	mutex_unlock(&rcu_fwd_mutex);
+	unregister_oom_notifier(&rcutorture_oom_nb);
 	kfree(rfp);
 }
 
-- 
2.9.5

