Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBA41DAFEC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 12:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgETKSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 May 2020 06:18:21 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56491 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgETKSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 06:18:20 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jbLnl-0001Iq-Sz; Wed, 20 May 2020 10:18:18 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     mathias.nyman@intel.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org (open list:USB XHCI DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] xhci: Return if xHCI doesn't support LPM
Date:   Wed, 20 May 2020 18:18:10 +0800
Message-Id: <20200520101811.2623-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just return if xHCI is quirked to disable LPM. We can save some time
from reading registers and doing spinlocks.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/usb/host/xhci.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index bee5deccc83d..14181a7ea375 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -4390,6 +4390,9 @@ static int xhci_set_usb2_hardware_lpm(struct usb_hcd *hcd,
 	int		hird, exit_latency;
 	int		ret;
 
+	if (xhci->quirks & XHCI_HW_LPM_DISABLE)
+		return -EPERM;
+
 	if (hcd->speed >= HCD_USB3 || !xhci->hw_lpm_support ||
 			!udev->lpm_capable)
 		return -EPERM;
@@ -4412,7 +4415,7 @@ static int xhci_set_usb2_hardware_lpm(struct usb_hcd *hcd,
 	xhci_dbg(xhci, "%s port %d USB2 hardware LPM\n",
 			enable ? "enable" : "disable", port_num + 1);
 
-	if (enable && !(xhci->quirks & XHCI_HW_LPM_DISABLE)) {
+	if (enable) {
 		/* Host supports BESL timeout instead of HIRD */
 		if (udev->usb2_hw_lpm_besl_capable) {
 			/* if device doesn't have a preferred BESL value use a
-- 
2.17.1

