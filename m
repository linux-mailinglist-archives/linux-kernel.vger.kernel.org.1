Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3F3B2CE162
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 23:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729911AbgLCWLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 17:11:19 -0500
Received: from mga14.intel.com ([192.55.52.115]:45507 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbgLCWLT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 17:11:19 -0500
IronPort-SDR: 5KGgysBdH/HDSYYJn/JsyjDx/pnqIcu4YMRbnI6mEYSIu0JCSzGbLBlNa1Aa4/fZtcntZq6MJL
 d+G/reRUaTRA==
X-IronPort-AV: E=McAfee;i="6000,8403,9824"; a="172502586"
X-IronPort-AV: E=Sophos;i="5.78,390,1599548400"; 
   d="scan'208";a="172502586"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2020 14:10:39 -0800
IronPort-SDR: LYlmX9WbfHSyvShZQdW8EeHv+ntY8nM30ZL6+p8bsedPOGI7QeRFy4kl/AIecGL1vbwtGRNbsE
 G03M+MgrObIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,390,1599548400"; 
   d="scan'208";a="330989885"
Received: from uhpatel-desk4.jf.intel.com (HELO uhpatel-desk4.intel.com) ([10.23.15.15])
  by orsmga003.jf.intel.com with ESMTP; 03 Dec 2020 14:10:38 -0800
From:   Utkarsh Patel <utkarsh.h.patel@intel.com>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com, rajmohan.mani@intel.com,
        azhar.shaikh@intel.com, Utkarsh Patel <utkarsh.h.patel@intel.com>
Subject: [PATCH] usb: typec: intel_pmc_mux: Use correct response message bits
Date:   Thu,  3 Dec 2020 14:08:13 -0800
Message-Id: <20201203220813.16281-1-utkarsh.h.patel@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When Intel PMC Mux agent driver receives the response message from PMC, it
checks for the same response bits for all the mux states.
Corrected it by checking correct response message bits, Bit 8 & 9 for the
SAFE Mode and Alternate Modes and Bit 16 & 17 for the Connect and
Disconnect Modes.

Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>
---
 drivers/usb/typec/mux/intel_pmc_mux.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
index aa3211f1c4c3..e58ae8a7fefb 100644
--- a/drivers/usb/typec/mux/intel_pmc_mux.c
+++ b/drivers/usb/typec/mux/intel_pmc_mux.c
@@ -176,6 +176,7 @@ static int hsl_orientation(struct pmc_usb_port *port)
 static int pmc_usb_command(struct pmc_usb_port *port, u8 *msg, u32 len)
 {
 	u8 response[4];
+	u8 status_res;
 	int ret;
 
 	/*
@@ -189,9 +190,13 @@ static int pmc_usb_command(struct pmc_usb_port *port, u8 *msg, u32 len)
 	if (ret)
 		return ret;
 
-	if (response[2] & PMC_USB_RESP_STATUS_FAILURE) {
-		if (response[2] & PMC_USB_RESP_STATUS_FATAL)
+	status_res = (msg[0] & 0xf) < PMC_USB_SAFE_MODE ?
+		     response[2] : response[1];
+
+	if (status_res & PMC_USB_RESP_STATUS_FAILURE) {
+		if (status_res & PMC_USB_RESP_STATUS_FATAL)
 			return -EIO;
+
 		return -EBUSY;
 	}
 
-- 
2.17.1

