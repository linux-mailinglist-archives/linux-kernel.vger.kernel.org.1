Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0C8D2BC76A
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 18:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbgKVRIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 12:08:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:58166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728112AbgKVRIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 12:08:53 -0500
Received: from localhost.localdomain (unknown [157.51.147.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BADDE2078D;
        Sun, 22 Nov 2020 17:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606064932;
        bh=8PuEzUTxYMVvwrtl32gf9xz5576uUtYRrUUoSUterio=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sd5PCXihLjlIgJ0V2ssFm7ozF4SWyx3zwdMYlhwoL+94Zm1ow7baqU41ZLST+VmO5
         rENxLwq0yWzIH71LoFC+KPBKoHDiIWPnPLEHYFmYO5cILK6HKBO0S+k/dJxrzHjLR9
         ifqzBFXhL86ow/cJnPMIFnKBtOoTB28M8CXYLbko=
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     johan@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        patong.mxl@gmail.com, linus.walleij@linaro.org,
        mchehab+huawei@kernel.org, angelo.dureghello@timesys.com,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH v5 3/3] usb: cdc-acm: Ignore Exar XR21V141X when serial driver is built
Date:   Sun, 22 Nov 2020 22:38:22 +0530
Message-Id: <20201122170822.21715-4-mani@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201122170822.21715-1-mani@kernel.org>
References: <20201122170822.21715-1-mani@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

The RTS/CTS line discipline for this device doesn't follow
the standard. So, in order to properly support TX, a separate
driver is needed.

Ensure that cdc_acm will ignore it during probe time, if the
Kernel is built with support for it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
---
 drivers/usb/class/cdc-acm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 30ef946a8e1a..719829e6b6db 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -1890,6 +1890,12 @@ static const struct usb_device_id acm_ids[] = {
 	},
 #endif
 
+#if IS_ENABLED(CONFIG_USB_SERIAL_XR)
+	{ USB_DEVICE(0x04e2, 0x1410),   /* Ignore XR21V141X USB to Serial converter */
+	.driver_info = IGNORE_DEVICE,
+	},
+#endif
+
 	/*Samsung phone in firmware update mode */
 	{ USB_DEVICE(0x04e8, 0x685d),
 	.driver_info = IGNORE_DEVICE,
-- 
2.25.1

