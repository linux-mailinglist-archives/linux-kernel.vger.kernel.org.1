Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 692C627BB09
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 04:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbgI2ClF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 22:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727448AbgI2Cka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 22:40:30 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CDE3C0613DA
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 19:40:27 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id o13so2007143qtl.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 19:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=geYL3do+xTVE8/5xBG9KqTUqxAZxMfB8i5h+drxS91s=;
        b=MNXv6mxdapkI/cAbRhlOweENvAHctkN2S4tu2C5Le9rEGZSPpQu89YWl3ibBW/3gr8
         Gr+lVmpgdbDwfeDjQWr/kuDt8L/qOl1IYZ2L3vODNL2nzQD7/5hhDaGFAq40ZDhnYEOU
         MCiH11OP1u3JMJJkhQ0fnEY/msMaW+vEg9rqdt6yfDeiEGKBKumLH7WPpPP+EDM9kfck
         VoKUttXJMGBlinY3uAv8DjMsDmFCPdybiTVwAAvngIxlYTEm5lUgikhR29LQXuOM/FXA
         uXr0xW1mGH16YsGhh/2pA/54QxQkW7AlfKT5y+RgSqQKlTPf4VmBlmG1yGq0vHzsONBz
         6UDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=geYL3do+xTVE8/5xBG9KqTUqxAZxMfB8i5h+drxS91s=;
        b=SLrOC7k5PBjOTeu6GKvQ4Q5aHd04JU5T/BCfVaeAezS9Y608qxljOkg7NkXtHPICtt
         /8RgrYOGNyeWq5eDyXMUFUBgqb9n8TSDZhr+DZcD79YM2FMxmsxD8ra+/iRH5nhKoXD6
         F+J3BdasPg/KJ3KhM7vRj7qTUr+wI8Xh6vgigFsZf40BO491kJpCF0S9OufA+wHoozhZ
         UpM+FQMHpiMSnG8RZ3PZu9gTzk959vDqW5qf12nNhSNR0+ODxLJZun50MmxTT4c+Vfu6
         bzxi3HQJEtIMqTQFjFeFvlHed38HKlUIAuqCJx9uWMC6/7o5t+aVoasdcGfKY5JSyLjA
         PDcA==
X-Gm-Message-State: AOAM530NrKFb+BKd7E1S1XoqvjHvP1Ev5F/weQDMlEtRKwifxN8RqO2D
        ztfxpbLl3Hs5s0HpY2zNB7MbAn04Y3M=
X-Google-Smtp-Source: ABdhPJx3D49ck9kIJUWm7qx46AZgBNNkQ1q9iAo72lho2oN/as5Dz4uwSEb2fMvROYM1EdzgoFCB/7/VNQw=
Sender: "badhri via sendgmr" <badhri@badhri.mtv.corp.google.com>
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:1:f292:1cff:fee0:66cf])
 (user=badhri job=sendgmr) by 2002:ad4:408f:: with SMTP id l15mr2606817qvp.4.1601347226533;
 Mon, 28 Sep 2020 19:40:26 -0700 (PDT)
Date:   Mon, 28 Sep 2020 19:39:57 -0700
In-Reply-To: <20200929024004.244992-1-badhri@google.com>
Message-Id: <20200929024004.244992-9-badhri@google.com>
Mime-Version: 1.0
References: <20200929024004.244992-1-badhri@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH v9 08/15] usb: typec: tcpci_maxim: Add support for Sink FRS
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
        linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Upon receiving ALERT_EXTENDED.TCPC_SINK_FAST_ROLE_SWAP signal
tcpm to start Sink fast role swap signal.

Inform when TCPM is sourcing vbus.

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
Changes since v1:
- Changing patch version to v6 to fix version number confusion.

Changes since v6:
- rebase on usb-next
- Added Reviewed-by: Heikki

Changes since v7:
- Rebase on usb-next

Changes since v8:
- None.
---
 drivers/usb/typec/tcpm/tcpci_maxim.c | 50 +++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpci_maxim.c b/drivers/usb/typec/tcpm/tcpci_maxim.c
index 91337ddb4962..723d7dd38f75 100644
--- a/drivers/usb/typec/tcpm/tcpci_maxim.c
+++ b/drivers/usb/typec/tcpm/tcpci_maxim.c
@@ -106,13 +106,22 @@ static void max_tcpci_init_regs(struct max_tcpci_chip *chip)
 		return;
 	}
 
+	ret = max_tcpci_write8(chip, TCPC_ALERT_EXTENDED, 0xff);
+	if (ret < 0) {
+		dev_err(chip->dev, "Unable to clear TCPC_ALERT_EXTENDED ret:%d\n", ret);
+		return;
+	}
+
 	alert_mask = TCPC_ALERT_TX_SUCCESS | TCPC_ALERT_TX_DISCARDED | TCPC_ALERT_TX_FAILED |
 		TCPC_ALERT_RX_HARD_RST | TCPC_ALERT_RX_STATUS | TCPC_ALERT_CC_STATUS |
-		TCPC_ALERT_VBUS_DISCNCT | TCPC_ALERT_RX_BUF_OVF | TCPC_ALERT_POWER_STATUS;
+		TCPC_ALERT_VBUS_DISCNCT | TCPC_ALERT_RX_BUF_OVF | TCPC_ALERT_POWER_STATUS |
+		/* Enable Extended alert for detecting Fast Role Swap Signal */
+		TCPC_ALERT_EXTND;
 
 	ret = max_tcpci_write16(chip, TCPC_ALERT_MASK, alert_mask);
 	if (ret < 0) {
-		dev_err(chip->dev, "Error writing to TCPC_ALERT_MASK ret:%d\n", ret);
+		dev_err(chip->dev,
+			"Error enabling TCPC_ALERT: TCPC_ALERT_MASK write failed ret:%d\n", ret);
 		return;
 	}
 
@@ -122,6 +131,10 @@ static void max_tcpci_init_regs(struct max_tcpci_chip *chip)
 		dev_err(chip->dev, "Error writing to TCPC_POWER_CTRL ret:%d\n", ret);
 		return;
 	}
+
+	ret = max_tcpci_write8(chip, TCPC_ALERT_EXTENDED_MASK, TCPC_SINK_FAST_ROLE_SWAP);
+	if (ret < 0)
+		return;
 }
 
 static void process_rx(struct max_tcpci_chip *chip, u16 status)
@@ -225,10 +238,23 @@ static void process_power_status(struct max_tcpci_chip *chip)
 	if (ret < 0)
 		return;
 
-	if (pwr_status == 0xff)
+	if (pwr_status == 0xff) {
 		max_tcpci_init_regs(chip);
-	else
+	} else if (pwr_status & TCPC_POWER_STATUS_SOURCING_VBUS) {
+		tcpm_sourcing_vbus(chip->port);
+		/*
+		 * Alawys re-enable boost here.
+		 * In normal case, when say an headset is attached, TCPM would
+		 * have instructed to TCPC to enable boost, so the call is a
+		 * no-op.
+		 * But for Fast Role Swap case, Boost turns on autonomously without
+		 * AP intervention, but, needs AP to enable source mode explicitly
+		 * for AP to regain control.
+		 */
+		max_tcpci_set_vbus(chip->tcpci, &chip->data, true, false);
+	} else {
 		tcpm_vbus_change(chip->port);
+	}
 }
 
 static void process_tx(struct max_tcpci_chip *chip, u16 status)
@@ -249,6 +275,7 @@ static irqreturn_t _max_tcpci_irq(struct max_tcpci_chip *chip, u16 status)
 {
 	u16 mask;
 	int ret;
+	u8 reg_status;
 
 	/*
 	 * Clear alert status for everything except RX_STATUS, which shouldn't
@@ -274,6 +301,21 @@ static irqreturn_t _max_tcpci_irq(struct max_tcpci_chip *chip, u16 status)
 		}
 	}
 
+	if (status & TCPC_ALERT_EXTND) {
+		ret = max_tcpci_read8(chip, TCPC_ALERT_EXTENDED, &reg_status);
+		if (ret < 0)
+			return ret;
+
+		ret = max_tcpci_write8(chip, TCPC_ALERT_EXTENDED, reg_status);
+		if (ret < 0)
+			return ret;
+
+		if (reg_status & TCPC_SINK_FAST_ROLE_SWAP) {
+			dev_info(chip->dev, "FRS Signal");
+			tcpm_sink_frs(chip->port);
+		}
+	}
+
 	if (status & TCPC_ALERT_RX_STATUS)
 		process_rx(chip, status);
 
-- 
2.28.0.709.gb0816b6eb0-goog

