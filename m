Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71B32242CCB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Aug 2020 18:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbgHLP74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Aug 2020 11:59:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:45684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726568AbgHLP5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 11:57:00 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B14822B43;
        Wed, 12 Aug 2020 15:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597247819;
        bh=Q90/lhBcwKMXxfqLcVtLbNk5zObWINvEzJPxwPfIcUw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SK++IBi5ZsxA0Kn/J1gzhJ/6YcDViQcaovoUEnop07BAtmx83tAtQd9orQJ+uvxZK
         KnRCj2kRredCKX8h2TOxjqsGl568bDnm7SG8urLZLmVILgQJ56HpEZWFXkdK6yVDwQ
         +OD1SZyZJavT7hnOe0+Ahr6oKjdJyM1fl8EJJjb8=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k5t7Z-005t5t-Mj; Wed, 12 Aug 2020 17:56:57 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH 08/44] staging: spmi: hisi-spmi-controller: fix the dev_foo() logic
Date:   Wed, 12 Aug 2020 17:56:18 +0200
Message-Id: <675327edf167c4352ece6ea571645edb9a84e51c.1597247164.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597247164.git.mchehab+huawei@kernel.org>
References: <cover.1597247164.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now, driver is printing some messages as:

	[   33.833026] (NULL device *): spmi_read_cmd: id:0 addr:0x17, read value: 00

This is because dev_foo() are not using a device with a name
set. Change the logic for it to print it right.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../staging/hikey9xx/hisi-spmi-controller.c   | 41 ++++++++++---------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/hikey9xx/hisi-spmi-controller.c b/drivers/staging/hikey9xx/hisi-spmi-controller.c
index e996114bc717..153bcdb0cde4 100644
--- a/drivers/staging/hikey9xx/hisi-spmi-controller.c
+++ b/drivers/staging/hikey9xx/hisi-spmi-controller.c
@@ -102,7 +102,8 @@ struct spmi_controller_dev {
 	u32			channel;
 };
 
-static int spmi_controller_wait_for_done(struct spmi_controller_dev *ctrl_dev,
+static int spmi_controller_wait_for_done(struct device *dev,
+					 struct spmi_controller_dev *ctrl_dev,
 					 void __iomem *base, u8 sid, u16 addr)
 {
 	u32 status = 0;
@@ -117,19 +118,17 @@ static int spmi_controller_wait_for_done(struct spmi_controller_dev *ctrl_dev,
 
 		if (status & SPMI_APB_TRANS_DONE) {
 			if (status & SPMI_APB_TRANS_FAIL) {
-				dev_err(ctrl_dev->dev,
-					"%s: transaction failed (0x%x)\n",
+				dev_err(dev, "%s: transaction failed (0x%x)\n",
 					__func__, status);
 				return -EIO;
 			}
+			dev_dbg(dev, "%s: status 0x%x\n", __func__, status);
 			return 0;
 		}
 		udelay(1);
 	}
 
-	dev_err(ctrl_dev->dev,
-		"%s: timeout, status 0x%x\n",
-		__func__, status);
+	dev_err(dev, "%s: timeout, status 0x%x\n", __func__, status);
 	return -ETIMEDOUT;
 }
 
@@ -145,9 +144,9 @@ static int spmi_read_cmd(struct spmi_controller *ctrl,
 	u8 op_code, i;
 
 	if (bc > SPMI_CONTROLLER_MAX_TRANS_BYTES) {
-		dev_err(spmi_controller->dev
-		, "spmi_controller supports 1..%d bytes per trans, but:%ld requested"
-					, SPMI_CONTROLLER_MAX_TRANS_BYTES, bc);
+		dev_err(&ctrl->dev,
+			"spmi_controller supports 1..%d bytes per trans, but:%ld requested",
+			SPMI_CONTROLLER_MAX_TRANS_BYTES, bc);
 		return  -EINVAL;
 	}
 
@@ -159,7 +158,7 @@ static int spmi_read_cmd(struct spmi_controller *ctrl,
 	} else if (opc == SPMI_CMD_EXT_READL) {
 		op_code = SPMI_CMD_EXT_REG_READ_L;
 	} else {
-		dev_err(spmi_controller->dev, "invalid read cmd 0x%x", opc);
+		dev_err(&ctrl->dev, "invalid read cmd 0x%x", opc);
 		return -EINVAL;
 	}
 
@@ -173,7 +172,7 @@ static int spmi_read_cmd(struct spmi_controller *ctrl,
 
 	writel(cmd, spmi_controller->base + chnl_ofst + SPMI_APB_SPMI_CMD_BASE_ADDR);
 
-	rc = spmi_controller_wait_for_done(spmi_controller,
+	rc = spmi_controller_wait_for_done(&ctrl->dev, spmi_controller,
 					   spmi_controller->base, sid, addr);
 	if (rc)
 		goto done;
@@ -195,10 +194,11 @@ static int spmi_read_cmd(struct spmi_controller *ctrl,
 done:
 	spin_unlock_irqrestore(&spmi_controller->lock, flags);
 	if (rc)
-		dev_err(spmi_controller->dev, "spmi read wait timeout op:0x%x sid:%d addr:0x%x bc:%ld\n",
+		dev_err(&ctrl->dev,
+			"spmi read wait timeout op:0x%x sid:%d addr:0x%x bc:%ld\n",
 			opc, sid, addr, bc + 1);
 	else
-		dev_dbg(spmi_controller->dev, "%s: id:%d addr:0x%x, read value: %*ph\n",
+		dev_dbg(&ctrl->dev, "%s: id:%d addr:0x%x, read value: %*ph\n",
 			__func__, sid, addr, (int)bc, __buf);
 
 	return rc;
@@ -216,9 +216,9 @@ static int spmi_write_cmd(struct spmi_controller *ctrl,
 	u8 op_code, i;
 
 	if (bc > SPMI_CONTROLLER_MAX_TRANS_BYTES) {
-		dev_err(spmi_controller->dev
-		, "spmi_controller supports 1..%d bytes per trans, but:%ld requested"
-					, SPMI_CONTROLLER_MAX_TRANS_BYTES, bc);
+		dev_err(&ctrl->dev,
+			"spmi_controller supports 1..%d bytes per trans, but:%ld requested",
+			SPMI_CONTROLLER_MAX_TRANS_BYTES, bc);
 		return  -EINVAL;
 	}
 
@@ -230,7 +230,7 @@ static int spmi_write_cmd(struct spmi_controller *ctrl,
 	} else if (opc == SPMI_CMD_EXT_WRITEL) {
 		op_code = SPMI_CMD_EXT_REG_WRITE_L;
 	} else {
-		dev_err(spmi_controller->dev, "invalid write cmd 0x%x", opc);
+		dev_err(&ctrl->dev, "invalid write cmd 0x%x", opc);
 		return -EINVAL;
 	}
 
@@ -262,14 +262,15 @@ static int spmi_write_cmd(struct spmi_controller *ctrl,
 	/* Start the transaction */
 	writel(cmd, spmi_controller->base + chnl_ofst + SPMI_APB_SPMI_CMD_BASE_ADDR);
 
-	rc = spmi_controller_wait_for_done(spmi_controller, spmi_controller->base, sid, addr);
+	rc = spmi_controller_wait_for_done(&ctrl->dev, spmi_controller,
+					   spmi_controller->base, sid, addr);
 	spin_unlock_irqrestore(&spmi_controller->lock, flags);
 
 	if (rc)
-		dev_err(spmi_controller->dev, "spmi write wait timeout op:0x%x sid:%d addr:0x%x bc:%ld\n",
+		dev_err(&ctrl->dev, "spmi write wait timeout op:0x%x sid:%d addr:0x%x bc:%ld\n",
 			opc, sid, addr, bc);
 	else
-		dev_dbg(spmi_controller->dev, "%s: id:%d addr:0x%x, wrote value: %*ph\n",
+		dev_dbg(&ctrl->dev, "%s: id:%d addr:0x%x, wrote value: %*ph\n",
 			__func__, sid, addr, (int)bc, __buf);
 
 	return rc;
-- 
2.26.2

