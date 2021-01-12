Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3502F25F0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 03:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729879AbhALCAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 21:00:17 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:10650 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbhALCAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 21:00:16 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DFDJC24Dgz15rhs;
        Tue, 12 Jan 2021 09:58:35 +0800 (CST)
Received: from huawei.com (10.67.165.24) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.498.0; Tue, 12 Jan 2021
 09:59:28 +0800
From:   Longfang Liu <liulongfang@huawei.com>
To:     <gregkh@linuxfoundation.org>, <stern@rowland.harvard.edu>
CC:     <linux-usb@vger.kernel.org>, <yisen.zhuang@huawei.com>,
        <kong.kongxinwei@hisilicon.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] USB:ehci:fix an interrupt calltrace error
Date:   Tue, 12 Jan 2021 09:57:27 +0800
Message-ID: <1610416647-45774-1-git-send-email-liulongfang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The system that use Synopsys USB host controllers goes to suspend
when using USB audio player. This causes the USB host controller
continuous send interrupt signal to system, When the number of
interrupts exceeds 100000, the system will forcibly close the
interrupts and output a calltrace error.

When the system goes to suspend, the last interrupt is reported to
the driver. At this time, the system has set the state to suspend.
This causes the last interrupt to not be processed by the system and
not clear the interrupt flag. This uncleared interrupt flag constantly
triggers new interrupt event. This causing the driver to receive more
than 100,000 interrupts, which causes the system to forcibly close the
interrupt report and report the calltrace error.

so, when the driver goes to sleep and changes the system state to
suspend, the interrupt flag needs to be cleared.

Signed-off-by: Longfang Liu <liulongfang@huawei.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
---

Changes in v2:
- updated cleared registers

 drivers/usb/host/ehci-hub.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/host/ehci-hub.c b/drivers/usb/host/ehci-hub.c
index ce0eaf7..6dfbba1 100644
--- a/drivers/usb/host/ehci-hub.c
+++ b/drivers/usb/host/ehci-hub.c
@@ -346,6 +346,9 @@ static int ehci_bus_suspend (struct usb_hcd *hcd)
 
 	unlink_empty_async_suspended(ehci);
 
+	/* Some Synopsys controllers mistakenly leave IAA turned on */
+	ehci_writel(ehci, STS_IAA, &ehci->regs->status);
+
 	/* Any IAA cycle that started before the suspend is now invalid */
 	end_iaa_cycle(ehci);
 	ehci_handle_start_intr_unlinks(ehci);
-- 
2.8.1

