Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC9E92E751D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 00:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgL2XEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 18:04:34 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:45015 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgL2XEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 18:04:30 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1609283047; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=2d0I99qrwmmdvzEFtybxhPdqQAQhHjHkB4hWT6pek3A=; b=I7XeRcg/Tb3/1dDO3PiSegxMixpj32aMaVsCiJmCYeanfmimgqBZ3iK7BkR6w5M5CkQOo4hJ
 uCHTtZb/3CZZbpbxaG6qyzBnxeNAUxYC1DvpSYWoEITx/0eD86m9yzRkSjog5g7kN296ij1g
 dYlKlU2wxbiFRrZYjiCIPw/6Jno=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5febb5cadb8e07fa6ce10c28 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 29 Dec 2020 23:03:38
 GMT
Sender: wcheng=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1925BC43461; Tue, 29 Dec 2020 23:03:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from wcheng-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 244D1C43463;
        Tue, 29 Dec 2020 23:03:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 244D1C43463
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=wcheng@codeaurora.org
From:   Wesley Cheng <wcheng@codeaurora.org>
To:     peter.chen@nxp.com, balbi@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Wesley Cheng <wcheng@codeaurora.org>
Subject: [PATCH 3/3] usb: gadget: configfs: Add a specific configFS reset callback
Date:   Tue, 29 Dec 2020 15:03:31 -0800
Message-Id: <1609283011-21997-4-git-send-email-wcheng@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1609283011-21997-1-git-send-email-wcheng@codeaurora.org>
References: <1609283011-21997-1-git-send-email-wcheng@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order for configFS based USB gadgets to set the proper charge current
for bus reset scenarios, expose a separate reset callback to set the
current to 100mA based on the USB battery charging specification.

Reviewed-by: Peter Chen <peter.chen@nxp.com>
Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
---
 drivers/usb/gadget/configfs.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
index 56051bb97349..80ca7ff2fb97 100644
--- a/drivers/usb/gadget/configfs.c
+++ b/drivers/usb/gadget/configfs.c
@@ -1481,6 +1481,28 @@ static void configfs_composite_disconnect(struct usb_gadget *gadget)
 	spin_unlock_irqrestore(&gi->spinlock, flags);
 }
 
+static void configfs_composite_reset(struct usb_gadget *gadget)
+{
+	struct usb_composite_dev *cdev;
+	struct gadget_info *gi;
+	unsigned long flags;
+
+	cdev = get_gadget_data(gadget);
+	if (!cdev)
+		return;
+
+	gi = container_of(cdev, struct gadget_info, cdev);
+	spin_lock_irqsave(&gi->spinlock, flags);
+	cdev = get_gadget_data(gadget);
+	if (!cdev || gi->unbind) {
+		spin_unlock_irqrestore(&gi->spinlock, flags);
+		return;
+	}
+
+	composite_reset(gadget);
+	spin_unlock_irqrestore(&gi->spinlock, flags);
+}
+
 static void configfs_composite_suspend(struct usb_gadget *gadget)
 {
 	struct usb_composite_dev *cdev;
@@ -1530,7 +1552,7 @@ static const struct usb_gadget_driver configfs_driver_template = {
 	.unbind         = configfs_composite_unbind,
 
 	.setup          = configfs_composite_setup,
-	.reset          = configfs_composite_disconnect,
+	.reset          = configfs_composite_reset,
 	.disconnect     = configfs_composite_disconnect,
 
 	.suspend	= configfs_composite_suspend,
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

