Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E6F2CCD40
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 04:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729764AbgLCDTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 22:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729751AbgLCDTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 22:19:54 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09ECC061A4E
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 19:19:13 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id 4so368512pla.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 19:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=aVI0c4MQz9foni25ng7Y69WIZ6p+uDOXMFX4qOhpuAk=;
        b=NkIn+mcN47DbJuzIZJhgN3zy20b//ayDYIx0oyuIu3zBT6nac8suDDKbYAarCdyf0H
         1xFhkmpTVt2l+TnGSXI/WMoF0/bjT1wN/3beiAsyE3zke5+XYD1ofDA2G2JQprAX0Iqc
         7vjQnIiEyl1y1pHwUbEoMpfB10adu4kLIBtaejt337VPKwthcQfRdPzA1EaKgWMAxdws
         OANpPljB4DaUsgDh6r7rYFUdkAtD59z0qJcaNsvmbuCryUabecl/GWeomDB8RjkvUDDR
         Q8ti84ucd4GCGrbZ7/YxyaD6q5ZjpUUsJXCzmlB/09TeLXC9JXVbIm5Y0ZrxdV2V4YIk
         Kbug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=aVI0c4MQz9foni25ng7Y69WIZ6p+uDOXMFX4qOhpuAk=;
        b=jOtOCNGMX+joedsKDYwmfTSgL/LH+TnOO0/HWcZTkg4YdKvpxBemp+U1bS3VRkmWxx
         BeXZuIpVBQcRGbCsNq9KNDVEV/ByBXpIZJl6+YfvnikKMJxu+ITMJjgmN4tbexCiVJgl
         2MpwAb3aRyxBKYMU4qY/o1Np15aNkeZeyWPQvWhG1qV73bFima9zluQv9oPG3/1V5Jcg
         o7yRL/prwHjrg50GYRdRwk0wIg2TSp2p6hWx+EAoo5O9rZviOUvwo8aRO1FmAIq8cK5n
         QKZSIROMLPbet7MGMTuSZYCxezj+WeKnIiFYzK/YN7tajez8IsHqclqJocQlWCMvr2YH
         KYQw==
X-Gm-Message-State: AOAM531mNnF7R9awbNkC9Zmhy/EAu+7KXr7k6oKhLMSc6mGSemdDwVte
        uilAFO49FSCrRa/BdcqB7PaYIODmiIo=
X-Google-Smtp-Source: ABdhPJyCB+n+29Ka48OvL7Dlkk6mk0yvvRNkd4HPOkHoIfQddlG0SnGo96HmGHmyQtG3VIOsmZGDoF0Rimg=
Sender: "badhri via sendgmr" <badhri@badhri.mtv.corp.google.com>
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:201:f292:1cff:fee0:66cf])
 (user=badhri job=sendgmr) by 2002:a17:90a:460a:: with SMTP id
 w10mr500462pjg.1.1606965552918; Wed, 02 Dec 2020 19:19:12 -0800 (PST)
Date:   Wed,  2 Dec 2020 19:19:08 -0800
Message-Id: <20201203031908.1491542-1-badhri@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH v1] usb: typec: tcpm: Clear send_discover in tcpm_check_send_discover
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

tcpm_check_send_discover does not clear the send_discover flag
when any of the following conditions are not met.
1. data_role is TYPEC_HOST
2. link is pd_capable

Discovery indentity would anyways not be attempted during
the current session anymore when the above conditions are not
met. Hence clear the send_discover flag here to prevent
tcpm_enable_frs_work from rescheduling indefinetly.

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 3bbc1f10af49..012135ade7b1 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -3035,10 +3035,9 @@ static inline enum tcpm_state unattached_state(struct tcpm_port *port)
 static void tcpm_check_send_discover(struct tcpm_port *port)
 {
 	if (port->data_role == TYPEC_HOST && port->send_discover &&
-	    port->pd_capable) {
+	    port->pd_capable)
 		tcpm_send_vdm(port, USB_SID_PD, CMD_DISCOVER_IDENT, NULL, 0);
-		port->send_discover = false;
-	}
+	port->send_discover = false;
 }
 
 static void tcpm_swap_complete(struct tcpm_port *port, int result)
-- 
2.29.2.576.ga3fc446d84-goog

