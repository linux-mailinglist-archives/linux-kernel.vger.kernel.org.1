Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 738392EB74A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 02:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbhAFBCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 20:02:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:57068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbhAFBCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 20:02:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4147022E00;
        Wed,  6 Jan 2021 01:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609894887;
        bh=ppqx1xvTKmXeI03LlY9ixmkXWbk7Emaooe7735KUcu8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PBqW5hEGQLWqcIgnzdW/OqDD0/BLpEDJaKxyrcQQR+cPmq7pQKdqcby3kKcxKGyQf
         QnDWqumg6HpMsMKapPSHloWRfUJxtkA7GPCgVXQgSjxL+0uxUgtCjrfzRZx/4Tuahd
         SLv3HjjMITJ5DxxnX9St8ttosf3pkwnC21HQ6C621GpWs0GxyY76eeqRUE5nMBHq6o
         0SPSJM5OBEpvVn+kqFSAyMZtR4286nEJBC+aIlDKIXFeBTa3lEQ/sfRJAqkH/YqDUB
         sD/0Ic0tyamoeLF7aI4ZyQqOhO7rJ9ypV6f9Zij2xnspUox3r0rrESNEN3XBbvcgTL
         ZxUVaUfqZabzg==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 2/3] rcu: Introduce kfree_rcu() single-argument macro
Date:   Tue,  5 Jan 2021 17:01:24 -0800
Message-Id: <20210106010125.12802-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106010102.GA12737@paulmck-ThinkPad-P72>
References: <20210106010102.GA12737@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

There is a kvfree_rcu() single argument macro that handles pointers
returned by kvmalloc(). Even though it also handles pointer returned by
kmalloc(), readability suffers.

This commit therefore updates the kfree_rcu() macro to explicitly pair
with kmalloc(), thus improving readability.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate.h | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index de08264..b95373e 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -851,8 +851,9 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
 
 /**
  * kfree_rcu() - kfree an object after a grace period.
- * @ptr:	pointer to kfree
- * @rhf:	the name of the struct rcu_head within the type of @ptr.
+ * @ptr: pointer to kfree for both single- and double-argument invocations.
+ * @rhf: the name of the struct rcu_head within the type of @ptr,
+ *       but only for double-argument invocations.
  *
  * Many rcu callbacks functions just call kfree() on the base structure.
  * These functions are trivial, but their size adds up, and furthermore
@@ -875,13 +876,7 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
  * The BUILD_BUG_ON check must not involve any function calls, hence the
  * checks are done in macros here.
  */
-#define kfree_rcu(ptr, rhf)						\
-do {									\
-	typeof (ptr) ___p = (ptr);					\
-									\
-	if (___p)							\
-		__kvfree_rcu(&((___p)->rhf), offsetof(typeof(*(ptr)), rhf)); \
-} while (0)
+#define kfree_rcu kvfree_rcu
 
 /**
  * kvfree_rcu() - kvfree an object after a grace period.
@@ -913,7 +908,14 @@ do {									\
 	kvfree_rcu_arg_2, kvfree_rcu_arg_1)(__VA_ARGS__)
 
 #define KVFREE_GET_MACRO(_1, _2, NAME, ...) NAME
-#define kvfree_rcu_arg_2(ptr, rhf) kfree_rcu(ptr, rhf)
+#define kvfree_rcu_arg_2(ptr, rhf)					\
+do {									\
+	typeof (ptr) ___p = (ptr);					\
+									\
+	if (___p)							\
+		__kvfree_rcu(&((___p)->rhf), offsetof(typeof(*(ptr)), rhf)); \
+} while (0)
+
 #define kvfree_rcu_arg_1(ptr)					\
 do {								\
 	typeof(ptr) ___p = (ptr);				\
-- 
2.9.5

