Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA7602F4FDD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 17:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbhAMQWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 11:22:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbhAMQWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 11:22:35 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04ACC061795
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 08:21:54 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id b8so1181841wrv.14
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 08:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=m6xusvsokM0PWzPtRFY43dxv0DbWG+gsyZsDZx85iWg=;
        b=oIZpxTscmzWNn6FCdK0QAMEb22GI8TtyGOSGYp0n9CCiJsPBVaS88difbiciw2Y/WA
         ll5wL0LrrITPb7IsDp6lk4BhoYUX7XC4JEBntwtKkumgvD4lDnPRRlyGxtXNDin/htC4
         WS84mFmlyahT5AR+NGIWNl2yA9pj85zk/jqZul/99RhfROiS8Z+sFZbs3dWsZjcb+eMX
         EQT9+/tAoTnv9tblI+CRR9ba2rO+yB3gScfPu4MeABpZyuuoGnUj6ymZT/hwOOTAzwwu
         zROA1X9gInEn71Ef5S/DouuF0FyHRQy8EgQmpuV1WLSWstqvvipbKpb8GkhBdAeDAR6h
         8+Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=m6xusvsokM0PWzPtRFY43dxv0DbWG+gsyZsDZx85iWg=;
        b=TKDVmdCKqnH1EUZWPuUTzfRKR3xQ10szM4MuADvKJGSIaFW+W6/8s6VXL/JK9+yoa1
         /r23XecgPW27NAQmY4N3IKG+y8vSbxtjVG67Qpd5QbaZTbOVIhXk+jOeihuilKbRLsw9
         BjJJA9dIbcpk7r+iU1XCASCy7+Era1cXlo7WIv3tJtza8eo71R5zpfw5D7WmWxOw5iTM
         lSweWkklSqyIKjxbqKXwahm54U12/clv5nbbfevm0WQFYDOdU9uGMtb11ThfVljXuRvl
         QA+ihlhRaIdTd0Mzpe6xuujc4wCgKX3Dn++1c+0TbPTaP/Uvi6t0yOT4cMn1fcvwgeGe
         tccA==
X-Gm-Message-State: AOAM53365eMhO67nXkVGOfgo+qituVsSsrb0Wy8vPuJsnNAjQkXfDvJi
        YJZz/Hj5JBl7/txUC/pu4gVhN5XANs+/BcZw
X-Google-Smtp-Source: ABdhPJxarFcYjl7xb1/SRC825R68ZOFC+U25rfLA2+9VuJbqvx76lMLxU2yiun2kPDZt20pEdQ2iKQIZgc/jbIUL
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a05:600c:4154:: with SMTP id
 h20mr66423wmm.72.1610554913410; Wed, 13 Jan 2021 08:21:53 -0800 (PST)
Date:   Wed, 13 Jan 2021 17:21:30 +0100
In-Reply-To: <cover.1610554432.git.andreyknvl@google.com>
Message-Id: <2b43049e25dcd04850ba6c205cd6dcc7caa4a886.1610554432.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1610554432.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v2 03/14] kasan: clean up comments in tests
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
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

Clarify and update comments in KASAN tests.

Link: https://linux-review.googlesource.com/id/I6c816c51fa1e0eb7aa3dead6bda1f339d2af46c8
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/test_kasan.c        | 59 +++++++++++++++++++++++++----------------
 lib/test_kasan_module.c |  5 ++--
 2 files changed, 39 insertions(+), 25 deletions(-)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index 2947274cc2d3..6f46e27c2af7 100644
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
@@ -121,7 +119,8 @@ static void kmalloc_pagealloc_oob_right(struct kunit *test)
 		return;
 	}
 
-	/* Allocate a chunk that does not fit into a SLUB cache to trigger
+	/*
+	 * Allocate a chunk that does not fit into a SLUB cache to trigger
 	 * the page allocator fallback.
 	 */
 	ptr = kmalloc(size, GFP_KERNEL);
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
 
@@ -568,7 +572,7 @@ static void kmem_cache_invalid_free(struct kunit *test)
 		return;
 	}
 
-	/* Trigger invalid free, the object doesn't get freed */
+	/* Trigger invalid free, the object doesn't get freed. */
 	KUNIT_EXPECT_KASAN_FAIL(test, kmem_cache_free(cache, p + 1));
 
 	/*
@@ -585,7 +589,10 @@ static void kasan_memchr(struct kunit *test)
 	char *ptr;
 	size_t size = 24;
 
-	/* See https://bugzilla.kernel.org/show_bug.cgi?id=206337 */
+	/*
+	 * str* functions are not instrumented with CONFIG_AMD_MEM_ENCRYPT.
+	 * See https://bugzilla.kernel.org/show_bug.cgi?id=206337 for details.
+	 */
 	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
 		kunit_info(test,
 			"str* functions are not instrumented with CONFIG_AMD_MEM_ENCRYPT");
@@ -610,7 +617,10 @@ static void kasan_memcmp(struct kunit *test)
 	size_t size = 24;
 	int arr[9];
 
-	/* See https://bugzilla.kernel.org/show_bug.cgi?id=206337 */
+	/*
+	 * str* functions are not instrumented with CONFIG_AMD_MEM_ENCRYPT.
+	 * See https://bugzilla.kernel.org/show_bug.cgi?id=206337 for details.
+	 */
 	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
 		kunit_info(test,
 			"str* functions are not instrumented with CONFIG_AMD_MEM_ENCRYPT");
@@ -634,7 +644,10 @@ static void kasan_strings(struct kunit *test)
 	char *ptr;
 	size_t size = 24;
 
-	/* See https://bugzilla.kernel.org/show_bug.cgi?id=206337 */
+	/*
+	 * str* functions are not instrumented with CONFIG_AMD_MEM_ENCRYPT.
+	 * See https://bugzilla.kernel.org/show_bug.cgi?id=206337 for details.
+	 */
 	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
 		kunit_info(test,
 			"str* functions are not instrumented with CONFIG_AMD_MEM_ENCRYPT");
@@ -706,7 +719,7 @@ static void kasan_bitops_generic(struct kunit *test)
 	}
 
 	/*
-	 * Allocate 1 more byte, which causes kzalloc to round up to 16-bytes;
+	 * Allocate 1 more byte, which causes kzalloc to round up to 16 bytes;
 	 * this way we do not actually corrupt other memory.
 	 */
 	bits = kzalloc(sizeof(*bits) + 1, GFP_KERNEL);
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
2.30.0.284.gd98b1dd5eaa7-goog

