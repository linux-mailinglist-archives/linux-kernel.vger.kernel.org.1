Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAD5D26D8CF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 12:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgIQKWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 06:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbgIQKTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 06:19:54 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7D4C06121E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 03:19:19 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id s141so1175463qka.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 03:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=LKmnPd4paP49UQIRtUnQ5RMmAmspwZ/8zkHoWQrBuBo=;
        b=ZGgWYzzT0mYeWriX5DlRghQq+9AE3iEbHg4Z9RBP0/Kbqu29XwBiKcLGtCa7gpYcYS
         kqRFnEcdNdxVW5OC84lSjWBnmHtdUZJ17YZDjzaRHN+BhB65MOWWW3dmhgVLwDW0x0Uw
         97ean9AZ6MvgsNUQLcK7oqGu6Ybb4VNzzLa0u2yG/9v/MyCLgF5b726HVIA5JqeoWJmL
         4MZZlfSCbvHGc63gb/OajhSHy0iXN18/zV5TcZwYdl1wPMlhg4hJZScOxtF4S7QqJH6/
         MN9ZxIAGqPAay/p6eRWtdR59ECgG/MR5WVeTkGTHsqeSjbZI4d1uR2MOP/j+r5FdkceJ
         e1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LKmnPd4paP49UQIRtUnQ5RMmAmspwZ/8zkHoWQrBuBo=;
        b=LvYGsa3x9pnDs+diUO75RfvAJq6DxKffLyaRHqXxrHs8HqXjEC82/gVvMUIpiKPi/W
         FISiGVk1izncCmfgdtfUv8gzHhKMEdwztqp4jUf/0nen0pQqfTQdjpjmolu4qki9Sy7I
         vhuYOX6foQuJvh2pnrP4M6VfMjdxANOFJJZ+TZEF632++22pAnK71lX1nvsitQr8drCe
         ebtDLvCAzVm+SuJwDQ4SSTCQePW+/DSO/n9w2mv0nYe2CfeL58sc8FxOmGCe0v4nGbfn
         u66OgpdGxy/4iKDr9ReTcZmpWx4ABjarjRjlDM7fdOe9JlZtT9X8TXB0vz6WvLB56TQJ
         g+Bg==
X-Gm-Message-State: AOAM530kgC+vTxmBtuLxyMmhs5Y3nYigJFSs7qaUksETEwG4Xo28EhSH
        PBVqhqewppnUeXS76wVxqgxA3m+1Ueo=
X-Google-Smtp-Source: ABdhPJxI2OdWVCZjihQ30hiXT6yn0RcWRmcYWlrn/AXLB5CSNJGJ8iqntLJlEKPU1JPqQgLneupD1d3G3Fc=
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:1:f292:1cff:fee0:66cf])
 (user=badhri job=sendgmr) by 2002:a0c:ac02:: with SMTP id l2mr6505761qvb.25.1600337958481;
 Thu, 17 Sep 2020 03:19:18 -0700 (PDT)
Date:   Thu, 17 Sep 2020 03:18:54 -0700
In-Reply-To: <20200917101856.3156869-1-badhri@google.com>
Message-Id: <20200917101856.3156869-9-badhri@google.com>
Mime-Version: 1.0
References: <20200917101856.3156869-1-badhri@google.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [PATCH v7 09/11] usb: typec: tcpm: Implement enabling Auto Discharge
 disconnect support
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Badhri Jagan Sridharan <badhri@google.com>
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
---
Changes since v1:
- Changing patch version to v6 to fix version number confusion.

Changes since v6:
- Fixed incorrect data_role error that I introduced by mistake in
  the previous version. 
---
 drivers/usb/typec/tcpm/tcpm.c | 74 +++++++++++++++++++++++++++++++++--
 include/linux/usb/tcpm.h      | 16 ++++++++
 2 files changed, 86 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 55535c4f66bf..d6b2a757a564 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -1706,6 +1706,25 @@ static void tcpm_handle_alert(struct tcpm_port *port, const __le32 *payload,
 	}
 }
 
+static int tcpm_set_auto_vbus_discharge_threshold(struct tcpm_port *port, enum typec_role port_role,
+						  enum typec_pwr_opmode mode, bool pps_active,
+						  u32 requested_vbus_voltage)
+{
+	int ret;
+
+	if (!port->tcpc->set_auto_vbus_discharge_threshold)
+		return 0;
+
+	ret = port->tcpc->set_auto_vbus_discharge_threshold(port->tcpc, port_role, mode, pps_active,
+							    requested_vbus_voltage);
+	tcpm_log_force(port,
+		       "set_auto_vbus_discharge_threshold pwr_role:%s mode:%d pps_active:%c vbus:%u ret:%d",
+		       port_role == TYPEC_SINK ? "sink" : "source", mode, pps_active ? 'y' : 'n',
+		       requested_vbus_voltage, ret);
+
+	return ret;
+}
+
 static void tcpm_pd_data_request(struct tcpm_port *port,
 				 const struct pd_message *msg)
 {
@@ -1875,6 +1894,10 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
 						       port->current_limit,
 						       port->supply_voltage);
 				port->explicit_contract = true;
+				tcpm_set_auto_vbus_discharge_threshold(port, TYPEC_SINK,
+								       TYPEC_PWR_MODE_PD,
+								       port->pps_data.active,
+								       port->supply_voltage);
 				tcpm_set_state(port, SNK_READY, 0);
 			} else {
 				/*
@@ -2789,8 +2812,14 @@ static int tcpm_src_attach(struct tcpm_port *port)
 	if (ret < 0)
 		return ret;
 
-	ret = tcpm_set_roles(port, true, TYPEC_SOURCE,
-			     tcpm_data_role_for_source(port));
+	if (port->tcpc->enable_auto_vbus_discharge) {
+		tcpm_set_auto_vbus_discharge_threshold(port, TYPEC_SOURCE, TYPEC_PWR_MODE_USB,
+						       false, VSAFE5V);
+		ret = port->tcpc->enable_auto_vbus_discharge(port->tcpc, true);
+		tcpm_log_force(port, "enable vbus discharge ret:%d", ret);
+	}
+
+	ret = tcpm_set_roles(port, true, TYPEC_SOURCE, tcpm_data_role_for_source(port));
 	if (ret < 0)
 		return ret;
 
@@ -2857,6 +2886,12 @@ static void tcpm_unregister_altmodes(struct tcpm_port *port)
 
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
@@ -2921,8 +2956,14 @@ static int tcpm_snk_attach(struct tcpm_port *port)
 	if (ret < 0)
 		return ret;
 
-	ret = tcpm_set_roles(port, true, TYPEC_SINK,
-			     tcpm_data_role_for_sink(port));
+	if (port->tcpc->enable_auto_vbus_discharge) {
+		tcpm_set_auto_vbus_discharge_threshold(port, TYPEC_SINK, TYPEC_PWR_MODE_USB, false,
+						       VSAFE5V);
+		ret = port->tcpc->enable_auto_vbus_discharge(port->tcpc, true);
+		tcpm_log_force(port, "enable vbus discharge ret:%d", ret);
+	}
+
+	ret = tcpm_set_roles(port, true, TYPEC_SINK, tcpm_data_role_for_sink(port));
 	if (ret < 0)
 		return ret;
 
@@ -3482,6 +3523,8 @@ static void run_state_machine(struct tcpm_port *port)
 		 * drive VBUS to vSafe0V as shown in Figure 7-9.
 		 */
 		tcpm_set_vconn(port, false);
+		tcpm_set_auto_vbus_discharge_threshold(port, TYPEC_SOURCE, TYPEC_PWR_MODE_USB,
+						       false, 0);
 		tcpm_set_vbus(port, false);
 		tcpm_set_roles(port, port->self_powered, TYPEC_SOURCE,
 			       tcpm_data_role_for_source(port));
@@ -3503,9 +3546,13 @@ static void run_state_machine(struct tcpm_port *port)
 		tcpm_set_vbus(port, true);
 		port->tcpc->set_pd_rx(port->tcpc, true);
 		tcpm_set_attached_state(port, true);
+		tcpm_set_auto_vbus_discharge_threshold(port, TYPEC_SOURCE, TYPEC_PWR_MODE_USB,
+						       false, VSAFE5V);
 		tcpm_set_state(port, SRC_UNATTACHED, PD_T_PS_SOURCE_ON);
 		break;
 	case SNK_HARD_RESET_SINK_OFF:
+		tcpm_set_auto_vbus_discharge_threshold(port, TYPEC_SINK, TYPEC_PWR_MODE_USB, false,
+						       0);
 		memset(&port->pps_data, 0, sizeof(port->pps_data));
 		tcpm_set_vconn(port, false);
 		if (port->pd_capable)
@@ -3548,6 +3595,8 @@ static void run_state_machine(struct tcpm_port *port)
 			tcpm_set_charge(port, true);
 		}
 		tcpm_set_attached_state(port, true);
+		tcpm_set_auto_vbus_discharge_threshold(port, TYPEC_SINK, TYPEC_PWR_MODE_USB, false,
+						       VSAFE5V);
 		tcpm_set_state(port, SNK_STARTUP, 0);
 		break;
 
@@ -3649,6 +3698,12 @@ static void run_state_machine(struct tcpm_port *port)
 			tcpm_set_state(port, PR_SWAP_SNK_SRC_SINK_OFF, 0);
 		break;
 	case PR_SWAP_SRC_SNK_TRANSITION_OFF:
+		/*
+		 * Prevent vbus discharge circuit from turning on during PR_SWAP
+		 * as this is not a disconnect.
+		 */
+		tcpm_set_auto_vbus_discharge_threshold(port, TYPEC_SOURCE, TYPEC_PWR_MODE_USB,
+						       port->pps_data.active, 0);
 		tcpm_set_vbus(port, false);
 		port->explicit_contract = false;
 		/* allow time for Vbus discharge, must be < tSrcSwapStdby */
@@ -3677,9 +3732,18 @@ static void run_state_machine(struct tcpm_port *port)
 		tcpm_set_state_cond(port, SNK_UNATTACHED, PD_T_PS_SOURCE_ON);
 		break;
 	case PR_SWAP_SRC_SNK_SINK_ON:
+		/* Set the vbus disconnect threshold for implicit contract */
+		tcpm_set_auto_vbus_discharge_threshold(port, TYPEC_SINK, TYPEC_PWR_MODE_USB, false,
+						       VSAFE5V);
 		tcpm_set_state(port, SNK_STARTUP, 0);
 		break;
 	case PR_SWAP_SNK_SRC_SINK_OFF:
+		/*
+		 * Prevent vbus discharge circuit from turning on during PR_SWAP
+		 * as this is not a disconnect.
+		 */
+		tcpm_set_auto_vbus_discharge_threshold(port, TYPEC_SINK, TYPEC_PWR_MODE_USB,
+						       port->pps_data.active, 0);
 		tcpm_set_charge(port, false);
 		tcpm_set_state(port, hard_reset_state(port),
 			       PD_T_PS_SOURCE_OFF);
@@ -3705,6 +3769,8 @@ static void run_state_machine(struct tcpm_port *port)
 		 */
 		tcpm_set_pwr_role(port, TYPEC_SOURCE);
 		tcpm_pd_send_control(port, PD_CTRL_PS_RDY);
+		tcpm_set_auto_vbus_discharge_threshold(port, TYPEC_SOURCE, TYPEC_PWR_MODE_USB,
+						       false, VSAFE5V);
 		tcpm_set_state(port, SRC_STARTUP, PD_T_SWAP_SRC_START);
 		break;
 
diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
index 09762d26fa0c..a1707def51c3 100644
--- a/include/linux/usb/tcpm.h
+++ b/include/linux/usb/tcpm.h
@@ -83,6 +83,18 @@ enum tcpm_transmit_type {
  *		Optional; Called to enable/disable PD 3.0 fast role swap.
  *		Enabling frs is accessory dependent as not all PD3.0
  *		accessories support fast role swap.
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
@@ -109,6 +121,10 @@ struct tcpc_dev {
 			   const struct pd_message *msg);
 	int (*set_bist_data)(struct tcpc_dev *dev, bool on);
 	int (*enable_frs)(struct tcpc_dev *dev, bool enable);
+	int (*enable_auto_vbus_discharge)(struct tcpc_dev *dev, bool enable);
+	int (*set_auto_vbus_discharge_threshold)(struct tcpc_dev *dev, enum typec_role port_role,
+						 enum typec_pwr_opmode mode, bool pps_active,
+						 u32 requested_vbus_voltage);
 };
 
 struct tcpm_port;
-- 
2.28.0.618.gf4bc123cb7-goog

