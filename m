Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C28529E588
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 08:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732667AbgJ2H5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbgJ2HYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:24:39 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9887DC05BD2C
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 23:31:59 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id w8so1677399ybj.14
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 23:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=HAJ3ZLGbY/a4OwiWQCJFfmbBm3x19ffpqAJu5Kgbp2U=;
        b=KLCQB2UGQT+iFWZ0eJvxR3n5ynaYMkV1R6Ev6nM90xW7cipgp6gkebc+YFl15HQDLl
         IaJ7p+7gOMWz6Yu20PnDi8dG2QQiPEUGvmel5vkzE76osThpxT7a82Ykw/2H5fpJQLHb
         fLxgPor+E9Xk3n2Ac8qGMp2PXNTC/N44JVKQbQr7Njozzw7XYUquG0nuzHXx0ATh+V5+
         OwdpzSXaOrtjCbE2jrtu91rkeWRYqyFSeti/uq6CkivaOpO98F0kFVn1tFf4ek9I1+mn
         5kOaAbtA0oGVsfrlLRs0HtWVienDeBWrB22Jmp628SV87/xmWK4y7Og+aUAfVAh6+QpJ
         kyhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HAJ3ZLGbY/a4OwiWQCJFfmbBm3x19ffpqAJu5Kgbp2U=;
        b=NvhF6mF+eklOW4O0Q+yxCxUL2+vVXz9k1FkM3OEsW1vKmvqdQY8AkuU6CqwojECZdL
         ZAKx6yD297ahWitTYQ8muWZ5WCWM8W0pWpRDZv8D8Vsfs6mihYmGFa4ZXyYjmx9B9bxS
         KewujpjzAr8gO/c45mAp1PCEsKlShnVuAGI4s63t/cAABEGRRp4oDqlawm99DY1hRnHZ
         2RNCc3EM2k9h0C1L8HKxVA5qt+g6S0IEp431r7Lqf4fkqEtrIi/kZ7RmA1tCdNndx+u5
         +4upGXTSBS34wHkDDSYXiLdCUaQgOefbPagW2Yq4N+tehEO6Vcy8r1lMgE2fUTh+kcxb
         z7mQ==
X-Gm-Message-State: AOAM532XEubz5ssRWZHGenZerv+WrMAjRKoFFL3x1p3+YJ1zDt1YL8Rb
        Twd79waMhHa/LxJJAQZUISjS64rb38U=
X-Google-Smtp-Source: ABdhPJwXoQCjDnY1RMk2JV+0K6dbcOakF++FC74iDwRbW2d+crkSdnmEtmxUJiXSNBZT31IXZ5svEeNgoc8=
Sender: "badhri via sendgmr" <badhri@badhri.mtv.corp.google.com>
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:201:f292:1cff:fee0:66cf])
 (user=badhri job=sendgmr) by 2002:a25:daca:: with SMTP id n193mr3642329ybf.326.1603953118841;
 Wed, 28 Oct 2020 23:31:58 -0700 (PDT)
Date:   Wed, 28 Oct 2020 23:31:35 -0700
In-Reply-To: <20201029063138.1429760-1-badhri@google.com>
Message-Id: <20201029063138.1429760-8-badhri@google.com>
Mime-Version: 1.0
References: <20201029063138.1429760-1-badhri@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v12 07/10] usb: typec: tcpm: Implement enabling Auto Discharge
 disconnect support
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thierry Reding <treding@nvidia.com>,
        Prashant Malani <pmalani@chromium.org>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TCPCI spec allows TCPC hardware to autonomously discharge the vbus
capacitance upon disconnect. The expectation is that the TCPM enables
AutoDischargeDisconnect while entering SNK/SRC_ATTACHED states. Hardware
then automously discharges vbus when the vbus falls below a certain
threshold i.e. VBUS_SINK_DISCONNECT_THRESHOLD.

Apart from enabling the vbus discharge circuit, AutoDischargeDisconnect
is also used a flag to move TCPCI based TCPC implementations into
Attached.Snk/Attached.Src state as mentioned in
Figure 4-15. TCPC State Diagram before a Connection of the
USB Type-C Port Controller Interface Specification.
In such TCPC implementations, setting AutoDischargeDisconnect would
prevent TCPC into entering "Connection_Invalid" state as well.

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
Changes since v1:
- Changing patch version to v6 to fix version number confusion.

Changes since v6:
- Fixed incorrect data_role error that I introduced by mistake in
  the previous version.

Changes since v7:
- Rebase on usb-next

Changes since v8:
- Removing the call to tcpm_set_auto_vbus_discharge_threshold
  in the source path.

Changes since v9:
- None

Changes since v10:
Added Reviewed-by: Heikki Krogerus

Changes since v11:
none
---
 drivers/usb/typec/tcpm/tcpm.c | 60 ++++++++++++++++++++++++++++++++---
 include/linux/usb/tcpm.h      | 15 +++++++++
 2 files changed, 71 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 0123d2f14c96..1539faf06d38 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -1706,6 +1706,24 @@ static void tcpm_handle_alert(struct tcpm_port *port, const __le32 *payload,
 	}
 }
 
+static int tcpm_set_auto_vbus_discharge_threshold(struct tcpm_port *port,
+						  enum typec_pwr_opmode mode, bool pps_active,
+						  u32 requested_vbus_voltage)
+{
+	int ret;
+
+	if (!port->tcpc->set_auto_vbus_discharge_threshold)
+		return 0;
+
+	ret = port->tcpc->set_auto_vbus_discharge_threshold(port->tcpc, mode, pps_active,
+							    requested_vbus_voltage);
+	tcpm_log_force(port,
+		       "set_auto_vbus_discharge_threshold mode:%d pps_active:%c vbus:%u ret:%d",
+		       mode, pps_active ? 'y' : 'n', requested_vbus_voltage, ret);
+
+	return ret;
+}
+
 static void tcpm_pd_data_request(struct tcpm_port *port,
 				 const struct pd_message *msg)
 {
@@ -1876,6 +1894,10 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
 						       port->current_limit,
 						       port->supply_voltage);
 				port->explicit_contract = true;
+				tcpm_set_auto_vbus_discharge_threshold(port,
+								       TYPEC_PWR_MODE_PD,
+								       port->pps_data.active,
+								       port->supply_voltage);
 				tcpm_set_state(port, SNK_READY, 0);
 			} else {
 				/*
@@ -2790,8 +2812,12 @@ static int tcpm_src_attach(struct tcpm_port *port)
 	if (ret < 0)
 		return ret;
 
-	ret = tcpm_set_roles(port, true, TYPEC_SOURCE,
-			     tcpm_data_role_for_source(port));
+	if (port->tcpc->enable_auto_vbus_discharge) {
+		ret = port->tcpc->enable_auto_vbus_discharge(port->tcpc, true);
+		tcpm_log_force(port, "enable vbus discharge ret:%d", ret);
+	}
+
+	ret = tcpm_set_roles(port, true, TYPEC_SOURCE, tcpm_data_role_for_source(port));
 	if (ret < 0)
 		return ret;
 
@@ -2858,6 +2884,12 @@ static void tcpm_unregister_altmodes(struct tcpm_port *port)
 
 static void tcpm_reset_port(struct tcpm_port *port)
 {
+	int ret;
+
+	if (port->tcpc->enable_auto_vbus_discharge) {
+		ret = port->tcpc->enable_auto_vbus_discharge(port->tcpc, false);
+		tcpm_log_force(port, "Disable vbus discharge ret:%d", ret);
+	}
 	tcpm_unregister_altmodes(port);
 	tcpm_typec_disconnect(port);
 	port->attached = false;
@@ -2922,8 +2954,13 @@ static int tcpm_snk_attach(struct tcpm_port *port)
 	if (ret < 0)
 		return ret;
 
-	ret = tcpm_set_roles(port, true, TYPEC_SINK,
-			     tcpm_data_role_for_sink(port));
+	if (port->tcpc->enable_auto_vbus_discharge) {
+		tcpm_set_auto_vbus_discharge_threshold(port, TYPEC_PWR_MODE_USB, false, VSAFE5V);
+		ret = port->tcpc->enable_auto_vbus_discharge(port->tcpc, true);
+		tcpm_log_force(port, "enable vbus discharge ret:%d", ret);
+	}
+
+	ret = tcpm_set_roles(port, true, TYPEC_SINK, tcpm_data_role_for_sink(port));
 	if (ret < 0)
 		return ret;
 
@@ -3507,6 +3544,8 @@ static void run_state_machine(struct tcpm_port *port)
 		tcpm_set_state(port, SRC_UNATTACHED, PD_T_PS_SOURCE_ON);
 		break;
 	case SNK_HARD_RESET_SINK_OFF:
+		/* Do not discharge/disconnect during hard reseet */
+		tcpm_set_auto_vbus_discharge_threshold(port, TYPEC_PWR_MODE_USB, false, 0);
 		memset(&port->pps_data, 0, sizeof(port->pps_data));
 		tcpm_set_vconn(port, false);
 		if (port->pd_capable)
@@ -3549,6 +3588,7 @@ static void run_state_machine(struct tcpm_port *port)
 			tcpm_set_charge(port, true);
 		}
 		tcpm_set_attached_state(port, true);
+		tcpm_set_auto_vbus_discharge_threshold(port, TYPEC_PWR_MODE_USB, false, VSAFE5V);
 		tcpm_set_state(port, SNK_STARTUP, 0);
 		break;
 
@@ -3650,6 +3690,10 @@ static void run_state_machine(struct tcpm_port *port)
 			tcpm_set_state(port, PR_SWAP_SNK_SRC_SINK_OFF, 0);
 		break;
 	case PR_SWAP_SRC_SNK_TRANSITION_OFF:
+		/*
+		 * Prevent vbus discharge circuit from turning on during PR_SWAP
+		 * as this is not a disconnect.
+		 */
 		tcpm_set_vbus(port, false);
 		port->explicit_contract = false;
 		/* allow time for Vbus discharge, must be < tSrcSwapStdby */
@@ -3678,9 +3722,17 @@ static void run_state_machine(struct tcpm_port *port)
 		tcpm_set_state_cond(port, SNK_UNATTACHED, PD_T_PS_SOURCE_ON);
 		break;
 	case PR_SWAP_SRC_SNK_SINK_ON:
+		/* Set the vbus disconnect threshold for implicit contract */
+		tcpm_set_auto_vbus_discharge_threshold(port, TYPEC_PWR_MODE_USB, false, VSAFE5V);
 		tcpm_set_state(port, SNK_STARTUP, 0);
 		break;
 	case PR_SWAP_SNK_SRC_SINK_OFF:
+		/*
+		 * Prevent vbus discharge circuit from turning on during PR_SWAP
+		 * as this is not a disconnect.
+		 */
+		tcpm_set_auto_vbus_discharge_threshold(port, TYPEC_PWR_MODE_USB,
+						       port->pps_data.active, 0);
 		tcpm_set_charge(port, false);
 		tcpm_set_state(port, hard_reset_state(port),
 			       PD_T_PS_SOURCE_OFF);
diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
index 7303f518ba49..e68aaa12886f 100644
--- a/include/linux/usb/tcpm.h
+++ b/include/linux/usb/tcpm.h
@@ -86,6 +86,18 @@ enum tcpm_transmit_type {
  * @frs_sourcing_vbus:
  *		Optional; Called to notify that vbus is now being sourced.
  *		Low level drivers can perform chip specific operations, if any.
+ * @enable_auto_vbus_discharge:
+ *		Optional; TCPCI spec based TCPC implementations can optionally
+ *		support hardware to autonomously dischrge vbus upon disconnecting
+ *		as sink or source. TCPM signals TCPC to enable the mechanism upon
+ *		entering connected state and signals disabling upon disconnect.
+ * @set_auto_vbus_discharge_threshold:
+ *		Mandatory when enable_auto_vbus_discharge is implemented. TCPM
+ *		calls this function to allow lower levels drivers to program the
+ *		vbus threshold voltage below which the vbus discharge circuit
+ *		will be turned on. requested_vbus_voltage is set to 0 when vbus
+ *		is going to disappear knowingly i.e. during PR_SWAP and
+ *		HARD_RESET etc.
  */
 struct tcpc_dev {
 	struct fwnode_handle *fwnode;
@@ -113,6 +125,9 @@ struct tcpc_dev {
 	int (*set_bist_data)(struct tcpc_dev *dev, bool on);
 	int (*enable_frs)(struct tcpc_dev *dev, bool enable);
 	void (*frs_sourcing_vbus)(struct tcpc_dev *dev);
+	int (*enable_auto_vbus_discharge)(struct tcpc_dev *dev, bool enable);
+	int (*set_auto_vbus_discharge_threshold)(struct tcpc_dev *dev, enum typec_pwr_opmode mode,
+						 bool pps_active, u32 requested_vbus_voltage);
 };
 
 struct tcpm_port;
-- 
2.29.1.341.ge80a0c044ae-goog

