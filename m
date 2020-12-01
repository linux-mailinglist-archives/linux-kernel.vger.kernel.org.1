Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8D72C94B5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 02:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389151AbgLABdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 20:33:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731118AbgLABdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 20:33:39 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D78C0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 17:32:53 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id o12so9533696qtw.14
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 17:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=EmxHim0aZSg8o5d0Bg0Km4CxFTJ/ntmkKCMnDqRTjRo=;
        b=HgF5+bq0NT/hieJejh0bXxmyKV61G+IFYs14Kxo9bDSg6EBgXIcY7BoH41aGSjv0iR
         9yJtsMJjt0S1biSIiSC/daR+6AmZIQyDPOYEEeliYEvGQOJXcI06P84LZ4q6VTNZ7dET
         WzhZsADM1LOZpZfrkl4Ik+ouAT99VRKkk8No+DzXWpEXFeFjzG9FcefAr3R98R5nZvOG
         sgP3AZ5xG3+XCIjb8Vay4OY2OkbYPjFFEfMMZD3N74h45PMjMe3fIOkVgvvvLfKM1UC2
         SB+JPXZ9lIYsuBTpjIeSsFpXuircMcpBkDJdQmpu+kSv3vpuM8S8Tz7NRLvO+4JUT5bv
         qf2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc:content-transfer-encoding;
        bh=EmxHim0aZSg8o5d0Bg0Km4CxFTJ/ntmkKCMnDqRTjRo=;
        b=pYA/PcKXkW6ZFfVhEhGzjQCZyqgrGM5xR4SXnm2mWhF87z9EfNK38vlmOvdSfY7I9z
         jFHqFFnLL6EPiXQtafwiiv7yGH8Z0hgtDYWQ48Blpn49O6crgzQ9OE7jSGYoaYksPPv6
         PhUibv7k+QMCfDij2VwhFp73o7rnV+XpEGQ96xb/fPnUPT/nLceTGd5peAR1zYXIMbYW
         omfJNUgdeamb44atB0B8qeQtpsAAAIyWFPm29KBgnLvb9EwZ49bdwxHtmrFfMpPiQMj3
         2smqMaF4cR6ydEdZWvPlfjVk5jQxByzfI8VrfC9/RJ9PoddCSI2ha0EvL5kfTU15NDq8
         iyDw==
X-Gm-Message-State: AOAM530hEGMVsD9hIHh76iM2zSeNzgUbzVBwoW9850qsMvvl0UQ1spw2
        jNyByz8tUvSb6uoL8n6Hs2ZeE9RFOt4=
X-Google-Smtp-Source: ABdhPJzVb9f0QBwJ9ZC2i1H3K6BZZfhtDe3gWQl2DmFGhBreyas9kKIMmvA9Fr3Md83cW01IcrMry5BOyNU=
Sender: "badhri via sendgmr" <badhri@badhri.mtv.corp.google.com>
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:201:f292:1cff:fee0:66cf])
 (user=badhri job=sendgmr) by 2002:ad4:5bad:: with SMTP id 13mr707408qvq.23.1606786372038;
 Mon, 30 Nov 2020 17:32:52 -0800 (PST)
Date:   Mon, 30 Nov 2020 17:32:44 -0800
Message-Id: <20201201013246.32034-1-badhri@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v1 1/3] usb: typec: tcpm: Introduce vsafe0v for vbus
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Badhri Jagan Sridharan <badhri@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TCPM at present lacks the notion of VSAFE0V. There
are three vbus threshold levels that are critical to track:
a. vSafe5V         - VBUS =E2=80=9C5 volts=E2=80=9D as defined by the USB
                     PD specification.
b. vSinkDisconnect - Threshold used for transition from
                     Attached.SNK to Unattached.SNK.
c. vSafe0V         - VBUS =E2=80=9C0 volts=E2=80=9D as defined by the USB
                     PD specification.

Tracking vSafe0V is crucial for entry into Try.SNK and
Attached.SRC and turning vbus back on by the source in
response to hard reset.

From "4.5.2.2.8.2 Exiting from AttachWait.SRC State" section
in the Type-C spec:

"The port shall transition to Attached.SRC when VBUS is at
vSafe0V and the SRC.Rd state is detected on exactly one of
the CC1 or CC2 pins for at least tCCDebounce."

"A DRP that strongly prefers the Sink role may optionally
transition to Try.SNK instead of Attached.SRC when VBUS
is at vSafe0V and the SRC.Rd state is detected on exactly
one of the CC1 or CC2 pins for at least tCCDebounce."

From "7.1.5 Response to Hard Resets" section in the PD spec:

"After establishing the vSafe0V voltage condition on VBUS,
the Source Shall wait tSrcRecover before re-applying VCONN
and restoring VBUS to vSafe5V."

vbus_present in the TCPM code tracks vSafe5V(vbus_present is true)
and vSinkDisconnect(vbus_present is false).

This change adds is_vbus_vsafe0v callback which when set makes
TCPM query for vSafe0V voltage level when needed.

Since not all TCPC controllers might have the capability
to report vSafe0V, TCPM assumes that vSafe0V is same as
vSinkDisconnect when is_vbus_vsafe0v callback is not set.
This allows TCPM to continue to support controllers which don't
have the support for reporting vSafe0V.

Introducing vSafe0V helps fix the failure reported at
"Step 15. CVS verifies PUT remains in AttachWait.SRC for 500ms"
of "TD 4.7.2 Try. SNK DRP Connect DRP Test" of
"Universal Serial Bus Type-C (USB Type-C) Functional Test
Specification Chapters 4 and 5". Here the compliance tester
intentionally maintains vbus at greater than vSafe0V and expects
the Product under test to stay in AttachWait.SRC till vbus drops
to vSafe0V.

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 63 +++++++++++++++++++++++++++++------
 include/linux/usb/tcpm.h      |  6 ++++
 2 files changed, 58 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 3bbc1f10af49..10a065eef73e 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -258,7 +258,19 @@ struct tcpm_port {
 	bool attached;
 	bool connected;
 	enum typec_port_type port_type;
+
+	/*
+	 * Set to true when vbus is greater than VSAFE5V min.
+	 * Set to false when vbus falls below vSinkDisconnect max threshold.
+	 */
 	bool vbus_present;
+
+	/*
+	 * Set to true when vbus is less than VSAFE0V max.
+	 * Set to false when vbus is greater than VSAFE0V max.
+	 */
+	bool vbus_vsafe0v;
+
 	bool vbus_never_low;
 	bool vbus_source;
 	bool vbus_charge;
@@ -3094,7 +3106,7 @@ static void run_state_machine(struct tcpm_port *port)
 		else if (tcpm_port_is_audio(port))
 			tcpm_set_state(port, AUDIO_ACC_ATTACHED,
 				       PD_T_CC_DEBOUNCE);
-		else if (tcpm_port_is_source(port))
+		else if (tcpm_port_is_source(port) && port->vbus_vsafe0v)
 			tcpm_set_state(port,
 				       tcpm_try_snk(port) ? SNK_TRY
 							  : SRC_ATTACHED,
@@ -4097,6 +4109,12 @@ static void _tcpm_pd_vbus_on(struct tcpm_port *port)
 {
 	tcpm_log_force(port, "VBUS on");
 	port->vbus_present =3D true;
+	/*
+	 * When vbus_present is true i.e. Voltage at VBUS is greater than VSAFE5V=
 implicitly
+	 * states that vbus is not at VSAFE0V, hence clear the vbus_vsafe0v flag =
here.
+	 */
+	port->vbus_vsafe0v =3D false;
+
 	switch (port->state) {
 	case SNK_TRANSITION_SINK_VBUS:
 		port->explicit_contract =3D true;
@@ -4186,16 +4204,8 @@ static void _tcpm_pd_vbus_off(struct tcpm_port *port=
)
 	case SNK_HARD_RESET_SINK_OFF:
 		tcpm_set_state(port, SNK_HARD_RESET_WAIT_VBUS, 0);
 		break;
-	case SRC_HARD_RESET_VBUS_OFF:
-		/*
-		 * After establishing the vSafe0V voltage condition on VBUS, the Source =
Shall wait
-		 * tSrcRecover before re-applying VCONN and restoring VBUS to vSafe5V.
-		 */
-		tcpm_set_state(port, SRC_HARD_RESET_VBUS_ON, PD_T_SRC_RECOVER);
-		break;
 	case HARD_RESET_SEND:
 		break;
-
 	case SNK_TRY:
 		/* Do nothing, waiting for timeout */
 		break;
@@ -4266,6 +4276,28 @@ static void _tcpm_pd_vbus_off(struct tcpm_port *port=
)
 	}
 }
=20
+static void _tcpm_pd_vbus_vsafe0v(struct tcpm_port *port)
+{
+	tcpm_log_force(port, "VBUS VSAFE0V");
+	port->vbus_vsafe0v =3D true;
+	switch (port->state) {
+	case SRC_HARD_RESET_VBUS_OFF:
+		/*
+		 * After establishing the vSafe0V voltage condition on VBUS, the Source =
Shall wait
+		 * tSrcRecover before re-applying VCONN and restoring VBUS to vSafe5V.
+		 */
+		tcpm_set_state(port, SRC_HARD_RESET_VBUS_ON, PD_T_SRC_RECOVER);
+		break;
+	case SRC_ATTACH_WAIT:
+		if (tcpm_port_is_source(port))
+			tcpm_set_state(port, tcpm_try_snk(port) ? SNK_TRY : SRC_ATTACHED,
+				       PD_T_CC_DEBOUNCE);
+		break;
+	default:
+		break;
+	}
+}
+
 static void _tcpm_pd_hard_reset(struct tcpm_port *port)
 {
 	tcpm_log_force(port, "Received hard reset");
@@ -4301,10 +4333,19 @@ static void tcpm_pd_event_handler(struct kthread_wo=
rk *work)
 			bool vbus;
=20
 			vbus =3D port->tcpc->get_vbus(port->tcpc);
-			if (vbus)
+			if (vbus) {
 				_tcpm_pd_vbus_on(port);
-			else
+			} else {
 				_tcpm_pd_vbus_off(port);
+				/*
+				 * When TCPC does not support detecting vsafe0v voltage level,
+				 * treat vbus absent as vsafe0v. Else invoke is_vbus_vsafe0v
+				 * to see if vbus has discharge to VSAFE0V.
+				 */
+				if (!port->tcpc->is_vbus_vsafe0v ||
+				    port->tcpc->is_vbus_vsafe0v(port->tcpc) > 0)
+					_tcpm_pd_vbus_vsafe0v(port);
+			}
 		}
 		if (events & TCPM_CC_EVENT) {
 			enum typec_cc_status cc1, cc2;
diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
index e68aaa12886f..615d4532c028 100644
--- a/include/linux/usb/tcpm.h
+++ b/include/linux/usb/tcpm.h
@@ -98,6 +98,11 @@ enum tcpm_transmit_type {
  *		will be turned on. requested_vbus_voltage is set to 0 when vbus
  *		is going to disappear knowingly i.e. during PR_SWAP and
  *		HARD_RESET etc.
+ * @is_vbus_vsafe0v:
+ *		Optional; TCPCI spec based TCPC implementations are expected to
+ *		detect VSAFE0V voltage level at vbus. When detection of VSAFE0V
+ *		is supported by TCPC, set this callback for TCPM to query
+ *		whether vbus is at VSAFE0V when needed.
  */
 struct tcpc_dev {
 	struct fwnode_handle *fwnode;
@@ -128,6 +133,7 @@ struct tcpc_dev {
 	int (*enable_auto_vbus_discharge)(struct tcpc_dev *dev, bool enable);
 	int (*set_auto_vbus_discharge_threshold)(struct tcpc_dev *dev, enum typec=
_pwr_opmode mode,
 						 bool pps_active, u32 requested_vbus_voltage);
+	int (*is_vbus_vsafe0v)(struct tcpc_dev *dev);
 };
=20
 struct tcpm_port;
--=20
2.29.2.454.gaff20da3a2-goog

