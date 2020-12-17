Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F11EF2DCCE6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 08:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbgLQHTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 02:19:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbgLQHTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 02:19:04 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443EDC061285
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 23:18:18 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id q22so18448584pfk.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 23:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7ROFwraclmZafOx9+Edkeznx8P384VynmuQCntAzvR8=;
        b=MyC9Vmv2wxTErdNuK46uB+6W+ZeVo7CEvAm4CwVHoHH6x/Qe6krRpXc5BwLHrwfy5s
         dqz3p5R0K8lWPFghYVZh8kljchH/xI8owsl/XOAqXzGWZZt8QqTi6lOnUujDFNWHp/MG
         dexyi7hbmLntzWFV7khcS9933ojZMNj1UgUxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7ROFwraclmZafOx9+Edkeznx8P384VynmuQCntAzvR8=;
        b=FmKozVKWbwODXdAWYmfCBvgXc2wb5S8bweyJIPuRGwy8tQHrdBr15ehsVaHzJ4vfEr
         UvWLNWJ5tXqFWe9yXgcfNvafgI3ZEKHc+/JkFmoZYUEjJqfrHXvmh0dRpgB0r8sIh97x
         XkESmNO2voapiem8KDgADfDLkEPiIObuVCKG0bHWymZ89EBJvFKMvjAOOdeHAsdpyu7T
         Ae2PWrsSZQQ82F592+7IJGaRcJG0eVXmtoNC3ZDF9eYG/8FZFwQCKQH2ipWfdnIPQ4el
         /3XceT9RrFELPQu7EZK2VCwvrxX5WSOxFlPnepNbf57tm+0HZ3SNvpN4tepRMmV6pTUM
         Dh6A==
X-Gm-Message-State: AOAM530hQ5KC3Rrt5qO7mNLfBczqW8MlRc3iprLyhew9Zyk2WimZmVdX
        wHo5qSRMaxw5IayjD0y+XgX/Yg==
X-Google-Smtp-Source: ABdhPJyTjk/xJ2oFRvRDO7TmL23v4R2kPT5mfGpPjmsduIU3UXGQFAsrW08FGb/A5mFBqOJB4ekjQA==
X-Received: by 2002:a63:f702:: with SMTP id x2mr35802021pgh.414.1608189497840;
        Wed, 16 Dec 2020 23:18:17 -0800 (PST)
Received: from localhost ([2620:15c:202:201:de4a:3eff:fe75:1314])
        by smtp.gmail.com with ESMTPSA id a31sm4956916pgb.93.2020.12.16.23.18.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Dec 2020 23:18:17 -0800 (PST)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Miao-chen Chou <mcchou@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/4] Bluetooth: btusb: Enable MSFT extension for Intel controllers
Date:   Wed, 16 Dec 2020 23:17:31 -0800
Message-Id: <20201216231652.v1.3.I84d6a963dbe3a014e8456943785b076344f659bf@changeid>
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
In-Reply-To: <20201216231652.v1.1.Id9bc5434114de07512661f002cdc0ada8b3d6d02@changeid>
References: <20201216231652.v1.1.Id9bc5434114de07512661f002cdc0ada8b3d6d02@changeid>
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

