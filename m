Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 885422AB7EC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 13:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729503AbgKIMM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 07:12:28 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:45910 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727311AbgKIMM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 07:12:27 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07515754|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0384173-0.00122631-0.960356;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047187;MF=frank@allwinnertech.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.IuVY7XN_1604923937;
Received: from allwinnertech.com(mailfrom:frank@allwinnertech.com fp:SMTPD_---.IuVY7XN_1604923937)
          by smtp.aliyun-inc.com(10.147.41.121);
          Mon, 09 Nov 2020 20:12:21 +0800
From:   Frank Lee <frank@allwinnertech.com>
To:     vkoul@kernel.org, mripard@kernel.org, wens@csie.org,
        krzk@kernel.org, colin.king@canonical.com, tiny.windzz@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Yangtao Li <frank@allwinnertech.com>
Subject: [PATCH 3/3] phy: sun4i-usb: Use power efficient workqueue for debounce and poll
Date:   Mon,  9 Nov 2020 20:12:14 +0800
Message-Id: <20201109121214.19012-1-frank@allwinnertech.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <frank@allwinnertech.com>

The debounce and poll time is generally quite long and the work not
performance critical so allow the scheduler to run the work anywhere
rather than in the normal per-CPU workqueue.

Signed-off-by: Yangtao Li <frank@allwinnertech.com>
---
 drivers/phy/allwinner/phy-sun4i-usb.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/phy/allwinner/phy-sun4i-usb.c b/drivers/phy/allwinner/phy-sun4i-usb.c
index 651d5e2a25ce..4787ad13b255 100644
--- a/drivers/phy/allwinner/phy-sun4i-usb.c
+++ b/drivers/phy/allwinner/phy-sun4i-usb.c
@@ -326,7 +326,7 @@ static int sun4i_usb_phy_init(struct phy *_phy)
 		/* Force ISCR and cable state updates */
 		data->id_det = -1;
 		data->vbus_det = -1;
-		queue_delayed_work(system_wq, &data->detect, 0);
+		queue_delayed_work(system_power_efficient_wq, &data->detect, 0);
 	}
 
 	return 0;
@@ -444,7 +444,7 @@ static int sun4i_usb_phy_power_on(struct phy *_phy)
 
 	/* We must report Vbus high within OTG_TIME_A_WAIT_VRISE msec. */
 	if (phy->index == 0 && sun4i_usb_phy0_poll(data))
-		mod_delayed_work(system_wq, &data->detect, DEBOUNCE_TIME);
+		mod_delayed_work(system_power_efficient_wq, &data->detect, DEBOUNCE_TIME);
 
 	return 0;
 }
@@ -465,7 +465,7 @@ static int sun4i_usb_phy_power_off(struct phy *_phy)
 	 * Vbus gpio to not trigger an edge irq on Vbus off, so force a rescan.
 	 */
 	if (phy->index == 0 && !sun4i_usb_phy0_poll(data))
-		mod_delayed_work(system_wq, &data->detect, POLL_TIME);
+		mod_delayed_work(system_power_efficient_wq, &data->detect, POLL_TIME);
 
 	return 0;
 }
@@ -504,7 +504,7 @@ static int sun4i_usb_phy_set_mode(struct phy *_phy,
 
 	data->id_det = -1; /* Force reprocessing of id */
 	data->force_session_end = true;
-	queue_delayed_work(system_wq, &data->detect, 0);
+	queue_delayed_work(system_power_efficient_wq, &data->detect, 0);
 
 	return 0;
 }
@@ -616,7 +616,7 @@ static void sun4i_usb_phy0_id_vbus_det_scan(struct work_struct *work)
 		extcon_set_state_sync(data->extcon, EXTCON_USB, vbus_det);
 
 	if (sun4i_usb_phy0_poll(data))
-		queue_delayed_work(system_wq, &data->detect, POLL_TIME);
+		queue_delayed_work(system_power_efficient_wq, &data->detect, POLL_TIME);
 }
 
 static irqreturn_t sun4i_usb_phy0_id_vbus_det_irq(int irq, void *dev_id)
@@ -624,7 +624,7 @@ static irqreturn_t sun4i_usb_phy0_id_vbus_det_irq(int irq, void *dev_id)
 	struct sun4i_usb_phy_data *data = dev_id;
 
 	/* vbus or id changed, let the pins settle and then scan them */
-	mod_delayed_work(system_wq, &data->detect, DEBOUNCE_TIME);
+	mod_delayed_work(system_power_efficient_wq, &data->detect, DEBOUNCE_TIME);
 
 	return IRQ_HANDLED;
 }
@@ -638,7 +638,7 @@ static int sun4i_usb_phy0_vbus_notify(struct notifier_block *nb,
 
 	/* Properties on the vbus_power_supply changed, scan vbus_det */
 	if (val == PSY_EVENT_PROP_CHANGED && psy == data->vbus_power_supply)
-		mod_delayed_work(system_wq, &data->detect, DEBOUNCE_TIME);
+		mod_delayed_work(system_power_efficient_wq, &data->detect, DEBOUNCE_TIME);
 
 	return NOTIFY_OK;
 }
-- 
2.28.0

