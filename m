Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52FA9275F38
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 19:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgIWR4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 13:56:15 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58081 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbgIWR4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 13:56:15 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kL8zz-0005V0-Hn; Wed, 23 Sep 2020 17:56:12 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     alex_lu@realsil.com.cn,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-bluetooth@vger.kernel.org (open list:BLUETOOTH DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] Bluetooth: btusb: Avoid unnecessary reset upon system resume
Date:   Thu, 24 Sep 2020 01:56:02 +0800
Message-Id: <20200923175602.9523-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Realtek bluetooth controller may fail to work after system sleep:
[ 1272.707670] Bluetooth: hci0: command 0x1001 tx timeout
[ 1280.835712] Bluetooth: hci0: RTL: HCI_OP_READ_LOCAL_VERSION failed (-110)

If platform firmware doesn't cut power off during suspend, the firmware
is considered retained in controller but the driver is still asking USB
core to perform a reset-resume. This can make bluetooth controller
unusable.

So avoid unnecessary reset to resolve the issue.

For devices that really lose power during suspend, USB core will detect
and handle reset-resume correctly.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/bluetooth/btusb.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 8d2608ddfd08..de86ef4388f9 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4255,17 +4255,15 @@ static int btusb_suspend(struct usb_interface *intf, pm_message_t message)
 		enable_irq(data->oob_wake_irq);
 	}
 
-	/* For global suspend, Realtek devices lose the loaded fw
-	 * in them. But for autosuspend, firmware should remain.
-	 * Actually, it depends on whether the usb host sends
+	/* For global suspend, Realtek devices lose the loaded fw in them if
+	 * platform firmware cut power off. But for autosuspend, firmware
+	 * should remain.  Actually, it depends on whether the usb host sends
 	 * set feature (enable wakeup) or not.
 	 */
 	if (test_bit(BTUSB_WAKEUP_DISABLE, &data->flags)) {
 		if (PMSG_IS_AUTO(message) &&
 		    device_can_wakeup(&data->udev->dev))
 			data->udev->do_remote_wakeup = 1;
-		else if (!PMSG_IS_AUTO(message))
-			data->udev->reset_resume = 1;
 	}
 
 	return 0;
-- 
2.17.1

