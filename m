Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF0822D70BF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 08:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436807AbgLKHUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 02:20:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436799AbgLKHTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 02:19:55 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789E2C0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 23:19:15 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id v9so5872345qtw.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 23:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=m0DrwSxF5qR9n1iY7YgNaOh8SW09GUyz6Ol3J+mXr+U=;
        b=rtJ0RIZTlwQdQWlSPxuR3vOa5DfGSmbjmTZcnqckvebY6+WfCZ28FM95LkWIcA5Aaa
         950sW7+R45o33bmOBbsJgqO4sxOT/7S3YrKoD+UUL8kz0J/jgNwd0wJI8UZcl9RJ2ID4
         nXRNSY6adSUV3NiysAv+DAuGWrzsHymlYt4OFKxWcgeAxLXSpVGPNXRF1cbNybigF1NO
         2LKcreA78JhdpHN30Wl/spIwxHl7Kh7FuBnFdZ7b41k3UVj1D+RMiPmWck+iIOwKEWuL
         NnKp1XBcOEDmn5FZQ09tEECmisEOBjhPu13vjGfkHCEYExZ1CLMr8eMYV1e6nnP3BbDN
         9+Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=m0DrwSxF5qR9n1iY7YgNaOh8SW09GUyz6Ol3J+mXr+U=;
        b=BolFtX5/3crNrTuri1QdkZc5+V66wb9Yb+sw79OlzTMEIPh2U4zwTGmgyml1N4xeCJ
         1nAuj6Y1upqyQG+yMPz8ldbD4G8WtkZ1Fzd/MWyN0KvirHgVvAJJ8b2Rv+Da9q68QrqO
         F8tGjdVxLqESmEpl3Nxb2u+dlsPtP92XEH2qgr7LKfFTFWXrSXP6C4sf+aqHsPD1jQip
         r1lke7ORx5LVrEIwosx7Syp73GL3OkKb5okelLbFZcPOKpIeghwDh9y7SyoirQAeZhmS
         WnBz8L/86M2UXT9us2BOu7GMFy9pNE9Q1d9B781vF/J3sv2uR5NL1UWHkroKI6V6Y8/a
         i0PA==
X-Gm-Message-State: AOAM5334eU79sPUrGmJX+h0HaQirJfpDx+1reAGHQ0+VhwEUoAJeYctD
        FtDRVaLdVTRwIsYXjRiU4HQFsXIfbqc=
X-Google-Smtp-Source: ABdhPJxtyOsdLpo5DZhFrT/IRN9ptqe8Bwz63ouNOM1Twwi41wODcjPrjRdDdkVhC2OtsFMQDSEWR02EHGI=
Sender: "badhri via sendgmr" <badhri@badhri.mtv.corp.google.com>
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:201:f292:1cff:fee0:66cf])
 (user=badhri job=sendgmr) by 2002:a0c:c405:: with SMTP id r5mr14548293qvi.4.1607671154568;
 Thu, 10 Dec 2020 23:19:14 -0800 (PST)
Date:   Thu, 10 Dec 2020 23:19:11 -0800
Message-Id: <20201211071911.2205197-1-badhri@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH v1] usb: typec: tcpm: Update vbus_vsafe0v on init
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

During init, vbus_vsafe0v does not get updated till the first
connect as a sink. This causes TCPM to be stuck in SRC_ATTACH_WAIT
state while booting with a sink (For instance: a headset) connected.

[    1.429168] Start toggling
[    1.439907] CC1: 0 -> 0, CC2: 0 -> 0 [state TOGGLING, polarity 0, disconnected]
[    1.445242] CC1: 0 -> 0, CC2: 0 -> 0 [state TOGGLING, polarity 0, disconnected]
[   53.358528] CC1: 0 -> 0, CC2: 0 -> 2 [state TOGGLING, polarity 0, connected]
[   53.358564] state change TOGGLING -> SRC_ATTACH_WAIT [rev1 NONE_AMS]

Fix this by updating vbus_vsafe0v based on vbus_present status
on boot.

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index cedc6cf82d61..58a6302c549f 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -4794,6 +4794,24 @@ static void tcpm_init(struct tcpm_port *port)
 	if (port->vbus_present)
 		port->vbus_never_low = true;
 
+	/*
+	 * 1. When vbus_present is true, voltage on VBUS is already at VSAFE5V.
+	 * So implicitly vbus_vsafe0v = false.
+	 *
+	 * 2. When vbus_present is false and TCPC does NOT support querying
+	 * vsafe0v status, then, it's best to assume vbus is at VSAFE0V i.e.
+	 * vbus_vsafe0v is true.
+	 *
+	 * 3. When vbus_present is false and TCPC does support querying vsafe0v,
+	 * then, query tcpc for vsafe0v status.
+	 */
+	if (port->vbus_present)
+		port->vbus_vsafe0v = false;
+	else if (!port->tcpc->is_vbus_vsafe0v)
+		port->vbus_vsafe0v = true;
+	else
+		port->vbus_vsafe0v = port->tcpc->is_vbus_vsafe0v(port->tcpc);
+
 	tcpm_set_state(port, tcpm_default_state(port), 0);
 
 	if (port->tcpc->get_cc(port->tcpc, &cc1, &cc2) == 0)
-- 
2.29.2.576.ga3fc446d84-goog

