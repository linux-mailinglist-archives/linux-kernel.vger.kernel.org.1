Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89DC9273349
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 21:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbgIUT4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 15:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728274AbgIUT4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 15:56:25 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342F2C061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 12:56:25 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id q2so9414876pfc.17
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 12:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=AWunavfjR2h7DGqJnJiiTrYCviYOJo4UjdEoDLbILJA=;
        b=t+GNICctCeMjWN/pUlO1D6VvqfujACAsEcklfpybyR5nZwW6Sdy0QnYyrhBPaIC5t6
         H14TSCQ9hvaKthS+0J7iv7W3S124LYUJjIn8tSybY1iBuhwhcstsGAGXxx+MKSl2D5rV
         x1qT8rzCzrzUfHdbRpVEMzO2Qsz4WKJ9sZmwktYdUXjte3x4jHDV1Q0DmCa6LCZP+WRU
         R7RJapDAJZCi5xkL+gOGg/vHjK0TzMA/4Ts41bi+x6kJuPbS8cgPiaZYtFuBwKSTQME5
         AJaWthUeIzVlaBTWgTi0277fp+iOysN3yPiFmUvkI2KLp+ByLyegHYOBacsvUPov1VNU
         vNXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AWunavfjR2h7DGqJnJiiTrYCviYOJo4UjdEoDLbILJA=;
        b=ED8HCQ23Cmvbdq1WS6sNp3cT0lpCldRb1QX/tBFb2chVT+7YDDOF0BPFzZcuoLs65Q
         /snH3eqNYFFCfkOIsM1V996eJmgzqAV0f/RgWwXiDaXSrI//jpPd43uhr3SosrHxch78
         Ukb9b/FzF9hO+sDjVj3KnbNuzWWbc8kN9RdJa0AyrcNmEmpsz+8xABON+7/vpul5GthX
         RW3UVM+nktavuYhazzB29XMmRLj2PUoUjFAuINFczEUacEDXjke84B0cqpxe9tqYExUW
         czSXNXbH9uE6AuAy7HaKduYMQcrvn26VFlPmt7jmZhHFdhBVnJuQGc7b13ngp5VVK6B2
         QTcA==
X-Gm-Message-State: AOAM531eeSNLBS9wP5+u9nUdumiiqmXo4+L1ElFavibhYD39/j+TIWUW
        bA3SwcVq4449f/AsAY4mipIg6lOIMxY=
X-Google-Smtp-Source: ABdhPJw68r3Flh7t8b0dWbxHTV0lK3ldYw/oSD30QlZuU6Hf9NnbdqD72KDkJsC1TlfmPRXRzX3WdKSiQew=
Sender: "badhri via sendgmr" <badhri@badhri.mtv.corp.google.com>
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:1:f292:1cff:fee0:66cf])
 (user=badhri job=sendgmr) by 2002:a17:902:d68c:b029:d2:23a6:f6d7 with SMTP id
 v12-20020a170902d68cb02900d223a6f6d7mr1462202ply.45.1600718184724; Mon, 21
 Sep 2020 12:56:24 -0700 (PDT)
Date:   Mon, 21 Sep 2020 12:55:55 -0700
In-Reply-To: <20200921195555.1050731-1-badhri@google.com>
Message-Id: <20200921195555.1050731-11-badhri@google.com>
Mime-Version: 1.0
References: <20200921195555.1050731-1-badhri@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v8 11/11] usb: typec: tcpci_maxim: Implemnent set_auto_vbus_discharge_threshold
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

Programs VBUS_SINK_DISCONNECT_THRESHOLD based on the power_role,
voltage requested as sink, mode of operation.

The programmed threshold is based on vSinkDisconnect and
vSinkDisconnectPD values.

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
Changes since v1:
- Changing patch version to v6 to fix version number confusion.

Changes since v6:
- Rebase on usb-next.

Changes since v7:
- Heikki's suggestion:
Moved the actual write of TCPC_VBUS_SINK_DISCONNECT_THRES
register to tcpci code.
---
 drivers/usb/typec/tcpm/tcpci_maxim.c | 33 ++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpci_maxim.c b/drivers/usb/typec/tcpm/tcpci_maxim.c
index 723d7dd38f75..329138622cc9 100644
--- a/drivers/usb/typec/tcpm/tcpci_maxim.c
+++ b/drivers/usb/typec/tcpm/tcpci_maxim.c
@@ -137,6 +137,37 @@ static void max_tcpci_init_regs(struct max_tcpci_chip *chip)
 		return;
 }
 
+u32 max_tcpci_get_auto_vbus_discharge_threshold(struct tcpci *tcpci, struct tcpci_data *data,
+						enum typec_role port_role,
+						enum typec_pwr_opmode mode, bool pps_active,
+						u32 requested_vbus_voltage_mv)
+{
+	struct max_tcpci_chip *chip = tdata_to_max_tcpci(data);
+	u32 threshold = 0;
+	u8 pwr_ctrl;
+
+	if (port_role == TYPEC_SINK) {
+		max_tcpci_read8(chip, TCPC_POWER_CTRL, &pwr_ctrl);
+		if (pwr_ctrl & TCPC_FAST_ROLE_SWAP_EN) {
+			/* To prevent disconnect when the source is fast role swap is capable. */
+			threshold = 3500;
+		} else if (mode == TYPEC_PWR_MODE_PD) {
+			if (pps_active)
+				threshold = (95 * requested_vbus_voltage_mv / 100) - 850;
+			else
+				threshold = (95 * requested_vbus_voltage_mv / 100) - 1250;
+		} else {
+			/* 3.5V for non-pd sink */
+			threshold = 3500;
+		}
+	} else {
+		/* 4V for source */
+		threshold = 4000;
+	}
+
+	return threshold;
+}
+
 static void process_rx(struct max_tcpci_chip *chip, u16 status)
 {
 	struct pd_message msg;
@@ -441,6 +472,8 @@ static int max_tcpci_probe(struct i2c_client *client, const struct i2c_device_id
 	chip->data.start_drp_toggling = max_tcpci_start_toggling;
 	chip->data.TX_BUF_BYTE_x_hidden = true;
 	chip->data.init = tcpci_init;
+	chip->data.get_auto_vbus_discharge_threshold = max_tcpci_get_auto_vbus_discharge_threshold;
+	chip->data.auto_discharge_disconnect = true;
 
 	max_tcpci_init_regs(chip);
 	chip->tcpci = tcpci_register_port(chip->dev, &chip->data);
-- 
2.28.0.681.g6f77f65b4e-goog

