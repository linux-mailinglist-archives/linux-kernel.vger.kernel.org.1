Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 426902EB29C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 19:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730605AbhAES3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 13:29:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730486AbhAES3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 13:29:32 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48689C0617A5
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 10:28:32 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id u3so174317wri.19
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 10:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=oRho7+sQYL8W8g66lzn3SO+/RCe3iCmUxBQsmdc55nY=;
        b=VubKJ4tGao6rr39K7dEx8xeHG8th8u0W76NMnX2RgStyrhptBxDAuVLL2jUWFyKyVb
         CiSab5ZOJMH+oUNih6ugHcAhtNgXlG0WH8r9T70W+LSBjDC/g6VgoyvGP4teEnJffBYA
         9vUy5dDJA+86MKvcD0pZN9HyN3Fx+zmW6tD8wvH+/oBohedPUCQSeH8UBzRaLjscXver
         3z2flUWE3gPwKy6z5TQ3zusM3e3GepNs/zVftxGPm6lCwhtemL+D3Q6Y/obzjMmWhSVp
         4DFFpbjNizMfHnG/4zp4JX6aflPp8f0lzJSigNmUK8b9By/StVB2BOou2FiQ9VY1M0LC
         k34A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oRho7+sQYL8W8g66lzn3SO+/RCe3iCmUxBQsmdc55nY=;
        b=U/WWkuyxmlGajQp63+W5GJZuG1Uvh/bJ8hhY54i5ZMc6+yw6H+SwU1OuDeoyiJZEOd
         SwE/SJtfvF3/kuE8AL3EygPPzazoa+F7qfOOVWLsUvHjnyY5Kt4OV9qEC8ALTvQPdyrG
         NTh0M/q8yn+hAWWPXgGk897T0Gl8JxqpuQ4ZCuTO9trz+xPLg2MLTgnYFWqLUm9Ibgvg
         pRysInFmlTbcKE4QZg56XxhX9iULJTxwdtVa7FM+VBvdjHK7xkhreslG2AhzAXlYpfDd
         ZvL0NhlTscAjMkF6B+j6QX7GxDuQ1U71amk1gAH9q90CBb2JPUKaKKhRIyMuB6rJGSKT
         iQbQ==
X-Gm-Message-State: AOAM532LE+a63j7Mdhc0dLHxj9LbTcQXoz1K8wvtc4WZNurPr2VIC5tK
        f/NpBQ2AcqIcXSN/C50/eE9cv95k3UxUTlK4
X-Google-Smtp-Source: ABdhPJxoWEP6BJ1reenr7C4SoK8UHxtinLKxkeHYeahf+7ie4bLyMFrFVqrKacmxVO7J7mnxTF4jJg0mL8c0//vU
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:adf:9b98:: with SMTP id
 d24mr846317wrc.240.1609871311014; Tue, 05 Jan 2021 10:28:31 -0800 (PST)
Date:   Tue,  5 Jan 2021 19:27:55 +0100
In-Reply-To: <cover.1609871239.git.andreyknvl@google.com>
Message-Id: <15ca1976b26aa9edcec4a9d0f3b73f5b6536e5d0.1609871239.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1609871239.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [PATCH 11/11] kasan: add proper page allocator tests
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

The currently existing page allocator tests rely on kmalloc fallback
with large sizes that is only present for SLUB. Add proper tests that
use alloc/free_pages().

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Link: https://linux-review.googlesource.com/id/Ia173d5a1b215fe6b2548d814ef0f4433cf983570
---
 lib/test_kasan.c | 54 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 49 insertions(+), 5 deletions(-)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index 6261521e57ad..24798c034d05 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -128,6 +128,12 @@ static void kmalloc_node_oob_right(struct kunit *test)
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
@@ -138,14 +144,11 @@ static void kmalloc_pagealloc_oob_right(struct kunit *test)
 		return;
 	}
 
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
 
@@ -161,8 +164,8 @@ static void kmalloc_pagealloc_uaf(struct kunit *test)
 
 	ptr = kmalloc(size, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
-
 	kfree(ptr);
+
 	KUNIT_EXPECT_KASAN_FAIL(test, ptr[0] = 0);
 }
 
@@ -182,6 +185,45 @@ static void kmalloc_pagealloc_invalid_free(struct kunit *test)
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
+	if (IS_ENABLED(CONFIG_KASAN_GENERIC)) {
+		kunit_info(test, "skipping, CONFIG_KASAN_GENERIC enabled");
+		return;
+	}
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
@@ -933,6 +975,8 @@ static struct kunit_case kasan_kunit_test_cases[] = {
 	KUNIT_CASE(kmalloc_pagealloc_oob_right),
 	KUNIT_CASE(kmalloc_pagealloc_uaf),
 	KUNIT_CASE(kmalloc_pagealloc_invalid_free),
+	KUNIT_CASE(pagealloc_oob_right),
+	KUNIT_CASE(pagealloc_uaf),
 	KUNIT_CASE(kmalloc_large_oob_right),
 	KUNIT_CASE(kmalloc_oob_krealloc_more),
 	KUNIT_CASE(kmalloc_oob_krealloc_less),
-- 
2.29.2.729.g45daf8777d-goog

