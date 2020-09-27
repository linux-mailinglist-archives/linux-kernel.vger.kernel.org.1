Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0972A27A148
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 15:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgI0Nxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 09:53:32 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:59586 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbgI0Nxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 09:53:31 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.11]) by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee35f709942f9b-dd0da; Sun, 27 Sep 2020 21:53:08 +0800 (CST)
X-RM-TRANSID: 2ee35f709942f9b-dd0da
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.0.144.153])
        by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee65f709942d77-83015;
        Sun, 27 Sep 2020 21:53:08 +0800 (CST)
X-RM-TRANSID: 2ee65f709942d77-83015
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Subject: [PATCH] usb: bdc: Fix unused assignment in bdc_probe()
Date:   Sun, 27 Sep 2020 21:53:04 +0800
Message-Id: <20200927135304.26036-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete unused initialized value of 'ret', because it will
be assigned by the function clk_prepare_enable().

Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/usb/gadget/udc/bdc/bdc_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/bdc/bdc_core.c b/drivers/usb/gadget/udc/bdc/bdc_core.c
index 9454f179e..f079c1fac 100644
--- a/drivers/usb/gadget/udc/bdc/bdc_core.c
+++ b/drivers/usb/gadget/udc/bdc/bdc_core.c
@@ -480,7 +480,7 @@ static void bdc_phy_exit(struct bdc *bdc)
 static int bdc_probe(struct platform_device *pdev)
 {
 	struct bdc *bdc;
-	int ret = -ENOMEM;
+	int ret;
 	int irq;
 	u32 temp;
 	struct device *dev = &pdev->dev;
-- 
2.20.1.windows.1



