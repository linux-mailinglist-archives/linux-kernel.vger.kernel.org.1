Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84E2A295FC3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 15:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899689AbgJVNUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 09:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2899669AbgJVNTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 09:19:55 -0400
Received: from mail-lf1-x149.google.com (mail-lf1-x149.google.com [IPv6:2a00:1450:4864:20::149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161EFC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 06:19:55 -0700 (PDT)
Received: by mail-lf1-x149.google.com with SMTP id i21so294762lfo.11
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 06:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=IcAE4Jyu1jclhjsbbav79rrFgX1+75/awDcEqCY54u8=;
        b=JUPSUQCugXbpMvU+5lWMoq1Q7csjmAxp/+xs9wlbLHvL0gEIeeRyX74Xq81EkalwMD
         CDbEUkHaZHb5wWaHbmZXBc6CkAs7EVeetyNeWUZ9+k0pputrmvxW17UUEOPok9ia51HV
         qHRwNWCHdqavnqYSJqpxB4/B3n1/4UCmgUqrkESq3/QnSeMUMTYp1wZioTJYAIzjnY5j
         8amHP91XRSNR62vonB2SS+JDQUOL8qO8VtRl1V3Si0NljR3vu7YEKBpAt+m7plkEaSwu
         Fvbo8vCqd8yRnFojZjnyO0ppYrMqgTvWf1y0IwK5mkN/B0xmqTNyqUVY0CcSnQEfYBex
         CMqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IcAE4Jyu1jclhjsbbav79rrFgX1+75/awDcEqCY54u8=;
        b=S5mQm6j9xjXc8HYTJVmJgDeWKHmwuldkJMwWvq1EXRa48dbJxANlZjUJcaby2JTVxy
         UwXaoF9n2X8FvcrSC3P/kfRaeGII6ErrDm0/Y9OmP83YyxELVDqMnsXYUQlBumAwBxes
         pVzs4apLQoLDRU3AyWfkKPyT8DG5KYGdLQfWKnYDaQJ91LQLoEwdsMVCYgBNSPH7a8wk
         AbqxkWjMHcS6q8NfbOe/0zp0UvVOLncJDGGVRBff6UkVGHRXcx8mqvqLZdKUkAoK0Eh/
         OZZWlOValV0nJRN5Fa+GB/vsuCf64xTWOBiFgFR9in/wPOExzMt2ADeKoGPs5lk8xyqf
         65yg==
X-Gm-Message-State: AOAM530s7R192W/4gfl6Mkx1N9m9g71g/d+jsORcOhDOt7b8Zem1DQOC
        rb9CsGYa6eRQWzAkqyaO3CZ3Saq3Iz3AyZZf
X-Google-Smtp-Source: ABdhPJwZGwfk0XCwSQapv30wLa6jrBk0HnDt0f1kgNHrVf7DZPKxRI4cNcY1vAmAYLTPAeB8Q8a2l9IHoun2wT9B
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a19:8a88:: with SMTP id
 m130mr896681lfd.503.1603372793217; Thu, 22 Oct 2020 06:19:53 -0700 (PDT)
Date:   Thu, 22 Oct 2020 15:19:04 +0200
In-Reply-To: <cover.1603372719.git.andreyknvl@google.com>
Message-Id: <6f87cb86aeeca9f4148d435ff01ad7d21af4bdfc.1603372719.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1603372719.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH RFC v2 12/21] kasan: inline and rename kasan_unpoison_memory
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

Currently kasan_unpoison_memory() is used as both an external annotation
and as internal memory poisoning helper. Rename external annotation to
kasan_unpoison_data() and inline the internal helper for for hardware
tag-based mode to avoid undeeded function calls.

There's the external annotation kasan_unpoison_slab() that is currently
defined as static inline and uses kasan_unpoison_memory(). With this
change it's turned into a function call. Overall, this results in the
same number of calls for hardware tag-based mode as
kasan_unpoison_memory() is now inlined.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Link: https://linux-review.googlesource.com/id/Ia7c8b659f79209935cbaab3913bf7f082cc43a0e
---
 include/linux/kasan.h | 16 ++++++----------
 kernel/fork.c         |  2 +-
 mm/kasan/common.c     | 10 ++++++++++
 mm/kasan/hw_tags.c    |  6 ------
 mm/kasan/kasan.h      |  7 +++++++
 mm/slab_common.c      |  2 +-
 6 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 6377d7d3a951..2b9023224474 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -66,14 +66,15 @@ static inline void kasan_disable_current(void) {}
 
 #ifdef CONFIG_KASAN
 
-void kasan_unpoison_memory(const void *address, size_t size);
-
 void kasan_alloc_pages(struct page *page, unsigned int order);
 void kasan_free_pages(struct page *page, unsigned int order);
 
 void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
 			slab_flags_t *flags);
 
+void kasan_unpoison_data(const void *address, size_t size);
+void kasan_unpoison_slab(const void *ptr);
+
 void kasan_poison_slab(struct page *page);
 void kasan_unpoison_object_data(struct kmem_cache *cache, void *object);
 void kasan_poison_object_data(struct kmem_cache *cache, void *object);
@@ -98,11 +99,6 @@ struct kasan_cache {
 	int free_meta_offset;
 };
 
-size_t __ksize(const void *);
-static inline void kasan_unpoison_slab(const void *ptr)
-{
-	kasan_unpoison_memory(ptr, __ksize(ptr));
-}
 size_t kasan_metadata_size(struct kmem_cache *cache);
 
 bool kasan_save_enable_multi_shot(void);
@@ -110,8 +106,6 @@ void kasan_restore_multi_shot(bool enabled);
 
 #else /* CONFIG_KASAN */
 
-static inline void kasan_unpoison_memory(const void *address, size_t size) {}
-
 static inline void kasan_alloc_pages(struct page *page, unsigned int order) {}
 static inline void kasan_free_pages(struct page *page, unsigned int order) {}
 
@@ -119,6 +113,9 @@ static inline void kasan_cache_create(struct kmem_cache *cache,
 				      unsigned int *size,
 				      slab_flags_t *flags) {}
 
+static inline void kasan_unpoison_data(const void *address, size_t size) { }
+static inline void kasan_unpoison_slab(const void *ptr) { }
+
 static inline void kasan_poison_slab(struct page *page) {}
 static inline void kasan_unpoison_object_data(struct kmem_cache *cache,
 					void *object) {}
@@ -158,7 +155,6 @@ static inline bool kasan_slab_free(struct kmem_cache *s, void *object,
 	return false;
 }
 
-static inline void kasan_unpoison_slab(const void *ptr) { }
 static inline size_t kasan_metadata_size(struct kmem_cache *cache) { return 0; }
 
 #endif /* CONFIG_KASAN */
diff --git a/kernel/fork.c b/kernel/fork.c
index b41fecca59d7..858d78eee6ec 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -225,7 +225,7 @@ static unsigned long *alloc_thread_stack_node(struct task_struct *tsk, int node)
 			continue;
 
 		/* Mark stack accessible for KASAN. */
-		kasan_unpoison_memory(s->addr, THREAD_SIZE);
+		kasan_unpoison_data(s->addr, THREAD_SIZE);
 
 		/* Clear stale pointers from reused stack. */
 		memset(s->addr, 0, THREAD_SIZE);
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 9008fc6b0810..1a5e6c279a72 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -184,6 +184,16 @@ struct kasan_free_meta *kasan_get_free_meta(struct kmem_cache *cache,
 	return (void *)reset_tag(object) + cache->kasan_info.free_meta_offset;
 }
 
+void kasan_unpoison_data(const void *address, size_t size)
+{
+	kasan_unpoison_memory(address, size);
+}
+
+void kasan_unpoison_slab(const void *ptr)
+{
+	kasan_unpoison_memory(ptr, __ksize(ptr));
+}
+
 void kasan_poison_slab(struct page *page)
 {
 	unsigned long i;
diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
index f03161f3da19..915142da6b57 100644
--- a/mm/kasan/hw_tags.c
+++ b/mm/kasan/hw_tags.c
@@ -24,12 +24,6 @@ void __init kasan_init_tags(void)
 	pr_info("KernelAddressSanitizer initialized\n");
 }
 
-void kasan_unpoison_memory(const void *address, size_t size)
-{
-	set_mem_tag_range(reset_tag(address),
-			  round_up(size, KASAN_GRANULE_SIZE), get_tag(address));
-}
-
 void kasan_set_free_info(struct kmem_cache *cache,
 				void *object, u8 tag)
 {
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 8d84ae6f58f1..da08b2533d73 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -280,6 +280,12 @@ static inline void kasan_poison_memory(const void *address, size_t size, u8 valu
 			  round_up(size, KASAN_GRANULE_SIZE), value);
 }
 
+static inline void kasan_unpoison_memory(const void *address, size_t size)
+{
+	set_mem_tag_range(reset_tag(address),
+			  round_up(size, KASAN_GRANULE_SIZE), get_tag(address));
+}
+
 static inline bool check_invalid_free(void *addr)
 {
 	u8 ptr_tag = get_tag(addr);
@@ -292,6 +298,7 @@ static inline bool check_invalid_free(void *addr)
 #else /* CONFIG_KASAN_HW_TAGS */
 
 void kasan_poison_memory(const void *address, size_t size, u8 value);
+void kasan_unpoison_memory(const void *address, size_t size);
 bool check_invalid_free(void *addr);
 
 #endif /* CONFIG_KASAN_HW_TAGS */
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 53d0f8bb57ea..f1b0c4a22f08 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1176,7 +1176,7 @@ size_t ksize(const void *objp)
 	 * We assume that ksize callers could use whole allocated area,
 	 * so we need to unpoison this area.
 	 */
-	kasan_unpoison_memory(objp, size);
+	kasan_unpoison_data(objp, size);
 	return size;
 }
 EXPORT_SYMBOL(ksize);
-- 
2.29.0.rc1.297.gfa9743e501-goog

