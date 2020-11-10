Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45ADE2AE30A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 23:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732268AbgKJWOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 17:14:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732248AbgKJWLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 17:11:19 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33E8C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:11:18 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id w6so6193136wrk.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=1eB/cLd20VDMIOf5D2uQuwyV0kwdvml7t6htObswIuI=;
        b=dcDLFYUo7ZWAl0w6Ap0g44WLGYOIxW8LfvFE7BVqEs3gAXemhCzpMkfI9vHDfCo5kW
         G6DfPNHDcMneHDBN1nxH1Eydjd/4oDloko4cSzC5V+MpBFyqz4pUyEnw4JEXd+wUFsDo
         yHlcQUTwruEFGKeILdN4qETaXVmG1nNvrrBMGhXjq0Btdua3oc8Tdl/uz0fb4xwF3464
         fJGVAT98LJmWJ6K2H5kKNrU7pBoLcV+RjVC6O86jwQINLvUqahB2rJYRXbl6uTwBr/ev
         oygWQe2FPANJPDJBwoKLxN1pCMn1sAlyj3x7qYNiK5EQOmtNG52a6p9o948Ujd5O3Wue
         W9YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1eB/cLd20VDMIOf5D2uQuwyV0kwdvml7t6htObswIuI=;
        b=eUywQ2IAJibXBQorixoT30bV60QeEmq26F7/bjT0kVZ9tAucWYpzBc1NP7lsZzraJp
         WpnXa9a3/3MBWH5xGh3bo+gVf7CmZIyvb/WZPsLargZlKkrEC/EU3Kaa0avSd5470lV4
         OmyMWgJdw6RM8sALC7RHn7dZolwtc5RHAPsuQE5DJDyJX95u4mylUo1VjUIzbOOLBsE/
         UQyyN1xFmeO4q4s+hiGwRAONU4Wo6JfZ0NlMUMUOApqTfo1AxKKHbeQdAQr2OqzPBE3x
         SZEzD4U7w3hagu5DI1movVpb5mmKU0HVjg8upwZ37AzGarcXuGwR9kobMU1mpB4THkDX
         Vfsw==
X-Gm-Message-State: AOAM530+1i7k+NSxjospOilz7/+IegClRJ8zvARkWbj8mQSuSxpJCVpc
        UxrP1j7MoCRaAUE6/cS7FU3r6qEg3JvbKlxX
X-Google-Smtp-Source: ABdhPJwNo9ObkSN2dMHiHZK/63eZNhZwi78i0Byk4gVJTBEP3w/ACtRfoFudjsbUvnKKRJmHq4ATBQVOooK1uHoj
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a1c:7303:: with SMTP id
 d3mr275192wmb.152.1605046277660; Tue, 10 Nov 2020 14:11:17 -0800 (PST)
Date:   Tue, 10 Nov 2020 23:10:02 +0100
In-Reply-To: <cover.1605046192.git.andreyknvl@google.com>
Message-Id: <81fbf12c3455448b2bb4162dd9888d405ee0c00a.1605046192.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605046192.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH v9 05/44] kasan: shadow declarations only for software modes
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
2.29.2.222.g5d2a92d10f8-goog

