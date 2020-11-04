Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFE52A711B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 00:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732625AbgKDXTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 18:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732573AbgKDXTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 18:19:20 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8EB9C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 15:19:19 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id z62so1721786wmb.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 15:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=nboRM2CFBpQGYkXl6uRGVt4iydoGbxyL4XKrxiXLpKY=;
        b=dgN/w1amHzWAucOFICHabUoYKns9E0EW4S17djL5Mq75cVwBGdDZqGYn8Qeq7nvUMW
         M97Jt+7e9lvcxl2kI9TAb+GXKY0QiGMIdyQ80daOWo5mtsE7SwttKp2xBsEJ2yjJSSCQ
         ayJDF8IL3/w0AgWFJMHoxvvtX/6pIISNeXHtetBbvP07VtsxAq5Dv50zks2RcMAKViLG
         CkyCLE5yfn5OdhtwmcfKGxnNruhoxrd+swkNI0152pnDJP/YtMLok9KSOn6eqZ38+VjO
         +BSkyPd2W9vydTe8BECVlFQ+za6j6eQ8FXktVLuLm2s382u0spMvJohHeUQmMlt4pBxG
         MK8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nboRM2CFBpQGYkXl6uRGVt4iydoGbxyL4XKrxiXLpKY=;
        b=bgVJWMBcWGJtOIvFyVkHoez/s8MLx6lJEukzV5qhdYndXbcKgqwcrX5jHMf8SHYMx5
         GB5wct2pnv/fb4rzxY0SJtjC8FhgasWAtoCuByU1WJo7bZT69q0cnBrPFOIgPG0rQqS8
         4rnx/BOtWaDxC8yZbUyeMGliWiRsVN2Gq7SiDfb0MfOPwik55JiRRjxyceDoYBsSiss+
         90au6ll0aGc2yLMcTMlcjhn7UWb6gkuD9W3X0AhoyvEkqvJOnXJuqBEK8bNG+GfyFPfV
         RvGSx92mbnvD/rCIndYq3Oay1LI3u5AU2hPRnQhGedFJ6qMmo55hWW6obbPZBUjpkkCh
         VOkA==
X-Gm-Message-State: AOAM531uJ/Jlc43qFbA2QnwM50a3UL/Ga/zbN/TYvf06yjHyuJCaYAQH
        lYKtxnF2CxWmt2GSVRMdJW7l0x6QOn1sLP5P
X-Google-Smtp-Source: ABdhPJyqM0dDi4GfWkh1I27aN5R/lBK00hzYxseangjAFcdYFNu3XKGF2HJ+8fAAEsbL6D3qdB2J3NKnTJRwJA6F
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a1c:4957:: with SMTP id
 w84mr86567wma.84.1604531958343; Wed, 04 Nov 2020 15:19:18 -0800 (PST)
Date:   Thu,  5 Nov 2020 00:18:20 +0100
In-Reply-To: <cover.1604531793.git.andreyknvl@google.com>
Message-Id: <36545c406b0aea73f636fa25e85de6a86a349775.1604531793.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1604531793.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v8 05/43] kasan: shadow declarations only for software modes
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
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

This is a preparatory commit for the upcoming addition of a new hardware
tag-based (MTE-based) KASAN mode.

Group shadow-related KASAN function declarations and only define them
for the two existing software modes.

No functional changes for software modes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Marco Elver <elver@google.com>
---
Change-Id: I864be75a88b91b443c55e9c2042865e15703e164
---
 include/linux/kasan.h | 45 ++++++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 16 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 59538e795df4..45345dd5cfd6 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -10,9 +10,20 @@ struct vm_struct;
 struct task_struct;
 
 #ifdef CONFIG_KASAN
+#include <asm/kasan.h>
+#endif
+
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
 
 /* kasan_data struct is used in KUnit tests for KASAN expected failures */
 struct kunit_kasan_expectation {
@@ -35,6 +46,23 @@ static inline void *kasan_mem_to_shadow(const void *addr)
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
 
@@ -75,9 +103,6 @@ struct kasan_cache {
 	int free_meta_offset;
 };
 
-int kasan_add_zero_shadow(void *start, unsigned long size);
-void kasan_remove_zero_shadow(void *start, unsigned long size);
-
 size_t __ksize(const void *);
 static inline void kasan_unpoison_slab(const void *ptr)
 {
@@ -143,14 +168,6 @@ static inline bool kasan_slab_free(struct kmem_cache *s, void *object,
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
 
@@ -158,8 +175,6 @@ static inline size_t kasan_metadata_size(struct kmem_cache *cache) { return 0; }
 
 #ifdef CONFIG_KASAN_GENERIC
 
-#define KASAN_SHADOW_INIT 0
-
 void kasan_cache_shrink(struct kmem_cache *cache);
 void kasan_cache_shutdown(struct kmem_cache *cache);
 void kasan_record_aux_stack(void *ptr);
@@ -174,8 +189,6 @@ static inline void kasan_record_aux_stack(void *ptr) {}
 
 #ifdef CONFIG_KASAN_SW_TAGS
 
-#define KASAN_SHADOW_INIT 0xFF
-
 void kasan_init_tags(void);
 
 void *kasan_reset_tag(const void *addr);
-- 
2.29.1.341.ge80a0c044ae-goog

