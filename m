Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8E719EFEE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Apr 2020 06:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgDFEdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 00:33:31 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:3991 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgDFEda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 00:33:30 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.9]) by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee55e8ab0fd965-9aa61; Mon, 06 Apr 2020 12:33:03 +0800 (CST)
X-RM-TRANSID: 2ee55e8ab0fd965-9aa61
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.1.173.122])
        by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee55e8ab0fb2ea-b5e8c;
        Mon, 06 Apr 2020 12:33:03 +0800 (CST)
X-RM-TRANSID: 2ee55e8ab0fb2ea-b5e8c
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     minyard@acm.org, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH v2]ipmi:bt-bmc:Avoid unnecessary judgement
Date:   Mon,  6 Apr 2020 12:34:15 +0800
Message-Id: <20200406043415.12292-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this driver,only the platform_device and platform_driver
matches,can trigger bt_bmc_probe(),and the trigger mode is
just Device Tree.Thus remove redundant judgments.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
Changes from v1:
 - improve the commit message.

 drivers/char/ipmi/bt-bmc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/char/ipmi/bt-bmc.c b/drivers/char/ipmi/bt-bmc.c
index d36aeacb2..890ad55aa 100644
--- a/drivers/char/ipmi/bt-bmc.c
+++ b/drivers/char/ipmi/bt-bmc.c
@@ -430,9 +430,6 @@ static int bt_bmc_probe(struct platform_device *pdev)
 	struct device *dev;
 	int rc;
 
-	if (!pdev || !pdev->dev.of_node)
-		return -ENODEV;
-
 	dev = &pdev->dev;
 	dev_info(dev, "Found bt bmc device\n");
 
-- 
2.20.1.windows.1



