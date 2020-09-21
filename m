Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE1D272519
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 15:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbgIUNKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 09:10:01 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13751 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726417AbgIUNJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 09:09:56 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 99B166ED5E66D7E0C04D;
        Mon, 21 Sep 2020 21:09:53 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Mon, 21 Sep 2020 21:09:43 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Boris Brezillon <bbrezillon@kernel.org>,
        Arnaud Ebalard <arno@natisbad.org>,
        Srujana Challa <schalla@marvell.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
CC:     "David S. Miller" <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Qinglang Miao <miaoqinglang@huawei.com>
Subject: [PATCH -next] crypto: marvell/octeontx - simplify the return expression of create_sysfs_eng_grps_info()
Date:   Mon, 21 Sep 2020 21:10:07 +0800
Message-ID: <20200921131007.91145-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the return expression.

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c b/drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c
index cc103b1bc..40b482198 100644
--- a/drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c
+++ b/drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c
@@ -824,18 +824,12 @@ static ssize_t eng_grp_info_show(struct device *dev,
 static int create_sysfs_eng_grps_info(struct device *dev,
 				      struct otx_cpt_eng_grp_info *eng_grp)
 {
-	int ret;
-
 	eng_grp->info_attr.show = eng_grp_info_show;
 	eng_grp->info_attr.store = NULL;
 	eng_grp->info_attr.attr.name = eng_grp->sysfs_info_name;
 	eng_grp->info_attr.attr.mode = 0440;
 	sysfs_attr_init(&eng_grp->info_attr.attr);
-	ret = device_create_file(dev, &eng_grp->info_attr);
-	if (ret)
-		return ret;
-
-	return 0;
+	return device_create_file(dev, &eng_grp->info_attr);
 }
 
 static void ucode_unload(struct device *dev, struct otx_cpt_ucode *ucode)
-- 
2.23.0

