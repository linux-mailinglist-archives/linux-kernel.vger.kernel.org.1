Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49CB72DC0C6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 14:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgLPNHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 08:07:51 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:9451 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725274AbgLPNHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 08:07:51 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CwwPR6c7dzhnyq;
        Wed, 16 Dec 2020 21:06:35 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Wed, 16 Dec 2020 21:06:55 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <miquel.raynal@bootlin.com>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] ubi: eba: Delete useless kfree code
Date:   Wed, 16 Dec 2020 21:07:28 +0800
Message-ID: <20201216130728.14034-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The parameter of kfree function is NULL, so kfree code is useless, delete it.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/mtd/ubi/eba.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mtd/ubi/eba.c b/drivers/mtd/ubi/eba.c
index 0edecfdbd01f..9c2840ffd2e9 100644
--- a/drivers/mtd/ubi/eba.c
+++ b/drivers/mtd/ubi/eba.c
@@ -142,7 +142,6 @@ struct ubi_eba_table *ubi_eba_create_table(struct ubi_volume *vol,
 	return tbl;
 
 err:
-	kfree(tbl->entries);
 	kfree(tbl);
 
 	return ERR_PTR(err);
-- 
2.22.0

