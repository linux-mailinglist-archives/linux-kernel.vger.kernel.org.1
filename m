Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F21D21270E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jul 2020 16:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730083AbgGBOxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jul 2020 10:53:39 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6809 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730044AbgGBOxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 10:53:37 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1384A23D8D7C17A1D939;
        Thu,  2 Jul 2020 22:53:32 +0800 (CST)
Received: from kernelci-master.huawei.com (10.175.101.6) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Thu, 2 Jul 2020 22:53:22 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Hulk Robot <hulkci@huawei.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Randy Dunlap <rd.dunlap@gmail.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] lib/test_bits: make some functions static
Date:   Thu, 2 Jul 2020 23:03:36 +0800
Message-ID: <20200702150336.4756-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse build warnings:

lib/test_bits.c:10:6: warning:
 symbol 'genmask_test' was not declared. Should it be static?
lib/test_bits.c:27:6: warning:
 symbol 'genmask_ull_test' was not declared. Should it be static?
lib/test_bits.c:42:6: warning:
 symbol 'genmask_input_check_test' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 lib/test_bits.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/test_bits.c b/lib/test_bits.c
index 89e0ea83511f..c9368a2314e7 100644
--- a/lib/test_bits.c
+++ b/lib/test_bits.c
@@ -7,7 +7,7 @@
 #include <linux/bits.h>
 
 
-void genmask_test(struct kunit *test)
+static void genmask_test(struct kunit *test)
 {
 	KUNIT_EXPECT_EQ(test, 1ul, GENMASK(0, 0));
 	KUNIT_EXPECT_EQ(test, 3ul, GENMASK(1, 0));
@@ -24,7 +24,7 @@ void genmask_test(struct kunit *test)
 
 }
 
-void genmask_ull_test(struct kunit *test)
+static void genmask_ull_test(struct kunit *test)
 {
 	KUNIT_EXPECT_EQ(test, 1ull, GENMASK_ULL(0, 0));
 	KUNIT_EXPECT_EQ(test, 3ull, GENMASK_ULL(1, 0));
@@ -39,7 +39,7 @@ void genmask_ull_test(struct kunit *test)
 #endif
 }
 
-void genmask_input_check_test(struct kunit *test)
+static void genmask_input_check_test(struct kunit *test)
 {
 	unsigned int x, y;
 	int z, w;

