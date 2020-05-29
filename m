Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77C831E7295
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 04:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406783AbgE2C3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 22:29:30 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:26557 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405031AbgE2C33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 22:29:29 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590719368; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=6ZkZeLjBfTWlGAiLQK4hHlaxQJ7Mx2KTNta8bDJGGoU=; b=LN13hocvMrOzYJXYlyxPF8M61JrNQ567sUYdVz+nxNtq4PU2a25qrUHedwcgWuZgqZByD5Q5
 d6abQYRNfO92g4KRslkH3CY6YqzxUKRdIlGPabgtnNKR6J0b6OkY+0Oxy7/K5fVSUQzjwhsf
 GJtVyhj4IKVBlUfFOFnwHsZ6enw=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5ed073864776d1da6d7d0714 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 29 May 2020 02:29:26
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9E3FAC433CA; Fri, 29 May 2020 02:29:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from zijuhu-gv.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: zijuhu)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CA4B3C433C6;
        Fri, 29 May 2020 02:29:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CA4B3C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=zijuhu@codeaurora.org
From:   Zijun Hu <zijuhu@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, bgodavar@codeaurora.org,
        c-hbandi@codeaurora.org, hemantg@codeaurora.org, mka@chromium.org,
        rjliao@codeaurora.org, zijuhu@codeaurora.org
Subject: [PATCH v1] Bluetooth: hci_qca: Fix qca6390 enable failure after warm reboot
Date:   Fri, 29 May 2020 10:29:20 +0800
Message-Id: <1590719360-28257-1-git-send-email-zijuhu@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Warm reboot can not reset controller qca6390 due to
lack of controllable power supply, so causes firmware
download failure during enable.

Fixed by sending VSC EDL_SOC_RESET to reset qca6390
within added device shutdown implementation.

Signed-off-by: Zijun Hu <zijuhu@codeaurora.org>
Tested-by: Zijun Hu <zijuhu@codeaurora.org>
---
 drivers/bluetooth/hci_qca.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index e4a6823..f525656 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1975,6 +1975,38 @@ static void qca_serdev_remove(struct serdev_device *serdev)
 	hci_uart_unregister_device(&qcadev->serdev_hu);
 }
 
+static void qca_serdev_shutdown(struct device *dev)
+{
+	int ret;
+	int timeout = msecs_to_jiffies(CMD_TRANS_TIMEOUT_MS);
+	struct serdev_device *serdev = to_serdev_device(dev);
+	struct qca_serdev *qcadev = serdev_device_get_drvdata(serdev);
+	const u8 ibs_wake_cmd[] = { 0xFD };
+	const u8 edl_reset_soc_cmd[] = { 0x01, 0x00, 0xFC, 0x01, 0x05 };
+
+	if (qcadev->btsoc_type == QCA_QCA6390) {
+		serdev_device_write_flush(serdev);
+		ret = serdev_device_write_buf(serdev, ibs_wake_cmd,
+					      sizeof(ibs_wake_cmd));
+		if (ret < 0) {
+			BT_ERR("QCA send IBS_WAKE_IND error: %d", ret);
+			return;
+		}
+		serdev_device_wait_until_sent(serdev, timeout);
+		usleep_range(8000, 10000);
+
+		serdev_device_write_flush(serdev);
+		ret = serdev_device_write_buf(serdev, edl_reset_soc_cmd,
+					      sizeof(edl_reset_soc_cmd));
+		if (ret < 0) {
+			BT_ERR("QCA send EDL_RESET_REQ error: %d", ret);
+			return;
+		}
+		serdev_device_wait_until_sent(serdev, timeout);
+		usleep_range(8000, 10000);
+	}
+}
+
 static int __maybe_unused qca_suspend(struct device *dev)
 {
 	struct hci_dev *hdev = container_of(dev, struct hci_dev, dev);
@@ -2100,6 +2132,7 @@ static struct serdev_device_driver qca_serdev_driver = {
 		.name = "hci_uart_qca",
 		.of_match_table = of_match_ptr(qca_bluetooth_of_match),
 		.acpi_match_table = ACPI_PTR(qca_bluetooth_acpi_match),
+		.shutdown = qca_serdev_shutdown,
 		.pm = &qca_pm_ops,
 	},
 };
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project

