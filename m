Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCDD26AF73
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 23:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgIOVVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 17:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728053AbgIOVQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 17:16:33 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22DF8C06178B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 14:16:31 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id b18so4025475qto.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 14:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=CRuZK+9yjNiKO3/D2O90q00ovcGW/0GaRtF/oaFCa6M=;
        b=hMw9RQ1dm2tX2wxDoS+iGFKc6VjnZ0XSq5Et2xcn9Si1ATKtqSzmGft3iR27ujVutM
         6Pmv9Ouek8j/oMRKz9BmvZ7pHOYOe6Lqj7XAOJ+IVmxsC1pGbjA11jnsHJo+2P3BeD7U
         ssDvbd51P7yEcYy2VrkEPQOC1NGoueMpaJQ5NMWy/P26Q+4Eur2f8WwuoSAjAISHRjgs
         4RFp88PAKRndNiG30G5JrdImqqcM8yXxseTQ3P3rk5mKHk51srzaCdnLOHyzHH11eFdB
         Z56rbIIDpE49gN6dYAIcfwB4B6ezKY9w/+af2eDNmCwV76JcqLbQzvBbSbEiYiI9oDjM
         YJVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CRuZK+9yjNiKO3/D2O90q00ovcGW/0GaRtF/oaFCa6M=;
        b=DepTy027Ov3xZ1St4u5RMepmAy/jUynl4wihjKimX9O5BikuGP16qQnLyPPTO65Cit
         UVVDWvz/AHeLU9HbznzshqXhlzyWvGeYQ37s4ky69n8GvM1ZCWkCC1cNNZVvDcrcJmxR
         2prir+1Mf3BiPwFkKMviHLqzod2Sdy9PNIwtlaOr6LeIULx8lJHH4qVyL6LZVhgNUzSR
         P/Gh9KstOgYqZnlXinci5dxasvcL+t92mTSQxnL7ywPdaLcB0Cv1yoEhBBoAosaFzoCS
         ZWyzeLk6iNq8hDtJnwG5qFgq1x63MLMZm+BuUD0TSbgEF/cBhFcTdVcGJPdMQnSamKdG
         ecjw==
X-Gm-Message-State: AOAM532mbPlCeyQL1KNzH6RVSnV6fRqQa1Bv/eKD4/Pz8R1J5qSJIzJ5
        gEmf2/bM/U0vA02DnHwMqEYZBBMDxpSzpQzv
X-Google-Smtp-Source: ABdhPJyN5unj5rLtoXzfox4mXS2M3S/SaZl+8R1nGGjQ6/HS4oOUtG9N8+ab9YhNGQBGWUztUka8v9nB9tQGSTvy
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:ad4:4527:: with SMTP id
 l7mr20524343qvu.2.1600204589991; Tue, 15 Sep 2020 14:16:29 -0700 (PDT)
Date:   Tue, 15 Sep 2020 23:15:45 +0200
In-Reply-To: <cover.1600204505.git.andreyknvl@google.com>
Message-Id: <6ad13f9f94e1a2f84f603e0e374582b89a44a75e.1600204505.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1600204505.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [PATCH v2 03/37] kasan: shadow declarations only for software modes
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kasan-dev@googlegroups.com
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
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
---
Change-Id: I864be75a88b91b443c55e9c2042865e15703e164
---
 include/linux/kasan.h | 44 ++++++++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index bd5b4965a269..44a9aae44138 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -3,16 +3,24 @@
 #define _LINUX_KASAN_H
 
 #include <linux/types.h>
+#include <asm/kasan.h>
 
 struct kmem_cache;
 struct page;
 struct vm_struct;
 struct task_struct;
 
-#ifdef CONFIG_KASAN
+#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 
 #include <linux/pgtable.h>
-#include <asm/kasan.h>
+
+/* Software KASAN implementations use shadow memory. */
+
+#ifdef CONFIG_KASAN_SW_TAGS
+#define KASAN_SHADOW_INIT 0xFF
+#else
+#define KASAN_SHADOW_INIT 0
+#endif
 
 extern unsigned char kasan_early_shadow_page[PAGE_SIZE];
 extern pte_t kasan_early_shadow_pte[PTRS_PER_PTE];
@@ -29,6 +37,23 @@ static inline void *kasan_mem_to_shadow(const void *addr)
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
 
@@ -69,9 +94,6 @@ struct kasan_cache {
 	int free_meta_offset;
 };
 
-int kasan_add_zero_shadow(void *start, unsigned long size);
-void kasan_remove_zero_shadow(void *start, unsigned long size);
-
 size_t __ksize(const void *);
 static inline void kasan_unpoison_slab(const void *ptr)
 {
@@ -137,14 +159,6 @@ static inline bool kasan_slab_free(struct kmem_cache *s, void *object,
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
 
@@ -152,8 +166,6 @@ static inline size_t kasan_metadata_size(struct kmem_cache *cache) { return 0; }
 
 #ifdef CONFIG_KASAN_GENERIC
 
-#define KASAN_SHADOW_INIT 0
-
 void kasan_cache_shrink(struct kmem_cache *cache);
 void kasan_cache_shutdown(struct kmem_cache *cache);
 void kasan_record_aux_stack(void *ptr);
@@ -168,8 +180,6 @@ static inline void kasan_record_aux_stack(void *ptr) {}
 
 #ifdef CONFIG_KASAN_SW_TAGS
 
-#define KASAN_SHADOW_INIT 0xFF
-
 void kasan_init_tags(void);
 
 void *kasan_reset_tag(const void *addr);
-- 
2.28.0.618.gf4bc123cb7-goog

