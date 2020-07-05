Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43A17214B83
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jul 2020 11:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgGEJVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jul 2020 05:21:20 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:39400 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726861AbgGEJVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 05:21:19 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 31B4DE101C8462403081;
        Sun,  5 Jul 2020 17:21:15 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.202.129) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Sun, 5 Jul 2020 17:21:07 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <wangzhou1@hisilicon.com>, <jonathan.cameron@huawei.com>,
        <akpm@linux-foundation.org>, <linux-crypto@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Barry Song <song.bao.hua@hisilicon.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>
Subject: [PATCH v3 3/3] mm/zswap: allocate acomp on the numa node committing acomp_req
Date:   Sun, 5 Jul 2020 21:19:00 +1200
Message-ID: <20200705091900.29232-4-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20200705091900.29232-1-song.bao.hua@hisilicon.com>
References: <20200705091900.29232-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.202.129]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

zswap is allocating acomp on one different cpu with those cpus which will
eventually committing acomp_req. this patch specifies the numa node to
help compression/decompression done by local (de)compressors hardware.

Cc: Seth Jennings <sjenning@redhat.com>
Cc: Dan Streetman <ddstreet@ieee.org>
Cc: Vitaly Wool <vitaly.wool@konsulko.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 this patch depends on a zswap patch which has not been merged yet:
 "[PATCH v3] mm/zswap: move to use crypto_acomp API for hardware
 acceleration"
 https://lkml.org/lkml/2020/6/26/95

 mm/zswap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index d170ef06c693..3c2acf51f09e 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -437,7 +437,7 @@ static int zswap_cpu_comp_prepare(unsigned int cpu, struct hlist_node *node)
 	if (!acomp_ctx)
 		return -ENOMEM;
 
-	acomp = crypto_alloc_acomp(pool->tfm_name, 0, 0);
+	acomp = crypto_alloc_acomp_node(pool->tfm_name, 0, 0, cpu_to_node(cpu));
 	if (IS_ERR(acomp)) {
 		pr_err("could not alloc crypto acomp %s : %ld\n",
 				pool->tfm_name, PTR_ERR(acomp));
-- 
2.27.0


