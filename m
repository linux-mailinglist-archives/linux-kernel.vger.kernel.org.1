Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 621E629382C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 11:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405744AbgJTJgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 05:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405738AbgJTJgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 05:36:50 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF55AC0613CE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 02:36:50 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id 62so810348pfv.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 02:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=aN7gnHoU6+XglyQ++3Bm09rGv5YmzeKvUGytqmUxCmQ=;
        b=b0Cml3u3zYV6a3GLVdMkDg0dqyoux5ZACXklWmIU4ViW2OhmAQ9QYCK+e801lBHp4I
         InUdNk6+jUi/l3qXzWp1LIe8bHwzzmmNgYKo07c8T+fmtWnRQAJe/2BYFyTQNJfq6xoY
         izDUIqBwP+PvE6PrFCv0jB4ZfBu6hlMqAgmT1gEhduu9s2NIpbaFsbxE/dyuyG486uzj
         HtjN2Xn4zEb6c/ny3QiCykGg/MO9HiXI8D1R6vWb8nAV9O5XsnvbQmZsARh7tUEvBSRn
         RxyYpi/f5Rg1VOZe+/bgxkTKsxMNEYgk1BaiKrhIrM+n+MnbNUPa+t1uLE618xZy3ulb
         uTmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aN7gnHoU6+XglyQ++3Bm09rGv5YmzeKvUGytqmUxCmQ=;
        b=eB1G8nxcK1M+Y+CH8oq+hGT+3JZg1boflYerFr61wlZql1z6D8qCCm2xC0W6CQNx2e
         yZ2mPNy6pZWHDRzBEH3xIVAQ08PX+nYbxLGhf2iGIySM/EuzLOBiKNTh56R+oPs6xut7
         kPV9Th2H744xaNTtGJiXJkFnUwfdFVxMMvzXW7mG9qZqH39AxYQsLj4r7aixH5LCzcPQ
         6MyrcfO1GwJNitT51u0On0BALJafDq2J44rB3Q+2w/Vjft/vO0kXHwgcZAAvcGj//rPC
         AWR591v51oPQL/S657fk/8gH0PZtQk5D/mCtq/JPkR4L/3/FJam6+AgMKcS+5IXrbBun
         QOwQ==
X-Gm-Message-State: AOAM532AF+5caZI4cOKEwiOZcKtR/T+MHXS8aK+2Ii1Ro52F6tAD0GGz
        0eCnvrS/81EKagSxZ8WHjLj5EbWxTfc=
X-Google-Smtp-Source: ABdhPJyXdeeMOq3OUQA7W93PmkOPYzMoC6jAQ9ML8iBNc6GDBFG02M8hbBcH/QaBeQtMsKWivQlS+sqJDXw=
Sender: "badhri via sendgmr" <badhri@badhri.mtv.corp.google.com>
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:1:f292:1cff:fee0:66cf])
 (user=badhri job=sendgmr) by 2002:a17:90b:1496:: with SMTP id
 js22mr2082188pjb.20.1603186610216; Tue, 20 Oct 2020 02:36:50 -0700 (PDT)
Date:   Tue, 20 Oct 2020 02:36:26 -0700
In-Reply-To: <20201020093627.256885-1-badhri@google.com>
Message-Id: <20201020093627.256885-10-badhri@google.com>
Mime-Version: 1.0
References: <20201020093627.256885-1-badhri@google.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH v11 09/10] usb: typec: tcpci: Implement Auto discharge
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
        linux-usb@vger.kernel.org
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
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
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

Changes since v10:
-Added Reviewed-by: Heikki Krogerus
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
2.29.0.rc1.297.gfa9743e501-goog

