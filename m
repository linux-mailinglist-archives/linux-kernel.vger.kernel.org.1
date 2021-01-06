Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5AE32EB74D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 02:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbhAFBCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 20:02:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:57098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725769AbhAFBCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 20:02:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 792ED22EBF;
        Wed,  6 Jan 2021 01:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609894887;
        bh=iA8otzrFeXuxiPM8h5m7YDsTdiUWeK2SWvY5mSJP/6E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=avJUfp9zPLAxpN0H3iwy+/6Z0B7NU+WpJYPSxnL+rwsS7O+hW+VcSA5rjJwl/OgY2
         wJj7Zp88cgOIdOTswtIv4K3LHFM1y5VFPD3Xrw6fQTAgpZc1kwTKkrxTVj/Lj4fA4P
         94/OdXsz003I8vUj5jCHrPwwvmAAitSWT5k8TfcEbVBX8q0E3/pwRPH/+BUwKnP60N
         jQifSDf1lmUEb0LIKREW4Ynm4tbbD8xTvMBFOUV5AK3N1LUdlp6DvvXDqut9KJjbwk
         OVU7cbkbNmGbv+a7azQwpTjVb2n2Cy/l1SThu1XOppayn1MbLYf0BVe2u1kwn0qcQt
         FpEqOv8ID8nuA==
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
Subject: [PATCH tip/core/rcu 3/3] rcu: Eliminate the __kvfree_rcu() macro
Date:   Tue,  5 Jan 2021 17:01:25 -0800
Message-Id: <20210106010125.12802-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106010102.GA12737@paulmck-ThinkPad-P72>
References: <20210106010102.GA12737@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

This commit open-codes the __kvfree_rcu() macro, thus saving a
few lines of code and improving readability.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate.h | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index b95373e..f1576cd 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -840,15 +840,6 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
  */
 #define __is_kvfree_rcu_offset(offset) ((offset) < 4096)
 
-/*
- * Helper macro for kfree_rcu() to prevent argument-expansion eyestrain.
- */
-#define __kvfree_rcu(head, offset) \
-	do { \
-		BUILD_BUG_ON(!__is_kvfree_rcu_offset(offset)); \
-		kvfree_call_rcu(head, (rcu_callback_t)(unsigned long)(offset)); \
-	} while (0)
-
 /**
  * kfree_rcu() - kfree an object after a grace period.
  * @ptr: pointer to kfree for both single- and double-argument invocations.
@@ -866,7 +857,7 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
  * Because the functions are not allowed in the low-order 4096 bytes of
  * kernel virtual memory, offsets up to 4095 bytes can be accommodated.
  * If the offset is larger than 4095 bytes, a compile-time error will
- * be generated in __kvfree_rcu(). If this error is triggered, you can
+ * be generated in kvfree_rcu_arg_2(). If this error is triggered, you can
  * either fall back to use of call_rcu() or rearrange the structure to
  * position the rcu_head structure into the first 4096 bytes.
  *
@@ -912,8 +903,11 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
 do {									\
 	typeof (ptr) ___p = (ptr);					\
 									\
-	if (___p)							\
-		__kvfree_rcu(&((___p)->rhf), offsetof(typeof(*(ptr)), rhf)); \
+	if (___p) {									\
+		BUILD_BUG_ON(!__is_kvfree_rcu_offset(offsetof(typeof(*(ptr)), rhf)));	\
+		kvfree_call_rcu(&((___p)->rhf), (rcu_callback_t)(unsigned long)		\
+			(offsetof(typeof(*(ptr)), rhf)));				\
+	}										\
 } while (0)
 
 #define kvfree_rcu_arg_1(ptr)					\
-- 
2.9.5

