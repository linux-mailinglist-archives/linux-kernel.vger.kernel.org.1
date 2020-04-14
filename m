Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A20F61A7F65
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 16:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389345AbgDNORY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 10:17:24 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:47039 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389221AbgDNORJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 10:17:09 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.13]) by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee65e95c5c7b67-54bc1; Tue, 14 Apr 2020 22:16:39 +0800 (CST)
X-RM-TRANSID: 2ee65e95c5c7b67-54bc1
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.3.208.246])
        by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee75e95c5c5882-f3bd1;
        Tue, 14 Apr 2020 22:16:39 +0800 (CST)
X-RM-TRANSID: 2ee75e95c5c5882-f3bd1
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     minyard@acm.org, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Shengju Zhang <zhangshengju@cmss.chinamobile.com>
Subject: [PATCH] ipmi:bt-bmc: Fix some format issue of the code
Date:   Tue, 14 Apr 2020 22:18:14 +0800
Message-Id: <20200414141814.19048-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix some format issue of the code in bt-bmc.c

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
Signed-off-by: Shengju Zhang <zhangshengju@cmss.chinamobile.com>
---
 drivers/char/ipmi/bt-bmc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/char/ipmi/bt-bmc.c b/drivers/char/ipmi/bt-bmc.c
index 890ad55aa..cd0349bff 100644
--- a/drivers/char/ipmi/bt-bmc.c
+++ b/drivers/char/ipmi/bt-bmc.c
@@ -463,9 +463,9 @@ static int bt_bmc_probe(struct platform_device *pdev)
 	init_waitqueue_head(&bt_bmc->queue);
 
 	bt_bmc->miscdev.minor	= MISC_DYNAMIC_MINOR,
-		bt_bmc->miscdev.name	= DEVICE_NAME,
-		bt_bmc->miscdev.fops	= &bt_bmc_fops,
-		bt_bmc->miscdev.parent = dev;
+	bt_bmc->miscdev.name	= DEVICE_NAME,
+	bt_bmc->miscdev.fops	= &bt_bmc_fops,
+	bt_bmc->miscdev.parent = dev;
 	rc = misc_register(&bt_bmc->miscdev);
 	if (rc) {
 		dev_err(dev, "Unable to register misc device\n");
-- 
2.20.1.windows.1



