Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 706922C94B3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 02:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731225AbgLABdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 20:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731118AbgLABdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 20:33:35 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5526C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 17:32:54 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id z3so510400ybc.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 17:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=luAMirKoJYalsuVhjtemmSEQvYQcvAW4IlIYXWdu+v4=;
        b=v97sVUC1aNXg1H56zuiHW0CwftWHHHRjK4dpvsipbKlzj9fqmu+ZZw0N2vXsfVTWmQ
         xtSu8HlqWRYfanPdrlfWCpZPJZ15fZywIYQFy9k/0jvRXz/4jYBFsArVSZeVd1bp8b5Z
         mudqhkNXnt+bdEgWeEV02omxZR1OVMlTVeVYDHDvpeDQy36PgQw4JY7kiEimhGYY/qvr
         AVE3s5IT+kV5CeSViJn0cxQusWpdMRshrMJXXZYfo8XA40CDwR66yU5+O7wgaI8aeULY
         1uGdNLLovwEz/qsf4r7qIqMF0SWy0/irBjlZN4Lq3f59IPUmSw9TIV71iV75x7hdOMoX
         8gAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=luAMirKoJYalsuVhjtemmSEQvYQcvAW4IlIYXWdu+v4=;
        b=mqV5lyIDS9cwvyqStpG5dst+sdTB01f7axU5M5nxPVwnYKF5bxRMMMKngJ9i3sCc+G
         HGFsXpXSbVx0Q0DEVJheN9k/oRtUqC5gv953On+5EPakdym1DdV4+gqYojwZVg2gqVCK
         ub8IGJzSXZ3uun4YOml9nkISAz0GOEBnjeFaum51HRpvA6jd62MB5fnp83ZKa5nEv8NH
         7rd3R4uJkjjX/LkvOJt63bCWOWmdC+uv/LFhwV9I6VC3TQg3kBMfpM+CS2S6V+Yujs+g
         VLfpfVQcV2uhXsxw6EDKokbW0RhVTwSyWLdipIL0MOmV7k9PZ6Pzlko+IGDtLpVO6DyG
         iBrg==
X-Gm-Message-State: AOAM531TSD1DxV6lS9R5si+vIrryrflj04vqx81kedIt4JfHZwTWeJvx
        4SZ69x+um6lIttjSEdH5xUNGwsTaVzo=
X-Google-Smtp-Source: ABdhPJxRq76JNsioT9qhQtE6gOclW1Ojx17Kl991aKFZGQLLHnA47UxluzIxNPnRXoH6Owd0I52xXnsqu4U=
Sender: "badhri via sendgmr" <badhri@badhri.mtv.corp.google.com>
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:201:f292:1cff:fee0:66cf])
 (user=badhri job=sendgmr) by 2002:a25:11c2:: with SMTP id 185mr396896ybr.410.1606786373958;
 Mon, 30 Nov 2020 17:32:53 -0800 (PST)
Date:   Mon, 30 Nov 2020 17:32:45 -0800
In-Reply-To: <20201201013246.32034-1-badhri@google.com>
Message-Id: <20201201013246.32034-2-badhri@google.com>
Mime-Version: 1.0
References: <20201201013246.32034-1-badhri@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v1 2/3] usb: typec: tcpci: Add support to report vSafe0V
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

This change adds vbus_vsafe0v which when set, makes TCPM
query for VSAFE0V by assigning the tcpc.is_vbus_vsafe0v callback.
Also enables ALERT.ExtendedStatus which is triggered when
status of EXTENDED_STATUS.vSafe0V changes.
EXTENDED_STATUS.vSafe0V is set when vbus is at vSafe0V and
cleared otherwise.

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
 drivers/usb/typec/tcpm/tcpci.c | 55 ++++++++++++++++++++++++++--------
 drivers/usb/typec/tcpm/tcpci.h |  6 ++++
 2 files changed, 49 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
index 12d983a75510..e281b8bee4db 100644
--- a/drivers/usb/typec/tcpm/tcpci.c
+++ b/drivers/usb/typec/tcpm/tcpci.c
@@ -402,6 +402,19 @@ static int tcpci_get_vbus(struct tcpc_dev *tcpc)
 	return !!(reg & TCPC_POWER_STATUS_VBUS_PRES);
 }
 
+static int tcpci_is_vbus_vsafe0v(struct tcpc_dev *tcpc)
+{
+	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
+	unsigned int reg;
+	int ret;
+
+	ret = regmap_read(tcpci->regmap, TCPC_EXTENDED_STATUS, &reg);
+	if (ret < 0)
+		return ret;
+
+	return !!(reg & TCPC_EXTENDED_STATUS_VSAFE0V);
+}
+
 static int tcpci_set_vbus(struct tcpc_dev *tcpc, bool source, bool sink)
 {
 	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
@@ -554,12 +567,22 @@ static int tcpci_init(struct tcpc_dev *tcpc)
 		TCPC_ALERT_RX_HARD_RST | TCPC_ALERT_CC_STATUS;
 	if (tcpci->controls_vbus)
 		reg |= TCPC_ALERT_POWER_STATUS;
+	/* Enable VSAFE0V status interrupt when detecting VSAFE0V is supported */
+	if (tcpci->data->vbus_vsafe0v) {
+		reg |= TCPC_ALERT_EXTENDED_STATUS;
+		ret = regmap_write(tcpci->regmap, TCPC_EXTENDED_STATUS_MASK,
+				   TCPC_EXTENDED_STATUS_VSAFE0V);
+		if (ret < 0)
+			return ret;
+	}
 	return tcpci_write16(tcpci, TCPC_ALERT_MASK, reg);
 }
 
 irqreturn_t tcpci_irq(struct tcpci *tcpci)
 {
 	u16 status;
+	int ret;
+	unsigned int raw;
 
 	tcpci_read16(tcpci, TCPC_ALERT, &status);
 
@@ -575,18 +598,17 @@ irqreturn_t tcpci_irq(struct tcpci *tcpci)
 		tcpm_cc_change(tcpci->port);
 
 	if (status & TCPC_ALERT_POWER_STATUS) {
-		unsigned int reg;
-
-		regmap_read(tcpci->regmap, TCPC_POWER_STATUS_MASK, &reg);
-
-		/*
-		 * If power status mask has been reset, then the TCPC
-		 * has reset.
-		 */
-		if (reg == 0xff)
-			tcpm_tcpc_reset(tcpci->port);
-		else
-			tcpm_vbus_change(tcpci->port);
+		ret = regmap_read(tcpci->regmap, TCPC_POWER_STATUS_MASK, &raw);
+		if (ret >= 0) {
+			/*
+			 * If power status mask has been reset, then the TCPC
+			 * has reset.
+			 */
+			if (raw == 0xff)
+				tcpm_tcpc_reset(tcpci->port);
+			else
+				tcpm_vbus_change(tcpci->port);
+		}
 	}
 
 	if (status & TCPC_ALERT_RX_STATUS) {
@@ -622,6 +644,12 @@ irqreturn_t tcpci_irq(struct tcpci *tcpci)
 		tcpm_pd_receive(tcpci->port, &msg);
 	}
 
+	if (status & TCPC_ALERT_EXTENDED_STATUS) {
+		ret = regmap_read(tcpci->regmap, TCPC_EXTENDED_STATUS, &raw);
+		if (ret >= 0 && (raw & TCPC_EXTENDED_STATUS_VSAFE0V))
+			tcpm_vbus_change(tcpci->port);
+	}
+
 	if (status & TCPC_ALERT_RX_HARD_RST)
 		tcpm_pd_hard_reset(tcpci->port);
 
@@ -699,6 +727,9 @@ struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *data)
 			tcpci_set_auto_vbus_discharge_threshold;
 	}
 
+	if (tcpci->data->vbus_vsafe0v)
+		tcpci->tcpc.is_vbus_vsafe0v = tcpci_is_vbus_vsafe0v;
+
 	err = tcpci_parse_config(tcpci);
 	if (err < 0)
 		return ERR_PTR(err);
diff --git a/drivers/usb/typec/tcpm/tcpci.h b/drivers/usb/typec/tcpm/tcpci.h
index 3fe313655f0c..116a69c85e38 100644
--- a/drivers/usb/typec/tcpm/tcpci.h
+++ b/drivers/usb/typec/tcpm/tcpci.h
@@ -49,6 +49,9 @@
 #define TCPC_TCPC_CTRL_ORIENTATION	BIT(0)
 #define TCPC_TCPC_CTRL_BIST_TM		BIT(1)
 
+#define TCPC_EXTENDED_STATUS		0x20
+#define TCPC_EXTENDED_STATUS_VSAFE0V	BIT(0)
+
 #define TCPC_ROLE_CTRL			0x1a
 #define TCPC_ROLE_CTRL_DRP		BIT(6)
 #define TCPC_ROLE_CTRL_RP_VAL_SHIFT	4
@@ -155,11 +158,14 @@ struct tcpci;
  *		is sourcing vbus.
  * @auto_discharge_disconnect:
  *		Optional; Enables TCPC to autonously discharge vbus on disconnect.
+ * @vbus_vsafe0v:
+ *		optional; Set when TCPC can detect whether vbus is at VSAFE0V.
  */
 struct tcpci_data {
 	struct regmap *regmap;
 	unsigned char TX_BUF_BYTE_x_hidden:1;
 	unsigned char auto_discharge_disconnect:1;
+	unsigned char vbus_vsafe0v:1;
 
 	int (*init)(struct tcpci *tcpci, struct tcpci_data *data);
 	int (*set_vconn)(struct tcpci *tcpci, struct tcpci_data *data,
-- 
2.29.2.454.gaff20da3a2-goog

