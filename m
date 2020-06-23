Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E476204541
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 02:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731671AbgFWAYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 20:24:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:51136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731486AbgFWAYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:24:45 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3ABA220780;
        Tue, 23 Jun 2020 00:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592871885;
        bh=fvg7edpN5UhbdDyxgVut+DhMZyQFLMSLs4aQ8/dgmE0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sfe5yPIxVv6YqTyMP7dj00iesVEr0E6J+SQ+7bCaf6M8jRsNEGzQJCxzslScYhsUz
         aBQPVZnIFuljLRQjhCCVHgNAskRoMfkdNgkgD3GN3Ss0Xe4b48q8S/exwlQaD1rfx/
         SpvOv/p7sdJHFgKBFka9WxmMrPX6+di/5zl7WoOE=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 2/5] rcu-tasks: Make rcu_tasks_postscan() be static
Date:   Mon, 22 Jun 2020 17:24:40 -0700
Message-Id: <20200623002443.25954-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623002423.GA25869@paulmck-ThinkPad-P72>
References: <20200623002423.GA25869@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The rcu_tasks_postscan() function is not used outside of RCU's tasks.h
file, so this commit makes it be static.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 91fee81..da200e5 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -402,7 +402,7 @@ static void rcu_tasks_pertask(struct task_struct *t, struct list_head *hop)
 }
 
 /* Processing between scanning taskslist and draining the holdout list. */
-void rcu_tasks_postscan(struct list_head *hop)
+static void rcu_tasks_postscan(struct list_head *hop)
 {
 	/*
 	 * Wait for tasks that are in the process of exiting.  This
-- 
2.9.5

