Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 961F627191B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 04:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbgIUCDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 22:03:06 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:34234 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726413AbgIUCC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 22:02:58 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A86B3588FA98689880E4;
        Mon, 21 Sep 2020 10:02:55 +0800 (CST)
Received: from mdc.huawei.com (10.175.112.208) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Mon, 21 Sep 2020 10:02:49 +0800
From:   Chen Jun <chenjun102@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC:     <catalin.marinas@arm.com>, <akpm@linux-foundation.org>,
        <rui.xiang@huawei.com>, <weiyongjun1@huawei.com>
Subject: [PATCH -next 5/5] mm/kmemleak-test: Add a test case for alloc_percpu
Date:   Mon, 21 Sep 2020 02:00:07 +0000
Message-ID: <20200921020007.35803-6-chenjun102@huawei.com>
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

After insmod kmemleak-test.ko, a leaking for alloc_percpu will be
reported as below:

kmemleak: alloc_percpu(sizeof(*elem)) = 00007dfdd26a2c40
			:
			:
unreferenced object 0x7dfdd26a2c40 (size 8):
  comm "insmod", pid 183, jiffies 4294905864 (age 40.520s)
  hex dump (first 8 bytes):
    00 00 00 00 00 00 00 00                          ........
  backtrace:
    [<(____ptrval____)>] pcpu_alloc+0x3ec/0x8c8
    [<(____ptrval____)>] __alloc_percpu+0x18/0x28
    [<(____ptrval____)>] 0xffff800008df525c
    [<(____ptrval____)>] do_one_initcall+0x60/0x1d8
    [<(____ptrval____)>] do_init_module+0x58/0x1d0
    [<(____ptrval____)>] load_module+0x1d8c/0x23d0
    [<(____ptrval____)>] __do_sys_finit_module+0xdc/0xf8
    [<(____ptrval____)>] __arm64_sys_finit_module+0x20/0x30
    [<(____ptrval____)>] el0_svc_common.constprop.3+0x68/0x170
    [<(____ptrval____)>] do_el0_svc+0x24/0x90
    [<(____ptrval____)>] el0_sync_handler+0x13c/0x1a8
    [<(____ptrval____)>] el0_sync+0x158/0x180

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Chen Jun <chenjun102@huawei.com>
---
 mm/kmemleak-test.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/kmemleak-test.c b/mm/kmemleak-test.c
index 75fe1b8c3226..8f3e4a60166b 100644
--- a/mm/kmemleak-test.c
+++ b/mm/kmemleak-test.c
@@ -79,6 +79,9 @@ static int __init kmemleak_test_init(void)
 			per_cpu(kmemleak_test_pointer, i));
 	}
 
+	pr_info("alloc_percpu(sizeof(*elem)) = %px\n",
+		alloc_percpu(sizeof(*elem)));
+
 	return 0;
 }
 module_init(kmemleak_test_init);
-- 
2.25.0

