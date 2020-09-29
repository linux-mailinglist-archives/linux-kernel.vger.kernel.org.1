Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B553E27BAF4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 04:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbgI2Ckf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 22:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727441AbgI2Ckd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 22:40:33 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DC9C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 19:40:33 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id l1so1777941qvr.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 19:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=DpYrlP24J5CraOwXQAn3+QVtbA7BAicUcylVOWBiG/8=;
        b=C5nCbrsWxtTuWbXYuTpsL6KGmbedWMp+NCjbUYcahBkficKt+LeeiDHhT2z9jqt1as
         QR/GR2FgXDOar8a0JGLeuUykKz70MKJMagoqrlpH46GLyD0I86UI6Odt36010gmtKveE
         tsFbJ06AYOsk9jCUR/KGW9uChhSDNqw0LKzo6xnrSrYb23v2xo21SAg89kljDgXkFPtc
         N9SqoiCP2It2NVICjdX2ORRSj2n7dIvwiGXeQhOg3Bw3nkqmTXDhjHXSPlFHp34z/IvI
         64yd4BGNhMo1KKheEFJFIFFkio4UduKbZ5BtGpai9L51fVPm6tj9dOz6l5yfUg9FKXgg
         QnCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DpYrlP24J5CraOwXQAn3+QVtbA7BAicUcylVOWBiG/8=;
        b=MKJAm6aSqHxN0xe6umnOYLqnVMcZHz/PeimJsY57XIYlRhj46EhLfm2TYHt/wbp8wd
         Tgh4ML7YO5F8nxMKvPNvpssAb7f3Kzhtm6PDvkE9ik1db2XoerRnHVG5xSv/KAnDs0J1
         vBJ9xsJQ8UoDHJiHuCmFNbf3S/0Mlf6CHAoXDt4c8mHXe1MiNUWm7iSDal9ST4PE56Ly
         NX+kSZCJnsx+uRdGOsRGfg5iD9NnlwFpFv5dGAC5wHegfgc+BDFqGc1bdEXg91CT5Viu
         wYSAE3x01eB9q/IS5Qb4yovs1aJR6nMJ+lbVB+wetWp54R5mPh2bjLt6KaTH0Wfb7FJN
         tDpA==
X-Gm-Message-State: AOAM530fI4OskA3tCr1BGKz1BHzQRaGFDGJJ9YJPmA4TNHrq5ShW1yV5
        pP4f9uVrVORcYEhPrK41yFxPNSBCBTw=
X-Google-Smtp-Source: ABdhPJwyCSrYbt5uFqV2H0HZtZabMENM/4+pRH39aLKtpAzQok9AOR3sONJfhU94qP0BEFSzs+VElXyBoqE=
Sender: "badhri via sendgmr" <badhri@badhri.mtv.corp.google.com>
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:1:f292:1cff:fee0:66cf])
 (user=badhri job=sendgmr) by 2002:a0c:b409:: with SMTP id u9mr2527426qve.9.1601347232286;
 Mon, 28 Sep 2020 19:40:32 -0700 (PDT)
Date:   Mon, 28 Sep 2020 19:40:00 -0700
In-Reply-To: <20200929024004.244992-1-badhri@google.com>
Message-Id: <20200929024004.244992-12-badhri@google.com>
Mime-Version: 1.0
References: <20200929024004.244992-1-badhri@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH v9 11/15] usb: typec: tcpci_max77759: Fix vbus stuck on upon
 diconnecting sink
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

Occasionally, POWER_STATUS.sourcing_vbus takes a while to clear after
writing to  MAX_BUCK_BOOST_OP register. This causes vbus to turn back
on while disconnecting the sink. Overcome this issue by writing into
MAX_BUCK_BOOST_OP during frs while sourcing vbu, instead of always
into the register whenever POWER_STATUS.sourcing_vbus is set.

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
v9 is the first version of this patch. Added to fix
occasional bug of vbus turning back on when disconnecting the FRS accessory
after disconnect.
---
 drivers/usb/typec/tcpm/tcpci_maxim.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpci_maxim.c b/drivers/usb/typec/tcpm/tcpci_maxim.c
index 723d7dd38f75..43dcad95e897 100644
--- a/drivers/usb/typec/tcpm/tcpci_maxim.c
+++ b/drivers/usb/typec/tcpm/tcpci_maxim.c
@@ -238,23 +238,22 @@ static void process_power_status(struct max_tcpci_chip *chip)
 	if (ret < 0)
 		return;
 
-	if (pwr_status == 0xff) {
+	if (pwr_status == 0xff)
 		max_tcpci_init_regs(chip);
-	} else if (pwr_status & TCPC_POWER_STATUS_SOURCING_VBUS) {
+	else if (pwr_status & TCPC_POWER_STATUS_SOURCING_VBUS)
 		tcpm_sourcing_vbus(chip->port);
-		/*
-		 * Alawys re-enable boost here.
-		 * In normal case, when say an headset is attached, TCPM would
-		 * have instructed to TCPC to enable boost, so the call is a
-		 * no-op.
-		 * But for Fast Role Swap case, Boost turns on autonomously without
-		 * AP intervention, but, needs AP to enable source mode explicitly
-		 * for AP to regain control.
-		 */
-		max_tcpci_set_vbus(chip->tcpci, &chip->data, true, false);
-	} else {
+	else
 		tcpm_vbus_change(chip->port);
-	}
+}
+
+static void max_tcpci_frs_sourcing_vbus(struct tcpci *tcpci, struct tcpci_data *tdata)
+{
+	/*
+	 * For Fast Role Swap case, Boost turns on autonomously without
+	 * AP intervention, but, needs AP to enable source mode explicitly
+	 * for AP to regain control.
+	 */
+	max_tcpci_set_vbus(tcpci, tdata, true, false);
 }
 
 static void process_tx(struct max_tcpci_chip *chip, u16 status)
@@ -441,6 +440,7 @@ static int max_tcpci_probe(struct i2c_client *client, const struct i2c_device_id
 	chip->data.start_drp_toggling = max_tcpci_start_toggling;
 	chip->data.TX_BUF_BYTE_x_hidden = true;
 	chip->data.init = tcpci_init;
+	chip->data.frs_sourcing_vbus = max_tcpci_frs_sourcing_vbus;
 
 	max_tcpci_init_regs(chip);
 	chip->tcpci = tcpci_register_port(chip->dev, &chip->data);
-- 
2.28.0.709.gb0816b6eb0-goog

