Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41D33286E9A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 08:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbgJHGRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 02:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728830AbgJHGQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 02:16:38 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A56FC0613E1
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 23:16:30 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id s14so4381660ybl.10
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 23:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=GjCc+BQkNqKSsKaA/WplKUyBVW0UGrqMAZUqUladaLM=;
        b=mNMAOTdUE549pA1vBLa0xlJl2DtepK4ZRhiLM0QF82FkDuuyDMHjtOyDdYrY9DNHtK
         oaEVZ53iAMGaUt8Pgp0PRKucNYmejbhR2AAMK50NC+W9D9ogB7hvNj1UmBZAMeAhgiPB
         1asuQEZiPBJyrkkD4eg9V0K4jGraGxlidw0RFZA8eXdnYIIL2lSm7ZD0MyVJaPLyGarq
         9/je4jc1vJ5ZkMyoup0Ph6Oj+DVsG2IngP4zXGN7+NDAglskG6FiwO8neTxTsdKZO7GO
         EmQwBwcEY1cMH4unzzc36st1ax5FRhaWXNWdkBjKq8TUj17RUll/H3LYtPLqbKgZSmnp
         d4tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GjCc+BQkNqKSsKaA/WplKUyBVW0UGrqMAZUqUladaLM=;
        b=qVPISaq+3o1Kyx3sHEbmrAlPEG9cG+I19R7nTQ4TLaDNkPGUO33ylrUpARl/DxPu1r
         zQ+ugUFFa3cJ6qxYQHQAdFu+mlsHRUfgLMFkTX1SwUZyoy1Xo+JlpggfMpvWMB7/nagb
         7WEeAjN+DdXWaZicCC+SSOtV9bVMurjK6G+/zVmlemKqK0yB7Fx6jVqA6pqw4MNFH1do
         AZE4rEDK9Bv93up98Ms+Tz9j5pS9ed36BlR3b51bznFWLX6AtxrEwIPxfQjfUfBkxevw
         vxNbC5OLv6bE8byOT52NCUmmOsa85lZ0P2lrbGrjbsJPM9vPLbVfxRzLIREmHoEJSqz0
         cUZg==
X-Gm-Message-State: AOAM531KTQrF+tFcn4A53McHZnlvdke9FXI6tbYuCjulRs+7036KEAvm
        NlxuXvs6qjoVG+4ygC84m0FWxe9mew8=
X-Google-Smtp-Source: ABdhPJzw4x4l4Msd/pS1Y6RiCAeIrWU4Iz05D1UDL3YFVodLdqhIcGiLm6uyT/nuVvEkqP5oiunssN376wQ=
Sender: "badhri via sendgmr" <badhri@badhri.mtv.corp.google.com>
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:1:f292:1cff:fee0:66cf])
 (user=badhri job=sendgmr) by 2002:a25:a290:: with SMTP id c16mr9189840ybi.84.1602137789208;
 Wed, 07 Oct 2020 23:16:29 -0700 (PDT)
Date:   Wed,  7 Oct 2020 23:15:54 -0700
In-Reply-To: <20201008061556.1402293-1-badhri@google.com>
Message-Id: <20201008061556.1402293-14-badhri@google.com>
Mime-Version: 1.0
References: <20201008061556.1402293-1-badhri@google.com>
X-Mailer: git-send-email 2.28.0.806.g8561365e88-goog
Subject: [PATCH v10 13/15] usb: typec: tcpm: Implement enabling Auto Discharge
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
        Badhri Jagan Sridharan <badhri@google.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Amelie Delaunay <amelie.delaunay@st.com>
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

Changes since v7:
- Rebase on usb-next

Changes since v8:
- Removing the call to tcpm_set_auto_vbus_discharge_threshold
  in the source path.

- Changes since v9:
- None
---
 drivers/usb/typec/tcpm/tcpm.c | 60 ++++++++++++++++++++++++++++++++---
 include/linux/usb/tcpm.h      | 15 +++++++++
 2 files changed, 71 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index d5a3e2b3bea2..51a14d282109 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -1701,6 +1701,24 @@ static void tcpm_handle_alert(struct tcpm_port *port, const __le32 *payload,
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
@@ -1871,6 +1889,10 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
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
@@ -2785,8 +2807,12 @@ static int tcpm_src_attach(struct tcpm_port *port)
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
 
@@ -2853,6 +2879,12 @@ static void tcpm_unregister_altmodes(struct tcpm_port *port)
 
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
@@ -2917,8 +2949,13 @@ static int tcpm_snk_attach(struct tcpm_port *port)
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
 
@@ -3502,6 +3539,8 @@ static void run_state_machine(struct tcpm_port *port)
 		tcpm_set_state(port, SRC_UNATTACHED, PD_T_PS_SOURCE_ON);
 		break;
 	case SNK_HARD_RESET_SINK_OFF:
+		/* Do not discharge/disconnect during hard reseet */
+		tcpm_set_auto_vbus_discharge_threshold(port, TYPEC_PWR_MODE_USB, false, 0);
 		memset(&port->pps_data, 0, sizeof(port->pps_data));
 		tcpm_set_vconn(port, false);
 		if (port->pd_capable)
@@ -3544,6 +3583,7 @@ static void run_state_machine(struct tcpm_port *port)
 			tcpm_set_charge(port, true);
 		}
 		tcpm_set_attached_state(port, true);
+		tcpm_set_auto_vbus_discharge_threshold(port, TYPEC_PWR_MODE_USB, false, VSAFE5V);
 		tcpm_set_state(port, SNK_STARTUP, 0);
 		break;
 
@@ -3645,6 +3685,10 @@ static void run_state_machine(struct tcpm_port *port)
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
@@ -3673,9 +3717,17 @@ static void run_state_machine(struct tcpm_port *port)
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
2.28.0.806.g8561365e88-goog

