Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5D5E2E1F62
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 17:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbgLWQTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 11:19:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:56768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726247AbgLWQTm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 11:19:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D25A2222BB;
        Wed, 23 Dec 2020 16:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608740342;
        bh=RhCqbYrptTdNjk/lDP4Bb4JHZUu7nVCpfKronRSYbGo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CkUqls+Xl8IAfZj1LPNUr40yVDRD8GjmG6+by017JywYFztlz/WoHfBV2vK+puH1t
         7TpOpjF569OJ4d6ll+WIMXEnVNC+rxc53ZQpOLongfc8SM7d2l7I8daV5LK0jU/mei
         CJ9ZHD5uIhCgbblYRQeqIN4obdKbMFezfaE9NdF0JTc0W+9mjWpHG4IHofv2E/Skyp
         lGLgWvPpK6XQMR45JzkrsiMXGdNzOUcR9edBOhZ71GobuUTIrrXWLZ1rCrBJvyx/Jm
         Rf28Um8NdAzNHwxtu+QnsJ4fK1VEswNymPOkGFXW+lAD3Fw0aMj3HHmKMxJBJcfq7M
         K0/C/JgqR7g+A==
Received: by pali.im (Postfix)
        id 796FF7F0; Wed, 23 Dec 2020 17:18:59 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@nxp.com>
Cc:     Jun Li <jun.li@nxp.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] usb: host: xhci-plat: fix support for XHCI_SKIP_PHY_INIT quirk
Date:   Wed, 23 Dec 2020 17:18:47 +0100
Message-Id: <20201223161847.10811-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201221150903.26630-1-pali@kernel.org>
References: <20201221150903.26630-1-pali@kernel.org>
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
XHCI_SKIP_PHY_INIT is set. Also checking if either xhci->quirks or
priv->quirks contains this XHCI_SKIP_PHY_INIT quirk.

Signed-off-by: Pali Rohár <pali@kernel.org>

---
Changes in v2:
* Check also xhci->quirks as xhci_priv_init_quirk() callbacks are setting xhci->quirks
* Tested with "usb: host: xhci: mvebu: make USB 3.0 PHY optional for Armada 3720" patch
* Removed Fixes: line
---
 drivers/usb/host/xhci-plat.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 4d34f6005381..0eab7cb5a767 100644
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
 
@@ -330,7 +323,14 @@ static int xhci_plat_probe(struct platform_device *pdev)
 
 	hcd->tpl_support = of_usb_host_tpl_support(sysdev->of_node);
 	xhci->shared_hcd->tpl_support = hcd->tpl_support;
-	if (priv && (priv->quirks & XHCI_SKIP_PHY_INIT))
+
+	if (priv) {
+		ret = xhci_priv_init_quirk(hcd);
+		if (ret)
+			goto disable_usb_phy;
+	}
+
+	if ((xhci->quirks & XHCI_SKIP_PHY_INIT) || (priv && (priv->quirks & XHCI_SKIP_PHY_INIT)))
 		hcd->skip_phy_initialization = 1;
 
 	if (priv && (priv->quirks & XHCI_SG_TRB_CACHE_SIZE_QUIRK))
-- 
2.20.1

