Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8D42F637E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 15:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729218AbhANOw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 09:52:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728968AbhANOw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 09:52:26 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F74C061786
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 06:51:25 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id d7so4890107qkb.23
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 06:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=IR7PJluQmWFX3bF3iE1MSr7GqOaTBsiNeWgrBO+48iY=;
        b=USIcIsLQ62YGVAVZiyXVHPwgJMpvu7UY+7pyMbzdiBpmFN8q7XGwyOH1jTgbI+Rbnp
         5eTTI8ufu98x4DoFQYlAuiVFX18TaYdA3KmXcddj39ttKKns+MZIjdzImkO58DiW57fN
         wC2QPwE+iK/XfMsTmRXY16OkaflqRLdCfqz9VOddEzojNTAubGGs3UbFIoiGvkGsh0QY
         yAh/N+sQP4UjjB02igeFqPJtqoQXIFzDzhDjdq6Fiq2+R7xcpeuSjOP+ILl+Yhbc5sGE
         HIkXnfLrS0+JDxQnloXJOK2mQiUSlUMdfQMKNLINNZ4ZZfFG9+zIRm7T6QfbtP0z4+C/
         ZWlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IR7PJluQmWFX3bF3iE1MSr7GqOaTBsiNeWgrBO+48iY=;
        b=OyTbTUFiqm/HqA257yxyYhdNX79JQDcq2V49clzbGqq8wQbKs72A3cBohIF9Zvx3jm
         vtOLGpNqpXUBXdoM4lg2djSCcrjd3V78FT2U/eUjhpbhTHJsVPewYOSQjeaPJRaH5bml
         iChCNRlVu0ntjBohROBzzoawATA4WRuZx782xoEZtif5kSU+jfUJNiCfrGHrnSU6CWeI
         JmIPz+3DzjJVTosPBJ0FPrH333MBrNi1JpIyExuANkfHJq6yMZ8Uk2KatB0VQKiWefic
         kn2wZvgjF18B9/hzGklXFX4iIvOUEofO4MXs9r3YOpjJ79K1WOy4t2X/ynmr1kgG5OAV
         7UcA==
X-Gm-Message-State: AOAM532uagQ7YEPCzTGljyQ0bm4aDaNuAGI4552rRSGSbTi8PYrtVjcU
        dPZwQ8qI6nZNmv/ZlB4d2Kyje/QNcRVc
X-Google-Smtp-Source: ABdhPJx08/ktH9DBsVQZWCAxV0yHK0EXn2nAAikLGmgqQishr11sc91Nrr8qq3+l99VRMYPJGVnvF5818aNl
Sender: "kyletso via sendgmr" <kyletso@kyletso.ntc.corp.google.com>
X-Received: from kyletso.ntc.corp.google.com ([2401:fa00:fc:202:3e52:82ff:fe5b:30db])
 (user=kyletso job=sendgmr) by 2002:a25:ed10:: with SMTP id
 k16mr2021253ybh.225.1610635885052; Thu, 14 Jan 2021 06:51:25 -0800 (PST)
Date:   Thu, 14 Jan 2021 22:50:53 +0800
In-Reply-To: <20210114145053.1952756-1-kyletso@google.com>
Message-Id: <20210114145053.1952756-4-kyletso@google.com>
Mime-Version: 1.0
References: <20210114145053.1952756-1-kyletso@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v6 3/3] usb: typec: tcpm: Respond Wait if VDM state machine is running
From:   Kyle Tso <kyletso@google.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, hdegoede@redhat.com
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kyle Tso <kyletso@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Port partner could send PR_SWAP/DR_SWAP/VCONN_SWAP/Request just after it
enters Ready states. This will cause conficts if the port is going to
send DISC_IDENT in the Ready states of TCPM. Set a flag indicating that
the state machine is processing VDM and respond Wait messages until the
VDM state machine stops.

Signed-off-by: Kyle Tso <kyletso@google.com>
---
Changelog since v5:
 - no change

 drivers/usb/typec/tcpm/tcpm.c | 80 ++++++++++++++++++++++++++++++++---
 1 file changed, 73 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 70922723da4b..0dd932fe08d0 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -352,6 +352,7 @@ struct tcpm_port {
 	struct hrtimer enable_frs_timer;
 	struct kthread_work enable_frs;
 	bool state_machine_running;
+	bool vdm_sm_running;
 
 	struct completion tx_complete;
 	enum tcpm_transmit_status tx_status;
@@ -1526,6 +1527,7 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
 				rlen = 1;
 			} else {
 				tcpm_register_partner_altmodes(port);
+				port->vdm_sm_running = false;
 			}
 			break;
 		case CMD_ENTER_MODE:
@@ -1569,10 +1571,12 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
 			rlen = 1;
 			break;
 		}
+		port->vdm_sm_running = false;
 		break;
 	default:
 		response[0] = p[0] | VDO_CMDT(CMDT_RSP_NAK);
 		rlen = 1;
+		port->vdm_sm_running = false;
 		break;
 	}
 
@@ -1739,6 +1743,8 @@ static void vdm_run_state_machine(struct tcpm_port *port)
 			switch (PD_VDO_CMD(vdo_hdr)) {
 			case CMD_DISCOVER_IDENT:
 				res = tcpm_ams_start(port, DISCOVER_IDENTITY);
+				if (res == 0)
+					port->send_discover = false;
 				break;
 			case CMD_DISCOVER_SVID:
 				res = tcpm_ams_start(port, DISCOVER_SVIDS);
@@ -1763,8 +1769,10 @@ static void vdm_run_state_machine(struct tcpm_port *port)
 				break;
 			}
 
-			if (res < 0)
+			if (res < 0) {
+				port->vdm_sm_running = false;
 				return;
+			}
 		}
 
 		port->vdm_state = VDM_STATE_SEND_MESSAGE;
@@ -1843,6 +1851,9 @@ static void vdm_state_machine_work(struct kthread_work *work)
 		 port->vdm_state != VDM_STATE_BUSY &&
 		 port->vdm_state != VDM_STATE_SEND_MESSAGE);
 
+	if (port->vdm_state == VDM_STATE_ERR_TMOUT)
+		port->vdm_sm_running = false;
+
 	mutex_unlock(&port->lock);
 }
 
@@ -2226,6 +2237,12 @@ static void tcpm_pd_data_request(struct tcpm_port *port,
 		}
 
 		port->sink_request = le32_to_cpu(msg->payload[0]);
+
+		if (port->vdm_sm_running && port->explicit_contract) {
+			tcpm_pd_handle_msg(port, PD_MSG_CTRL_WAIT, port->ams);
+			break;
+		}
+
 		if (port->state == SRC_SEND_CAPABILITIES)
 			tcpm_set_state(port, SRC_NEGOTIATE_CAPABILITIES, 0);
 		else
@@ -2328,6 +2345,10 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
 								       TYPEC_PWR_MODE_PD,
 								       port->pps_data.active,
 								       port->supply_voltage);
+				/* Set VDM running flag ASAP */
+				if (port->data_role == TYPEC_HOST &&
+				    port->send_discover)
+					port->vdm_sm_running = true;
 				tcpm_set_state(port, SNK_READY, 0);
 			} else {
 				/*
@@ -2365,10 +2386,14 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
 		switch (port->state) {
 		case SNK_NEGOTIATE_CAPABILITIES:
 			/* USB PD specification, Figure 8-43 */
-			if (port->explicit_contract)
+			if (port->explicit_contract) {
 				next_state = SNK_READY;
-			else
+				if (port->data_role == TYPEC_HOST &&
+				    port->send_discover)
+					port->vdm_sm_running = true;
+			} else {
 				next_state = SNK_WAIT_CAPABILITIES;
+			}
 			tcpm_set_state(port, next_state, 0);
 			break;
 		case SNK_NEGOTIATE_PPS_CAPABILITIES:
@@ -2377,6 +2402,11 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
 			port->pps_data.op_curr = port->current_limit;
 			port->pps_status = (type == PD_CTRL_WAIT ?
 					    -EAGAIN : -EOPNOTSUPP);
+
+			if (port->data_role == TYPEC_HOST &&
+			    port->send_discover)
+				port->vdm_sm_running = true;
+
 			tcpm_set_state(port, SNK_READY, 0);
 			break;
 		case DR_SWAP_SEND:
@@ -2433,6 +2463,10 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
 			}
 			break;
 		case DR_SWAP_SEND:
+			if (port->data_role == TYPEC_DEVICE &&
+			    port->send_discover)
+				port->vdm_sm_running = true;
+
 			tcpm_set_state(port, DR_SWAP_CHANGE_DR, 0);
 			break;
 		case PR_SWAP_SEND:
@@ -2463,26 +2497,43 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
 		 * 6.3.9: If an alternate mode is active, a request to swap
 		 * alternate modes shall trigger a port reset.
 		 */
-		if (port->typec_caps.data != TYPEC_PORT_DRD)
+		if (port->typec_caps.data != TYPEC_PORT_DRD) {
 			tcpm_pd_handle_msg(port,
 					   port->negotiated_rev < PD_REV30 ?
 					   PD_MSG_CTRL_REJECT :
 					   PD_MSG_CTRL_NOT_SUPP,
 					   NONE_AMS);
-		else
+		} else {
+			if (port->vdm_sm_running) {
+				tcpm_queue_message(port, PD_MSG_CTRL_WAIT);
+				break;
+			}
+
 			tcpm_pd_handle_state(port, DR_SWAP_ACCEPT, DATA_ROLE_SWAP, 0);
+		}
 		break;
 	case PD_CTRL_PR_SWAP:
-		if (port->port_type != TYPEC_PORT_DRP)
+		if (port->port_type != TYPEC_PORT_DRP) {
 			tcpm_pd_handle_msg(port,
 					   port->negotiated_rev < PD_REV30 ?
 					   PD_MSG_CTRL_REJECT :
 					   PD_MSG_CTRL_NOT_SUPP,
 					   NONE_AMS);
-		else
+		} else {
+			if (port->vdm_sm_running) {
+				tcpm_queue_message(port, PD_MSG_CTRL_WAIT);
+				break;
+			}
+
 			tcpm_pd_handle_state(port, PR_SWAP_ACCEPT, POWER_ROLE_SWAP, 0);
+		}
 		break;
 	case PD_CTRL_VCONN_SWAP:
+		if (port->vdm_sm_running) {
+			tcpm_queue_message(port, PD_MSG_CTRL_WAIT);
+			break;
+		}
+
 		tcpm_pd_handle_state(port, VCONN_SWAP_ACCEPT, VCONN_SWAP, 0);
 		break;
 	case PD_CTRL_GET_SOURCE_CAP_EXT:
@@ -3346,6 +3397,7 @@ static void tcpm_reset_port(struct tcpm_port *port)
 	}
 	port->in_ams = false;
 	port->ams = NONE_AMS;
+	port->vdm_sm_running = false;
 	tcpm_unregister_altmodes(port);
 	tcpm_typec_disconnect(port);
 	port->attached = false;
@@ -4144,6 +4196,9 @@ static void run_state_machine(struct tcpm_port *port)
 		break;
 	case DR_SWAP_ACCEPT:
 		tcpm_pd_send_control(port, PD_CTRL_ACCEPT);
+		/* Set VDM state machine running flag ASAP */
+		if (port->data_role == TYPEC_DEVICE && port->send_discover)
+			port->vdm_sm_running = true;
 		tcpm_set_state_cond(port, DR_SWAP_CHANGE_DR, 0);
 		break;
 	case DR_SWAP_SEND_TIMEOUT:
@@ -4299,6 +4354,8 @@ static void run_state_machine(struct tcpm_port *port)
 		break;
 	case VCONN_SWAP_SEND_TIMEOUT:
 		tcpm_swap_complete(port, -ETIMEDOUT);
+		if (port->data_role == TYPEC_HOST && port->send_discover)
+			port->vdm_sm_running = true;
 		tcpm_set_state(port, ready_state(port), 0);
 		break;
 	case VCONN_SWAP_START:
@@ -4314,10 +4371,14 @@ static void run_state_machine(struct tcpm_port *port)
 	case VCONN_SWAP_TURN_ON_VCONN:
 		tcpm_set_vconn(port, true);
 		tcpm_pd_send_control(port, PD_CTRL_PS_RDY);
+		if (port->data_role == TYPEC_HOST && port->send_discover)
+			port->vdm_sm_running = true;
 		tcpm_set_state(port, ready_state(port), 0);
 		break;
 	case VCONN_SWAP_TURN_OFF_VCONN:
 		tcpm_set_vconn(port, false);
+		if (port->data_role == TYPEC_HOST && port->send_discover)
+			port->vdm_sm_running = true;
 		tcpm_set_state(port, ready_state(port), 0);
 		break;
 
@@ -4325,6 +4386,8 @@ static void run_state_machine(struct tcpm_port *port)
 	case PR_SWAP_CANCEL:
 	case VCONN_SWAP_CANCEL:
 		tcpm_swap_complete(port, port->swap_status);
+		if (port->data_role == TYPEC_HOST && port->send_discover)
+			port->vdm_sm_running = true;
 		if (port->pwr_role == TYPEC_SOURCE)
 			tcpm_set_state(port, SRC_READY, 0);
 		else
@@ -4654,6 +4717,9 @@ static void _tcpm_pd_vbus_on(struct tcpm_port *port)
 	switch (port->state) {
 	case SNK_TRANSITION_SINK_VBUS:
 		port->explicit_contract = true;
+		/* Set the VDM flag ASAP */
+		if (port->data_role == TYPEC_HOST && port->send_discover)
+			port->vdm_sm_running = true;
 		tcpm_set_state(port, SNK_READY, 0);
 		break;
 	case SNK_DISCOVERY:
-- 
2.30.0.284.gd98b1dd5eaa7-goog

