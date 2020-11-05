Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0302A8AD7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 00:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732585AbgKEXji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 18:39:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:43304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730895AbgKEXjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 18:39:36 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CEC620759;
        Thu,  5 Nov 2020 23:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604619575;
        bh=W2PCuQShH0esQHNKGU2ub4JmUxBHu2jmMJe7CBqNC3Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wKsmaPY76qEJXosDI2cNCmC7nwqXuu2V3PbcwUJBcwT/xuktyt2I0Hpb492LphZSn
         Dk3hkiJ2EL6RWWjeVCMLHN8eWo5dnL+o/r3rCYZOEXfkDcQ/sSjmL0ByWnwfZfgt2C
         op4e95gaZmNdBd5OMfJjAOauJYCP7f4/6zDCzKsM=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 2/4] rcu-tasks: Convert rcu_tasks_wait_gp() for-loop to while-loop
Date:   Thu,  5 Nov 2020 15:39:31 -0800
Message-Id: <20201105233933.20748-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201105233900.GA20676@paulmck-ThinkPad-P72>
References: <20201105233900.GA20676@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The infinite for-loop in rcu_tasks_wait_gp() has its only exit at the
top of the loop, so this commit does the straightforward conversion to
a while-loop, thus saving a few lines.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index d5d9f2d..a93271f 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -338,14 +338,11 @@ static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
 	if (fract > HZ)
 		fract = HZ;
 
-	for (;;) {
+	while (!list_empty(&holdouts)) {
 		bool firstreport;
 		bool needreport;
 		int rtst;
 
-		if (list_empty(&holdouts))
-			break;
-
 		/* Slowly back off waiting for holdouts */
 		set_tasks_gp_state(rtp, RTGS_WAIT_SCAN_HOLDOUTS);
 		schedule_timeout_idle(HZ/fract);
-- 
2.9.5

