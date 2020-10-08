Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5F1286E7B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 08:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbgJHGQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 02:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728711AbgJHGQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 02:16:25 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0C4C0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 23:16:17 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id v4so202909ybp.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 23:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ZWt32l+TYej4QZMKFfY95w9ZTUY2cd5q7xBhuPrv2GI=;
        b=I9eyIs2kIUFWoxtwQtA7ec3LUj1pH6B3md1TP5nBXfiuDTTwqxwtp5BpDCZwAeUuKM
         ALSFc0BOgnx0PUmeY6J60CQkizYl5pU46uhReVmaOQotWGBFMP0pgNZPT5dreSqWNtJb
         eXBQc6G42RhUK8sg5xDy0vDtgpbapsHJFib6sgtreDNLmX35N5cH3T2Ho14y59DNEMRF
         /iI8Q5o7lqyYKb4wUtS2/BTzCshy5371BoY0hZDNCIkCUVu7ZCeV2v/ztS7lgEU6vfUa
         uSNUlO+j5gKmbbHsq1anBle32oTrKdii0bH+4JFU1szlSifnp1pf8XSOlwKCujzX5ebC
         IwBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZWt32l+TYej4QZMKFfY95w9ZTUY2cd5q7xBhuPrv2GI=;
        b=jwDD/LbACN+xTQlpP5FKFSS6fdTLQtxPYOyzfMRrHJhbZ2sCDSWDLYDq3RS5HZ3sQD
         LXtlrWZWoKO1a1P+ODzHrXoOadt1TLf4Zm2oZBjo1H/8F55JZKSeE4FOOvMi6q9pnzkW
         uXMhFhu+F4xLZqdqca72hIh2CwE3g9y94HnqKEZwnJm1UfGr+SKYt3owfmzKramMm+jk
         Plp4p65WZT0Cgy11MPEyeCgjg31YoxR/dvgHc5p/bzZNiYrykweKl9QNZDYS6kdMkr3I
         OOkeNmuO6W/sMzdrIDaIVE22YgIXwE5nJe6YBuJJT1GA8l0V5vJjLTIWBdwFpTr9WHxr
         rEqA==
X-Gm-Message-State: AOAM533v4aOwaFUlqiAHj8NO3e2UGmhbwf2WCh9AINZhxyZ4J21sgXTi
        2w1Hpw9Anmdkor3rNYogO49SDKwqQPU=
X-Google-Smtp-Source: ABdhPJzvCTboVjYa8W43Yu74CZ2RF96C33+yc2tzLEfZLYnZ07jzVNxeX2pZ6Z7OvM63kEbjFM7qJDpWMEg=
Sender: "badhri via sendgmr" <badhri@badhri.mtv.corp.google.com>
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:1:f292:1cff:fee0:66cf])
 (user=badhri job=sendgmr) by 2002:a25:bd0c:: with SMTP id f12mr843402ybk.392.1602137776918;
 Wed, 07 Oct 2020 23:16:16 -0700 (PDT)
Date:   Wed,  7 Oct 2020 23:15:48 -0700
In-Reply-To: <20201008061556.1402293-1-badhri@google.com>
Message-Id: <20201008061556.1402293-8-badhri@google.com>
Mime-Version: 1.0
References: <20201008061556.1402293-1-badhri@google.com>
X-Mailer: git-send-email 2.28.0.806.g8561365e88-goog
Subject: [PATCH v10 07/15] usb: typec: tcpci: Implement callbacks for FRS
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

Implement tcpc.enable_frs to enable TCPC to receive
Fast role swap signal.

Additionally set the sink disconnect threshold to 4v
to prevent disconnect during Fast Role swap.

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
Changes since v1:
- Changing patch version to v6 to fix version number confusion.

Changes since v6:
- Rebase on usb-next.
- Fixed formatting error.
- Added Reviewed-by: Heikki.

Changes since v7:
- Rebase on usb-next.

Changes since v8:
- None.

Changes since v9:
- None.
---
 drivers/usb/typec/tcpm/tcpci.c | 17 +++++++++++++++++
 drivers/usb/typec/tcpm/tcpci.h |  8 ++++++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
index d6a6fac82d48..f9f0af64da5f 100644
--- a/drivers/usb/typec/tcpm/tcpci.c
+++ b/drivers/usb/typec/tcpm/tcpci.c
@@ -268,6 +268,22 @@ static int tcpci_set_vconn(struct tcpc_dev *tcpc, bool enable)
 				enable ? TCPC_POWER_CTRL_VCONN_ENABLE : 0);
 }
 
+static int tcpci_enable_frs(struct tcpc_dev *dev, bool enable)
+{
+	struct tcpci *tcpci = tcpc_to_tcpci(dev);
+	int ret;
+
+	/* To prevent disconnect during FRS, set disconnect threshold to 3.5V */
+	ret = tcpci_write16(tcpci, TCPC_VBUS_SINK_DISCONNECT_THRESH, enable ? 0 : 0x8c);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_update_bits(tcpci->regmap, TCPC_POWER_CTRL, TCPC_FAST_ROLE_SWAP_EN, enable ?
+				 TCPC_FAST_ROLE_SWAP_EN : 0);
+
+	return ret;
+}
+
 static int tcpci_set_bist_data(struct tcpc_dev *tcpc, bool enable)
 {
 	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
@@ -611,6 +627,7 @@ struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *data)
 	tcpci->tcpc.set_roles = tcpci_set_roles;
 	tcpci->tcpc.pd_transmit = tcpci_pd_transmit;
 	tcpci->tcpc.set_bist_data = tcpci_set_bist_data;
+	tcpci->tcpc.enable_frs = tcpci_enable_frs;
 
 	err = tcpci_parse_config(tcpci);
 	if (err < 0)
diff --git a/drivers/usb/typec/tcpm/tcpci.h b/drivers/usb/typec/tcpm/tcpci.h
index 82f021a82456..5ef07a56d67a 100644
--- a/drivers/usb/typec/tcpm/tcpci.h
+++ b/drivers/usb/typec/tcpm/tcpci.h
@@ -16,6 +16,7 @@
 #define TCPC_PD_INT_REV			0xa
 
 #define TCPC_ALERT			0x10
+#define TCPC_ALERT_EXTND		BIT(14)
 #define TCPC_ALERT_EXTENDED_STATUS	BIT(13)
 #define TCPC_ALERT_VBUS_DISCNCT		BIT(11)
 #define TCPC_ALERT_RX_BUF_OVF		BIT(10)
@@ -37,6 +38,9 @@
 #define TCPC_EXTENDED_STATUS_MASK		0x16
 #define TCPC_EXTENDED_STATUS_MASK_VSAFE0V	BIT(0)
 
+#define TCPC_ALERT_EXTENDED_MASK	0x17
+#define TCPC_SINK_FAST_ROLE_SWAP	BIT(0)
+
 #define TCPC_CONFIG_STD_OUTPUT		0x18
 
 #define TCPC_TCPC_CTRL			0x19
@@ -63,6 +67,7 @@
 
 #define TCPC_POWER_CTRL			0x1c
 #define TCPC_POWER_CTRL_VCONN_ENABLE	BIT(0)
+#define TCPC_FAST_ROLE_SWAP_EN		BIT(7)
 
 #define TCPC_CC_STATUS			0x1d
 #define TCPC_CC_STATUS_TOGGLING		BIT(5)
@@ -74,11 +79,14 @@
 
 #define TCPC_POWER_STATUS		0x1e
 #define TCPC_POWER_STATUS_UNINIT	BIT(6)
+#define TCPC_POWER_STATUS_SOURCING_VBUS	BIT(4)
 #define TCPC_POWER_STATUS_VBUS_DET	BIT(3)
 #define TCPC_POWER_STATUS_VBUS_PRES	BIT(2)
 
 #define TCPC_FAULT_STATUS		0x1f
 
+#define TCPC_ALERT_EXTENDED		0x21
+
 #define TCPC_COMMAND			0x23
 #define TCPC_CMD_WAKE_I2C		0x11
 #define TCPC_CMD_DISABLE_VBUS_DETECT	0x22
-- 
2.28.0.806.g8561365e88-goog

