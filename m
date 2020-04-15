Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFD091AAFBA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 19:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411179AbgDORbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 13:31:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:46440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2411133AbgDORbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 13:31:08 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EA4421841;
        Wed, 15 Apr 2020 17:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586971867;
        bh=JxgKlG4fjDGWQjaJg9tkjDnCcb/RI0ZUVz7/OvSjvBQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JbDboS9F1QwHTfCbyD2Vuz8GDQ6UQ2oTraAm+bvYchQ47V2re10uUVjvxztgcFBZd
         ZbyS88m7Cpy8P8hZ8yWAlTLp9zBbM0NWPjDaeTL4XgOUUweFEw8YqLvG9vgChhaTvX
         FoG5ghld+hCN8CAd0/IKdpZ8NMyLU2ho/bXuPzuo=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 18/18] rcutorture: Convert ULONG_CMP_LT() to time_before()
Date:   Wed, 15 Apr 2020 10:31:00 -0700
Message-Id: <20200415173100.9927-18-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415173037.GA9768@paulmck-ThinkPad-P72>
References: <20200415173037.GA9768@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit converts three ULONG_CMP_LT() invocations in rcutorture to
time_before() to reflect the fact that they are comparing timestamps to
the jiffies counter.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index c7b7594b..fc96147 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -848,7 +848,7 @@ static int rcu_torture_boost(void *arg)
 
 		/* Wait for the next test interval. */
 		oldstarttime = boost_starttime;
-		while (ULONG_CMP_LT(jiffies, oldstarttime)) {
+		while (time_before(jiffies, oldstarttime)) {
 			schedule_timeout_interruptible(oldstarttime - jiffies);
 			stutter_wait("rcu_torture_boost");
 			if (torture_must_stop())
@@ -858,7 +858,7 @@ static int rcu_torture_boost(void *arg)
 		/* Do one boost-test interval. */
 		endtime = oldstarttime + test_boost_duration * HZ;
 		call_rcu_time = jiffies;
-		while (ULONG_CMP_LT(jiffies, endtime)) {
+		while (time_before(jiffies, endtime)) {
 			/* If we don't have a callback in flight, post one. */
 			if (!smp_load_acquire(&rbi.inflight)) {
 				/* RCU core before ->inflight = 1. */
@@ -929,7 +929,7 @@ rcu_torture_fqs(void *arg)
 	VERBOSE_TOROUT_STRING("rcu_torture_fqs task started");
 	do {
 		fqs_resume_time = jiffies + fqs_stutter * HZ;
-		while (ULONG_CMP_LT(jiffies, fqs_resume_time) &&
+		while (time_before(jiffies, fqs_resume_time) &&
 		       !kthread_should_stop()) {
 			schedule_timeout_interruptible(1);
 		}
-- 
2.9.5

