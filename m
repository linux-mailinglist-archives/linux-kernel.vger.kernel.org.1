Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6B32A8B02
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 00:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733156AbgKEXs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 18:48:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:45970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732498AbgKEXrY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 18:47:24 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 475A82151B;
        Thu,  5 Nov 2020 23:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604620043;
        bh=RmqrHKJx6BYaq4MH6bNxDrXByH53ETHnBnon0isWHcQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wfnrowlSUQ7MFGxQWY/ccC/2ZFvl3KPTjqXwT3OYFIfv/YtVUynz/C6e+PQFnw/yW
         XYgNUhekE1f5eqM2D2SPLkMO++qFi1MYMj/6q8zgDxK1mibDeI+3PV1RsA7NDrJMI7
         pBfVKy0RrfZZRIgWPITewVpPirnctRtaimlbjUYQ=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 04/28] torture: Periodically pause in stutter_wait()
Date:   Thu,  5 Nov 2020 15:46:55 -0800
Message-Id: <20201105234719.23307-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201105234658.GA23142@paulmck-ThinkPad-P72>
References: <20201105234658.GA23142@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Running locktorture scenario LOCK05 results in hangs:

tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --torture lock --duration 3 --configs LOCK05

The lock_torture_writer() kthreads set themselves to MAX_NICE while
running SCHED_OTHER.  Other locktorture kthreads run at default niceness,
also SCHED_OTHER.  This results in these other locktorture kthreads
indefinitely preempting the lock_torture_writer() kthreads.  Note that
the cond_resched() in the stutter_wait() function's loop is ineffective
because this scenario is built with CONFIG_PREEMPT=y.

It is not clear that such indefinite preemption is supposed to happen, but
in the meantime this commit prevents kthreads running in stutter_wait()
from being completely CPU-bound, thus allowing the other threads to get
some CPU in a timely fashion.  This commit also uses hrtimers to provide
very short sleeps to avoid degrading the sudden-on testing that stutter
is supposed to provide.

Reviewed-by: Davidlohr Bueso <dbueso@suse.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/torture.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/kernel/torture.c b/kernel/torture.c
index 1061492..5488ad2 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -602,8 +602,11 @@ static int stutter_gap;
  */
 bool stutter_wait(const char *title)
 {
-	int spt;
+	ktime_t delay;
+	unsigned i = 0;
+	int oldnice;
 	bool ret = false;
+	int spt;
 
 	cond_resched_tasks_rcu_qs();
 	spt = READ_ONCE(stutter_pause_test);
@@ -612,8 +615,17 @@ bool stutter_wait(const char *title)
 		if (spt == 1) {
 			schedule_timeout_interruptible(1);
 		} else if (spt == 2) {
-			while (READ_ONCE(stutter_pause_test))
+			oldnice = task_nice(current);
+			set_user_nice(current, MAX_NICE);
+			while (READ_ONCE(stutter_pause_test)) {
+				if (!(i++ & 0xffff)) {
+					set_current_state(TASK_INTERRUPTIBLE);
+					delay = 10 * NSEC_PER_USEC;
+					schedule_hrtimeout(&delay, HRTIMER_MODE_REL);
+				}
 				cond_resched();
+			}
+			set_user_nice(current, oldnice);
 		} else {
 			schedule_timeout_interruptible(round_jiffies_relative(HZ));
 		}
-- 
2.9.5

