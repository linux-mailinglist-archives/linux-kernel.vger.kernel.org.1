Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE3A12A7392
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 01:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387845AbgKEAEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 19:04:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387540AbgKEADA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 19:03:00 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F086C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 16:03:00 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id w1so99654wrr.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 16:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=IR+L7pzOJ3S8sSm3PMiXuYbX9hdb+iZBoVgJRWY7cXM=;
        b=iH4SUzBBRR5CmezCpCssl96xuxWU5rYOC5p49knORlt/DlKkf4bUYRgUYkQfHbyqzI
         Wjp3S6zP0hsWuTRlT3kZrfLV35zK4lCv78SBodcqjwFi0y5k1iYJU4rPz7GCGMl8l2Yf
         Xgpd8Ec4O9XN/osspKXmsXrdmeI+tsrmxx2qHfYA1mRMz7vR/7y6s+EJU7woeySmHJ+x
         R75NynG563yeZ+l2+qkvA4ZWEKnIBqPguaJjoKaxkseImgY7sUuOO0WaupodY4v8b7l4
         L0A5JKrS9qa5u95L3dpVvEIUM5i4CDf4fEr8Jba3GgECYdL8KdeUeNrUvFq6f/0Bkw5D
         aJQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IR+L7pzOJ3S8sSm3PMiXuYbX9hdb+iZBoVgJRWY7cXM=;
        b=K9utuPfhnuk6vsoljxD6jr0E3IK+etJJtnlcPXIVZwCVhHXOpH5R/f5U+1yt4PHFwm
         HrHZiCTInqdQ1mVhNflaXosNtNo2wrY5rjaoZRiskXGYaSEXlZF1h9HAvPJAU8ERFdWs
         2now43t3AjDBHZHPi7gkIbwv70BkM80GQSSbyxiq3+2zG5N9PHNPKOxjcjT90pvn8TTG
         YPCDjuuu6R0XjcqtE5QYNWji+vBDIQMPQm1DV3RWzkMrhKD5u4J/zsuVL51y2lt2XlXB
         RkYmjcdi50zDoE0IdiYfKNiDLnfW6n7D5iQ+8NmoY3OLJfVM77vqVgnXBymkjFaYP0FL
         SYEg==
X-Gm-Message-State: AOAM5310QnCzHWT5gsLpUowLT4ReUa2Ze8EZMZ8jKaPUXkM08bH+bUi7
        k2JqVl1JQkvpdZhrJlblbAm5iKlepiZaZLW/
X-Google-Smtp-Source: ABdhPJziGq/j8udcryfhR03OaOpym1lVl1to/3Mi30OCnUP7ip/1hRB5UF2s45H8QUldbWJDkwFxs5TLqGB7SkVw
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a1c:bc08:: with SMTP id
 m8mr185656wmf.137.1604534579112; Wed, 04 Nov 2020 16:02:59 -0800 (PST)
Date:   Thu,  5 Nov 2020 01:02:20 +0100
In-Reply-To: <cover.1604534322.git.andreyknvl@google.com>
Message-Id: <82219b5988592173ba4fbf07abcb7009e3d7265a.1604534322.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1604534322.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH 10/20] kasan: inline and rename kasan_unpoison_memory
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

Currently kasan_unpoison_memory() is used as both an external annotation
and as an internal memory poisoning helper. Rename external annotation to
kasan_unpoison_data() and inline the internal helper for hardware
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
index 0211a4ec5d87..34236f134472 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -72,14 +72,15 @@ static inline void kasan_disable_current(void) {}
 
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
@@ -104,11 +105,6 @@ struct kasan_cache {
 	int free_meta_offset;
 };
 
-size_t __ksize(const void *);
-static inline void kasan_unpoison_slab(const void *ptr)
-{
-	kasan_unpoison_memory(ptr, __ksize(ptr));
-}
 size_t kasan_metadata_size(struct kmem_cache *cache);
 
 bool kasan_save_enable_multi_shot(void);
@@ -116,8 +112,6 @@ void kasan_restore_multi_shot(bool enabled);
 
 #else /* CONFIG_KASAN */
 
-static inline void kasan_unpoison_memory(const void *address, size_t size) {}
-
 static inline void kasan_alloc_pages(struct page *page, unsigned int order) {}
 static inline void kasan_free_pages(struct page *page, unsigned int order) {}
 
@@ -125,6 +119,9 @@ static inline void kasan_cache_create(struct kmem_cache *cache,
 				      unsigned int *size,
 				      slab_flags_t *flags) {}
 
+static inline void kasan_unpoison_data(const void *address, size_t size) { }
+static inline void kasan_unpoison_slab(const void *ptr) { }
+
 static inline void kasan_poison_slab(struct page *page) {}
 static inline void kasan_unpoison_object_data(struct kmem_cache *cache,
 					void *object) {}
@@ -164,7 +161,6 @@ static inline bool kasan_slab_free(struct kmem_cache *s, void *object,
 	return false;
 }
 
-static inline void kasan_unpoison_slab(const void *ptr) { }
 static inline size_t kasan_metadata_size(struct kmem_cache *cache) { return 0; }
 
 #endif /* CONFIG_KASAN */
diff --git a/kernel/fork.c b/kernel/fork.c
index 463ef51f2b05..d6ff6b5650aa 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -226,7 +226,7 @@ static unsigned long *alloc_thread_stack_node(struct task_struct *tsk, int node)
 			continue;
 
 		/* Mark stack accessible for KASAN. */
-		kasan_unpoison_memory(s->addr, THREAD_SIZE);
+		kasan_unpoison_data(s->addr, THREAD_SIZE);
 
 		/* Clear stale pointers from reused stack. */
 		memset(s->addr, 0, THREAD_SIZE);
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index a266b90636a1..4598c1364f19 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -184,6 +184,16 @@ struct kasan_free_meta *kasan_get_free_meta(struct kmem_cache *cache,
 	return kasan_reset_tag(object) + cache->kasan_info.free_meta_offset;
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
index 9d7b1f1a2553..bd8bf05c8034 100644
--- a/mm/kasan/hw_tags.c
+++ b/mm/kasan/hw_tags.c
@@ -26,12 +26,6 @@ void kasan_init_hw_tags(void)
 		pr_info("KernelAddressSanitizer initialized\n");
 }
 
-void kasan_unpoison_memory(const void *address, size_t size)
-{
-	hw_set_mem_tag_range(kasan_reset_tag(address),
-			round_up(size, KASAN_GRANULE_SIZE), get_tag(address));
-}
-
 void kasan_set_free_info(struct kmem_cache *cache,
 				void *object, u8 tag)
 {
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 73364acf6ec8..ba850285a360 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -279,6 +279,12 @@ static inline void kasan_poison_memory(const void *address, size_t size, u8 valu
 			round_up(size, KASAN_GRANULE_SIZE), value);
 }
 
+static inline void kasan_unpoison_memory(const void *address, size_t size)
+{
+	hw_set_mem_tag_range(kasan_reset_tag(address),
+			round_up(size, KASAN_GRANULE_SIZE), get_tag(address));
+}
+
 static inline bool check_invalid_free(void *addr)
 {
 	u8 ptr_tag = get_tag(addr);
@@ -291,6 +297,7 @@ static inline bool check_invalid_free(void *addr)
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
2.29.1.341.ge80a0c044ae-goog

