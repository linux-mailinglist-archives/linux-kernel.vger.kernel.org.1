Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6F81295FC9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 15:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899726AbgJVNUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 09:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2899684AbgJVNUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 09:20:04 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B8AC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 06:20:04 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id r7so422819wmr.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 06:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=OXY1Rszcej9Z+zHeV4E2RjMvc6KaNi19mvRQTnsPsy0=;
        b=jSZdrkfYHdvmkFju49p2qS0kgX2rxE4/jZ6jdMbQBk8JbMtDBsCGSZDA0F5DFfMUzJ
         125NE/PkCAu7vblUYOEBxCcXW/oqJuZuWWNUhTID58/RzuS76DG+2id6CQTTfbadeKuU
         Nanbu0+Vac4ZfyGxSA4Eup2d5Q0cFnKE9eF+63c/g34MmKm3qg6zcKumetvpvAlrn0NZ
         CT6lCbQLpwFIm4Z2BFtFjpRLquLSET4CjXaU4jxUM/X1ZV6GXtFLHARWz7EkycSfDpJZ
         45XlQqS3KATaw5tIUU5NIoJW4nT6HtVwv0C3OE5c9IagN7/X9hbdZ7wMduUpy+LoOYjy
         sB9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OXY1Rszcej9Z+zHeV4E2RjMvc6KaNi19mvRQTnsPsy0=;
        b=WRkgzV6XVHouLCWEWR2aEexaLlMJOp/tIkQGYmcN9XJcODcJqqgJ1q2hG7IiB1UIq0
         1kBvOrTqiiAICIlTOfJRGbXzfSkd96ZUyH/c0Mugf7JkTvWd0bvmbjOeMoYKgl+7eWaa
         h5VOajnBaOUu/JCwznmPWsG50G0e12Iif6LxqmVDLLopxtIo6AQAa9SZVJWGFLjidYEM
         bRwHN2jVrOEKORBYqbkY5A/eq8ZhmugU2wnamABHXhyd0BNUxgY+9n+ObfxDUxwx88X7
         H3QwbiugyWNrSwofieobmOanWYyj0kZZjuh0vPGrVS0bAC3sxpRV4HWmqQxTxkqg1MO7
         EroA==
X-Gm-Message-State: AOAM532JglaQjGCvUlVsVygGrKD68eAWU/rINgBA38NBibqFyBabEQOB
        c4hrXLenRIbxv9nuS3qul/d3rm6tDuNRFLZN
X-Google-Smtp-Source: ABdhPJy3D1LRywWc/ht9ZMDiiul5ZWljka05fqMEDEJhehrq0Xcx8gYVjiEcOyxi8iZPzt+IvfBa0o5POo4KjZTx
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:adf:e88a:: with SMTP id
 d10mr2859147wrm.247.1603372802756; Thu, 22 Oct 2020 06:20:02 -0700 (PDT)
Date:   Thu, 22 Oct 2020 15:19:08 +0200
In-Reply-To: <cover.1603372719.git.andreyknvl@google.com>
Message-Id: <ce573435398f21d3e604f104c29ba65eca70d9e7.1603372719.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1603372719.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH RFC v2 16/21] kasan: optimize poisoning in kmalloc and krealloc
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

Since kasan_kmalloc() always follows kasan_slab_alloc(), there's no need
to reunpoison the object data, only to poison the redzone.

This requires changing kasan annotation for early SLUB cache to
kasan_slab_alloc(). Otherwise kasan_kmalloc() doesn't untag the object.
This doesn't do any functional changes, as kmem_cache_node->object_size
is equal to sizeof(struct kmem_cache_node).

Similarly for kasan_krealloc(), as it's called after ksize(), which
already unpoisoned the object, there's no need to do it again.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Link: https://linux-review.googlesource.com/id/I4083d3b55605f70fef79bca9b90843c4390296f2
---
 mm/kasan/common.c | 31 +++++++++++++++++++++----------
 mm/slub.c         |  3 +--
 2 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index c5ec60e1a4d2..a581937c2a44 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -360,8 +360,14 @@ static void *____kasan_kmalloc(struct kmem_cache *cache, const void *object,
 	if (IS_ENABLED(CONFIG_KASAN_SW_TAGS) || IS_ENABLED(CONFIG_KASAN_HW_TAGS))
 		tag = assign_tag(cache, object, false, keep_tag);
 
-	/* Tag is ignored in set_tag without CONFIG_KASAN_SW/HW_TAGS */
-	kasan_unpoison_memory(set_tag(object, tag), size);
+	/*
+	 * Don't unpoison the object when keeping the tag. Tag is kept for:
+	 * 1. krealloc(), and then the memory has already been unpoisoned via ksize();
+	 * 2. kmalloc(), and then the memory has already been unpoisoned by kasan_kmalloc().
+	 * Tag is ignored in set_tag() without CONFIG_KASAN_SW/HW_TAGS.
+	 */
+	if (!keep_tag)
+		kasan_unpoison_memory(set_tag(object, tag), size);
 	kasan_poison_memory((void *)redzone_start, redzone_end - redzone_start,
 		KASAN_KMALLOC_REDZONE);
 
@@ -384,10 +390,9 @@ void * __must_check __kasan_kmalloc(struct kmem_cache *cache, const void *object
 }
 EXPORT_SYMBOL(__kasan_kmalloc);
 
-void * __must_check __kasan_kmalloc_large(const void *ptr, size_t size,
-						gfp_t flags)
+static void * __must_check ____kasan_kmalloc_large(struct page *page, const void *ptr,
+						size_t size, gfp_t flags, bool realloc)
 {
-	struct page *page;
 	unsigned long redzone_start;
 	unsigned long redzone_end;
 
@@ -397,18 +402,24 @@ void * __must_check __kasan_kmalloc_large(const void *ptr, size_t size,
 	if (unlikely(ptr == NULL))
 		return NULL;
 
-	page = virt_to_page(ptr);
-	redzone_start = round_up((unsigned long)(ptr + size),
-				KASAN_GRANULE_SIZE);
+	redzone_start = round_up((unsigned long)(ptr + size), KASAN_GRANULE_SIZE);
 	redzone_end = (unsigned long)ptr + page_size(page);
 
-	kasan_unpoison_memory(ptr, size);
+	/* ksize() in __do_krealloc() already unpoisoned the memory. */
+	if (!realloc)
+		kasan_unpoison_memory(ptr, size);
 	kasan_poison_memory((void *)redzone_start, redzone_end - redzone_start,
 		KASAN_PAGE_REDZONE);
 
 	return (void *)ptr;
 }
 
+void * __must_check __kasan_kmalloc_large(const void *ptr, size_t size,
+						gfp_t flags)
+{
+	return ____kasan_kmalloc_large(virt_to_page(ptr), ptr, size, flags, false);
+}
+
 void * __must_check __kasan_krealloc(const void *object, size_t size, gfp_t flags)
 {
 	struct page *page;
@@ -419,7 +430,7 @@ void * __must_check __kasan_krealloc(const void *object, size_t size, gfp_t flag
 	page = virt_to_head_page(object);
 
 	if (unlikely(!PageSlab(page)))
-		return __kasan_kmalloc_large(object, size, flags);
+		return ____kasan_kmalloc_large(page, object, size, flags, true);
 	else
 		return ____kasan_kmalloc(page->slab_cache, object, size,
 						flags, true);
diff --git a/mm/slub.c b/mm/slub.c
index 1d3f2355df3b..afb035b0bf2d 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3535,8 +3535,7 @@ static void early_kmem_cache_node_alloc(int node)
 	init_object(kmem_cache_node, n, SLUB_RED_ACTIVE);
 	init_tracking(kmem_cache_node, n);
 #endif
-	n = kasan_kmalloc(kmem_cache_node, n, sizeof(struct kmem_cache_node),
-		      GFP_KERNEL);
+	n = kasan_slab_alloc(kmem_cache_node, n, GFP_KERNEL);
 	page->freelist = get_freepointer(kmem_cache_node, n);
 	page->inuse = 1;
 	page->frozen = 0;
-- 
2.29.0.rc1.297.gfa9743e501-goog

