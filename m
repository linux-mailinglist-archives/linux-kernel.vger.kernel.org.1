Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 026DA2AC9C3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 01:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730849AbgKJAiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 19:38:52 -0500
Received: from mga04.intel.com ([192.55.52.120]:25963 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730608AbgKJAis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 19:38:48 -0500
IronPort-SDR: dFMXm2GE5FHXUWhkCiaOtLJEqlUscMM803h7GIdYgCr/ThiTaBoVpPb8tR9iUY/ZGQZHfXnsST
 K4cto56jIipA==
X-IronPort-AV: E=McAfee;i="6000,8403,9800"; a="167308563"
X-IronPort-AV: E=Sophos;i="5.77,464,1596524400"; 
   d="scan'208";a="167308563"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 16:38:48 -0800
IronPort-SDR: 8+NyTaOfgOqfj3dSponRGgWOUyPbqwLPWrxFYMIP3BIM+0VuP4bODYMzSh+olKTJjaxzAuktwS
 Xne/VfvlYHzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,464,1596524400"; 
   d="scan'208";a="354312344"
Received: from uhpatel-desk4.jf.intel.com (HELO uhpatel-desk4.intel.com) ([10.23.15.15])
  by orsmga008.jf.intel.com with ESMTP; 09 Nov 2020 16:38:48 -0800
From:   Utkarsh Patel <utkarsh.h.patel@intel.com>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com, pmalani@chromium.org,
        enric.balletbo@collabora.com, rajmohan.mani@intel.com,
        azhar.shaikh@intel.com, Utkarsh Patel <utkarsh.h.patel@intel.com>
Subject: [PATCH 3/8] usb: typec: intel_pmc_mux: Configure Thunderbolt cable generation bits
Date:   Mon,  9 Nov 2020 16:37:11 -0800
Message-Id: <20201110003716.5164-4-utkarsh.h.patel@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201110003716.5164-1-utkarsh.h.patel@intel.com>
References: <20201110003716.5164-1-utkarsh.h.patel@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thunderbolt cable generation bits received as a part of Thunderbolt 3 cable
discover mode VDO needs to be configured for Thunderbolt rounded and
non-rounded cable support in the Thunderbolt alternate mode.

Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>
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

