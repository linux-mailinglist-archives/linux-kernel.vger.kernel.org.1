Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A16F2E1F69
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 17:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbgLWQY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 11:24:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:57282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbgLWQY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 11:24:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B6244222BB;
        Wed, 23 Dec 2020 16:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608740656;
        bh=BxgtCRLcshuJRlikNm+aCB62jEh25FJudr2hKT0iFBs=;
        h=From:To:Cc:Subject:Date:From;
        b=imP8cyt0YqKYSOV+/42mq3DypEZsGPAZSSXLMPEdEPScm4/EY1XPkENi6UWAxfxTc
         GoD6fxxwpxuU2i8WN5mhv/cR3zTjIbQe8g0leT1obTsd7ZlvqshpPw0vGhZvKpmnr4
         fNldDZnuWAHR/KBqF3CaoV8bsVPM7y3cQh34cMyenHFQAsfWRBZIP9bJDUQzcge+FJ
         dvMDuzEIfX66Eci4VQzcm5ssi0GvPIyvFmRT90b+iYJAAm0yl16YEepIGsVPrDa3Ko
         kqsergld5QbAJnC+9MwBXjEBgEWfot9ZUG7J980DIsjugCkRtH+ZoImBiKcH7HGp0S
         24vtru5idOIIA==
Received: by pali.im (Postfix)
        id 9C4CD7F0; Wed, 23 Dec 2020 17:24:14 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Tomasz Maciej Nowak <tmn505@gmail.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Chen <peter.chen@nxp.com>
Subject: [PATCH] usb: host: xhci: mvebu: make USB 3.0 PHY optional for Armada 3720
Date:   Wed, 23 Dec 2020 17:24:03 +0100
Message-Id: <20201223162403.10897-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Older ATF does not provide SMC call for USB 3.0 phy power on functionality
and therefore initialization of xhci-hcd is failing when older version of
ATF is used. In this case phy_power_on() function returns -EOPNOTSUPP.

[    3.108467] mvebu-a3700-comphy d0018300.phy: unsupported SMC call, try updating your firmware
[    3.117250] phy phy-d0018300.phy.0: phy poweron failed --> -95
[    3.123465] xhci-hcd: probe of d0058000.usb failed with error -95

This patch calls phy_power_on() in xhci_mvebu_a3700_init_quirk() function
and in case it returns -EOPNOTSUPP then XHCI_SKIP_PHY_INIT quirk is set to
instruct xhci-plat to skip PHY initialization.

This patch fixes above failure by ignoring 'not supported' error in
aardvark driver. In this case it is expected that phy is already power on.

It fixes initialization of xhci-hcd on Espressobin boards where is older
Marvell's Arm Trusted Firmware without SMC call for USB 3.0 phy power.

This is regression introduced in commit bd3d25b07342 ("arm64: dts: marvell:
armada-37xx: link USB hosts with their PHYs") where USB 3.0 phy was defined
and therefore xhci-hcd on Espressobin with older ATF started failing.

Fixes: bd3d25b07342 ("arm64: dts: marvell: armada-37xx: link USB hosts with their PHYs")
Signed-off-by: Pali Rohár <pali@kernel.org>
Cc: <stable@vger.kernel.org> # 5.1+: ea17a0f153af: phy: marvell: comphy: Convert internal SMCC firmware return codes to errno
Cc: <stable@vger.kernel.org> # 5.1+: f768e718911e: usb: host: xhci-plat: add priv quirk for skip PHY initialization

---

When applying this patch, please include additional line

Cc: <stable@vger.kernel.org> # 5.1+: <COMMIT_ID>: usb: host: xhci-plat: fix support for XHCI_SKIP_PHY_INIT quirk

with correct COMMIT_ID of mentioned patch which is available in the thread:
https://lore.kernel.org/lkml/20201221150903.26630-1-pali@kernel.org/T/#u

As mentioned patch is required for change in this patch to work. Above
mentioned patch is prerequisite for this patch and therefore needs to be
reviewed and applied prior this patch.

Note that same issue as in this USB 3.0 PHY patch was already resolved and
applied also for SATA PHY and PCIe PHY on A3720 SOC in following commits:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=45aefe3d2251e4e229d7662052739f96ad1d08d9
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b0c6ae0f8948a2be6bf4e8b4bbab9ca1343289b6

And these commits were also backported to stable kernel versions (where
were affected commits which broke drivers initialization).
---
 drivers/usb/host/xhci-mvebu.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/usb/host/xhci-mvebu.c b/drivers/usb/host/xhci-mvebu.c
index 60651a50770f..ec4f6d6e44cf 100644
--- a/drivers/usb/host/xhci-mvebu.c
+++ b/drivers/usb/host/xhci-mvebu.c
@@ -8,6 +8,7 @@
 #include <linux/mbus.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/phy/phy.h>
 
 #include <linux/usb.h>
 #include <linux/usb/hcd.h>
@@ -77,9 +78,43 @@ int xhci_mvebu_mbus_init_quirk(struct usb_hcd *hcd)
 int xhci_mvebu_a3700_init_quirk(struct usb_hcd *hcd)
 {
 	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
+	struct device *dev = hcd->self.controller;
+	struct phy *phy;
+	int ret;
 
 	/* Without reset on resume, the HC won't work at all */
 	xhci->quirks |= XHCI_RESET_ON_RESUME;
 
+	/* Old bindings miss the PHY handle */
+	phy = of_phy_get(dev->of_node, "usb3-phy");
+	if (IS_ERR(phy) && PTR_ERR(phy) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+	else if (IS_ERR(phy))
+		goto phy_out;
+
+	ret = phy_init(phy);
+	if (ret)
+		goto phy_put;
+
+	ret = phy_set_mode(phy, PHY_MODE_USB_HOST_SS);
+	if (ret)
+		goto phy_exit;
+
+	ret = phy_power_on(phy);
+	if (ret == -EOPNOTSUPP) {
+		/* Skip initializatin of XHCI PHY when it is unsupported by firmware */
+		dev_warn(dev, "PHY unsupported by firmware\n");
+		xhci->quirks |= XHCI_SKIP_PHY_INIT;
+	}
+	if (ret)
+		goto phy_exit;
+
+	phy_power_off(phy);
+phy_exit:
+	phy_exit(phy);
+phy_put:
+	of_phy_put(phy);
+phy_out:
+
 	return 0;
 }
-- 
2.20.1

