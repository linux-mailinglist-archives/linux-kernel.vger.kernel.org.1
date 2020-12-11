Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89A072D6D49
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 02:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394775AbgLKBWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 20:22:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:36668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404805AbgLKBUr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 20:20:47 -0500
From:   paulmck@kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org, iamjoonsoo.kim@lge.com,
        andrii@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>, linux-mm@kvack.org
Subject: [PATCH v3 sl-b 5/6] rcu: Make call_rcu() print mem_dump_obj() info for double-freed callback
Date:   Thu, 10 Dec 2020 17:20:02 -0800
Message-Id: <20201211012003.16473-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201211011907.GA16110@paulmck-ThinkPad-P72>
References: <20201211011907.GA16110@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The debug-object double-free checks in __call_rcu() print out the
RCU callback function, which is usually sufficient to track down the
double free.  However, all uses of things like queue_rcu_work() will
have the same RCU callback function (rcu_work_rcufn() in this case),
so a diagnostic message for a double queue_rcu_work() needs more than
just the callback function.

This commit therefore calls mem_dump_obj() to dump out any additional
available information on the double-freed callback.

Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: <linux-mm@kvack.org>
Reported-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index b408dca..80ceee5 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2959,6 +2959,7 @@ static void check_cb_ovld(struct rcu_data *rdp)
 static void
 __call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
+	static atomic_t doublefrees;
 	unsigned long flags;
 	struct rcu_data *rdp;
 	bool was_alldone;
@@ -2972,8 +2973,10 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func)
 		 * Use rcu:rcu_callback trace event to find the previous
 		 * time callback was passed to __call_rcu().
 		 */
-		WARN_ONCE(1, "__call_rcu(): Double-freed CB %p->%pS()!!!\n",
-			  head, head->func);
+		if (atomic_inc_return(&doublefrees) < 4) {
+			pr_err("%s(): Double-freed CB %p->%pS()!!!  ", __func__, head, head->func);
+			mem_dump_obj(head);
+		}
 		WRITE_ONCE(head->func, rcu_leak_callback);
 		return;
 	}
-- 
2.9.5

