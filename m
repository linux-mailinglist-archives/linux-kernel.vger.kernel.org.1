Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1698E2A738F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 01:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387559AbgKEADF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 19:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387443AbgKEADD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 19:03:03 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED3BC0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 16:03:02 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id q18so38791qke.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 16:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=YHPz8JrRkO/XRi71L68uJnMTHNWIIJmflnYXoYMB1HU=;
        b=MX4puu5vY5ArnM06rFh+Cesd3ekV0Pt8TXclcxkRsmn9ZJcjqSxu5S4dY6abyKf7/d
         fPBWZ1NcRQyBMo8+o0SGloqmEoVjT24NRRNqMHykXQ2LwZSyF77DyOl1BHVE8V5D64QO
         pa51EuoTzpt+vlTQKxImAS83FZCb82pvJk7wtJnQvTmg5D6jKcX7oJTm6QURngCsnwQM
         vaqaEgbJlp+et0wpzHH0o5KK4L3N3fk2igBMo8GHqoxXk2KQ6GrEJZ8msKygxFZIo7/0
         56U1QvIKMOKf6pjQoDsq7IKEEtfN2EXrVv1VoEl6xXsp8JVNVJ8WpnPI98b6peFxEftd
         md1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YHPz8JrRkO/XRi71L68uJnMTHNWIIJmflnYXoYMB1HU=;
        b=dyE+ngf1DYB7gs0sXdPeoF0uVwATYZl7eZHSXudiwr80ZBl6AjzXtJkamscJTiIU0D
         535AtSHXZtuzVXrISnh+ajQrzcbVYjjwf4X4VX2i3prFn1JXDi9YGlK0xfXSlEYC4LuA
         s21qwSirf3MRisBxyqhWxtRYQL++6XYxwZRQDUdtNjkObXtzNZVxeip0vLhZWh0txKIa
         V59SEqiVR2QRgx0a+jCw3RBXQlmdEXCcLqJUW+4k7ysg+KM3IOKwAIZ0CshWC0QWpx8J
         d18aR8ju3od6UxrrajqIw9wg8NA3UW52UC4ZC6KFyAYGTDWTbrHvrr9g4vp7eR/J0Xjo
         tMEA==
X-Gm-Message-State: AOAM531MhaV9yMx4ZwvbMe45PYfSnv7kgPmfsSBDgR27OwIznzRorGHA
        RrwCz6IBtJdtHRZmfRCZK3Lcjl4hp9MqQjvu
X-Google-Smtp-Source: ABdhPJyy9dYPH53G7mNH8StH+XA61fxu2VluKrIUzwGUzcdlLu3J13fpNk0YwaAKhzuBscpovrcCh9MFsI99dfia
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:ad4:560d:: with SMTP id
 ca13mr435510qvb.2.1604534581496; Wed, 04 Nov 2020 16:03:01 -0800 (PST)
Date:   Thu,  5 Nov 2020 01:02:21 +0100
In-Reply-To: <cover.1604534322.git.andreyknvl@google.com>
Message-Id: <050977b6a6e0baee4afb4e701b600af32ee85ee6.1604534322.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1604534322.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH 11/20] kasan: add and integrate kasan boot parameters
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Evgenii Stepanov <eugenis@google.com>,
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

- kasan.stack=off/on - enable stacks collection
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
 mm/kasan/hw_tags.c | 144 +++++++++++++++++++++++++++++++++++++++++++++
 mm/kasan/kasan.h   |  16 +++++
 mm/kasan/report.c  |  14 ++++-
 4 files changed, 189 insertions(+), 7 deletions(-)

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
index bd8bf05c8034..52984825c75f 100644
--- a/mm/kasan/hw_tags.c
+++ b/mm/kasan/hw_tags.c
@@ -8,6 +8,8 @@
 
 #define pr_fmt(fmt) "kasan: " fmt
 
+#include <linux/init.h>
+#include <linux/jump_label.h>
 #include <linux/kasan.h>
 #include <linux/kernel.h>
 #include <linux/memory.h>
@@ -17,11 +19,153 @@
 
 #include "kasan.h"
 
+enum kasan_arg_mode {
+	KASAN_ARG_MODE_DEFAULT,
+	KASAN_ARG_MODE_OFF,
+	KASAN_ARG_MODE_PROD,
+	KASAN_ARG_MODE_FULL,
+};
+
+enum kasan_arg_stacks {
+	KASAN_ARG_STACKS_DEFAULT,
+	KASAN_ARG_STACKS_OFF,
+	KASAN_ARG_STACKS_ON,
+};
+
+enum kasan_arg_fault {
+	KASAN_ARG_FAULT_DEFAULT,
+	KASAN_ARG_FAULT_REPORT,
+	KASAN_ARG_FAULT_PANIC,
+};
+
+static enum kasan_arg_mode kasan_arg_mode __ro_after_init;
+static enum kasan_arg_stacks kasan_arg_stacks __ro_after_init;
+static enum kasan_arg_fault kasan_arg_fault __ro_after_init;
+
+/* Whether KASAN is enabled at all. */
+DEFINE_STATIC_KEY_FALSE_RO(kasan_flag_enabled);
+EXPORT_SYMBOL(kasan_flag_enabled);
+
+/* Whether to collect alloc/free stack traces. */
+DEFINE_STATIC_KEY_FALSE_RO(kasan_flag_stacks);
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
+static int __init early_kasan_flag_stacks(char *arg)
+{
+	if (!arg)
+		return -EINVAL;
+
+	if (!strcmp(arg, "off"))
+		kasan_arg_stacks = KASAN_ARG_STACKS_OFF;
+	else if (!strcmp(arg, "on"))
+		kasan_arg_stacks = KASAN_ARG_STACKS_ON;
+	else
+		return -EINVAL;
+
+	return 0;
+}
+early_param("kasan.stacks", early_kasan_flag_stacks);
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
 /* kasan_init_hw_tags() is called for each CPU. */
 void kasan_init_hw_tags(void)
 {
+	/* Choose KASAN mode if kasan boot parameter is not provided. */
+	if (kasan_arg_mode == KASAN_ARG_MODE_DEFAULT) {
+		if (IS_ENABLED(CONFIG_DEBUG_KERNEL))
+			kasan_arg_mode = KASAN_ARG_MODE_FULL;
+		else
+			kasan_arg_mode = KASAN_ARG_MODE_PROD;
+	}
+
+	/* If KASAN isn't enabled, do nothing. */
+	if (kasan_arg_mode == KASAN_ARG_MODE_OFF)
+		return;
+
+	/* Only process the boot parameters on boot CPU. */
+	if (smp_processor_id() == 0) {
+		/* Preset parameter values based on the mode. */
+		switch (kasan_arg_mode) {
+		case KASAN_ARG_MODE_OFF:
+			return;
+		case KASAN_ARG_MODE_PROD:
+			static_branch_enable(&kasan_flag_enabled);
+			break;
+		case KASAN_ARG_MODE_FULL:
+			static_branch_enable(&kasan_flag_enabled);
+			static_branch_enable(&kasan_flag_stacks);
+			break;
+		default:
+			break;
+		}
+
+		/* Now, optionally override the presets. */
+
+		switch (kasan_arg_stacks) {
+		case KASAN_ARG_STACKS_OFF:
+			static_branch_disable(&kasan_flag_stacks);
+			break;
+		case KASAN_ARG_STACKS_ON:
+			static_branch_enable(&kasan_flag_stacks);
+			break;
+		default:
+			break;
+		}
+
+		switch (kasan_arg_fault) {
+		case KASAN_ARG_FAULT_REPORT:
+			kasan_flag_panic = false;
+			break;
+		case KASAN_ARG_FAULT_PANIC:
+			kasan_flag_panic = true;
+			break;
+		default:
+			break;
+		}
+	}
+
+	/* Init tags for each CPU. */
 	hw_init_tags(KASAN_TAG_MAX);
 
+	/* Only print the message on boot CPU. */
 	if (smp_processor_id() == 0)
 		pr_info("KernelAddressSanitizer initialized\n");
 }
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index ba850285a360..8a4cd9618142 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -5,6 +5,22 @@
 #include <linux/kasan.h>
 #include <linux/stackdepot.h>
 
+#ifdef CONFIG_KASAN_HW_TAGS
+#include <linux/jump_label.h>
+DECLARE_STATIC_KEY_FALSE(kasan_flag_stacks);
+static inline bool kasan_stack_collection_enabled(void)
+{
+	return static_branch_unlikely(&kasan_flag_stacks);
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
2.29.1.341.ge80a0c044ae-goog

