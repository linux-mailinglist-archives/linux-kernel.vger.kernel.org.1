Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 738AD2B286D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 23:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgKMWVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 17:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbgKMWU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 17:20:59 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B044C0617A6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:20:59 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id x2so7552893qkd.23
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=VblPcwxF/Hme6lihpSqzEG9568rY0eTc9RDR6WgTVWw=;
        b=Wogiwfd7B8TITgy/dJX2SuNVBCGj1sMmA/wWfqUVUW625r77eKdpvQaDaSu3aBij18
         zEhjdHmrCW/gZ7A+s95KqIfE8DNCf76WA+Nww0tJUkPRyTX4kRL6suTfbHi2qlyVafam
         rV+hV43GvnYUfMMgdDZbuxRdthx5R+R5/Y2EHztggMs7SRvCIai8cg3H8bvmqhAi17Nt
         36le6MqSx5RpWtq05dKx2kbxkwESQg8uMTwlplCYYGRgGySvTwMQEijRKAHcWAwock2d
         3rNzJuPXD5wPMUIWUOa1SBHN9tz+5KvOK3ae7A6N6hVkTe9bRJuMUVjKXK9evatpgUtX
         DvbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VblPcwxF/Hme6lihpSqzEG9568rY0eTc9RDR6WgTVWw=;
        b=fIQIgelveruxrWBJ/FSBsB+G61Qqf8HqNmYoaQQd+IRVP93RPbpWXjJL1OAFXwL6+O
         cXLK+iOpknX1qCuaxI8owBSiybChR2KwqRZupJIu3lEYrRICh5GxhZg7VbChGe8RxzYp
         lGiA2awHoxEpRh95n7Wf8BQNotM7/rJCXfWLvVtpKlnt8z9uwfvNxRykrsq7VfyijjRm
         qLWWUXvEAiQdYD8yFTIw7pJC/3AyZhl6NyXTmn2G0JQNc+jzrXHt0MPOCCNce5c3Lhha
         K13/vRnmH+18dCge7Wmn6Hf1Hi28A4REeoBRXIOebFXd8/AYG0i/rZXH38pJo/sppkJm
         8W4w==
X-Gm-Message-State: AOAM5311BGVyb4QPJ1yGQAj09EStuXbGp+/A+i9814KXhqgvG8R5wK5A
        RWvxJsfce4gKqbXo8/YBywBxyaWhNM52KEPv
X-Google-Smtp-Source: ABdhPJxPL1Ew5OnNzRmKgE563d6wfxOAtulSj3z/jp9Yh8hehdEomONqkappFCtKfgmpNirQUmmu+Nt5HUJLowo+
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a0c:9e53:: with SMTP id
 z19mr4596536qve.23.1605306058182; Fri, 13 Nov 2020 14:20:58 -0800 (PST)
Date:   Fri, 13 Nov 2020 23:20:08 +0100
In-Reply-To: <cover.1605305978.git.andreyknvl@google.com>
Message-Id: <6f0a1e72783ddac000ac08e7315b1d7c0ca4ec51.1605305978.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605305978.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH mm v3 18/19] kasan, mm: allow cache merging with no metadata
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
        Andrey Konovalov <andreyknvl@google.com>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>
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

Co-developed-by: Vincenzo Frascino <Vincenzo.Frascino@arm.com>
Signed-off-by: Vincenzo Frascino <Vincenzo.Frascino@arm.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Link: https://linux-review.googlesource.com/id/Ia114847dfb2244f297d2cb82d592bf6a07455dba
---
 include/linux/kasan.h | 21 +++++++++++++++++++--
 mm/kasan/common.c     | 11 +++++++++++
 mm/slab_common.c      |  3 ++-
 3 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 16cf53eac29b..173a8e81d001 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -81,17 +81,30 @@ struct kasan_cache {
 };
 
 #ifdef CONFIG_KASAN_HW_TAGS
+
 DECLARE_STATIC_KEY_FALSE(kasan_flag_enabled);
+
 static __always_inline bool kasan_enabled(void)
 {
 	return static_branch_likely(&kasan_flag_enabled);
 }
-#else
+
+#else /* CONFIG_KASAN_HW_TAGS */
+
 static inline bool kasan_enabled(void)
 {
 	return true;
 }
-#endif
+
+#endif /* CONFIG_KASAN_HW_TAGS */
+
+slab_flags_t __kasan_never_merge(void);
+static __always_inline slab_flags_t kasan_never_merge(void)
+{
+	if (kasan_enabled())
+		return __kasan_never_merge();
+	return 0;
+}
 
 void __kasan_unpoison_range(const void *addr, size_t size);
 static __always_inline void kasan_unpoison_range(const void *addr, size_t size)
@@ -238,6 +251,10 @@ static inline bool kasan_enabled(void)
 {
 	return false;
 }
+static inline slab_flags_t kasan_never_merge(void)
+{
+	return 0;
+}
 static inline void kasan_unpoison_range(const void *address, size_t size) {}
 static inline void kasan_alloc_pages(struct page *page, unsigned int order) {}
 static inline void kasan_free_pages(struct page *page, unsigned int order) {}
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index cf874243efab..a5a4dcb1254d 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -87,6 +87,17 @@ asmlinkage void kasan_unpoison_task_stack_below(const void *watermark)
 }
 #endif /* CONFIG_KASAN_STACK */
 
+/*
+ * Only allow cache merging when stack collection is disabled and no metadata
+ * is present.
+ */
+slab_flags_t __kasan_never_merge(void)
+{
+	if (kasan_stack_collection_enabled())
+		return SLAB_KASAN;
+	return 0;
+}
+
 void __kasan_alloc_pages(struct page *page, unsigned int order)
 {
 	u8 tag;
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 0b5ae1819a8b..075b23ce94ec 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -19,6 +19,7 @@
 #include <linux/seq_file.h>
 #include <linux/proc_fs.h>
 #include <linux/debugfs.h>
+#include <linux/kasan.h>
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 #include <asm/page.h>
@@ -54,7 +55,7 @@ static DECLARE_WORK(slab_caches_to_rcu_destroy_work,
  */
 #define SLAB_NEVER_MERGE (SLAB_RED_ZONE | SLAB_POISON | SLAB_STORE_USER | \
 		SLAB_TRACE | SLAB_TYPESAFE_BY_RCU | SLAB_NOLEAKTRACE | \
-		SLAB_FAILSLAB | SLAB_KASAN)
+		SLAB_FAILSLAB | kasan_never_merge())
 
 #define SLAB_MERGE_SAME (SLAB_RECLAIM_ACCOUNT | SLAB_CACHE_DMA | \
 			 SLAB_CACHE_DMA32 | SLAB_ACCOUNT)
-- 
2.29.2.299.gdc1121823c-goog

