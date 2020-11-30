Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 566EA2C92BD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 00:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389006AbgK3XfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 18:35:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387996AbgK3XfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 18:35:09 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99700C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:34:48 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id k196so158123ybf.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=6uc7ZLqzr9oyVU4hbwFSRyKi3sFmVrBfBXorh1eNGEA=;
        b=BzEa4nkfxkMZKW7cseeSx8SY164/h+h2hni0VDyb30y/8QyxSnxAAC/8I5vwNG5bDl
         x3ysxxGDHBf00/s/nMUPoWxxLvs8FwoestNcKA0ujwnqwcG/4ZyQ0f5FcCDieuDRQNkC
         uEVy/uQgvIxxhGyKofDgNF+8FXmpI8SfoaBqtyerD/NwAl2kJJQf6s0FOFhrxW+IDqs4
         vbkegF3NlvkROTGReHHpanIl0Hs7vPBwEJTpch37KtUSdqYR+7NSCHSzfphI2nkMsAYR
         MBMAxZUX+O0cJ8IBDpCeAWWKkN59Zt6yB7YimTU276QaGRZoQGvpHZyLzYqhMwmS63R0
         YI2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6uc7ZLqzr9oyVU4hbwFSRyKi3sFmVrBfBXorh1eNGEA=;
        b=XVbYYGzxTVlWP79MC2GEYnU4AbJdKufShRiEJQqopRcIVvWVdepU268LcrtIoke6li
         kAO8irvyxgGGbyyE4UGRXoM/NJktUxbJjZ8yMZlbvyo47gkDeUPsuDsVwwoC1jAQ7itg
         YJfIW8z66vXl67p4M979mBbPpheX4Hx8jpaPimIfRUBGkTkiznHQOj7XKW87G7dcql8y
         LXRO31fvOq665gisNr74ZFn9dRAU87X14xRjZJ+oEZ4O2xvczq022To/0LvUi+LyNIRU
         ACya3KtFog0ndWSv4TK18tQFxcgPcfRCuyqJvsxJDnxBxWFzRQPur8FMLKNsFVlerQa/
         Bchg==
X-Gm-Message-State: AOAM530SLDPzFoL0jHnKBuqtD1KRrqEWdO1WNNQ3UqEl5PzGKKONPnzR
        MdSBLnHs69HfbhzozDDfeJtZEZcL9PzjFrKviio=
X-Google-Smtp-Source: ABdhPJzGaieQ6MZgiNyXIW04eO8Ne+Y0K0jSiE+cKMV1SV2mjmeHFdgilfGi5zMqufWZUY5o2g/uoghZ3ShEg81gf1k=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a25:884:: with SMTP id
 126mr26559330ybi.154.1606779287851; Mon, 30 Nov 2020 15:34:47 -0800 (PST)
Date:   Mon, 30 Nov 2020 15:34:41 -0800
In-Reply-To: <20201130233442.2562064-1-samitolvanen@google.com>
Message-Id: <20201130233442.2562064-2-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201130233442.2562064-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v3 1/2] scs: switch to vmapped shadow stacks
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel currently uses kmem_cache to allocate shadow call stacks,
which means an overflows may not be immediately detected and can
potentially result in another task's shadow stack to be overwritten.

This change switches SCS to use virtually mapped shadow stacks for
tasks, which increases shadow stack size to a full page and provides
more robust overflow detection, similarly to VMAP_STACK.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Acked-by: Will Deacon <will@kernel.org>
---
 include/linux/scs.h | 12 ++++----
 kernel/scs.c        | 71 ++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 66 insertions(+), 17 deletions(-)

diff --git a/include/linux/scs.h b/include/linux/scs.h
index 6dec390cf154..2a506c2a16f4 100644
--- a/include/linux/scs.h
+++ b/include/linux/scs.h
@@ -15,12 +15,8 @@
 
 #ifdef CONFIG_SHADOW_CALL_STACK
 
-/*
- * In testing, 1 KiB shadow stack size (i.e. 128 stack frames on a 64-bit
- * architecture) provided ~40% safety margin on stack usage while keeping
- * memory allocation overhead reasonable.
- */
-#define SCS_SIZE		SZ_1K
+#define SCS_ORDER		0
+#define SCS_SIZE		(PAGE_SIZE << SCS_ORDER)
 #define GFP_SCS			(GFP_KERNEL | __GFP_ZERO)
 
 /* An illegal pointer value to mark the end of the shadow stack. */
@@ -33,6 +29,8 @@
 #define task_scs(tsk)		(task_thread_info(tsk)->scs_base)
 #define task_scs_sp(tsk)	(task_thread_info(tsk)->scs_sp)
 
+void *scs_alloc(int node);
+void scs_free(void *s);
 void scs_init(void);
 int scs_prepare(struct task_struct *tsk, int node);
 void scs_release(struct task_struct *tsk);
@@ -61,6 +59,8 @@ static inline bool task_scs_end_corrupted(struct task_struct *tsk)
 
 #else /* CONFIG_SHADOW_CALL_STACK */
 
+static inline void *scs_alloc(int node) { return NULL; }
+static inline void scs_free(void *s) {}
 static inline void scs_init(void) {}
 static inline void scs_task_reset(struct task_struct *tsk) {}
 static inline int scs_prepare(struct task_struct *tsk, int node) { return 0; }
diff --git a/kernel/scs.c b/kernel/scs.c
index 4ff4a7ba0094..e2a71fc82fa0 100644
--- a/kernel/scs.c
+++ b/kernel/scs.c
@@ -5,26 +5,49 @@
  * Copyright (C) 2019 Google LLC
  */
 
+#include <linux/cpuhotplug.h>
 #include <linux/kasan.h>
 #include <linux/mm.h>
 #include <linux/scs.h>
-#include <linux/slab.h>
+#include <linux/vmalloc.h>
 #include <linux/vmstat.h>
 
-static struct kmem_cache *scs_cache;
-
 static void __scs_account(void *s, int account)
 {
-	struct page *scs_page = virt_to_page(s);
+	struct page *scs_page = vmalloc_to_page(s);
 
 	mod_node_page_state(page_pgdat(scs_page), NR_KERNEL_SCS_KB,
 			    account * (SCS_SIZE / SZ_1K));
 }
 
-static void *scs_alloc(int node)
+/* Matches NR_CACHED_STACKS for VMAP_STACK */
+#define NR_CACHED_SCS 2
+static DEFINE_PER_CPU(void *, scs_cache[NR_CACHED_SCS]);
+
+static void *__scs_alloc(int node)
 {
-	void *s = kmem_cache_alloc_node(scs_cache, GFP_SCS, node);
+	int i;
+	void *s;
+
+	for (i = 0; i < NR_CACHED_SCS; i++) {
+		s = this_cpu_xchg(scs_cache[i], NULL);
+		if (s) {
+			kasan_unpoison_vmalloc(s, SCS_SIZE);
+			memset(s, 0, SCS_SIZE);
+			return s;
+		}
+	}
+
+	return __vmalloc_node_range(SCS_SIZE, 1, VMALLOC_START, VMALLOC_END,
+				    GFP_SCS, PAGE_KERNEL, 0, node,
+				    __builtin_return_address(0));
+}
 
+void *scs_alloc(int node)
+{
+	void *s;
+
+	s = __scs_alloc(node);
 	if (!s)
 		return NULL;
 
@@ -34,21 +57,47 @@ static void *scs_alloc(int node)
 	 * Poison the allocation to catch unintentional accesses to
 	 * the shadow stack when KASAN is enabled.
 	 */
-	kasan_poison_object_data(scs_cache, s);
+	kasan_poison_vmalloc(s, SCS_SIZE);
 	__scs_account(s, 1);
 	return s;
 }
 
-static void scs_free(void *s)
+void scs_free(void *s)
 {
+	int i;
+
 	__scs_account(s, -1);
-	kasan_unpoison_object_data(scs_cache, s);
-	kmem_cache_free(scs_cache, s);
+
+	/*
+	 * We cannot sleep as this can be called in interrupt context,
+	 * so use this_cpu_cmpxchg to update the cache, and vfree_atomic
+	 * to free the stack.
+	 */
+
+	for (i = 0; i < NR_CACHED_SCS; i++)
+		if (this_cpu_cmpxchg(scs_cache[i], 0, s) == NULL)
+			return;
+
+	vfree_atomic(s);
+}
+
+static int scs_cleanup(unsigned int cpu)
+{
+	int i;
+	void **cache = per_cpu_ptr(scs_cache, cpu);
+
+	for (i = 0; i < NR_CACHED_SCS; i++) {
+		vfree(cache[i]);
+		cache[i] = NULL;
+	}
+
+	return 0;
 }
 
 void __init scs_init(void)
 {
-	scs_cache = kmem_cache_create("scs_cache", SCS_SIZE, 0, 0, NULL);
+	cpuhp_setup_state(CPUHP_BP_PREPARE_DYN, "scs:scs_cache", NULL,
+			  scs_cleanup);
 }
 
 int scs_prepare(struct task_struct *tsk, int node)
-- 
2.29.2.454.gaff20da3a2-goog

