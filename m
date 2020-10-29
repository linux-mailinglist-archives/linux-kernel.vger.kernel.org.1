Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D33B929F7F5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 23:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbgJ2W2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 18:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbgJ2W2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 18:28:38 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC0FC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 15:28:38 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id r10so3510844pgb.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 15:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sczkyUobqJqj2q5gvyD9THsNoWnzVNind2w+5my991w=;
        b=lIJY11xPWjbxn7xIe4bI7zttyU7PBwSgQj1qzK/9NoG+BeflzbZpoQngIFtwRHQoiX
         L45LWImXU8geZ6qrD1i45+EdKiyJgGEfGty4YUhrmfuEAPZSMYekhQlmW8N6/wDMcXcY
         QkOuID513vS25ZZn47Es44dfwTdOsqPnOahlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sczkyUobqJqj2q5gvyD9THsNoWnzVNind2w+5my991w=;
        b=Ba0AOyW3szEfZ/V3qhjTVm3fFwakbbMbNkwuJxznrZW8LgzF0vla5S3KKdA17t+ceb
         RJSpoWsNDeHN95cN8ZoXQ1VI4uv5VmNeSvDSWs5tDHPnWKCbnndt2gXrGN1afuCWgNSK
         4YsCR/cIL4ZITEci+f/TlP6y2phz/VXaWgRlyWnZmDqoDWoC98FS8xCLHFR0TgHdLU+/
         KCh7El4ujtQR8Yh3W/mq9wP4sdKTCQTDxT+omFyq1X6wMHlgQSEjLYdGcdqEc+klPWrn
         1JCce1/DfbvKL2p7fdolWcdEOtdsDr23qSqbgQKRXRhsYHAEVxG+h8AFeurfSGFKJT5S
         noBg==
X-Gm-Message-State: AOAM530MtcNhuBAlxTqfZe9cTUPPEdrE6vLDal16Vpet1r/ZKFINJfo3
        j+vCgi+1X4yT3OCL0MOu8rD1iJFXeaRgkQ==
X-Google-Smtp-Source: ABdhPJymEz1f8EcJykIEK62JtiAP3m7j1wr0GgCznzT23+AhNDelEfofFrTTDHH/2Hjpo5RCUI6Hiw==
X-Received: by 2002:a17:90a:4684:: with SMTP id z4mr1965852pjf.97.1604010517606;
        Thu, 29 Oct 2020 15:28:37 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id f5sm3573886pgi.86.2020.10.29.15.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 15:28:37 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com, dzigterman@chromium.org,
        alevkoy@chromium.org, Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 4/7] platform/chrome: cros_ec: Import Type C host commands
Date:   Thu, 29 Oct 2020 15:27:36 -0700
Message-Id: <20201029222738.482366-5-pmalani@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201029222738.482366-1-pmalani@chromium.org>
References: <20201029222738.482366-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Import the EC_CMD_TYPEC_STATUS and EC_CMD_TYPEC_DISCOVERY Chrome OS EC
host commands from the EC code base [1].

These commands can be used by the application processor to query Power
Delivery (PD) discovery information concerning connected Type C
peripherals.

Also add the EC_FEATURE_TYPEC_CMD feature flag, which is used to
determine whether these commands are supported by the EC.

[1]:
https://chromium.googlesource.com/chromiumos/platform/ec/+/refs/heads/master/include/ec_commands.h

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

Changes in v2:
- No changes.

 .../linux/platform_data/cros_ec_commands.h    | 155 ++++++++++++++++++
 1 file changed, 155 insertions(+)

diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
index 1fcfe9e63cb9..7f54fdcdd8cb 100644
--- a/include/linux/platform_data/cros_ec_commands.h
+++ b/include/linux/platform_data/cros_ec_commands.h
@@ -1284,6 +1284,8 @@ enum ec_feature_code {
 	EC_FEATURE_SCP = 39,
 	/* The MCU is an Integrated Sensor Hub */
 	EC_FEATURE_ISH = 40,
+	/* New TCPMv2 TYPEC_ prefaced commands supported */
+	EC_FEATURE_TYPEC_CMD = 41,
 };
 
 #define EC_FEATURE_MASK_0(event_code) BIT(event_code % 32)
@@ -5528,6 +5530,159 @@ struct ec_response_regulator_get_voltage {
 	uint32_t voltage_mv;
 } __ec_align4;
 
+/*
+ * Gather all discovery information for the given port and partner type.
+ *
+ * Note that if discovery has not yet completed, only the currently completed
+ * responses will be filled in.   If the discovery data structures are changed
+ * in the process of the command running, BUSY will be returned.
+ *
+ * VDO field sizes are set to the maximum possible number of VDOs a VDM may
+ * contain, while the number of SVIDs here is selected to fit within the PROTO2
+ * maximum parameter size.
+ */
+#define EC_CMD_TYPEC_DISCOVERY 0x0131
+
+enum typec_partner_type {
+	TYPEC_PARTNER_SOP = 0,
+	TYPEC_PARTNER_SOP_PRIME = 1,
+};
+
+struct ec_params_typec_discovery {
+	uint8_t port;
+	uint8_t partner_type; /* enum typec_partner_type */
+} __ec_align1;
+
+struct svid_mode_info {
+	uint16_t svid;
+	uint16_t mode_count;  /* Number of modes partner sent */
+	uint32_t mode_vdo[6]; /* Max VDOs allowed after VDM header is 6 */
+};
+
+struct ec_response_typec_discovery {
+	uint8_t identity_count;    /* Number of identity VDOs partner sent */
+	uint8_t svid_count;	   /* Number of SVIDs partner sent */
+	uint16_t reserved;
+	uint32_t discovery_vdo[6]; /* Max VDOs allowed after VDM header is 6 */
+	struct svid_mode_info svids[0];
+} __ec_align1;
+
+/*
+ * Gather all status information for a port.
+ *
+ * Note: this covers many of the return fields from the deprecated
+ * EC_CMD_USB_PD_CONTROL command, except those that are redundant with the
+ * discovery data.  The "enum pd_cc_states" is defined with the deprecated
+ * EC_CMD_USB_PD_CONTROL command.
+ *
+ * This also combines in the EC_CMD_USB_PD_MUX_INFO flags.
+ */
+#define EC_CMD_TYPEC_STATUS 0x0133
+
+/*
+ * Power role.
+ *
+ * Note this is also used for PD header creation, and values align to those in
+ * the Power Delivery Specification Revision 3.0 (See
+ * 6.2.1.1.4 Port Power Role).
+ */
+enum pd_power_role {
+	PD_ROLE_SINK = 0,
+	PD_ROLE_SOURCE = 1
+};
+
+/*
+ * Data role.
+ *
+ * Note this is also used for PD header creation, and the first two values
+ * align to those in the Power Delivery Specification Revision 3.0 (See
+ * 6.2.1.1.6 Port Data Role).
+ */
+enum pd_data_role {
+	PD_ROLE_UFP = 0,
+	PD_ROLE_DFP = 1,
+	PD_ROLE_DISCONNECTED = 2,
+};
+
+enum pd_vconn_role {
+	PD_ROLE_VCONN_OFF = 0,
+	PD_ROLE_VCONN_SRC = 1,
+};
+
+/*
+ * Note: BIT(0) may be used to determine whether the polarity is CC1 or CC2,
+ * regardless of whether a debug accessory is connected.
+ */
+enum tcpc_cc_polarity {
+	/*
+	 * _CCx: is used to indicate the polarity while not connected to
+	 * a Debug Accessory.  Only one CC line will assert a resistor and
+	 * the other will be open.
+	 */
+	POLARITY_CC1 = 0,
+	POLARITY_CC2 = 1,
+
+	/*
+	 * _CCx_DTS is used to indicate the polarity while connected to a
+	 * SRC Debug Accessory.  Assert resistors on both lines.
+	 */
+	POLARITY_CC1_DTS = 2,
+	POLARITY_CC2_DTS = 3,
+
+	/*
+	 * The current TCPC code relies on these specific POLARITY values.
+	 * Adding in a check to verify if the list grows for any reason
+	 * that this will give a hint that other places need to be
+	 * adjusted.
+	 */
+	POLARITY_COUNT
+};
+
+#define PD_STATUS_EVENT_SOP_DISC_DONE		BIT(0)
+#define PD_STATUS_EVENT_SOP_PRIME_DISC_DONE	BIT(1)
+
+struct ec_params_typec_status {
+	uint8_t port;
+} __ec_align1;
+
+struct ec_response_typec_status {
+	uint8_t pd_enabled;		/* PD communication enabled - bool */
+	uint8_t dev_connected;		/* Device connected - bool */
+	uint8_t sop_connected;		/* Device is SOP PD capable - bool */
+	uint8_t source_cap_count;	/* Number of Source Cap PDOs */
+
+	uint8_t power_role;		/* enum pd_power_role */
+	uint8_t data_role;		/* enum pd_data_role */
+	uint8_t vconn_role;		/* enum pd_vconn_role */
+	uint8_t sink_cap_count;		/* Number of Sink Cap PDOs */
+
+	uint8_t polarity;		/* enum tcpc_cc_polarity */
+	uint8_t cc_state;		/* enum pd_cc_states */
+	uint8_t dp_pin;			/* DP pin mode (MODE_DP_IN_[A-E]) */
+	uint8_t mux_state;		/* USB_PD_MUX* - encoded mux state */
+
+	char tc_state[32];		/* TC state name */
+
+	uint32_t events;		/* PD_STATUS_EVENT bitmask */
+
+	/*
+	 * BCD PD revisions for partners
+	 *
+	 * The format has the PD major reversion in the upper nibble, and PD
+	 * minor version in the next nibble.  Following two nibbles are
+	 * currently 0.
+	 * ex. PD 3.2 would map to 0x3200
+	 *
+	 * PD major/minor will be 0 if no PD device is connected.
+	 */
+	uint16_t sop_revision;
+	uint16_t sop_prime_revision;
+
+	uint32_t source_cap_pdos[7];	/* Max 7 PDOs can be present */
+
+	uint32_t sink_cap_pdos[7];	/* Max 7 PDOs can be present */
+} __ec_align1;
+
 /*****************************************************************************/
 /* The command range 0x200-0x2FF is reserved for Rotor. */
 
-- 
2.29.1.341.ge80a0c044ae-goog

