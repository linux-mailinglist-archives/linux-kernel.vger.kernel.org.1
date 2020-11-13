Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8A192B2868
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 23:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgKMWU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 17:20:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbgKMWUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 17:20:43 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8580C0617A7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:20:42 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id b206so4006917wmd.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=MxVAcTo0hk94ZX+Zq5q+mwXBwZIWhhZSGlgZNdsI0wo=;
        b=ZIkZiVFLBy+yabzozxOvR3Zd9N0uMrnSqsg1jqb7ahlGPFDQz+1TbXnthaA4GQhP1x
         JsJu5MQvJKt4fGk8SABnDNIQMmoc+uA7gIYCk3tNvGhy5S65rYsOSXY3kXr6rNkxWAXM
         K78sNGsH1TGF5VpVMxee7i3DyEJMZLEK26QyQQVoZeo16rIHhzeRmnZPOKNTHUx+HMRz
         5QjVJG/DYqWK59TPHeBLsRRQqYSusASu1S9WEfxVCxD8dgeCfDIqIi/11BE9ClC46CbJ
         RzTIQx9V0vKqFu66BHoIO8x488w+TtM6ss8DejH+vK5YgdDYiITe2FdC+JXhzpOJpM4P
         OkIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MxVAcTo0hk94ZX+Zq5q+mwXBwZIWhhZSGlgZNdsI0wo=;
        b=eu2hCljgE0kOpuQ4Lbbn/LuxfAsaRR3G2DVrVxeYVeYpf9wWuI6EC9CpXfp1gons7i
         uhiDsqUoSWlz/nEM+AAmadmmmYTsX1UgySGh3PVnErRrMpgvkcLPzNtE0h592zoJ9ms9
         H4kU4AmDXjJqHuyPaSKnA0Dd1eaXQQz0qSN9CPmAXT9DDrL78r94mTeEJgDMScmSbgkn
         Ojbx4mCmCJ7Dr72dcIzCH63rx8j+Dyq386BnB7WpbetDef6wEoMu47XBuwZl1Tf6oHGe
         5wMHahpgCUAsNf7Ifc1G3oSwst7+vADmkNAlf0dv+SAYJuwwnE5s/US8uVuLgdn3rHwK
         pGfQ==
X-Gm-Message-State: AOAM530IojCc19gLpFOTphY5KEaJXASO0CphmTkZ4n3bhGEoBRaDLUww
        9HRD5iJwguVsJIG1waZ1+CUDVM2jK9rPLT5d
X-Google-Smtp-Source: ABdhPJyKR3meGMOmAU7hmbjaXFufu+qBx5atnm9eeN5FLHLvSQS99Iqt2PYCkuuJvvCa31Cp9bFz1kNn0+MItfaq
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:adf:f24b:: with SMTP id
 b11mr6350563wrp.342.1605306041610; Fri, 13 Nov 2020 14:20:41 -0800 (PST)
Date:   Fri, 13 Nov 2020 23:20:01 +0100
In-Reply-To: <cover.1605305978.git.andreyknvl@google.com>
Message-Id: <deb1af093f19c8848346682245513af059626412.1605305978.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605305978.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH mm v3 11/19] kasan: add and integrate kasan boot parameters
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hardware tag-based KASAN mode is intended to eventually be used in
production as a security mitigation. Therefore there's a need for finer
control over KASAN features and for an existence of a kill switch.

This change adds a few boot parameters for hardware tag-based KASAN that
allow to disable or otherwise control particular KASAN features.

The features that can be controlled are:

1. Whether KASAN is enabled at all.
2. Whether KASAN collects and saves alloc/free stacks.
3. Whether KASAN panics on a detected bug or not.

With this change a new boot parameter kasan.mode allows to choose one of
three main modes:

- kasan.mode=off - KASAN is disabled, no tag checks are performed
- kasan.mode=prod - only essential production features are enabled
- kasan.mode=full - all KASAN features are enabled

The chosen mode provides default control values for the features mentioned
above. However it's also possible to override the default values by
providing:

- kasan.stacktrace=off/on - enable alloc/free stack collection
                            (default: on for mode=full, otherwise off)
- kasan.fault=report/panic - only report tag fault or also panic
                             (default: report)

If kasan.mode parameter is not provided, it defaults to full when
CONFIG_DEBUG_KERNEL is enabled, and to prod otherwise.

It is essential that switching between these modes doesn't require
rebuilding the kernel with different configs, as this is required by
the Android GKI (Generic Kernel Image) initiative [1].

[1] https://source.android.com/devices/architecture/kernel/generic-kernel-image

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Link: https://linux-review.googlesource.com/id/If7d37003875b2ed3e0935702c8015c223d6416a4
---
 mm/kasan/common.c  |  22 +++++--
 mm/kasan/hw_tags.c | 151 +++++++++++++++++++++++++++++++++++++++++++++
 mm/kasan/kasan.h   |  16 +++++
 mm/kasan/report.c  |  14 ++++-
 4 files changed, 196 insertions(+), 7 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 1ac4f435c679..a11e3e75eb08 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -135,6 +135,11 @@ void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
 	unsigned int redzone_size;
 	int redzone_adjust;
 
+	if (!kasan_stack_collection_enabled()) {
+		*flags |= SLAB_KASAN;
+		return;
+	}
+
 	/* Add alloc meta. */
 	cache->kasan_info.alloc_meta_offset = *size;
 	*size += sizeof(struct kasan_alloc_meta);
@@ -171,6 +176,8 @@ void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
 
 size_t kasan_metadata_size(struct kmem_cache *cache)
 {
+	if (!kasan_stack_collection_enabled())
+		return 0;
 	return (cache->kasan_info.alloc_meta_offset ?
 		sizeof(struct kasan_alloc_meta) : 0) +
 		(cache->kasan_info.free_meta_offset ?
@@ -263,11 +270,13 @@ void * __must_check kasan_init_slab_obj(struct kmem_cache *cache,
 {
 	struct kasan_alloc_meta *alloc_meta;
 
-	if (!(cache->flags & SLAB_KASAN))
-		return (void *)object;
+	if (kasan_stack_collection_enabled()) {
+		if (!(cache->flags & SLAB_KASAN))
+			return (void *)object;
 
-	alloc_meta = kasan_get_alloc_meta(cache, object);
-	__memset(alloc_meta, 0, sizeof(*alloc_meta));
+		alloc_meta = kasan_get_alloc_meta(cache, object);
+		__memset(alloc_meta, 0, sizeof(*alloc_meta));
+	}
 
 	if (IS_ENABLED(CONFIG_KASAN_SW_TAGS) || IS_ENABLED(CONFIG_KASAN_HW_TAGS))
 		object = set_tag(object, assign_tag(cache, object, true, false));
@@ -307,6 +316,9 @@ static bool __kasan_slab_free(struct kmem_cache *cache, void *object,
 	rounded_up_size = round_up(cache->object_size, KASAN_GRANULE_SIZE);
 	poison_range(object, rounded_up_size, KASAN_KMALLOC_FREE);
 
+	if (!kasan_stack_collection_enabled())
+		return false;
+
 	if ((IS_ENABLED(CONFIG_KASAN_GENERIC) && !quarantine) ||
 			unlikely(!(cache->flags & SLAB_KASAN)))
 		return false;
@@ -357,7 +369,7 @@ static void *__kasan_kmalloc(struct kmem_cache *cache, const void *object,
 	poison_range((void *)redzone_start, redzone_end - redzone_start,
 		     KASAN_KMALLOC_REDZONE);
 
-	if (cache->flags & SLAB_KASAN)
+	if (kasan_stack_collection_enabled() && (cache->flags & SLAB_KASAN))
 		set_alloc_info(cache, (void *)object, flags);
 
 	return set_tag(object, tag);
diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
index 863fed4edd3f..30ce88935e9d 100644
--- a/mm/kasan/hw_tags.c
+++ b/mm/kasan/hw_tags.c
@@ -8,18 +8,115 @@
 
 #define pr_fmt(fmt) "kasan: " fmt
 
+#include <linux/init.h>
 #include <linux/kasan.h>
 #include <linux/kernel.h>
 #include <linux/memory.h>
 #include <linux/mm.h>
+#include <linux/static_key.h>
 #include <linux/string.h>
 #include <linux/types.h>
 
 #include "kasan.h"
 
+enum kasan_arg_mode {
+	KASAN_ARG_MODE_DEFAULT,
+	KASAN_ARG_MODE_OFF,
+	KASAN_ARG_MODE_PROD,
+	KASAN_ARG_MODE_FULL,
+};
+
+enum kasan_arg_stacktrace {
+	KASAN_ARG_STACKTRACE_DEFAULT,
+	KASAN_ARG_STACKTRACE_OFF,
+	KASAN_ARG_STACKTRACE_ON,
+};
+
+enum kasan_arg_fault {
+	KASAN_ARG_FAULT_DEFAULT,
+	KASAN_ARG_FAULT_REPORT,
+	KASAN_ARG_FAULT_PANIC,
+};
+
+static enum kasan_arg_mode kasan_arg_mode __ro_after_init;
+static enum kasan_arg_stacktrace kasan_arg_stacktrace __ro_after_init;
+static enum kasan_arg_fault kasan_arg_fault __ro_after_init;
+
+/* Whether KASAN is enabled at all. */
+DEFINE_STATIC_KEY_FALSE_RO(kasan_flag_enabled);
+EXPORT_SYMBOL(kasan_flag_enabled);
+
+/* Whether to collect alloc/free stack traces. */
+DEFINE_STATIC_KEY_FALSE_RO(kasan_flag_stacktrace);
+
+/* Whether panic or disable tag checking on fault. */
+bool kasan_flag_panic __ro_after_init;
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
+static int __init early_kasan_flag_stacktrace(char *arg)
+{
+	if (!arg)
+		return -EINVAL;
+
+	if (!strcmp(arg, "off"))
+		kasan_arg_stacktrace = KASAN_ARG_STACKTRACE_OFF;
+	else if (!strcmp(arg, "on"))
+		kasan_arg_stacktrace = KASAN_ARG_STACKTRACE_ON;
+	else
+		return -EINVAL;
+
+	return 0;
+}
+early_param("kasan.stacktrace", early_kasan_flag_stacktrace);
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
 /* kasan_init_hw_tags_cpu() is called for each CPU. */
 void kasan_init_hw_tags_cpu(void)
 {
+	/*
+	 * There's no need to check that the hardware is MTE-capable here,
+	 * as this function is only called for MTE-capable hardware.
+	 */
+
+	/* If KASAN is disabled, do nothing. */
+	if (kasan_arg_mode == KASAN_ARG_MODE_OFF)
+		return;
+
 	hw_init_tags(KASAN_TAG_MAX);
 	hw_enable_tagging();
 }
@@ -27,6 +124,60 @@ void kasan_init_hw_tags_cpu(void)
 /* kasan_init_hw_tags() is called once on boot CPU. */
 void __init kasan_init_hw_tags(void)
 {
+	/* If hardware doesn't support MTE, do nothing. */
+	if (!system_supports_mte())
+		return;
+
+	/* Choose KASAN mode if kasan boot parameter is not provided. */
+	if (kasan_arg_mode == KASAN_ARG_MODE_DEFAULT) {
+		if (IS_ENABLED(CONFIG_DEBUG_KERNEL))
+			kasan_arg_mode = KASAN_ARG_MODE_FULL;
+		else
+			kasan_arg_mode = KASAN_ARG_MODE_PROD;
+	}
+
+	/* Preset parameter values based on the mode. */
+	switch (kasan_arg_mode) {
+	case KASAN_ARG_MODE_DEFAULT:
+		/* Shouldn't happen as per the check above. */
+		WARN_ON(1);
+		return;
+	case KASAN_ARG_MODE_OFF:
+		/* If KASAN is disabled, do nothing. */
+		return;
+	case KASAN_ARG_MODE_PROD:
+		static_branch_enable(&kasan_flag_enabled);
+		break;
+	case KASAN_ARG_MODE_FULL:
+		static_branch_enable(&kasan_flag_enabled);
+		static_branch_enable(&kasan_flag_stacktrace);
+		break;
+	}
+
+	/* Now, optionally override the presets. */
+
+	switch (kasan_arg_stacktrace) {
+	case KASAN_ARG_STACKTRACE_DEFAULT:
+		break;
+	case KASAN_ARG_STACKTRACE_OFF:
+		static_branch_disable(&kasan_flag_stacktrace);
+		break;
+	case KASAN_ARG_STACKTRACE_ON:
+		static_branch_enable(&kasan_flag_stacktrace);
+		break;
+	}
+
+	switch (kasan_arg_fault) {
+	case KASAN_ARG_FAULT_DEFAULT:
+		break;
+	case KASAN_ARG_FAULT_REPORT:
+		kasan_flag_panic = false;
+		break;
+	case KASAN_ARG_FAULT_PANIC:
+		kasan_flag_panic = true;
+		break;
+	}
+
 	pr_info("KernelAddressSanitizer initialized\n");
 }
 
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 8aa83b7ad79e..d01a5ac34f70 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -6,6 +6,22 @@
 #include <linux/kfence.h>
 #include <linux/stackdepot.h>
 
+#ifdef CONFIG_KASAN_HW_TAGS
+#include <linux/static_key.h>
+DECLARE_STATIC_KEY_FALSE(kasan_flag_stacktrace);
+static inline bool kasan_stack_collection_enabled(void)
+{
+	return static_branch_unlikely(&kasan_flag_stacktrace);
+}
+#else
+static inline bool kasan_stack_collection_enabled(void)
+{
+	return true;
+}
+#endif
+
+extern bool kasan_flag_panic __ro_after_init;
+
 #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 #define KASAN_GRANULE_SIZE	(1UL << KASAN_SHADOW_SCALE_SHIFT)
 #else
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 76a0e3ae2049..ffa6076b1710 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -99,6 +99,10 @@ static void end_report(unsigned long *flags)
 		panic_on_warn = 0;
 		panic("panic_on_warn set ...\n");
 	}
+#ifdef CONFIG_KASAN_HW_TAGS
+	if (kasan_flag_panic)
+		panic("kasan.fault=panic set ...\n");
+#endif
 	kasan_enable_current();
 }
 
@@ -161,8 +165,8 @@ static void describe_object_addr(struct kmem_cache *cache, void *object,
 		(void *)(object_addr + cache->object_size));
 }
 
-static void describe_object(struct kmem_cache *cache, void *object,
-				const void *addr, u8 tag)
+static void describe_object_stacks(struct kmem_cache *cache, void *object,
+					const void *addr, u8 tag)
 {
 	struct kasan_alloc_meta *alloc_meta = kasan_get_alloc_meta(cache, object);
 
@@ -190,7 +194,13 @@ static void describe_object(struct kmem_cache *cache, void *object,
 		}
 #endif
 	}
+}
 
+static void describe_object(struct kmem_cache *cache, void *object,
+				const void *addr, u8 tag)
+{
+	if (kasan_stack_collection_enabled())
+		describe_object_stacks(cache, object, addr, tag);
 	describe_object_addr(cache, object, addr);
 }
 
-- 
2.29.2.299.gdc1121823c-goog

