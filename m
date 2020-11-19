Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0A632B8BB5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 07:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbgKSGeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 01:34:04 -0500
Received: from mga18.intel.com ([134.134.136.126]:60908 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgKSGeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 01:34:03 -0500
IronPort-SDR: t9cfQbu2ZCqaI/7Tv/6kLlxHuC+ysuE2/KPf4EhJLAFoorrnJiTbXcRvZ+RzqBoFBH8c58+9vR
 pGojgS9ZTxIQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="159012436"
X-IronPort-AV: E=Sophos;i="5.77,489,1596524400"; 
   d="scan'208";a="159012436"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 22:34:03 -0800
IronPort-SDR: zJFWwwBEn4llxBO/Lsm0z9v4cLZajdPN1YHMpzLDBWWgbGHC8rsJ4jFRXrue+LUjPX9U7nGHAJ
 7scFcgnkFOkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,489,1596524400"; 
   d="scan'208";a="544877914"
Received: from uhpatel-desk4.jf.intel.com (HELO uhpatel-desk4.intel.com) ([10.23.15.15])
  by orsmga005.jf.intel.com with ESMTP; 18 Nov 2020 22:34:03 -0800
From:   Utkarsh Patel <utkarsh.h.patel@intel.com>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com, pmalani@chromium.org,
        enric.balletbo@collabora.com, rajmohan.mani@intel.com,
        azhar.shaikh@intel.com, Utkarsh Patel <utkarsh.h.patel@intel.com>
Subject: [PATCH v3 3/4] usb: typec: intel_pmc_mux: Configure active cable properties for USB4
Date:   Wed, 18 Nov 2020 22:32:10 -0800
Message-Id: <20201119063211.2264-4-utkarsh.h.patel@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201119063211.2264-1-utkarsh.h.patel@intel.com>
References: <20201119063211.2264-1-utkarsh.h.patel@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Value received as a part of Thunderbolt 3 cable discover mode VDO needs
to be configured in the USB4 mode for the cable rounded support and
active cable plug link training.

Suggested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>

--
Changes in v3:
- Moved TBT_CABLE_ROUNDED_SUPPORT assignment to the same line.

Changes in v2:
- No change.
--
---
 drivers/usb/typec/mux/intel_pmc_mux.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
index aa3211f1c4c3..baf343b14682 100644
--- a/drivers/usb/typec/mux/intel_pmc_mux.c
+++ b/drivers/usb/typec/mux/intel_pmc_mux.c
@@ -295,6 +295,7 @@ pmc_usb_mux_usb4(struct pmc_usb_port *port, struct typec_mux_state *state)
 {
 	struct enter_usb_data *data = state->data;
 	struct altmode_req req = { };
+	u8 cable_rounded;
 	u8 cable_speed;
 
 	if (IOM_PORT_ACTIVITY_IS(port->iom_status, TBT) ||
@@ -308,9 +309,6 @@ pmc_usb_mux_usb4(struct pmc_usb_port *port, struct typec_mux_state *state)
 	/* USB4 Mode */
 	req.mode_data = PMC_USB_ALTMODE_FORCE_LSR;
 
-	if (data->active_link_training)
-		req.mode_data |= PMC_USB_ALTMODE_ACTIVE_LINK;
-
 	req.mode_data |= (port->orientation - 1) << PMC_USB_ALTMODE_ORI_SHIFT;
 	req.mode_data |= (port->role - 1) << PMC_USB_ALTMODE_UFP_SHIFT;
 
@@ -322,6 +320,19 @@ pmc_usb_mux_usb4(struct pmc_usb_port *port, struct typec_mux_state *state)
 		fallthrough;
 	default:
 		req.mode_data |= PMC_USB_ALTMODE_ACTIVE_CABLE;
+
+		if (data->tbt_cable_vdo) {
+			/* Active Thunderbolt 3 cable */
+			if (data->tbt_cable_vdo & TBT_CABLE_LINK_TRAINING)
+				req.mode_data |= PMC_USB_ALTMODE_ACTIVE_LINK;
+
+			cable_rounded = TBT_CABLE_ROUNDED_SUPPORT(data->tbt_cable_vdo);
+			req.mode_data |= PMC_USB_ALTMODE_TBT_GEN(cable_rounded);
+		} else {
+			/* Active USB4 cable */
+			req.mode_data |= PMC_USB_ALTMODE_ACTIVE_LINK |
+				PMC_USB_ALTMODE_TBT_GEN(1);
+		}
 		break;
 	}
 
-- 
2.17.1

