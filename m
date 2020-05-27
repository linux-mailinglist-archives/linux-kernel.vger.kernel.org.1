Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB751E35FA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 04:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgE0C5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 May 2020 22:57:18 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:52702 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728177AbgE0C5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 22:57:17 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590548236; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=6Ift2CZ2f8hYhU8lvSz1kq7TxcCrUamQ2r8BuaLxoas=; b=W5rQ36JejQBoh5If7AxN/ZwPCofQ7hWsbi6BR/UgkUcN6rpBUBbf/6Y0bER8N4QTyNf/vxmG
 sqAPuINc2n4whobb+NKh8ss2ANZ0Rah52ZZR9CjgKSHdM0WeulZpGoxKhTgPPVdcJ/YvZufv
 iM5Frebq2iYPVJnJBjNqhCAKsdo=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5ecdd70b2dd9e15ae3d5383f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 27 May 2020 02:57:15
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 81085C433C6; Wed, 27 May 2020 02:57:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from zijuhu-gv.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: zijuhu)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E50E7C433C9;
        Wed, 27 May 2020 02:57:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E50E7C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=zijuhu@codeaurora.org
From:   Zijun Hu <zijuhu@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, bgodavar@codeaurora.org,
        c-hbandi@codeaurora.org, hemantg@codeaurora.org, mka@chromium.org,
        rjliao@codeaurora.org, zijuhu@codeaurora.org
Subject: [PATCH v2] Bluetooth: hci_qca: Improve controller ID info log level
Date:   Wed, 27 May 2020 10:57:09 +0800
Message-Id: <1590548229-17812-1-git-send-email-zijuhu@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Controller ID info got by VSC EDL_PATCH_GETVER is very
important, so improve its log level from DEBUG to INFO.

Signed-off-by: Zijun Hu <zijuhu@codeaurora.org>
---
 drivers/bluetooth/btqca.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index 3ea866d..94d8e15 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -74,10 +74,14 @@ int qca_read_soc_version(struct hci_dev *hdev, u32 *soc_version,
 
 	ver = (struct qca_btsoc_version *)(edl->data);
 
-	BT_DBG("%s: Product:0x%08x", hdev->name, le32_to_cpu(ver->product_id));
-	BT_DBG("%s: Patch  :0x%08x", hdev->name, le16_to_cpu(ver->patch_ver));
-	BT_DBG("%s: ROM    :0x%08x", hdev->name, le16_to_cpu(ver->rom_ver));
-	BT_DBG("%s: SOC    :0x%08x", hdev->name, le32_to_cpu(ver->soc_id));
+	bt_dev_info(hdev, "QCA Product ID   :0x%08x",
+			le32_to_cpu(ver->product_id));
+	bt_dev_info(hdev, "QCA SOC Version  :0x%08x",
+			le32_to_cpu(ver->soc_id));
+	bt_dev_info(hdev, "QCA ROM Version  :0x%08x",
+			le16_to_cpu(ver->rom_ver));
+	bt_dev_info(hdev, "QCA Patch Version:0x%08x",
+			le16_to_cpu(ver->patch_ver));
 
 	/* QCA chipset version can be decided by patch and SoC
 	 * version, combination with upper 2 bytes from SoC
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project

