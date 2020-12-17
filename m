Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA1C2DDBA6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 23:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732222AbgLQWy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 17:54:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732168AbgLQWy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 17:54:59 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B25C061285
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 14:54:16 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id b8so363575plx.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 14:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WZ5WSbQtPeUtU/i4otWMR2VgbaOPAzPCIHXFiOM9ruA=;
        b=A4h3Z6nsqjvVlEDu1hHg5MAI22u3KUOUIPnpQOSsrM5dhduiWA2NQCdzkG5RU9pd4p
         tG2KnEnBBJRLCTXyNEa9kQudxBa8ABQImvv+cQfKZB8e1d+x3Her/TfDqAdQ5CwMVwD0
         ED9npRAn0QZZd7pRs9je6E3d1v3BeDX6eV4dI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WZ5WSbQtPeUtU/i4otWMR2VgbaOPAzPCIHXFiOM9ruA=;
        b=HU2l+9oNc4tWNCv9K2PsAqG+fR1dyec+X2naNJcSM2O+8tRAJ0328IMUlGONCCowBF
         2xmHLrDlLEJDdLikJaqxVY9nQQzpvs7RetTXd4f/ZhNzY/0S3JrCMrUZg5e+31r7F0xs
         uB+wxUVCgPXEHXeQKAARG7nXaQ+Az78dlUL4dEP7NfyO22PERkaxKA6s8g+7gsw8qpPP
         SSZvIVwUx6jnCk/iodxZDfpUghJ3I8O759DuYh4ydYtASmnE+6P5eARc/T+4h3sTmfgJ
         lkWTudEFabweMcarTslLfTiuQonvpSGamwccu0vtDMlJ91Rc4EP8kuwG0Mp95doAv+iO
         eaQw==
X-Gm-Message-State: AOAM533Y5iJpJ//jFT+UUG7uupVCn7aOryAaCyj2v/H1whKmLrOCkqEv
        7A7joPzxIEBVNJwqx0YuGoC4ADKGUO29oA==
X-Google-Smtp-Source: ABdhPJzsZ0rOvLccxWS60JFncVdyDGjlKad9nUpOq5XRfyzyvOUSIchietm1qp1JpAOTfisKkZvUww==
X-Received: by 2002:a17:90a:1182:: with SMTP id e2mr1355532pja.152.1608245655911;
        Thu, 17 Dec 2020 14:54:15 -0800 (PST)
Received: from localhost ([2620:15c:202:201:de4a:3eff:fe75:1314])
        by smtp.gmail.com with ESMTPSA id s7sm5557907pju.37.2020.12.17.14.54.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Dec 2020 14:54:15 -0800 (PST)
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
Subject: [PATCH v2 3/4] Bluetooth: btusb: Enable MSFT extension for Intel controllers
Date:   Thu, 17 Dec 2020 14:53:19 -0800
Message-Id: <20201217145149.v2.3.I84d6a963dbe3a014e8456943785b076344f659bf@changeid>
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
In-Reply-To: <20201217145149.v2.1.Id9bc5434114de07512661f002cdc0ada8b3d6d02@changeid>
References: <20201217145149.v2.1.Id9bc5434114de07512661f002cdc0ada8b3d6d02@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Intel JeffersonPeak, HarrisonPeak and CyclonePeak Bluetooth
controllers support the Microsoft vendor extension and they are using
0xFC1E for VsMsftOpCode.

< HCI Command: Vendor (0x3f|0x001e) plen 1
        00
> HCI Event: Command Complete (0x0e) plen 15
      Vendor (0x3f|0x001e) ncmd 1
        Status: Success (0x00)
        00 3f 00 00 00 00 00 00 00 01 50

The following test step was performed.
- Boot the test devices with HarrisonPeak and verify INFO print in
dmesg.

Signed-off-by: Miao-chen Chou <mcchou@chromium.org>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Archie Pusaka <apusaka@chromium.org>
---

(no changes since v1)

 drivers/bluetooth/btusb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 03b83aa912779..25cfa47995a8a 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2924,7 +2924,10 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	 * extension are using 0xFC1E for VsMsftOpCode.
 	 */
 	switch (ver.hw_variant) {
+	case 0x11:	/* JfP */
 	case 0x12:	/* ThP */
+	case 0x13:	/* HrP */
+	case 0x14:	/* CcP */
 		hci_set_msft_opcode(hdev, 0xFC1E);
 		break;
 	}
-- 
2.29.2.684.gfbc64c5ab5-goog

