Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8902C1652
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 21:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387524AbgKWUPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 15:15:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387443AbgKWUPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 15:15:37 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361BEC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:15:37 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id w189so15479982qkd.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=jlSh18JA+tyc0YTMYNGOzncWOn17Ui2VWegewVhQQAI=;
        b=Va6STH1aX4wYunU0iMuz4BvFHnwWptWCMWXmt/xofeqd3owQuGpwtvjYit4rl6mlW2
         hhm5iDeTzV3r8r1qtqi5fdwTQs/TSfD/bCoDouUVq/mqil3HrggfywpVxpheL6ZEWpIl
         zDXMe40hvq88yS3PuIjxsWaxgjZyKl/B05KVNcChbJkk49tAW2TDEREdWyEig5SkLtvs
         5K5C3H1Yizp2NapbQ8UOeKQZdiMwc5N0OfbB8Dc3yzVaEvt/fAhl005CJycepaLAgkY1
         zyVIgqpv8eZepV66RBshT0P3UBs6jkxe5tAKTYnNSfeugX8uOp+AF7kVSkrFVfKZ4WBw
         kmbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jlSh18JA+tyc0YTMYNGOzncWOn17Ui2VWegewVhQQAI=;
        b=fH2EkJTeqe0FFMh6YSEs3+3qsA4auyMabgHscRAkRqaoTlIc7zHA+TUzuc0TvSwKTY
         wvBBWkK4+noAC0y8FA+y66ZCwZteY1/a954/tqFhkZvKnTbDVCSreA14hFiJC3zjhqA5
         MEPTT7l5JWqus9UncAqdSwEJLxdkEeYosrZjmlhYoZqCPkpq3tK74iFcu5O4PEVMgKWG
         CGr9xUZwdcVqkzsOStLevv1J9Ty1pUbf5HsIYpNSNYri66M5F7SuVr9nj49AnxAan03f
         a3qtqkYkU8fur8rgiyIS4fK3vwNHhnfS1d1ePLje6OZQf3TEpvOJU7GoRohLGi/UJfCh
         Vi4Q==
X-Gm-Message-State: AOAM532l6aBgHjMko36yMhWYLxnKMKd2UcgSHCSmFGKI6VxBXfJWFeoU
        BHQRnrolZMJlX8HRKcDOielLtC3ZbVXDF6q4
X-Google-Smtp-Source: ABdhPJxiz/yK/mWtOWOXNmT0lUD67I1dkQtTBgb4Q9Y4cmrtA6Kl6akYtyMC6LEbXAx67mmzam5gwyx0dWQN53nE
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a0c:804a:: with SMTP id
 68mr1172222qva.1.1606162536399; Mon, 23 Nov 2020 12:15:36 -0800 (PST)
Date:   Mon, 23 Nov 2020 21:14:48 +0100
In-Reply-To: <cover.1606162397.git.andreyknvl@google.com>
Message-Id: <37497e940bfd4b32c0a93a702a9ae4cf061d5392.1606162397.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1606162397.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH mm v4 18/19] kasan, mm: allow cache merging with no metadata
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
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Reviewed-by: Marco Elver <elver@google.com>
Link: https://linux-review.googlesource.com/id/Ia114847dfb2244f297d2cb82d592bf6a07455dba
---
 include/linux/kasan.h | 21 +++++++++++++++++++--
 mm/kasan/common.c     | 11 +++++++++++
 mm/slab_common.c      |  3 ++-
 3 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 2610438120ce..83860aa4e89c 100644
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
index 249ccba1ecf5..da79f340f3a6 100644
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
2.29.2.454.gaff20da3a2-goog

