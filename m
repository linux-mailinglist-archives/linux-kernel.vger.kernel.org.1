Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF7F29E054
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 02:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729795AbgJ1WFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:05:04 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6565 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729359AbgJ1WCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:02:21 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CLhyz57XzzhZ6B;
        Wed, 28 Oct 2020 16:47:23 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Wed, 28 Oct 2020 16:47:10 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <kishon@ti.com>, <vkoul@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] phy: cpcap-usb: Use IRQF_ONESHOT
Date:   Wed, 28 Oct 2020 16:59:09 +0800
Message-ID: <1603875549-107500-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes coccicheck error:

./drivers/phy/motorola/phy-cpcap-usb.c:365:9-34: ERROR:
Threaded IRQ with no primary handler requested without IRQF_ONESHOT

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/phy/motorola/phy-cpcap-usb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/motorola/phy-cpcap-usb.c b/drivers/phy/motorola/phy-cpcap-usb.c
index 089db0d..442522b 100644
--- a/drivers/phy/motorola/phy-cpcap-usb.c
+++ b/drivers/phy/motorola/phy-cpcap-usb.c
@@ -364,7 +364,8 @@ static int cpcap_usb_init_irq(struct platform_device *pdev,
 
 	error = devm_request_threaded_irq(ddata->dev, irq, NULL,
 					  cpcap_phy_irq_thread,
-					  IRQF_SHARED,
+					  IRQF_SHARED |
+					  IRQF_ONESHOT,
 					  name, ddata);
 	if (error) {
 		dev_err(ddata->dev, "could not get irq %s: %i\n",
-- 
2.6.2

