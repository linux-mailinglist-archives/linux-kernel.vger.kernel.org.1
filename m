Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C08AD27BBE1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 06:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725730AbgI2EYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 00:24:03 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:39192 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbgI2EYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 00:24:02 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601353440; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=P8gYl8gLUGbwwjZC8LE+UOZ0BMCTQ1I9NDbu9UvISug=; b=mSgS8zWlFoRUeoMCDCleKajS/R0sP7WusQWjGPVWFRt42HP1zb6j+ytDidBAblFft8ZLJKRg
 pv9L7oAr6YYJpa9Sqmm3m4R/otjRLcGNxC3y4XQILHNi4a+XOJxH5sDQ/B75BhF0qVEC+Vp/
 Hv+ECHwkmK++eEKcCsSydwCh+VY=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5f72b6debe59ebabf3237ed8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 29 Sep 2020 04:23:58
 GMT
Sender: rjliao=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0D8ACC433F1; Tue, 29 Sep 2020 04:23:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from rocky-Inspiron-7590.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rjliao)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8FAF7C433CA;
        Tue, 29 Sep 2020 04:23:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8FAF7C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=rjliao@codeaurora.org
From:   Rocky Liao <rjliao@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Rocky Liao <rjliao@codeaurora.org>
Subject: [PATCH v4] Bluetooth: btusb: Add Qualcomm Bluetooth SoC WCN6855 support
Date:   Tue, 29 Sep 2020 12:23:51 +0800
Message-Id: <20200929042351.2496-1-rjliao@codeaurora.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200925090829.3088-1-rjliao@codeaurora.org>
References: <20200925090829.3088-1-rjliao@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add support for WCN6855 i.e. patch and nvm download
support.

T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12   MxCh= 0
D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0cf3 ProdID=e600 Rev= 0.01
C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
I:  If#= 1 Alt= 6 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  63 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  63 Ivl=1ms
I:  If#= 1 Alt= 7 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  65 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  65 Ivl=1ms

Signed-off-by: Rocky Liao <rjliao@codeaurora.org>
---
 drivers/bluetooth/btusb.c | 66 +++++++++++++++++++++++++++++++--------
 1 file changed, 53 insertions(+), 13 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 9f294b941943..1005b6e8ff74 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -59,6 +59,7 @@ static struct usb_driver btusb_driver;
 #define BTUSB_MEDIATEK		0x200000
 #define BTUSB_WIDEBAND_SPEECH	0x400000
 #define BTUSB_VALID_LE_STATES   0x800000
+#define BTUSB_QCA_WCN6855	0x1000000
 
 static const struct usb_device_id btusb_table[] = {
 	/* Generic Bluetooth USB device */
@@ -291,6 +292,10 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x13d3, 0x3501), .driver_info = BTUSB_QCA_ROME |
 						     BTUSB_WIDEBAND_SPEECH },
 
+	/* QCA WCN6855 chipset */
+	{ USB_DEVICE(0x0cf3, 0xe600), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH },
+
 	/* Broadcom BCM2035 */
 	{ USB_DEVICE(0x0a5c, 0x2009), .driver_info = BTUSB_BCM92035 },
 	{ USB_DEVICE(0x0a5c, 0x200a), .driver_info = BTUSB_WRONG_SCO_MTU },
@@ -3409,6 +3414,27 @@ static int btusb_set_bdaddr_ath3012(struct hci_dev *hdev,
 	return 0;
 }
 
+static int btusb_set_bdaddr_wcn6855(struct hci_dev *hdev,
+				const bdaddr_t *bdaddr)
+{
+	struct sk_buff *skb;
+	u8 buf[6];
+	long ret;
+
+	memcpy(buf, bdaddr, sizeof(bdaddr_t));
+
+	skb = __hci_cmd_sync_ev(hdev, 0xfc14, sizeof(buf), buf,
+				HCI_EV_CMD_COMPLETE, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		ret = PTR_ERR(skb);
+		bt_dev_err(hdev, "Change address command failed (%ld)", ret);
+		return ret;
+	}
+	kfree_skb(skb);
+
+	return 0;
+}
+
 #define QCA_DFU_PACKET_LEN	4096
 
 #define QCA_GET_TARGET_VERSION	0x09
@@ -3428,7 +3454,8 @@ struct qca_version {
 } __packed;
 
 struct qca_rampatch_version {
-	__le16	rom_version;
+	__le16	rom_version_high;
+	__le16  rom_version_low;
 	__le16	patch_version;
 } __packed;
 
@@ -3440,12 +3467,14 @@ struct qca_device_info {
 };
 
 static const struct qca_device_info qca_devices_table[] = {
-	{ 0x00000100, 20, 4, 10 }, /* Rome 1.0 */
-	{ 0x00000101, 20, 4, 10 }, /* Rome 1.1 */
-	{ 0x00000200, 28, 4, 18 }, /* Rome 2.0 */
-	{ 0x00000201, 28, 4, 18 }, /* Rome 2.1 */
-	{ 0x00000300, 28, 4, 18 }, /* Rome 3.0 */
-	{ 0x00000302, 28, 4, 18 }, /* Rome 3.2 */
+	{ 0x00000100, 20, 4,  8 }, /* Rome 1.0 */
+	{ 0x00000101, 20, 4,  8 }, /* Rome 1.1 */
+	{ 0x00000200, 28, 4, 16 }, /* Rome 2.0 */
+	{ 0x00000201, 28, 4, 16 }, /* Rome 2.1 */
+	{ 0x00000300, 28, 4, 16 }, /* Rome 3.0 */
+	{ 0x00000302, 28, 4, 16 }, /* Rome 3.2 */
+	{ 0x00130100, 40, 4, 16 }, /* WCN6855 1.0 */
+	{ 0x00130200, 40, 4, 16 }, /* WCN6855 2.0 */
 };
 
 static int btusb_qca_send_vendor_req(struct usb_device *udev, u8 request,
@@ -3547,8 +3576,8 @@ static int btusb_setup_qca_load_rampatch(struct hci_dev *hdev,
 {
 	struct qca_rampatch_version *rver;
 	const struct firmware *fw;
-	u32 ver_rom, ver_patch;
-	u16 rver_rom, rver_patch;
+	u32 ver_rom, ver_patch, rver_rom;
+	u16 rver_rom_low, rver_rom_high, rver_patch;
 	char fwname[64];
 	int err;
 
@@ -3567,9 +3596,16 @@ static int btusb_setup_qca_load_rampatch(struct hci_dev *hdev,
 	bt_dev_info(hdev, "using rampatch file: %s", fwname);
 
 	rver = (struct qca_rampatch_version *)(fw->data + info->ver_offset);
-	rver_rom = le16_to_cpu(rver->rom_version);
+	rver_rom_low = le16_to_cpu(rver->rom_version_low);
 	rver_patch = le16_to_cpu(rver->patch_version);
 
+	if (ver_rom & ~0xffffU) {
+		rver_rom_high = le16_to_cpu(rver->rom_version_high);
+		rver_rom = le32_to_cpu(rver_rom_high << 16 | rver_rom_low);
+	} else {
+		rver_rom = rver_rom_low;
+	}
+
 	bt_dev_info(hdev, "QCA: patch rome 0x%x build 0x%x, "
 		    "firmware rome 0x%x build 0x%x",
 		    rver_rom, rver_patch, ver_rom, ver_patch);
@@ -3643,9 +3679,6 @@ static int btusb_setup_qca(struct hci_dev *hdev)
 		return err;
 
 	ver_rom = le32_to_cpu(ver.rom_version);
-	/* Don't care about high ROM versions */
-	if (ver_rom & ~0xffffU)
-		return 0;
 
 	for (i = 0; i < ARRAY_SIZE(qca_devices_table); i++) {
 		if (ver_rom == qca_devices_table[i].rom_version)
@@ -4081,6 +4114,13 @@ static int btusb_probe(struct usb_interface *intf,
 		btusb_check_needs_reset_resume(intf);
 	}
 
+	if (id->driver_info & BTUSB_QCA_WCN6855) {
+		data->setup_on_usb = btusb_setup_qca;
+		hdev->set_bdaddr = btusb_set_bdaddr_wcn6855;
+		hdev->cmd_timeout = btusb_qca_cmd_timeout;
+		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
+	}
+
 	if (id->driver_info & BTUSB_AMP) {
 		/* AMP controllers do not support SCO packets */
 		data->isoc = NULL;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project

