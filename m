Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 591AA2DDBA4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 23:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732193AbgLQWyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 17:54:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732146AbgLQWyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 17:54:45 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0080BC06138C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 14:54:04 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id q4so342646plr.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 14:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cI9MgmLeploorlaT6riPPJE9eXLVQcklnfEH1q+Fd9s=;
        b=eeSPw9ZNCa3gp4C94BkDSwC79ilLWC9VXQd3Ibuzia9j0DGwW584pKr22PoidTVF9z
         IRAQD1+yho+07aj/S+ueSUy2Srx3RJWkNfp315Kpj29Z1XiiWmPhh94vbkja4z+NKtX6
         EJPgoUESQOiuv9BByERPEEj76aLTvRuUnA1OA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cI9MgmLeploorlaT6riPPJE9eXLVQcklnfEH1q+Fd9s=;
        b=YrumnytjtghtJxWUjNvVf+gdRyYwcV4gE/5IBh5eWuZS0hw0rmHHu3l712MERtX1+U
         FQE39NhqTmaef7omTTJ6KDknQkZCXSnGmYDVkwuCf/yuwJ8oihl6kPSpkAEeF1E8/JZ4
         Jsv8e9JPlPNZ1BywVrbIoW+HY4oYiEimpqDjjLxlM4uCMf84BVVVZwIHfRt1ellRvOT+
         Uo3/IpzFItXcNFRgzvXXq4pep/WPZayMSa0mwYe42XWWEdr8Xih0FwNBWT6lLlXT71J/
         hS4fvjJmUsD/P95JsfbGbuMun/5HIHg8ri/LxBx7VMz2dU1QmgME8Zlxpdq8lVYeFprS
         E/FQ==
X-Gm-Message-State: AOAM531la/3/xau11s7+UwmR27/c2e8WFhBjCh91X0mT1Nk920mhdK8W
        7eWK59LrAaGnwYK1QVZkjhkmuw==
X-Google-Smtp-Source: ABdhPJyAgs5zVEPDtjuG0Pl+XF2C1xuC0/BKGQDoZVn8MmxXYDfPKxSs/86+hI9EBSIiQQ03COSEfg==
X-Received: by 2002:a17:90a:6a48:: with SMTP id d8mr1363057pjm.130.1608245644550;
        Thu, 17 Dec 2020 14:54:04 -0800 (PST)
Received: from localhost ([2620:15c:202:201:de4a:3eff:fe75:1314])
        by smtp.gmail.com with ESMTPSA id w200sm6776305pfc.14.2020.12.17.14.54.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Dec 2020 14:54:03 -0800 (PST)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Archie Pusaka <apusaka@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] Bluetooth: btqca: Enable MSFT extension for Qualcomm WCN399x
Date:   Thu, 17 Dec 2020 14:53:17 -0800
Message-Id: <20201217145149.v2.2.I188d99e738b39d9ef36110addbc227837d3c42a7@changeid>
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
In-Reply-To: <20201217145149.v2.1.Id9bc5434114de07512661f002cdc0ada8b3d6d02@changeid>
References: <20201217145149.v2.1.Id9bc5434114de07512661f002cdc0ada8b3d6d02@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following Qualcomm WCN399x Bluetooth controllers support the
Microsoft vendor extension and they are using 0xFD70 for VsMsftOpCode.
-WCN3990
-WCN3991
-WCN3998

< HCI Command: ogf 0x3f, ocf 0x0170, plen 1
  00
> HCI Event: 0x0e plen 18
  01 70 FD 00 00 1F 00 00 00 00 00 00 00 04 4D 53 46 54

The following test step was performed.
- Boot the device with WCN3991 and verify INFO print in dmesg.

Signed-off-by: Miao-chen Chou <mcchou@chromium.org>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Archie Pusaka <apusaka@chromium.org>
---

(no changes since v1)

 drivers/bluetooth/btqca.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index f85a55add9be5..ab19963c83616 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -517,6 +517,19 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 			return err;
 	}
 
+	/* WCN399x supports the Microsoft vendor extension with 0xFD70 as the
+	 * VsMsftOpCode.
+	 */
+	switch (soc_type) {
+	case QCA_WCN3990:
+	case QCA_WCN3991:
+	case QCA_WCN3998:
+		hci_set_msft_opcode(hdev, 0xFD70);
+		break;
+	default:
+		break;
+	}
+
 	/* Perform HCI reset */
 	err = qca_send_reset(hdev);
 	if (err < 0) {
-- 
2.29.2.684.gfbc64c5ab5-goog

