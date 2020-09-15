Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87F43269C3F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 05:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbgIODEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 23:04:08 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12282 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726045AbgIODD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 23:03:56 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 12998763F03EE3FFA957;
        Tue, 15 Sep 2020 11:03:54 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Tue, 15 Sep 2020
 11:03:43 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jens Axboe <axboe@kernel.dk>
CC:     <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH -next] ata: pata_samsung_cf: simplify the return expression of pata_s3c_wait_after_reset()
Date:   Tue, 15 Sep 2020 11:26:21 +0800
Message-ID: <20200915032621.1772254-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the return expression.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 drivers/ata/pata_samsung_cf.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/ata/pata_samsung_cf.c b/drivers/ata/pata_samsung_cf.c
index 3da0e8e30286..5fd5c79e1543 100644
--- a/drivers/ata/pata_samsung_cf.c
+++ b/drivers/ata/pata_samsung_cf.c
@@ -340,19 +340,14 @@ static unsigned int pata_s3c_devchk(struct ata_port *ap,
 static int pata_s3c_wait_after_reset(struct ata_link *link,
 		unsigned long deadline)
 {
-	int rc;
-
 	ata_msleep(link->ap, ATA_WAIT_AFTER_RESET);
 
-	/* always check readiness of the master device */
-	rc = ata_sff_wait_ready(link, deadline);
-	/* -ENODEV means the odd clown forgot the D7 pulldown resistor
+	/*
+	 * always check readiness of the master device.
+	 * -ENODEV means the odd clown forgot the D7 pulldown resistor
 	 * and TF status is 0xff, bail out on it too.
 	 */
-	if (rc)
-		return rc;
-
-	return 0;
+	return ata_sff_wait_ready(link, deadline);
 }
 
 /*
-- 
2.25.1

