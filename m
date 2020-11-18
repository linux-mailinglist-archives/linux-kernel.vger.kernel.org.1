Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 911292B7DE6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 13:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgKRMwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 07:52:53 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:23005 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgKRMwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 07:52:53 -0500
Received: from ironmsg07-lv.qualcomm.com (HELO ironmsg07-lv.qulacomm.com) ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 18 Nov 2020 04:52:52 -0800
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg07-lv.qulacomm.com with ESMTP/TLS/AES256-SHA; 18 Nov 2020 04:52:50 -0800
X-QCInternal: smtphost
Received: from gubbaven-linux.qualcomm.com ([10.206.64.32])
  by ironmsg01-blr.qualcomm.com with ESMTP; 18 Nov 2020 18:22:26 +0530
Received: by gubbaven-linux.qualcomm.com (Postfix, from userid 2365015)
        id 4184A21D6E; Wed, 18 Nov 2020 18:22:25 +0530 (IST)
From:   Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org, bgodavar@codeaurora.org,
        rjliao@codeaurora.org, hbandi@codeaurora.org,
        abhishekpandit@chromium.org,
        Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>
Subject: [PATCH v2] Bluetooth: btqca: Add support to read FW build version for WCN3991 BTSoC
Date:   Wed, 18 Nov 2020 18:22:23 +0530
Message-Id: <1605703943-25980-1-git-send-email-gubbaven@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to read FW build version for WCN3991 BTSoC

Signed-off-by: Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>
---
 drivers/bluetooth/btqca.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/btqca.h |  3 +++
 2 files changed, 60 insertions(+)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index ce9dcff..dfd7ff7 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -101,6 +101,56 @@ int qca_read_soc_version(struct hci_dev *hdev, u32 *soc_version,
 }
 EXPORT_SYMBOL_GPL(qca_read_soc_version);
 
+static int qca_read_fw_build_info(struct hci_dev *hdev)
+{
+	struct sk_buff *skb;
+	struct edl_event_hdr *edl;
+	char cmd;
+	int err = 0;
+	char build_label[QCA_FW_BUILD_VER_LEN];
+	int build_lbl_len;
+
+	bt_dev_dbg(hdev, "QCA read fw build info");
+
+	cmd = EDL_GET_BUILD_INFO_CMD;
+	skb = __hci_cmd_sync_ev(hdev, EDL_PATCH_CMD_OPCODE, EDL_PATCH_CMD_LEN,
+				&cmd, HCI_EV_VENDOR, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		err = PTR_ERR(skb);
+		bt_dev_err(hdev, "Reading QCA fw build info failed (%d)",
+			   err);
+		return err;
+	}
+
+	edl = (struct edl_event_hdr *)(skb->data);
+	if (!edl) {
+		bt_dev_err(hdev, "QCA read fw build info with no header");
+		err = -EILSEQ;
+		goto out;
+	}
+
+	if (edl->cresp != EDL_CMD_REQ_RES_EVT ||
+	    edl->rtype != EDL_GET_BUILD_INFO_CMD) {
+		bt_dev_err(hdev, "QCA Wrong packet received %d %d", edl->cresp,
+			   edl->rtype);
+		err = -EIO;
+		goto out;
+	}
+
+	build_lbl_len = edl->data[0];
+	memcpy(build_label, &edl->data[1], build_lbl_len);
+	*(build_label + build_lbl_len) = '\0';
+
+	bt_dev_info(hdev, "BT SoC FW Build info: %s", build_label);
+
+out:
+	kfree_skb(skb);
+	if (err)
+		bt_dev_err(hdev, "QCA read fw build info failed (%d)", err);
+
+	return err;
+}
+
 static int qca_send_reset(struct hci_dev *hdev)
 {
 	struct sk_buff *skb;
@@ -520,6 +570,13 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 		return err;
 	}
 
+	if (soc_type == QCA_WCN3991) {
+		/* get fw build info */
+		err = qca_read_fw_build_info(hdev);
+		if (err < 0)
+			return err;
+	}
+
 	bt_dev_info(hdev, "QCA setup on UART is completed");
 
 	return 0;
diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
index d81b74c..375c7fc 100644
--- a/drivers/bluetooth/btqca.h
+++ b/drivers/bluetooth/btqca.h
@@ -11,6 +11,7 @@
 #define EDL_PATCH_CMD_LEN		(1)
 #define EDL_PATCH_VER_REQ_CMD		(0x19)
 #define EDL_PATCH_TLV_REQ_CMD		(0x1E)
+#define EDL_GET_BUILD_INFO_CMD		(0x20)
 #define EDL_NVM_ACCESS_SET_REQ_CMD	(0x01)
 #define MAX_SIZE_PER_TLV_SEGMENT	(243)
 #define QCA_PRE_SHUTDOWN_CMD		(0xFC08)
@@ -34,6 +35,8 @@
 #define QCA_HCI_CC_OPCODE		0xFC00
 #define QCA_HCI_CC_SUCCESS		0x00
 
+#define QCA_FW_BUILD_VER_LEN		255
+
 enum qca_baudrate {
 	QCA_BAUDRATE_115200 	= 0,
 	QCA_BAUDRATE_57600,
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

