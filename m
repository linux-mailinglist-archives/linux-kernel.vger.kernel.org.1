Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCD12CB3C9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 05:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387476AbgLBEJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 23:09:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728260AbgLBEJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 23:09:27 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F89C0617A7
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 20:08:46 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id c8so373868plo.13
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 20:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=GPfieuL579HTKjRrv6lfSduVFxhc0wtLXQ4TT0sB194=;
        b=dj4gGzfiDcgEFxzYQY3LwWLwoiCD62RjZXk0q+xIEnXCCur+xysLFclekp3dQvJJEI
         Gj4KuwQ5hGuaAiwHReHc9G3ho1MFPW1IOfPNHrY+mpR9Do7a/p0z4o/O2fTDBKy4Aps+
         l+5e/s6Fz4oNWkghFlSH+X3rdoS16PPwNxeNGd9yXAQubr0azS2F6po+c/6G1JVgmE0t
         ijgb90dcYGCyzJDP5ydAjBIR77NHOwAmRZr1n7axD/tlJgFgSgczd0JtV4OVI54wafz+
         pikNimaWG+abrFuKlX0+5+M2wmoPRv+/xMBtSPFTodrhuaaFWS0jNDGUqYO24IuYjb8e
         xd1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GPfieuL579HTKjRrv6lfSduVFxhc0wtLXQ4TT0sB194=;
        b=uCnWDFVXpRUMvJQCoRke3Teoor2FbVsNRAJjoP+N8JnlF020CphLMADUF7weYJraqN
         v5eY+TJhMhJHCbrOWKvty4Ie9g4PTAr/OQjPXF0TF6l6kAFUjPINsNrEpQDB/28R2nBI
         Bi2ePvRC19hFhAo69vvBvU+R2dtAplmsI8vnpuyIiiKwC+naPBw1WMeJWPWjT4aNRszc
         gva25/gsNJDFwlUD128YlJVT0RP3N+LNcOKlXSfCzzQxL0+6rkD3X8kCDCuVgCGhTJuX
         zwGfrk4Im4/4Z8CfIslym+Bn0F3EFw5dUu78aC3M98S+OCzNbqME9MfWlw6UuPZKvdg5
         Dsfg==
X-Gm-Message-State: AOAM530M1KijJHcU0qhZBEAagrTY5nbuJB66Eb8JFRmjaq2T8Jr2iWbJ
        xfandhX1uIEVYbzEpovJuql2V1Zyyg4=
X-Google-Smtp-Source: ABdhPJyYAN/geB66mabvtDxw8SO2pfPBcrnnBUNx2umYFUSrt/H4t4nibZaz+NMMR+Bo/Ae6etgZDskN13o=
Sender: "badhri via sendgmr" <badhri@badhri.mtv.corp.google.com>
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:201:f292:1cff:fee0:66cf])
 (user=badhri job=sendgmr) by 2002:a62:cd85:0:b029:18b:36c7:382d with SMTP id
 o127-20020a62cd850000b029018b36c7382dmr751151pfg.14.1606882126140; Tue, 01
 Dec 2020 20:08:46 -0800 (PST)
Date:   Tue,  1 Dec 2020 20:08:39 -0800
In-Reply-To: <20201202040840.663578-1-badhri@google.com>
Message-Id: <20201202040840.663578-2-badhri@google.com>
Mime-Version: 1.0
References: <20201202040840.663578-1-badhri@google.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH v2 2/3] usb: typec: tcpci: Add support to report vSafe0V
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
Changes since v1:
- Removed logic for checking TCPC_POWER_STATUS_MASK reg
  read in the irq handler. Sending that as a separate patch.
---
 drivers/usb/typec/tcpm/tcpci.c | 39 +++++++++++++++++++++++++++++-----
 drivers/usb/typec/tcpm/tcpci.h |  6 ++++++
 2 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
index 12d983a75510..f938d9876ce9 100644
--- a/drivers/usb/typec/tcpm/tcpci.c
+++ b/drivers/usb/typec/tcpm/tcpci.c
@@ -402,6 +402,19 @@ static int tcpci_get_vbus(struct tcpc_dev *tcpc)
 	return !!(reg & TCPC_POWER_STATUS_VBUS_PRES);
 }
 
+static bool tcpci_is_vbus_vsafe0v(struct tcpc_dev *tcpc)
+{
+	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
+	unsigned int reg;
+	int ret;
+
+	ret = regmap_read(tcpci->regmap, TCPC_EXTENDED_STATUS, &reg);
+	if (ret < 0)
+		return false;
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
 
@@ -575,15 +598,12 @@ irqreturn_t tcpci_irq(struct tcpci *tcpci)
 		tcpm_cc_change(tcpci->port);
 
 	if (status & TCPC_ALERT_POWER_STATUS) {
-		unsigned int reg;
-
-		regmap_read(tcpci->regmap, TCPC_POWER_STATUS_MASK, &reg);
-
+		regmap_read(tcpci->regmap, TCPC_POWER_STATUS_MASK, &raw);
 		/*
 		 * If power status mask has been reset, then the TCPC
 		 * has reset.
 		 */
-		if (reg == 0xff)
+		if (raw == 0xff)
 			tcpm_tcpc_reset(tcpci->port);
 		else
 			tcpm_vbus_change(tcpci->port);
@@ -622,6 +642,12 @@ irqreturn_t tcpci_irq(struct tcpci *tcpci)
 		tcpm_pd_receive(tcpci->port, &msg);
 	}
 
+	if (status & TCPC_ALERT_EXTENDED_STATUS) {
+		ret = regmap_read(tcpci->regmap, TCPC_EXTENDED_STATUS, &raw);
+		if (!ret && (raw & TCPC_EXTENDED_STATUS_VSAFE0V))
+			tcpm_vbus_change(tcpci->port);
+	}
+
 	if (status & TCPC_ALERT_RX_HARD_RST)
 		tcpm_pd_hard_reset(tcpci->port);
 
@@ -699,6 +725,9 @@ struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *data)
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
2.29.2.576.ga3fc446d84-goog

