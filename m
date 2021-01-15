Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA1852F8314
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733283AbhAORy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:54:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732808AbhAORy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:54:26 -0500
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3500FC06179E
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:53:28 -0800 (PST)
Received: by mail-ed1-x549.google.com with SMTP id m16so4168198edd.21
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=s9iTK42qkuuD6lYECtRWQxjMOH1zhUNQbPwL/2iO3lo=;
        b=O2+V2KguK/zlzi5IVNcxgJTnqP7u2ELwLAnBN4dZIEl6ZBfjPiJAwTDAEWwhu/sZCh
         A2+93OkWMs5vC8pXbTn+A6N1GirgD6H0UcsWrFL1CR+MVZ27mpKOdhJqou9S+cza6cuV
         QcMBq0kbClbElTJkzfKH1ukQw5+Ct3+fT5kxRRIuYNzTweKcSNLlXWs4Q5kfhOYJKMHp
         WVSqPUsEopg5+HL4NgBlJhWzTNddOBdMsktqMsUPPd2Bits0lxlISlGIHIfmyoCnV1us
         xI+rUvBJEcsjTS1GLXOkkElCdJSrrCc90w/ueN3qBXqChkkSBiObivGcmKblpcT03Q3c
         Nn+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=s9iTK42qkuuD6lYECtRWQxjMOH1zhUNQbPwL/2iO3lo=;
        b=Q9yqSnPP3G1i5+3jrYIpIOfK0P9BBc+g2W0FB8PykY3ES3IxKYt03qJM4DmKCwfCUX
         xEwvjTwYQ6RjZLvu4YcphxrGfWDKR01ZDk7C9h9VGHZMx06H9rjVjBHTg2DcvOysJoOw
         av5UQGO5zPZSpHQKUp93dQdGMZ8B1vDCnO1CsYNDa1+q45GVc8kWjPglk3KSnDzWeAZr
         Zed5b2xRnXGMegYeW6A9IFJ2+g+pGr+ni+8ZVyebUdbNJq4DxDvOHk9FankQep7PGSVP
         0lMCyv19Jq4TmlvZ7k82UiRuCVOonHU5QKq+JPN+Sqm64+B9S2253YFNNFrl/YG420xJ
         pidg==
X-Gm-Message-State: AOAM530Gndv6ZGLuCEB4wpwl6QZfXo9hz5+7aqm5+pbETdYNVEJP4E6D
        jR2ZCLflG0SEhpoEbf/g2uepxsBAeua1oP+L
X-Google-Smtp-Source: ABdhPJz2IP/EHvbtZjuUifViynHIiNw7HJZvHC8wrDVcEbAFG03fk/aFEPZsBB6QxcsQvzWc6qn7cCRc3MUuvX/K
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a17:907:d8e:: with SMTP id
 go14mr9789602ejc.472.1610733206643; Fri, 15 Jan 2021 09:53:26 -0800 (PST)
Date:   Fri, 15 Jan 2021 18:52:48 +0100
In-Reply-To: <cover.1610733117.git.andreyknvl@google.com>
Message-Id: <5c1490eddf20b436b8c4eeea83fce47687d5e4a4.1610733117.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1610733117.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v4 11/15] kasan: move _RET_IP_ to inline wrappers
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Peter Collingbourne <pcc@google.com>,
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

Generic mm functions that call KASAN annotations that might report a bug
pass _RET_IP_ to them as an argument. This allows KASAN to include the
name of the function that called the mm function in its report's header.

Now that KASAN has inline wrappers for all of its annotations, move
_RET_IP_ to those wrappers to simplify annotation call sites.

Link: https://linux-review.googlesource.com/id/I8fb3c06d49671305ee184175a39591bc26647a67
Reviewed-by: Marco Elver <elver@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 include/linux/kasan.h | 20 +++++++++-----------
 mm/mempool.c          |  2 +-
 mm/slab.c             |  2 +-
 mm/slub.c             |  4 ++--
 4 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 5e0655fb2a6f..bba1637827c3 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -181,19 +181,18 @@ static __always_inline void * __must_check kasan_init_slab_obj(
 }
 
 bool __kasan_slab_free(struct kmem_cache *s, void *object, unsigned long ip);
-static __always_inline bool kasan_slab_free(struct kmem_cache *s, void *object,
-						unsigned long ip)
+static __always_inline bool kasan_slab_free(struct kmem_cache *s, void *object)
 {
 	if (kasan_enabled())
-		return __kasan_slab_free(s, object, ip);
+		return __kasan_slab_free(s, object, _RET_IP_);
 	return false;
 }
 
 void __kasan_slab_free_mempool(void *ptr, unsigned long ip);
-static __always_inline void kasan_slab_free_mempool(void *ptr, unsigned long ip)
+static __always_inline void kasan_slab_free_mempool(void *ptr)
 {
 	if (kasan_enabled())
-		__kasan_slab_free_mempool(ptr, ip);
+		__kasan_slab_free_mempool(ptr, _RET_IP_);
 }
 
 void * __must_check __kasan_slab_alloc(struct kmem_cache *s,
@@ -237,10 +236,10 @@ static __always_inline void * __must_check kasan_krealloc(const void *object,
 }
 
 void __kasan_kfree_large(void *ptr, unsigned long ip);
-static __always_inline void kasan_kfree_large(void *ptr, unsigned long ip)
+static __always_inline void kasan_kfree_large(void *ptr)
 {
 	if (kasan_enabled())
-		__kasan_kfree_large(ptr, ip);
+		__kasan_kfree_large(ptr, _RET_IP_);
 }
 
 bool kasan_save_enable_multi_shot(void);
@@ -273,12 +272,11 @@ static inline void *kasan_init_slab_obj(struct kmem_cache *cache,
 {
 	return (void *)object;
 }
-static inline bool kasan_slab_free(struct kmem_cache *s, void *object,
-				   unsigned long ip)
+static inline bool kasan_slab_free(struct kmem_cache *s, void *object)
 {
 	return false;
 }
-static inline void kasan_slab_free_mempool(void *ptr, unsigned long ip) {}
+static inline void kasan_slab_free_mempool(void *ptr) {}
 static inline void *kasan_slab_alloc(struct kmem_cache *s, void *object,
 				   gfp_t flags)
 {
@@ -298,7 +296,7 @@ static inline void *kasan_krealloc(const void *object, size_t new_size,
 {
 	return (void *)object;
 }
-static inline void kasan_kfree_large(void *ptr, unsigned long ip) {}
+static inline void kasan_kfree_large(void *ptr) {}
 
 #endif /* CONFIG_KASAN */
 
diff --git a/mm/mempool.c b/mm/mempool.c
index 624ed51b060f..79959fac27d7 100644
--- a/mm/mempool.c
+++ b/mm/mempool.c
@@ -104,7 +104,7 @@ static inline void poison_element(mempool_t *pool, void *element)
 static __always_inline void kasan_poison_element(mempool_t *pool, void *element)
 {
 	if (pool->alloc == mempool_alloc_slab || pool->alloc == mempool_kmalloc)
-		kasan_slab_free_mempool(element, _RET_IP_);
+		kasan_slab_free_mempool(element);
 	else if (pool->alloc == mempool_alloc_pages)
 		kasan_free_pages(element, (unsigned long)pool->pool_data);
 }
diff --git a/mm/slab.c b/mm/slab.c
index d7c8da9319c7..afeb6191fb1e 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3421,7 +3421,7 @@ static __always_inline void __cache_free(struct kmem_cache *cachep, void *objp,
 		memset(objp, 0, cachep->object_size);
 
 	/* Put the object into the quarantine, don't touch it for now. */
-	if (kasan_slab_free(cachep, objp, _RET_IP_))
+	if (kasan_slab_free(cachep, objp))
 		return;
 
 	/* Use KCSAN to help debug racy use-after-free. */
diff --git a/mm/slub.c b/mm/slub.c
index 75fb097d990d..0afb53488238 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1514,7 +1514,7 @@ static inline void *kmalloc_large_node_hook(void *ptr, size_t size, gfp_t flags)
 static __always_inline void kfree_hook(void *x)
 {
 	kmemleak_free(x);
-	kasan_kfree_large(x, _RET_IP_);
+	kasan_kfree_large(x);
 }
 
 static __always_inline bool slab_free_hook(struct kmem_cache *s, void *x)
@@ -1544,7 +1544,7 @@ static __always_inline bool slab_free_hook(struct kmem_cache *s, void *x)
 				     KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ASSERT);
 
 	/* KASAN might put x into memory quarantine, delaying its reuse */
-	return kasan_slab_free(s, x, _RET_IP_);
+	return kasan_slab_free(s, x);
 }
 
 static inline bool slab_free_freelist_hook(struct kmem_cache *s,
-- 
2.30.0.284.gd98b1dd5eaa7-goog

