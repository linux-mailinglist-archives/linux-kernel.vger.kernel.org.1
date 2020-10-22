Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85405295FCB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 15:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899738AbgJVNUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 09:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2899692AbgJVNUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 09:20:10 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE23C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 06:20:08 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id y13so346702wmj.7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 06:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=mi7vvSs1Xj6QP3ZrLQqzK4ZcKPoucW49C95TbzYwJvE=;
        b=WMfS9dRtWZDX51w4plP16bp5piaEqQBpE3ornSYeL4364aMXjgpHqTbWKaOtT8lIOT
         v5zOz0YSe6e0XtaHoql8967nc/Ii8Xyg3lq0RkSpi0aEH27mCDY9+Sm1vddt2AcHGw+3
         M+4LeBiz3q9p/G41hOvs2+O6TYRJRlz5Z4/lK4kPB4PV1Uwo2emgWq4qSbkzvrBrPkMz
         CZRZd+EFA54+4QVaXcXhxB+1cxfOvt4wyBzRVaJBz/D+2wnhEul+MQwlP5Fgl2Sljjxs
         UVriHaxB0mWYuChQ5nj6umtVt+86dyH3deGoVsEldYIV3EuTpba9LgakwKDulbRSW3yy
         WYPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mi7vvSs1Xj6QP3ZrLQqzK4ZcKPoucW49C95TbzYwJvE=;
        b=lir+eco40x0GX+LEjxRYoGWO/T/TzmaygmknVXKPFZ8ErGgoSO3R+Nf3q/U+OGibGn
         fUGHWiOmplgRTJlkljEHJq1V3WkM8QSj03BQHX3eZVqM3A8yVKOWwbxvVf+QUnkuG7Gw
         LhsDf+mv4whQM5zlsPOQ3z0iSre9sIDMSfGKM82tidUeRdP753nWokeqgbi97wamYMrc
         XwnqtHMkD9QQRsKvWC8eObNYgsKwp6+Gad2Sd52t1mFr5BMRZQqhtV9pWv1bTOPGhWR0
         ZtTHnjM/gikroopgkBtOzEcxxlheaKfrSeHSeim7aQAhbMmW1jRloGgn1YOfEs7WNEDD
         koIA==
X-Gm-Message-State: AOAM531LbaxqhGtvOqXAuV4JaAWeCwd+C9YodmzHsGKDVIEwfKo9h4c2
        0YCMDlB2SqeMv4aXrzr+8yBcjiT/E3VrVurV
X-Google-Smtp-Source: ABdhPJyeu67ARBka23poZcAOoLY0EqwcOXOj2FFCFiEBl9x3OWHicQB9Jdn9dGK4WtpJc3PPmsLntPwXfNYvLXyq
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a1c:4b09:: with SMTP id
 y9mr2666404wma.90.1603372807440; Thu, 22 Oct 2020 06:20:07 -0700 (PDT)
Date:   Thu, 22 Oct 2020 15:19:10 +0200
In-Reply-To: <cover.1603372719.git.andreyknvl@google.com>
Message-Id: <5a6f32308101c49da5eef652437bd3da9234c0da.1603372719.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1603372719.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH RFC v2 18/21] kasan: rename kasan_poison_kfree
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

Rename kasan_poison_kfree() into kasan_slab_free_mempool() as it better
reflects what this annotation does.

No functional changes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Link: https://linux-review.googlesource.com/id/I5026f87364e556b506ef1baee725144bb04b8810
---
 include/linux/kasan.h | 16 ++++++++--------
 mm/kasan/common.c     | 16 ++++++++--------
 mm/mempool.c          |  2 +-
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 8654275aa62e..2ae92f295f76 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -162,6 +162,13 @@ static inline bool kasan_slab_free(struct kmem_cache *s, void *object, unsigned
 	return false;
 }
 
+void __kasan_slab_free_mempool(void *ptr, unsigned long ip);
+static inline void kasan_slab_free_mempool(void *ptr, unsigned long ip)
+{
+	if (static_branch_likely(&kasan_enabled))
+		__kasan_slab_free_mempool(ptr, ip);
+}
+
 void * __must_check __kasan_slab_alloc(struct kmem_cache *s,
 				       void *object, gfp_t flags);
 static inline void * __must_check kasan_slab_alloc(struct kmem_cache *s,
@@ -202,13 +209,6 @@ static inline void * __must_check kasan_krealloc(const void *object,
 	return (void *)object;
 }
 
-void __kasan_poison_kfree(void *ptr, unsigned long ip);
-static inline void kasan_poison_kfree(void *ptr, unsigned long ip)
-{
-	if (static_branch_likely(&kasan_enabled))
-		__kasan_poison_kfree(ptr, ip);
-}
-
 void __kasan_kfree_large(void *ptr, unsigned long ip);
 static inline void kasan_kfree_large(void *ptr, unsigned long ip)
 {
@@ -244,6 +244,7 @@ static inline bool kasan_slab_free(struct kmem_cache *s, void *object,
 {
 	return false;
 }
+static inline void kasan_slab_free_mempool(void *ptr, unsigned long ip) {}
 static inline void *kasan_slab_alloc(struct kmem_cache *s, void *object,
 				   gfp_t flags)
 {
@@ -264,7 +265,6 @@ static inline void *kasan_krealloc(const void *object, size_t new_size,
 {
 	return (void *)object;
 }
-static inline void kasan_poison_kfree(void *ptr, unsigned long ip) {}
 static inline void kasan_kfree_large(void *ptr, unsigned long ip) {}
 
 #endif /* CONFIG_KASAN */
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index b82dbae0c5d6..5622b0ec0907 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -334,6 +334,14 @@ bool __kasan_slab_free(struct kmem_cache *cache, void *object, unsigned long ip)
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
@@ -436,14 +444,6 @@ void * __must_check __kasan_krealloc(const void *object, size_t size, gfp_t flag
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
index 79bff63ecf27..0e8d877fbbc6 100644
--- a/mm/mempool.c
+++ b/mm/mempool.c
@@ -106,7 +106,7 @@ static inline void poison_element(mempool_t *pool, void *element)
 static __always_inline void kasan_poison_element(mempool_t *pool, void *element)
 {
 	if (pool->alloc == mempool_alloc_slab || pool->alloc == mempool_kmalloc)
-		kasan_poison_kfree(element, _RET_IP_);
+		kasan_slab_free_mempool(element, _RET_IP_);
 	if (pool->alloc == mempool_alloc_pages)
 		kasan_free_pages(element, (unsigned long)pool->pool_data);
 }
-- 
2.29.0.rc1.297.gfa9743e501-goog

