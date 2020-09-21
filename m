Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 696DB27191E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 04:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgIUCC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 22:02:57 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:34122 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726221AbgIUCC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 22:02:57 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9B6A2D59F4361EE129AF;
        Mon, 21 Sep 2020 10:02:55 +0800 (CST)
Received: from mdc.huawei.com (10.175.112.208) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Mon, 21 Sep 2020 10:02:48 +0800
From:   Chen Jun <chenjun102@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC:     <catalin.marinas@arm.com>, <akpm@linux-foundation.org>,
        <rui.xiang@huawei.com>, <weiyongjun1@huawei.com>
Subject: [PATCH -next 4/5] mm/kmemleak-test: use %px instead of %p in print
Date:   Mon, 21 Sep 2020 02:00:06 +0000
Message-ID: <20200921020007.35803-5-chenjun102@huawei.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200921020007.35803-1-chenjun102@huawei.com>
References: <20200921020007.35803-1-chenjun102@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.208]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

Real addresses are used for diagnose issues.
Convert %p with %px to print kernel addresses.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Chen Jun <chenjun102@huawei.com>
---
 mm/kmemleak-test.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/mm/kmemleak-test.c b/mm/kmemleak-test.c
index e19279ff6aa3..75fe1b8c3226 100644
--- a/mm/kmemleak-test.c
+++ b/mm/kmemleak-test.c
@@ -40,25 +40,25 @@ static int __init kmemleak_test_init(void)
 	pr_info("Kmemleak testing\n");
 
 	/* make some orphan objects */
-	pr_info("kmalloc(32) = %p\n", kmalloc(32, GFP_KERNEL));
-	pr_info("kmalloc(32) = %p\n", kmalloc(32, GFP_KERNEL));
-	pr_info("kmalloc(1024) = %p\n", kmalloc(1024, GFP_KERNEL));
-	pr_info("kmalloc(1024) = %p\n", kmalloc(1024, GFP_KERNEL));
-	pr_info("kmalloc(2048) = %p\n", kmalloc(2048, GFP_KERNEL));
-	pr_info("kmalloc(2048) = %p\n", kmalloc(2048, GFP_KERNEL));
-	pr_info("kmalloc(4096) = %p\n", kmalloc(4096, GFP_KERNEL));
-	pr_info("kmalloc(4096) = %p\n", kmalloc(4096, GFP_KERNEL));
+	pr_info("kmalloc(32) = %px\n", kmalloc(32, GFP_KERNEL));
+	pr_info("kmalloc(32) = %px\n", kmalloc(32, GFP_KERNEL));
+	pr_info("kmalloc(1024) = %px\n", kmalloc(1024, GFP_KERNEL));
+	pr_info("kmalloc(1024) = %px\n", kmalloc(1024, GFP_KERNEL));
+	pr_info("kmalloc(2048) = %px\n", kmalloc(2048, GFP_KERNEL));
+	pr_info("kmalloc(2048) = %px\n", kmalloc(2048, GFP_KERNEL));
+	pr_info("kmalloc(4096) = %px\n", kmalloc(4096, GFP_KERNEL));
+	pr_info("kmalloc(4096) = %px\n", kmalloc(4096, GFP_KERNEL));
 #ifndef CONFIG_MODULES
-	pr_info("kmem_cache_alloc(files_cachep) = %p\n",
+	pr_info("kmem_cache_alloc(files_cachep) = %px\n",
 		kmem_cache_alloc(files_cachep, GFP_KERNEL));
-	pr_info("kmem_cache_alloc(files_cachep) = %p\n",
+	pr_info("kmem_cache_alloc(files_cachep) = %px\n",
 		kmem_cache_alloc(files_cachep, GFP_KERNEL));
 #endif
-	pr_info("vmalloc(64) = %p\n", vmalloc(64));
-	pr_info("vmalloc(64) = %p\n", vmalloc(64));
-	pr_info("vmalloc(64) = %p\n", vmalloc(64));
-	pr_info("vmalloc(64) = %p\n", vmalloc(64));
-	pr_info("vmalloc(64) = %p\n", vmalloc(64));
+	pr_info("vmalloc(64) = %px\n", vmalloc(64));
+	pr_info("vmalloc(64) = %px\n", vmalloc(64));
+	pr_info("vmalloc(64) = %px\n", vmalloc(64));
+	pr_info("vmalloc(64) = %px\n", vmalloc(64));
+	pr_info("vmalloc(64) = %px\n", vmalloc(64));
 
 	/*
 	 * Add elements to a list. They should only appear as orphan
@@ -66,7 +66,7 @@ static int __init kmemleak_test_init(void)
 	 */
 	for (i = 0; i < 10; i++) {
 		elem = kzalloc(sizeof(*elem), GFP_KERNEL);
-		pr_info("kzalloc(sizeof(*elem)) = %p\n", elem);
+		pr_info("kzalloc(sizeof(*elem)) = %px\n", elem);
 		if (!elem)
 			return -ENOMEM;
 		INIT_LIST_HEAD(&elem->list);
@@ -75,7 +75,7 @@ static int __init kmemleak_test_init(void)
 
 	for_each_possible_cpu(i) {
 		per_cpu(kmemleak_test_pointer, i) = kmalloc(129, GFP_KERNEL);
-		pr_info("kmalloc(129) = %p\n",
+		pr_info("kmalloc(129) = %px\n",
 			per_cpu(kmemleak_test_pointer, i));
 	}
 
-- 
2.25.0

