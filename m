Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A45D02888B1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 14:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733159AbgJIMaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 08:30:02 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34613 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733111AbgJIMaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 08:30:00 -0400
Received: by mail-ed1-f67.google.com with SMTP id x1so9161246eds.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 05:29:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AJLwlDreOTu9E3bmosdSuLK6PqXZ1aXx/xmTJ/4R+lc=;
        b=STbt1PB7h8+1n22m9awQQ7sGHHLZyXNUn0oxi7/LQpTarUJT2nR3oOaK6cM1c6BRaf
         w/E4dH8M+3jtn3HjsVctUa5CTlR/XdAdsLKtV9ToRGfTOMSGmq0dalmGLG/dHxicMbTr
         cIiiplH2b6f+P9N5O7tu1hOg91nJ3WFR/o+4g5PZ2Uucx5YBpYNLRjH3lQyHKIrH1Usi
         vC8iOSOdGkSdGvFjbRExAjGLgLy1JvDLoOzSPzF5lX7/dJNrjUEIAZ6LXi1vcN9WGefu
         zrRSSkA+fRZ5pBrAchmeYvT7CwwyilIMPnlxySISBz3kRSrb7DwWdxcL5B0wWbuzUjdZ
         cv1Q==
X-Gm-Message-State: AOAM531caVzraAv7/ZYhTJsYgV9Z0BRgwptrg38Oq5GrtMO4rgekh99E
        FZQ7wb1CsFT68sotx17ieBs=
X-Google-Smtp-Source: ABdhPJxy7R8HNTZ2KqMfTNdiFQMawGS+RQGR63Y146SRA6DdonLwQXOG6Kp7I8ZbUftztqPvRjMV9w==
X-Received: by 2002:aa7:d30d:: with SMTP id p13mr11152960edq.315.1602246596809;
        Fri, 09 Oct 2020 05:29:56 -0700 (PDT)
Received: from tiehlicka.suse.cz (ip-85-160-42-169.eurotel.cz. [85.160.42.169])
        by smtp.gmail.com with ESMTPSA id q27sm6412701ejd.74.2020.10.09.05.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 05:29:56 -0700 (PDT)
From:   Michal Hocko <mhocko@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Mel Gorman <mgorman@suse.de>,
        Frederic Weisbecker <fweisbecker@suse.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: [RFC PATCH v2 1/5] jump_label: split out declaration parts into its own headers
Date:   Fri,  9 Oct 2020 14:29:22 +0200
Message-Id: <20201009122926.29962-2-mhocko@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201009122926.29962-1-mhocko@kernel.org>
References: <20201007120401.11200-1-mhocko@kernel.org>
 <20201009122926.29962-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

Follow up patch would like to add a static key into kernel.h and that
requires a declaration of the key in the same file. Including
jump_label.h into kernel.h is not possible due to headers dependencies.

Separate parts needed for declaration into its own header which doesn't
depend on any other header file. kernel.h can include jump_abel_type.h.

Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 include/linux/jump_label.h      | 44 +----------------------------
 include/linux/jump_label_type.h | 49 +++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 43 deletions(-)
 create mode 100644 include/linux/jump_label_type.h

diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index 32809624d422..bd0d846d0bde 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -75,6 +75,7 @@
 
 #include <linux/types.h>
 #include <linux/compiler.h>
+#include <linux/jump_label_type.h>
 
 extern bool static_key_initialized;
 
@@ -82,35 +83,6 @@ extern bool static_key_initialized;
 				    "%s(): static key '%pS' used before call to jump_label_init()", \
 				    __func__, (key))
 
-#ifdef CONFIG_JUMP_LABEL
-
-struct static_key {
-	atomic_t enabled;
-/*
- * Note:
- *   To make anonymous unions work with old compilers, the static
- *   initialization of them requires brackets. This creates a dependency
- *   on the order of the struct with the initializers. If any fields
- *   are added, STATIC_KEY_INIT_TRUE and STATIC_KEY_INIT_FALSE may need
- *   to be modified.
- *
- * bit 0 => 1 if key is initially true
- *	    0 if initially false
- * bit 1 => 1 if points to struct static_key_mod
- *	    0 if points to struct jump_entry
- */
-	union {
-		unsigned long type;
-		struct jump_entry *entries;
-		struct static_key_mod *next;
-	};
-};
-
-#else
-struct static_key {
-	atomic_t enabled;
-};
-#endif	/* CONFIG_JUMP_LABEL */
 #endif /* __ASSEMBLY__ */
 
 #ifdef CONFIG_JUMP_LABEL
@@ -343,14 +315,6 @@ static inline void static_key_disable(struct static_key *key)
  * All the below code is macros in order to play type games.
  */
 
-struct static_key_true {
-	struct static_key key;
-};
-
-struct static_key_false {
-	struct static_key key;
-};
-
 #define STATIC_KEY_TRUE_INIT  (struct static_key_true) { .key = STATIC_KEY_INIT_TRUE,  }
 #define STATIC_KEY_FALSE_INIT (struct static_key_false){ .key = STATIC_KEY_INIT_FALSE, }
 
@@ -360,18 +324,12 @@ struct static_key_false {
 #define DEFINE_STATIC_KEY_TRUE_RO(name)	\
 	struct static_key_true name __ro_after_init = STATIC_KEY_TRUE_INIT
 
-#define DECLARE_STATIC_KEY_TRUE(name)	\
-	extern struct static_key_true name
-
 #define DEFINE_STATIC_KEY_FALSE(name)	\
 	struct static_key_false name = STATIC_KEY_FALSE_INIT
 
 #define DEFINE_STATIC_KEY_FALSE_RO(name)	\
 	struct static_key_false name __ro_after_init = STATIC_KEY_FALSE_INIT
 
-#define DECLARE_STATIC_KEY_FALSE(name)	\
-	extern struct static_key_false name
-
 #define DEFINE_STATIC_KEY_ARRAY_TRUE(name, count)		\
 	struct static_key_true name[count] = {			\
 		[0 ... (count) - 1] = STATIC_KEY_TRUE_INIT,	\
diff --git a/include/linux/jump_label_type.h b/include/linux/jump_label_type.h
new file mode 100644
index 000000000000..37cb02c12f35
--- /dev/null
+++ b/include/linux/jump_label_type.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_JUMP_LABEL_TYPE_H
+#define _LINUX_JUMP_LABEL_TYPE_H
+
+#ifdef CONFIG_JUMP_LABEL
+
+struct static_key {
+	atomic_t enabled;
+/*
+ * Note:
+ *   To make anonymous unions work with old compilers, the static
+ *   initialization of them requires brackets. This creates a dependency
+ *   on the order of the struct with the initializers. If any fields
+ *   are added, STATIC_KEY_INIT_TRUE and STATIC_KEY_INIT_FALSE may need
+ *   to be modified.
+ *
+ * bit 0 => 1 if key is initially true
+ *	    0 if initially false
+ * bit 1 => 1 if points to struct static_key_mod
+ *	    0 if points to struct jump_entry
+ */
+	union {
+		unsigned long type;
+		struct jump_entry *entries;
+		struct static_key_mod *next;
+	};
+};
+
+#else
+struct static_key {
+	atomic_t enabled;
+};
+#endif	/* CONFIG_JUMP_LABEL */
+
+struct static_key_true {
+	struct static_key key;
+};
+
+struct static_key_false {
+	struct static_key key;
+};
+
+#define DECLARE_STATIC_KEY_TRUE(name)	\
+	extern struct static_key_true name
+
+#define DECLARE_STATIC_KEY_FALSE(name)	\
+	extern struct static_key_false name
+
+#endif /* _LINUX_JUMP_LABEL_TYPE_H */
-- 
2.28.0

