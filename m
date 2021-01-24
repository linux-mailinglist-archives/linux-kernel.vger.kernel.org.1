Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51970301CF1
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 16:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbhAXPIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 10:08:45 -0500
Received: from m12-11.163.com ([220.181.12.11]:36670 "EHLO m12-11.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbhAXPIm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 10:08:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=iLE0g
        06xU+6exRMJLJkHediCAJdjAzK+BXU4PQJz5OE=; b=VFRu3/UdarHnjMF1ks6VH
        EXR02VTy0FlKvj84irDvDC3qRDtRifi7kE3alsvWZptEQ0qnkmJQT1JPRYdITTQP
        FtmUuJKHzlmkWWetXGU0yrIqX8OkjY7XFODSz5PbUrrZf1gz7/qx6yvwA3SP3jfE
        TviO86M5HYmjQTJJHWAw74=
Received: from yangjunlin.ccdomain.com (unknown [119.137.52.0])
        by smtp7 (Coremail) with SMTP id C8CowAA3AsK+dg1gZ+ePKQ--.25720S2;
        Sun, 24 Jan 2021 21:31:43 +0800 (CST)
From:   angkery <angkery@163.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Junlin Yang <yangjunlin@yulong.com>
Subject: [PATCH v2] usb: typec: tcpci_maxim: remove redundant assignment
Date:   Sun, 24 Jan 2021 21:31:37 +0800
Message-Id: <20210124133137.1468-1-angkery@163.com>
X-Mailer: git-send-email 2.24.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C8CowAA3AsK+dg1gZ+ePKQ--.25720S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAr4xZr4fXr43AFy3Cr13XFb_yoW5XFWfp3
        W8AFZrCFZ5G39Iq34UAan5ZFn0gr1fK3yxZ3y8K340qw1Yqrs0ya1UJF1UXF1rArWkJ345
        ArWjqFy8uF40qFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jRjgcUUUUU=
X-Originating-IP: [119.137.52.0]
X-CM-SenderInfo: 5dqjyvlu16il2tof0z/xtbBRh8kI13l+Y2BLAAAs-
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Junlin Yang <yangjunlin@yulong.com>

PTR_ERR(chip->tcpci) has been used as a return value,
it is not necessary to assign it to ret, so remove it.
And add terminating '\n' to the formats where missed too.

Signed-off-by: Junlin Yang <yangjunlin@yulong.com>
---
v2: add terminating '\n' to the formats where missed too.

 drivers/usb/typec/tcpm/tcpci_maxim.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpci_maxim.c b/drivers/usb/typec/tcpm/tcpci_maxim.c
index 3192663..5d7463c 100644
--- a/drivers/usb/typec/tcpm/tcpci_maxim.c
+++ b/drivers/usb/typec/tcpm/tcpci_maxim.c
@@ -158,7 +158,7 @@ static void process_rx(struct max_tcpci_chip *chip, u16 status)
 	 */
 	ret = regmap_raw_read(chip->data.regmap, TCPC_RX_BYTE_CNT, rx_buf, 2);
 	if (ret < 0) {
-		dev_err(chip->dev, "TCPC_RX_BYTE_CNT read failed ret:%d", ret);
+		dev_err(chip->dev, "TCPC_RX_BYTE_CNT read failed ret:%d\n", ret);
 		return;
 	}
 
@@ -167,13 +167,13 @@ static void process_rx(struct max_tcpci_chip *chip, u16 status)
 
 	if (count == 0 || frame_type != TCPC_RX_BUF_FRAME_TYPE_SOP) {
 		max_tcpci_write16(chip, TCPC_ALERT, TCPC_ALERT_RX_STATUS);
-		dev_err(chip->dev, "%s", count ==  0 ? "error: count is 0" :
+		dev_err(chip->dev, "%s\n", count ==  0 ? "error: count is 0" :
 			"error frame_type is not SOP");
 		return;
 	}
 
 	if (count > sizeof(struct pd_message) || count + 1 > TCPC_RECEIVE_BUFFER_LEN) {
-		dev_err(chip->dev, "Invalid TCPC_RX_BYTE_CNT %d", count);
+		dev_err(chip->dev, "Invalid TCPC_RX_BYTE_CNT %d\n", count);
 		return;
 	}
 
@@ -184,7 +184,7 @@ static void process_rx(struct max_tcpci_chip *chip, u16 status)
 	count += 1;
 	ret = regmap_raw_read(chip->data.regmap, TCPC_RX_BYTE_CNT, rx_buf, count);
 	if (ret < 0) {
-		dev_err(chip->dev, "Error: TCPC_RX_BYTE_CNT read failed: %d", ret);
+		dev_err(chip->dev, "Error: TCPC_RX_BYTE_CNT read failed: %d\n", ret);
 		return;
 	}
 
@@ -317,7 +317,7 @@ static irqreturn_t _max_tcpci_irq(struct max_tcpci_chip *chip, u16 status)
 			return ret;
 
 		if (reg_status & TCPC_SINK_FAST_ROLE_SWAP) {
-			dev_info(chip->dev, "FRS Signal");
+			dev_info(chip->dev, "FRS Signal\n");
 			tcpm_sink_frs(chip->port);
 		}
 	}
@@ -460,8 +460,7 @@ static int max_tcpci_probe(struct i2c_client *client, const struct i2c_device_id
 	max_tcpci_init_regs(chip);
 	chip->tcpci = tcpci_register_port(chip->dev, &chip->data);
 	if (IS_ERR(chip->tcpci)) {
-		dev_err(&client->dev, "TCPCI port registration failed");
-		ret = PTR_ERR(chip->tcpci);
+		dev_err(&client->dev, "TCPCI port registration failed\n");
 		return PTR_ERR(chip->tcpci);
 	}
 	chip->port = tcpci_get_tcpm_port(chip->tcpci);
-- 
1.9.1

