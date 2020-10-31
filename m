Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF9A22A13BD
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 06:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbgJaF4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 01:56:48 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7014 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgJaF4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 01:56:48 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CNT2j1Tl8zhdtp;
        Sat, 31 Oct 2020 13:56:45 +0800 (CST)
Received: from localhost (10.174.176.180) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Sat, 31 Oct 2020
 13:56:35 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <sjenning@redhat.com>, <ddstreet@ieee.org>,
        <vitaly.wool@konsulko.com>, <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] mm/zswap: Fix passing zero to 'PTR_ERR' warning
Date:   Sat, 31 Oct 2020 13:56:15 +0800
Message-ID: <20201031055615.28080-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.176.180]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix smatch warning:

mm/zswap.c:425 zswap_cpu_comp_prepare() warn: passing zero to 'PTR_ERR'

crypto_alloc_comp() never return NULL, use IS_ERR
instead of IS_ERR_OR_NULL to fix this.

Fixes: f1c54846ee45 ("zswap: dynamic pool creation")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 mm/zswap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 1eced701b3bd..55a2f72557a8 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -421,7 +421,7 @@ static int zswap_cpu_comp_prepare(unsigned int cpu, struct hlist_node *node)
 		return 0;
 
 	tfm = crypto_alloc_comp(pool->tfm_name, 0, 0);
-	if (IS_ERR_OR_NULL(tfm)) {
+	if (IS_ERR(tfm)) {
 		pr_err("could not alloc crypto comp %s : %ld\n",
 		       pool->tfm_name, PTR_ERR(tfm));
 		return -ENOMEM;
-- 
2.17.1

