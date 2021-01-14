Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB432F637B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 15:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbhANOw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 09:52:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728249AbhANOw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 09:52:26 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18560C0613ED
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 06:51:21 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id i20so4696581qvk.18
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 06:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=1yLjsRu5Ste2PhrkWaCnsjEG7AiDWmvLuLuqX0wP30g=;
        b=HNKoNgpM3PEsz4r7cUU6d58szZqcQasDFOCH17gRbyCYOx65plWwPw3DjoUBMAxJ8k
         xTyaOCJmEK6CjhS8VxmgU84jiA/mWCnj6Ep3wNqlvOgzoiFBa6iLEim+uKO2p+VONO4s
         0BKpzbROjDQnVTsJXC0uhUxcAIJa4L5eaHe5Rz9e29rAjSnRBs+mBB0AN1kPSz0zPi3K
         KA9KSf9u4poTii1Su92iXTkGnPo4HbXK00kCQaVTbQ1Or7tOfF8t55EFUCdtXVtfUaLI
         2KeNy+0XI4qa91Nwv108aS2ih6z9gq1UX97K46qXvebhMqVlB93ePxHEoIbcr699WwkR
         Xnkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1yLjsRu5Ste2PhrkWaCnsjEG7AiDWmvLuLuqX0wP30g=;
        b=ZaENx6qNYyKboTnPPuStHb2yaIHHWBkbHk2ZZ0y+/orNiHosIjTtj0EhWjQelRkRqC
         FhpTA/l/gDBqPZad8y1GrpJEKsbKZKIkvYhnoxUSgfvkDAXRxbWmMhZKbZ40KqaCVlwf
         SNSJj6Yr4Kj+Dh7T6/hUWo6dhC+YcoQHgGpdV1FAEow0goMWu0A3ZLPzs6R+Ep9n4t1y
         8+a0VCX+Wwm9dUMpA6RytuQ9+PXcu/rCgW8NCZHg9i8TaHeLvtKvJcrX2lc3RXf0qSl5
         RJQAfi4QqJGIx/GBHB/ddQLUFWvCSENOYmEM3mHVpGBKDj+4/hU+mv1iYcOIOLoNhZ6p
         e6Hw==
X-Gm-Message-State: AOAM532fJ4iV4PMSV7OmMToHgvjIpTPN5ozoAhJHpPrKhqo12hMqo2Fa
        0AZb+3SiZC1R9k7ybOPPt0wgRWJhNJZH
X-Google-Smtp-Source: ABdhPJzd6Pfxf+kp7Xc4gS48NGeq1zPl4OELPt2COvlna1LNeUrgAVV+hrSUUxCdTpNKEjRMmkVhwo7rxvTp
Sender: "kyletso via sendgmr" <kyletso@kyletso.ntc.corp.google.com>
X-Received: from kyletso.ntc.corp.google.com ([2401:fa00:fc:202:3e52:82ff:fe5b:30db])
 (user=kyletso job=sendgmr) by 2002:ad4:438f:: with SMTP id
 s15mr7521781qvr.13.1610635880148; Thu, 14 Jan 2021 06:51:20 -0800 (PST)
Date:   Thu, 14 Jan 2021 22:50:52 +0800
In-Reply-To: <20210114145053.1952756-1-kyletso@google.com>
Message-Id: <20210114145053.1952756-3-kyletso@google.com>
Mime-Version: 1.0
References: <20210114145053.1952756-1-kyletso@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v6 2/3] usb: typec: tcpm: Protocol Error handling
From:   Kyle Tso <kyletso@google.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, hdegoede@redhat.com
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kyle Tso <kyletso@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PD3.0 Spec 6.8.1 describes how to handle Protocol Error. There are
general rules defined in Table 6-61 which regulate incoming Message
handling. If the incoming Message is unexpected, unsupported, or
unrecognized, Protocol Error occurs. Follow the rules to handle these
situations. Also consider PD2.0 connection (PD2.0 Spec Table 6-36) for
backward compatibilities.

To know the types of AMS in all the recipient's states, identify those
AMS who are initiated by the port partner but not yet recorded in the
current code.

Besides, introduce a new state CHUNK_NOT_SUPP to delay the NOT_SUPPORTED
message after receiving a chunked message.

Signed-off-by: Kyle Tso <kyletso@google.com>
---
changelog since v5:
 - removed the signed-off
 - modified the coding style suggested from Heikki
 - modified more coding style problems (line wrapping limit)

 drivers/usb/typec/tcpm/tcpm.c | 335 +++++++++++++++++++++++++---------
 include/linux/usb/pd.h        |   1 +
 2 files changed, 246 insertions(+), 90 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 2b16d2764092..70922723da4b 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -143,7 +143,8 @@
 	S(PORT_RESET),				\
 	S(PORT_RESET_WAIT_OFF),			\
 						\
-	S(AMS_START)
+	S(AMS_START),				\
+	S(CHUNK_NOT_SUPP)
 
 #define FOREACH_AMS(S)				\
 	S(NONE_AMS),				\
@@ -433,6 +434,7 @@ struct tcpm_port {
 	/* Collision Avoidance and Atomic Message Sequence */
 	enum tcpm_state upcoming_state;
 	enum tcpm_ams ams;
+	enum tcpm_ams next_ams;
 	bool in_ams;
 
 #ifdef CONFIG_DEBUG_FS
@@ -1213,7 +1215,8 @@ static int tcpm_ams_start(struct tcpm_port *port, enum tcpm_ams ams)
 
 	tcpm_log(port, "AMS %s start", tcpm_ams_str[ams]);
 
-	if (!tcpm_ams_interruptible(port) && ams != HARD_RESET) {
+	if (!tcpm_ams_interruptible(port) &&
+	    !(ams == HARD_RESET || ams == SOFT_RESET_AMS)) {
 		port->upcoming_state = INVALID_STATE;
 		tcpm_log(port, "AMS %s not interruptible, aborting",
 			 tcpm_ams_str[port->ams]);
@@ -1231,11 +1234,10 @@ static int tcpm_ams_start(struct tcpm_port *port, enum tcpm_ams ams)
 			tcpm_set_state(port, HARD_RESET_START, 0);
 			return ret;
 		} else if (ams == SOFT_RESET_AMS) {
-			if (!port->explicit_contract) {
-				port->upcoming_state = INVALID_STATE;
+			if (!port->explicit_contract)
 				tcpm_set_cc(port, tcpm_rp_cc(port));
-				return ret;
-			}
+			tcpm_set_state(port, SOFT_RESET_SEND, 0);
+			return ret;
 		} else if (tcpm_vdm_ams(port)) {
 			/* tSinkTx is enforced in vdm_run_state_machine */
 			if (port->negotiated_rev >= PD_REV30)
@@ -1452,6 +1454,9 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
 	case CMDT_INIT:
 		switch (cmd) {
 		case CMD_DISCOVER_IDENT:
+			if (PD_VDO_VID(p[0]) != USB_SID_PD)
+				break;
+
 			/* 6.4.4.3.1: Only respond as UFP (device) */
 			if (port->data_role == TYPEC_DEVICE &&
 			    port->nr_snk_vdo) {
@@ -1537,22 +1542,37 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
 				return 0;
 			}
 			break;
+		case VDO_CMD_VENDOR(0) ... VDO_CMD_VENDOR(15):
+			break;
 		default:
+			/* Unrecognized SVDM */
+			response[0] = p[0] | VDO_CMDT(CMDT_RSP_NAK);
+			rlen = 1;
 			break;
 		}
 		break;
 	case CMDT_RSP_NAK:
 		tcpm_ams_finish(port);
 		switch (cmd) {
+		case CMD_DISCOVER_IDENT:
+		case CMD_DISCOVER_SVID:
+		case CMD_DISCOVER_MODES:
+		case VDO_CMD_VENDOR(0) ... VDO_CMD_VENDOR(15):
+			break;
 		case CMD_ENTER_MODE:
 			/* Back to USB Operation */
 			*adev_action = ADEV_NOTIFY_USB_AND_QUEUE_VDM;
 			return 0;
 		default:
+			/* Unrecognized SVDM */
+			response[0] = p[0] | VDO_CMDT(CMDT_RSP_NAK);
+			rlen = 1;
 			break;
 		}
 		break;
 	default:
+		response[0] = p[0] | VDO_CMDT(CMDT_RSP_NAK);
+		rlen = 1;
 		break;
 	}
 
@@ -1588,8 +1608,12 @@ static void tcpm_handle_vdm_request(struct tcpm_port *port,
 		port->vdm_state = VDM_STATE_DONE;
 	}
 
-	if (PD_VDO_SVDM(p[0]))
+	if (PD_VDO_SVDM(p[0])) {
 		rlen = tcpm_pd_svdm(port, adev, p, cnt, response, &adev_action);
+	} else {
+		if (port->negotiated_rev >= PD_REV30)
+			tcpm_queue_message(port, PD_MSG_CTRL_NOT_SUPP);
+	}
 
 	/*
 	 * We are done with any state stored in the port struct now, except
@@ -2039,6 +2063,71 @@ static int tcpm_set_auto_vbus_discharge_threshold(struct tcpm_port *port,
 	return ret;
 }
 
+static void tcpm_pd_handle_state(struct tcpm_port *port,
+				 enum tcpm_state state,
+				 enum tcpm_ams ams,
+				 unsigned int delay_ms)
+{
+	switch (port->state) {
+	case SRC_READY:
+	case SNK_READY:
+		port->ams = ams;
+		tcpm_set_state(port, state, delay_ms);
+		break;
+	/* 8.3.3.4.1.1 and 6.8.1 power transitioning */
+	case SNK_TRANSITION_SINK:
+	case SNK_TRANSITION_SINK_VBUS:
+	case SRC_TRANSITION_SUPPLY:
+		tcpm_set_state(port, HARD_RESET_SEND, 0);
+		break;
+	default:
+		if (!tcpm_ams_interruptible(port)) {
+			tcpm_set_state(port, port->pwr_role == TYPEC_SOURCE ?
+				       SRC_SOFT_RESET_WAIT_SNK_TX :
+				       SNK_SOFT_RESET,
+				       0);
+		} else {
+			/* process the Message 6.8.1 */
+			port->upcoming_state = state;
+			port->next_ams = ams;
+			tcpm_set_state(port, ready_state(port), delay_ms);
+		}
+		break;
+	}
+}
+
+static void tcpm_pd_handle_msg(struct tcpm_port *port,
+			       enum pd_msg_request message,
+			       enum tcpm_ams ams)
+{
+	switch (port->state) {
+	case SRC_READY:
+	case SNK_READY:
+		port->ams = ams;
+		tcpm_queue_message(port, message);
+		break;
+	/* PD 3.0 Spec 8.3.3.4.1.1 and 6.8.1 */
+	case SNK_TRANSITION_SINK:
+	case SNK_TRANSITION_SINK_VBUS:
+	case SRC_TRANSITION_SUPPLY:
+		tcpm_set_state(port, HARD_RESET_SEND, 0);
+		break;
+	default:
+		if (!tcpm_ams_interruptible(port)) {
+			tcpm_set_state(port, port->pwr_role == TYPEC_SOURCE ?
+				       SRC_SOFT_RESET_WAIT_SNK_TX :
+				       SNK_SOFT_RESET,
+				       0);
+		} else {
+			port->next_ams = ams;
+			tcpm_set_state(port, ready_state(port), 0);
+			/* 6.8.1 process the Message */
+			tcpm_queue_message(port, message);
+		}
+		break;
+	}
+}
+
 static void tcpm_pd_data_request(struct tcpm_port *port,
 				 const struct pd_message *msg)
 {
@@ -2052,9 +2141,6 @@ static void tcpm_pd_data_request(struct tcpm_port *port,
 
 	switch (type) {
 	case PD_DATA_SOURCE_CAP:
-		if (port->pwr_role != TYPEC_SINK)
-			break;
-
 		for (i = 0; i < cnt; i++)
 			port->source_caps[i] = le32_to_cpu(msg->payload[i]);
 
@@ -2070,12 +2156,26 @@ static void tcpm_pd_data_request(struct tcpm_port *port,
 		 * to comply with 6.2.1.1.5 of the USB PD 3.0 spec. We don't
 		 * support Rev 1.0 so just do nothing in that scenario.
 		 */
-		if (rev == PD_REV10)
+		if (rev == PD_REV10) {
+			if (port->ams == GET_SOURCE_CAPABILITIES)
+				tcpm_ams_finish(port);
 			break;
+		}
 
 		if (rev < PD_MAX_REV)
 			port->negotiated_rev = rev;
 
+		if (port->pwr_role == TYPEC_SOURCE) {
+			if (port->ams == GET_SOURCE_CAPABILITIES)
+				tcpm_pd_handle_state(port, SRC_READY, NONE_AMS, 0);
+			/* Unexpected Source Capabilities */
+			else
+				tcpm_pd_handle_msg(port,
+						   port->negotiated_rev < PD_REV30 ?
+						   PD_MSG_CTRL_REJECT :
+						   PD_MSG_CTRL_NOT_SUPP,
+						   NONE_AMS);
+		} else if (port->state == SNK_WAIT_CAPABILITIES) {
 		/*
 		 * This message may be received even if VBUS is not
 		 * present. This is quite unexpected; see USB PD
@@ -2089,30 +2189,48 @@ static void tcpm_pd_data_request(struct tcpm_port *port,
 		 * but be prepared to keep waiting for VBUS after it was
 		 * handled.
 		 */
-		tcpm_set_state(port, SNK_NEGOTIATE_CAPABILITIES, 0);
+			port->ams = POWER_NEGOTIATION;
+			tcpm_set_state(port, SNK_NEGOTIATE_CAPABILITIES, 0);
+		} else {
+			if (port->ams == GET_SOURCE_CAPABILITIES)
+				tcpm_ams_finish(port);
+			tcpm_pd_handle_state(port, SNK_NEGOTIATE_CAPABILITIES,
+					     POWER_NEGOTIATION, 0);
+		}
 		break;
 	case PD_DATA_REQUEST:
-		if (port->pwr_role != TYPEC_SOURCE ||
-		    cnt != 1) {
-			tcpm_queue_message(port, PD_MSG_CTRL_REJECT);
-			break;
-		}
-
 		/*
 		 * Adjust revision in subsequent message headers, as required,
 		 * to comply with 6.2.1.1.5 of the USB PD 3.0 spec. We don't
 		 * support Rev 1.0 so just reject in that scenario.
 		 */
 		if (rev == PD_REV10) {
-			tcpm_queue_message(port, PD_MSG_CTRL_REJECT);
+			tcpm_pd_handle_msg(port,
+					   port->negotiated_rev < PD_REV30 ?
+					   PD_MSG_CTRL_REJECT :
+					   PD_MSG_CTRL_NOT_SUPP,
+					   NONE_AMS);
 			break;
 		}
 
 		if (rev < PD_MAX_REV)
 			port->negotiated_rev = rev;
 
+		if (port->pwr_role != TYPEC_SOURCE || cnt != 1) {
+			tcpm_pd_handle_msg(port,
+					   port->negotiated_rev < PD_REV30 ?
+					   PD_MSG_CTRL_REJECT :
+					   PD_MSG_CTRL_NOT_SUPP,
+					   NONE_AMS);
+			break;
+		}
+
 		port->sink_request = le32_to_cpu(msg->payload[0]);
-		tcpm_set_state(port, SRC_NEGOTIATE_CAPABILITIES, 0);
+		if (port->state == SRC_SEND_CAPABILITIES)
+			tcpm_set_state(port, SRC_NEGOTIATE_CAPABILITIES, 0);
+		else
+			tcpm_pd_handle_state(port, SRC_NEGOTIATE_CAPABILITIES,
+					     POWER_NEGOTIATION, 0);
 		break;
 	case PD_DATA_SINK_CAP:
 		/* We don't do anything with this at the moment... */
@@ -2133,16 +2251,22 @@ static void tcpm_pd_data_request(struct tcpm_port *port,
 
 		port->nr_sink_caps = cnt;
 		port->sink_cap_done = true;
-		tcpm_set_state(port, SNK_READY, 0);
+		if (port->ams == GET_SINK_CAPABILITIES)
+			tcpm_pd_handle_state(port, ready_state(port), NONE_AMS, 0);
+		/* Unexpected Sink Capabilities */
+		else
+			tcpm_pd_handle_msg(port,
+					   port->negotiated_rev < PD_REV30 ?
+					   PD_MSG_CTRL_REJECT :
+					   PD_MSG_CTRL_NOT_SUPP,
+					   NONE_AMS);
 		break;
 	case PD_DATA_VENDOR_DEF:
 		tcpm_handle_vdm_request(port, msg->payload, cnt);
 		break;
 	case PD_DATA_BIST:
-		if (port->state == SRC_READY || port->state == SNK_READY) {
-			port->bist_request = le32_to_cpu(msg->payload[0]);
-			tcpm_set_state(port, BIST_RX, 0);
-		}
+		port->bist_request = le32_to_cpu(msg->payload[0]);
+		tcpm_pd_handle_state(port, BIST_RX, BIST, 0);
 		break;
 	case PD_DATA_ALERT:
 		tcpm_handle_alert(port, msg->payload, cnt);
@@ -2150,10 +2274,17 @@ static void tcpm_pd_data_request(struct tcpm_port *port,
 	case PD_DATA_BATT_STATUS:
 	case PD_DATA_GET_COUNTRY_INFO:
 		/* Currently unsupported */
-		tcpm_queue_message(port, PD_MSG_CTRL_NOT_SUPP);
+		tcpm_pd_handle_msg(port, port->negotiated_rev < PD_REV30 ?
+				   PD_MSG_CTRL_REJECT :
+				   PD_MSG_CTRL_NOT_SUPP,
+				   NONE_AMS);
 		break;
 	default:
-		tcpm_log(port, "Unhandled data message type %#x", type);
+		tcpm_pd_handle_msg(port, port->negotiated_rev < PD_REV30 ?
+				   PD_MSG_CTRL_REJECT :
+				   PD_MSG_CTRL_NOT_SUPP,
+				   NONE_AMS);
+		tcpm_log(port, "Unrecognized data message type %#x", type);
 		break;
 	}
 }
@@ -2178,26 +2309,10 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
 	case PD_CTRL_PING:
 		break;
 	case PD_CTRL_GET_SOURCE_CAP:
-		switch (port->state) {
-		case SRC_READY:
-		case SNK_READY:
-			tcpm_queue_message(port, PD_MSG_DATA_SOURCE_CAP);
-			break;
-		default:
-			tcpm_queue_message(port, PD_MSG_CTRL_REJECT);
-			break;
-		}
+		tcpm_pd_handle_msg(port, PD_MSG_DATA_SOURCE_CAP, GET_SOURCE_CAPABILITIES);
 		break;
 	case PD_CTRL_GET_SINK_CAP:
-		switch (port->state) {
-		case SRC_READY:
-		case SNK_READY:
-			tcpm_queue_message(port, PD_MSG_DATA_SINK_CAP);
-			break;
-		default:
-			tcpm_queue_message(port, PD_MSG_CTRL_REJECT);
-			break;
-		}
+		tcpm_pd_handle_msg(port, PD_MSG_DATA_SINK_CAP, GET_SINK_CAPABILITIES);
 		break;
 	case PD_CTRL_GOTO_MIN:
 		break;
@@ -2236,6 +2351,11 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
 			tcpm_set_state(port, FR_SWAP_SNK_SRC_NEW_SINK_READY, 0);
 			break;
 		default:
+			tcpm_pd_handle_state(port,
+					     port->pwr_role == TYPEC_SOURCE ?
+					     SRC_SOFT_RESET_WAIT_SNK_TX :
+					     SNK_SOFT_RESET,
+					     NONE_AMS, 0);
 			break;
 		}
 		break;
@@ -2282,6 +2402,11 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
 			tcpm_set_state(port, ready_state(port), 0);
 			break;
 		default:
+			tcpm_pd_handle_state(port,
+					     port->pwr_role == TYPEC_SOURCE ?
+					     SRC_SOFT_RESET_WAIT_SNK_TX :
+					     SNK_SOFT_RESET,
+					     NONE_AMS, 0);
 			break;
 		}
 		break;
@@ -2298,8 +2423,6 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
 			tcpm_set_state(port, SNK_TRANSITION_SINK, 0);
 			break;
 		case SOFT_RESET_SEND:
-			port->message_id = 0;
-			port->rx_msgid = -1;
 			if (port->ams == SOFT_RESET_AMS)
 				tcpm_ams_finish(port);
 			if (port->pwr_role == TYPEC_SOURCE) {
@@ -2322,57 +2445,45 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
 			tcpm_set_state(port, FR_SWAP_SNK_SRC_TRANSITION_TO_OFF, 0);
 			break;
 		default:
+			tcpm_pd_handle_state(port,
+					     port->pwr_role == TYPEC_SOURCE ?
+					     SRC_SOFT_RESET_WAIT_SNK_TX :
+					     SNK_SOFT_RESET,
+					     NONE_AMS, 0);
 			break;
 		}
 		break;
 	case PD_CTRL_SOFT_RESET:
+		port->ams = SOFT_RESET_AMS;
 		tcpm_set_state(port, SOFT_RESET, 0);
 		break;
 	case PD_CTRL_DR_SWAP:
-		if (port->typec_caps.data != TYPEC_PORT_DRD) {
-			tcpm_queue_message(port, PD_MSG_CTRL_REJECT);
-			break;
-		}
 		/*
 		 * XXX
 		 * 6.3.9: If an alternate mode is active, a request to swap
 		 * alternate modes shall trigger a port reset.
 		 */
-		switch (port->state) {
-		case SRC_READY:
-		case SNK_READY:
-			tcpm_set_state(port, DR_SWAP_ACCEPT, 0);
-			break;
-		default:
-			tcpm_queue_message(port, PD_MSG_CTRL_WAIT);
-			break;
-		}
+		if (port->typec_caps.data != TYPEC_PORT_DRD)
+			tcpm_pd_handle_msg(port,
+					   port->negotiated_rev < PD_REV30 ?
+					   PD_MSG_CTRL_REJECT :
+					   PD_MSG_CTRL_NOT_SUPP,
+					   NONE_AMS);
+		else
+			tcpm_pd_handle_state(port, DR_SWAP_ACCEPT, DATA_ROLE_SWAP, 0);
 		break;
 	case PD_CTRL_PR_SWAP:
-		if (port->port_type != TYPEC_PORT_DRP) {
-			tcpm_queue_message(port, PD_MSG_CTRL_REJECT);
-			break;
-		}
-		switch (port->state) {
-		case SRC_READY:
-		case SNK_READY:
-			tcpm_set_state(port, PR_SWAP_ACCEPT, 0);
-			break;
-		default:
-			tcpm_queue_message(port, PD_MSG_CTRL_WAIT);
-			break;
-		}
+		if (port->port_type != TYPEC_PORT_DRP)
+			tcpm_pd_handle_msg(port,
+					   port->negotiated_rev < PD_REV30 ?
+					   PD_MSG_CTRL_REJECT :
+					   PD_MSG_CTRL_NOT_SUPP,
+					   NONE_AMS);
+		else
+			tcpm_pd_handle_state(port, PR_SWAP_ACCEPT, POWER_ROLE_SWAP, 0);
 		break;
 	case PD_CTRL_VCONN_SWAP:
-		switch (port->state) {
-		case SRC_READY:
-		case SNK_READY:
-			tcpm_set_state(port, VCONN_SWAP_ACCEPT, 0);
-			break;
-		default:
-			tcpm_queue_message(port, PD_MSG_CTRL_WAIT);
-			break;
-		}
+		tcpm_pd_handle_state(port, VCONN_SWAP_ACCEPT, VCONN_SWAP, 0);
 		break;
 	case PD_CTRL_GET_SOURCE_CAP_EXT:
 	case PD_CTRL_GET_STATUS:
@@ -2380,10 +2491,19 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
 	case PD_CTRL_GET_PPS_STATUS:
 	case PD_CTRL_GET_COUNTRY_CODES:
 		/* Currently not supported */
-		tcpm_queue_message(port, PD_MSG_CTRL_NOT_SUPP);
+		tcpm_pd_handle_msg(port,
+				   port->negotiated_rev < PD_REV30 ?
+				   PD_MSG_CTRL_REJECT :
+				   PD_MSG_CTRL_NOT_SUPP,
+				   NONE_AMS);
 		break;
 	default:
-		tcpm_log(port, "Unhandled ctrl message type %#x", type);
+		tcpm_pd_handle_msg(port,
+				   port->negotiated_rev < PD_REV30 ?
+				   PD_MSG_CTRL_REJECT :
+				   PD_MSG_CTRL_NOT_SUPP,
+				   NONE_AMS);
+		tcpm_log(port, "Unrecognized ctrl message type %#x", type);
 		break;
 	}
 }
@@ -2395,11 +2515,13 @@ static void tcpm_pd_ext_msg_request(struct tcpm_port *port,
 	unsigned int data_size = pd_ext_header_data_size_le(msg->ext_msg.header);
 
 	if (!(msg->ext_msg.header & PD_EXT_HDR_CHUNKED)) {
+		tcpm_pd_handle_msg(port, PD_MSG_CTRL_NOT_SUPP, NONE_AMS);
 		tcpm_log(port, "Unchunked extended messages unsupported");
 		return;
 	}
 
 	if (data_size > PD_EXT_MAX_CHUNK_DATA) {
+		tcpm_pd_handle_state(port, CHUNK_NOT_SUPP, NONE_AMS, PD_T_CHUNK_NOT_SUPP);
 		tcpm_log(port, "Chunk handling not yet supported");
 		return;
 	}
@@ -2412,16 +2534,18 @@ static void tcpm_pd_ext_msg_request(struct tcpm_port *port,
 		 */
 		if (msg->ext_msg.data[USB_PD_EXT_SDB_EVENT_FLAGS] &
 		    USB_PD_EXT_SDB_PPS_EVENTS)
-			tcpm_set_state(port, GET_PPS_STATUS_SEND, 0);
+			tcpm_pd_handle_state(port, GET_PPS_STATUS_SEND,
+					     GETTING_SOURCE_SINK_STATUS, 0);
+
 		else
-			tcpm_set_state(port, ready_state(port), 0);
+			tcpm_pd_handle_state(port, ready_state(port), NONE_AMS, 0);
 		break;
 	case PD_EXT_PPS_STATUS:
 		/*
 		 * For now the PPS status message is used to clear events
 		 * and nothing more.
 		 */
-		tcpm_set_state(port, ready_state(port), 0);
+		tcpm_pd_handle_state(port, ready_state(port), NONE_AMS, 0);
 		break;
 	case PD_EXT_SOURCE_CAP_EXT:
 	case PD_EXT_GET_BATT_CAP:
@@ -2435,10 +2559,11 @@ static void tcpm_pd_ext_msg_request(struct tcpm_port *port,
 	case PD_EXT_FW_UPDATE_RESPONSE:
 	case PD_EXT_COUNTRY_INFO:
 	case PD_EXT_COUNTRY_CODES:
-		tcpm_queue_message(port, PD_MSG_CTRL_NOT_SUPP);
+		tcpm_pd_handle_msg(port, PD_MSG_CTRL_NOT_SUPP, NONE_AMS);
 		break;
 	default:
-		tcpm_log(port, "Unhandled extended message type %#x", type);
+		tcpm_pd_handle_msg(port, PD_MSG_CTRL_NOT_SUPP, NONE_AMS);
+		tcpm_log(port, "Unrecognized extended message type %#x", type);
 		break;
 	}
 }
@@ -2551,7 +2676,12 @@ static bool tcpm_send_queued_message(struct tcpm_port *port)
 			tcpm_pd_send_control(port, PD_CTRL_NOT_SUPP);
 			break;
 		case PD_MSG_DATA_SINK_CAP:
-			tcpm_pd_send_sink_caps(port);
+			ret = tcpm_pd_send_sink_caps(port);
+			if (ret < 0) {
+				tcpm_log(port, "Unable to send snk caps, ret=%d", ret);
+				tcpm_set_state(port, SNK_SOFT_RESET, 0);
+			}
+			tcpm_ams_finish(port);
 			break;
 		case PD_MSG_DATA_SOURCE_CAP:
 			ret = tcpm_pd_send_source_caps(port);
@@ -2561,8 +2691,11 @@ static bool tcpm_send_queued_message(struct tcpm_port *port)
 					 ret);
 				tcpm_set_state(port, SOFT_RESET_SEND, 0);
 			} else if (port->pwr_role == TYPEC_SOURCE) {
+				tcpm_ams_finish(port);
 				tcpm_set_state(port, HARD_RESET_SEND,
 					       PD_T_SENDER_RESPONSE);
+			} else {
+				tcpm_ams_finish(port);
 			}
 			break;
 		default:
@@ -3581,6 +3714,11 @@ static void run_state_machine(struct tcpm_port *port)
 
 		if (port->ams != NONE_AMS)
 			tcpm_ams_finish(port);
+		if (port->next_ams != NONE_AMS) {
+			port->ams = port->next_ams;
+			port->next_ams = NONE_AMS;
+		}
+
 		/*
 		 * If previous AMS is interrupted, switch to the upcoming
 		 * state.
@@ -3821,6 +3959,11 @@ static void run_state_machine(struct tcpm_port *port)
 
 		if (port->ams != NONE_AMS)
 			tcpm_ams_finish(port);
+		if (port->next_ams != NONE_AMS) {
+			port->ams = port->next_ams;
+			port->next_ams = NONE_AMS;
+		}
+
 		/*
 		 * If previous AMS is interrupted, switch to the upcoming
 		 * state.
@@ -3968,6 +4111,7 @@ static void run_state_machine(struct tcpm_port *port)
 		port->message_id = 0;
 		port->rx_msgid = -1;
 		tcpm_pd_send_control(port, PD_CTRL_ACCEPT);
+		tcpm_ams_finish(port);
 		if (port->pwr_role == TYPEC_SOURCE) {
 			port->upcoming_state = SRC_SEND_CAPABILITIES;
 			tcpm_ams_start(port, POWER_NEGOTIATION);
@@ -4004,6 +4148,7 @@ static void run_state_machine(struct tcpm_port *port)
 		break;
 	case DR_SWAP_SEND_TIMEOUT:
 		tcpm_swap_complete(port, -ETIMEDOUT);
+		tcpm_ams_finish(port);
 		tcpm_set_state(port, ready_state(port), 0);
 		break;
 	case DR_SWAP_CHANGE_DR:
@@ -4016,6 +4161,7 @@ static void run_state_machine(struct tcpm_port *port)
 				       TYPEC_HOST);
 			port->send_discover = true;
 		}
+		tcpm_ams_finish(port);
 		tcpm_set_state(port, ready_state(port), 0);
 		break;
 
@@ -4143,6 +4289,7 @@ static void run_state_machine(struct tcpm_port *port)
 
 	case VCONN_SWAP_ACCEPT:
 		tcpm_pd_send_control(port, PD_CTRL_ACCEPT);
+		tcpm_ams_finish(port);
 		tcpm_set_state(port, VCONN_SWAP_START, 0);
 		break;
 	case VCONN_SWAP_SEND:
@@ -4260,6 +4407,12 @@ static void run_state_machine(struct tcpm_port *port)
 		port->upcoming_state = INVALID_STATE;
 		tcpm_set_state(port, upcoming_state, 0);
 		break;
+
+	/* Chunk state */
+	case CHUNK_NOT_SUPP:
+		tcpm_pd_send_control(port, PD_CTRL_NOT_SUPP);
+		tcpm_set_state(port, port->pwr_role == TYPEC_SOURCE ? SRC_READY : SNK_READY, 0);
+		break;
 	default:
 		WARN(1, "Unexpected port state %d\n", port->state);
 		break;
@@ -4689,6 +4842,8 @@ static void _tcpm_pd_hard_reset(struct tcpm_port *port)
 
 	if (port->ams != NONE_AMS)
 		port->ams = NONE_AMS;
+	if (port->hard_reset_count < PD_N_HARD_RESET_COUNT)
+		port->ams = HARD_RESET;
 	/*
 	 * If we keep receiving hard reset requests, executing the hard reset
 	 * must have failed. Revert to error recovery if that happens.
diff --git a/include/linux/usb/pd.h b/include/linux/usb/pd.h
index 79599b90ba55..272454f9cd67 100644
--- a/include/linux/usb/pd.h
+++ b/include/linux/usb/pd.h
@@ -480,6 +480,7 @@ static inline unsigned int rdo_max_power(u32 rdo)
 #define PD_T_SWAP_SRC_START	20	/* Minimum of 20ms */
 #define PD_T_BIST_CONT_MODE	50	/* 30 - 60 ms */
 #define PD_T_SINK_TX		16	/* 16 - 20 ms */
+#define PD_T_CHUNK_NOT_SUPP	42	/* 40 - 50 ms */
 
 #define PD_T_DRP_TRY		100	/* 75 - 150 ms */
 #define PD_T_DRP_TRYWAIT	600	/* 400 - 800 ms */
-- 
2.30.0.284.gd98b1dd5eaa7-goog

