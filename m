Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE451242426
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Aug 2020 04:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgHLCvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Aug 2020 22:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbgHLCva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 22:51:30 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA034C061787
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 19:51:30 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id q18so546099qkq.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 19:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=HImBaAs0uc45OqtAJgZ8+ISMmBV9I7FItZjw+fSeCgo=;
        b=G1n4xgpC9EfQKBRZfi0+3DN1iWPjo1Zuv1zvNLudk+pDViLirw7hQVaoPSBG8DtB5I
         /kQWvXh6cGlZKQhD5KWxYFDplwN6NL8cDg1N09lOF/Olp3RKpDtoavBzaZTebtTMpUtt
         pGYktLk6zgyL1yQ7T87fxpBXhJgblRg0VJBjqaNz8eYROIT/g1p2w5r4EX7XA786aO+e
         +xEmBJEbyAe9kNrMo2MR6GEgajcLd9uPtRdpPurqTLGADOIn730CV4nKRm+b0WlMrvuQ
         6WMVwBJ6f0T0DF76kR1rD1jIQ2d3YYD5DXRFeFgSW/J1VNbefwLikirKoBISYMijLOSp
         jbsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=HImBaAs0uc45OqtAJgZ8+ISMmBV9I7FItZjw+fSeCgo=;
        b=Dst9+IV/eJoO/3sqM02yZESuIQxpyElFFbGqNI/nJqOaavN3ErT1cjDQZJCayjL835
         FMbx8pToOGIvXAh5VjWEi5pnnRtGLQHfMDo8PrA9dqDjBarUpMEBKhJ0cdkrv5eZUAVS
         QUO/+mlNnfHBPVU8N6+DNRUSrrotCde3Pk4bZ1ApusJXwmsllMTJzfd+b9Nhw2/TOzt6
         I5x1zJIGwZ7bd3XwjnwJ1nq9sWuCf0r+HwV/xq7PbYg2MMad8fEf8ZVj/IZ39K3EQrEO
         suZtCrm0XIm0WPV6o6eQvki+LiiUuaJfhgS37wLmBuqnTVg4GQj0uTUfDQiNhF+kEZdA
         QE1g==
X-Gm-Message-State: AOAM532aVmTsTihMrNY4/vKO0l4pyUT3NjnUpuIHtAuabyBqoFapra+8
        vbxe6DHxsqOBbdrFo4duPpq1YZVWDmo=
X-Google-Smtp-Source: ABdhPJyBpLfxQ5F41wghm9T9k6xYgeHM8BywD2CKeOutLUjVlWTuCK/1lKNzDVZMon06LiXqaR43N6vVWQo=
X-Received: by 2002:a05:6214:3e8:: with SMTP id cf8mr4577952qvb.74.1597200689437;
 Tue, 11 Aug 2020 19:51:29 -0700 (PDT)
Date:   Tue, 11 Aug 2020 19:51:26 -0700
Message-Id: <20200812025126.574519-1-badhri@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
Subject: [PATCH v3] usb: typec: tcpm: Fix TDA 2.2.1.1 and TDA 2.2.1.2 failures
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Badhri Jagan Sridharan <badhri@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From the spec:
"7.1.5 Response to Hard Resets
Hard Reset Signaling indicates a communication failure has occurred and
the Source Shall stop driving VCONN, Shall remove Rp from the VCONN pin
and Shall drive VBUS to vSafe0V as shown in Figure 7-9. The USB connection
May reset during a Hard Reset since the VBUS voltage will be less than
vSafe5V for an extended period of time. After establishing the vSafe0V
voltage condition on VBUS, the Source Shall wait tSrcRecover before
re-applying VCONN and restoring VBUS to vSafe5V. A Source Shall conform
to the VCONN timing as specified in [USB Type-C 1.3]."

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
Changes since V1 (Guenter's suggestion):
- Bound SRC_HARD_RESET_VBUS_ON to accommodate tcpc drivers which doesn't
  update the vbus status.

Changes since V2:
- Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/usb/typec/tcpm/tcpm.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 3ef37202ee37..a48e3f90d196 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -3372,13 +3372,31 @@ static void run_state_machine(struct tcpm_port *port)
 			tcpm_set_state(port, SNK_HARD_RESET_SINK_OFF, 0);
 		break;
 	case SRC_HARD_RESET_VBUS_OFF:
-		tcpm_set_vconn(port, true);
+		/*
+		 * 7.1.5 Response to Hard Resets
+		 * Hard Reset Signaling indicates a communication failure has occurred and the
+		 * Source Shall stop driving VCONN, Shall remove Rp from the VCONN pin and Shall
+		 * drive VBUS to vSafe0V as shown in Figure 7-9.
+		 */
+		tcpm_set_vconn(port, false);
 		tcpm_set_vbus(port, false);
 		tcpm_set_roles(port, port->self_powered, TYPEC_SOURCE,
 			       tcpm_data_role_for_source(port));
-		tcpm_set_state(port, SRC_HARD_RESET_VBUS_ON, PD_T_SRC_RECOVER);
+		/*
+		 * If tcpc fails to notify vbus off, TCPM will wait for PD_T_SAFE_0V +
+		 * PD_T_SRC_RECOVER before turning vbus back on.
+		 * From Table 7-12 Sequence Description for a Source Initiated Hard Reset:
+		 * 4. Policy Engine waits tPSHardReset after sending Hard Reset Signaling and then
+		 * tells the Device Policy Manager to instruct the power supply to perform a
+		 * Hard Reset. The transition to vSafe0V Shall occur within tSafe0V (t2).
+		 * 5. After tSrcRecover the Source applies power to VBUS in an attempt to
+		 * re-establish communication with the Sink and resume USB Default Operation.
+		 * The transition to vSafe5V Shall occur within tSrcTurnOn(t4).
+		 */
+		tcpm_set_state(port, SRC_HARD_RESET_VBUS_ON, PD_T_SAFE_0V + PD_T_SRC_RECOVER);
 		break;
 	case SRC_HARD_RESET_VBUS_ON:
+		tcpm_set_vconn(port, true);
 		tcpm_set_vbus(port, true);
 		port->tcpc->set_pd_rx(port->tcpc, true);
 		tcpm_set_attached_state(port, true);
@@ -3944,7 +3962,11 @@ static void _tcpm_pd_vbus_off(struct tcpm_port *port)
 		tcpm_set_state(port, SNK_HARD_RESET_WAIT_VBUS, 0);
 		break;
 	case SRC_HARD_RESET_VBUS_OFF:
-		tcpm_set_state(port, SRC_HARD_RESET_VBUS_ON, 0);
+		/*
+		 * After establishing the vSafe0V voltage condition on VBUS, the Source Shall wait
+		 * tSrcRecover before re-applying VCONN and restoring VBUS to vSafe5V.
+		 */
+		tcpm_set_state(port, SRC_HARD_RESET_VBUS_ON, PD_T_SRC_RECOVER);
 		break;
 	case HARD_RESET_SEND:
 		break;
-- 
2.28.0.236.gb10cc79966-goog

