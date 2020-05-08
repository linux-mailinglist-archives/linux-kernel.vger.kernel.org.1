Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2081CA9E0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 May 2020 13:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbgEHLon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 May 2020 07:44:43 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:8079 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbgEHLom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 07:44:42 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.19]) by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee85eb54612030-594e9; Fri, 08 May 2020 19:44:19 +0800 (CST)
X-RM-TRANSID: 2ee85eb54612030-594e9
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.25.154.146])
        by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea5eb5460f44c-97f6d;
        Fri, 08 May 2020 19:44:17 +0800 (CST)
X-RM-TRANSID: 2eea5eb5460f44c-97f6d
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     stern@rowland.harvard.edu, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Subject: [PATCH] USB: host: ehci: Add error handling in ehci_mxc_drv_probe()
Date:   Fri,  8 May 2020 19:44:53 +0800
Message-Id: <20200508114453.15436-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function ehci_mxc_drv_probe() does not perform sufficient error
checking after executing platform_get_irq(), thus fix it.

Fixes: 7e8d5cd93fa ("USB: Add EHCI support for MX27 and MX31 based boards")
Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/usb/host/ehci-mxc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/host/ehci-mxc.c b/drivers/usb/host/ehci-mxc.c
index a1eb5ee77..a0b42ba59 100644
--- a/drivers/usb/host/ehci-mxc.c
+++ b/drivers/usb/host/ehci-mxc.c
@@ -50,6 +50,8 @@ static int ehci_mxc_drv_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
 
 	hcd = usb_create_hcd(&ehci_mxc_hc_driver, dev, dev_name(dev));
 	if (!hcd)
-- 
2.20.1.windows.1



