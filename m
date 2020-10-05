Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D84502837BE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 16:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgJEO2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 10:28:44 -0400
Received: from z5.mailgun.us ([104.130.96.5]:46740 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbgJEO2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 10:28:40 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601908120; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=4536qQz/JYk99Kzt4MFwTq6daCJzWCm4s1PZWssFp6c=; b=bQ1LFqe0Oatym65WAFhQAotNRY+UGDJRP2QRvvBq6Cng54bRY3yKsF3ZOmVIiV61NFh+cbQN
 xMBVsUJSAHQHwv1zWp9DMvXExfMXtoQuuubF98HZ2Zzv0D/nxBVeYoEqEYIl9JKzKAX68pez
 eoKfaohSmjl+C7Cje+OGH+Xcdu8=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5f7b2d953711fec7b18b7370 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 05 Oct 2020 14:28:37
 GMT
Sender: lkasam=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2A640C433CA; Mon,  5 Oct 2020 14:28:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from codeaurora.org (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: b_lkasam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9F343C433CB;
        Mon,  5 Oct 2020 14:28:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9F343C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=lkasam@codeaurora.org
From:   Laxminath Kasam <lkasam@codeaurora.org>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     srinivas.kandagatla@linaro.org,
        Laxminath Kasam <lkasam@codeaurora.org>
Subject: [PATCH v3] regmap: irq: Add support to clear ack registers
Date:   Mon,  5 Oct 2020 19:47:19 +0530
Message-Id: <1601907440-13373-1-git-send-email-lkasam@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For particular codec HWs have requirement to toggle interrupt clear
register twice 0->1->0. To accommodate it, need to add one more field
(clear_ack) in the regmap_irq struct and update regmap-irq driver to
support it.

Signed-off-by: Laxminath Kasam <lkasam@codeaurora.org>
---
Changes from v2:
Updated commit text
---
 drivers/base/regmap/regmap-irq.c | 33 ++++++++++++++++++++++++++++++++-
 include/linux/regmap.h           |  2 ++
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index 369a57e..ad5c2de 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -168,6 +168,14 @@ static void regmap_irq_sync_unlock(struct irq_data *data)
 				ret = regmap_write(map, reg, ~d->mask_buf[i]);
 			else
 				ret = regmap_write(map, reg, d->mask_buf[i]);
+			if (d->chip->clear_ack) {
+				if (d->chip->ack_invert && !ret)
+					ret = regmap_write(map, reg,
+							   d->mask_buf[i]);
+				else if (!ret)
+					ret = regmap_write(map, reg,
+							   ~d->mask_buf[i]);
+			}
 			if (ret != 0)
 				dev_err(d->map->dev, "Failed to ack 0x%x: %d\n",
 					reg, ret);
@@ -493,7 +501,20 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
 		if (data->status_buf[i] && (chip->ack_base || chip->use_ack)) {
 			reg = chip->ack_base +
 				(i * map->reg_stride * data->irq_reg_stride);
-			ret = regmap_write(map, reg, data->status_buf[i]);
+			if (chip->ack_invert)
+				ret = regmap_write(map, reg,
+						~data->status_buf[i]);
+			else
+				ret = regmap_write(map, reg,
+						data->status_buf[i]);
+			if (chip->clear_ack) {
+				if (chip->ack_invert && !ret)
+					ret = regmap_write(map, reg,
+							data->status_buf[i]);
+				else if (!ret)
+					ret = regmap_write(map, reg,
+							~data->status_buf[i]);
+			}
 			if (ret != 0)
 				dev_err(map->dev, "Failed to ack 0x%x: %d\n",
 					reg, ret);
@@ -722,6 +743,16 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 			else
 				ret = regmap_write(map, reg,
 					d->status_buf[i] & d->mask_buf[i]);
+			if (chip->clear_ack) {
+				if (chip->ack_invert && !ret)
+					ret = regmap_write(map, reg,
+						(d->status_buf[i] &
+						 d->mask_buf[i]));
+				else if (!ret)
+					ret = regmap_write(map, reg,
+						~(d->status_buf[i] &
+						  d->mask_buf[i]));
+			}
 			if (ret != 0) {
 				dev_err(map->dev, "Failed to ack 0x%x: %d\n",
 					reg, ret);
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 1970ed5..0701671 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1305,6 +1305,7 @@ struct regmap_irq_sub_irq_map {
  * @mask_invert: Inverted mask register: cleared bits are masked out.
  * @use_ack:     Use @ack register even if it is zero.
  * @ack_invert:  Inverted ack register: cleared bits for ack.
+ * @clear_ack:  Use this to set 1 and 0 or vice-versa to clear interrupts.
  * @wake_invert: Inverted wake register: cleared bits are wake enabled.
  * @type_invert: Invert the type flags.
  * @type_in_mask: Use the mask registers for controlling irq type. For
@@ -1353,6 +1354,7 @@ struct regmap_irq_chip {
 	bool mask_invert:1;
 	bool use_ack:1;
 	bool ack_invert:1;
+	bool clear_ack:1;
 	bool wake_invert:1;
 	bool runtime_pm:1;
 	bool type_invert:1;
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

