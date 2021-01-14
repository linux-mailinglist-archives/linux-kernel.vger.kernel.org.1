Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC262F6B2D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 20:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730102AbhANTh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 14:37:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730045AbhANTh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 14:37:27 -0500
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5F2C0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 11:36:47 -0800 (PST)
Received: by mail-ed1-x54a.google.com with SMTP id m16so2777753edd.21
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 11:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=An8QbssU3Paiod4E1kUAdvkgOfXtx5Y6R0zbziTz4iI=;
        b=XqPiQtw9YQSKwfBHug0K7Gx2aQSpRU67NFdlNj1GL3DMONyjFiF08+yYYrndtRlMdv
         a7pv5IyeZNjlG90DrKDpNS+TkaubuqxuTT6KePSEQiIfRLoyOkM0Q8cYErb4FuNtQg31
         8kM6qdsMd9il2Fo9qMED+1kCSmDoOns88Uie0oC5nqWLNWe5OVMLftc5DhnV6sLmc2cX
         D5lh/nS0//eM08oI947aXCnMxg2hMtcS9QlSq1d4DkD921Ydn6n0Ruqbigz9MMkLz+m2
         fG2OZumAae9BCmsIefvpcSwqV1PonJvsA/j1Q9hLqeAIp8UnOBQ6LT6EP8WGWZqj15Mb
         G/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=An8QbssU3Paiod4E1kUAdvkgOfXtx5Y6R0zbziTz4iI=;
        b=ue6dWFrzyW0YLB3qTvPDaLO5zgNFTOeBI6+TLsBuCuWIxtiXcRyPHGGrlkZFMWGrTr
         TK32IcbuvWYZGire7rx3UISQhlmWo4NbzZWwhimssfupzVkMci1jCkd4w+8ndAy6pIlb
         4LCOdi+dDaHMEf2I5Hn33EXlVUq4gcnxAoyXEKt+zS9CcX3sqMvxTd2yp9UhEEoZ+CTN
         kvQmJyxIHikaIsC/Rgu/raXvpRlDNxEGk+NZhcotNzyqcJahrXSfkeGJFbRy8bgIGX9d
         ZhS7HCUaZoaWzFkVncXVGzwHWQ+3S4u16kr2ZJRBCUtce8Gx/RhtcTDLKnfyDjRevK9Z
         GjLg==
X-Gm-Message-State: AOAM533TL4p4QotrKpx3Ku75/fwZc4Z8rJwUhoB5d8G0gU6rb3w3FLPN
        KQdRor+P1DZCgvXbcyspL+b584p2AsROlpqd
X-Google-Smtp-Source: ABdhPJyHKp/wtdv/7GBZwhEP0RQ9LzEgR2YxKDNd406EN/bdf9yI/02kXsTGoRQ44kcYA/LIsLz2ttRK02+QMqPG
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a17:906:3949:: with SMTP id
 g9mr6032701eje.493.1610653006118; Thu, 14 Jan 2021 11:36:46 -0800 (PST)
Date:   Thu, 14 Jan 2021 20:36:21 +0100
In-Reply-To: <cover.1610652890.git.andreyknvl@google.com>
Message-Id: <5153dafd6498a9183cfedaf267a2953defb6578e.1610652890.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1610652890.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v3 05/15] kasan: add match-all tag tests
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

Add 3 new tests for tag-based KASAN modes:

1. Check that match-all pointer tag is not assigned randomly.
2. Check that 0xff works as a match-all pointer tag.
3. Check that there are no match-all memory tags.

Note, that test #3 causes a significant number (255) of KASAN reports
to be printed during execution for the SW_TAGS mode.

Link: https://linux-review.googlesource.com/id/I78f1375efafa162b37f3abcb2c5bc2f3955dfd8e
Reviewed-by: Marco Elver <elver@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/test_kasan.c | 92 ++++++++++++++++++++++++++++++++++++++++++++++++
 mm/kasan/kasan.h |  6 ++++
 2 files changed, 98 insertions(+)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index 714ea27fcc3e..c344fe506ffc 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -13,6 +13,7 @@
 #include <linux/mman.h>
 #include <linux/module.h>
 #include <linux/printk.h>
+#include <linux/random.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/uaccess.h>
@@ -754,6 +755,94 @@ static void vmalloc_oob(struct kunit *test)
 	vfree(area);
 }
 
+/*
+ * Check that the assigned pointer tag falls within the [KASAN_TAG_MIN,
+ * KASAN_TAG_KERNEL) range (note: excluding the match-all tag) for tag-based
+ * modes.
+ */
+static void match_all_not_assigned(struct kunit *test)
+{
+	char *ptr;
+	struct page *pages;
+	int i, size, order;
+
+	KASAN_TEST_NEEDS_CONFIG_OFF(test, CONFIG_KASAN_GENERIC);
+
+	for (i = 0; i < 256; i++) {
+		size = (get_random_int() % 1024) + 1;
+		ptr = kmalloc(size, GFP_KERNEL);
+		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
+		KUNIT_EXPECT_GE(test, (u8)get_tag(ptr), (u8)KASAN_TAG_MIN);
+		KUNIT_EXPECT_LT(test, (u8)get_tag(ptr), (u8)KASAN_TAG_KERNEL);
+		kfree(ptr);
+	}
+
+	for (i = 0; i < 256; i++) {
+		order = (get_random_int() % 4) + 1;
+		pages = alloc_pages(GFP_KERNEL, order);
+		ptr = page_address(pages);
+		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
+		KUNIT_EXPECT_GE(test, (u8)get_tag(ptr), (u8)KASAN_TAG_MIN);
+		KUNIT_EXPECT_LT(test, (u8)get_tag(ptr), (u8)KASAN_TAG_KERNEL);
+		free_pages((unsigned long)ptr, order);
+	}
+}
+
+/* Check that 0xff works as a match-all pointer tag for tag-based modes. */
+static void match_all_ptr_tag(struct kunit *test)
+{
+	char *ptr;
+	u8 tag;
+
+	KASAN_TEST_NEEDS_CONFIG_OFF(test, CONFIG_KASAN_GENERIC);
+
+	ptr = kmalloc(128, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
+
+	/* Backup the assigned tag. */
+	tag = get_tag(ptr);
+	KUNIT_EXPECT_NE(test, tag, (u8)KASAN_TAG_KERNEL);
+
+	/* Reset the tag to 0xff.*/
+	ptr = set_tag(ptr, KASAN_TAG_KERNEL);
+
+	/* This access shouldn't trigger a KASAN report. */
+	*ptr = 0;
+
+	/* Recover the pointer tag and free. */
+	ptr = set_tag(ptr, tag);
+	kfree(ptr);
+}
+
+/* Check that there are no match-all memory tags for tag-based modes. */
+static void match_all_mem_tag(struct kunit *test)
+{
+	char *ptr;
+	int tag;
+
+	KASAN_TEST_NEEDS_CONFIG_OFF(test, CONFIG_KASAN_GENERIC);
+
+	ptr = kmalloc(128, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
+	KUNIT_EXPECT_NE(test, (u8)get_tag(ptr), (u8)KASAN_TAG_KERNEL);
+
+	/* For each possible tag value not matching the pointer tag. */
+	for (tag = KASAN_TAG_MIN; tag <= KASAN_TAG_KERNEL; tag++) {
+		if (tag == get_tag(ptr))
+			continue;
+
+		/* Mark the first memory granule with the chosen memory tag. */
+		kasan_poison(ptr, KASAN_GRANULE_SIZE, (u8)tag);
+
+		/* This access must cause a KASAN report. */
+		KUNIT_EXPECT_KASAN_FAIL(test, *ptr = 0);
+	}
+
+	/* Recover the memory tag and free. */
+	kasan_poison(ptr, KASAN_GRANULE_SIZE, get_tag(ptr));
+	kfree(ptr);
+}
+
 static struct kunit_case kasan_kunit_test_cases[] = {
 	KUNIT_CASE(kmalloc_oob_right),
 	KUNIT_CASE(kmalloc_oob_left),
@@ -793,6 +882,9 @@ static struct kunit_case kasan_kunit_test_cases[] = {
 	KUNIT_CASE(kasan_bitops_tags),
 	KUNIT_CASE(kmalloc_double_kzfree),
 	KUNIT_CASE(vmalloc_oob),
+	KUNIT_CASE(match_all_not_assigned),
+	KUNIT_CASE(match_all_ptr_tag),
+	KUNIT_CASE(match_all_mem_tag),
 	{}
 };
 
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 3b38baddec47..c3fb9bf241d3 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -36,6 +36,12 @@ extern bool kasan_flag_panic __ro_after_init;
 #define KASAN_TAG_INVALID	0xFE /* inaccessible memory tag */
 #define KASAN_TAG_MAX		0xFD /* maximum value for random tags */
 
+#ifdef CONFIG_KASAN_HW_TAGS
+#define KASAN_TAG_MIN		0xF0 /* mimimum value for random tags */
+#else
+#define KASAN_TAG_MIN		0x00 /* mimimum value for random tags */
+#endif
+
 #ifdef CONFIG_KASAN_GENERIC
 #define KASAN_FREE_PAGE         0xFF  /* page was freed */
 #define KASAN_PAGE_REDZONE      0xFE  /* redzone for kmalloc_large allocations */
-- 
2.30.0.284.gd98b1dd5eaa7-goog

