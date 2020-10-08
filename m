Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C915E286E99
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 08:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbgJHGRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 02:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728834AbgJHGQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 02:16:38 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2813C0613E4
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 23:16:31 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id n8so3049503qtf.10
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 23:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ebMLL3uQjmDQf27Z+hcIGJGbzI6/4R/tQRAYIq3vKl8=;
        b=JXlLTnib43C3WXIOzSQrHV561AgM1lwqnXeY5/6dTnyH5lU2iRoNASrDjXM7q2eJT0
         r9W7B7J3LUhIGFhXq2dZzV8CPdDqDWy2EPcXr/YJosA8u4vNY/Gh6pwhtFxdjAXh30pF
         5tAXsFTL2z1T8cektqJGJ2f52t3qQH/z5qyJ5NDDZuIQsQTfBs/9GMwkZL/03sX+PZaq
         XMzpUWfL+rdShCeLqA8xeN/Mw6raWUYBmUyjMKxk6cupBYZu/uYp/buPjBtJkB1FM1VT
         SX4yFT2zqMUEmnJcCwMvf+HIFUcNgthCtj7OVoNVN0fHCRP1E2DiAlYU3PLuVCUJJsIL
         8TZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ebMLL3uQjmDQf27Z+hcIGJGbzI6/4R/tQRAYIq3vKl8=;
        b=rHOu0fECTp+rHi1XVkogAPwvlDAI8FLI4rJHXQSP0A3Dr0nUyUDN4n2BulIRihu5Sv
         ggPhZemcnNHksFNsNnFGJ9U/Kgk5bEqFxLrBlvUqaBZy7SJ2akaKH/Q781+QsIY0FjvN
         iu071iyT0b8xOWzoXNLapyBXCz3deSDdpNfdGC+xWtUNy79u3SlwEBdMiZYGxFOi9Fog
         Vn677Ca8R3GC2RyyWpbYN6FsUTX0jyjcimp0iX0GIme7d8bOM9bknZJIEjhGR3idy5WE
         IicxuKNVbz+2Fh8LBxcOLK+1bpbSt9hnLdZ6sERLlVr1ZNiPkCDitE95MM9tpw2W8a1Y
         Mmcw==
X-Gm-Message-State: AOAM530xcKeud2HawnIJMfhEXE4iw7/zoYEx27a/HgrjiaVeOEdUEmGn
        N9ZXdBe9lMpo6dW7IBWyfM9V+iEkoJY=
X-Google-Smtp-Source: ABdhPJwNmYJzXx8mim9diJUMMT/spOt5aVujkZBCx8HuI9Q5zNK1iPsbj0QG1HN4Aw/25UdMR0OWRmhfDWc=
Sender: "badhri via sendgmr" <badhri@badhri.mtv.corp.google.com>
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:1:f292:1cff:fee0:66cf])
 (user=badhri job=sendgmr) by 2002:ad4:458d:: with SMTP id x13mr6927461qvu.4.1602137791024;
 Wed, 07 Oct 2020 23:16:31 -0700 (PDT)
Date:   Wed,  7 Oct 2020 23:15:55 -0700
In-Reply-To: <20201008061556.1402293-1-badhri@google.com>
Message-Id: <20201008061556.1402293-15-badhri@google.com>
Mime-Version: 1.0
References: <20201008061556.1402293-1-badhri@google.com>
X-Mailer: git-send-email 2.28.0.806.g8561365e88-goog
Subject: [PATCH v10 14/15] usb: typec: tcpci: Implement Auto discharge
 disconnect callbacks
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

vImplement callbacks for enabling/disabling
POWER_CONTROL.AutoDischargeDisconnect.

Programs VBUS_SINK_DISCONNECT_THRESHOLD based on the
voltage requested as sink, mode of operation.

The programmed threshold is based on vSinkDisconnect and
vSinkDisconnectPD values.

Add auto_discharge_disconnect to tdata to allow TCPC chip
level drivers enable AutoDischargeDisconnect.

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
Changes since v1:
- Changing patch version to v6 to fix version number confusion.

Changes since v6:
- Rebase on usb-next.

Changes since v7:
Heikki's suggestion:
- Moved the actual write to TCPC_VBUS_SINK_DISCONNECT_THRESH
as it's common to all chip drivers.
- Renaming the tcpci_data callback as
get_auto_vbus_discharge_threshold

Changes since v8:
- Removed get_auto_vbus_discharge_threshold callback and moved the logic
  to program the default threshold for TCPC_VBUS_SINK_DISCONNECT_THRESH
  into the TCPCI code.

Changes since v9:
- none
---
 drivers/usb/typec/tcpm/tcpci.c | 63 +++++++++++++++++++++++++++++++++-
 drivers/usb/typec/tcpm/tcpci.h | 14 ++++++--
 2 files changed, 74 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
index f91688e43991..12d983a75510 100644
--- a/drivers/usb/typec/tcpm/tcpci.c
+++ b/drivers/usb/typec/tcpm/tcpci.c
@@ -18,7 +18,10 @@
 
 #include "tcpci.h"
 
-#define PD_RETRY_COUNT 3
+#define	PD_RETRY_COUNT				3
+#define	AUTO_DISCHARGE_DEFAULT_THRESHOLD_MV	3500
+#define	AUTO_DISCHARGE_PD_HEADROOM_MV		850
+#define	AUTO_DISCHARGE_PPS_HEADROOM_MV		1250
 
 struct tcpci {
 	struct device *dev;
@@ -268,6 +271,58 @@ static int tcpci_set_vconn(struct tcpc_dev *tcpc, bool enable)
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
+static int tcpci_set_auto_vbus_discharge_threshold(struct tcpc_dev *dev, enum typec_pwr_opmode mode,
+						   bool pps_active, u32 requested_vbus_voltage_mv)
+{
+	struct tcpci *tcpci = tcpc_to_tcpci(dev);
+	unsigned int pwr_ctrl, threshold = 0;
+	int ret;
+
+	/*
+	 * Indicates that vbus is going to go away due PR_SWAP, hard reset etc.
+	 * Do not discharge vbus here.
+	 */
+	if (requested_vbus_voltage_mv == 0)
+		goto write_thresh;
+
+	ret = regmap_read(tcpci->regmap, TCPC_POWER_CTRL, &pwr_ctrl);
+	if (ret < 0)
+		return ret;
+
+	if (pwr_ctrl & TCPC_FAST_ROLE_SWAP_EN) {
+		/* To prevent disconnect when the source is fast role swap is capable. */
+		threshold = AUTO_DISCHARGE_DEFAULT_THRESHOLD_MV;
+	} else if (mode == TYPEC_PWR_MODE_PD) {
+		if (pps_active)
+			threshold = (95 * requested_vbus_voltage_mv / 100) -
+				AUTO_DISCHARGE_PD_HEADROOM_MV;
+		else
+			threshold = (95 * requested_vbus_voltage_mv / 100) -
+				AUTO_DISCHARGE_PPS_HEADROOM_MV;
+	} else {
+		/* 3.5V for non-pd sink */
+		threshold = AUTO_DISCHARGE_DEFAULT_THRESHOLD_MV;
+	}
+
+	threshold = threshold / TCPC_VBUS_SINK_DISCONNECT_THRESH_LSB_MV;
+
+	if (threshold > TCPC_VBUS_SINK_DISCONNECT_THRESH_MAX)
+		return -EINVAL;
+
+write_thresh:
+	return tcpci_write16(tcpci, TCPC_VBUS_SINK_DISCONNECT_THRESH, threshold);
+}
+
 static int tcpci_enable_frs(struct tcpc_dev *dev, bool enable)
 {
 	struct tcpci *tcpci = tcpc_to_tcpci(dev);
@@ -638,6 +693,12 @@ struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *data)
 	tcpci->tcpc.enable_frs = tcpci_enable_frs;
 	tcpci->tcpc.frs_sourcing_vbus = tcpci_frs_sourcing_vbus;
 
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
index b418fe11b527..3fe313655f0c 100644
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
+#define TCPC_VBUS_SINK_DISCONNECT_THRESH_LSB_MV	25
+#define TCPC_VBUS_SINK_DISCONNECT_THRESH_MAX	0x3ff
 #define TCPC_VBUS_STOP_DISCHARGE_THRESH		0x74
 #define TCPC_VBUS_VOLTAGE_ALARM_HI_CFG		0x76
 #define TCPC_VBUS_VOLTAGE_ALARM_LO_CFG		0x78
@@ -140,17 +145,22 @@
 /* I2C_WRITE_BYTE_COUNT + 1 when TX_BUF_BYTE_x is only accessible I2C_WRITE_BYTE_COUNT */
 #define TCPC_TRANSMIT_BUFFER_MAX_LEN		31
 
+struct tcpci;
+
 /*
- * @TX_BUF_BYTE_x_hidden
+ * @TX_BUF_BYTE_x_hidden:
  *		optional; Set when TX_BUF_BYTE_x can only be accessed through I2C_WRITE_BYTE_COUNT.
  * @frs_sourcing_vbus:
  *		Optional; Callback to perform chip specific operations when FRS
  *		is sourcing vbus.
+ * @auto_discharge_disconnect:
+ *		Optional; Enables TCPC to autonously discharge vbus on disconnect.
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
-- 
2.28.0.806.g8561365e88-goog

