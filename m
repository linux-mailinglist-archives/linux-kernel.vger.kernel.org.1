Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE382C164D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 21:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733297AbgKWUP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 15:15:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732960AbgKWUPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 15:15:25 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622CCC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:15:25 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id v5so6291029wrr.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=vCPSdYhuISEPMca4NzZzu0kqKTeEYaaZfMxe3jMvD/s=;
        b=A+kpGAdDHR+xLc8BXfFeZuxuuUrerctxHRGgM41gvim7A7SXBS2BpSFAPSf5z+xzcE
         w6rQ703Pf9m4i65OsXJrLu449pBNv4pXNZeOvCOD8nzLXO3r5Zsa4nVbArsdgc4QZy/D
         ClV5Ear6f0SA4Jp/VjbffFIIf1cSZ6qO6dFN5ShhIVcvVxMoMbpLjthlfMNq75mF0WYA
         T7wypdNYQEmicmFseG6C87RZXk2XsHgsH8s1aqze4J+fIljx2mYVTU6+mkwSiOWQsfQD
         BnjTUyurg1MZW73nAmP1V+AeMyico/YJMF2zluj5MlPfXPwPp4qXLmUPA3Lavcv/PFIs
         URBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vCPSdYhuISEPMca4NzZzu0kqKTeEYaaZfMxe3jMvD/s=;
        b=fpCgQtyltnU0LlWMAL0XUkXy17yR687DlF0DNNixy3v7V29GbVzyPSBfzCbssuTLkS
         okHqoXvYQtjaMMTYd5Zc2kT/F2spZRJZRFx0AnwhruhQWWr9zvgqQkF88khmY67+ESXM
         nzXMO/LgC2Jv9Qb8s37jL5zLbARWPyp/odzPUKGVN/Ql9rahGkv03TmRgRj9lmyy5aiM
         s9Z5Pud/BR5ea7QzHmeJKGvx3HZCvEjEs1DoWs4bpYS7OUax5Hhoxa4LAL73X/EDVx16
         nVsiUkoDb9kplGJHc2E8nzGh8Qj2HKIfKQorbxj6Z26uumj4zW9nx1xfS+VlEibLrnJ1
         fH5w==
X-Gm-Message-State: AOAM530bL518OHptjwqHvmfQyP/0YOpZ/s94D4VVIIAq+v7btDpVnZzA
        JKRSHwsLE/tv90COvDoXRit1gwJDANSOOf6T
X-Google-Smtp-Source: ABdhPJyImRIUxX0vdlPpQTNZOS8VnAdiwtBEG9ySXx3qFznfha0oetLY9Do8+WGjSwOiFt3ZSxe5XbJ3Qnga4at5
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a1c:c343:: with SMTP id
 t64mr639600wmf.140.1606162524075; Mon, 23 Nov 2020 12:15:24 -0800 (PST)
Date:   Mon, 23 Nov 2020 21:14:43 +0100
In-Reply-To: <cover.1606162397.git.andreyknvl@google.com>
Message-Id: <141675fb493555e984c5dca555e9d9f768c7bbaa.1606162397.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1606162397.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH mm v4 13/19] kasan, mm: rename kasan_poison_kfree
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

Rename kasan_poison_kfree() to kasan_slab_free_mempool() as it better
reflects what this annotation does. Also add a comment that explains the
PageSlab() check.

No functional changes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Marco Elver <elver@google.com>
Link: https://linux-review.googlesource.com/id/I5026f87364e556b506ef1baee725144bb04b8810
---
 include/linux/kasan.h | 16 ++++++++--------
 mm/kasan/common.c     | 40 +++++++++++++++++++++++-----------------
 mm/mempool.c          |  2 +-
 3 files changed, 32 insertions(+), 26 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index f631f99aa4b4..2610438120ce 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -175,6 +175,13 @@ static __always_inline bool kasan_slab_free(struct kmem_cache *s, void *object,
 	return false;
 }
 
+void __kasan_slab_free_mempool(void *ptr, unsigned long ip);
+static __always_inline void kasan_slab_free_mempool(void *ptr, unsigned long ip)
+{
+	if (kasan_enabled())
+		__kasan_slab_free_mempool(ptr, ip);
+}
+
 void * __must_check __kasan_slab_alloc(struct kmem_cache *s,
 				       void *object, gfp_t flags);
 static __always_inline void * __must_check kasan_slab_alloc(
@@ -215,13 +222,6 @@ static __always_inline void * __must_check kasan_krealloc(const void *object,
 	return (void *)object;
 }
 
-void __kasan_poison_kfree(void *ptr, unsigned long ip);
-static __always_inline void kasan_poison_kfree(void *ptr, unsigned long ip)
-{
-	if (kasan_enabled())
-		__kasan_poison_kfree(ptr, ip);
-}
-
 void __kasan_kfree_large(void *ptr, unsigned long ip);
 static __always_inline void kasan_kfree_large(void *ptr, unsigned long ip)
 {
@@ -260,6 +260,7 @@ static inline bool kasan_slab_free(struct kmem_cache *s, void *object,
 {
 	return false;
 }
+static inline void kasan_slab_free_mempool(void *ptr, unsigned long ip) {}
 static inline void *kasan_slab_alloc(struct kmem_cache *s, void *object,
 				   gfp_t flags)
 {
@@ -279,7 +280,6 @@ static inline void *kasan_krealloc(const void *object, size_t new_size,
 {
 	return (void *)object;
 }
-static inline void kasan_poison_kfree(void *ptr, unsigned long ip) {}
 static inline void kasan_kfree_large(void *ptr, unsigned long ip) {}
 
 #endif /* CONFIG_KASAN */
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 17918bd20ed9..1205faac90bd 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -335,6 +335,29 @@ bool __kasan_slab_free(struct kmem_cache *cache, void *object, unsigned long ip)
 	return ____kasan_slab_free(cache, object, ip, true);
 }
 
+void __kasan_slab_free_mempool(void *ptr, unsigned long ip)
+{
+	struct page *page;
+
+	page = virt_to_head_page(ptr);
+
+	/*
+	 * Even though this function is only called for kmem_cache_alloc and
+	 * kmalloc backed mempool allocations, those allocations can still be
+	 * !PageSlab() when the size provided to kmalloc is larger than
+	 * KMALLOC_MAX_SIZE, and kmalloc falls back onto page_alloc.
+	 */
+	if (unlikely(!PageSlab(page))) {
+		if (ptr != page_address(page)) {
+			kasan_report_invalid_free(ptr, ip);
+			return;
+		}
+		poison_range(ptr, page_size(page), KASAN_FREE_PAGE);
+	} else {
+		____kasan_slab_free(page->slab_cache, ptr, ip, false);
+	}
+}
+
 static void set_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags)
 {
 	kasan_set_track(&kasan_get_alloc_meta(cache, object)->alloc_track, flags);
@@ -429,23 +452,6 @@ void * __must_check __kasan_krealloc(const void *object, size_t size, gfp_t flag
 						flags, true);
 }
 
-void __kasan_poison_kfree(void *ptr, unsigned long ip)
-{
-	struct page *page;
-
-	page = virt_to_head_page(ptr);
-
-	if (unlikely(!PageSlab(page))) {
-		if (ptr != page_address(page)) {
-			kasan_report_invalid_free(ptr, ip);
-			return;
-		}
-		poison_range(ptr, page_size(page), KASAN_FREE_PAGE);
-	} else {
-		____kasan_slab_free(page->slab_cache, ptr, ip, false);
-	}
-}
-
 void __kasan_kfree_large(void *ptr, unsigned long ip)
 {
 	if (ptr != page_address(virt_to_head_page(ptr)))
diff --git a/mm/mempool.c b/mm/mempool.c
index 583a9865b181..624ed51b060f 100644
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
2.29.2.454.gaff20da3a2-goog

