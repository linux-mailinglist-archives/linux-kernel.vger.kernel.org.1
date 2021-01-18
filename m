Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16AE12FA2A8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 15:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392717AbhARONo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 09:13:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:42344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391744AbhARONP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 09:13:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 56A0722BF3;
        Mon, 18 Jan 2021 14:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610979154;
        bh=1+HfaV0EjZcRW6SrSxh4RjyC9M2Z5uRcOlAOV1nlcOA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q61LY/goYwDL8ASCq98RA+ZkKAyvmyymx3s0DCG41Aa/htDGyBSgERlfv1oH7bAut
         baAJhG3kBDdq66PR5fiCzJrIWab8+ibnJy+0m1C/oQIt+n3kUX9pCWRDf9sPd0ms+Q
         3wg2+fLtGRWcIfi6WuRA0fwyd272UhriYvyXPLy121Vx0NCCdhoJpiOVjJIvRxM/UD
         9bxWkY5yvFg0aOcrkKtyNIkwR2hd5wnBazRiWNzaQiF5m+CXqycVvPPlhHl1PrGGXw
         bLZ/cJcAlS2AYHO3obLxeuSAD4uHauAGqbNZCpflpmeN1l4Zts/0LNG1ALcI+B14cU
         nSQJH8dFo/YqA==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Michal Hocko <mhocko@suse.com>
Subject: [RFC PATCH 2/8] static_call: Provide DEFINE_STATIC_CALL_RET0()
Date:   Mon, 18 Jan 2021 15:12:17 +0100
Message-Id: <20210118141223.123667-3-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210118141223.123667-1-frederic@kernel.org>
References: <20210118141223.123667-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DECLARE_STATIC_CALL() must pass the original function targeted for a
given static call. But DEFINE_STATIC_CALL() may want to initialize it as
off. In this case we can't pass NULL (for functions without return value)
or __static_call_return0 (for functions returning a value) directly
to DEFINE_STATIC_CALL() as that may trigger a static call redeclaration
with a different function prototype. Type casts neither can work around
that as they don't get along with typeof().

The proper way to do that for functions that don't return a value is
to use DEFINE_STATIC_CALL_NULL(). But functions returning a actual value
don't have an equivalent yet.

Provide DEFINE_STATIC_CALL_RET0() to solve this situation.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/static_call.h | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index 9f05d60aca70..076f124c957a 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -160,13 +160,13 @@ extern void __static_call_update(struct static_call_key *key, void *tramp, void
 extern int static_call_mod_init(struct module *mod);
 extern int static_call_text_reserved(void *start, void *end);
 
-#define DEFINE_STATIC_CALL(name, _func)					\
+#define __DEFINE_STATIC_CALL(name, _func, _func_init)			\
 	DECLARE_STATIC_CALL(name, _func);				\
 	struct static_call_key STATIC_CALL_KEY(name) = {		\
-		.func = _func,						\
+		.func = _func_init,					\
 		.type = 1,						\
 	};								\
-	ARCH_DEFINE_STATIC_CALL_TRAMP(name, _func)
+	ARCH_DEFINE_STATIC_CALL_TRAMP(name, _func_init)
 
 #define DEFINE_STATIC_CALL_NULL(name, _func)				\
 	DECLARE_STATIC_CALL(name, _func);				\
@@ -195,12 +195,12 @@ struct static_call_key {
 	void *func;
 };
 
-#define DEFINE_STATIC_CALL(name, _func)					\
+#define __DEFINE_STATIC_CALL(name, _func _func_init)			\
 	DECLARE_STATIC_CALL(name, _func);				\
 	struct static_call_key STATIC_CALL_KEY(name) = {		\
-		.func = _func,						\
+		.func = _func_init,					\
 	};								\
-	ARCH_DEFINE_STATIC_CALL_TRAMP(name, _func)
+	ARCH_DEFINE_STATIC_CALL_TRAMP(name, _func_init)
 
 #define DEFINE_STATIC_CALL_NULL(name, _func)				\
 	DECLARE_STATIC_CALL(name, _func);				\
@@ -242,10 +242,10 @@ struct static_call_key {
 	void *func;
 };
 
-#define DEFINE_STATIC_CALL(name, _func)					\
+#define __DEFINE_STATIC_CALL(name, _func, _func_init)			\
 	DECLARE_STATIC_CALL(name, _func);				\
 	struct static_call_key STATIC_CALL_KEY(name) = {		\
-		.func = _func,						\
+		.func = _func_init,					\
 	}
 
 #define DEFINE_STATIC_CALL_NULL(name, _func)				\
@@ -297,4 +297,10 @@ static inline int static_call_text_reserved(void *start, void *end)
 
 #endif /* CONFIG_HAVE_STATIC_CALL */
 
+#define DEFINE_STATIC_CALL(name, _func)					\
+	__DEFINE_STATIC_CALL(name, _func, _func)
+
+#define DEFINE_STATIC_CALL_RET0(name, _func)				\
+	__DEFINE_STATIC_CALL(name, _func, __static_call_return0)
+
 #endif /* _LINUX_STATIC_CALL_H */
-- 
2.25.1

