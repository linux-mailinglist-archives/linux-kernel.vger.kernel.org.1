Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50FB21F9719
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jun 2020 14:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730047AbgFOMw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jun 2020 08:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729733AbgFOMw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 08:52:56 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5784C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 05:52:56 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id s88so7103079pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 05:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ONb6OWKObcCQqLE8RslwvJhlq5Ue2l0Tz9q17QRwXmQ=;
        b=vZbKVnAO17BTn8GBQWe+nB+Znl5GJy50GPNS4pm5PKyPAVl/XpmS9FwTNt+dq23Aiv
         5iCGZgPFzi6ERQN8FkwAJTd50037VFqhEXH9bvwrRtEFTry/zfF8fM/+Mqg8Bg2+qSHO
         0OoDpJuuoENHTWVa0hpsg+MjVRoFFIRmgEAESJpe8aMXD1n+UThXuU3Sot3041qb6dog
         NIFgmzqz5iv3NoNl1ynAI5I78MuCSxDunsILjgamY0UarFwmOf8asqfbK4bkg+jBEscr
         xnBxbqAavUAdUMd0c3JH09hT/xSNDh2VIx/9bGUm+wLCTSWmSx5TalrXuydON/HnKtxi
         2bzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ONb6OWKObcCQqLE8RslwvJhlq5Ue2l0Tz9q17QRwXmQ=;
        b=imaNmvY/oADILnrF8M0a0MJ8jzG1vv/nEaE6r4rb+R1Hm4ZI94DhRtBqf3TmTmzchf
         9VRFdYmXFRs0iW6c//fDDAFvfU4sGFVS+AsMK1Kjm1cZoWIF4cH+vK2EbWxWG8cfUXvh
         ykJ2OycNd41wekUIUzCaGZjDO4mFKa0RASj9Qlx5NiyozR8j5SOxw+0ikc/FYPnji5kv
         2IfmSqBrG/OBomP0rHHO0SCH673s1mOOo36ebEwZXbKFRQ4HFeryH/V60GDw9H7GsYkA
         G43/34MbrhMeSp9YBMu2+Azs6sZfye90u56R42LLNiyxJtirzyDpc8BXxZiN3ZIrnv5+
         ilmQ==
X-Gm-Message-State: AOAM532cHHBoBz5ve5XWVmLIHk2pETe0eK3uvW22iwMOpWGeJUClkXWp
        IBgohtiphj8tq9gB781YpI0=
X-Google-Smtp-Source: ABdhPJxrfMOBjXTWudyJ406ScatOVOdOkHbstrT3o4Hnki0oRM9cqBhMZf3+zXSIA/tJBTaJwxY/nA==
X-Received: by 2002:a17:90a:234f:: with SMTP id f73mr11942119pje.174.1592225576181;
        Mon, 15 Jun 2020 05:52:56 -0700 (PDT)
Received: from syed ([106.198.195.84])
        by smtp.gmail.com with ESMTPSA id c7sm12140270pgh.84.2020.06.15.05.52.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jun 2020 05:52:55 -0700 (PDT)
Date:   Mon, 15 Jun 2020 18:22:41 +0530
From:   Syed Nayyar Waris <syednwaris@gmail.com>
To:     linus.walleij@linaro.org, akpm@linux-foundation.org
Cc:     andriy.shevchenko@linux.intel.com, vilhelm.gray@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 2/4] lib/test_bitmap.c: Add for_each_set_clump test cases
Message-ID: <4bb5a95212d9371a3c47500cea9b98837ac8c664.1592224129.git.syednwaris@gmail.com>
References: <cover.1592224128.git.syednwaris@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1592224128.git.syednwaris@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The introduction of the generic for_each_set_clump macro need test
cases to verify the implementation. This patch adds test cases for
scenarios in which clump sizes are 8 bits, 24 bits, 30 bits and 6 bits.
The cases contain situations where clump is getting split at the word
boundary and also when zeroes are present in the start and middle of
bitmap.

Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
Changes in v8:
 - [Patch 2/4]: Minor change: Use '__initdata' for correct section mismatch
   in 'clump_test_data' array.

Changes in v7:
 - Minor changes: Use macro 'DECLARE_BITMAP()' and split 'struct'
   definition and test data.

Changes in v6:
 - Make 'for loop' inside 'test_for_each_set_clump' more succinct.

Changes in v5:
 - No change.

Changes in v4:
 - Use 'for' loop in test function of 'for_each_set_clump'.

Changes in v3:
 - No Change.

Changes in v2:
 - Unify different tests for 'for_each_set_clump'. Pass test data as
   function parameters.
 - Remove unnecessary bitmap_zero calls.

 lib/test_bitmap.c | 145 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 145 insertions(+)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 6b13150667f5..78c0048870a6 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -155,6 +155,38 @@ static bool __init __check_eq_clump8(const char *srcfile, unsigned int line,
 	return true;
 }
 
+static bool __init __check_eq_clump(const char *srcfile, unsigned int line,
+				    const unsigned int offset,
+				    const unsigned int size,
+				    const unsigned long *const clump_exp,
+				    const unsigned long *const clump,
+				    const unsigned long clump_size)
+{
+	unsigned long exp;
+
+	if (offset >= size) {
+		pr_warn("[%s:%u] bit offset for clump out-of-bounds: expected less than %u, got %u\n",
+			srcfile, line, size, offset);
+		return false;
+	}
+
+	exp = clump_exp[offset / clump_size];
+	if (!exp) {
+		pr_warn("[%s:%u] bit offset for zero clump: expected nonzero clump, got bit offset %u with clump value 0",
+			srcfile, line, offset);
+		return false;
+	}
+
+	if (*clump != exp) {
+		pr_warn("[%s:%u] expected clump value of 0x%lX, got clump value of 0x%lX",
+			srcfile, line, exp, *clump);
+		return false;
+	}
+
+	return true;
+}
+
+
 #define __expect_eq(suffix, ...)					\
 	({								\
 		int result = 0;						\
@@ -172,6 +204,7 @@ static bool __init __check_eq_clump8(const char *srcfile, unsigned int line,
 #define expect_eq_pbl(...)		__expect_eq(pbl, ##__VA_ARGS__)
 #define expect_eq_u32_array(...)	__expect_eq(u32_array, ##__VA_ARGS__)
 #define expect_eq_clump8(...)		__expect_eq(clump8, ##__VA_ARGS__)
+#define expect_eq_clump(...)		__expect_eq(clump, ##__VA_ARGS__)
 
 static void __init test_zero_clear(void)
 {
@@ -577,6 +610,28 @@ static void noinline __init test_mem_optimisations(void)
 	}
 }
 
+static const unsigned long clump_bitmap_data[] __initconst = {
+	0x38000201,
+	0x05ff0f38,
+	0xeffedcba,
+	0xbbbbabcd,
+	0x000000aa,
+	0x000000aa,
+	0x00ff0000,
+	0xaaaaaa00,
+	0xff000000,
+	0x00aa0000,
+	0x00000000,
+	0x00000000,
+	0x00000000,
+	0x0f000000,
+	0x00ff0000,
+	0xaaaaaa00,
+	0xff000000,
+	0x00aa0000,
+	0x00000ac0,
+};
+
 static const unsigned char clump_exp[] __initconst = {
 	0x01,	/* 1 bit set */
 	0x02,	/* non-edge 1 bit set */
@@ -588,6 +643,95 @@ static const unsigned char clump_exp[] __initconst = {
 	0x05,	/* non-adjacent 2 bits set */
 };
 
+static const unsigned long clump_exp1[] __initconst = {
+	0x01,	/* 1 bit set */
+	0x02,	/* non-edge 1 bit set */
+	0x00,	/* zero bits set */
+	0x38,	/* 3 bits set across 4-bit boundary */
+	0x38,	/* Repeated clump */
+	0x0F,	/* 4 bits set */
+	0xFF,	/* all bits set */
+	0x05,	/* non-adjacent 2 bits set */
+};
+
+static const unsigned long clump_exp2[] __initconst = {
+	0xfedcba,	/* 24 bits */
+	0xabcdef,
+	0xaabbbb,	/* Clump split between 2 words */
+	0x000000,	/* zeroes in between */
+	0x0000aa,
+	0x000000,
+	0x0000ff,
+	0xaaaaaa,
+	0x000000,
+	0x0000ff,
+};
+
+static const unsigned long clump_exp3[] __initconst = {
+	0x00000000,	/* starting with 0s*/
+	0x00000000,	/* All 0s */
+	0x00000000,
+	0x00000000,
+	0x3f00000f,     /* Non zero set */
+	0x2aa80003,
+	0x00000aaa,
+	0x00003fc0,
+};
+
+static const unsigned long clump_exp4[] __initconst = {
+	0x00,
+	0x2b,
+};
+
+struct clump_test_data_params {
+	DECLARE_BITMAP(data, 256);
+	unsigned long count;
+	unsigned long offset;
+	unsigned long limit;
+	unsigned long clump_size;
+	unsigned long const *exp;
+};
+
+static struct clump_test_data_params clump_test_data[] __initdata =
+				      { {{0}, 2, 0, 64, 8, clump_exp1},
+					{{0}, 8, 2, 240, 24, clump_exp2},
+					{{0}, 8, 10, 240, 30, clump_exp3},
+					{{0}, 1, 18, 18, 6, clump_exp4} };
+
+static void __init prepare_test_data(unsigned int index)
+{
+	int i;
+	unsigned long width = 0;
+
+	for(i = 0; i < clump_test_data[index].count; i++)
+	{
+		bitmap_set_value(clump_test_data[index].data,
+			clump_bitmap_data[(clump_test_data[index].offset)++], width, 32);
+		width += 32;
+	}
+}
+
+static void __init execute_for_each_set_clump_test(unsigned int index)
+{
+	unsigned long start, clump;
+
+	for_each_set_clump(start, clump, clump_test_data[index].data,
+						clump_test_data[index].limit,
+						clump_test_data[index].clump_size)
+	expect_eq_clump(start, clump_test_data[index].limit, clump_test_data[index].exp,
+						&clump, clump_test_data[index].clump_size);
+}
+
+static void __init test_for_each_set_clump(void)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(clump_test_data); i++) {
+		prepare_test_data(i);
+		execute_for_each_set_clump_test(i);
+	}
+}
+
 static void __init test_for_each_set_clump8(void)
 {
 #define CLUMP_EXP_NUMBITS 64
@@ -623,6 +767,7 @@ static void __init selftest(void)
 	test_bitmap_parselist_user();
 	test_mem_optimisations();
 	test_for_each_set_clump8();
+	test_for_each_set_clump();
 }
 
 KSTM_MODULE_LOADERS(test_bitmap);
-- 
2.26.2

