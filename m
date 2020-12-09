Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC8EF2D399C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 05:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbgLIE0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 23:26:06 -0500
Received: from mga07.intel.com ([134.134.136.100]:28282 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbgLIE0G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 23:26:06 -0500
IronPort-SDR: 5HMtwnCeTs3PMImwkPLSFHkCdkC5y487jQ7iuv073RoRFMp0eN5SxBO9HBFAGd7bFv0iOT2syI
 JaI3Sj7SQopQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9829"; a="238120609"
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; 
   d="scan'208";a="238120609"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 20:25:25 -0800
IronPort-SDR: OYGOrM8MZACGb/CPyOYwUUAMZB+Meksxt4SzcO5bVcjOhgXmhUBaKFiiXPNwMVt7nRxexFXVVk
 bwUnGaD89PNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; 
   d="scan'208";a="376205757"
Received: from uhpatel-desk4.jf.intel.com ([10.23.15.15])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Dec 2020 20:25:25 -0800
From:   Utkarsh Patel <utkarsh.h.patel@intel.com>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com, pmalani@chromium.org,
        enric.balletbo@collabora.com, rajmohan.mani@intel.com,
        azhar.shaikh@intel.com, Utkarsh Patel <utkarsh.h.patel@intel.com>
Subject: [PATCH v4 1/1] usb: typec: intel_pmc_mux: Configure cable generation value for USB4
Date:   Tue,  8 Dec 2020 20:24:08 -0800
Message-Id: <20201209042408.23079-2-utkarsh.h.patel@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201209042408.23079-1-utkarsh.h.patel@intel.com>
References: <20201209042408.23079-1-utkarsh.h.patel@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB4 specification chapter 3 indicates that cable data rates have to be
rounded for USB4 device to operate as USB4.
With that configure cable generation value to use rounded data rates for
USB4.

Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>
---
Changes in v4:
- Removed usage of tbt_mode_vdo since data rates should always be rounded
  in the case of USB4.
- Updated commit message to reflect the change.

Changes in v3:
- Moved TBT_CABLE_ROUNDED_SUPPORT assignment to the same line.

Changes in v2:
- No change.
---
 drivers/usb/typec/mux/intel_pmc_mux.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
index e58ae8a7fefb..cf37a59ce130 100644
--- a/drivers/usb/typec/mux/intel_pmc_mux.c
+++ b/drivers/usb/typec/mux/intel_pmc_mux.c
@@ -327,6 +327,11 @@ pmc_usb_mux_usb4(struct pmc_usb_port *port, struct typec_mux_state *state)
 		fallthrough;
 	default:
 		req.mode_data |= PMC_USB_ALTMODE_ACTIVE_CABLE;
+
+		/* Configure data rate to rounded in the case of Active TBT3
+		 * and USB4 cables.
+		 */
+		req.mode_data |= PMC_USB_ALTMODE_TBT_GEN(1);
 		break;
 	}
 
-- 
2.17.1

