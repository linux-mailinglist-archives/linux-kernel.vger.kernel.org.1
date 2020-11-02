Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27B6D2A2F1B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 17:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbgKBQFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 11:05:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbgKBQFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 11:05:03 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40804C061A04
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 08:05:01 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id u9so919861wmb.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 08:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=nboRM2CFBpQGYkXl6uRGVt4iydoGbxyL4XKrxiXLpKY=;
        b=JHfhNMMW+qn1qY2Cu3L6Q6z30VYq2DY1x6anOXs6RaYMAQ84dCzOuSq0hbAFJEat9V
         T3b6MzAFO6gbMTVr7Q4CJ3R44CvSnXJUAP2BKdYszxsWhQlvR19wJVcH6PpXEibDQrpM
         tlHv+Z5IHNSQbO6fvxfo0R7quqUo1UmFz7C9DB9ct8oHgvJThFh/q/pc0BOdG4PDac+7
         kvP96QOWlT9l5ydslHUJgmb20xJKvJdkd2Q6nWIB7WuIEdYMMlWe2qhlz+p8Hcac7kMO
         yMSxKHynwoHB0l4YrlvZDJaMeJD5Svq8l8lWPvXzJfCzp8mUimoZmpWhiK+QzHX1Swh2
         x6Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nboRM2CFBpQGYkXl6uRGVt4iydoGbxyL4XKrxiXLpKY=;
        b=dAfYcbwAbRhLoN3SYHhk1yICaJw9tKbor4uBKvl1B5Sagk0oc2R9QyzVSBh5rs5Rjn
         hreV1Hjt2xIbH5kKJtDX3tqt88jhu5wKJ/5y9dkK6bXWp3K3QUG3RNejeu96jMOTdkz0
         50jASW/NLolemx6nYQSPusyJ4NZfSz9A1At3XE2iSHnT3K7zFt93uN9xW5t5vG4ZLngA
         yT/hggmifQloSq7mnV1mLIjjrQwxpwYSrhRcMLmmFgyK6vZR8MaERXLPRplk1tbe3jOe
         wYdjrYBG0K4sLYgZJQ7NEEVC1mnaKZobJKVAS0cAtVOzDaIVNUGaQidZwwsBiHIEHhxp
         Kbcg==
X-Gm-Message-State: AOAM530HRWRChDkZtX5Bwevay5FVq3lzGWy76gnljhCn0jJtpIR71+4/
        8CCjn7B0VuXv+ePSfz6PnN5rgb0/gVBqcxbl
X-Google-Smtp-Source: ABdhPJx223Po5pNDzYi2DjmiVzapcUD41oWyajMVJAAkpsvXv4jOC/1TDREEGXz2jJfrXsii6Us2R0rk3eugfUNI
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a05:600c:21c4:: with SMTP id
 x4mr18287235wmj.74.1604333099942; Mon, 02 Nov 2020 08:04:59 -0800 (PST)
Date:   Mon,  2 Nov 2020 17:03:54 +0100
In-Reply-To: <cover.1604333009.git.andreyknvl@google.com>
Message-Id: <d292b4aefdd9b5d0d52bfde8a353aae4e3cb5d5d.1604333009.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1604333009.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v7 14/41] kasan: shadow declarations only for software modes
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
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

