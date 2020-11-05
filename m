Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1C72A7384
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 01:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387645AbgKEADK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 19:03:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387595AbgKEADJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 19:03:09 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643A4C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 16:03:09 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id h31so119154qtd.14
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 16:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=n/EgrjS/0wTVW1eC4Y9BfE2JdZzS0OcWlZnzEp1P2oA=;
        b=jrZ3nq9hvCyDk1RywcRDcNGLi6wEaMLQe6lPvnUPEYicuoOqjT3eav85cW/BXeq2ZN
         QVOCcds43Wnzx3dOnutChSfKv1NVao6weEX+bhbFjRbzNcdGAsbsHrc959Cjb8TQGLeI
         QvY7yMKKV2eGthNdRftUUMd1mqd3sADjDOTmOzxQGQtW9yKhpco958xzs3qnh9LWUpNB
         Vf5EwNZxVZ/etFX2hS0qJnRqlYILtSSHtGEPqZ+C4i+NiiIotBy3GT2UPg4dw7/VpXiT
         8bDZtmQaKFqy0pr6z+S/70zL5rJgVmIhQfN3xyX7xUwnbUIZ8XcIhY12Sfv6sAIVSOsC
         5Eyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=n/EgrjS/0wTVW1eC4Y9BfE2JdZzS0OcWlZnzEp1P2oA=;
        b=r7hnW7ZyaMeP+MDaJFoIK6n8wADn4ujFdgnZmE/z0DZrgWD34lfIL8EXPdCu4CkGV9
         Q/+Wnrkx4xQCeWpKxK1uBZKStsMUkwx09GzIFh6dq0xlqb/ziqz3SHi9Q+XMlirLkKT6
         bU6/4/SxtpfQg0fcoIfiUQhuliTnPTTuFgRqAUnsXBak5V0oEdzBZRE3e3GcVXrFeLfX
         3jaLm9r3ZMUkbdquVXF2e1Hs6vcoZkxPEaY0hcu3KPdckbFFGeSkdA26FkaR1reOqTw4
         qTug3+qZ7tvOGDRoQagdaGF0uqvL85CC2VSZDtJaxomIV4R5132TBs9vHwKSBvJWLdA6
         Z3AQ==
X-Gm-Message-State: AOAM530HRQNn0jU9ToYFImStaiimQbej//vM1L5dqpmqP5j8fCkfCdxp
        vyrGXoqatGqUUSLDB8xrLl6zAxPfsF8j9kNr
X-Google-Smtp-Source: ABdhPJzX+fSBMSD2Sr3BapYXMWINq8pPniVZsem2D0Y9Dv2YLtXgN5Ei9MAIzJTjyzHz2heVRtUdpAvUTBisVAT7
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a0c:f70f:: with SMTP id
 w15mr489369qvn.45.1604534588580; Wed, 04 Nov 2020 16:03:08 -0800 (PST)
Date:   Thu,  5 Nov 2020 01:02:24 +0100
In-Reply-To: <cover.1604534322.git.andreyknvl@google.com>
Message-Id: <82f01c35335ae293f6119531670354116fd63858.1604534322.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1604534322.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH 14/20] kasan, mm: rename kasan_poison_kfree
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
index ae1046fc74e5..d47601517dad 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -175,6 +175,13 @@ static inline bool kasan_slab_free(struct kmem_cache *s, void *object, unsigned
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
@@ -215,13 +222,6 @@ static inline void * __must_check kasan_krealloc(const void *object,
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
@@ -261,6 +261,7 @@ static inline bool kasan_slab_free(struct kmem_cache *s, void *object,
 {
 	return false;
 }
+static inline void kasan_slab_free_mempool(void *ptr, unsigned long ip) {}
 static inline void *kasan_slab_alloc(struct kmem_cache *s, void *object,
 				   gfp_t flags)
 {
@@ -280,7 +281,6 @@ static inline void *kasan_krealloc(const void *object, size_t new_size,
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
2.29.1.341.ge80a0c044ae-goog

