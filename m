Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 957B12D115C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 14:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgLGNGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 08:06:47 -0500
Received: from aposti.net ([89.234.176.197]:35468 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725550AbgLGNGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 08:06:47 -0500
From:   Paul Cercueil <paul@crapouillou.net>
To:     Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     od@zcrc.me, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 4/4] usb: musb: Support setting OTG mode using generic PHY
Date:   Mon,  7 Dec 2020 13:03:32 +0000
Message-Id: <20201207130332.120681-4-paul@crapouillou.net>
In-Reply-To: <20201207130332.120681-1-paul@crapouillou.net>
References: <20201207130332.120681-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When musb->xceiv is not provided but musb->phy is, support setting the
OTG mode (host, peripheral) using the generic PHY framework.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/usb/musb/musb_gadget.c | 4 ++++
 drivers/usb/musb/musb_host.c   | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index f3592c7a5c5e..3cfbd7990e92 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -1849,6 +1849,8 @@ static int musb_gadget_start(struct usb_gadget *g,
 
 	if (musb->xceiv)
 		otg_set_peripheral(musb->xceiv->otg, &musb->g);
+	else
+		phy_set_mode(musb->phy, PHY_MODE_USB_DEVICE);
 
 	musb_set_state(musb, OTG_STATE_B_IDLE);
 	spin_unlock_irqrestore(&musb->lock, flags);
@@ -1900,6 +1902,8 @@ static int musb_gadget_stop(struct usb_gadget *g)
 
 	if (musb->xceiv)
 		otg_set_peripheral(musb->xceiv->otg, NULL);
+	else
+		phy_set_mode(musb->phy, PHY_MODE_INVALID);
 
 	musb->is_active = 0;
 	musb->gadget_driver = NULL;
diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index d8793f8df25c..f53968ad9187 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -2732,6 +2732,8 @@ int musb_host_setup(struct musb *musb, int power_budget)
 	if (musb->xceiv) {
 		otg_set_host(musb->xceiv->otg, &hcd->self);
 		musb->xceiv->otg->host = &hcd->self;
+	} else {
+		phy_set_mode(musb->phy, PHY_MODE_USB_HOST);
 	}
 
 	/* don't support otg protocols */
-- 
2.29.2

