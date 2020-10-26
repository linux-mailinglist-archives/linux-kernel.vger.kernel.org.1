Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDBD8298914
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 10:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1772569AbgJZJG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 05:06:59 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:63555 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391070AbgJZJG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 05:06:59 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.3]) by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee35f96919b00c-e1f43; Mon, 26 Oct 2020 17:06:35 +0800 (CST)
X-RM-TRANSID: 2ee35f96919b00c-e1f43
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.112.105.130])
        by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee25f969198e03-26d43;
        Mon, 26 Oct 2020 17:06:35 +0800 (CST)
X-RM-TRANSID: 2ee25f969198e03-26d43
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com
Cc:     linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] usb: host: ehci-tegra: Fix error handling in tegra_ehci_probe()
Date:   Mon, 26 Oct 2020 17:06:57 +0800
Message-Id: <20201026090657.49988-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the function platform_get_irq() failed, the negative value
returned will not be detected here. So fix error handling in
tegra_ehci_probe().

Fixes: 79ad3b5add4a ("usb: host: Add EHCI driver for NVIDIA Tegra SoCs")
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/usb/host/ehci-tegra.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/ehci-tegra.c b/drivers/usb/host/ehci-tegra.c
index 75a075daf..7b0efaf15 100644
--- a/drivers/usb/host/ehci-tegra.c
+++ b/drivers/usb/host/ehci-tegra.c
@@ -479,9 +479,9 @@ static int tegra_ehci_probe(struct platform_device *pdev)
 	u_phy->otg->host = hcd_to_bus(hcd);
 
 	irq = platform_get_irq(pdev, 0);
-	if (!irq) {
-		err = -ENODEV;
-		goto cleanup_phy;
+	if (irq < 0) {
+		err = irq;
+		goto cleanup_phy;
 	}
 
 	otg_set_host(u_phy->otg, &hcd->self);
-- 
2.20.1.windows.1



