Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11DA6292037
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 23:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbgJRVjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 17:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbgJRVjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 17:39:54 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1388C061755
        for <linux-kernel@vger.kernel.org>; Sun, 18 Oct 2020 14:39:54 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id k8so4823324pfk.2
        for <linux-kernel@vger.kernel.org>; Sun, 18 Oct 2020 14:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1XRqUV++Eg/NVx7IRtnMf/6Aid20eo3diEAeSuZJdGo=;
        b=kx08Lg8V5nAYXtPUdR0wk9mVcfJ9WkmPLn1lNicg4vUd2yJ2im5U3LqjcrsDuCBGI7
         4559NqasIf/IxE7+u+tymr/5MjaJhyU9ScDeHoU5oAbjLVag72WwVJzNYDPJ17mdhcTF
         o8Xvp23TnOoELmZBXv215aRioRmtibftBqzNv37bkBEfC/xCEyCkLpb2yjNMOxYgcBRO
         PTK0L1MXfdOIWkT6dfzXo1i97YrrRbdQ+M+ZLvuB8OBA4VnMmXBShjR4x3Sp5lutof5g
         sR+5KlSCMY95wUc3Dv0qoDTZ9obs4V9NzX0fW/BL8w162I4hcELFt4D5Vx4N9ebGKZig
         VfLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1XRqUV++Eg/NVx7IRtnMf/6Aid20eo3diEAeSuZJdGo=;
        b=A2Etvy6UQjyADuYWkXmM83hisCFgFdq3X0wgJubXBR/KCoV43EPkbchyVMLxkr2YVp
         3yioDxMyiXf9sLlZCS3AlCog7alHGrn7vqzG5HZV3LWmBKhr308h8VBJWDPIFBFiWitm
         bEfm5/jSRMo4+ekkCjxLQrL1pBx0RaM5wlhsFVxlentFkgM3dUDfUp6YhkoJlOUlP9nB
         wgj1P4JNM+nKa5CSG8GhMcOqRpMenECcFXgQruyydHOAUcCZq2g+5kfffdl9jhwPu2MR
         Y/AX1CAiLDJLHVKmCn86iS6AtdRd0Qm0iN/EiAD0Dp+R/sSxbr76LBJHMrgRBo1rDuJJ
         UaNw==
X-Gm-Message-State: AOAM531yHPnVBr9CuwUYFqL+d7ZN6uosZNJJisRoxza8ZI+aRf7KcriF
        eEUpKsjbBIhAQUIdyBfbYwUdzaLRlZKH+g==
X-Google-Smtp-Source: ABdhPJyc5L1zesvZX0DCqCC2zSX7B2Dz/80iSACG3E5NkJ+oce94uNrrtL3FNwzcg8U9d8bqnNVcOw==
X-Received: by 2002:a65:4bcc:: with SMTP id p12mr11401702pgr.353.1603057194362;
        Sun, 18 Oct 2020 14:39:54 -0700 (PDT)
Received: from syed ([2401:4900:47f3:e624:90f9:25c2:806b:19c8])
        by smtp.gmail.com with ESMTPSA id w10sm9506670pjy.13.2020.10.18.14.39.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Oct 2020 14:39:53 -0700 (PDT)
Date:   Mon, 19 Oct 2020 03:09:36 +0530
From:   Syed Nayyar Waris <syednwaris@gmail.com>
To:     linus.walleij@linaro.org, akpm@linux-foundation.org
Cc:     andriy.shevchenko@linux.intel.com, vilhelm.gray@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v12 2/4] lib/test_bitmap.c: Add for_each_set_clump test cases
Message-ID: <bf4d78db5d56a6b22e68a4ecb24d4cb09d1a3124.1603055402.git.syednwaris@gmail.com>
References: <cover.1603055402.git.syednwaris@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1603055402.git.syednwaris@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
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
Changes in v12:
 - No change.

Changes in v11:
 - No change.

Changes in v10:
 - No change.

Changes in v9:
 - No change.

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

 lib/test_bitmap.c | 144 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 144 insertions(+)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index df903c53952b..cb2cf3858f93 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -155,6 +155,37 @@ static bool __init __check_eq_clump8(const char *srcfile, unsigned int line,
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
 #define __expect_eq(suffix, ...)					\
 	({								\
 		int result = 0;						\
@@ -172,6 +203,7 @@ static bool __init __check_eq_clump8(const char *srcfile, unsigned int line,
 #define expect_eq_pbl(...)		__expect_eq(pbl, ##__VA_ARGS__)
 #define expect_eq_u32_array(...)	__expect_eq(u32_array, ##__VA_ARGS__)
 #define expect_eq_clump8(...)		__expect_eq(clump8, ##__VA_ARGS__)
+#define expect_eq_clump(...)		__expect_eq(clump, ##__VA_ARGS__)
 
 static void __init test_zero_clear(void)
 {
@@ -577,6 +609,28 @@ static void noinline __init test_mem_optimisations(void)
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
@@ -588,6 +642,95 @@ static const unsigned char clump_exp[] __initconst = {
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
@@ -680,6 +823,7 @@ static void __init selftest(void)
 	test_bitmap_parselist_user();
 	test_mem_optimisations();
 	test_for_each_set_clump8();
+	test_for_each_set_clump();
 	test_bitmap_cut();
 }
 
-- 
2.26.2

