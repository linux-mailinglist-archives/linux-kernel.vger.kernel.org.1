Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25DBD2D539E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 07:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733098AbgLJGLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 01:11:41 -0500
Received: from mga17.intel.com ([192.55.52.151]:43534 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733092AbgLJGLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 01:11:17 -0500
IronPort-SDR: /gySunIWU5ufzlVExBFbHcfhO2EB5ErVr04SAlYaOfCfQ5YH/Ruvvs31DADqYO7T9bhw+gptB3
 wShU3HA4BH6Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9830"; a="154009986"
X-IronPort-AV: E=Sophos;i="5.78,407,1599548400"; 
   d="scan'208";a="154009986"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2020 22:10:36 -0800
IronPort-SDR: jhblvtUr0H7uJQPeszTicgOreuMAcetI/7cZtaPqbM6PWfzAQWmdJN7KGlHSxLYrnZpBQnfHAO
 k4oi1pJ0av2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,407,1599548400"; 
   d="scan'208";a="368644910"
Received: from uhpatel-desk4.jf.intel.com ([10.23.15.15])
  by fmsmga004.fm.intel.com with ESMTP; 09 Dec 2020 22:10:36 -0800
From:   Utkarsh Patel <utkarsh.h.patel@intel.com>
To:     linux-kernel@vger.kernel.org, enric.balletbo@collabora.com,
        pmalani@chromium.org, bleung@chromium.org
Cc:     heikki.krogerus@linux.intel.com, rajmohan.mani@intel.com,
        Utkarsh Patel <utkarsh.h.patel@intel.com>
Subject: [PATCH 2/2] platform/chrome: cros_ec_typec: Send mux configuration acknowledgment to EC
Date:   Wed,  9 Dec 2020 22:09:03 -0800
Message-Id: <20201210060903.2205-3-utkarsh.h.patel@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201210060903.2205-1-utkarsh.h.patel@intel.com>
References: <20201210060903.2205-1-utkarsh.h.patel@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some corner cases downgrade of the superspeed typec device(e.g. Dell
typec Dock, apple dongle) was seen because before the SOC mux configuration
finishes, EC starts configuring the next mux state.

With this change, once the SOC mux is configured, kernel will send an
acknowledgment to EC via Host command EC_CMD_USB_PD_MUX_ACK [1].
After sending the host event EC will wait for the acknowledgment from
kernel before starting the PD negotiation for the next mux state. This
helps to have a framework to build better error handling along with the
synchronization of timing sensitive mux states.

This change also brings in corresponding EC header updates from the EC code
base [1].

[1]:
https://chromium.googlesource.com/chromiumos/platform/ec/+/refs/heads/master/include/ec_commands.h

Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>
---
 drivers/platform/chrome/cros_ec_typec.c        | 16 ++++++++++++++++
 include/linux/platform_data/cros_ec_commands.h | 17 +++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 650aa5332055..e6abe205890c 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -74,6 +74,7 @@ struct cros_typec_data {
 	struct notifier_block nb;
 	struct work_struct port_work;
 	bool typec_cmd_supported;
+	bool needs_mux_ack;
 };
 
 static int cros_typec_parse_port_props(struct typec_capability *cap,
@@ -503,6 +504,7 @@ static int cros_typec_configure_mux(struct cros_typec_data *typec, int port_num,
 				struct ec_response_usb_pd_control_v2 *pd_ctrl)
 {
 	struct cros_typec_port *port = typec->ports[port_num];
+	struct ec_params_usb_pd_mux_ack mux_ack;
 	enum typec_orientation orientation;
 	int ret;
 
@@ -543,6 +545,18 @@ static int cros_typec_configure_mux(struct cros_typec_data *typec, int port_num,
 		ret = -ENOTSUPP;
 	}
 
+	if (!typec->needs_mux_ack)
+		return ret;
+
+	/* Sending Acknowledgment to EC */
+	mux_ack.port = port_num;
+
+	if (cros_typec_ec_command(typec, 0, EC_CMD_USB_PD_MUX_ACK, &mux_ack,
+				  sizeof(mux_ack), NULL, 0) < 0)
+		dev_warn(typec->dev,
+			 "Failed to send Mux ACK to EC for port: %d\n",
+			 port_num);
+
 	return ret;
 }
 
@@ -908,6 +922,8 @@ static int cros_typec_probe(struct platform_device *pdev)
 
 	typec->typec_cmd_supported = !!cros_typec_feature_supported(typec,
 					EC_FEATURE_TYPEC_CMD);
+	typec->needs_mux_ack = !!cros_typec_feature_supported(typec,
+					EC_FEATURE_TYPEC_MUX_REQUIRE_AP_ACK);
 
 	ret = cros_typec_ec_command(typec, 0, EC_CMD_USB_PD_PORTS, NULL, 0,
 				    &resp, sizeof(resp));
diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
index 7f54fdcdd8cb..3b53e45cb5a0 100644
--- a/include/linux/platform_data/cros_ec_commands.h
+++ b/include/linux/platform_data/cros_ec_commands.h
@@ -1286,6 +1286,16 @@ enum ec_feature_code {
 	EC_FEATURE_ISH = 40,
 	/* New TCPMv2 TYPEC_ prefaced commands supported */
 	EC_FEATURE_TYPEC_CMD = 41,
+	/*
+	 * The EC will wait for direction from the AP to enter Type-C alternate
+	 * modes or USB4.
+	 */
+	EC_FEATURE_TYPEC_REQUIRE_AP_MODE_ENTRY = 42,
+	/*
+	 * The EC will wait for an acknowledge from the AP after setting the
+	 * mux.
+	 */
+	EC_FEATURE_TYPEC_MUX_REQUIRE_AP_ACK = 43,
 };
 
 #define EC_FEATURE_MASK_0(event_code) BIT(event_code % 32)
@@ -6054,6 +6064,13 @@ struct ec_params_charger_control {
 	uint8_t allow_charging;
 } __ec_align_size1;
 
+/* Get ACK from the USB-C SS muxes */
+#define EC_CMD_USB_PD_MUX_ACK 0x0603
+
+struct ec_params_usb_pd_mux_ack {
+	uint8_t port; /* USB-C port number */
+} __ec_align1;
+
 /*****************************************************************************/
 /*
  * Reserve a range of host commands for board-specific, experimental, or
-- 
2.25.1

