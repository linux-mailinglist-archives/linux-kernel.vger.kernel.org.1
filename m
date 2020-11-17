Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 379CB2B59A0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 07:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgKQGQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 01:16:57 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7550 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgKQGQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 01:16:56 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CZwgr05y0zhXfr;
        Tue, 17 Nov 2020 14:16:40 +0800 (CST)
Received: from huawei.com (10.175.103.91) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Tue, 17 Nov 2020
 14:16:45 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <yangyingliang@huawei.com>
Subject: [PATCH] usb/max3421: fix return error code in max3421_probe()
Date:   Tue, 17 Nov 2020 14:15:00 +0800
Message-ID: <20201117061500.3454223-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

retval may be reassigned to 0 after max3421_of_vbus_en_pin(),
if allocate memory failed after this, max3421_probe() cann't
return ENOMEM, fix this by moving assign retval afther max3421_probe().

Fixes: 721fdc83b31b ("usb: max3421: Add devicetree support")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/usb/host/max3421-hcd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/max3421-hcd.c b/drivers/usb/host/max3421-hcd.c
index 0894f6caccb2..ebb8180b52ab 100644
--- a/drivers/usb/host/max3421-hcd.c
+++ b/drivers/usb/host/max3421-hcd.c
@@ -1847,7 +1847,7 @@ max3421_probe(struct spi_device *spi)
 	struct max3421_hcd *max3421_hcd;
 	struct usb_hcd *hcd = NULL;
 	struct max3421_hcd_platform_data *pdata = NULL;
-	int retval = -ENOMEM;
+	int retval;
 
 	if (spi_setup(spi) < 0) {
 		dev_err(&spi->dev, "Unable to setup SPI bus");
@@ -1889,6 +1889,7 @@ max3421_probe(struct spi_device *spi)
 		goto error;
 	}
 
+	retval = -ENOMEM;
 	hcd = usb_create_hcd(&max3421_hcd_desc, &spi->dev,
 			     dev_name(&spi->dev));
 	if (!hcd) {
-- 
2.25.1

