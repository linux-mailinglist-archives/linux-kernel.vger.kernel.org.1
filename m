Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37D262DC1E1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 15:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbgLPOKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 09:10:54 -0500
Received: from mga07.intel.com ([134.134.136.100]:25008 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726332AbgLPOKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 09:10:53 -0500
IronPort-SDR: MA5sCidqquxWUW95zH8OLFgEjnNfi1xjbjFThGCLObkXYLG6Ke4qpHoMsx0nMMKMjxnTOELOLT
 W29nEHjzBYXA==
X-IronPort-AV: E=McAfee;i="6000,8403,9836"; a="239161740"
X-IronPort-AV: E=Sophos;i="5.78,424,1599548400"; 
   d="scan'208";a="239161740"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2020 06:10:12 -0800
IronPort-SDR: Ds0uP0VSA1bCoI57L0lM2BwJmKkXn43OmKxFVsJbwNZxJ+hx45xZ0dBD6yNo8RcPgHvDEZCahA
 AyJiaOyx/8mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,424,1599548400"; 
   d="scan'208";a="386477446"
Received: from pktinlab.iind.intel.com ([10.66.241.160])
  by fmsmga002.fm.intel.com with ESMTP; 16 Dec 2020 06:10:10 -0800
From:   Madhusudanarao Amara <madhusudanarao.amara@intel.com>
To:     heikki.krogerus@intel.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com, madhusudanarao.amara@intel.com
Subject: [PATCH v1] usb: typec: intel_pmc_mux: Configure HPD first for HPD+IRQ request
Date:   Wed, 16 Dec 2020 19:39:18 +0530
Message-Id: <20201216140918.49197-1-madhusudanarao.amara@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Warm reboot scenarios some times type C Mux driver gets Mux configuration
request as HPD=1,IRQ=1. In that scenario typeC Mux driver need to configure
Mux as follows as per IOM requirement:
 (1). Confgiure Mux HPD = 1, IRQ = 0
 (2). Configure Mux with HPD = 1, IRQ = 1

IOM expects TypeC Mux configuration as follows:
 (1). HPD=1, IRQ=0
 (2). HPD=1, IRQ=1
if IOM gets mux config request (2) without configuring (1), it will ignore
the request. The impact of this is there is no DP_alt mode display.

Fixes: 43d596e32276 ("usb: typec: intel_pmc_mux: Check the port status before connect")
Cc: stable@vger.kernel.org
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Madhusudanarao Amara <madhusudanarao.amara@intel.com>
---
 drivers/usb/typec/mux/intel_pmc_mux.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
index cf37a59ce130..46a25b8db72e 100644
--- a/drivers/usb/typec/mux/intel_pmc_mux.c
+++ b/drivers/usb/typec/mux/intel_pmc_mux.c
@@ -207,10 +207,21 @@ static int
 pmc_usb_mux_dp_hpd(struct pmc_usb_port *port, struct typec_displayport_data *dp)
 {
 	u8 msg[2] = { };
+	int ret;
 
 	msg[0] = PMC_USB_DP_HPD;
 	msg[0] |= port->usb3_port << PMC_USB_MSG_USB3_PORT_SHIFT;
 
+	/* Configure HPD first if HPD,IRQ comes together */
+	if (!IOM_PORT_HPD_ASSERTED(port->iom_status) &&
+	    dp->status & DP_STATUS_IRQ_HPD &&
+	    dp->status & DP_STATUS_HPD_STATE) {
+		msg[1] = PMC_USB_DP_HPD_LVL;
+		ret = pmc_usb_command(port, msg, sizeof(msg));
+		if (ret)
+			return ret;
+	}
+
 	if (dp->status & DP_STATUS_IRQ_HPD)
 		msg[1] = PMC_USB_DP_HPD_IRQ;
 
-- 
2.17.1

