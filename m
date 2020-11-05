Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 417622A8AF5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 00:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732828AbgKEXrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 18:47:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:45930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732591AbgKEXrY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 18:47:24 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A964F217A0;
        Thu,  5 Nov 2020 23:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604620043;
        bh=8dAvn0YKpaz7R2OElvDxDCJwZrTX1on4SeZcENj0nOo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TRlObfciPu0Cyo7hxhJdSgMCmQsK8Xo5ljFZbNAKSBMaiauNSmk92uqfCVLxN+zn6
         VI5ga2/UMvWo3xbggwyC9AWXhYW/RqUGK2a+rYxOgzlVd0/GReIziw83A1EcPkk/yl
         Lo/f5+2nNuq1N+k94FT1I12p/TaOhEc9Hy/MOow8=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 05/28] torture: Make torture_stutter() use hrtimer
Date:   Thu,  5 Nov 2020 15:46:56 -0800
Message-Id: <20201105234719.23307-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201105234658.GA23142@paulmck-ThinkPad-P72>
References: <20201105234658.GA23142@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The torture_stutter() function uses schedule_timeout_interruptible()
to time the stutter duration, but this can miss race conditions due to
its being time-synchronized with everything else that is based on the
timer wheels.  This commit therefore converts torture_stutter() to use
the high-resolution timers via schedule_hrtimeout(), and also to fuzz
the stutter interval.  While in the area, this commit also limits the
spin-loop portion of the stutter_wait() function's wait loop to two
jiffies, down from about one second.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/torture.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/kernel/torture.c b/kernel/torture.c
index 5488ad2..d8bdd9a 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -641,20 +641,27 @@ EXPORT_SYMBOL_GPL(stutter_wait);
  */
 static int torture_stutter(void *arg)
 {
+	ktime_t delay;
+	DEFINE_TORTURE_RANDOM(rand);
 	int wtime;
 
 	VERBOSE_TOROUT_STRING("torture_stutter task started");
 	do {
 		if (!torture_must_stop() && stutter > 1) {
 			wtime = stutter;
-			if (stutter > HZ + 1) {
+			if (stutter > 2) {
 				WRITE_ONCE(stutter_pause_test, 1);
-				wtime = stutter - HZ - 1;
-				schedule_timeout_interruptible(wtime);
-				wtime = HZ + 1;
+				wtime = stutter - 3;
+				delay = ktime_divns(NSEC_PER_SEC * wtime, HZ);
+				delay += (torture_random(&rand) >> 3) % NSEC_PER_MSEC;
+				set_current_state(TASK_INTERRUPTIBLE);
+				schedule_hrtimeout(&delay, HRTIMER_MODE_REL);
+				wtime = 2;
 			}
 			WRITE_ONCE(stutter_pause_test, 2);
-			schedule_timeout_interruptible(wtime);
+			delay = ktime_divns(NSEC_PER_SEC * wtime, HZ);
+			set_current_state(TASK_INTERRUPTIBLE);
+			schedule_hrtimeout(&delay, HRTIMER_MODE_REL);
 		}
 		WRITE_ONCE(stutter_pause_test, 0);
 		if (!torture_must_stop())
-- 
2.9.5

