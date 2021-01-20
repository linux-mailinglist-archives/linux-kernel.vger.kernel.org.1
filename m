Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50EFA2FD25D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 15:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388685AbhATOJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 09:09:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:43980 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387649AbhATN1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 08:27:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611149174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HFz2mXiWK9cyR0546fhkjVi2i/3VDJZ0f5MwdCEislA=;
        b=oq4KdSETm7KlSxMAdvuhhuzXTf336XqEUsaNhLQtad4gUY1o5n0G1u7zJG3CIb3dxjPPlG
        Rzlr3THm9RIHG/hKRH8axNMRpiPiOHrP05k6GvKS054/bankadvacssUjDlGEHkYaJKqAK
        B6uo+q6gVbvU3mYwzvbjIcoqgzardhA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2253BAD6A;
        Wed, 20 Jan 2021 13:26:14 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     bpetkov@suse.com, linux-kernel@vger.kernel.org
Subject: [PATCH v4 01/15] static_call: Pull some static_call declarations to the type headers
Date:   Wed, 20 Jan 2021 14:25:59 +0100
Message-Id: <20210120132613.31487-2-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210120132613.31487-1-jgross@suse.com>
References: <20210120132613.31487-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Some static call declarations are going to be needed on low level header
files. Move the necessary material to the dedicated static call types
header to avoid inclusion dependency hell.

[jgross@suse.com: updated tools/include/linux/static_call_types.h, too]

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 include/linux/static_call.h             | 20 ------------------
 include/linux/static_call_types.h       | 27 +++++++++++++++++++++++++
 tools/include/linux/static_call_types.h | 27 +++++++++++++++++++++++++
 3 files changed, 54 insertions(+), 20 deletions(-)

diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index 695da4c9b338..39f39920bb29 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -107,26 +107,11 @@ extern void arch_static_call_transform(void *site, void *tramp, void *func, bool
 
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
 
 
-#define DECLARE_STATIC_CALL(name, func)					\
-	extern struct static_call_key STATIC_CALL_KEY(name);		\
-	extern typeof(func) STATIC_CALL_TRAMP(name);
-
 #define static_call_update(name, func)					\
 ({									\
 	BUILD_BUG_ON(!__same_type(*(func), STATIC_CALL_TRAMP(name)));	\
@@ -174,7 +159,6 @@ extern int static_call_text_reserved(void *start, void *end);
 	};								\
 	ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)
 
-#define static_call(name)	__static_call(name)
 #define static_call_cond(name)	(void)__static_call(name)
 
 #define EXPORT_STATIC_CALL(name)					\
@@ -207,7 +191,6 @@ struct static_call_key {
 	};								\
 	ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)
 
-#define static_call(name)	__static_call(name)
 #define static_call_cond(name)	(void)__static_call(name)
 
 static inline
@@ -252,9 +235,6 @@ struct static_call_key {
 		.func = NULL,						\
 	}
 
-#define static_call(name)						\
-	((typeof(STATIC_CALL_TRAMP(name))*)(STATIC_CALL_KEY(name).func))
-
 static inline void __static_call_nop(void) { }
 
 /*
diff --git a/include/linux/static_call_types.h b/include/linux/static_call_types.h
index 89135bb35bf7..08f78b1b88b4 100644
--- a/include/linux/static_call_types.h
+++ b/include/linux/static_call_types.h
@@ -4,6 +4,7 @@
 
 #include <linux/types.h>
 #include <linux/stringify.h>
+#include <linux/compiler.h>
 
 #define STATIC_CALL_KEY_PREFIX		__SCK__
 #define STATIC_CALL_KEY_PREFIX_STR	__stringify(STATIC_CALL_KEY_PREFIX)
@@ -32,4 +33,30 @@ struct static_call_site {
 	s32 key;
 };
 
+#define DECLARE_STATIC_CALL(name, func)					\
+	extern struct static_call_key STATIC_CALL_KEY(name);		\
+	extern typeof(func) STATIC_CALL_TRAMP(name);
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
diff --git a/tools/include/linux/static_call_types.h b/tools/include/linux/static_call_types.h
index 89135bb35bf7..08f78b1b88b4 100644
--- a/tools/include/linux/static_call_types.h
+++ b/tools/include/linux/static_call_types.h
@@ -4,6 +4,7 @@
 
 #include <linux/types.h>
 #include <linux/stringify.h>
+#include <linux/compiler.h>
 
 #define STATIC_CALL_KEY_PREFIX		__SCK__
 #define STATIC_CALL_KEY_PREFIX_STR	__stringify(STATIC_CALL_KEY_PREFIX)
@@ -32,4 +33,30 @@ struct static_call_site {
 	s32 key;
 };
 
+#define DECLARE_STATIC_CALL(name, func)					\
+	extern struct static_call_key STATIC_CALL_KEY(name);		\
+	extern typeof(func) STATIC_CALL_TRAMP(name);
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
2.26.2

