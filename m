Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D75F92C3659
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 02:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbgKYBsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 20:48:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbgKYBsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 20:48:11 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91906C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 17:48:11 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id ba3so643946plb.9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 17:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=F1xIHDPPY9Oqfb0ME3dD9RN5PQwJBw9tHgqdKwHf13o=;
        b=PIgJY+A9qCBNhFb3ERl6vp852CHoWAZqv4T5FujzNlnx5ZI3UsOib/WeWQTyIdr0Pm
         aF9kzgoOLdLxbb+3/G12qJ7dGYArB5SeY+kd459KGlCmnxAJXYgxXoms5P5343nZzqY9
         2C6pxk3JNWzYoncmic+HGiHAmPV4AwRv61HmJNlEHwO2HdNCl2Rm14K/nWuPPdjYgK5O
         +rc7T6UDvIOn2VOuFG8+2qbejL3ITV2sa9GClu7bXS4jjiFSWvGJHIauvmcCt9nqtp5o
         CwI8VEG0HpVuf4roYgVdRiiedWJRL7vbhktnmk1XyYV5x8d3R1PnHcgQwH4bJrqNw6nt
         86og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=F1xIHDPPY9Oqfb0ME3dD9RN5PQwJBw9tHgqdKwHf13o=;
        b=kQ3ZiOkBNQoiz3cY3ZSGSHLSUhK3WkbBUYe/MVIbOXvBl08zhUZMOZ5t78+/CAqiSA
         jNpdG/cbuwUxbl3+ialYPgSMg38mDebzpecGMYwyr+6si94NuYL6QmwJn4n2tq+J7E2h
         T6SyGUUwblqGhbY9pWN8zZpMZFdinbIhiYm0HpFX04zRSyDG5POKNbbaQ35YoRnoorh8
         adKWheWxbSDACOsrJVLgr3dofdFv8XOX0VSP03A6zWKPHMXW/jiJiuGJr3ciduUtCDtq
         byx+4sbSSROg2sZkRS1mVjvZjOKWNROS+MY+9ifoFUuHnNNoS1LU9A8+RcBTf03P27xS
         6zDw==
X-Gm-Message-State: AOAM531U1NQOsyE6J7dONpf9kRc6s7F7iF4LWV7jFf9g298bZtaCZ0Xz
        TRiIfQ8UNcoNZrWLh3FptiEg9gEs858=
X-Google-Smtp-Source: ABdhPJzAqON/tEhZRrX41VDmvLvotzmx38c++6/KV7X5+o67hx6Ch0wT4pK/wGSrH/XL8ppciig7LoZOTP0=
Sender: "badhri via sendgmr" <badhri@badhri.mtv.corp.google.com>
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:201:f292:1cff:fee0:66cf])
 (user=badhri job=sendgmr) by 2002:a63:3fcb:: with SMTP id m194mr1105818pga.58.1606268891004;
 Tue, 24 Nov 2020 17:48:11 -0800 (PST)
Date:   Tue, 24 Nov 2020 17:48:04 -0800
Message-Id: <20201125014804.1596719-1-badhri@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH] usb: typec: tcpm: Stay in SNK_TRY_WAIT_DEBOUNCE_CHECK_VBUS
 till Rp is seen
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

TD.4.7.3. Try SNK DRP Connect Try.SRC DRP fails. The compliance
tester mimics being a Try.SRC USB-C port.
The failure is due to TCPM exiting SNK_TRY_WAIT_DEBOUNCE_CHECK_VBUS
when VBUS is not present eventhough when SNK.Rp is seen. Exit to
SRC_TRYWAIT from SNK_TRY_WAIT_DEBOUNCE_CHECK_VBUS only when SNK.Rp
is not seen for PD_T_TRY_CC_DEBOUNCE.

From the spec:
The port shall then transition to Attached.SNK when the SNK.Rp state
is detected on exactly one of the CC1 or CC2 pins for at least
tTryCCDebounce and VBUS is detected. Alternatively, the port shall
transition to TryWait.SRC if SNK.Rp state is not detected for
tTryCCDebounce.

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 18 +++++++++++++-----
 include/linux/usb/pd.h        |  1 +
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 4aac0efdb720..b2cffa00d737 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -3124,15 +3124,13 @@ static void run_state_machine(struct tcpm_port *port)
 		break;
 	case SNK_TRY_WAIT_DEBOUNCE:
 		tcpm_set_state(port, SNK_TRY_WAIT_DEBOUNCE_CHECK_VBUS,
-			       PD_T_PD_DEBOUNCE);
+			       PD_T_TRY_CC_DEBOUNCE);
 		break;
 	case SNK_TRY_WAIT_DEBOUNCE_CHECK_VBUS:
-		if (port->vbus_present && tcpm_port_is_sink(port)) {
+		if (port->vbus_present && tcpm_port_is_sink(port))
 			tcpm_set_state(port, SNK_ATTACHED, 0);
-		} else {
-			tcpm_set_state(port, SRC_TRYWAIT, 0);
+		else
 			port->max_wait = 0;
-		}
 		break;
 	case SRC_TRYWAIT:
 		tcpm_set_cc(port, tcpm_rp_cc(port));
@@ -4053,6 +4051,12 @@ static void _tcpm_cc_change(struct tcpm_port *port, enum typec_cc_status cc1,
 		if (!tcpm_port_is_sink(port))
 			tcpm_set_state(port, SNK_TRYWAIT_DEBOUNCE, 0);
 		break;
+	case SNK_TRY_WAIT_DEBOUNCE_CHECK_VBUS:
+		if (!tcpm_port_is_sink(port))
+			tcpm_set_state(port, SRC_TRYWAIT, PD_T_TRY_CC_DEBOUNCE);
+		else
+			tcpm_set_state(port, SNK_TRY_WAIT_DEBOUNCE_CHECK_VBUS, 0);
+		break;
 	case SNK_TRYWAIT:
 		/* Do nothing, waiting for tCCDebounce */
 		break;
@@ -4139,6 +4143,10 @@ static void _tcpm_pd_vbus_on(struct tcpm_port *port)
 	case SNK_TRYWAIT_DEBOUNCE:
 		/* Do nothing, waiting for Rp */
 		break;
+	case SNK_TRY_WAIT_DEBOUNCE_CHECK_VBUS:
+		if (port->vbus_present && tcpm_port_is_sink(port))
+			tcpm_set_state(port, SNK_ATTACHED, 0);
+		break;
 	case SRC_TRY_WAIT:
 	case SRC_TRY_DEBOUNCE:
 		/* Do nothing, waiting for sink detection */
diff --git a/include/linux/usb/pd.h b/include/linux/usb/pd.h
index 3a805e2ecbc9..63a66dd5d832 100644
--- a/include/linux/usb/pd.h
+++ b/include/linux/usb/pd.h
@@ -484,6 +484,7 @@ static inline unsigned int rdo_max_power(u32 rdo)
 
 #define PD_T_CC_DEBOUNCE	200	/* 100 - 200 ms */
 #define PD_T_PD_DEBOUNCE	20	/* 10 - 20 ms */
+#define PD_T_TRY_CC_DEBOUNCE	15	/* 10 - 20 ms */
 
 #define PD_N_CAPS_COUNT		(PD_T_NO_RESPONSE / PD_T_SEND_SOURCE_CAP)
 #define PD_N_HARD_RESET_COUNT	2
-- 
2.29.2.454.gaff20da3a2-goog

