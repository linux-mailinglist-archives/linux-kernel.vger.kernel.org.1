Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF662B287D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 23:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbgKMWQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 17:16:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbgKMWQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 17:16:26 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE3BC0617A6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:16:24 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id x20so6627878qts.19
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=dmp1Ztz+z0/5ouydww+9T91eTtvP6ouU0pc5TkOOGLA=;
        b=Sdo5xec8tSPhCBD9HVH8oNcti7JVTWAnBqJi7WPO+NIzZ54aQM4HnIl9inItDYW9TC
         bWQnh825FCOq1JbkMy+NkSB4AVLMhpX+g+PXDkRZZ01lqZNcunr+cbO8MIgc2XMnG6A9
         hEZlaG6pJji1w1WY/Ro6jjOdZQQ13+E9oFooGxh/LYDljzPaLqWwSpP+ZsA4LPogN+L9
         9ZvpH284+FMQnyYPcBtAWhfxNcqHVS5+NOUJZmA4cZ6JhgrMxptwag1+wTZFpw1+8SzL
         DI+yQIpxec4CGc1SDFD1mc9aujwDnpZrPQo8usyFzbapOYdcVAyX+SjUK3jUILKi5ywY
         Fgdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dmp1Ztz+z0/5ouydww+9T91eTtvP6ouU0pc5TkOOGLA=;
        b=XxiMvZwFT2xasDfJP+FEyBrM5nKZv/QQC9k8EMXDp/9YTjI9cb1TG7mqfce6bM3nD/
         yreqtCpRgxk2Y+PoiRgAiEMpSXFwA7UZl/CgC3SNxQcCwWXSpgpBZ/V+f6Jpe/00La+n
         UCr5w2pSGSs5ZVg5UJQ9FFaGdXXFf6QH7hCmCuXzaaZ+/XENLuvid3ORKFBdXOM3EXYc
         aQvgvvze0yuDs5FSH64jemPkKvMnWDIPAhBMa6cpSpOfXVlx33xtJ2L1n3xJY8D7RjFI
         Fe7HMIPd4tDaQQ0qZDfpgSUzA618gXpU0r0mcqsgQy3hb6iBHVcXxAAJBb22Bqrk8b3G
         W0Ig==
X-Gm-Message-State: AOAM532BYDLR4tyDgzlIMBQYxe8JDcyL//bZMpxHPoXr+5CzYar6gQcx
        B+RwMZ/RFri97KG3Fm/mRxtjYrvdmHQis7/j
X-Google-Smtp-Source: ABdhPJzEbY0rG6ltfJUnnmISccnN45yIP/Gez6V2X6kPmpzEcbfHuqVMAkyZ1+7W2inavCFGTR8CMeGZVtrYJfDm
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:ad4:5387:: with SMTP id
 i7mr4558075qvv.43.1605305783806; Fri, 13 Nov 2020 14:16:23 -0800 (PST)
Date:   Fri, 13 Nov 2020 23:15:32 +0100
In-Reply-To: <cover.1605305705.git.andreyknvl@google.com>
Message-Id: <df8daed599225910d82a752b8717b70911816772.1605305705.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605305705.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH mm v10 04/42] kasan: shadow declarations only for software modes
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

This is a preparatory commit for the upcoming addition of a new hardware
tag-based (MTE-based) KASAN mode.

Group shadow-related KASAN function declarations and only define them
for the two existing software modes.

No functional changes for software modes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Marco Elver <elver@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
---
Change-Id: I864be75a88b91b443c55e9c2042865e15703e164
---
 include/linux/kasan.h | 47 ++++++++++++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 16 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 59538e795df4..26f2ab92e7ca 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -11,7 +11,6 @@ struct task_struct;
 
 #ifdef CONFIG_KASAN
 
-#include <linux/pgtable.h>
 #include <asm/kasan.h>
 
 /* kasan_data struct is used in KUnit tests for KASAN expected failures */
@@ -20,6 +19,20 @@ struct kunit_kasan_expectation {
 	bool report_found;
 };
 
+#endif
+
+#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
+
+#include <linux/pgtable.h>
+
+/* Software KASAN implementations use shadow memory. */
+
+#ifdef CONFIG_KASAN_SW_TAGS
+#define KASAN_SHADOW_INIT 0xFF
+#else
+#define KASAN_SHADOW_INIT 0
+#endif
+
 extern unsigned char kasan_early_shadow_page[PAGE_SIZE];
 extern pte_t kasan_early_shadow_pte[PTRS_PER_PTE];
 extern pmd_t kasan_early_shadow_pmd[PTRS_PER_PMD];
@@ -35,6 +48,23 @@ static inline void *kasan_mem_to_shadow(const void *addr)
 		+ KASAN_SHADOW_OFFSET;
 }
 
+int kasan_add_zero_shadow(void *start, unsigned long size);
+void kasan_remove_zero_shadow(void *start, unsigned long size);
+
+#else /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
+
+static inline int kasan_add_zero_shadow(void *start, unsigned long size)
+{
+	return 0;
+}
+static inline void kasan_remove_zero_shadow(void *start,
+					unsigned long size)
+{}
+
+#endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
+
+#ifdef CONFIG_KASAN
+
 /* Enable reporting bugs after kasan_disable_current() */
 extern void kasan_enable_current(void);
 
@@ -75,9 +105,6 @@ struct kasan_cache {
 	int free_meta_offset;
 };
 
-int kasan_add_zero_shadow(void *start, unsigned long size);
-void kasan_remove_zero_shadow(void *start, unsigned long size);
-
 size_t __ksize(const void *);
 static inline void kasan_unpoison_slab(const void *ptr)
 {
@@ -143,14 +170,6 @@ static inline bool kasan_slab_free(struct kmem_cache *s, void *object,
 	return false;
 }
 
-static inline int kasan_add_zero_shadow(void *start, unsigned long size)
-{
-	return 0;
-}
-static inline void kasan_remove_zero_shadow(void *start,
-					unsigned long size)
-{}
-
 static inline void kasan_unpoison_slab(const void *ptr) { }
 static inline size_t kasan_metadata_size(struct kmem_cache *cache) { return 0; }
 
@@ -158,8 +177,6 @@ static inline size_t kasan_metadata_size(struct kmem_cache *cache) { return 0; }
 
 #ifdef CONFIG_KASAN_GENERIC
 
-#define KASAN_SHADOW_INIT 0
-
 void kasan_cache_shrink(struct kmem_cache *cache);
 void kasan_cache_shutdown(struct kmem_cache *cache);
 void kasan_record_aux_stack(void *ptr);
@@ -174,8 +191,6 @@ static inline void kasan_record_aux_stack(void *ptr) {}
 
 #ifdef CONFIG_KASAN_SW_TAGS
 
-#define KASAN_SHADOW_INIT 0xFF
-
 void kasan_init_tags(void);
 
 void *kasan_reset_tag(const void *addr);
-- 
2.29.2.299.gdc1121823c-goog

