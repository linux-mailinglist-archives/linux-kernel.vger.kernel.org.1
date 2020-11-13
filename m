Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B39642B2570
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 21:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgKMU1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 15:27:01 -0500
Received: from mga06.intel.com ([134.134.136.31]:13747 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbgKMU07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 15:26:59 -0500
IronPort-SDR: 09W50NKRHJwRQmyIpDCfiaz2nlbfTNKlJDr7GSuLBpamCDQDLnHz0d7CNc3ntPkeYCz4Y+Cw2Z
 rE9oVuU4iGDQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9804"; a="232145828"
X-IronPort-AV: E=Sophos;i="5.77,476,1596524400"; 
   d="scan'208";a="232145828"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2020 12:26:55 -0800
IronPort-SDR: i29wMykUxtWb7qPZ5mtgPhDowYjpWDUJHeWScD0Ezb4AXBTld5he7EcK1tj6Q8nDucAp2mgK4c
 zYLM3JYnQqDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,476,1596524400"; 
   d="scan'208";a="367050290"
Received: from uhpatel-desk4.jf.intel.com (HELO uhpatel-desk4.intel.com) ([10.23.15.15])
  by orsmga007.jf.intel.com with ESMTP; 13 Nov 2020 12:26:55 -0800
From:   Utkarsh Patel <utkarsh.h.patel@intel.com>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com, pmalani@chromium.org,
        enric.balletbo@collabora.com, rajmohan.mani@intel.com,
        azhar.shaikh@intel.com, Utkarsh Patel <utkarsh.h.patel@intel.com>
Subject: [PATCH v2 7/8] usb: typec: intel_pmc_mux: Configure active cable properties for USB4
Date:   Fri, 13 Nov 2020 12:25:02 -0800
Message-Id: <20201113202503.6559-8-utkarsh.h.patel@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201113202503.6559-1-utkarsh.h.patel@intel.com>
References: <20201113202503.6559-1-utkarsh.h.patel@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Value received as a part of Thunderbolt 3 cable discover mode VDO needs
to be configured in the USB4 mode for the Thunderbolt rounded support and
active cable plug link training.

Suggested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>

--
Changes in v2:
- No change.
--
---
 drivers/usb/typec/mux/intel_pmc_mux.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
index aa3211f1c4c3..61feb358aad3 100644
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
 
@@ -322,6 +320,20 @@ pmc_usb_mux_usb4(struct pmc_usb_port *port, struct typec_mux_state *state)
 		fallthrough;
 	default:
 		req.mode_data |= PMC_USB_ALTMODE_ACTIVE_CABLE;
+
+		if (data->tbt_cable_vdo) {
+			/* Active Thunderbolt 3 cable */
+			if (data->tbt_cable_vdo & TBT_CABLE_LINK_TRAINING)
+				req.mode_data |= PMC_USB_ALTMODE_ACTIVE_LINK;
+
+			cable_rounded =
+				TBT_CABLE_ROUNDED_SUPPORT(data->tbt_cable_vdo);
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

