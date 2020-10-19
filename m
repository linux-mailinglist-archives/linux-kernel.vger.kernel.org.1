Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C871292D28
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 19:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729797AbgJSRx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 13:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbgJSRxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 13:53:24 -0400
Received: from mail-lj1-x24a.google.com (mail-lj1-x24a.google.com [IPv6:2a00:1450:4864:20::24a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA78C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 10:53:24 -0700 (PDT)
Received: by mail-lj1-x24a.google.com with SMTP id z8so127005lji.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 10:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=9+UDdS+l5mUdoefczQoyUzdbVQoDy0qQmASeL8V17TM=;
        b=HXsubSDIuJAPUazMbq59QO75beFg8so3lj42CiRQIHjH/FkdaEWoBtW/HrPPea7h5K
         N2aYNC1fAp1aL5YU98Hg/X8/al3aJqe2dFjmam5Be7b5yN/q1MsyHDphBXOQeJb/ZrG4
         D7z1xaAne2xJUjWVwSymeqTRWoP8IXS7KOMzv7aYXWQKSYaJrz1CdqGUsdu7JIhc1V05
         Tv43+2AYjDfRKuRwwQ22CMuu5cDqYDyNKHFR8cdcpzXtkW7yL+XfXP7n7OwLH3Q2nv+v
         EBOX/1R107RTJxm7+K35v6Aon6XlaEHCYaCJOcSmJAUXOYY7GfvaB4Aciola0gkSD2G5
         RlkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=9+UDdS+l5mUdoefczQoyUzdbVQoDy0qQmASeL8V17TM=;
        b=uSh2bi2XGHj9mgHNdm4b2HJFzVnfMaTkmDDx8xjXhrpkpUE2z1CKGqcuYCMnsuWO79
         8sM5GNHcNzCD5dq2Hq8avOrEowRwydMEQjgQzSL/iKpFtTtRLeOc724Q7r/Mov/rbqGz
         13Yvo0xrwsQazJ+xt0QPLPOgH0liMOs1xFRouuUQdNXYgaayBDSw+cZayN4CUC4srfo1
         9sCgfaYU2ZbxXnVjzHrs7MyaRoKHIbnL6jT4GrTPtv83ewPbiGyR+UJOjbyBNIYrUr0L
         l0leqpTVUO6S3evVqJMM1V37Lo/z9NXAhV+NraxIb4L08DuZfVfkvdcINUb2E4QMROe7
         rB5A==
X-Gm-Message-State: AOAM533SbIbmQC0Esu7VSFP4sjYbUIBcUzoaalwh0AqMZ5Yas7vfoaYb
        uq4yN40Z7azp4JW+lBNU9+Uc/mluw8/4sIzZ
X-Google-Smtp-Source: ABdhPJxfdq301Fj4c2XDlkirmH7au2QFPaqbD6SwU9Z5w0igOA6yljHhU0Ce1NF/X2TujwfL9/amjdmMM+orbMWG
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a2e:910a:: with SMTP id
 m10mr476193ljg.385.1603130002262; Mon, 19 Oct 2020 10:53:22 -0700 (PDT)
Date:   Mon, 19 Oct 2020 19:53:18 +0200
Message-Id: <76eee17b6531ca8b3ca92b240cb2fd23204aaff7.1603129942.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH v2] kasan: adopt KUNIT tests to SW_TAGS mode
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

Add a new kmalloc_uaf_16() tests that relies on UAF, and a new
kasan_bitops_tags() test that is tailored to tag-based mode, as it's hard
to adopt the existing kmalloc_oob_16() and kasan_bitops_generic() (renamed
from kasan_bitops()) without losing the precision.

Add new kmalloc_uaf_16() and kasan_bitops_uaf() tests that rely on UAFs,
as it's hard to adopt the existing kmalloc_oob_16() and kasan_bitops_oob()
(rename from kasan_bitops()) without losing the precision.

Disable kasan_global_oob() and kasan_alloca_oob_left/right() as SW_TAGS
mode doesn't instrument globals nor dynamic allocas.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Tested-by: David Gow <davidgow@google.com>
---

Changes v1->v2:
- Don't do UAF write accesses during tests.

---
 lib/test_kasan.c | 149 ++++++++++++++++++++++++++++++++++-------------
 1 file changed, 107 insertions(+), 42 deletions(-)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index 63c26171a791..662f862702fc 100644
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
+{
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
+static void kasan_bitops_generic(struct kunit *test)
 {
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
@@ -633,55 +717,34 @@ static void kasan_bitops(struct kunit *test)
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
-
-	KUNIT_EXPECT_KASAN_FAIL(test,
-		test_and_set_bit_lock(BITS_PER_LONG + BITS_PER_BYTE, bits));
+	kasan_bitops_test_and_modify(test, BITS_PER_LONG + BITS_PER_BYTE, bits);
 
-	KUNIT_EXPECT_KASAN_FAIL(test,
-		test_and_clear_bit(BITS_PER_LONG + BITS_PER_BYTE, bits));
+	kfree(bits);
+}
 
-	KUNIT_EXPECT_KASAN_FAIL(test,
-		__test_and_clear_bit(BITS_PER_LONG + BITS_PER_BYTE, bits));
+static void kasan_bitops_tags(struct kunit *test)
+{
+	long *bits;
 
-	KUNIT_EXPECT_KASAN_FAIL(test,
-		test_and_change_bit(BITS_PER_LONG + BITS_PER_BYTE, bits));
+	/* This test is specifically crafted for the tag-based mode. */
+	if (IS_ENABLED(CONFIG_KASAN_GENERIC)) {
+		kunit_info(test, "CONFIG_KASAN_SW_TAGS required\n");
+		return;
+	}
 
-	KUNIT_EXPECT_KASAN_FAIL(test,
-		__test_and_change_bit(BITS_PER_LONG + BITS_PER_BYTE, bits));
+	/* Allocation size will be rounded to up granule size, which is 16. */
+	bits = kzalloc(sizeof(*bits), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, bits);
 
-	KUNIT_EXPECT_KASAN_FAIL(test,
-		kasan_int_result =
-			test_bit(BITS_PER_LONG + BITS_PER_BYTE, bits));
+	/* Do the accesses past the 16 allocated bytes. */
+	kasan_bitops_modify(test, BITS_PER_LONG, &bits[1]);
+	kasan_bitops_test_and_modify(test, BITS_PER_LONG + BITS_PER_BYTE, &bits[1]);
 
-#if defined(clear_bit_unlock_is_negative_byte)
-	KUNIT_EXPECT_KASAN_FAIL(test,
-		kasan_int_result = clear_bit_unlock_is_negative_byte(
-			BITS_PER_LONG + BITS_PER_BYTE, bits));
-#endif
 	kfree(bits);
 }
 
@@ -728,6 +791,7 @@ static struct kunit_case kasan_kunit_test_cases[] = {
 	KUNIT_CASE(kmalloc_oob_krealloc_more),
 	KUNIT_CASE(kmalloc_oob_krealloc_less),
 	KUNIT_CASE(kmalloc_oob_16),
+	KUNIT_CASE(kmalloc_uaf_16),
 	KUNIT_CASE(kmalloc_oob_in_memset),
 	KUNIT_CASE(kmalloc_oob_memset_2),
 	KUNIT_CASE(kmalloc_oob_memset_4),
@@ -751,7 +815,8 @@ static struct kunit_case kasan_kunit_test_cases[] = {
 	KUNIT_CASE(kasan_memchr),
 	KUNIT_CASE(kasan_memcmp),
 	KUNIT_CASE(kasan_strings),
-	KUNIT_CASE(kasan_bitops),
+	KUNIT_CASE(kasan_bitops_generic),
+	KUNIT_CASE(kasan_bitops_tags),
 	KUNIT_CASE(kmalloc_double_kzfree),
 	KUNIT_CASE(vmalloc_oob),
 	{}
-- 
2.29.0.rc1.297.gfa9743e501-goog

