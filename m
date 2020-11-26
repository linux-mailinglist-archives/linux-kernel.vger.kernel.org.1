Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 591182C4DD4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 04:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387482AbgKZDgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 22:36:17 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7688 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387468AbgKZDgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 22:36:17 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4ChNh83Y69z15STQ;
        Thu, 26 Nov 2020 11:35:52 +0800 (CST)
Received: from huawei.com (10.67.165.24) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Thu, 26 Nov 2020
 11:36:11 +0800
From:   Longfang Liu <liulongfang@huawei.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] USB:ehci:fix an interrupt calltrace error
Date:   Thu, 26 Nov 2020 11:34:33 +0800
Message-ID: <1606361673-573-1-git-send-email-liulongfang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The system goes to suspend when using USB audio player. This causes
the USB device continuous send interrupt signal to system, When the
number of interrupts exceeds 100000, the system will forcibly close
the interrupts and output a calltrace error.

When the system goes to suspend, the last interrupt is reported to
the driver. At this time, the system has set the state to suspend.
This causes the last interrupt to not be processed by the system and
not clear the interrupt state flag. This uncleared interrupt flag
constantly triggers new interrupt event. This causing the driver to
receive more than 100,000 interrupts, which causes the system to
forcibly close the interrupt report and report the calltrace error.

so, when the driver goes to sleep and changes the system state to
suspend, the interrupt flag needs to be cleared.

Signed-off-by: Longfang Liu <liulongfang@huawei.com>
---
 drivers/usb/host/ehci-hub.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/host/ehci-hub.c b/drivers/usb/host/ehci-hub.c
index ce0eaf7..5b13825 100644
--- a/drivers/usb/host/ehci-hub.c
+++ b/drivers/usb/host/ehci-hub.c
@@ -348,6 +348,11 @@ static int ehci_bus_suspend (struct usb_hcd *hcd)
 
 	/* Any IAA cycle that started before the suspend is now invalid */
 	end_iaa_cycle(ehci);
+
+	/* clear interrupt status */
+	if (ehci->has_synopsys_hc_bug)
+		ehci_writel(ehci, INTR_MASK | STS_FLR, &ehci->regs->status);
+
 	ehci_handle_start_intr_unlinks(ehci);
 	ehci_handle_intr_unlinks(ehci);
 	end_free_itds(ehci);
-- 
2.8.1

