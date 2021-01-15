Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5B372F8310
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732497AbhAORyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbhAORyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:54:21 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421C5C061795
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:53:10 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id r5so3272314wma.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=zMg6r0lhSdqTSYHUPwBG8lqIjESWbLf3bRfMeCJdmw0=;
        b=BdrM/OgtKgtwtkZrRDvSjneQEmaFxHvNidV13QaIsDaKHLQkxdZAyIz6nKTwapsqml
         tNVLyE1vG6b4ranZ2aJz38cXwMl+MXOv/72bmF8cyEm0QNy0E/FFi2V2ZMJivl/2HeQz
         ReA5B2aZ9HtAfVnXkEQQm5HHw3+9fD1P1X9/2i/WfBLQwhVzVCvonQ+dsuf/tLGLkuiF
         3i839QqVJzzHPZPVBk7SgK2zlt6ggS78YV3Za+0MeOjrD7CQlae+EFP62bx1Fx2ea55L
         HpGh9UR6SsWuaPH7lDAdr+Fp/w0xNtjcbE+vhmz66c3PwHVwrSNLSrws/Qqis6+nSPGZ
         N8Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zMg6r0lhSdqTSYHUPwBG8lqIjESWbLf3bRfMeCJdmw0=;
        b=UklnTZM5wsU3Y4z7IONOXYBuTmpA705S4Gyh4HVkpFgrPqcvT+u2tO9RlVX/Lrw3TI
         m1K4U8F861KK9bbi3F+OsKbJW336Fax1t0Qwf4ddMuz7kSsSsU1/t/O8HRZXV0WxD4/O
         IHVziBuhJuii8gJEyFcwHifr34fh3FXYeFts8iwDTHDqZJc1jPhyec2NQbvaPlGESLeL
         OlvyVim4yPu5aG6S2AzUPtUcyc6bGxcXZTh/dtqkW3zOFV+nS7oETdCBDL7K7y/t1rro
         QgDbhV29qmsKww44AoHYYWyNx6MYfnVwpT+YsIVjqFNlqPOp1XNFj8ShCc78QE6jctbh
         iKVw==
X-Gm-Message-State: AOAM530Y3QwxKGgIu7BP/Vh/4Ug+LprjVkG/w4AQvw94aS1s2ZbOWemR
        n++K2hN7a7ym/Pk48B06YNltvcQWQp/8Epk0
X-Google-Smtp-Source: ABdhPJyI5UjvJtuZWU5JcOkxMt0jDOhuHDy2TRnSQW3JB1SPQmiD4RvzKDe64oIbvPSHNHHmEPI2RkFtfBO/4+/U
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a5d:4f8a:: with SMTP id
 d10mr14096449wru.219.1610733189015; Fri, 15 Jan 2021 09:53:09 -0800 (PST)
Date:   Fri, 15 Jan 2021 18:52:41 +0100
In-Reply-To: <cover.1610733117.git.andreyknvl@google.com>
Message-Id: <6a0fcdb9676b7e869cfc415893ede12d916c246c.1610733117.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1610733117.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v4 04/15] kasan: add macros to simplify checking test constraints
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Peter Collingbourne <pcc@google.com>,
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

Some KASAN tests require specific kernel configs to be enabled.
Instead of copy-pasting the checks for these configs add a few helper
macros and use them.

Link: https://linux-review.googlesource.com/id/I237484a7fddfedf4a4aae9cc61ecbcdbe85a0a63
Suggested-by: Alexander Potapenko <glider@google.com>
Reviewed-by: Marco Elver <elver@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/test_kasan.c | 101 +++++++++++++++--------------------------------
 1 file changed, 31 insertions(+), 70 deletions(-)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index 6f46e27c2af7..714ea27fcc3e 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -73,6 +73,20 @@ static void kasan_test_exit(struct kunit *test)
 			fail_data.report_found); \
 } while (0)
 
+#define KASAN_TEST_NEEDS_CONFIG_ON(test, config) do {			\
+	if (!IS_ENABLED(config)) {					\
+		kunit_info((test), "skipping, " #config " required");	\
+		return;							\
+	}								\
+} while (0)
+
+#define KASAN_TEST_NEEDS_CONFIG_OFF(test, config) do {			\
+	if (IS_ENABLED(config)) {					\
+		kunit_info((test), "skipping, " #config " enabled");	\
+		return;							\
+	}								\
+} while (0)
+
 static void kmalloc_oob_right(struct kunit *test)
 {
 	char *ptr;
@@ -114,10 +128,7 @@ static void kmalloc_pagealloc_oob_right(struct kunit *test)
 	char *ptr;
 	size_t size = KMALLOC_MAX_CACHE_SIZE + 10;
 
-	if (!IS_ENABLED(CONFIG_SLUB)) {
-		kunit_info(test, "CONFIG_SLUB is not enabled.");
-		return;
-	}
+	KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_SLUB);
 
 	/*
 	 * Allocate a chunk that does not fit into a SLUB cache to trigger
@@ -135,10 +146,7 @@ static void kmalloc_pagealloc_uaf(struct kunit *test)
 	char *ptr;
 	size_t size = KMALLOC_MAX_CACHE_SIZE + 10;
 
-	if (!IS_ENABLED(CONFIG_SLUB)) {
-		kunit_info(test, "CONFIG_SLUB is not enabled.");
-		return;
-	}
+	KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_SLUB);
 
 	ptr = kmalloc(size, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
@@ -152,10 +160,7 @@ static void kmalloc_pagealloc_invalid_free(struct kunit *test)
 	char *ptr;
 	size_t size = KMALLOC_MAX_CACHE_SIZE + 10;
 
-	if (!IS_ENABLED(CONFIG_SLUB)) {
-		kunit_info(test, "CONFIG_SLUB is not enabled.");
-		return;
-	}
+	KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_SLUB);
 
 	ptr = kmalloc(size, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
@@ -218,10 +223,7 @@ static void kmalloc_oob_16(struct kunit *test)
 	} *ptr1, *ptr2;
 
 	/* This test is specifically crafted for the generic mode. */
-	if (!IS_ENABLED(CONFIG_KASAN_GENERIC)) {
-		kunit_info(test, "CONFIG_KASAN_GENERIC required\n");
-		return;
-	}
+	KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_KASAN_GENERIC);
 
 	ptr1 = kmalloc(sizeof(*ptr1) - 3, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr1);
@@ -454,10 +456,7 @@ static void kasan_global_oob(struct kunit *test)
 	char *p = &global_array[ARRAY_SIZE(global_array) + i];
 
 	/* Only generic mode instruments globals. */
-	if (!IS_ENABLED(CONFIG_KASAN_GENERIC)) {
-		kunit_info(test, "CONFIG_KASAN_GENERIC required");
-		return;
-	}
+	KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_KASAN_GENERIC);
 
 	KUNIT_EXPECT_KASAN_FAIL(test, *(volatile char *)p);
 }
@@ -486,10 +485,7 @@ static void kasan_stack_oob(struct kunit *test)
 	volatile int i = OOB_TAG_OFF;
 	char *p = &stack_array[ARRAY_SIZE(stack_array) + i];
 
-	if (!IS_ENABLED(CONFIG_KASAN_STACK)) {
-		kunit_info(test, "CONFIG_KASAN_STACK is not enabled");
-		return;
-	}
+	KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_KASAN_STACK);
 
 	KUNIT_EXPECT_KASAN_FAIL(test, *(volatile char *)p);
 }
@@ -501,15 +497,8 @@ static void kasan_alloca_oob_left(struct kunit *test)
 	char *p = alloca_array - 1;
 
 	/* Only generic mode instruments dynamic allocas. */
-	if (!IS_ENABLED(CONFIG_KASAN_GENERIC)) {
-		kunit_info(test, "CONFIG_KASAN_GENERIC required");
-		return;
-	}
-
-	if (!IS_ENABLED(CONFIG_KASAN_STACK)) {
-		kunit_info(test, "CONFIG_KASAN_STACK is not enabled");
-		return;
-	}
+	KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_KASAN_GENERIC);
+	KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_KASAN_STACK);
 
 	KUNIT_EXPECT_KASAN_FAIL(test, *(volatile char *)p);
 }
@@ -521,15 +510,8 @@ static void kasan_alloca_oob_right(struct kunit *test)
 	char *p = alloca_array + i;
 
 	/* Only generic mode instruments dynamic allocas. */
-	if (!IS_ENABLED(CONFIG_KASAN_GENERIC)) {
-		kunit_info(test, "CONFIG_KASAN_GENERIC required");
-		return;
-	}
-
-	if (!IS_ENABLED(CONFIG_KASAN_STACK)) {
-		kunit_info(test, "CONFIG_KASAN_STACK is not enabled");
-		return;
-	}
+	KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_KASAN_GENERIC);
+	KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_KASAN_STACK);
 
 	KUNIT_EXPECT_KASAN_FAIL(test, *(volatile char *)p);
 }
@@ -593,11 +575,7 @@ static void kasan_memchr(struct kunit *test)
 	 * str* functions are not instrumented with CONFIG_AMD_MEM_ENCRYPT.
 	 * See https://bugzilla.kernel.org/show_bug.cgi?id=206337 for details.
 	 */
-	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
-		kunit_info(test,
-			"str* functions are not instrumented with CONFIG_AMD_MEM_ENCRYPT");
-		return;
-	}
+	KASAN_TEST_NEEDS_CONFIG_OFF(test, CONFIG_AMD_MEM_ENCRYPT);
 
 	if (OOB_TAG_OFF)
 		size = round_up(size, OOB_TAG_OFF);
@@ -621,11 +599,7 @@ static void kasan_memcmp(struct kunit *test)
 	 * str* functions are not instrumented with CONFIG_AMD_MEM_ENCRYPT.
 	 * See https://bugzilla.kernel.org/show_bug.cgi?id=206337 for details.
 	 */
-	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
-		kunit_info(test,
-			"str* functions are not instrumented with CONFIG_AMD_MEM_ENCRYPT");
-		return;
-	}
+	KASAN_TEST_NEEDS_CONFIG_OFF(test, CONFIG_AMD_MEM_ENCRYPT);
 
 	if (OOB_TAG_OFF)
 		size = round_up(size, OOB_TAG_OFF);
@@ -648,11 +622,7 @@ static void kasan_strings(struct kunit *test)
 	 * str* functions are not instrumented with CONFIG_AMD_MEM_ENCRYPT.
 	 * See https://bugzilla.kernel.org/show_bug.cgi?id=206337 for details.
 	 */
-	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
-		kunit_info(test,
-			"str* functions are not instrumented with CONFIG_AMD_MEM_ENCRYPT");
-		return;
-	}
+	KASAN_TEST_NEEDS_CONFIG_OFF(test, CONFIG_AMD_MEM_ENCRYPT);
 
 	ptr = kmalloc(size, GFP_KERNEL | __GFP_ZERO);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
@@ -713,10 +683,7 @@ static void kasan_bitops_generic(struct kunit *test)
 	long *bits;
 
 	/* This test is specifically crafted for the generic mode. */
-	if (!IS_ENABLED(CONFIG_KASAN_GENERIC)) {
-		kunit_info(test, "CONFIG_KASAN_GENERIC required\n");
-		return;
-	}
+	KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_KASAN_GENERIC);
 
 	/*
 	 * Allocate 1 more byte, which causes kzalloc to round up to 16 bytes;
@@ -744,11 +711,8 @@ static void kasan_bitops_tags(struct kunit *test)
 {
 	long *bits;
 
-	/* This test is specifically crafted for the tag-based mode. */
-	if (IS_ENABLED(CONFIG_KASAN_GENERIC)) {
-		kunit_info(test, "CONFIG_KASAN_SW_TAGS required\n");
-		return;
-	}
+	/* This test is specifically crafted for tag-based modes. */
+	KASAN_TEST_NEEDS_CONFIG_OFF(test, CONFIG_KASAN_GENERIC);
 
 	/* Allocation size will be rounded to up granule size, which is 16. */
 	bits = kzalloc(sizeof(*bits), GFP_KERNEL);
@@ -777,10 +741,7 @@ static void vmalloc_oob(struct kunit *test)
 {
 	void *area;
 
-	if (!IS_ENABLED(CONFIG_KASAN_VMALLOC)) {
-		kunit_info(test, "CONFIG_KASAN_VMALLOC is not enabled.");
-		return;
-	}
+	KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_KASAN_VMALLOC);
 
 	/*
 	 * We have to be careful not to hit the guard page.
-- 
2.30.0.284.gd98b1dd5eaa7-goog

