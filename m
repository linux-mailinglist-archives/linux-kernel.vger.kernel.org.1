Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 876602B2869
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 23:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgKMWVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 17:21:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgKMWUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 17:20:48 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7166C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:20:47 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id v5so4697405wrr.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=2KLolIFhijPlCk9+fyMngQmrLJRsQkhazwFij5lYkks=;
        b=nHk4m8fIajcoKGXz71w/hOkG9Y8KPvxJ7kjUbdB8Qx75uQSuFt3tsDdSskBaqLDy1a
         oravc38rEEZcIkj06gvuom8/BTOPLhVY7Yh79j3zqDW1HQjH0BOFyOQUXvbccD9KVYcH
         E9+lSheC8kZevYjyBKHr1mP1dhMe3hw7Vy3ZOZ0unCthrJ1LSBHMy6Gu9mILjaI18/NW
         +lqQsVM64auomxIjP4GHr2oOFFke0Ts0MapRV41avkeB4U556K8w6Sui1SoEScQQoX2C
         lrWwtc+y3P6hHtcbfuhnuDSF2VSzK4LoUQ0Bi7YTPLklh+QsWM8vrzrHXkPNSesgs8zf
         pXjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2KLolIFhijPlCk9+fyMngQmrLJRsQkhazwFij5lYkks=;
        b=BryP5SdiE+ixT8sOMBNrcybBnAQQUBSMrh6Wjnv7PgDm2X1vzdMzzmDAZXm1G0/svi
         RolRhfP46THydtXe9DnfOWKA/xVOCXgORNtDUfuD3OWL+giRXe8Vrc9mBMBOhQNXf2L8
         GXjnfvT4K+h0B7deq2WaEifWGrTccbcAui0ONyKWboz3Y0Lo9p+tBSyPRq3p81stzRke
         TYAWEgnC5YmCNWOsNYHXUZwoiI9VtUwhhvYT5GYlDFqTGy7T0rMp7XnD8pO4O+C5XHZI
         7HLWNokdNNrnyPoONGnzWQTxsqesFrA3ejfGra5YVkf4hQVmVS7+4wWbQNRiGVULhXFa
         +y9w==
X-Gm-Message-State: AOAM533YtjgUyrduMtPmTHdl5N12/RWrc19VhzrvszOMsNvZ5jWCA+o7
        EEjyctMO3/UuMfQezikjbYLce8yyk3P5AcPR
X-Google-Smtp-Source: ABdhPJz+I+zljHSUOpMnhH3ZRq1yNmGQYurOlqmTjFRBj2bTeKOonLpwQijlOqwdQRHlDe2A37Q45dEdqT2C+Ulk
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a1c:3d6:: with SMTP id
 205mr4665784wmd.85.1605306046610; Fri, 13 Nov 2020 14:20:46 -0800 (PST)
Date:   Fri, 13 Nov 2020 23:20:03 +0100
In-Reply-To: <cover.1605305978.git.andreyknvl@google.com>
Message-Id: <798e1753fafb37151213a0ad0b1b2f08f66c3877.1605305978.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605305978.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH mm v3 13/19] kasan, mm: rename kasan_poison_kfree
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
Link: https://linux-review.googlesource.com/id/I5026f87364e556b506ef1baee725144bb04b8810
---
 include/linux/kasan.h | 16 ++++++++--------
 mm/kasan/common.c     | 40 +++++++++++++++++++++++-----------------
 mm/mempool.c          |  2 +-
 3 files changed, 32 insertions(+), 26 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 6bd95243a583..16cf53eac29b 100644
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
2.29.2.299.gdc1121823c-goog

