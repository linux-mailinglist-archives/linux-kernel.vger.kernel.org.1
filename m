Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56C9426D8D7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 12:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbgIQKWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 06:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbgIQKTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 06:19:53 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F62C0612F2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 03:19:15 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id b3so1761322ybg.23
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 03:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=0aTOF3VwOfvlq9pcrGgaocTr6H19KtqyyWv30I3+P9k=;
        b=F1lTXgM7KaxmaA11aa2W1qQ+V2m2jtHjk7t6fOkpnUjz5ScRQWIjcTJG/RdtZtPK3T
         rVdQsF1ng+1kcIPg/7x2qymzFRGX7pkNN5j2XNO4vvX9fqm90h+ZoDvNtuVi6m2sAOb7
         XeYgdOaEMe6MxFKK2RX3By43O0vCz3rnSLcy9bfDS3B+Y/w3pPYQT6m5LuPyb3Eixq97
         A6C5Em/Ci+wJcsmNO5xPsVOnhdRXWUPvRkWTrNe2N85jtoBPQov8RxZkynH8Cbd4jz6V
         WFywQS+lFHepG+hdoNk3G90QWAP+OGeWd5dh2BQB058MNA26fZ9g7Gvoyqz6+wzkwoCF
         N+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0aTOF3VwOfvlq9pcrGgaocTr6H19KtqyyWv30I3+P9k=;
        b=o2a6GMrHOZqp+BJYmXcTKtUfkq7sDMoZVNK5HQreeAwnr3fHWNalt7d5BITLYWixqn
         z/03nZq7dxunrnYmYY119kA2SZrLxpN0ZpFs7muVa6oof7VhBZxJNeaDdyc6ihOVW2+N
         yKNKDBHHJqY2V1J6GxFq65/XO6kL24NHVrOzrio6nZzwK3wNOughZXLkRU2Qi57utMyZ
         I5+ttfIUneLNYFsTH6ghe1mdXhi4a7VK8M1qxXKzA6JJuubYKiY+SMEyU8FQB9KJfRLt
         o/5ZJXnseS9SGnBqPWKiVOC6/BSz/3rX+hRDlnhed1z62Zmap/Zar67S9TzYnjdWeL25
         hc5g==
X-Gm-Message-State: AOAM5317tAhYGHGrmizOmCai2gr7oKqodNN8vF4nunWoaUWvNSO7kBgz
        b58XvCCZ53lV5XCsAe1fD0qKe+ToxtU=
X-Google-Smtp-Source: ABdhPJzb1juZr/0Y2G1y9iXIgtPOxi2gmV3F0iGnKj8afIEflB5JjY92L6UKVTToAKJwNx5dAAw9F66ufbQ=
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:1:f292:1cff:fee0:66cf])
 (user=badhri job=sendgmr) by 2002:a25:d290:: with SMTP id j138mr40600991ybg.146.1600337954644;
 Thu, 17 Sep 2020 03:19:14 -0700 (PDT)
Date:   Thu, 17 Sep 2020 03:18:52 -0700
In-Reply-To: <20200917101856.3156869-1-badhri@google.com>
Message-Id: <20200917101856.3156869-7-badhri@google.com>
Mime-Version: 1.0
References: <20200917101856.3156869-1-badhri@google.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [PATCH v7 07/11] usb: typec: tcpci: Implement callbacks for FRS
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
2.28.0.618.gf4bc123cb7-goog

