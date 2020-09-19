Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C836A270C4A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 11:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgISJqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Sep 2020 05:46:44 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54814 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726202AbgISJqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Sep 2020 05:46:36 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D875968D08076370B470;
        Sat, 19 Sep 2020 17:46:33 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Sat, 19 Sep 2020
 17:46:26 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Liu Shixin" <liushixin2@huawei.com>
Subject: [PATCH -next] mtd: vmu-flash: simplify the return expression of probe_maple_vmu
Date:   Sat, 19 Sep 2020 18:08:54 +0800
Message-ID: <20200919100854.1639267-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the return expression.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 drivers/mtd/maps/vmu-flash.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/mtd/maps/vmu-flash.c b/drivers/mtd/maps/vmu-flash.c
index 177bf134e189..588e82de581c 100644
--- a/drivers/mtd/maps/vmu-flash.c
+++ b/drivers/mtd/maps/vmu-flash.c
@@ -772,7 +772,6 @@ static void vmu_file_error(struct maple_device *mdev, void *recvbuf)
 
 static int probe_maple_vmu(struct device *dev)
 {
-	int error;
 	struct maple_device *mdev = to_maple_dev(dev);
 	struct maple_driver *mdrv = to_maple_driver(dev->driver);
 
@@ -780,11 +779,7 @@ static int probe_maple_vmu(struct device *dev)
 	mdev->fileerr_handler = vmu_file_error;
 	mdev->driver = mdrv;
 
-	error = vmu_connect(mdev);
-	if (error)
-		return error;
-
-	return 0;
+	return vmu_connect(mdev);
 }
 
 static int remove_maple_vmu(struct device *dev)
-- 
2.25.1

