Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53E502A13C2
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 07:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgJaGEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 02:04:23 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:7000 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgJaGEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 02:04:22 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CNTCT4FWPzhdxV;
        Sat, 31 Oct 2020 14:04:21 +0800 (CST)
Received: from localhost (10.174.176.180) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Sat, 31 Oct 2020
 14:04:05 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <hminas@synopsys.com>, <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] usb: dwc2: Fix unused label warning
Date:   Sat, 31 Oct 2020 14:03:42 +0800
Message-ID: <20201031060342.43384-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.180]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/usb/dwc2/platform.c: In function ‘dwc2_driver_probe’:
drivers/usb/dwc2/platform.c:611:1: warning: label ‘error_debugfs’ defined but not used [-Wunused-label]
 error_debugfs:
 ^~~~~~~~~~~~~

Move label 'error_debugfs' to ifdef block.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/usb/dwc2/platform.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
index e2820676beb1..5f18acac7406 100644
--- a/drivers/usb/dwc2/platform.c
+++ b/drivers/usb/dwc2/platform.c
@@ -608,10 +608,13 @@ static int dwc2_driver_probe(struct platform_device *dev)
 #endif /* CONFIG_USB_DWC2_PERIPHERAL || CONFIG_USB_DWC2_DUAL_ROLE */
 	return 0;
 
+#if IS_ENABLED(CONFIG_USB_DWC2_PERIPHERAL) || \
+	IS_ENABLED(CONFIG_USB_DWC2_DUAL_ROLE)
 error_debugfs:
 	dwc2_debugfs_exit(hsotg);
 	if (hsotg->hcd_enabled)
 		dwc2_hcd_remove(hsotg);
+#endif
 error_drd:
 	dwc2_drd_exit(hsotg);
 
-- 
2.17.1

