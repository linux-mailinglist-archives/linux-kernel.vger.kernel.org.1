Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E97AA2D1154
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 14:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbgLGNFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 08:05:12 -0500
Received: from aposti.net ([89.234.176.197]:35016 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726061AbgLGNFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 08:05:12 -0500
From:   Paul Cercueil <paul@crapouillou.net>
To:     Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     od@zcrc.me, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 2/4] usb: musb: Add and use inline function musb_otg_state_string
Date:   Mon,  7 Dec 2020 13:03:30 +0000
Message-Id: <20201207130332.120681-2-paul@crapouillou.net>
In-Reply-To: <20201207130332.120681-1-paul@crapouillou.net>
References: <20201207130332.120681-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The musb_otg_state_string() simply calls usb_otg_state_string().
This will make it easier to get rid of the musb->xceiv dependency later.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/usb/musb/musb_core.c    | 43 +++++++++++++++------------------
 drivers/usb/musb/musb_core.h    |  5 ++++
 drivers/usb/musb/musb_gadget.c  |  8 +++---
 drivers/usb/musb/musb_host.c    |  2 +-
 drivers/usb/musb/musb_virthub.c |  4 +--
 5 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index c4665d08aa33..8e8861955545 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -609,13 +609,13 @@ static void musb_otg_timer_func(struct timer_list *t)
 	case OTG_STATE_A_SUSPEND:
 	case OTG_STATE_A_WAIT_BCON:
 		musb_dbg(musb, "HNP: %s timeout",
-			usb_otg_state_string(musb->xceiv->otg->state));
+			 musb_otg_state_string(musb));
 		musb_platform_set_vbus(musb, 0);
 		musb_set_state(musb, OTG_STATE_A_WAIT_VFALL);
 		break;
 	default:
 		musb_dbg(musb, "HNP: Unhandled mode %s",
-			usb_otg_state_string(musb->xceiv->otg->state));
+			 musb_otg_state_string(musb));
 	}
 	spin_unlock_irqrestore(&musb->lock, flags);
 }
@@ -629,14 +629,12 @@ void musb_hnp_stop(struct musb *musb)
 	void __iomem	*mbase = musb->mregs;
 	u8	reg;
 
-	musb_dbg(musb, "HNP: stop from %s",
-			usb_otg_state_string(musb->xceiv->otg->state));
+	musb_dbg(musb, "HNP: stop from %s", musb_otg_state_string(musb));
 
 	switch (musb_get_state(musb)) {
 	case OTG_STATE_A_PERIPHERAL:
 		musb_g_disconnect(musb);
-		musb_dbg(musb, "HNP: back to %s",
-			usb_otg_state_string(musb->xceiv->otg->state));
+		musb_dbg(musb, "HNP: back to %s", musb_otg_state_string(musb));
 		break;
 	case OTG_STATE_B_HOST:
 		musb_dbg(musb, "HNP: Disabling HR");
@@ -651,7 +649,7 @@ void musb_hnp_stop(struct musb *musb)
 		break;
 	default:
 		musb_dbg(musb, "HNP: Stopping in unknown state %s",
-			usb_otg_state_string(musb->xceiv->otg->state));
+			 musb_otg_state_string(musb));
 	}
 
 	/*
@@ -666,8 +664,7 @@ static void musb_recover_from_babble(struct musb *musb);
 
 static void musb_handle_intr_resume(struct musb *musb, u8 devctl)
 {
-	musb_dbg(musb, "RESUME (%s)",
-			usb_otg_state_string(musb->xceiv->otg->state));
+	musb_dbg(musb, "RESUME (%s)", musb_otg_state_string(musb));
 
 	if (devctl & MUSB_DEVCTL_HM) {
 		switch (musb_get_state(musb)) {
@@ -692,7 +689,7 @@ static void musb_handle_intr_resume(struct musb *musb, u8 devctl)
 		default:
 			WARNING("bogus %s RESUME (%s)\n",
 				"host",
-				usb_otg_state_string(musb->xceiv->otg->state));
+				musb_otg_state_string(musb));
 		}
 	} else {
 		switch (musb_get_state(musb)) {
@@ -721,7 +718,7 @@ static void musb_handle_intr_resume(struct musb *musb, u8 devctl)
 		default:
 			WARNING("bogus %s RESUME (%s)\n",
 				"peripheral",
-				usb_otg_state_string(musb->xceiv->otg->state));
+				musb_otg_state_string(musb));
 		}
 	}
 }
@@ -737,8 +734,7 @@ static irqreturn_t musb_handle_intr_sessreq(struct musb *musb, u8 devctl)
 		return IRQ_HANDLED;
 	}
 
-	musb_dbg(musb, "SESSION_REQUEST (%s)",
-		usb_otg_state_string(musb->xceiv->otg->state));
+	musb_dbg(musb, "SESSION_REQUEST (%s)", musb_otg_state_string(musb));
 
 	/* IRQ arrives from ID pin sense or (later, if VBUS power
 	 * is removed) SRP.  responses are time critical:
@@ -805,7 +801,7 @@ static void musb_handle_intr_vbuserr(struct musb *musb, u8 devctl)
 
 	dev_printk(ignore ? KERN_DEBUG : KERN_ERR, musb->controller,
 			"VBUS_ERROR in %s (%02x, %s), retry #%d, port1 %08x\n",
-			usb_otg_state_string(musb->xceiv->otg->state),
+			musb_otg_state_string(musb),
 			devctl,
 			({ char *s;
 			switch (devctl & MUSB_DEVCTL_VBUS) {
@@ -830,7 +826,7 @@ static void musb_handle_intr_vbuserr(struct musb *musb, u8 devctl)
 static void musb_handle_intr_suspend(struct musb *musb, u8 devctl)
 {
 	musb_dbg(musb, "SUSPEND (%s) devctl %02x",
-		usb_otg_state_string(musb->xceiv->otg->state), devctl);
+		 musb_otg_state_string(musb), devctl);
 
 	switch (musb_get_state(musb)) {
 	case OTG_STATE_A_PERIPHERAL:
@@ -938,13 +934,13 @@ static void musb_handle_intr_connect(struct musb *musb, u8 devctl, u8 int_usb)
 	musb_host_poke_root_hub(musb);
 
 	musb_dbg(musb, "CONNECT (%s) devctl %02x",
-			usb_otg_state_string(musb->xceiv->otg->state), devctl);
+			musb_otg_state_string(musb), devctl);
 }
 
 static void musb_handle_intr_disconnect(struct musb *musb, u8 devctl)
 {
 	musb_dbg(musb, "DISCONNECT (%s) as %s, devctl %02x",
-			usb_otg_state_string(musb->xceiv->otg->state),
+			musb_otg_state_string(musb),
 			MUSB_MODE(musb), devctl);
 
 	switch (musb_get_state(musb)) {
@@ -980,7 +976,7 @@ static void musb_handle_intr_disconnect(struct musb *musb, u8 devctl)
 		break;
 	default:
 		WARNING("unhandled DISCONNECT transition (%s)\n",
-			usb_otg_state_string(musb->xceiv->otg->state));
+			musb_otg_state_string(musb));
 		break;
 	}
 }
@@ -1003,8 +999,7 @@ static void musb_handle_intr_reset(struct musb *musb)
 		dev_err(musb->controller, "Babble\n");
 		musb_recover_from_babble(musb);
 	} else {
-		musb_dbg(musb, "BUS RESET as %s",
-			usb_otg_state_string(musb->xceiv->otg->state));
+		musb_dbg(musb, "BUS RESET as %s", musb_otg_state_string(musb));
 		switch (musb_get_state(musb)) {
 		case OTG_STATE_A_SUSPEND:
 			musb_g_reset(musb);
@@ -1012,7 +1007,7 @@ static void musb_handle_intr_reset(struct musb *musb)
 		case OTG_STATE_A_WAIT_BCON:	/* OPT TD.4.7-900ms */
 			/* never use invalid T(a_wait_bcon) */
 			musb_dbg(musb, "HNP: in %s, %d msec timeout",
-				usb_otg_state_string(musb->xceiv->otg->state),
+				 musb_otg_state_string(musb),
 				TA_WAIT_BCON(musb));
 			mod_timer(&musb->otg_timer, jiffies
 				+ msecs_to_jiffies(TA_WAIT_BCON(musb)));
@@ -1023,7 +1018,7 @@ static void musb_handle_intr_reset(struct musb *musb)
 			break;
 		case OTG_STATE_B_WAIT_ACON:
 			musb_dbg(musb, "HNP: RESET (%s), to b_peripheral",
-				usb_otg_state_string(musb->xceiv->otg->state));
+				 musb_otg_state_string(musb));
 			musb_set_state(musb, OTG_STATE_B_PERIPHERAL);
 			musb_g_reset(musb);
 			break;
@@ -1035,7 +1030,7 @@ static void musb_handle_intr_reset(struct musb *musb)
 			break;
 		default:
 			musb_dbg(musb, "Unhandled BUS RESET as %s",
-				usb_otg_state_string(musb->xceiv->otg->state));
+				 musb_otg_state_string(musb));
 		}
 	}
 }
@@ -1862,7 +1857,7 @@ mode_show(struct device *dev, struct device_attribute *attr, char *buf)
 	int ret;
 
 	spin_lock_irqsave(&musb->lock, flags);
-	ret = sprintf(buf, "%s\n", usb_otg_state_string(musb->xceiv->otg->state));
+	ret = sprintf(buf, "%s\n", musb_otg_state_string(musb));
 	spin_unlock_irqrestore(&musb->lock, flags);
 
 	return ret;
diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
index 8c0fec972b65..363481df1ceb 100644
--- a/drivers/usb/musb/musb_core.h
+++ b/drivers/usb/musb/musb_core.h
@@ -603,6 +603,11 @@ static inline enum usb_otg_state musb_get_state(struct musb *musb)
 	return musb->xceiv->otg->state;
 }
 
+static inline const char *musb_otg_state_string(struct musb *musb)
+{
+	return usb_otg_state_string(musb_get_state(musb));
+}
+
 /*
  * gets the "dr_mode" property from DT and converts it into musb_mode
  * if the property is not found or not recognized returns MUSB_OTG
diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index 2be9b084749b..ba312b43b895 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -1559,7 +1559,7 @@ static int musb_gadget_wakeup(struct usb_gadget *gadget)
 		goto done;
 	default:
 		musb_dbg(musb, "Unhandled wake: %s",
-			usb_otg_state_string(musb->xceiv->otg->state));
+			 musb_otg_state_string(musb));
 		goto done;
 	}
 
@@ -1937,7 +1937,7 @@ void musb_g_resume(struct musb *musb)
 		break;
 	default:
 		WARNING("unhandled RESUME transition (%s)\n",
-				usb_otg_state_string(musb->xceiv->otg->state));
+			musb_otg_state_string(musb));
 	}
 }
 
@@ -1967,7 +1967,7 @@ void musb_g_suspend(struct musb *musb)
 		 * A_PERIPHERAL may need care too
 		 */
 		WARNING("unhandled SUSPEND transition (%s)",
-				usb_otg_state_string(musb->xceiv->otg->state));
+			musb_otg_state_string(musb));
 	}
 }
 
@@ -2001,7 +2001,7 @@ void musb_g_disconnect(struct musb *musb)
 	switch (musb_get_state(musb)) {
 	default:
 		musb_dbg(musb, "Unhandled disconnect %s, setting a_idle",
-			usb_otg_state_string(musb->xceiv->otg->state));
+			 musb_otg_state_string(musb));
 		musb_set_state(musb, OTG_STATE_A_IDLE);
 		MUSB_HST_MODE(musb);
 		break;
diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index 7811a8858c54..7db464e50cf9 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -2525,7 +2525,7 @@ static int musb_bus_suspend(struct usb_hcd *hcd)
 
 	if (musb->is_active) {
 		WARNING("trying to suspend as %s while active\n",
-				usb_otg_state_string(musb->xceiv->otg->state));
+			musb_otg_state_string(musb));
 		return -EBUSY;
 	} else
 		return 0;
diff --git a/drivers/usb/musb/musb_virthub.c b/drivers/usb/musb/musb_virthub.c
index d1cfd45d69e3..7eb929d75280 100644
--- a/drivers/usb/musb/musb_virthub.c
+++ b/drivers/usb/musb/musb_virthub.c
@@ -102,7 +102,7 @@ int musb_port_suspend(struct musb *musb, bool do_suspend)
 			break;
 		default:
 			musb_dbg(musb, "bogus rh suspend? %s",
-				usb_otg_state_string(musb->xceiv->otg->state));
+				 musb_otg_state_string(musb));
 		}
 	} else if (power & MUSB_POWER_SUSPENDM) {
 		power &= ~MUSB_POWER_SUSPENDM;
@@ -221,7 +221,7 @@ void musb_root_disconnect(struct musb *musb)
 		break;
 	default:
 		musb_dbg(musb, "host disconnect (%s)",
-			usb_otg_state_string(musb->xceiv->otg->state));
+			 musb_otg_state_string(musb));
 	}
 }
 EXPORT_SYMBOL_GPL(musb_root_disconnect);
-- 
2.29.2

