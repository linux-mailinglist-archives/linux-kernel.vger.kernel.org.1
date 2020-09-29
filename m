Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31B3727BAF7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 04:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbgI2Ckj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 22:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727459AbgI2Ckb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 22:40:31 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39317C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 19:40:31 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id dj20so1753094qvb.23
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 19:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=+8V9XbF+nrhvOeFjlq1gqGlcRl5hrQT9omJcJW0tz7E=;
        b=eThgSYYws9kLpLHXJUFr8JlqfR0wyD59aDcTKSpqbsx6KIFxXcnLhU123aJufAG5WH
         aDXDmzpTpskIbia0MgBBXSxSbn9D49hM95Y5gcdvk5KasouU/EUxaaOkgaLoA7gLHbBZ
         mLFZyzCFBFplneMO5kRnVhmXU8OVM+0SxYVaiILHXuCSd5etox30tyBSlB1pyq8j7vnl
         p+pt0YFFe0+KCPJNLCrOm6lKk/HCz3ASuUm/CgmjIvExOL/8MBztejPq9+WfTWQp84JX
         EqRvZ+FPJAi8dDJwpQAygrOGlF2gYOv2HypGFKuUp3WW+ZQz0YWAss5U+aX+fjVmfCzW
         QSWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+8V9XbF+nrhvOeFjlq1gqGlcRl5hrQT9omJcJW0tz7E=;
        b=fTzopLtIfUKCz/naToXJR/jzkssu08Mpsef+/SqJpkzsLBbJRzhyDMdw7tsIMK3axG
         HmepOmZwXusq2NhFIT54VJFsLSV7Cf3XGhH8YsBOr77TVr0NRdrzCF9Xgs7TFkGZPn+C
         a/KO1gzMPop0H0b+lLd4B1zynDA7lMyuuh8yrXo637WJ3MHyD/hjHqnpTMnqDotr/Vzv
         ZbjsopiuGEdu10Fjc6LVPrMkEpKshE1rwQjiN/HO+9xqtsIBQVRF8vq8RXuve9aJE+Pg
         eC8NOABNsCkpdu+r6sbQjt4bmIu3K/+Da6OySmPC9E421TkRLKZkcyRleRUeLxppT8Ty
         /nfg==
X-Gm-Message-State: AOAM5326qny8mTgLvxB+LpdaVLTfbxv47+3JphXZzFl5I/Y8iVRa6612
        8iRxGnLtHyeF9sVsSbY+T3/X3CG0u5U=
X-Google-Smtp-Source: ABdhPJzwsg7Sc8wZ0WPfTkzvJTJdAdYy3e+MUHpTHIttV5fY2N8t9NGM6qfFCPHu+ad0WPdZNkpCdjyfmhM=
Sender: "badhri via sendgmr" <badhri@badhri.mtv.corp.google.com>
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:1:f292:1cff:fee0:66cf])
 (user=badhri job=sendgmr) by 2002:ad4:58c7:: with SMTP id dh7mr2723471qvb.20.1601347230306;
 Mon, 28 Sep 2020 19:40:30 -0700 (PDT)
Date:   Mon, 28 Sep 2020 19:39:59 -0700
In-Reply-To: <20200929024004.244992-1-badhri@google.com>
Message-Id: <20200929024004.244992-11-badhri@google.com>
Mime-Version: 1.0
References: <20200929024004.244992-1-badhri@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH v9 10/15] usb: typec: tcpci: frs sourcing vbus callback
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

During FRS hardware autonomously starts to source vbus. Provide
callback to perform chip specific operations.

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
v9 is the first version of this patch in the series. Added to fix
occasional bug of vbus turning back on when disconnecting the FRS accessory
after disconnect.
---
 drivers/usb/typec/tcpm/tcpci.c | 9 +++++++++
 drivers/usb/typec/tcpm/tcpci.h | 4 ++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
index f9f0af64da5f..f91688e43991 100644
--- a/drivers/usb/typec/tcpm/tcpci.c
+++ b/drivers/usb/typec/tcpm/tcpci.c
@@ -284,6 +284,14 @@ static int tcpci_enable_frs(struct tcpc_dev *dev, bool enable)
 	return ret;
 }
 
+static void tcpci_frs_sourcing_vbus(struct tcpc_dev *dev)
+{
+	struct tcpci *tcpci = tcpc_to_tcpci(dev);
+
+	if (tcpci->data->frs_sourcing_vbus)
+		tcpci->data->frs_sourcing_vbus(tcpci, tcpci->data);
+}
+
 static int tcpci_set_bist_data(struct tcpc_dev *tcpc, bool enable)
 {
 	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
@@ -628,6 +636,7 @@ struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *data)
 	tcpci->tcpc.pd_transmit = tcpci_pd_transmit;
 	tcpci->tcpc.set_bist_data = tcpci_set_bist_data;
 	tcpci->tcpc.enable_frs = tcpci_enable_frs;
+	tcpci->tcpc.frs_sourcing_vbus = tcpci_frs_sourcing_vbus;
 
 	err = tcpci_parse_config(tcpci);
 	if (err < 0)
diff --git a/drivers/usb/typec/tcpm/tcpci.h b/drivers/usb/typec/tcpm/tcpci.h
index 5ef07a56d67a..b418fe11b527 100644
--- a/drivers/usb/typec/tcpm/tcpci.h
+++ b/drivers/usb/typec/tcpm/tcpci.h
@@ -143,6 +143,9 @@
 /*
  * @TX_BUF_BYTE_x_hidden
  *		optional; Set when TX_BUF_BYTE_x can only be accessed through I2C_WRITE_BYTE_COUNT.
+ * @frs_sourcing_vbus:
+ *		Optional; Callback to perform chip specific operations when FRS
+ *		is sourcing vbus.
  */
 struct tcpci;
 struct tcpci_data {
@@ -154,6 +157,7 @@ struct tcpci_data {
 	int (*start_drp_toggling)(struct tcpci *tcpci, struct tcpci_data *data,
 				  enum typec_cc_status cc);
 	int (*set_vbus)(struct tcpci *tcpci, struct tcpci_data *data, bool source, bool sink);
+	void (*frs_sourcing_vbus)(struct tcpci *tcpci, struct tcpci_data *data);
 };
 
 struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *data);
-- 
2.28.0.709.gb0816b6eb0-goog

