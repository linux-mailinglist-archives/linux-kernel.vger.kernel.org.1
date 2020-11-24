Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB4E2C3188
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 21:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729817AbgKXT7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 14:59:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729752AbgKXT7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 14:59:51 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E33C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 11:59:51 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id t22so12479636qtq.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 11:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=FVQS1M4KVeXjKNOKRHPJrd8BR6PbfTKPcKqR0T4EXVc=;
        b=SUk5JlyxWBeBNn8+bH/u3kAph5z8l4gaT+wrbmymdEUfN4CzkWGEURqr1fR+ga0Lvd
         f7Y97E940hOXcDcMbiNZZ/rxDnvWj1Y6iNMO5BLW/1tk5nM1iCphRbc62/0Wyg0z7cgk
         zLMLN/jgDkXowvVhtCVd3kaoUaveblswuMxyJUTWYafxvClxVVpWnCkRvI9UhaPTPucA
         qsA/8c6VHLcn1tGWWd8xtlFaubTN/cA2IdggdQBeIhiSvhSjn/vsxE546JHhqjAXLcZJ
         eBPXoqi4sIa6ueb3T9XSXpZT7pHcCCXShxm9NgBWaYGKLkeN0U/ZxTEr/5Fz+4p8drZn
         uSQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FVQS1M4KVeXjKNOKRHPJrd8BR6PbfTKPcKqR0T4EXVc=;
        b=Ux1n81pFwQjNM6pzClyc8Y7tcMuXuUkOgPGX6QYJpv3iWaSwS3iWkOAk5eheDoNxpi
         NDz1UU+9oBVtP4bO7IMQoG0hzXw3tAf66A8kWLm5BuGBOFd2ZJJtxo+xQLIS9jvFD0iq
         CqLfpumQEh1fd6uCDs+Vp9X9FtrQ81X8T5dICBuMTRNDKSNx1liYc9JJG6ne8znHoLwz
         CVtr23jXFUF/07R+bW6jqRt90kCTJ5a1SlLqED6RGsQzniNjFeE7enL5ncuGe6D3zTGo
         1kghcdRiE7hkGDhn8ljsIbwP3516Q4/WD8jWPpEld9VN6JnrZq3aoAAf2GK+If34Ojlo
         yYgw==
X-Gm-Message-State: AOAM532adAfDRj0gBzDofIyhLmJ75YpDlLT4er/av7aZ6L5jv50LSDGx
        C2BWe6YnIs4PjROreSjJVE1MdRkOC37G5r2l1cQ=
X-Google-Smtp-Source: ABdhPJzLjM7X2Za0sQ5cQHWDCE2TBUvGheAojN48CLbofUImKRKHKdYP2ZPepyS89daNUYx7h3wNQP8vgae/UweoEbE=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a25:6e43:: with SMTP id
 j64mr7692153ybc.183.1606247990853; Tue, 24 Nov 2020 11:59:50 -0800 (PST)
Date:   Tue, 24 Nov 2020 11:59:39 -0800
In-Reply-To: <20201124195940.27061-1-samitolvanen@google.com>
Message-Id: <20201124195940.27061-2-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201124195940.27061-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v2 1/2] scs: switch to vmapped shadow stacks
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
---
 include/linux/scs.h | 12 ++++-----
 kernel/scs.c        | 66 +++++++++++++++++++++++++++++++++++++--------
 2 files changed, 61 insertions(+), 17 deletions(-)

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
index 4ff4a7ba0094..25b0dd5aa0e2 100644
--- a/kernel/scs.c
+++ b/kernel/scs.c
@@ -5,50 +5,94 @@
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
+void *scs_alloc(int node)
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
+			goto out;
+		}
+	}
+
+	s = __vmalloc_node_range(SCS_SIZE, 1, VMALLOC_START, VMALLOC_END,
+				 GFP_SCS, PAGE_KERNEL, 0, node,
+				 __builtin_return_address(0));
 
 	if (!s)
 		return NULL;
 
+out:
 	*__scs_magic(s) = SCS_END_MAGIC;
 
 	/*
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

