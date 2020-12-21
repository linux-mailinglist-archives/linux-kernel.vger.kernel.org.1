Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA77D2DFD44
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 16:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbgLUPJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 10:09:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:33456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725777AbgLUPJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 10:09:58 -0500
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@nxp.com>
Cc:     Jun Li <jun.li@nxp.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: host: xhci-plat: fix support for XHCI_SKIP_PHY_INIT quirk
Date:   Mon, 21 Dec 2020 16:09:03 +0100
Message-Id: <20201221150903.26630-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently init_quirk callbacks for xhci platform drivers are called
xhci_plat_setup() function which is called after chip reset completes.
It happens in the middle of the usb_add_hcd() function.

But XHCI_SKIP_PHY_INIT quirk is checked in the xhci_plat_probe() function
prior calling usb_add_hcd() function. Therefore this XHCI_SKIP_PHY_INIT
currently does nothing as prior xhci_plat_setup() it is not set.

Quirk XHCI_SKIP_PHY_INIT is only setting hcd->skip_phy_initialization value
which really needs to be set prior calling usb_add_hcd() as this function
at its beginning skips PHY init if this member is set.

This patch fixes implementation of the XHCI_SKIP_PHY_INIT quirk by calling
init_quirk callbacks (via xhci_priv_init_quirk()) prior checking if
XHCI_SKIP_PHY_INIT is set.

Fixes: f768e718911e0 ("usb: host: xhci-plat: add priv quirk for skip PHY initialization")
Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/usb/host/xhci-plat.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 4d34f6005381..58704c5b002b 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -89,13 +89,6 @@ static void xhci_plat_quirks(struct device *dev, struct xhci_hcd *xhci)
 /* called during probe() after chip reset completes */
 static int xhci_plat_setup(struct usb_hcd *hcd)
 {
-	int ret;
-
-
-	ret = xhci_priv_init_quirk(hcd);
-	if (ret)
-		return ret;
-
 	return xhci_gen_setup(hcd, xhci_plat_quirks);
 }
 
@@ -330,6 +323,13 @@ static int xhci_plat_probe(struct platform_device *pdev)
 
 	hcd->tpl_support = of_usb_host_tpl_support(sysdev->of_node);
 	xhci->shared_hcd->tpl_support = hcd->tpl_support;
+
+	if (priv) {
+		ret = xhci_priv_init_quirk(hcd);
+		if (ret)
+			goto disable_usb_phy;
+	}
+
 	if (priv && (priv->quirks & XHCI_SKIP_PHY_INIT))
 		hcd->skip_phy_initialization = 1;
 
-- 
2.20.1

