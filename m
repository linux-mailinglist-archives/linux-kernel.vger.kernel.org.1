Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D29A25801F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 20:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbgHaSDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 14:03:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:36142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728776AbgHaSB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:01:26 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45D4221556;
        Mon, 31 Aug 2020 18:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598896884;
        bh=90MadMgN8o3HpOyPeyMVAosKnpX8VPQY4+XK0zBBVd4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uZFn5zscUsOX/1eG7bhNjgA/uanhfNLuFkCfWfPnP41VxwLPvWhhV5Pk/wu/DKC2u
         gwvAFQ5LTarlmx7AT6FkEhxNf5z3VzLfJ2UnGYzOVf/DB+cz2AEb85ZZ9CE6435rFX
         IjHHpnWh3xsJzwdB8daWi27tEIZz+5C+rlrPEyKo=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 14/24] rcu: Add READ_ONCE() to rcu_do_batch() access to rcu_cpu_stall_ftrace_dump
Date:   Mon, 31 Aug 2020 11:01:06 -0700
Message-Id: <20200831180116.32690-14-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831180050.GA32590@paulmck-ThinkPad-P72>
References: <20200831180050.GA32590@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Given that sysfs can change the value of rcu_cpu_stall_ftrace_dump at any
time, this commit adds a READ_ONCE() to the accesses to that variable.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_stall.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index a1780a6..0fde39b 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -623,7 +623,7 @@ static void check_cpu_stall(struct rcu_data *rdp)
 
 		/* We haven't checked in, so go dump stack. */
 		print_cpu_stall(gps);
-		if (rcu_cpu_stall_ftrace_dump)
+		if (READ_ONCE(rcu_cpu_stall_ftrace_dump))
 			rcu_ftrace_dump(DUMP_ALL);
 
 	} else if (rcu_gp_in_progress() &&
@@ -632,7 +632,7 @@ static void check_cpu_stall(struct rcu_data *rdp)
 
 		/* They had a few time units to dump stack, so complain. */
 		print_other_cpu_stall(gs2, gps);
-		if (rcu_cpu_stall_ftrace_dump)
+		if (READ_ONCE(rcu_cpu_stall_ftrace_dump))
 			rcu_ftrace_dump(DUMP_ALL);
 	}
 }
-- 
2.9.5

