Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B24295FCA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 15:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899731AbgJVNUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 09:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2899676AbgJVNT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 09:19:59 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24A6C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 06:19:58 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id 2so1032109qtb.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 06:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=hXyFPEk4foicA9MHUn1LEAgXXkiWJy7tayx5woeXroY=;
        b=VesxqZfVc4TwIJOMCHCJCamqxdv3ivbVcAf/dPZk4kFR93xcHiGrBpORd1FmKSnz4M
         LLYv6Ue+5wAxbuGSDmXQxMoN8Y4ep4iGBpMomTNuR0kdJNPaa2GGqQCFz4rEiglKvW8h
         Mj1BXmRBClmxHgIpHikrc/rCK7c3cBSofpyvsWyoYZ0y1nTw8CDWIJLlKn1zT7zyniuA
         Xpj4CbezQmIO6q+TMWARr7yMMdERPhlVsoPT9rH67PVkJYge8klVwSHrqAtC6EUYMsnG
         eyy8fdtPy02ZuttyO1oMl1zmHFMk5+ZPxxEJglbphMNSlZcjZIxAZspqPwEO5HQXRouQ
         XKkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hXyFPEk4foicA9MHUn1LEAgXXkiWJy7tayx5woeXroY=;
        b=akfUAKkrBWD/L0MwEP80b6/uJx3Z2CiH3ZWhqz+9YZM7g5Kfj9hTcAA8GJwIEIyaPh
         vo16UdOt9Geav08J4mQK0bqXp0o06sqXLQpx11BWDGGJKwXvADnRdoNbDwlX6ib/EjVw
         5tTRPp3/a4N4ECIJ01ToLfXzWzxlpVKx7qI4AEufnVqE224wuKvUQyw262KNVOXQmNg1
         XL3pJmaxAtK+/4rhnvAS0azz+hB/bTUJhiqVDoPhOCI+nN2YGlWtZIdgndWkZVeDSE89
         L7TO69TpvZ7Fev0xrmoCZp74MLHbryOFSVwHL0FM46tB8GrmEentw1CX5fOzHctQ1/91
         GpkA==
X-Gm-Message-State: AOAM5300FpR31tBN0GmZnAKYI6X+aCVxjr2Ifc+2PjAeltvZHR79N2kS
        7nX2/dw6mrvPgjFSuMjLbHW+FXr69i+YSYoE
X-Google-Smtp-Source: ABdhPJz9rkeUtygs5ZPEaDOWc/yvjgB7QSCk5bCAQdXqW9yO1wZyxT1pgPdZxui+xVFkBbj2LobYJDXK6Aw6OyF4
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a0c:8d05:: with SMTP id
 r5mr2364576qvb.31.1603372797908; Thu, 22 Oct 2020 06:19:57 -0700 (PDT)
Date:   Thu, 22 Oct 2020 15:19:06 +0200
In-Reply-To: <cover.1603372719.git.andreyknvl@google.com>
Message-Id: <6a4a7626bf280871518656f4fa89cb064740baf7.1603372719.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1603372719.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH RFC v2 14/21] kasan: add and integrate kasan boot parameters
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Serban Constantinescu <serbanc@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TODO: no meaningful description here yet, please see the cover letter
      for this RFC series.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Link: https://linux-review.googlesource.com/id/If7d37003875b2ed3e0935702c8015c223d6416a4
---
 mm/kasan/common.c  |  92 +++++++++++++-----------
 mm/kasan/generic.c |   5 ++
 mm/kasan/hw_tags.c | 169 ++++++++++++++++++++++++++++++++++++++++++++-
 mm/kasan/kasan.h   |   9 +++
 mm/kasan/report.c  |  14 +++-
 mm/kasan/sw_tags.c |   5 ++
 6 files changed, 250 insertions(+), 44 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 1a5e6c279a72..cc129ef62ab1 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -129,35 +129,37 @@ void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
 	unsigned int redzone_size;
 	int redzone_adjust;
 
-	/* Add alloc meta. */
-	cache->kasan_info.alloc_meta_offset = *size;
-	*size += sizeof(struct kasan_alloc_meta);
-
-	/* Add free meta. */
-	if (IS_ENABLED(CONFIG_KASAN_GENERIC) &&
-	    (cache->flags & SLAB_TYPESAFE_BY_RCU || cache->ctor ||
-	     cache->object_size < sizeof(struct kasan_free_meta))) {
-		cache->kasan_info.free_meta_offset = *size;
-		*size += sizeof(struct kasan_free_meta);
-	}
-
-	redzone_size = optimal_redzone(cache->object_size);
-	redzone_adjust = redzone_size -	(*size - cache->object_size);
-	if (redzone_adjust > 0)
-		*size += redzone_adjust;
-
-	*size = min_t(unsigned int, KMALLOC_MAX_SIZE,
-			max(*size, cache->object_size + redzone_size));
+	if (static_branch_unlikely(&kasan_stack)) {
+		/* Add alloc meta. */
+		cache->kasan_info.alloc_meta_offset = *size;
+		*size += sizeof(struct kasan_alloc_meta);
+
+		/* Add free meta. */
+		if (IS_ENABLED(CONFIG_KASAN_GENERIC) &&
+		    (cache->flags & SLAB_TYPESAFE_BY_RCU || cache->ctor ||
+		     cache->object_size < sizeof(struct kasan_free_meta))) {
+			cache->kasan_info.free_meta_offset = *size;
+			*size += sizeof(struct kasan_free_meta);
+		}
 
-	/*
-	 * If the metadata doesn't fit, don't enable KASAN at all.
-	 */
-	if (*size <= cache->kasan_info.alloc_meta_offset ||
-			*size <= cache->kasan_info.free_meta_offset) {
-		cache->kasan_info.alloc_meta_offset = 0;
-		cache->kasan_info.free_meta_offset = 0;
-		*size = orig_size;
-		return;
+		redzone_size = optimal_redzone(cache->object_size);
+		redzone_adjust = redzone_size -	(*size - cache->object_size);
+		if (redzone_adjust > 0)
+			*size += redzone_adjust;
+
+		*size = min_t(unsigned int, KMALLOC_MAX_SIZE,
+				max(*size, cache->object_size + redzone_size));
+
+		/*
+		 * If the metadata doesn't fit, don't enable KASAN at all.
+		 */
+		if (*size <= cache->kasan_info.alloc_meta_offset ||
+				*size <= cache->kasan_info.free_meta_offset) {
+			cache->kasan_info.alloc_meta_offset = 0;
+			cache->kasan_info.free_meta_offset = 0;
+			*size = orig_size;
+			return;
+		}
 	}
 
 	*flags |= SLAB_KASAN;
@@ -165,10 +167,12 @@ void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
 
 size_t kasan_metadata_size(struct kmem_cache *cache)
 {
-	return (cache->kasan_info.alloc_meta_offset ?
-		sizeof(struct kasan_alloc_meta) : 0) +
-		(cache->kasan_info.free_meta_offset ?
-		sizeof(struct kasan_free_meta) : 0);
+	if (static_branch_unlikely(&kasan_stack))
+		return (cache->kasan_info.alloc_meta_offset ?
+			sizeof(struct kasan_alloc_meta) : 0) +
+			(cache->kasan_info.free_meta_offset ?
+			sizeof(struct kasan_free_meta) : 0);
+	return 0;
 }
 
 struct kasan_alloc_meta *kasan_get_alloc_meta(struct kmem_cache *cache,
@@ -270,8 +274,10 @@ void * __must_check kasan_init_slab_obj(struct kmem_cache *cache,
 	if (!(cache->flags & SLAB_KASAN))
 		return (void *)object;
 
-	alloc_meta = kasan_get_alloc_meta(cache, object);
-	__memset(alloc_meta, 0, sizeof(*alloc_meta));
+	if (static_branch_unlikely(&kasan_stack)) {
+		alloc_meta = kasan_get_alloc_meta(cache, object);
+		__memset(alloc_meta, 0, sizeof(*alloc_meta));
+	}
 
 	if (IS_ENABLED(CONFIG_KASAN_SW_TAGS) || IS_ENABLED(CONFIG_KASAN_HW_TAGS))
 		object = set_tag(object, assign_tag(cache, object, true, false));
@@ -308,15 +314,19 @@ static bool __kasan_slab_free(struct kmem_cache *cache, void *object,
 	rounded_up_size = round_up(cache->object_size, KASAN_GRANULE_SIZE);
 	kasan_poison_memory(object, rounded_up_size, KASAN_KMALLOC_FREE);
 
-	if ((IS_ENABLED(CONFIG_KASAN_GENERIC) && !quarantine) ||
-			unlikely(!(cache->flags & SLAB_KASAN)))
-		return false;
+	if (static_branch_unlikely(&kasan_stack)) {
+		if ((IS_ENABLED(CONFIG_KASAN_GENERIC) && !quarantine) ||
+				unlikely(!(cache->flags & SLAB_KASAN)))
+			return false;
+
+		kasan_set_free_info(cache, object, tag);
 
-	kasan_set_free_info(cache, object, tag);
+		quarantine_put(cache, object);
 
-	quarantine_put(cache, object);
+		return IS_ENABLED(CONFIG_KASAN_GENERIC);
+	}
 
-	return IS_ENABLED(CONFIG_KASAN_GENERIC);
+	return false;
 }
 
 bool kasan_slab_free(struct kmem_cache *cache, void *object, unsigned long ip)
@@ -355,7 +365,7 @@ static void *__kasan_kmalloc(struct kmem_cache *cache, const void *object,
 	kasan_poison_memory((void *)redzone_start, redzone_end - redzone_start,
 		KASAN_KMALLOC_REDZONE);
 
-	if (cache->flags & SLAB_KASAN)
+	if (static_branch_unlikely(&kasan_stack) && (cache->flags & SLAB_KASAN))
 		set_alloc_info(cache, (void *)object, flags);
 
 	return set_tag(object, tag);
diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index d259e4c3aefd..20a1e753e0c5 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -33,6 +33,11 @@
 #include "kasan.h"
 #include "../slab.h"
 
+/* See the comments in hw_tags.c */
+DEFINE_STATIC_KEY_TRUE_RO(kasan_enabled);
+EXPORT_SYMBOL(kasan_enabled);
+DEFINE_STATIC_KEY_TRUE_RO(kasan_stack);
+
 /*
  * All functions below always inlined so compiler could
  * perform better optimizations in each of __asan_loadX/__assn_storeX
diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
index 915142da6b57..bccd781011ad 100644
--- a/mm/kasan/hw_tags.c
+++ b/mm/kasan/hw_tags.c
@@ -8,6 +8,8 @@
 
 #define pr_fmt(fmt) "kasan: " fmt
 
+#include <linux/init.h>
+#include <linux/jump_label.h>
 #include <linux/kasan.h>
 #include <linux/kernel.h>
 #include <linux/memory.h>
@@ -17,10 +19,175 @@
 
 #include "kasan.h"
 
+enum kasan_arg_mode {
+	KASAN_ARG_MODE_OFF,
+	KASAN_ARG_MODE_PROD,
+	KASAN_ARG_MODE_FULL,
+};
+
+enum kasan_arg_stack {
+	KASAN_ARG_STACK_DEFAULT,
+	KASAN_ARG_STACK_OFF,
+	KASAN_ARG_STACK_ON,
+};
+
+enum kasan_arg_trap {
+	KASAN_ARG_TRAP_DEFAULT,
+	KASAN_ARG_TRAP_ASYNC,
+	KASAN_ARG_TRAP_SYNC,
+};
+
+enum kasan_arg_fault {
+	KASAN_ARG_FAULT_DEFAULT,
+	KASAN_ARG_FAULT_REPORT,
+	KASAN_ARG_FAULT_PANIC,
+};
+
+static enum kasan_arg_mode kasan_arg_mode __ro_after_init;
+static enum kasan_arg_stack kasan_arg_stack __ro_after_init;
+static enum kasan_arg_fault kasan_arg_fault __ro_after_init;
+static enum kasan_arg_trap kasan_arg_trap __ro_after_init;
+
+/* Whether KASAN is enabled at all. */
+DEFINE_STATIC_KEY_FALSE_RO(kasan_enabled);
+EXPORT_SYMBOL(kasan_enabled);
+
+/* Whether to collect alloc/free stack traces. */
+DEFINE_STATIC_KEY_FALSE_RO(kasan_stack);
+
+/* Whether to use synchronous or asynchronous tag checking. */
+static bool kasan_sync __ro_after_init;
+
+/* Whether panic or disable tag checking on fault. */
+bool kasan_panic __ro_after_init;
+
+/* kasan.mode=off/prod/full */
+static int __init early_kasan_mode(char *arg)
+{
+	if (!arg)
+		return -EINVAL;
+
+	if (!strcmp(arg, "off"))
+		kasan_arg_mode = KASAN_ARG_MODE_OFF;
+	else if (!strcmp(arg, "prod"))
+		kasan_arg_mode = KASAN_ARG_MODE_PROD;
+	else if (!strcmp(arg, "full"))
+		kasan_arg_mode = KASAN_ARG_MODE_FULL;
+	else
+		return -EINVAL;
+
+	return 0;
+}
+early_param("kasan.mode", early_kasan_mode);
+
+/* kasan.stack=off/on */
+static int __init early_kasan_stack(char *arg)
+{
+	if (!arg)
+		return -EINVAL;
+
+	if (!strcmp(arg, "off"))
+		kasan_arg_stack = KASAN_ARG_STACK_OFF;
+	else if (!strcmp(arg, "on"))
+		kasan_arg_stack = KASAN_ARG_STACK_ON;
+	else
+		return -EINVAL;
+
+	return 0;
+}
+early_param("kasan.stack", early_kasan_stack);
+
+/* kasan.trap=sync/async */
+static int __init early_kasan_trap(char *arg)
+{
+	if (!arg)
+		return -EINVAL;
+
+	if (!strcmp(arg, "ASYNC"))
+		kasan_arg_trap = KASAN_ARG_TRAP_ASYNC;
+	else if (!strcmp(arg, "sync"))
+		kasan_arg_trap = KASAN_ARG_TRAP_SYNC;
+	else
+		return -EINVAL;
+
+	return 0;
+}
+early_param("kasan.trap", early_kasan_trap);
+
+/* kasan.fault=report/panic */
+static int __init early_kasan_fault(char *arg)
+{
+	if (!arg)
+		return -EINVAL;
+
+	if (!strcmp(arg, "report"))
+		kasan_arg_fault = KASAN_ARG_FAULT_REPORT;
+	else if (!strcmp(arg, "panic"))
+		kasan_arg_fault = KASAN_ARG_FAULT_PANIC;
+	else
+		return -EINVAL;
+
+	return 0;
+}
+early_param("kasan.fault", early_kasan_fault);
+
 void __init kasan_init_tags(void)
 {
-	init_tags(KASAN_TAG_MAX);
+	if (!cpu_supports_tags())
+		return;
+
+	/* First, preset values based on the mode. */
+
+	switch (kasan_arg_mode) {
+	case KASAN_ARG_MODE_OFF:
+		return;
+	case KASAN_ARG_MODE_PROD:
+		static_branch_enable(&kasan_enabled);
+		break;
+	case KASAN_ARG_MODE_FULL:
+		static_branch_enable(&kasan_enabled);
+		static_branch_enable(&kasan_stack);
+		kasan_sync = true;
+		break;
+	}
+
+	/* Now, optionally override the presets. */
 
+	switch (kasan_arg_stack) {
+	case KASAN_ARG_STACK_OFF:
+		static_branch_disable(&kasan_stack);
+		break;
+	case KASAN_ARG_STACK_ON:
+		static_branch_enable(&kasan_stack);
+		break;
+	default:
+		break;
+	}
+
+	switch (kasan_arg_trap) {
+	case KASAN_ARG_TRAP_ASYNC:
+		kasan_sync = false;
+		break;
+	case KASAN_ARG_TRAP_SYNC:
+		kasan_sync = true;
+		break;
+	default:
+		break;
+	}
+
+	switch (kasan_arg_fault) {
+	case KASAN_ARG_FAULT_REPORT:
+		kasan_panic = false;
+		break;
+	case KASAN_ARG_FAULT_PANIC:
+		kasan_panic = true;
+		break;
+	default:
+		break;
+	}
+
+	/* TODO: choose between sync and async based on kasan_sync. */
+	init_tags(KASAN_TAG_MAX);
 	pr_info("KernelAddressSanitizer initialized\n");
 }
 
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index f7ae0c23f023..00b47bc753aa 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -2,9 +2,18 @@
 #ifndef __MM_KASAN_KASAN_H
 #define __MM_KASAN_KASAN_H
 
+#include <linux/jump_label.h>
 #include <linux/kasan.h>
 #include <linux/stackdepot.h>
 
+#ifdef CONFIG_KASAN_HW_TAGS
+DECLARE_STATIC_KEY_FALSE(kasan_stack);
+#else
+DECLARE_STATIC_KEY_TRUE(kasan_stack);
+#endif
+
+extern bool kasan_panic __ro_after_init;
+
 #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 #define KASAN_GRANULE_SIZE	(1UL << KASAN_SHADOW_SCALE_SHIFT)
 #else
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index dee5350b459c..426dd1962d3c 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -97,6 +97,10 @@ static void end_report(unsigned long *flags)
 		panic_on_warn = 0;
 		panic("panic_on_warn set ...\n");
 	}
+#ifdef CONFIG_KASAN_HW_TAGS
+	if (kasan_panic)
+		panic("kasan.fault=panic set ...\n");
+#endif
 	kasan_enable_current();
 }
 
@@ -159,8 +163,8 @@ static void describe_object_addr(struct kmem_cache *cache, void *object,
 		(void *)(object_addr + cache->object_size));
 }
 
-static void describe_object(struct kmem_cache *cache, void *object,
-				const void *addr, u8 tag)
+static void describe_object_stacks(struct kmem_cache *cache, void *object,
+					const void *addr, u8 tag)
 {
 	struct kasan_alloc_meta *alloc_meta = kasan_get_alloc_meta(cache, object);
 
@@ -188,7 +192,13 @@ static void describe_object(struct kmem_cache *cache, void *object,
 		}
 #endif
 	}
+}
 
+static void describe_object(struct kmem_cache *cache, void *object,
+				const void *addr, u8 tag)
+{
+	if (static_branch_unlikely(&kasan_stack))
+		describe_object_stacks(cache, object, addr, tag);
 	describe_object_addr(cache, object, addr);
 }
 
diff --git a/mm/kasan/sw_tags.c b/mm/kasan/sw_tags.c
index 4db41f274702..b6d185adf2c5 100644
--- a/mm/kasan/sw_tags.c
+++ b/mm/kasan/sw_tags.c
@@ -33,6 +33,11 @@
 #include "kasan.h"
 #include "../slab.h"
 
+/* See the comments in hw_tags.c */
+DEFINE_STATIC_KEY_TRUE_RO(kasan_enabled);
+EXPORT_SYMBOL(kasan_enabled);
+DEFINE_STATIC_KEY_TRUE_RO(kasan_stack);
+
 static DEFINE_PER_CPU(u32, prng_state);
 
 void __init kasan_init_tags(void)
-- 
2.29.0.rc1.297.gfa9743e501-goog

