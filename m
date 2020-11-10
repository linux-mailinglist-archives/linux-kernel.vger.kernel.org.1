Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8B32AE33A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 23:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732552AbgKJWVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 17:21:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732427AbgKJWU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 17:20:57 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA224C0613D4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:20:55 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id 7so8476364qtw.23
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=C1AHhA2JiIvkEyQnY3sopRuy3W9NzHQWsdv6OutYhlM=;
        b=gvbp41WoAzww8TYRMkKnNegELr+4/Y7ni0aHb9h9e2Ek6BRCEc8wNmGcSuLXFrDdju
         8HFuejYaUD5zzx3ycw8T9elfW5ANAXirMImZOqD/oLXj2HVCz1N+dvi6nzg7Myeom8qF
         oOZF84RbQOqOFCChHPxL2C9Kv2NiHuBbkcZR0NRfazYmTWAYEXJi2p8kpQi/cHe8EVed
         DCIt1qRmzd0sV/2tF7FAS3pmWCL+sTMRTblqS0nTQeWXc5hqnMTNDeFFFsurS6+KxYhI
         7v2Sg3o9W2+dQYcGdjjASONR6vn+tDZdwD1OYziEKxKg/WI6riY39Z6vo/ae7LBj+tGb
         5yoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=C1AHhA2JiIvkEyQnY3sopRuy3W9NzHQWsdv6OutYhlM=;
        b=ZNfQ0DMr55u+ANt8Box5FhYUlNuA3xpVaJihQrgzaPtSva4nu8Sfm2bsyiB6xPO+mV
         HnlKK+vKMu6PAiXVZw1U2Q79th5VBTOcYERKpu1kBoGZaFbyK3GHdbXFj6QP/AT5kx6v
         zYJJfFNQ5lw6rRkAjPDezrarb4QWH61M+cjIxoS59mQTRyYD2m3oCxSjpv61KvXk8FPc
         UYpJ7ldxo/iJIUGmIwjlYWUmGSkrUg23+XaCQX42B1FIpsBzYhvKk9KcVhXRUMqzgVn4
         8zQxVTgLRV0oyZ+7dNhC3jHzTj69kEHuNmAXunljIGG652h2+2QybEqv4eK0fjkQqQCP
         Aa9g==
X-Gm-Message-State: AOAM531fO9SkoaSdyb8Pf0dO0YwSJLjoc9WP5ppSxymjb5ldZ7f88Cvq
        oKZZmVlFgyYC7CAaGzxJfcwdswisP4fPNxoo
X-Google-Smtp-Source: ABdhPJzULwIjhucxHMEL1ve5N+U+spPW+S0asJ3yxR73Odh5s887/rzw9Q2Ud8xCU6UwkQF11IYxomADZ/OybFc8
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a05:6214:1541:: with SMTP id
 t1mr21263869qvw.61.1605046855110; Tue, 10 Nov 2020 14:20:55 -0800 (PST)
Date:   Tue, 10 Nov 2020 23:20:15 +0100
In-Reply-To: <cover.1605046662.git.andreyknvl@google.com>
Message-Id: <fdf9e3aec8f57ebb2795710195f8aaf79e3b45bd.1605046662.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605046662.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH v2 11/20] kasan: add and integrate kasan boot parameters
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
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
 mm/kasan/hw_tags.c | 152 +++++++++++++++++++++++++++++++++++++++++++++
 mm/kasan/kasan.h   |  16 +++++
 mm/kasan/report.c  |  14 ++++-
 4 files changed, 197 insertions(+), 7 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 4598c1364f19..efad5ed6a3bd 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -129,6 +129,11 @@ void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
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
@@ -165,6 +170,8 @@ void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
 
 size_t kasan_metadata_size(struct kmem_cache *cache)
 {
+	if (!kasan_stack_collection_enabled())
+		return 0;
 	return (cache->kasan_info.alloc_meta_offset ?
 		sizeof(struct kasan_alloc_meta) : 0) +
 		(cache->kasan_info.free_meta_offset ?
@@ -267,11 +274,13 @@ void * __must_check kasan_init_slab_obj(struct kmem_cache *cache,
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
@@ -308,6 +317,9 @@ static bool __kasan_slab_free(struct kmem_cache *cache, void *object,
 	rounded_up_size = round_up(cache->object_size, KASAN_GRANULE_SIZE);
 	kasan_poison_memory(object, rounded_up_size, KASAN_KMALLOC_FREE);
 
+	if (!kasan_stack_collection_enabled())
+		return false;
+
 	if ((IS_ENABLED(CONFIG_KASAN_GENERIC) && !quarantine) ||
 			unlikely(!(cache->flags & SLAB_KASAN)))
 		return false;
@@ -355,7 +367,7 @@ static void *__kasan_kmalloc(struct kmem_cache *cache, const void *object,
 	kasan_poison_memory((void *)redzone_start, redzone_end - redzone_start,
 		KASAN_KMALLOC_REDZONE);
 
-	if (cache->flags & SLAB_KASAN)
+	if (kasan_stack_collection_enabled() && (cache->flags & SLAB_KASAN))
 		set_alloc_info(cache, (void *)object, flags);
 
 	return set_tag(object, tag);
diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
index 838b29e44e32..2f6f0261af8c 100644
--- a/mm/kasan/hw_tags.c
+++ b/mm/kasan/hw_tags.c
@@ -8,6 +8,8 @@
 
 #define pr_fmt(fmt) "kasan: " fmt
 
+#include <linux/init.h>
+#include <linux/jump_label.h>
 #include <linux/kasan.h>
 #include <linux/kernel.h>
 #include <linux/memory.h>
@@ -17,9 +19,104 @@
 
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
@@ -27,6 +124,61 @@ void kasan_init_hw_tags_cpu(void)
 /* kasan_init_hw_tags() is called once on boot CPU. */
 void kasan_init_hw_tags(void)
 {
+	/* If hardware doesn't support MTE, do nothing. */
+	if (!system_supports_mte())
+		return;
+
+	/* If KASAN is disabled, do nothing. */
+	if (kasan_arg_mode == KASAN_ARG_MODE_OFF)
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
+	case KASAN_ARG_MODE_OFF:
+		return;
+	case KASAN_ARG_MODE_PROD:
+		static_branch_enable(&kasan_flag_enabled);
+		break;
+	case KASAN_ARG_MODE_FULL:
+		static_branch_enable(&kasan_flag_enabled);
+		static_branch_enable(&kasan_flag_stacktrace);
+		break;
+	default:
+		break;
+	}
+
+	/* Now, optionally override the presets. */
+
+	switch (kasan_arg_stacktrace) {
+	case KASAN_ARG_STACKTRACE_OFF:
+		static_branch_disable(&kasan_flag_stacktrace);
+		break;
+	case KASAN_ARG_STACKTRACE_ON:
+		static_branch_enable(&kasan_flag_stacktrace);
+		break;
+	default:
+		break;
+	}
+
+	switch (kasan_arg_fault) {
+	case KASAN_ARG_FAULT_REPORT:
+		kasan_flag_panic = false;
+		break;
+	case KASAN_ARG_FAULT_PANIC:
+		kasan_flag_panic = true;
+		break;
+	default:
+		break;
+	}
+
 	pr_info("KernelAddressSanitizer initialized\n");
 }
 
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 2d3c99125996..5eff3d9f624e 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -5,6 +5,22 @@
 #include <linux/kasan.h>
 #include <linux/stackdepot.h>
 
+#ifdef CONFIG_KASAN_HW_TAGS
+#include <linux/jump_label.h>
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
index 25ca66c99e48..7d86af340148 100644
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
2.29.2.222.g5d2a92d10f8-goog

