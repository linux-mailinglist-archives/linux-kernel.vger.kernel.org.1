Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68C1A29F4F9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 20:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgJ2T0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 15:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbgJ2T0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 15:26:42 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897FCC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 12:26:40 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id z62so972762wmb.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 12:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=nboRM2CFBpQGYkXl6uRGVt4iydoGbxyL4XKrxiXLpKY=;
        b=vLHwj7A5gFQKqlkRDBMVzX6K9iJ/mMR6bA0PxbMCKvpNLDl67MVinUphj1bWMfnhll
         7EKjNu0BDMsx4OjuMmBu1buc9CeCM9Rp7XrvpfoHzRu/rd1Gvv2YQs0StYOBxVndw5nX
         kz6J3IfTyvPwkKtP9q/qkdOXv1A6QRL8tgQz35+DVVcRoODEGW+K6tAOS8xbfPZlaE+N
         b0bKgwUI7oPQ03zDlPkFIx36OevYLbvz8z/rFFt4hvH5S6nTaWIvL8KZWULFxVl9NdWg
         Dvr9udCV+PLe1ftwi9LUy9A3UBWELicytQ5NN1HH5IHd2smHLd/XV0501sRX5FPHQVxo
         0xKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nboRM2CFBpQGYkXl6uRGVt4iydoGbxyL4XKrxiXLpKY=;
        b=jFG3AI1rkSYsqaZYwGe5DyDChJR3P8o6sCN1Rq6OpLjZl7TUQqM6KZQDp1WcRJJese
         Uu4wYLrqieRizOUAt0MIXbJWBSHbsd6v8oxH7ThNQNJc8vh/Wo3Xx4LaZHtIYj3HCaeS
         vUEI7fwxUJCiuMGXOmn9a7Rr2seRAC9hMONCEuRbeCaW68b994YrCvTDAvHdh6ERFx1D
         safGx4Zgr5aHTMijFXsRKRkuI7LpY2xBJP2SaIKUSY6poboVza7/kqzhUmo793So7hhz
         icNAZEtD+OfAP04rH07S/hQfOUztJdqgUwoYONIjG1ZvVKJbJlDInGcl+7f2dQEt1mdM
         GY1g==
X-Gm-Message-State: AOAM530CVK0uotj/XjwA4YAHej8YOittb4/FXA9iabM+jUFe3PWBoWUP
        2+jeUc++gTWZCYmSQlO5y1/8evATE0I/+Pgu
X-Google-Smtp-Source: ABdhPJwIIyzSfuuguARDCDhOaa8VXjLTXjjb9PFLkIubsbZADx+X2+oyTkemHPuhBQlyecjUTgfvNXvANDRlo6Ac
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:adf:c58f:: with SMTP id
 m15mr7428154wrg.144.1603999599104; Thu, 29 Oct 2020 12:26:39 -0700 (PDT)
Date:   Thu, 29 Oct 2020 20:25:34 +0100
In-Reply-To: <cover.1603999489.git.andreyknvl@google.com>
Message-Id: <0130b488568090eb2ad2ffc47955122be754cfbe.1603999489.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1603999489.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v6 13/40] kasan: shadow declarations only for software modes
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

