Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30EA3286E8A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 08:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbgJHGQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 02:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728724AbgJHGQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 02:16:25 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8193C0613D8
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 23:16:19 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id b2so2827872plx.7
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 23:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=JGnbDdcxJxj3se75rgmrjhN39DHldDWoTPiiMZNtj7E=;
        b=nAVkaEcnDmhVbSpWNYTTx5pXdK06HUScBVwcpxTI232E63s1kszyjkbCWJLMlXqJe3
         0vPZZdSd4tde7l696itSjzsbv2L2VXb3yT5MYjlGAq3rGWBJn/G0EPEeb0NCnDU7XX+N
         QjygauJUQFTf69p5AbYmSjtXBI47Pl1nSNPEGwTsnnl4XDznAG/z7b4fg1NL19IPUzjw
         u5NSLAkKpgF0KwjNPLhUlfxYPZT8vDOMRSGGIiKbLeCgBmApuUuYH8mdFdcHArBrtGRR
         a3dguMsZWwbthsBDveFuafcOxnEPbjmc43vFKrqP1JzcNEKIL1TbM+5LSwigAZjglsSu
         KkcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JGnbDdcxJxj3se75rgmrjhN39DHldDWoTPiiMZNtj7E=;
        b=tTSjO3BC4SRWiqJLBq3N4wfMxZRKzFTfvD+YewfqftwXfe0uEyk1mJrjv9ziN5omPV
         upOrO+PQMsOOO8dx7ANfOUQJhxlb+Xsg6UGRQGBnUsXvkYGLTm0V0hvMJaDeW3jzNR1H
         Yqtyhi9iA1xi9cNvY/Ky8jR3xljP+pNekFLsJHs9+0R+5Hx4Rxgk9CyjnsK2e42SEYVL
         aWEqQwuEpwgw8nQTrsu/72xpgJchRsz5QFFEWSeyfTkugRG0UUj5D4ThdqqcKRphavA2
         s4FlB/KSDAKJSZqr7Hq+GufXLyA7cRAK3L1ACb57NmxUIC4Hfg6AJzn3KztCxcjttQPX
         f13g==
X-Gm-Message-State: AOAM53384sDm24j4nmrNd9LrKE4Z2wI9dI68Vwg83j9pt15bEDY7/TP8
        xNH/aEMOfNJcdmJGKGSER34jXOt0S2s=
X-Google-Smtp-Source: ABdhPJwwOAXPiSstHERTXmDe5W6qA8MIBrre2VpOrw4LQzT/B2TmkkuLJltxEt45kH3aGKmVuzaOyDLKN7Q=
Sender: "badhri via sendgmr" <badhri@badhri.mtv.corp.google.com>
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:1:f292:1cff:fee0:66cf])
 (user=badhri job=sendgmr) by 2002:a63:f04c:: with SMTP id s12mr6027108pgj.425.1602137779013;
 Wed, 07 Oct 2020 23:16:19 -0700 (PDT)
Date:   Wed,  7 Oct 2020 23:15:49 -0700
In-Reply-To: <20201008061556.1402293-1-badhri@google.com>
Message-Id: <20201008061556.1402293-9-badhri@google.com>
Mime-Version: 1.0
References: <20201008061556.1402293-1-badhri@google.com>
X-Mailer: git-send-email 2.28.0.806.g8561365e88-goog
Subject: [PATCH v10 08/15] usb: typec: tcpci_maxim: Add support for Sink FRS
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

Changes since v9:
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
2.28.0.806.g8561365e88-goog

