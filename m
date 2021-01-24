Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0463301DDA
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 18:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbhAXRRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 12:17:25 -0500
Received: from m12-11.163.com ([220.181.12.11]:41407 "EHLO m12-11.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725550AbhAXRRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 12:17:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=nnGPu
        W3JEtFab1luo5EYdxjZ4kiRtOiGmSD4yFmXKAA=; b=Mzq+TGyCMbLcMCIO5ampQ
        uut9pTl3xDi6447z3+ahq+ayirrbySwaQNkugztT+HFGg1WVyq9u2VX5x35qedlz
        RUol0PagvC8QWZlytJrra7ZmMz9GZC3qfLMKx2GQSPX1mu2zlZpxwFCcqu2usPdd
        5wn6pboSq/BEDFo+CxZuLo=
Received: from yangjunlin.ccdomain.com (unknown [218.17.89.92])
        by smtp7 (Coremail) with SMTP id C8CowAAn3Ku1hg1g_NCWKQ--.25582S2;
        Sun, 24 Jan 2021 22:39:50 +0800 (CST)
From:   angkery <angkery@163.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Junlin Yang <yangjunlin@yulong.com>
Subject: [PATCH v3 2/2] usb: typec: tcpci_maxim: add terminating newlines to logging
Date:   Sun, 24 Jan 2021 22:39:47 +0800
Message-Id: <20210124143947.1688-1-angkery@163.com>
X-Mailer: git-send-email 2.24.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C8CowAAn3Ku1hg1g_NCWKQ--.25582S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAr4fXF17Cr4fWry8ZF4Dtwb_yoW5GF43p3
        W5AFW7AFZ5G39Ig345AFs5ZFn09r4fK3yxZ3y8K340q3WYqrs8ta1UJF1jqF1rArWkJ343
        A3yjqFy8uF40qFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07bVsqAUUUUU=
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 5dqjyvlu16il2tof0z/xtbBCRckI13l+ACCGAAAsD
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Junlin Yang <yangjunlin@yulong.com>

Add terminating '\n' to the formats where missed.

Signed-off-by: Junlin Yang <yangjunlin@yulong.com>
---
v3:Modify it again and submit it separately from patch 1.

 drivers/usb/typec/tcpm/tcpci_maxim.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpci_maxim.c b/drivers/usb/typec/tcpm/tcpci_maxim.c
index 7f54f51a..5d7463c 100644
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
@@ -460,7 +460,7 @@ static int max_tcpci_probe(struct i2c_client *client, const struct i2c_device_id
 	max_tcpci_init_regs(chip);
 	chip->tcpci = tcpci_register_port(chip->dev, &chip->data);
 	if (IS_ERR(chip->tcpci)) {
-		dev_err(&client->dev, "TCPCI port registration failed");
+		dev_err(&client->dev, "TCPCI port registration failed\n");
 		return PTR_ERR(chip->tcpci);
 	}
 	chip->port = tcpci_get_tcpm_port(chip->tcpci);
-- 
1.9.1

