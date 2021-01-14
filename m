Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E23002F6B2C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 20:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730088AbhANTh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 14:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730045AbhANThZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 14:37:25 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF72C0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 11:36:44 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id k67so2259258wmk.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 11:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=zMg6r0lhSdqTSYHUPwBG8lqIjESWbLf3bRfMeCJdmw0=;
        b=Dx+ztVnv+FwNwPzFXu5KIt3022UCQpjcH8gV792uQrosCwBiD6s4lKdG6MDiSwIFty
         zznmU+yiRfoJQcWIwikMbMqsCRkQxUgLXifvz8Oxd4YIBwAAFS36926Pfeu7bsSiIEwE
         o3usg3RsQK4R+oSpZnrq5o46zjx+pugkAeDbGniEVaNPqnlP2N3zERnpZSjYfM2EaIcx
         buXUb1FmK8aV44K8w4h8I1q4JXZVL0tARu5F4Bk3c/xs+5B7IbL3MBJfnqm38wapZjEt
         y0ScDih7/CtVvBRKYgX3tAxh8Igw2y7LypOyXTtN/ko9k9Ke/uyVLw1tmc3VEKeshCcA
         ky3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zMg6r0lhSdqTSYHUPwBG8lqIjESWbLf3bRfMeCJdmw0=;
        b=mboYcc5CAVQ/XbY5Q/s/kk+mjj2VBf7oKEfB2EK9jrDLrIU85YaA4jDwyu6rSQWEEu
         w09lYZMeH6K2V5rJTrT++A0zdP8l98kPhlsQY57DaaLBk+SHXSQ3m9BoePrSwvcrAkoP
         QSeNDmk7m55KtdDeBTT2tS/97eCZsjBZofOXJ6ATtsLtAcbx0jVQdJLesoQgq/3oAUL9
         62+JWjwn4xBVfVP0choluVrkmr9za1YB4k6OGCUAotMHO6g26iDpB3Qf9j1FmH0ajpUy
         T24AIGG+qAW+9NeX/uBFyXGmLmI6WZYgqoIfn2NSmzeALFpA5yNxmx2m/yjIc+FAl9e5
         toDA==
X-Gm-Message-State: AOAM532DZS7tvfD9fWCN3ksUV+dRGmBLcBq+icIBnMkKBADrBQSsYEnZ
        XsjKWzsLwzRCBEvTITWDxrEPnUKyZHv5NMgZ
X-Google-Smtp-Source: ABdhPJyibMeibL9gpregYii7PXMjkIxcavXYjOpF3E3d81tvEjVnDAbs2GeCK4dNyz9x/wDqO4/Zs4uRZg3wZEZf
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a7b:cf08:: with SMTP id
 l8mr5430516wmg.189.1610653003717; Thu, 14 Jan 2021 11:36:43 -0800 (PST)
Date:   Thu, 14 Jan 2021 20:36:20 +0100
In-Reply-To: <cover.1610652890.git.andreyknvl@google.com>
Message-Id: <7723d28506e41b5b7da1b4540b80f3f13c92b33f.1610652890.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1610652890.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v3 04/15] kasan: add macros to simplify checking test constraints
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

