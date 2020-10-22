Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 593D52965EC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 22:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S371558AbgJVUYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 16:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2894716AbgJVUYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 16:24:07 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458A7C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 13:24:05 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id m11so1532816pgq.7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 13:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=zw2T1AigDoes2ZXL/BhvqfeuP2I6Xp6hCsVSILgFLs8=;
        b=BuwZP/EKu0LtETCQvIPBCjdbGmanyNFJwkuQZhTKogFSUwBPbwGZGu1uD808VWHLJq
         YBl5YdZ2JKT0Z0cTOXDHgNa0D1KRhlSRTqFKfyIsvd37jzKZDraiVkVWdOjYP7j+g9j3
         DLKWOsllpnL9e96v7q73jsKOADyqAeeAAYlYjjtKAlX/UAw5HrKqp9qH73S2bic77OPm
         T0lUA4AH1laQOIAwEHSpRp9pvYfrp10DhzYj9tEyODtVAFIF2/adDcNxoL6BGnS9Kx1U
         iTIgrdHwXruRHx6h3SA6UH9pfV0Q5xzR53yxG3zGPkQ/B42bEum9lvNYWV0mMiHlrrvf
         TUrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zw2T1AigDoes2ZXL/BhvqfeuP2I6Xp6hCsVSILgFLs8=;
        b=epd1ZpdR+qE/azRmy1Jo3DL1qekV/VsjWvQF0oRPx7L4V17DBg7r5T7+AWaoOXPzGL
         ghw08akgzJ0Bjg8WqMvJ3/0wyGyPyjU3Mv/Ba0xF/u98v4vXQ8ST6dONUUCL1w6tUfIW
         siXoUqZf9kWCW1vLnhdDr5m2Lp2NpIjFGam6S7n6ALeGh6jlLqRxrYzt4+pzOw7Xxl3Y
         fffdklGsk7JVUdbJvuCoEGq2h8QOgLun22GRwSuQsRzEncZpQA2x+uDPpuaa2jJCxnTl
         xQj3dV10lc2472QGdemBY4n1Y+NhYcU4ODTcwEBybgrmhOOe2uw2bqVGsb2nmc2+TCNZ
         qKoA==
X-Gm-Message-State: AOAM531ixOZ885QxBqRwRTWPxSMyrI7iqONsQE0sST5J2aJLmOE6luXh
        btCzsGjDwlq79UU5yIL6IW+Wc19M/GIHHReF7a4=
X-Google-Smtp-Source: ABdhPJxRFySAVxGLLNyCelqlhm8iYc1/ihDpFk9R8qj83Ysvq9Y2hRy81LujM+tgbEbBj+4tq73wBvubyx9vMXe4Sfc=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a63:1906:: with SMTP id
 z6mr3801421pgl.286.1603398244708; Thu, 22 Oct 2020 13:24:04 -0700 (PDT)
Date:   Thu, 22 Oct 2020 13:23:54 -0700
In-Reply-To: <20201022202355.3529836-1-samitolvanen@google.com>
Message-Id: <20201022202355.3529836-2-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201022202355.3529836-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH 1/2] scs: switch to vmapped shadow stacks
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
which means an overflow may not be immediately detected and can
potentially result in another task's shadow stack to be overwritten.

This change switches SCS to use virtually mapped shadow stacks,
which increases shadow stack size to a full page and provides more
robust overflow detection similarly to VMAP_STACK.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 include/linux/scs.h |  7 +----
 kernel/scs.c        | 63 ++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 55 insertions(+), 15 deletions(-)

diff --git a/include/linux/scs.h b/include/linux/scs.h
index 6dec390cf154..86e3c4b7b714 100644
--- a/include/linux/scs.h
+++ b/include/linux/scs.h
@@ -15,12 +15,7 @@
 
 #ifdef CONFIG_SHADOW_CALL_STACK
 
-/*
- * In testing, 1 KiB shadow stack size (i.e. 128 stack frames on a 64-bit
- * architecture) provided ~40% safety margin on stack usage while keeping
- * memory allocation overhead reasonable.
- */
-#define SCS_SIZE		SZ_1K
+#define SCS_SIZE		PAGE_SIZE
 #define GFP_SCS			(GFP_KERNEL | __GFP_ZERO)
 
 /* An illegal pointer value to mark the end of the shadow stack. */
diff --git a/kernel/scs.c b/kernel/scs.c
index 4ff4a7ba0094..2136edba548d 100644
--- a/kernel/scs.c
+++ b/kernel/scs.c
@@ -5,50 +5,95 @@
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
 
+/* Matches NR_CACHED_STACKS for VMAP_STACK */
+#define NR_CACHED_SCS 2
+static DEFINE_PER_CPU(void *, scs_cache[NR_CACHED_SCS]);
+
 static void *scs_alloc(int node)
 {
-	void *s = kmem_cache_alloc_node(scs_cache, GFP_SCS, node);
+	int i;
+	void *s;
+
+	for (i = 0; i < NR_CACHED_SCS; i++) {
+		s = this_cpu_xchg(scs_cache[i], NULL);
+		if (s) {
+			memset(s, 0, SCS_SIZE);
+			goto out;
+		}
+	}
+
+	/*
+	 * We allocate a full page for the shadow stack, which should be
+	 * more than we need. Check the assumption nevertheless.
+	 */
+	BUILD_BUG_ON(SCS_SIZE > PAGE_SIZE);
+
+	s = __vmalloc_node_range(PAGE_SIZE, SCS_SIZE,
+				 VMALLOC_START, VMALLOC_END,
+				 GFP_SCS, PAGE_KERNEL, 0,
+				 node, __builtin_return_address(0));
 
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
 
 static void scs_free(void *s)
 {
+	int i;
+
 	__scs_account(s, -1);
-	kasan_unpoison_object_data(scs_cache, s);
-	kmem_cache_free(scs_cache, s);
+	kasan_unpoison_vmalloc(s, SCS_SIZE);
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
2.29.0.rc1.297.gfa9743e501-goog

