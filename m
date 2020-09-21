Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49936271CD7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 10:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgIUICn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 04:02:43 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:48580 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726643AbgIUICi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 04:02:38 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 21D26EA4AE943D9D3537;
        Mon, 21 Sep 2020 16:02:36 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Mon, 21 Sep 2020
 16:02:26 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH -next] sata, highbank: simplify the return expression of ahci_highbank_suspend
Date:   Mon, 21 Sep 2020 16:24:51 +0800
Message-ID: <20200921082451.2592033-1-liushixin2@huawei.com>
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
 drivers/ata/sata_highbank.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/ata/sata_highbank.c b/drivers/ata/sata_highbank.c
index ad3893c62572..64b2ef15ec19 100644
--- a/drivers/ata/sata_highbank.c
+++ b/drivers/ata/sata_highbank.c
@@ -571,7 +571,6 @@ static int ahci_highbank_suspend(struct device *dev)
 	struct ahci_host_priv *hpriv = host->private_data;
 	void __iomem *mmio = hpriv->mmio;
 	u32 ctl;
-	int rc;
 
 	if (hpriv->flags & AHCI_HFLAG_NO_SUSPEND) {
 		dev_err(dev, "firmware update required for suspend/resume\n");
@@ -588,11 +587,7 @@ static int ahci_highbank_suspend(struct device *dev)
 	writel(ctl, mmio + HOST_CTL);
 	readl(mmio + HOST_CTL); /* flush */
 
-	rc = ata_host_suspend(host, PMSG_SUSPEND);
-	if (rc)
-		return rc;
-
-	return 0;
+	return ata_host_suspend(host, PMSG_SUSPEND);
 }
 
 static int ahci_highbank_resume(struct device *dev)
-- 
2.25.1

