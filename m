Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6233B2B256D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 21:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgKMU06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 15:26:58 -0500
Received: from mga06.intel.com ([134.134.136.31]:13739 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbgKMU04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 15:26:56 -0500
IronPort-SDR: DQRTFUfTiH8AOdwVl8kWn/xI5zMEirezSbi9K0qwbPx7vA09uyASlgU1IwbOtqkEOBbJNRLaFX
 FO3uUQE8eGIw==
X-IronPort-AV: E=McAfee;i="6000,8403,9804"; a="232145824"
X-IronPort-AV: E=Sophos;i="5.77,476,1596524400"; 
   d="scan'208";a="232145824"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2020 12:26:54 -0800
IronPort-SDR: vKKnmB9R8KKVlCCxVaMUZVnKsP4BGr4X6wOENHvwPN1MH0c7ZrqLMtNqziDFxPQhwURbCnuh80
 OcUw3q5EuqzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,476,1596524400"; 
   d="scan'208";a="367050277"
Received: from uhpatel-desk4.jf.intel.com (HELO uhpatel-desk4.intel.com) ([10.23.15.15])
  by orsmga007.jf.intel.com with ESMTP; 13 Nov 2020 12:26:54 -0800
From:   Utkarsh Patel <utkarsh.h.patel@intel.com>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com, pmalani@chromium.org,
        enric.balletbo@collabora.com, rajmohan.mani@intel.com,
        azhar.shaikh@intel.com, Utkarsh Patel <utkarsh.h.patel@intel.com>
Subject: [PATCH v2 3/8] usb: typec: intel_pmc_mux: Configure Thunderbolt cable generation bits
Date:   Fri, 13 Nov 2020 12:24:58 -0800
Message-Id: <20201113202503.6559-4-utkarsh.h.patel@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201113202503.6559-1-utkarsh.h.patel@intel.com>
References: <20201113202503.6559-1-utkarsh.h.patel@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thunderbolt cable generation bits received as a part of Thunderbolt 3 cable
discover mode VDO needs to be configured for Thunderbolt rounded and
non-rounded cable support in the Thunderbolt alternate mode.

Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>

--
Changes in v2:
- No change.
--
---
 drivers/usb/typec/mux/intel_pmc_mux.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
index d7f63b74c6b1..aa3211f1c4c3 100644
--- a/drivers/usb/typec/mux/intel_pmc_mux.c
+++ b/drivers/usb/typec/mux/intel_pmc_mux.c
@@ -256,6 +256,7 @@ static int
 pmc_usb_mux_tbt(struct pmc_usb_port *port, struct typec_mux_state *state)
 {
 	struct typec_thunderbolt_data *data = state->data;
+	u8 cable_rounded = TBT_CABLE_ROUNDED_SUPPORT(data->cable_mode);
 	u8 cable_speed = TBT_CABLE_SPEED(data->cable_mode);
 	struct altmode_req req = { };
 
@@ -284,6 +285,8 @@ pmc_usb_mux_tbt(struct pmc_usb_port *port, struct typec_mux_state *state)
 
 	req.mode_data |= PMC_USB_ALTMODE_CABLE_SPD(cable_speed);
 
+	req.mode_data |= PMC_USB_ALTMODE_TBT_GEN(cable_rounded);
+
 	return pmc_usb_command(port, (void *)&req, sizeof(req));
 }
 
-- 
2.17.1

