Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1D62F1186
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 12:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbhAKLcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 06:32:32 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:10647 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729672AbhAKLcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 06:32:31 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DDs2w5b34z15h8F;
        Mon, 11 Jan 2021 19:30:48 +0800 (CST)
Received: from huawei.com (10.67.165.24) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.498.0; Mon, 11 Jan 2021
 19:31:38 +0800
From:   Longfang Liu <liulongfang@huawei.com>
To:     <gregkh@linuxfoundation.org>, <stern@rowland.harvard.edu>
CC:     <yisen.zhuang@huawei.com>, <kong.kongxinwei@hisilicon.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] USB:ehci:fix an interrupt calltrace error
Date:   Mon, 11 Jan 2021 19:29:37 +0800
Message-ID: <1610364577-11617-1-git-send-email-liulongfang@huawei.com>
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
---

Changes in v2:
- updated cleared registers

 drivers/usb/host/ehci-hub.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/host/ehci-hub.c b/drivers/usb/host/ehci-hub.c
index ce0eaf7..a99c1ac 100644
--- a/drivers/usb/host/ehci-hub.c
+++ b/drivers/usb/host/ehci-hub.c
@@ -346,8 +346,12 @@ static int ehci_bus_suspend (struct usb_hcd *hcd)
 
 	unlink_empty_async_suspended(ehci);
 
+	/* Some Synopsys controllers mistakenly leave IAA turned on */
+	ehci_writel(ehci, STS_IAA, &ehci->regs->status);
+
 	/* Any IAA cycle that started before the suspend is now invalid */
 	end_iaa_cycle(ehci);
+
 	ehci_handle_start_intr_unlinks(ehci);
 	ehci_handle_intr_unlinks(ehci);
 	end_free_itds(ehci);
-- 
2.8.1

