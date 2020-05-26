Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2A501BD061
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Apr 2020 01:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgD1XGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 19:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726042AbgD1XGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 19:06:16 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D79C03C1AC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 16:06:16 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id o185so74207pgo.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 16:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UeE7fIVHYtjA66XxZFQpvt5yhdMnfvlryX8XU026EjU=;
        b=n0l/0xzh0UjcEnqRmeOhW4/aZq0o6N+Hph+eRkEryI6H5GePsyNQi21tBruLrzUCAV
         eihbE04/EnZwfhjNKu06yz4XOunQet8fgVwFLEJ/cWErVwbxEQ9IjnVgPj8gyQhzZ6Ws
         6FFfZuk5tjYVcW5jzUM4K0nPmPah4HGqHYKMLTLs2RkjvBqE2BgHWmHW8x//op18pezn
         fw0jCQiyJGOrUbH+MK7k+W724fHfVyWSoPAENhMwjGug/vvIxULEjRt7lQhhUYhJq9as
         75OJek9ghvVRmFNswdwdcrjhCMKcJKTGO/ETl1YXGUlGNpaDrFg/OxZF8Jq9W9T5e8RP
         3UEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UeE7fIVHYtjA66XxZFQpvt5yhdMnfvlryX8XU026EjU=;
        b=e70D7+g62hDuANuhMqjNX+xsJm6A9VDKEI6qY1k0dQW6rIGJxaxIhDFGzrsZ0aa0kK
         Swi4jrVhuSbIiTsF6PvrNvWAD72D616Qb3xA0fYsAJhh6vuUstw5sM+3UHaV+SeeiyoX
         099K40NOd1846aczYLh3vDilIJPanA6CuP9FtjjT0LYnv2L8AVRwl7BuLNEaMHhnG0WQ
         I3leV6rtM26RXyirOQrK2l2YW6W8etOQFxRCmSKxzDTJ5vBTqaKPN6V7N/5ztDxfJkz4
         DpngJzHyBVh1xMdu8KIYNKWkxydUruN1ZjSjbBd8OorHRf9lPPOLkDPURismBC3jZpu6
         nSnA==
X-Gm-Message-State: AGi0PuZBxHo2ZeYhALBNnZjE6rhYNChrbNVe+Ezg9govChE3ToFmh8/u
        h+CNbZgtBsH9kAqAd1yPCLmOFe9m
X-Google-Smtp-Source: APiQypJP0YCloypxLwGfW+Nw2a22/Zat5kwBjLwOkf4WbeDGAydyK8ObRvNso3ORDesmmZOO51KyDg==
X-Received: by 2002:aa7:8593:: with SMTP id w19mr32101995pfn.97.1588115175769;
        Tue, 28 Apr 2020 16:06:15 -0700 (PDT)
Received: from syed ([106.202.21.137])
        by smtp.gmail.com with ESMTPSA id e135sm16162876pfh.37.2020.04.28.16.06.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Apr 2020 16:06:15 -0700 (PDT)
Date:   Wed, 29 Apr 2020 04:35:58 +0530
From:   Syed Nayyar Waris <syednwaris@gmail.com>
To:     akpm@linux-foundation.org
Cc:     andriy.shevchenko@linux.intel.com, vilhelm.gray@gmail.com,
        linus.walleij@linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] lib/test_bitmap.c: Add for_each_set_clump test cases
Message-ID: <46108644a1cc2750e281c33fd0efe99bd57c50e2.1588112715.git.syednwaris@gmail.com>
References: <cover.1588112714.git.syednwaris@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1588112714.git.syednwaris@gmail.com>
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

Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
Changes in v3:
 - No CHange.

Changes in v2:
 - Unify different tests for 'for_each_set_clump'. Pass test data as
   function parameters.
 - Remove unnecessary bitmap_zero calls.

 lib/test_bitmap.c | 121 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 6b13150667f5..13fe9a2e752e 100644
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
@@ -588,6 +621,46 @@ static const unsigned char clump_exp[] __initconst = {
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
 static void __init test_for_each_set_clump8(void)
 {
 #define CLUMP_EXP_NUMBITS 64
@@ -610,6 +683,53 @@ static void __init test_for_each_set_clump8(void)
 		expect_eq_clump8(start, CLUMP_EXP_NUMBITS, clump_exp, &clump);
 }
 
+static void __init execute_for_each_set_clump(unsigned long *bits,
+				unsigned long size,
+				const unsigned long *clump_exp,
+				unsigned long clump_size)
+{
+	unsigned long start, clump;
+
+	for_each_set_clump(start, clump, bits, size, clump_size)
+		expect_eq_clump(start, size, clump_exp, &clump, clump_size);
+}
+
+static void __init test_for_each_set_clump(void)
+{
+	/* common bitmap of max size for different tests */
+	DECLARE_BITMAP(bits, 256);
+
+	/* set bitmap for test case 1 with clump size as 8 bits */
+	bitmap_set_value(bits, 0x38000201, 0, 32);
+	bitmap_set_value(bits, 0x05ff0f38, 32, 32);
+
+	execute_for_each_set_clump(bits, 64, clump_exp1, 8);
+
+	/* set bitmap for test case 2 with clump size as 24 bits */
+	bitmap_set_value(bits, 0xeffedcba, 0, 32);
+	bitmap_set_value(bits, 0xbbbbabcd, 32, 32);
+	bitmap_set_value(bits, 0x000000aa, 64, 32);
+	bitmap_set_value(bits, 0x000000aa, 96, 32);
+	bitmap_set_value(bits, 0x00ff0000, 128, 32);
+	bitmap_set_value(bits, 0xaaaaaa00, 160, 32);
+	bitmap_set_value(bits, 0xff000000, 192, 32);
+	bitmap_set_value(bits, 0x00aa0000, 224, 32);
+
+	execute_for_each_set_clump(bits, 240, clump_exp2, 24);
+
+	/* set bitmap for test case 3 with clump size as 30 bits */
+	bitmap_set_value(bits, 0x00000000, 0, 32);
+	bitmap_set_value(bits, 0x00000000, 32, 32);
+	bitmap_set_value(bits, 0x00000000, 64, 32);
+	bitmap_set_value(bits, 0x0f000000, 96, 32);
+
+	execute_for_each_set_clump(bits, 240, clump_exp3, 30);
+
+	/* set bitmap for test case 4 with clump size as 6 bits */
+	bitmap_set_value(bits, 0x00000ac0, 0, 32);
+	execute_for_each_set_clump(bits, 18, clump_exp4, 6);
+}
+
 static void __init selftest(void)
 {
 	test_zero_clear();
@@ -623,6 +743,7 @@ static void __init selftest(void)
 	test_bitmap_parselist_user();
 	test_mem_optimisations();
 	test_for_each_set_clump8();
+	test_for_each_set_clump();
 }
 
 KSTM_MODULE_LOADERS(test_bitmap);
-- 
2.26.2

