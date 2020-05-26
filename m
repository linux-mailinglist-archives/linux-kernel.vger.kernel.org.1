Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4F841BB69E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Apr 2020 08:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgD1Gco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 02:32:44 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3359 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726378AbgD1Gcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 02:32:43 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C5E02F89E18EF037C7EA;
        Tue, 28 Apr 2020 14:32:39 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Tue, 28 Apr 2020
 14:32:29 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] uio: remove unneeded variable "ret" in uio_dmem_genirq_open
Date:   Tue, 28 Apr 2020 14:31:55 +0800
Message-ID: <20200428063155.42349-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:

drivers/uio/uio_dmem_genirq.c:47:5-8: Unneeded variable: "ret". Return
"0" on line 71

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/uio/uio_dmem_genirq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/uio/uio_dmem_genirq.c b/drivers/uio/uio_dmem_genirq.c
index f6ab3f28c838..6e27fe4fcca3 100644
--- a/drivers/uio/uio_dmem_genirq.c
+++ b/drivers/uio/uio_dmem_genirq.c
@@ -44,7 +44,6 @@ static int uio_dmem_genirq_open(struct uio_info *info, struct inode *inode)
 {
 	struct uio_dmem_genirq_platdata *priv = info->priv;
 	struct uio_mem *uiomem;
-	int ret = 0;
 	int dmem_region = priv->dmem_region_start;
 
 	uiomem = &priv->uioinfo->mem[priv->dmem_region_start];
@@ -68,7 +67,7 @@ static int uio_dmem_genirq_open(struct uio_info *info, struct inode *inode)
 	mutex_unlock(&priv->alloc_lock);
 	/* Wait until the Runtime PM code has woken up the device */
 	pm_runtime_get_sync(&priv->pdev->dev);
-	return ret;
+	return 0;
 }
 
 static int uio_dmem_genirq_release(struct uio_info *info, struct inode *inode)
-- 
2.21.1

