Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C89892F4FE6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 17:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbhAMQXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 11:23:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727776AbhAMQXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 11:23:15 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787F4C0617AA
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 08:22:17 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id r5so1030008wma.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 08:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=qQVzFZxhqiBzY9F1wdp+d+EdRYAfotcsjSYx9y4am/0=;
        b=BR5OmmjyR6sTYkY6yO/wiMj9obAVT5Qvv1Fag/2rpA2efyniv7YkbqqAhVzFjsRd3N
         XVbx3b1j7PqSVvUqSZHuUCZWsDoIwC26NGoYnX0Zbk7Yn09p6iVqeEstl0xwxsj0ldhK
         UVLdkpj2EOn3kjsOylI3WQo45ZSJBz82jiByaCu50NemoLylow9ZlA2RaG1sE7SP7056
         i9pLyzQU1YzVFyvOjaUpD8F5JAOZrzv0XK9Ys51vkP0eaYVBE8g6R/IQ9NzYMnrfssb4
         BGuYpiG+EXafCIrz7lPCgQHTxsEJkNh4ibiJM2BqJKWbujgEox/0v9TiSqmK4QFsAqGh
         yzFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qQVzFZxhqiBzY9F1wdp+d+EdRYAfotcsjSYx9y4am/0=;
        b=K/xRI69tjNE4R1J14qz3tdI8MHd3ROfyrD0GQ3ZRbnsDzsQb2Jahq5AI1obKEzlLDH
         O9GfugPn/4BL9IFZv2soV325QI+Azg5JW51jNUmcyjzS3FT9sYLUP0uH/0Fs9QmnPeSs
         j9Diw4ExtJcRDL8HvZg52xl5bC5tuJ1SDQpaFWmX2DqbTEvmMvcShRTTEV+pLW7pg8KR
         ZWxgB3ukrNCVKdbx/HB7edzhzE9zRVTzG4DV6RawRs2Fn9Te9bqCq3YD5Py+3Et5D3gv
         iSpBr7/PrHEkBf2AsMm6vlBThyFWgRoSYSaHpQFgOrlstC1IqxoH8DLPUChyMfz+1LZV
         OSJw==
X-Gm-Message-State: AOAM532Ij//6dis8k4iju2WBwV3Yj41Pn2joDYhqHDUppL5Tcjs/EDJh
        V4q7jZp6czvcp3w25+XQalAdEJU7uIlpzYrd
X-Google-Smtp-Source: ABdhPJzSKosgGLWyRiKWPdCCVC8Y1iQeq2wYpLHPbwSetVm0yj+8VcVFi5Ojpa3SzDGIXUgPVqRFY8BTble0U4Y1
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a5d:4f82:: with SMTP id
 d2mr3382368wru.87.1610554936199; Wed, 13 Jan 2021 08:22:16 -0800 (PST)
Date:   Wed, 13 Jan 2021 17:21:39 +0100
In-Reply-To: <cover.1610554432.git.andreyknvl@google.com>
Message-Id: <b7b0ca13a5a4d0d9d8b2fe88a9c3c154bb885294.1610554432.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1610554432.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v2 12/14] kasan: add proper page allocator tests
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

The currently existing page allocator tests rely on kmalloc fallback
with large sizes that is only present for SLUB. Add proper tests that
use alloc/free_pages().

Link: https://linux-review.googlesource.com/id/Ia173d5a1b215fe6b2548d814ef0f4433cf983570
Reviewed-by: Marco Elver <elver@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/test_kasan.c | 51 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 46 insertions(+), 5 deletions(-)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index 710e714dc0cb..5e3d054e5b8c 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -147,6 +147,12 @@ static void kmalloc_node_oob_right(struct kunit *test)
 	kfree(ptr);
 }
 
+/*
+ * These kmalloc_pagealloc_* tests try allocating a memory chunk that doesn't
+ * fit into a slab cache and therefore is allocated via the page allocator
+ * fallback. Since this kind of fallback is only implemented for SLUB, these
+ * tests are limited to that allocator.
+ */
 static void kmalloc_pagealloc_oob_right(struct kunit *test)
 {
 	char *ptr;
@@ -154,14 +160,11 @@ static void kmalloc_pagealloc_oob_right(struct kunit *test)
 
 	KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_SLUB);
 
-	/*
-	 * Allocate a chunk that does not fit into a SLUB cache to trigger
-	 * the page allocator fallback.
-	 */
 	ptr = kmalloc(size, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 
 	KUNIT_EXPECT_KASAN_FAIL(test, ptr[size + OOB_TAG_OFF] = 0);
+
 	kfree(ptr);
 }
 
@@ -174,8 +177,8 @@ static void kmalloc_pagealloc_uaf(struct kunit *test)
 
 	ptr = kmalloc(size, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
-
 	kfree(ptr);
+
 	KUNIT_EXPECT_KASAN_FAIL(test, ptr[0] = 0);
 }
 
@@ -192,6 +195,42 @@ static void kmalloc_pagealloc_invalid_free(struct kunit *test)
 	KUNIT_EXPECT_KASAN_FAIL(test, kfree(ptr + 1));
 }
 
+static void pagealloc_oob_right(struct kunit *test)
+{
+	char *ptr;
+	struct page *pages;
+	size_t order = 4;
+	size_t size = (1UL << (PAGE_SHIFT + order));
+
+	/*
+	 * With generic KASAN page allocations have no redzones, thus
+	 * out-of-bounds detection is not guaranteed.
+	 * See https://bugzilla.kernel.org/show_bug.cgi?id=210503.
+	 */
+	KASAN_TEST_NEEDS_CONFIG_OFF(test, CONFIG_KASAN_GENERIC);
+
+	pages = alloc_pages(GFP_KERNEL, order);
+	ptr = page_address(pages);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
+
+	KUNIT_EXPECT_KASAN_FAIL(test, ptr[size] = 0);
+	free_pages((unsigned long)ptr, order);
+}
+
+static void pagealloc_uaf(struct kunit *test)
+{
+	char *ptr;
+	struct page *pages;
+	size_t order = 4;
+
+	pages = alloc_pages(GFP_KERNEL, order);
+	ptr = page_address(pages);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
+	free_pages((unsigned long)ptr, order);
+
+	KUNIT_EXPECT_KASAN_FAIL(test, ptr[0] = 0);
+}
+
 static void kmalloc_large_oob_right(struct kunit *test)
 {
 	char *ptr;
@@ -903,6 +942,8 @@ static struct kunit_case kasan_kunit_test_cases[] = {
 	KUNIT_CASE(kmalloc_pagealloc_oob_right),
 	KUNIT_CASE(kmalloc_pagealloc_uaf),
 	KUNIT_CASE(kmalloc_pagealloc_invalid_free),
+	KUNIT_CASE(pagealloc_oob_right),
+	KUNIT_CASE(pagealloc_uaf),
 	KUNIT_CASE(kmalloc_large_oob_right),
 	KUNIT_CASE(kmalloc_oob_krealloc_more),
 	KUNIT_CASE(kmalloc_oob_krealloc_less),
-- 
2.30.0.284.gd98b1dd5eaa7-goog

