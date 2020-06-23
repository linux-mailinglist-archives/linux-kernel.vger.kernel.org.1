Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4768D204530
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 02:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731696AbgFWAW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 20:22:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:48606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731571AbgFWAVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:21:53 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55EEB20781;
        Tue, 23 Jun 2020 00:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592871713;
        bh=L2y6WsRc1VL94lPLYQQt9gYYbdxRkdtH9oSrKqqAucM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kh7SXq8VIhRfMtV3uaDi/EZkWrxccDjjoDlN0AW4NJrKWUhn6wWhbGUJh1rEmF+fd
         10OarY1rKYD809lBsSjrTGm69s55h3c8Jy6PajwTz4DlRhtKbPlFL6pjCRglkRW4jY
         5oAqWfeOw586bI6pmHFyWtqkbtd7MiOnC2wGVqE4=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 20/26] rcu: gp_max is protected by root rcu_node's lock
Date:   Mon, 22 Jun 2020 17:21:41 -0700
Message-Id: <20200623002147.25750-20-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623002128.GA25456@paulmck-ThinkPad-P72>
References: <20200623002128.GA25456@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yang <richard.weiyang@linux.alibaba.com>

gp_max is protected by root rcu_node's lock, let's move the definition
to the place where comments indicate.

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 575745f..09ec93b 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -302,6 +302,8 @@ struct rcu_state {
 	u8	boost ____cacheline_internodealigned_in_smp;
 						/* Subject to priority boost. */
 	unsigned long gp_seq;			/* Grace-period sequence #. */
+	unsigned long gp_max;			/* Maximum GP duration in */
+						/*  jiffies. */
 	struct task_struct *gp_kthread;		/* Task for grace periods. */
 	struct swait_queue_head gp_wq;		/* Where GP task waits. */
 	short gp_flags;				/* Commands for GP task. */
@@ -347,8 +349,6 @@ struct rcu_state {
 						/*  a reluctant CPU. */
 	unsigned long n_force_qs_gpstart;	/* Snapshot of n_force_qs at */
 						/*  GP start. */
-	unsigned long gp_max;			/* Maximum GP duration in */
-						/*  jiffies. */
 	const char *name;			/* Name of structure. */
 	char abbr;				/* Abbreviated name. */
 
-- 
2.9.5

