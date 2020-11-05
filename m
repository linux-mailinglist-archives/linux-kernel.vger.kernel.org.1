Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7EE2A8AB1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 00:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732250AbgKEXZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 18:25:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:40784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731060AbgKEXY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 18:24:57 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 503BE20786;
        Thu,  5 Nov 2020 23:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604618696;
        bh=AV28ppG8npANecF/aTt3ITUSYwCdAIjPjQ/rME20Tew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ULdu+vd/sYkDXHcj2T7o3az8qugfZ8caRnHKrB4CCePECYLuJcxkotBKST6FTuL4R
         JZkSx043oFqIbfg+8DoKysZOdZwjK+ww6yjHWTQQuVoSXfNJZLp/nbBcPF0MS2pJ79
         Q7W7FY+1pNySr9x5D+eclCraKU0/t06VQkQWFJjc=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Jakub Kicinski <kuba@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 2/7] rcu: Un-hide lockdep maps for !LOCKDEP
Date:   Thu,  5 Nov 2020 15:24:49 -0800
Message-Id: <20201105232454.19919-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201105232345.GA19179@paulmck-ThinkPad-P72>
References: <20201105232345.GA19179@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <kuba@kernel.org>

Currently, variables used only within lockdep expressions are flagged as
unused, requiring that these variables' declarations be decorated with
either #ifdef or __maybe_unused.  This results in ugly code.  This commit
therefore causes the RCU lock maps to be visible even when lockdep is not
enabled, thus removing the need for these decorations.  This approach
further relies on dead-code elimination to remove any references to
functions or variables that are not available in non-lockdep kernels.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate.h       | 9 +++++----
 include/linux/rcupdate_trace.h | 4 ++--
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 6cdd015..f9533bb 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -241,6 +241,11 @@ bool rcu_lockdep_current_cpu_online(void);
 static inline bool rcu_lockdep_current_cpu_online(void) { return true; }
 #endif /* #else #if defined(CONFIG_HOTPLUG_CPU) && defined(CONFIG_PROVE_RCU) */
 
+extern struct lockdep_map rcu_lock_map;
+extern struct lockdep_map rcu_bh_lock_map;
+extern struct lockdep_map rcu_sched_lock_map;
+extern struct lockdep_map rcu_callback_map;
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 
 static inline void rcu_lock_acquire(struct lockdep_map *map)
@@ -253,10 +258,6 @@ static inline void rcu_lock_release(struct lockdep_map *map)
 	lock_release(map, _THIS_IP_);
 }
 
-extern struct lockdep_map rcu_lock_map;
-extern struct lockdep_map rcu_bh_lock_map;
-extern struct lockdep_map rcu_sched_lock_map;
-extern struct lockdep_map rcu_callback_map;
 int debug_lockdep_rcu_enabled(void);
 int rcu_read_lock_held(void);
 int rcu_read_lock_bh_held(void);
diff --git a/include/linux/rcupdate_trace.h b/include/linux/rcupdate_trace.h
index 3e7919f..86c8f6c 100644
--- a/include/linux/rcupdate_trace.h
+++ b/include/linux/rcupdate_trace.h
@@ -11,10 +11,10 @@
 #include <linux/sched.h>
 #include <linux/rcupdate.h>
 
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-
 extern struct lockdep_map rcu_trace_lock_map;
 
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+
 static inline int rcu_read_lock_trace_held(void)
 {
 	return lock_is_held(&rcu_trace_lock_map);
-- 
2.9.5

