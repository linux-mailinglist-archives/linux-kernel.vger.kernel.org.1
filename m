Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3A42F8311
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733104AbhAORyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:54:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728698AbhAORyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:54:21 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4381C061796
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:53:12 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id b8so4462815wrv.14
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=jfWJXOWlHJo7EltzDAfS0s8ib651kGruxNglu567YtE=;
        b=UpDZIP6xR7ghSKnhzK0eRNfsLeyL8ZfbfdrS0ZbiXAREa4/3evrQBC1aIzqQ9uPRaK
         vVDx5+guFDF2M60tFhWxTC1woCdY3Ezi3z80HIkXlN5A4QRMNh+us9qm3WvBz4r9xUAX
         vEAGJhsJXcf8yq/65SZe1JFLuzjSlkMBF9WzIOAjE8C/oevNO9sxdMzCxd5wddJ/kDN+
         9t+r4P24kGbGCAeo2xPmV1rZqyp078zmHZoPN+wLHN40Pe0Nxa6wDDbvBnCBuiIPX3nz
         8SPXVztg5pBePTNl2c0MLwzMTfKqUuDsyxcShY8oKJqSH+0VXX9dD8lLPltgiEwTTtmt
         yBvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jfWJXOWlHJo7EltzDAfS0s8ib651kGruxNglu567YtE=;
        b=HIBeOxs2fhDtreOFst8f5NSk49pG5PGsAJCM9FI0d9jHitxToGd6y8sqXODD77cnlT
         QB6TSQ321q8O7bm+krb1agKUS01fdxDgVz/8tqjUN5NrOoxfQ8CO8IGE8rPV4I8uyCWZ
         weaHyOG3AFc8SqpBVLnBuKbIr80AejgqRWcyTSaS+E3WtX3YDYvDzGd4Jd0Z0z7NGFyM
         c22vtEfTO/ner9C6aF6NRmo4xwcnxLzCo+6Pu3V0tNgx/RGaJdOrpoWilzVskAsmevuz
         GlFZYad/7LbFgcy4YYw3GwloRLxgrWzhimpDb5q24nD3Wp9W/s8kRS1Rxua6o3327s8V
         LdaA==
X-Gm-Message-State: AOAM531GSUOwpnvZ87yBJ53eDEHkdcJv9vlmRu14z/t8Cjq9RfkjR+mk
        wdFxMeFZuNM66AWrvJ5Bw4suglKxbWsVOspZ
X-Google-Smtp-Source: ABdhPJyTX+oi4bC453jP1Oba8mmIO/be705slN5QNgbNBVtZKN7OlSl3vgP/jlwXwIICnGDefo9UkGtGOwwhdtkR
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a1c:e919:: with SMTP id
 q25mr2033205wmc.57.1610733191375; Fri, 15 Jan 2021 09:53:11 -0800 (PST)
Date:   Fri, 15 Jan 2021 18:52:42 +0100
In-Reply-To: <cover.1610733117.git.andreyknvl@google.com>
Message-Id: <da841a5408e2204bf25f3b23f70540a65844e8a4.1610733117.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1610733117.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v4 05/15] kasan: add match-all tag tests
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
Reviewed-by: Alexander Potapenko <glider@google.com>
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

