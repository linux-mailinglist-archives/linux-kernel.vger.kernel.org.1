Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14B9E2AE33C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 23:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732469AbgKJWVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 17:21:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732559AbgKJWVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 17:21:03 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F6EC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:21:03 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id o19so1873564wme.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=GOGJv8k49mZ7izGKRKf2lz4nE5+QAATrVFhHt9hU4vk=;
        b=nWOy4NUDHFOJEkxt4HeQuuF7ItikIUR8FEDsoSuy97fbvULA7lagn7eN3aC6vpstwF
         xnpFycGGrQwC8h/x/TXHWw0CW+G4Fjd4Slr9kUN2ThO1uqV1a17ThYYrVviz2QzvLoEO
         oWgn9eARxtVrIcMhHtbgK5vf157PytkMdr0TozM3dqyYiXD2fg1TZOmiSH2tfoQNyg/p
         JnBT4n1XAgbGk9xq5rgIyLRbUehOrg15Syn4bQ069qKNf+WaK4exp2ytMFY2Ps2HZxgG
         ZfB1I1UrMfNw1Gz86u3BfC24ZC1yd4ha4aaLaa9otfPc1GMwphpeAJEn2q3FmZCaeW05
         uz7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GOGJv8k49mZ7izGKRKf2lz4nE5+QAATrVFhHt9hU4vk=;
        b=iYPaRhQDVh44d5rzVcQxoidKbdzs3p1LIeXsIsmAZ+q5UsoALIEQFqwaiY+7I2qwKO
         UGP/waKh7EMrE5WdhiH83D+YGNpGBZDES+iRGyNMhV9yIUxegqt3kgw3uDI8lt8PrGmG
         LdznlT76+XZ6jvLEnOCxBJlCFy8j4jYivhNmSPK5HDL4W0ulyL254PJ7VttAX+p64xNn
         /uzOb8waG38geivf+LrC+Rk/bMhjUHCozeqAT45+WJBs+zoM/2zpN/sB6ptEEn87AmdB
         DTOLV9oyECm6wL5aaMa3u78XWu6vwVev9Lv9BWj1WHMOXdk6Bc5W5NbQ8IGJzQn8pnZJ
         4kuA==
X-Gm-Message-State: AOAM533R/i/spNTQv0XsZuxER+82CgENw+aTLbV/edFioc0CAR0y2QFf
        dugEAi6jadR/wT6ywk9++HF3osiASLBsoARt
X-Google-Smtp-Source: ABdhPJye7812Tl8RDG0JMOImadD+I+Ef01WcUzHZ3QitQU3NwVahUAiU8MWUn0N3DMR/yxe7K7D4GjlglR/6liPr
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a7b:cbd7:: with SMTP id
 n23mr302280wmi.142.1605046862286; Tue, 10 Nov 2020 14:21:02 -0800 (PST)
Date:   Tue, 10 Nov 2020 23:20:18 +0100
In-Reply-To: <cover.1605046662.git.andreyknvl@google.com>
Message-Id: <ee33aa1d9c57c3f2b2c700e8f2c6c24db8703612.1605046662.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605046662.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH v2 14/20] kasan, mm: rename kasan_poison_kfree
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

Rename kasan_poison_kfree() to kasan_slab_free_mempool() as it better
reflects what this annotation does.

No functional changes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Link: https://linux-review.googlesource.com/id/I5026f87364e556b506ef1baee725144bb04b8810
---
 include/linux/kasan.h | 16 ++++++++--------
 mm/kasan/common.c     | 16 ++++++++--------
 mm/mempool.c          |  2 +-
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 779f8e703982..534ab3e2935a 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -177,6 +177,13 @@ static inline bool kasan_slab_free(struct kmem_cache *s, void *object, unsigned
 	return false;
 }
 
+void __kasan_slab_free_mempool(void *ptr, unsigned long ip);
+static inline void kasan_slab_free_mempool(void *ptr, unsigned long ip)
+{
+	if (kasan_enabled())
+		__kasan_slab_free_mempool(ptr, ip);
+}
+
 void * __must_check __kasan_slab_alloc(struct kmem_cache *s,
 				       void *object, gfp_t flags);
 static inline void * __must_check kasan_slab_alloc(struct kmem_cache *s,
@@ -217,13 +224,6 @@ static inline void * __must_check kasan_krealloc(const void *object,
 	return (void *)object;
 }
 
-void __kasan_poison_kfree(void *ptr, unsigned long ip);
-static inline void kasan_poison_kfree(void *ptr, unsigned long ip)
-{
-	if (kasan_enabled())
-		__kasan_poison_kfree(ptr, ip);
-}
-
 void __kasan_kfree_large(void *ptr, unsigned long ip);
 static inline void kasan_kfree_large(void *ptr, unsigned long ip)
 {
@@ -263,6 +263,7 @@ static inline bool kasan_slab_free(struct kmem_cache *s, void *object,
 {
 	return false;
 }
+static inline void kasan_slab_free_mempool(void *ptr, unsigned long ip) {}
 static inline void *kasan_slab_alloc(struct kmem_cache *s, void *object,
 				   gfp_t flags)
 {
@@ -282,7 +283,6 @@ static inline void *kasan_krealloc(const void *object, size_t new_size,
 {
 	return (void *)object;
 }
-static inline void kasan_poison_kfree(void *ptr, unsigned long ip) {}
 static inline void kasan_kfree_large(void *ptr, unsigned long ip) {}
 
 #endif /* CONFIG_KASAN */
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 819403548f2e..60793f8695a8 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -336,6 +336,14 @@ bool __kasan_slab_free(struct kmem_cache *cache, void *object, unsigned long ip)
 	return ____kasan_slab_free(cache, object, ip, true);
 }
 
+void __kasan_slab_free_mempool(void *ptr, unsigned long ip)
+{
+	struct page *page;
+
+	page = virt_to_head_page(ptr);
+	____kasan_slab_free(page->slab_cache, ptr, ip, false);
+}
+
 static void set_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags)
 {
 	kasan_set_track(&kasan_get_alloc_meta(cache, object)->alloc_track, flags);
@@ -427,14 +435,6 @@ void * __must_check __kasan_krealloc(const void *object, size_t size, gfp_t flag
 						flags, true);
 }
 
-void __kasan_poison_kfree(void *ptr, unsigned long ip)
-{
-	struct page *page;
-
-	page = virt_to_head_page(ptr);
-	____kasan_slab_free(page->slab_cache, ptr, ip, false);
-}
-
 void __kasan_kfree_large(void *ptr, unsigned long ip)
 {
 	if (ptr != page_address(virt_to_head_page(ptr)))
diff --git a/mm/mempool.c b/mm/mempool.c
index f473cdddaff0..b1f39fa75ade 100644
--- a/mm/mempool.c
+++ b/mm/mempool.c
@@ -104,7 +104,7 @@ static inline void poison_element(mempool_t *pool, void *element)
 static __always_inline void kasan_poison_element(mempool_t *pool, void *element)
 {
 	if (pool->alloc == mempool_alloc_slab || pool->alloc == mempool_kmalloc)
-		kasan_poison_kfree(element, _RET_IP_);
+		kasan_slab_free_mempool(element, _RET_IP_);
 	else if (pool->alloc == mempool_alloc_pages)
 		kasan_free_pages(element, (unsigned long)pool->pool_data);
 }
-- 
2.29.2.222.g5d2a92d10f8-goog

