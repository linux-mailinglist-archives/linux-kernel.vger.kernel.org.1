Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B999F290C53
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 21:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411081AbgJPTdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 15:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408463AbgJPTdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 15:33:38 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4814C061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 12:33:37 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id i9so1040539wml.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 12:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=0xkOIUrMlpfAxYo59kbuN09qneusLJjvCEfygqYyq5g=;
        b=YoWrrTqMR6FGVWYf9vxSc/bJ6pym6/saitpcXWksTRu1sE3OgyzHfdmX8MSy7pxGeC
         ifeT/3X8PF2eq9IXs1ySvL/ITXLdD36eGLV5cyBtbzL3fdoBh/4RKOQRUEcNagbNR5f5
         +3WhUVoryedtqTOzts5OAAMXaH9A++3CG2yjMfxfwvkjeKFdjhXjNfZgZPL6ReQdlgAp
         rk7ouTKehCEpO/rIQpQYJKWOScv6XSsQJtNzYxub0Dzzrn1h5gv7pjhOPjexxo0i0+Lh
         0qnQLkCMU+8BnAFOO7jYHPmOQyexTD0uZ2Ya2qU9iNOfg7Zu9fWoEWwId6GzwjfF66ZS
         qiaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=0xkOIUrMlpfAxYo59kbuN09qneusLJjvCEfygqYyq5g=;
        b=OFhiWCfL4itFaiSBAX4G1yg1G7Mkm1iWCXpacOWE0LHaW81jiKP1u3pydnT50oyAXX
         Cf+0E9FfANUpag44l/QgIMiWRo6KZYg9R+QNhTn49A8cZwsgMjJHmt9qh56+lJc5g3+3
         eGynxF+jRCOl14D2//9uchcHyrVgU55mPBxUsp+tCfuXhUlQl3exss5VS4FwQBTUsoVe
         OY6ND2K+4bN6IqncmKXuqJRNfFVEMu9M6XmtYOHEfBR1LK75rgoOC830bw3N/oEqgoL4
         GlKLPUc81+Jbis2XrRvLa9cEMjs3jpz76UsE++dH0y4r99nTd6n6N2i45rnyUpVPZJ0/
         WYTw==
X-Gm-Message-State: AOAM530QW4MvVAJZ9anXOGNM+rxKflrK6Qcbp5M0FKkRqJTD/UTj7c31
        3LzxukLgO5pkH7eT89w/FEkgZ+I9vEmGYoEF
X-Google-Smtp-Source: ABdhPJyPBIuS0bew93qU9jvTH/zkjUImvynyXNbeHOFcvhDuyBPWoiqjKIrjCIfnq9yqL9zBgONHjQPM/2thkExW
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:adf:f1c1:: with SMTP id
 z1mr5753170wro.331.1602876816443; Fri, 16 Oct 2020 12:33:36 -0700 (PDT)
Date:   Fri, 16 Oct 2020 21:33:30 +0200
Message-Id: <44861eaca17ffbb51726473bc8e86ad9e130c67e.1602876780.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH] kasan: adopt KUNIT tests to SW_TAGS mode
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        David Gow <davidgow@google.com>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have KASAN-KUNIT tests integration, it's easy to see that
some KASAN tests are not adopted to the SW_TAGS mode and are failing.

Adjust the allocation size for kasan_memchr() and kasan_memcmp() by
roung it up to OOB_TAG_OFF so the bad access ends up in a separate
memory granule.

Add new kmalloc_uaf_16() and kasan_bitops_uaf() tests that rely on UAFs,
as it's hard to adopt the existing kmalloc_oob_16() and kasan_bitops_oob()
(rename from kasan_bitops()) without losing the precision.

Disable kasan_global_oob() and kasan_alloca_oob_left/right() as SW_TAGS
mode doesn't instrument globals nor dynamic allocas.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/test_kasan.c | 144 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 99 insertions(+), 45 deletions(-)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index 63c26171a791..3bff25a7fdcc 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -216,6 +216,12 @@ static void kmalloc_oob_16(struct kunit *test)
 		u64 words[2];
 	} *ptr1, *ptr2;
 
+	/* This test is specifically crafted for the generic mode. */
+	if (!IS_ENABLED(CONFIG_KASAN_GENERIC)) {
+		kunit_info(test, "CONFIG_KASAN_GENERIC required\n");
+		return;
+	}
+
 	ptr1 = kmalloc(sizeof(*ptr1) - 3, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr1);
 
@@ -227,6 +233,23 @@ static void kmalloc_oob_16(struct kunit *test)
 	kfree(ptr2);
 }
 
+static void kmalloc_uaf_16(struct kunit *test)
+{
+	struct {
+		u64 words[2];
+	} *ptr1, *ptr2;
+
+	ptr1 = kmalloc(sizeof(*ptr1), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr1);
+
+	ptr2 = kmalloc(sizeof(*ptr2), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr2);
+	kfree(ptr2);
+
+	KUNIT_EXPECT_KASAN_FAIL(test, *ptr1 = *ptr2);
+	kfree(ptr1);
+}
+
 static void kmalloc_oob_memset_2(struct kunit *test)
 {
 	char *ptr;
@@ -429,6 +452,12 @@ static void kasan_global_oob(struct kunit *test)
 	volatile int i = 3;
 	char *p = &global_array[ARRAY_SIZE(global_array) + i];
 
+	/* Only generic mode instruments globals. */
+	if (!IS_ENABLED(CONFIG_KASAN_GENERIC)) {
+		kunit_info(test, "CONFIG_KASAN_GENERIC required");
+		return;
+	}
+
 	KUNIT_EXPECT_KASAN_FAIL(test, *(volatile char *)p);
 }
 
@@ -467,6 +496,12 @@ static void kasan_alloca_oob_left(struct kunit *test)
 	char alloca_array[i];
 	char *p = alloca_array - 1;
 
+	/* Only generic mode instruments dynamic allocas. */
+	if (!IS_ENABLED(CONFIG_KASAN_GENERIC)) {
+		kunit_info(test, "CONFIG_KASAN_GENERIC required");
+		return;
+	}
+
 	if (!IS_ENABLED(CONFIG_KASAN_STACK)) {
 		kunit_info(test, "CONFIG_KASAN_STACK is not enabled");
 		return;
@@ -481,6 +516,12 @@ static void kasan_alloca_oob_right(struct kunit *test)
 	char alloca_array[i];
 	char *p = alloca_array + i;
 
+	/* Only generic mode instruments dynamic allocas. */
+	if (!IS_ENABLED(CONFIG_KASAN_GENERIC)) {
+		kunit_info(test, "CONFIG_KASAN_GENERIC required");
+		return;
+	}
+
 	if (!IS_ENABLED(CONFIG_KASAN_STACK)) {
 		kunit_info(test, "CONFIG_KASAN_STACK is not enabled");
 		return;
@@ -551,6 +592,9 @@ static void kasan_memchr(struct kunit *test)
 		return;
 	}
 
+	if (OOB_TAG_OFF)
+		size = round_up(size, OOB_TAG_OFF);
+
 	ptr = kmalloc(size, GFP_KERNEL | __GFP_ZERO);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 
@@ -573,6 +617,9 @@ static void kasan_memcmp(struct kunit *test)
 		return;
 	}
 
+	if (OOB_TAG_OFF)
+		size = round_up(size, OOB_TAG_OFF);
+
 	ptr = kmalloc(size, GFP_KERNEL | __GFP_ZERO);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 	memset(arr, 0, sizeof(arr));
@@ -619,13 +666,50 @@ static void kasan_strings(struct kunit *test)
 	KUNIT_EXPECT_KASAN_FAIL(test, kasan_int_result = strnlen(ptr, 1));
 }
 
-static void kasan_bitops(struct kunit *test)
+static void kasan_bitops_modify(struct kunit *test, int nr, void *addr)
+{
+	KUNIT_EXPECT_KASAN_FAIL(test, set_bit(nr, addr));
+	KUNIT_EXPECT_KASAN_FAIL(test, __set_bit(nr, addr));
+	KUNIT_EXPECT_KASAN_FAIL(test, clear_bit(nr, addr));
+	KUNIT_EXPECT_KASAN_FAIL(test, __clear_bit(nr, addr));
+	KUNIT_EXPECT_KASAN_FAIL(test, clear_bit_unlock(nr, addr));
+	KUNIT_EXPECT_KASAN_FAIL(test, __clear_bit_unlock(nr, addr));
+	KUNIT_EXPECT_KASAN_FAIL(test, change_bit(nr, addr));
+	KUNIT_EXPECT_KASAN_FAIL(test, __change_bit(nr, addr));
+}
+
+static void kasan_bitops_test_and_modify(struct kunit *test, int nr, void *addr)
 {
+	KUNIT_EXPECT_KASAN_FAIL(test, test_and_set_bit(nr, addr));
+	KUNIT_EXPECT_KASAN_FAIL(test, __test_and_set_bit(nr, addr));
+	KUNIT_EXPECT_KASAN_FAIL(test, test_and_set_bit_lock(nr, addr));
+	KUNIT_EXPECT_KASAN_FAIL(test, test_and_clear_bit(nr, addr));
+	KUNIT_EXPECT_KASAN_FAIL(test, __test_and_clear_bit(nr, addr));
+	KUNIT_EXPECT_KASAN_FAIL(test, test_and_change_bit(nr, addr));
+	KUNIT_EXPECT_KASAN_FAIL(test, __test_and_change_bit(nr, addr));
+	KUNIT_EXPECT_KASAN_FAIL(test, kasan_int_result = test_bit(nr, addr));
+
+#if defined(clear_bit_unlock_is_negative_byte)
+	KUNIT_EXPECT_KASAN_FAIL(test, kasan_int_result =
+				clear_bit_unlock_is_negative_byte(nr, addr));
+#endif
+}
+
+static void kasan_bitops_oob(struct kunit *test)
+{
+	long *bits;
+
+	/* This test is specifically crafted for the generic mode. */
+	if (!IS_ENABLED(CONFIG_KASAN_GENERIC)) {
+		kunit_info(test, "CONFIG_KASAN_GENERIC required\n");
+		return;
+	}
+
 	/*
 	 * Allocate 1 more byte, which causes kzalloc to round up to 16-bytes;
 	 * this way we do not actually corrupt other memory.
 	 */
-	long *bits = kzalloc(sizeof(*bits) + 1, GFP_KERNEL);
+	bits = kzalloc(sizeof(*bits) + 1, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, bits);
 
 	/*
@@ -633,56 +717,24 @@ static void kasan_bitops(struct kunit *test)
 	 * below accesses are still out-of-bounds, since bitops are defined to
 	 * operate on the whole long the bit is in.
 	 */
-	KUNIT_EXPECT_KASAN_FAIL(test, set_bit(BITS_PER_LONG, bits));
-
-	KUNIT_EXPECT_KASAN_FAIL(test, __set_bit(BITS_PER_LONG, bits));
-
-	KUNIT_EXPECT_KASAN_FAIL(test, clear_bit(BITS_PER_LONG, bits));
-
-	KUNIT_EXPECT_KASAN_FAIL(test, __clear_bit(BITS_PER_LONG, bits));
-
-	KUNIT_EXPECT_KASAN_FAIL(test, clear_bit_unlock(BITS_PER_LONG, bits));
-
-	KUNIT_EXPECT_KASAN_FAIL(test, __clear_bit_unlock(BITS_PER_LONG, bits));
-
-	KUNIT_EXPECT_KASAN_FAIL(test, change_bit(BITS_PER_LONG, bits));
-
-	KUNIT_EXPECT_KASAN_FAIL(test, __change_bit(BITS_PER_LONG, bits));
+	kasan_bitops_modify(test, BITS_PER_LONG, bits);
 
 	/*
 	 * Below calls try to access bit beyond allocated memory.
 	 */
-	KUNIT_EXPECT_KASAN_FAIL(test,
-		test_and_set_bit(BITS_PER_LONG + BITS_PER_BYTE, bits));
-
-	KUNIT_EXPECT_KASAN_FAIL(test,
-		__test_and_set_bit(BITS_PER_LONG + BITS_PER_BYTE, bits));
+	kasan_bitops_test_and_modify(test, BITS_PER_LONG + BITS_PER_BYTE, bits);
 
-	KUNIT_EXPECT_KASAN_FAIL(test,
-		test_and_set_bit_lock(BITS_PER_LONG + BITS_PER_BYTE, bits));
-
-	KUNIT_EXPECT_KASAN_FAIL(test,
-		test_and_clear_bit(BITS_PER_LONG + BITS_PER_BYTE, bits));
-
-	KUNIT_EXPECT_KASAN_FAIL(test,
-		__test_and_clear_bit(BITS_PER_LONG + BITS_PER_BYTE, bits));
-
-	KUNIT_EXPECT_KASAN_FAIL(test,
-		test_and_change_bit(BITS_PER_LONG + BITS_PER_BYTE, bits));
-
-	KUNIT_EXPECT_KASAN_FAIL(test,
-		__test_and_change_bit(BITS_PER_LONG + BITS_PER_BYTE, bits));
+	kfree(bits);
+}
 
-	KUNIT_EXPECT_KASAN_FAIL(test,
-		kasan_int_result =
-			test_bit(BITS_PER_LONG + BITS_PER_BYTE, bits));
+static void kasan_bitops_uaf(struct kunit *test)
+{
+	long *bits = kzalloc(sizeof(*bits), GFP_KERNEL);
 
-#if defined(clear_bit_unlock_is_negative_byte)
-	KUNIT_EXPECT_KASAN_FAIL(test,
-		kasan_int_result = clear_bit_unlock_is_negative_byte(
-			BITS_PER_LONG + BITS_PER_BYTE, bits));
-#endif
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, bits);
 	kfree(bits);
+	kasan_bitops_modify(test, BITS_PER_LONG, bits);
+	kasan_bitops_test_and_modify(test, BITS_PER_LONG + BITS_PER_BYTE, bits);
 }
 
 static void kmalloc_double_kzfree(struct kunit *test)
@@ -728,6 +780,7 @@ static struct kunit_case kasan_kunit_test_cases[] = {
 	KUNIT_CASE(kmalloc_oob_krealloc_more),
 	KUNIT_CASE(kmalloc_oob_krealloc_less),
 	KUNIT_CASE(kmalloc_oob_16),
+	KUNIT_CASE(kmalloc_uaf_16),
 	KUNIT_CASE(kmalloc_oob_in_memset),
 	KUNIT_CASE(kmalloc_oob_memset_2),
 	KUNIT_CASE(kmalloc_oob_memset_4),
@@ -751,7 +804,8 @@ static struct kunit_case kasan_kunit_test_cases[] = {
 	KUNIT_CASE(kasan_memchr),
 	KUNIT_CASE(kasan_memcmp),
 	KUNIT_CASE(kasan_strings),
-	KUNIT_CASE(kasan_bitops),
+	KUNIT_CASE(kasan_bitops_oob),
+	KUNIT_CASE(kasan_bitops_uaf),
 	KUNIT_CASE(kmalloc_double_kzfree),
 	KUNIT_CASE(vmalloc_oob),
 	{}
-- 
2.29.0.rc1.297.gfa9743e501-goog

