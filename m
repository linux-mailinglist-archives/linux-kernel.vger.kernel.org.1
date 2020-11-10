Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D85742AE343
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 23:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732851AbgKJWVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 17:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732759AbgKJWVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 17:21:18 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E294AC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:21:16 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id 67so6236671wra.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=NSEnP5/Ymw2+CzfuUjUL3yzFjWGlVw3jfopzq6nBhYw=;
        b=MvPjJraTvvciMCrmEVBHJf7JZffHC8y5WsKXsz7dKaBKOd+ahVD8jotAMioOOY+Zy8
         +oIjs5zBxjMN13SJYSVufJUR8ZSJRp8wcFRg6ysEbVOpnOQ5vU6igGKyRCAtUMHR205f
         7QyvhDr6wwOcsOkI4zxzz6jcwQtJl0AqqctzgvATGiNPeP/sVqQ+6ox1fbYOYABAYPvk
         7DaxX13UIIfsr9P6vPscgt+nvmJbOlQRSXO/sZhZ6Ht3GxlE3kgYYtamuzZF9LJ/Pvpz
         BQVuFuMfR8gf1A4I0Rij0OHDKjK8tIBD4Mhw3LvAXhWqwcwJRbF96SPZigccwisHP0Br
         nfyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NSEnP5/Ymw2+CzfuUjUL3yzFjWGlVw3jfopzq6nBhYw=;
        b=EF+F6AyS2iCQf1krjHMgWMabUcR/WUgVAJewJjNVUUaeGHFCNx0omXPefIBGzKaPUH
         kcT+rh8X9sONIcvXOqW/khyZAQ1LxGczjtz7u7EVyZj82TwYM8vdgrCvbfax3ahbTl7I
         H7HT6hdMXcgJofoutHriUyMoYKYK+MIVnWJBK35cItXW/PzQP0mBhYFyqWX4y9afg3pn
         2vb0jTFEiVrqE1WvikslDrAHZ97jUsZLbpW79FDVMSjIGh5I4uxGfMnAdz6TlAQlHG1S
         5YuqgWL/V7j861khmIhu5SecyWGjjjSQcHv0BqBoB2WUmuitveUsavwwTIodVMSl1zrR
         qGYA==
X-Gm-Message-State: AOAM533F854B05vM41+dpKZBTlhq5Saig6TMxj7vRoPjrAu1kEBWiKgV
        YXbO7UMEBv5rl9AtIjdoUjsJHqbIpbZJVo1T
X-Google-Smtp-Source: ABdhPJx5R9Lwi7vyMEdhZoBWGFA+5/tY8OWnRDBKQTuXeI+HTirxH7sptEemR57Y7sCa/FhiaUQSY6Jezq4w1pp+
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a7b:c772:: with SMTP id
 x18mr262720wmk.185.1605046875625; Tue, 10 Nov 2020 14:21:15 -0800 (PST)
Date:   Tue, 10 Nov 2020 23:20:23 +0100
In-Reply-To: <cover.1605046662.git.andreyknvl@google.com>
Message-Id: <936c0c198145b663e031527c49a6895bd21ac3a0.1605046662.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605046662.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH v2 19/20] kasan, mm: allow cache merging with no metadata
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
index 534ab3e2935a..c754eca356f7 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -81,17 +81,35 @@ struct kasan_cache {
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
@@ -240,6 +258,10 @@ static inline kasan_enabled(void)
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
2.29.2.222.g5d2a92d10f8-goog

