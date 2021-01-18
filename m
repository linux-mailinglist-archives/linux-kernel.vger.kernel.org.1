Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 490712FA2A7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 15:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392757AbhAROOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 09:14:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:42398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390886AbhARONR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 09:13:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A99D322B49;
        Mon, 18 Jan 2021 14:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610979156;
        bh=/9YqueDD6mDPFdGvI3qBNOd4tWcc0HxJ2vpRRbZaonA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uR4LB8ak2ZlvEt/aHcUTsyXUKfPDgKtWvVhx7Dh5ou2Wy9cc6G2Dd+M/f2mBKwe2c
         FnrC0LBp7YtVFRjRg/QOy4SuSj28xjZ8ViRR2xkmttPgDoN3pm7e0lVnXfTIvcClv+
         BCWnInQjmgcEAC5fVA6rSe1TMGDja3iCUnc2ax+ANbkf7nM+UNx46oIrqBqWz5sVAd
         XDrPzkzRUqaswHbhuoqSl/3hwnJnj07XYQ1OqPRDqYjSVV1fAm4aIDNsIXmPX70/9z
         bwoPuNc5+LDMyBpOSRQB8BLLmG6nIiy7a8MxkhYgfVot7xxQOYPHPGboFJz4uuu0vY
         voYSyEpPlCyuw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Mel Gorman <mgorman@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Michal Hocko <mhocko@suse.com>
Subject: [RFC PATCH 3/8] static_call: Pull some static_call declarations to the type headers
Date:   Mon, 18 Jan 2021 15:12:18 +0100
Message-Id: <20210118141223.123667-4-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210118141223.123667-1-frederic@kernel.org>
References: <20210118141223.123667-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Some static call declarations are going to be needed on low level header
files. Move the necessary material to the dedicated static call types
header to avoid inclusion dependency hell.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/static_call.h       | 23 -----------------------
 include/linux/static_call_types.h | 29 +++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 23 deletions(-)

diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index 076f124c957a..c272ccd811de 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -107,26 +107,10 @@ extern void arch_static_call_transform(void *site, void *tramp, void *func, bool
 
 #define STATIC_CALL_TRAMP_ADDR(name) &STATIC_CALL_TRAMP(name)
 
-/*
- * __ADDRESSABLE() is used to ensure the key symbol doesn't get stripped from
- * the symbol table so that objtool can reference it when it generates the
- * .static_call_sites section.
- */
-#define __static_call(name)						\
-({									\
-	__ADDRESSABLE(STATIC_CALL_KEY(name));				\
-	&STATIC_CALL_TRAMP(name);					\
-})
-
 #else
 #define STATIC_CALL_TRAMP_ADDR(name) NULL
 #endif
 
-
-#define DECLARE_STATIC_CALL(name, func)					\
-	extern struct static_call_key STATIC_CALL_KEY(name);		\
-	extern typeof(func) STATIC_CALL_TRAMP(name);
-
 #define static_call_update(name, func)					\
 ({									\
 	BUILD_BUG_ON(!__same_type(*(func), STATIC_CALL_TRAMP(name)));	\
@@ -134,8 +118,6 @@ extern void arch_static_call_transform(void *site, void *tramp, void *func, bool
 			     STATIC_CALL_TRAMP_ADDR(name), func);	\
 })
 
-extern long __static_call_return0(void);
-
 #ifdef CONFIG_HAVE_STATIC_CALL_INLINE
 
 extern int __init static_call_init(void);
@@ -176,7 +158,6 @@ extern int static_call_text_reserved(void *start, void *end);
 	};								\
 	ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)
 
-#define static_call(name)	__static_call(name)
 #define static_call_cond(name)	(void)__static_call(name)
 
 #define EXPORT_STATIC_CALL(name)					\
@@ -209,7 +190,6 @@ struct static_call_key {
 	};								\
 	ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)
 
-#define static_call(name)	__static_call(name)
 #define static_call_cond(name)	(void)__static_call(name)
 
 static inline
@@ -254,9 +234,6 @@ struct static_call_key {
 		.func = NULL,						\
 	}
 
-#define static_call(name)						\
-	((typeof(STATIC_CALL_TRAMP(name))*)(STATIC_CALL_KEY(name).func))
-
 static inline void __static_call_nop(void) { }
 
 /*
diff --git a/include/linux/static_call_types.h b/include/linux/static_call_types.h
index 89135bb35bf7..632a9e79c003 100644
--- a/include/linux/static_call_types.h
+++ b/include/linux/static_call_types.h
@@ -4,6 +4,7 @@
 
 #include <linux/types.h>
 #include <linux/stringify.h>
+#include <linux/compiler.h>
 
 #define STATIC_CALL_KEY_PREFIX		__SCK__
 #define STATIC_CALL_KEY_PREFIX_STR	__stringify(STATIC_CALL_KEY_PREFIX)
@@ -32,4 +33,32 @@ struct static_call_site {
 	s32 key;
 };
 
+#define DECLARE_STATIC_CALL(name, func)					\
+	extern struct static_call_key STATIC_CALL_KEY(name);		\
+	extern typeof(func) STATIC_CALL_TRAMP(name);
+
+extern long __static_call_return0(void);
+
+#ifdef CONFIG_HAVE_STATIC_CALL
+
+/*
+ * __ADDRESSABLE() is used to ensure the key symbol doesn't get stripped from
+ * the symbol table so that objtool can reference it when it generates the
+ * .static_call_sites section.
+ */
+#define __static_call(name)						\
+({									\
+	__ADDRESSABLE(STATIC_CALL_KEY(name));				\
+	&STATIC_CALL_TRAMP(name);					\
+})
+
+#define static_call(name)	__static_call(name)
+
+#else
+
+#define static_call(name)						\
+	((typeof(STATIC_CALL_TRAMP(name))*)(STATIC_CALL_KEY(name).func))
+
+#endif /* CONFIG_HAVE_STATIC_CALL */
+
 #endif /* _STATIC_CALL_TYPES_H */
-- 
2.25.1

