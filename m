Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22E8D2EB295
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 19:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729947AbhAES24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 13:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729333AbhAES2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 13:28:52 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E934C061796
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 10:28:11 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id s130so176416wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 10:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=kMqOwAycKrvTptizhNYAx5EVpfOHvBX1uRwiTYE70ik=;
        b=fj8BsYWgCboP+uVLBfvlbK31OG0ZtFjZt8zg55BXEKKy2v1MXA0eTVf7WHerJZ4xSW
         iuoWFs/AUeCZUFjT3q9Dil3OXp3+2WbO24Oy7cWUfSsHXUGhaULNe+jCfB5LXEZJqKxi
         XPtkWWmW6g3x8diCRQo75saoWYguzu2Y6r6vFhILoB3ct/OxXXZRLvmtH76jLWiejlKf
         ElfPX2qRlQVV8/Cm0kwX1BYlCrfYUSBSa9PzFRXDiaE0fSDv1gT3quf6anlqHKJe9dtM
         V/PrBwCcgDCk2ia/2fUZY7MB29NUlm39xinhRinn/MrO2Xv46hHXChBBVjzO7nhXHIAQ
         kmEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kMqOwAycKrvTptizhNYAx5EVpfOHvBX1uRwiTYE70ik=;
        b=lBEzr9/XHcYOtiFKPoq6W690FNrITl24lv44yKcxiOTxkoGWK+GckCQR4JGBaZKPz2
         jhdPOM9x48+J6V+n45fCeCXtf/xnLi0hQPMZBePunqSvhceQiN99ITevdLwH6Bc8fyMS
         SDGuAtenLM0J2Vz9Vdp+Sp3N7uEvNsOa0ogdWQ8Hw+yPrsYD9Joo+7o1FXaB3wDXUanm
         g32HzdsMudevG5LyTw0HsH5tBI62s5XCt6FUG+qvK6w97aokjLBlLdJ4IsnnFCu+RKP6
         gLfCL9MhFNc0QEhCCojMKzMNXO23Txi+te4vxeoDpuwjoWCITvcKwP4uCtE1/HKStfBd
         fDfw==
X-Gm-Message-State: AOAM531GeSuunHDYVaqUmJwJJmyk6erjQg2bz8lcRP+aMEdUzAj9neMZ
        JHUgGAZLkAHciPg8lH4tG4F156j3GF7tN1Hr
X-Google-Smtp-Source: ABdhPJwGB1XJ2ejrBSrZLIAkQ/xHnnVSqucNQ8BcjHRY5B2Gd7j+EsVmJ2AdOBTl42/sHCQeRO/tPW5KILA8tRZU
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a5d:4307:: with SMTP id
 h7mr795184wrq.353.1609871289844; Tue, 05 Jan 2021 10:28:09 -0800 (PST)
Date:   Tue,  5 Jan 2021 19:27:47 +0100
In-Reply-To: <cover.1609871239.git.andreyknvl@google.com>
Message-Id: <cb4e610c6584251aa2397b56c46e278da0050a25.1609871239.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1609871239.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [PATCH 03/11] kasan: clean up comments in tests
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
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

Clarify and update comments and info messages in KASAN tests.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Link: https://linux-review.googlesource.com/id/I6c816c51fa1e0eb7aa3dead6bda1f339d2af46c8
---
 lib/test_kasan.c        | 94 +++++++++++++++++++++++------------------
 lib/test_kasan_module.c |  5 ++-
 2 files changed, 55 insertions(+), 44 deletions(-)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index 2947274cc2d3..46e578c8e842 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -28,10 +28,9 @@
 #define OOB_TAG_OFF (IS_ENABLED(CONFIG_KASAN_GENERIC) ? 0 : KASAN_GRANULE_SIZE)
 
 /*
- * We assign some test results to these globals to make sure the tests
- * are not eliminated as dead code.
+ * Some tests use these global variables to store return values from function
+ * calls that could otherwise be eliminated by the compiler as dead code.
  */
-
 void *kasan_ptr_result;
 int kasan_int_result;
 
@@ -39,14 +38,13 @@ static struct kunit_resource resource;
 static struct kunit_kasan_expectation fail_data;
 static bool multishot;
 
+/*
+ * Temporarily enable multi-shot mode. Otherwise, KASAN would only report the
+ * first detected bug and panic the kernel if panic_on_warn is enabled.
+ */
 static int kasan_test_init(struct kunit *test)
 {
-	/*
-	 * Temporarily enable multi-shot mode and set panic_on_warn=0.
-	 * Otherwise, we'd only get a report for the first case.
-	 */
 	multishot = kasan_save_enable_multi_shot();
-
 	return 0;
 }
 
@@ -56,12 +54,12 @@ static void kasan_test_exit(struct kunit *test)
 }
 
 /**
- * KUNIT_EXPECT_KASAN_FAIL() - Causes a test failure when the expression does
- * not cause a KASAN error. This uses a KUnit resource named "kasan_data." Do
- * Do not use this name for a KUnit resource outside here.
- *
+ * KUNIT_EXPECT_KASAN_FAIL() - check that the executed expression produces a
+ * KASAN report; causes a test failure otherwise. This relies on a KUnit
+ * resource named "kasan_data". Do not use this name for KUnit resources
+ * outside of KASAN tests.
  */
-#define KUNIT_EXPECT_KASAN_FAIL(test, condition) do { \
+#define KUNIT_EXPECT_KASAN_FAIL(test, expression) do { \
 	fail_data.report_expected = true; \
 	fail_data.report_found = false; \
 	kunit_add_named_resource(test, \
@@ -69,7 +67,7 @@ static void kasan_test_exit(struct kunit *test)
 				NULL, \
 				&resource, \
 				"kasan_data", &fail_data); \
-	condition; \
+	expression; \
 	KUNIT_EXPECT_EQ(test, \
 			fail_data.report_expected, \
 			fail_data.report_found); \
@@ -117,11 +115,12 @@ static void kmalloc_pagealloc_oob_right(struct kunit *test)
 	size_t size = KMALLOC_MAX_CACHE_SIZE + 10;
 
 	if (!IS_ENABLED(CONFIG_SLUB)) {
-		kunit_info(test, "CONFIG_SLUB is not enabled.");
+		kunit_info(test, "skipping, CONFIG_SLUB required");
 		return;
 	}
 
-	/* Allocate a chunk that does not fit into a SLUB cache to trigger
+	/*
+	 * Allocate a chunk that does not fit into a SLUB cache to trigger
 	 * the page allocator fallback.
 	 */
 	ptr = kmalloc(size, GFP_KERNEL);
@@ -137,7 +136,7 @@ static void kmalloc_pagealloc_uaf(struct kunit *test)
 	size_t size = KMALLOC_MAX_CACHE_SIZE + 10;
 
 	if (!IS_ENABLED(CONFIG_SLUB)) {
-		kunit_info(test, "CONFIG_SLUB is not enabled.");
+		kunit_info(test, "skipping, CONFIG_SLUB required");
 		return;
 	}
 
@@ -154,7 +153,7 @@ static void kmalloc_pagealloc_invalid_free(struct kunit *test)
 	size_t size = KMALLOC_MAX_CACHE_SIZE + 10;
 
 	if (!IS_ENABLED(CONFIG_SLUB)) {
-		kunit_info(test, "CONFIG_SLUB is not enabled.");
+		kunit_info(test, "skipping, CONFIG_SLUB required");
 		return;
 	}
 
@@ -168,7 +167,9 @@ static void kmalloc_large_oob_right(struct kunit *test)
 {
 	char *ptr;
 	size_t size = KMALLOC_MAX_CACHE_SIZE - 256;
-	/* Allocate a chunk that is large enough, but still fits into a slab
+
+	/*
+	 * Allocate a chunk that is large enough, but still fits into a slab
 	 * and does not trigger the page allocator fallback in SLUB.
 	 */
 	ptr = kmalloc(size, GFP_KERNEL);
@@ -218,7 +219,7 @@ static void kmalloc_oob_16(struct kunit *test)
 
 	/* This test is specifically crafted for the generic mode. */
 	if (!IS_ENABLED(CONFIG_KASAN_GENERIC)) {
-		kunit_info(test, "CONFIG_KASAN_GENERIC required\n");
+		kunit_info(test, "skipping, CONFIG_KASAN_GENERIC required");
 		return;
 	}
 
@@ -454,7 +455,7 @@ static void kasan_global_oob(struct kunit *test)
 
 	/* Only generic mode instruments globals. */
 	if (!IS_ENABLED(CONFIG_KASAN_GENERIC)) {
-		kunit_info(test, "CONFIG_KASAN_GENERIC required");
+		kunit_info(test, "skipping, CONFIG_KASAN_GENERIC required");
 		return;
 	}
 
@@ -469,10 +470,13 @@ static void ksize_unpoisons_memory(struct kunit *test)
 	ptr = kmalloc(size, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 	real_size = ksize(ptr);
-	/* This access doesn't trigger an error. */
+
+	/* This access shouldn't trigger a KASAN report. */
 	ptr[size] = 'x';
-	/* This one does. */
+
+	/* This one must. */
 	KUNIT_EXPECT_KASAN_FAIL(test, ptr[real_size] = 'y');
+
 	kfree(ptr);
 }
 
@@ -483,7 +487,7 @@ static void kasan_stack_oob(struct kunit *test)
 	char *p = &stack_array[ARRAY_SIZE(stack_array) + i];
 
 	if (!IS_ENABLED(CONFIG_KASAN_STACK)) {
-		kunit_info(test, "CONFIG_KASAN_STACK is not enabled");
+		kunit_info(test, "skipping, CONFIG_KASAN_STACK required");
 		return;
 	}
 
@@ -498,12 +502,12 @@ static void kasan_alloca_oob_left(struct kunit *test)
 
 	/* Only generic mode instruments dynamic allocas. */
 	if (!IS_ENABLED(CONFIG_KASAN_GENERIC)) {
-		kunit_info(test, "CONFIG_KASAN_GENERIC required");
+		kunit_info(test, "skipping, CONFIG_KASAN_GENERIC required");
 		return;
 	}
 
 	if (!IS_ENABLED(CONFIG_KASAN_STACK)) {
-		kunit_info(test, "CONFIG_KASAN_STACK is not enabled");
+		kunit_info(test, "skipping, CONFIG_KASAN_STACK required");
 		return;
 	}
 
@@ -518,12 +522,12 @@ static void kasan_alloca_oob_right(struct kunit *test)
 
 	/* Only generic mode instruments dynamic allocas. */
 	if (!IS_ENABLED(CONFIG_KASAN_GENERIC)) {
-		kunit_info(test, "CONFIG_KASAN_GENERIC required");
+		kunit_info(test, "skipping, CONFIG_KASAN_GENERIC required");
 		return;
 	}
 
 	if (!IS_ENABLED(CONFIG_KASAN_STACK)) {
-		kunit_info(test, "CONFIG_KASAN_STACK is not enabled");
+		kunit_info(test, "skipping, CONFIG_KASAN_STACK required");
 		return;
 	}
 
@@ -568,7 +572,7 @@ static void kmem_cache_invalid_free(struct kunit *test)
 		return;
 	}
 
-	/* Trigger invalid free, the object doesn't get freed */
+	/* Trigger invalid free, the object doesn't get freed. */
 	KUNIT_EXPECT_KASAN_FAIL(test, kmem_cache_free(cache, p + 1));
 
 	/*
@@ -585,10 +589,12 @@ static void kasan_memchr(struct kunit *test)
 	char *ptr;
 	size_t size = 24;
 
-	/* See https://bugzilla.kernel.org/show_bug.cgi?id=206337 */
+	/*
+	 * str* functions are not instrumented with CONFIG_AMD_MEM_ENCRYPT.
+	 * See https://bugzilla.kernel.org/show_bug.cgi?id=206337 for details.
+	 */
 	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
-		kunit_info(test,
-			"str* functions are not instrumented with CONFIG_AMD_MEM_ENCRYPT");
+		kunit_info(test, "skipping, CONFIG_AMD_MEM_ENCRYPT enabled");
 		return;
 	}
 
@@ -610,10 +616,12 @@ static void kasan_memcmp(struct kunit *test)
 	size_t size = 24;
 	int arr[9];
 
-	/* See https://bugzilla.kernel.org/show_bug.cgi?id=206337 */
+	/*
+	 * str* functions are not instrumented with CONFIG_AMD_MEM_ENCRYPT.
+	 * See https://bugzilla.kernel.org/show_bug.cgi?id=206337 for details.
+	 */
 	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
-		kunit_info(test,
-			"str* functions are not instrumented with CONFIG_AMD_MEM_ENCRYPT");
+		kunit_info(test, "skipping, CONFIG_AMD_MEM_ENCRYPT enabled");
 		return;
 	}
 
@@ -634,10 +642,12 @@ static void kasan_strings(struct kunit *test)
 	char *ptr;
 	size_t size = 24;
 
-	/* See https://bugzilla.kernel.org/show_bug.cgi?id=206337 */
+	/*
+	 * str* functions are not instrumented with CONFIG_AMD_MEM_ENCRYPT.
+	 * See https://bugzilla.kernel.org/show_bug.cgi?id=206337 for details.
+	 */
 	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
-		kunit_info(test,
-			"str* functions are not instrumented with CONFIG_AMD_MEM_ENCRYPT");
+		kunit_info(test, "skipping, CONFIG_AMD_MEM_ENCRYPT enabled");
 		return;
 	}
 
@@ -701,12 +711,12 @@ static void kasan_bitops_generic(struct kunit *test)
 
 	/* This test is specifically crafted for the generic mode. */
 	if (!IS_ENABLED(CONFIG_KASAN_GENERIC)) {
-		kunit_info(test, "CONFIG_KASAN_GENERIC required\n");
+		kunit_info(test, "skipping, CONFIG_KASAN_GENERIC required");
 		return;
 	}
 
 	/*
-	 * Allocate 1 more byte, which causes kzalloc to round up to 16-bytes;
+	 * Allocate 1 more byte, which causes kzalloc to round up to 16 bytes;
 	 * this way we do not actually corrupt other memory.
 	 */
 	bits = kzalloc(sizeof(*bits) + 1, GFP_KERNEL);
@@ -733,7 +743,7 @@ static void kasan_bitops_tags(struct kunit *test)
 
 	/* This test is specifically crafted for the tag-based mode. */
 	if (IS_ENABLED(CONFIG_KASAN_GENERIC)) {
-		kunit_info(test, "CONFIG_KASAN_SW_TAGS required\n");
+		kunit_info(test, "skipping, CONFIG_KASAN_SW_TAGS required");
 		return;
 	}
 
@@ -765,7 +775,7 @@ static void vmalloc_oob(struct kunit *test)
 	void *area;
 
 	if (!IS_ENABLED(CONFIG_KASAN_VMALLOC)) {
-		kunit_info(test, "CONFIG_KASAN_VMALLOC is not enabled.");
+		kunit_info(test, "skipping, CONFIG_KASAN_VMALLOC required");
 		return;
 	}
 
diff --git a/lib/test_kasan_module.c b/lib/test_kasan_module.c
index 3b4cc77992d2..eee017ff8980 100644
--- a/lib/test_kasan_module.c
+++ b/lib/test_kasan_module.c
@@ -123,8 +123,9 @@ static noinline void __init kasan_workqueue_uaf(void)
 static int __init test_kasan_module_init(void)
 {
 	/*
-	 * Temporarily enable multi-shot mode. Otherwise, we'd only get a
-	 * report for the first case.
+	 * Temporarily enable multi-shot mode. Otherwise, KASAN would only
+	 * report the first detected bug and panic the kernel if panic_on_warn
+	 * is enabled.
 	 */
 	bool multishot = kasan_save_enable_multi_shot();
 
-- 
2.29.2.729.g45daf8777d-goog

