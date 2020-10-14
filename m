Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC4B28E805
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 22:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389177AbgJNUpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 16:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388879AbgJNUpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 16:45:04 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CACC0613D2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 13:45:03 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id g184so605374qke.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 13:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=SUndFZwmd/UI7ffIXpzXKFFOW5Rrpznt5Bq+QYZ8r0w=;
        b=caicryyEbUpsIiZ0NMxXzTfuEB2I6l9NimsZ6Lk6Czndwv2e3G7VtJkCRKGYY4FWAT
         6uHlkTBwMQGK03tgQxtNK33SmCFmXX/ZiiOfaElRTt2AvB1IuQsUzCGNPm/ESL0z3zsV
         3pnR6sdai/eX52O2cMQXO10G9NgkjhnJZbKGbOf3Iu0pJh8LZmkFxOgoJ6A8yB6J+k26
         IuIYtakyU4uB3YuLy1C+0IV4/lGcy/Cc/uWNB2t3/fkHb47ZN2IcL3QOcXmACEr/Lx+4
         Ul81bm2qjhUIqn2E/9Qde6fHHlfgg+TUNsJKNzGZj4kkfh1nc4orCaR2vfpmo2V/JM68
         fsxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SUndFZwmd/UI7ffIXpzXKFFOW5Rrpznt5Bq+QYZ8r0w=;
        b=WYOi8pwOiDE0aPtbDktzXRgMCADcPIdJ9DkYk6KnVckTS/p589+9+zSzndAwZTqndb
         hw6xUQ5EpMP64QvleDbffs7grpNEd3cEflwNx1+c41tRLvoPxH4AyrTj2itAvCcD2LE9
         uOS7gr38uujFHZZy/opMlP7bfC5hTzeorlEdD5ddMdPHqS+nwERPF7h50BPlWf6+hEI4
         Yf6Oll4cjs/oJREB3qkfSNAERD9bACLpuXI/R3RmIpYaGNdrv1lplVYdPp3bqtqVaTE3
         sZnBUC5Vs80NQu+HUy98PZIKI/Z8oDy8Cv4EQ7Pg1kFSXgXJ81IzmgYGE62WU0XhKU7j
         Ybxw==
X-Gm-Message-State: AOAM530Sgh+5BkZR3UI48IKtKsnpHkgAzoyQVDtwB2a/dg9dHFRBnxtv
        bs42HXYwq1wHpj6G/u+625AhLulHteumD5u2
X-Google-Smtp-Source: ABdhPJwkH7NZaiymmpkrpu4Oo26FdAmZETt4ONiB1fR/jb04+GN/F+l6yYohbS6UY0kfXjoO7q/MICddWQPbHX7/
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:ad4:4f46:: with SMTP id
 eu6mr1409445qvb.9.1602708302995; Wed, 14 Oct 2020 13:45:02 -0700 (PDT)
Date:   Wed, 14 Oct 2020 22:44:36 +0200
In-Reply-To: <cover.1602708025.git.andreyknvl@google.com>
Message-Id: <c44b27703fb2fa11029ecd92522a66988295dfb6.1602708025.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1602708025.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH RFC 8/8] kasan: add and integrate kasan_mode boot param
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
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
 mm/kasan/common.c  | 69 +++++++++++++++++++++++++---------------------
 mm/kasan/generic.c |  4 +++
 mm/kasan/hw_tags.c | 53 +++++++++++++++++++++++++++++++++++
 mm/kasan/kasan.h   |  8 ++++++
 mm/kasan/report.c  | 10 +++++--
 mm/kasan/sw_tags.c |  4 +++
 6 files changed, 115 insertions(+), 33 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index a3e67d49b893..d642d5fce1e5 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -135,35 +135,37 @@ void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
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
+	if (static_branch_unlikely(&kasan_debug)) {
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
@@ -180,6 +182,7 @@ size_t kasan_metadata_size(struct kmem_cache *cache)
 struct kasan_alloc_meta *kasan_get_alloc_meta(struct kmem_cache *cache,
 					      const void *object)
 {
+	WARN_ON(!static_branch_unlikely(&kasan_debug));
 	return (void *)reset_tag(object) + cache->kasan_info.alloc_meta_offset;
 }
 
@@ -187,6 +190,7 @@ struct kasan_free_meta *kasan_get_free_meta(struct kmem_cache *cache,
 					    const void *object)
 {
 	BUILD_BUG_ON(sizeof(struct kasan_free_meta) > 32);
+	WARN_ON(!static_branch_unlikely(&kasan_debug));
 	return (void *)reset_tag(object) + cache->kasan_info.free_meta_offset;
 }
 
@@ -266,8 +270,10 @@ void * __must_check kasan_init_slab_obj(struct kmem_cache *cache,
 	if (!(cache->flags & SLAB_KASAN))
 		return (void *)object;
 
-	alloc_meta = kasan_get_alloc_meta(cache, object);
-	__memset(alloc_meta, 0, sizeof(*alloc_meta));
+	if (static_branch_unlikely(&kasan_debug)) {
+		alloc_meta = kasan_get_alloc_meta(cache, object);
+		__memset(alloc_meta, 0, sizeof(*alloc_meta));
+	}
 
 	if (IS_ENABLED(CONFIG_KASAN_SW_TAGS) || IS_ENABLED(CONFIG_KASAN_HW_TAGS))
 		object = set_tag(object, assign_tag(cache, object, true, false));
@@ -305,6 +311,7 @@ static bool __kasan_slab_free(struct kmem_cache *cache, void *object,
 	kasan_poison_memory(object, rounded_up_size, KASAN_KMALLOC_FREE);
 
 	if ((IS_ENABLED(CONFIG_KASAN_GENERIC) && !quarantine) ||
+			!static_branch_unlikely(&kasan_debug) ||
 			unlikely(!(cache->flags & SLAB_KASAN)))
 		return false;
 
@@ -351,7 +358,7 @@ static void *__kasan_kmalloc(struct kmem_cache *cache, const void *object,
 	kasan_poison_memory((void *)redzone_start, redzone_end - redzone_start,
 		KASAN_KMALLOC_REDZONE);
 
-	if (cache->flags & SLAB_KASAN)
+	if (static_branch_unlikely(&kasan_debug) && cache->flags & SLAB_KASAN)
 		set_alloc_info(cache, (void *)object, flags);
 
 	return set_tag(object, tag);
diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index d259e4c3aefd..9d968eaedc98 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -33,6 +33,10 @@
 #include "kasan.h"
 #include "../slab.h"
 
+/* See the comments in hw_tags.c */
+DEFINE_STATIC_KEY_TRUE_RO(kasan_enabled);
+DEFINE_STATIC_KEY_TRUE_RO(kasan_debug);
+
 /*
  * All functions below always inlined so compiler could
  * perform better optimizations in each of __asan_loadX/__assn_storeX
diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
index b372421258c8..fc6ab1c8b155 100644
--- a/mm/kasan/hw_tags.c
+++ b/mm/kasan/hw_tags.c
@@ -8,6 +8,8 @@
 
 #define pr_fmt(fmt) "kasan: " fmt
 
+#include <linux/init.h>
+#include <linux/jump_label.h>
 #include <linux/kasan.h>
 #include <linux/kernel.h>
 #include <linux/memory.h>
@@ -17,8 +19,57 @@
 
 #include "kasan.h"
 
+enum kasan_mode {
+	KASAN_MODE_OFF,
+	KASAN_MODE_ON,
+	KASAN_MODE_DEBUG,
+};
+
+static enum kasan_mode kasan_mode __ro_after_init;
+
+/* Whether KASAN is enabled at all. */
+/* TODO: ideally no KASAN callbacks when this is disabled. */
+DEFINE_STATIC_KEY_FALSE_RO(kasan_enabled);
+
+/* Whether to collect debugging info, e.g. alloc/free stack traces. */
+DEFINE_STATIC_KEY_FALSE_RO(kasan_debug);
+
+/* Whether to use syncronous or asynchronous tag checking. */
+static bool kasan_sync __ro_after_init;
+
+static int __init early_kasan_mode(char *arg)
+{
+	if (!arg)
+		return -EINVAL;
+
+	if (strcmp(arg, "on") == 0)
+		kasan_mode = KASAN_MODE_ON;
+	else if (strcmp(arg, "debug") == 0)
+		kasan_mode = KASAN_MODE_DEBUG;
+	return 0;
+}
+early_param("kasan_mode", early_kasan_mode);
+
 void __init kasan_init_tags(void)
 {
+	/* TODO: system_supports_tags() always returns 0 here, fix. */
+	if (0 /*!system_supports_tags()*/)
+		return;
+
+	switch (kasan_mode) {
+	case KASAN_MODE_OFF:
+		return;
+	case KASAN_MODE_ON:
+		static_branch_enable(&kasan_enabled);
+		break;
+	case KASAN_MODE_DEBUG:
+		static_branch_enable(&kasan_enabled);
+		static_branch_enable(&kasan_debug);
+		kasan_sync = true;
+		break;
+	}
+
+	/* TODO: choose between sync and async based on kasan_sync. */
 	init_tags(KASAN_TAG_MAX);
 
 	pr_info("KernelAddressSanitizer initialized\n");
@@ -60,6 +111,7 @@ void kasan_set_free_info(struct kmem_cache *cache,
 {
 	struct kasan_alloc_meta *alloc_meta;
 
+	WARN_ON(!static_branch_unlikely(&kasan_debug));
 	alloc_meta = kasan_get_alloc_meta(cache, object);
 	kasan_set_track(&alloc_meta->free_track[0], GFP_NOWAIT);
 }
@@ -69,6 +121,7 @@ struct kasan_track *kasan_get_free_track(struct kmem_cache *cache,
 {
 	struct kasan_alloc_meta *alloc_meta;
 
+	WARN_ON(!static_branch_unlikely(&kasan_debug));
 	alloc_meta = kasan_get_alloc_meta(cache, object);
 	return &alloc_meta->free_track[0];
 }
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 47d6074c7958..3712e7a39717 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -279,6 +279,14 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
 #define get_mem_tag(addr)			arch_get_mem_tag(addr)
 #define set_mem_tag_range(addr, size, tag)	arch_set_mem_tag_range((addr), (size), (tag))
 
+#ifdef CONFIG_KASAN_HW_TAGS
+DECLARE_STATIC_KEY_FALSE(kasan_enabled);
+DECLARE_STATIC_KEY_FALSE(kasan_debug);
+#else
+DECLARE_STATIC_KEY_TRUE(kasan_enabled);
+DECLARE_STATIC_KEY_TRUE(kasan_debug);
+#endif
+
 /*
  * Exported functions for interfaces called from assembly or from generated
  * code. Declarations here to avoid warning about missing declarations.
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index dee5350b459c..ae956a29ad4e 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -159,8 +159,8 @@ static void describe_object_addr(struct kmem_cache *cache, void *object,
 		(void *)(object_addr + cache->object_size));
 }
 
-static void describe_object(struct kmem_cache *cache, void *object,
-				const void *addr, u8 tag)
+static void describe_object_stacks(struct kmem_cache *cache, void *object,
+					const void *addr, u8 tag)
 {
 	struct kasan_alloc_meta *alloc_meta = kasan_get_alloc_meta(cache, object);
 
@@ -188,7 +188,13 @@ static void describe_object(struct kmem_cache *cache, void *object,
 		}
 #endif
 	}
+}
 
+static void describe_object(struct kmem_cache *cache, void *object,
+				const void *addr, u8 tag)
+{
+	if (static_branch_unlikely(&kasan_debug))
+		describe_object_stacks(cache, object, addr, tag);
 	describe_object_addr(cache, object, addr);
 }
 
diff --git a/mm/kasan/sw_tags.c b/mm/kasan/sw_tags.c
index 099af6dc8f7e..50e797a16e17 100644
--- a/mm/kasan/sw_tags.c
+++ b/mm/kasan/sw_tags.c
@@ -33,6 +33,10 @@
 #include "kasan.h"
 #include "../slab.h"
 
+/* See the comments in hw_tags.c */
+DEFINE_STATIC_KEY_TRUE_RO(kasan_enabled);
+DEFINE_STATIC_KEY_TRUE_RO(kasan_debug);
+
 static DEFINE_PER_CPU(u32, prng_state);
 
 void __init kasan_init_tags(void)
-- 
2.28.0.1011.ga647a8990f-goog

