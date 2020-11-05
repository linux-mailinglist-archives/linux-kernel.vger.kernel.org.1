Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B60E12A738B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 01:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387790AbgKEAD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 19:03:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387774AbgKEADY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 19:03:24 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C00AC0613D2
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 16:03:23 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id h8so97237wrt.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 16:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=BKsLmNNgmZaUnh/EpgjKJBz6eZxr51wf9zKFrfwsdMY=;
        b=qJE0zOp+CKttdyhR8H016jLOb78DZeJauMV8UV6YZ6W6V0nNZuzfcr66fKWF+xyu0j
         Hu93tQ9+h2euPfBrbAxeuBkQNmB8XDwFPIUVJgoex7AOSAWddfvqlgdW3pAWZhXwKd6X
         b+4Ap2alZM5FYcGzH2cFewAp6b7/bUbZIK3yBJc2oRUFxZfbXaPfwTPIUBN3UXPtMd8B
         0s2vwIlVrgjH1M0Fqhf9QXQfXantgORoY4k0jb4EKhOV+mnANLXMQSac5m11GpbObnx4
         yfQ1qeP54OrJQ6bj36qKUqzswK3NjKcjADRI71Uarnr5Yd65cdFHT2Dm5JIJEZXHacUn
         FVew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BKsLmNNgmZaUnh/EpgjKJBz6eZxr51wf9zKFrfwsdMY=;
        b=kiv9iPxyUHBh+WPZ9AIiUtpCSzAMhhenpEsxsTMnxgrolh5vy4665I/HNGapK8VUer
         31T750XGosoS97zAJqsSQbDr+MkC4opTo5eZh36xm6LQaxDGqQVE8I93UmMFAWGKUvrJ
         ZU4nO085BGmpnzatxk2vs/rzLutXj7t6fpfsFnDxTGBM2HpLS8tJ+oPqqi5/vIj02LWR
         xR01s/PRY6690n6IIqlY7nV3Ik6TwOOUDLwqadH2IBOKaQrv4fxn28saZZFiSw9j1hZs
         vccXJ0DmIWBZ0bzA2Qr4BpBezFj8/ZkFQICpF2J71tsNcYhclOcJbUgJTtV00X3x8sdF
         JoBA==
X-Gm-Message-State: AOAM533/JpGbrmu2hwQdj7ONvFhdYp7Xlc7Bt0c0ovG6zFv3tAp3Ej7k
        SmIvfyekoew1tha8ee3e674G4V8CmfnpSqTe
X-Google-Smtp-Source: ABdhPJwrvNjDqk1pGCj7inLtCzHsZII7Iw+NeQV+f26/W8zfFQBJG75O6f9HjOB9QVSFdbKpg6sk4TSVpyEf1Ad2
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a1c:6302:: with SMTP id
 x2mr196504wmb.121.1604534601835; Wed, 04 Nov 2020 16:03:21 -0800 (PST)
Date:   Thu,  5 Nov 2020 01:02:29 +0100
In-Reply-To: <cover.1604534322.git.andreyknvl@google.com>
Message-Id: <17ecf27ee7b275869047bef91558bd263dd243f1.1604534322.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1604534322.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH 19/20] kasan, mm: allow cache merging with no metadata
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

The reason cache merging is disabled with KASAN is because KASAN puts its
metadata right after the allocated object. When the merged caches have
slightly different sizes, the metadata ends up in different places, which
KASAN doesn't support.

It might be possible to adjust the metadata allocation algorithm and make
it friendly to the cache merging code. Instead this change takes a simpler
approach and allows merging caches when no metadata is present. Which is
the case for hardware tag-based KASAN with kasan.mode=prod.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Link: https://linux-review.googlesource.com/id/Ia114847dfb2244f297d2cb82d592bf6a07455dba
---
 include/linux/kasan.h | 26 ++++++++++++++++++++++++--
 mm/kasan/common.c     | 11 +++++++++++
 mm/slab_common.c      | 11 ++++++++---
 3 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index d47601517dad..fb8ba4719e3b 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -79,17 +79,35 @@ struct kasan_cache {
 };
 
 #ifdef CONFIG_KASAN_HW_TAGS
+
 DECLARE_STATIC_KEY_FALSE(kasan_flag_enabled);
+
 static inline kasan_enabled(void)
 {
 	return static_branch_likely(&kasan_flag_enabled);
 }
-#else
+
+slab_flags_t __kasan_never_merge(slab_flags_t flags);
+static inline slab_flags_t kasan_never_merge(slab_flags_t flags)
+{
+	if (kasan_enabled())
+		return __kasan_never_merge(flags);
+	return flags;
+}
+
+#else /* CONFIG_KASAN_HW_TAGS */
+
 static inline kasan_enabled(void)
 {
 	return true;
 }
-#endif
+
+static inline slab_flags_t kasan_never_merge(slab_flags_t flags)
+{
+	return flags;
+}
+
+#endif /* CONFIG_KASAN_HW_TAGS */
 
 void __kasan_alloc_pages(struct page *page, unsigned int order);
 static inline void kasan_alloc_pages(struct page *page, unsigned int order)
@@ -238,6 +256,10 @@ static inline kasan_enabled(void)
 {
 	return false;
 }
+static inline slab_flags_t kasan_never_merge(slab_flags_t flags)
+{
+	return flags;
+}
 static inline void kasan_alloc_pages(struct page *page, unsigned int order) {}
 static inline void kasan_free_pages(struct page *page, unsigned int order) {}
 static inline void kasan_cache_create(struct kmem_cache *cache,
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 940b42231069..25b18c145b06 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -81,6 +81,17 @@ asmlinkage void kasan_unpoison_task_stack_below(const void *watermark)
 }
 #endif /* CONFIG_KASAN_STACK */
 
+/*
+ * Only allow cache merging when stack collection is disabled and no metadata
+ * is present.
+ */
+slab_flags_t __kasan_never_merge(slab_flags_t flags)
+{
+	if (kasan_stack_collection_enabled())
+		return flags;
+	return flags & ~SLAB_KASAN;
+}
+
 void __kasan_alloc_pages(struct page *page, unsigned int order)
 {
 	u8 tag;
diff --git a/mm/slab_common.c b/mm/slab_common.c
index f1b0c4a22f08..3042ee8ea9ce 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -18,6 +18,7 @@
 #include <linux/seq_file.h>
 #include <linux/proc_fs.h>
 #include <linux/debugfs.h>
+#include <linux/kasan.h>
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 #include <asm/page.h>
@@ -49,12 +50,16 @@ static DECLARE_WORK(slab_caches_to_rcu_destroy_work,
 		    slab_caches_to_rcu_destroy_workfn);
 
 /*
- * Set of flags that will prevent slab merging
+ * Set of flags that will prevent slab merging.
+ * Use slab_never_merge() instead.
  */
 #define SLAB_NEVER_MERGE (SLAB_RED_ZONE | SLAB_POISON | SLAB_STORE_USER | \
 		SLAB_TRACE | SLAB_TYPESAFE_BY_RCU | SLAB_NOLEAKTRACE | \
 		SLAB_FAILSLAB | SLAB_KASAN)
 
+/* KASAN allows merging in some configurations and will remove SLAB_KASAN. */
+#define slab_never_merge() (kasan_never_merge(SLAB_NEVER_MERGE))
+
 #define SLAB_MERGE_SAME (SLAB_RECLAIM_ACCOUNT | SLAB_CACHE_DMA | \
 			 SLAB_CACHE_DMA32 | SLAB_ACCOUNT)
 
@@ -164,7 +169,7 @@ static unsigned int calculate_alignment(slab_flags_t flags,
  */
 int slab_unmergeable(struct kmem_cache *s)
 {
-	if (slab_nomerge || (s->flags & SLAB_NEVER_MERGE))
+	if (slab_nomerge || (s->flags & slab_never_merge()))
 		return 1;
 
 	if (s->ctor)
@@ -198,7 +203,7 @@ struct kmem_cache *find_mergeable(unsigned int size, unsigned int align,
 	size = ALIGN(size, align);
 	flags = kmem_cache_flags(size, flags, name, NULL);
 
-	if (flags & SLAB_NEVER_MERGE)
+	if (flags & slab_never_merge())
 		return NULL;
 
 	list_for_each_entry_reverse(s, &slab_caches, list) {
-- 
2.29.1.341.ge80a0c044ae-goog

