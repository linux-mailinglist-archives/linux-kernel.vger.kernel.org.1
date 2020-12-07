Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECBA2D1159
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 14:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgLGNGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 08:06:01 -0500
Received: from aposti.net ([89.234.176.197]:35236 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbgLGNGA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 08:06:00 -0500
From:   Paul Cercueil <paul@crapouillou.net>
To:     Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     od@zcrc.me, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 3/4] usb: musb: Allow running without a PHY
Date:   Mon,  7 Dec 2020 13:03:31 +0000
Message-Id: <20201207130332.120681-3-paul@crapouillou.net>
In-Reply-To: <20201207130332.120681-1-paul@crapouillou.net>
References: <20201207130332.120681-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some platforms (e.g. JZ4740) can run without a PHY.

Modify the core so that musb->xceiv is never deferenced without being
checked first.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/usb/musb/musb_core.c    |  2 +-
 drivers/usb/musb/musb_core.h    | 12 ++++++++++--
 drivers/usb/musb/musb_gadget.c  | 21 +++++++++++++--------
 drivers/usb/musb/musb_host.c    |  8 ++++++--
 drivers/usb/musb/musb_virthub.c | 11 +++++------
 5 files changed, 35 insertions(+), 19 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 8e8861955545..232218d74b95 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2431,7 +2431,7 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 	else
 		musb->io.set_toggle = musb_default_set_toggle;
 
-	if (!musb->xceiv->io_ops) {
+	if (IS_ENABLED(CONFIG_USB_PHY) && musb->xceiv && !musb->xceiv->io_ops) {
 		musb->xceiv->io_dev = musb->controller;
 		musb->xceiv->io_priv = musb->mregs;
 		musb->xceiv->io_ops = &musb_ulpi_access;
diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
index 363481df1ceb..f9f058bb5dda 100644
--- a/drivers/usb/musb/musb_core.h
+++ b/drivers/usb/musb/musb_core.h
@@ -339,6 +339,8 @@ struct musb {
 	struct usb_phy		*xceiv;
 	struct phy		*phy;
 
+	enum usb_otg_state	otg_state;
+
 	int nIrq;
 	unsigned		irq_wake:1;
 
@@ -595,12 +597,18 @@ static inline void musb_platform_clear_ep_rxintr(struct musb *musb, int epnum)
 static inline void musb_set_state(struct musb *musb,
 				  enum usb_otg_state otg_state)
 {
-	musb->xceiv->otg->state = otg_state;
+	if (musb->xceiv)
+		musb->xceiv->otg->state = otg_state;
+	else
+		musb->otg_state = otg_state;
 }
 
 static inline enum usb_otg_state musb_get_state(struct musb *musb)
 {
-	return musb->xceiv->otg->state;
+	if (musb->xceiv)
+		return musb->xceiv->otg->state;
+
+	return musb->otg_state;
 }
 
 static inline const char *musb_otg_state_string(struct musb *musb)
diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index ba312b43b895..f3592c7a5c5e 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -1547,9 +1547,11 @@ static int musb_gadget_wakeup(struct usb_gadget *gadget)
 				break;
 		}
 
-		spin_unlock_irqrestore(&musb->lock, flags);
-		otg_start_srp(musb->xceiv->otg);
-		spin_lock_irqsave(&musb->lock, flags);
+		if (musb->xceiv) {
+			spin_unlock_irqrestore(&musb->lock, flags);
+			otg_start_srp(musb->xceiv->otg);
+			spin_lock_irqsave(&musb->lock, flags);
+		}
 
 		/* Block idling for at least 1s */
 		musb_platform_try_idle(musb,
@@ -1623,7 +1625,7 @@ static int musb_gadget_vbus_draw(struct usb_gadget *gadget, unsigned mA)
 {
 	struct musb	*musb = gadget_to_musb(gadget);
 
-	if (!musb->xceiv->set_power)
+	if (!musb->xceiv || !musb->xceiv->set_power)
 		return -EOPNOTSUPP;
 	return usb_phy_set_power(musb->xceiv, mA);
 }
@@ -1829,7 +1831,6 @@ static int musb_gadget_start(struct usb_gadget *g,
 		struct usb_gadget_driver *driver)
 {
 	struct musb		*musb = gadget_to_musb(g);
-	struct usb_otg		*otg = musb->xceiv->otg;
 	unsigned long		flags;
 	int			retval = 0;
 
@@ -1846,7 +1847,9 @@ static int musb_gadget_start(struct usb_gadget *g,
 	spin_lock_irqsave(&musb->lock, flags);
 	musb->is_active = 1;
 
-	otg_set_peripheral(otg, &musb->g);
+	if (musb->xceiv)
+		otg_set_peripheral(musb->xceiv->otg, &musb->g);
+
 	musb_set_state(musb, OTG_STATE_B_IDLE);
 	spin_unlock_irqrestore(&musb->lock, flags);
 
@@ -1856,7 +1859,7 @@ static int musb_gadget_start(struct usb_gadget *g,
 	 * handles power budgeting ... this way also
 	 * ensures HdrcStart is indirectly called.
 	 */
-	if (musb->xceiv->last_event == USB_EVENT_ID)
+	if (musb->xceiv && musb->xceiv->last_event == USB_EVENT_ID)
 		musb_platform_set_vbus(musb, 1);
 
 	pm_runtime_mark_last_busy(musb->controller);
@@ -1894,7 +1897,9 @@ static int musb_gadget_stop(struct usb_gadget *g)
 
 	musb_set_state(musb, OTG_STATE_UNDEFINED);
 	musb_stop(musb);
-	otg_set_peripheral(musb->xceiv->otg, NULL);
+
+	if (musb->xceiv)
+		otg_set_peripheral(musb->xceiv->otg, NULL);
 
 	musb->is_active = 0;
 	musb->gadget_driver = NULL;
diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index 7db464e50cf9..d8793f8df25c 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -2728,10 +2728,14 @@ int musb_host_setup(struct musb *musb, int power_budget)
 		MUSB_HST_MODE(musb);
 		musb_set_state(musb, OTG_STATE_A_IDLE);
 	}
-	otg_set_host(musb->xceiv->otg, &hcd->self);
+
+	if (musb->xceiv) {
+		otg_set_host(musb->xceiv->otg, &hcd->self);
+		musb->xceiv->otg->host = &hcd->self;
+	}
+
 	/* don't support otg protocols */
 	hcd->self.otg_port = 0;
-	musb->xceiv->otg->host = &hcd->self;
 	hcd->power_budget = 2 * (power_budget ? : 250);
 	hcd->skip_phy_initialization = 1;
 
diff --git a/drivers/usb/musb/musb_virthub.c b/drivers/usb/musb/musb_virthub.c
index 7eb929d75280..2b2164e028b3 100644
--- a/drivers/usb/musb/musb_virthub.c
+++ b/drivers/usb/musb/musb_virthub.c
@@ -50,7 +50,6 @@ void musb_host_finish_resume(struct work_struct *work)
 
 int musb_port_suspend(struct musb *musb, bool do_suspend)
 {
-	struct usb_otg	*otg = musb->xceiv->otg;
 	u8		power;
 	void __iomem	*mbase = musb->mregs;
 
@@ -88,7 +87,8 @@ int musb_port_suspend(struct musb *musb, bool do_suspend)
 		switch (musb_get_state(musb)) {
 		case OTG_STATE_A_HOST:
 			musb_set_state(musb, OTG_STATE_A_SUSPEND);
-			musb->is_active = otg->host->b_hnp_enable;
+			musb->is_active = musb->xceiv &&
+				musb->xceiv->otg->host->b_hnp_enable;
 			if (musb->is_active)
 				mod_timer(&musb->otg_timer, jiffies
 					+ msecs_to_jiffies(
@@ -97,7 +97,8 @@ int musb_port_suspend(struct musb *musb, bool do_suspend)
 			break;
 		case OTG_STATE_B_HOST:
 			musb_set_state(musb, OTG_STATE_B_WAIT_ACON);
-			musb->is_active = otg->host->b_hnp_enable;
+			musb->is_active = musb->xceiv &&
+				musb->xceiv->otg->host->b_hnp_enable;
 			musb_platform_try_idle(musb, 0);
 			break;
 		default:
@@ -196,8 +197,6 @@ void musb_port_reset(struct musb *musb, bool do_reset)
 
 void musb_root_disconnect(struct musb *musb)
 {
-	struct usb_otg	*otg = musb->xceiv->otg;
-
 	musb->port1_status = USB_PORT_STAT_POWER
 			| (USB_PORT_STAT_C_CONNECTION << 16);
 
@@ -206,7 +205,7 @@ void musb_root_disconnect(struct musb *musb)
 
 	switch (musb_get_state(musb)) {
 	case OTG_STATE_A_SUSPEND:
-		if (otg->host->b_hnp_enable) {
+		if (musb->xceiv && musb->xceiv->otg->host->b_hnp_enable) {
 			musb_set_state(musb, OTG_STATE_A_PERIPHERAL);
 			musb->g.is_a_peripheral = 1;
 			break;
-- 
2.29.2

