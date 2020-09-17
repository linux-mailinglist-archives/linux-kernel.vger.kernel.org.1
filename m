Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7DBA26D8CC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 12:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbgIQKWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 06:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgIQKTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 06:19:54 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12664C061221
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 03:19:21 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id 10so1037211ple.19
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 03:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=rSelLwuthAAPkVKKgQOggAPjlAjJFhRrpVlRLEhgpkQ=;
        b=dsLchTaK8f1sFrPHXB+GhZQnVdLDUqIvh/GnHAm9AHDuFCi5tG5Qtr+z7BMqWoeBdX
         4xBaoylerz06RpcPDBdxm5d5K/Y0rCwUB08U2bRxTMAL81gseH0pAjFHaR8Cr1VvQfQD
         /OnjrnF12o3IGY9+WQklpxvgJJUbGVWZNz4VtE1Thwzy+6WBuz3kZHmQM39zKQvXxXmY
         MYaABkdhEfX6FqMmCkGtyF1kX1D5syy9Dcxfqrf3iZ+cMQuo04QP8PCrPzI1yQAlcW0s
         ovimQSqkpX+/oyApf2SC6kEnT6VDr+udR3ICBEL0RMthCDQDulHazoFTyd0SefCA5FSL
         mJJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rSelLwuthAAPkVKKgQOggAPjlAjJFhRrpVlRLEhgpkQ=;
        b=ntQcAkbqr7XFmyqgnmJhLzKDMOICLlqc8LAviJgvxtwolHZqFMGadbpFEHeSVUpDSH
         zw3uC6hEUSdvmwJnRUjnrEvSyGyhlf9++8rMg8UScfSxZAprkO3EriI3ysjaPPKC/foU
         UWwtGb5x+oV6Zxqo+Dom75aDdLi2M26grk3KqU0xyjfdD29tSjtq5eeUjqIa04kdw+TY
         lsrKDDb/Q9QdsJFKzKT5OcYmRKsshLM1tANzUzpC59PmWD2i0Yyij9i4oQuaE8DcUv6O
         b35Xe/YsWVQhy0KUswPzdD9DI3ut0c0NVoJ62TjYpTOPD/62DvjqQtdqnPDpWZDsXwMX
         ADDA==
X-Gm-Message-State: AOAM531mlGilz8+xHjGtIjyN6FKlnAl6SP5UivMQqJH3PZAGbaSZRLeJ
        p7kM6pNeDaEPX43mHrH4MG2d/aZdutQ=
X-Google-Smtp-Source: ABdhPJxeMIFzmJQ/SM9BVhk0fJSJAaU5fKHIlw4zaysv/qI9apU/x+dO7aIE9WrAE4jIujwy+dzZjF0cNTE=
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:1:f292:1cff:fee0:66cf])
 (user=badhri job=sendgmr) by 2002:a17:90a:c255:: with SMTP id
 d21mr8137282pjx.212.1600337960530; Thu, 17 Sep 2020 03:19:20 -0700 (PDT)
Date:   Thu, 17 Sep 2020 03:18:55 -0700
In-Reply-To: <20200917101856.3156869-1-badhri@google.com>
Message-Id: <20200917101856.3156869-10-badhri@google.com>
Mime-Version: 1.0
References: <20200917101856.3156869-1-badhri@google.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [PATCH v7 10/11] usb: typec: tcpci: Implement Auto discharge
 disconnect callbacks
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

Implement callbacks for enabling/disabling
POWER_CONTROL.AutoDischargeDisconnect.

TCPCI spec allows TCPC hardware to autonomously discharge the vbus
capacitance upon disconnect. The expectation is that the TCPM enables
AutoDischargeDisconnect while entering SNK/SRC_ATTACHED states. Hardware
then automously discharges vbus when the vbus falls below a certain
threshold i.e. VBUS_SINK_DISCONNECT_THRESHOLD.

Apart from enabling the vbus discharge circuit, AutoDischargeDisconnect
is also used a flag to move TCPCI based TCPC implementations into
Attached.Snk/Attached.Src state as mentioned in
Figure 4-15. TCPC State Diagram before a Connection of the
USB Type-C Port Controller Interface Specification.
In such TCPC implementations, setting AutoDischargeDisconnect would
prevent TCPC into entering "Connection_Invalid" state as well.

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
Changes since v1:
- Changing patch version to v6 to fix version number confusion.

Changes since v6:
- Rebase on usb-next.
---
 drivers/usb/typec/tcpm/tcpci.c | 33 +++++++++++++++++++++++++++++++++
 drivers/usb/typec/tcpm/tcpci.h | 22 ++++++++++++++++++++--
 2 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
index f9f0af64da5f..4ca64e8c8fe8 100644
--- a/drivers/usb/typec/tcpm/tcpci.c
+++ b/drivers/usb/typec/tcpm/tcpci.c
@@ -268,6 +268,33 @@ static int tcpci_set_vconn(struct tcpc_dev *tcpc, bool enable)
 				enable ? TCPC_POWER_CTRL_VCONN_ENABLE : 0);
 }
 
+static int tcpci_enable_auto_vbus_discharge(struct tcpc_dev *dev, bool enable)
+{
+	struct tcpci *tcpci = tcpc_to_tcpci(dev);
+	int ret;
+
+	ret = regmap_update_bits(tcpci->regmap, TCPC_POWER_CTRL, TCPC_POWER_CTRL_AUTO_DISCHARGE,
+				 enable ? TCPC_POWER_CTRL_AUTO_DISCHARGE : 0);
+	return ret;
+}
+
+static int tcpci_set_auto_vbus_discharge_threshold(struct tcpc_dev *dev, enum typec_role port_role,
+						   enum typec_pwr_opmode mode, bool pps_active,
+						   u32 requested_vbus_voltage)
+{
+	struct tcpci *tcpci = tcpc_to_tcpci(dev);
+	int (*set_auto_vbus_threshold)(struct tcpci *tcpci, struct tcpci_data *data,
+				       enum typec_role port_role, enum typec_pwr_opmode mode,
+				       bool pps_active, u32 requested_vbus_voltage);
+
+	set_auto_vbus_threshold = tcpci->data->set_auto_vbus_discharge_threshold;
+	if (set_auto_vbus_threshold)
+		return set_auto_vbus_threshold(tcpci, tcpci->data, port_role, mode, pps_active,
+					       requested_vbus_voltage);
+
+	return 0;
+}
+
 static int tcpci_enable_frs(struct tcpc_dev *dev, bool enable)
 {
 	struct tcpci *tcpci = tcpc_to_tcpci(dev);
@@ -629,6 +656,12 @@ struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *data)
 	tcpci->tcpc.set_bist_data = tcpci_set_bist_data;
 	tcpci->tcpc.enable_frs = tcpci_enable_frs;
 
+	if (tcpci->data->auto_discharge_disconnect) {
+		tcpci->tcpc.enable_auto_vbus_discharge = tcpci_enable_auto_vbus_discharge;
+		tcpci->tcpc.set_auto_vbus_discharge_threshold =
+			tcpci_set_auto_vbus_discharge_threshold;
+	}
+
 	err = tcpci_parse_config(tcpci);
 	if (err < 0)
 		return ERR_PTR(err);
diff --git a/drivers/usb/typec/tcpm/tcpci.h b/drivers/usb/typec/tcpm/tcpci.h
index 5ef07a56d67a..6a0aea34e544 100644
--- a/drivers/usb/typec/tcpm/tcpci.h
+++ b/drivers/usb/typec/tcpm/tcpci.h
@@ -8,6 +8,8 @@
 #ifndef __LINUX_USB_TCPCI_H
 #define __LINUX_USB_TCPCI_H
 
+#include <linux/usb/typec.h>
+
 #define TCPC_VENDOR_ID			0x0
 #define TCPC_PRODUCT_ID			0x2
 #define TCPC_BCD_DEV			0x4
@@ -67,6 +69,7 @@
 
 #define TCPC_POWER_CTRL			0x1c
 #define TCPC_POWER_CTRL_VCONN_ENABLE	BIT(0)
+#define TCPC_POWER_CTRL_AUTO_DISCHARGE	BIT(4)
 #define TCPC_FAST_ROLE_SWAP_EN		BIT(7)
 
 #define TCPC_CC_STATUS			0x1d
@@ -133,6 +136,8 @@
 
 #define TCPC_VBUS_VOLTAGE			0x70
 #define TCPC_VBUS_SINK_DISCONNECT_THRESH	0x72
+#define TCPC_VBUS_SINK_DISCONNECT_THRESH_LSB	25
+#define TCPC_VBUS_SINK_DISCONNECT_THRESH_MAX	1023
 #define TCPC_VBUS_STOP_DISCHARGE_THRESH		0x74
 #define TCPC_VBUS_VOLTAGE_ALARM_HI_CFG		0x76
 #define TCPC_VBUS_VOLTAGE_ALARM_LO_CFG		0x78
@@ -140,20 +145,33 @@
 /* I2C_WRITE_BYTE_COUNT + 1 when TX_BUF_BYTE_x is only accessible I2C_WRITE_BYTE_COUNT */
 #define TCPC_TRANSMIT_BUFFER_MAX_LEN		31
 
+struct tcpci;
+
 /*
- * @TX_BUF_BYTE_x_hidden
+ * @TX_BUF_BYTE_x_hidden:
  *		optional; Set when TX_BUF_BYTE_x can only be accessed through I2C_WRITE_BYTE_COUNT.
+ * @auto_discharge_disconnect:
+ *		Optional; Enables TCPC to autonously discharge vbus on disconnect.
+ * @set_auto_vbus_discharge_threshold:
+ *		Mandatory when @auto_discharge_disconnect is sets. Allows
+ *		programming the voltage threshold of vbus below which TCPC
+ *		enables the vbus discharge circuit.
  */
-struct tcpci;
 struct tcpci_data {
 	struct regmap *regmap;
 	unsigned char TX_BUF_BYTE_x_hidden:1;
+	unsigned char auto_discharge_disconnect:1;
+
 	int (*init)(struct tcpci *tcpci, struct tcpci_data *data);
 	int (*set_vconn)(struct tcpci *tcpci, struct tcpci_data *data,
 			 bool enable);
 	int (*start_drp_toggling)(struct tcpci *tcpci, struct tcpci_data *data,
 				  enum typec_cc_status cc);
 	int (*set_vbus)(struct tcpci *tcpci, struct tcpci_data *data, bool source, bool sink);
+	int (*set_auto_vbus_discharge_threshold)(struct tcpci *tcpci, struct tcpci_data *data,
+						 enum typec_role port_role,
+						 enum typec_pwr_opmode mode, bool pps_active,
+						 u32 requested_vbus_voltage);
 };
 
 struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *data);
-- 
2.28.0.618.gf4bc123cb7-goog

