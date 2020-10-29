Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 977F229E4A2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 08:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730351AbgJ2Hkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727668AbgJ2HYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:24:51 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C016CC05BD26
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 23:31:54 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id i129so1661442ybc.11
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 23:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=HobQdiija1UHAC8Z9UnHwQZPe4I5ZvWSajBtFoTjVfA=;
        b=b5wr5dYFmLvtUzF+1op0Ac3LpMV70844MHD3To2qSF+2q4QlW/F+pUAl4SB+qxHhWS
         4Goba80/RBBpZxnh06qX9krXYmDKZK3tgR0akk2s9gLsf84z9T143K9wM7OlvnkphynD
         Q3Lpx2UOeE/uxh90q7yMBD3UwAlc1FpgYZFjVT2XPHhrNq2S2VmxLlufViVzyKgHkRpo
         O/RHYAefCepVm9gQAE9ztPsFgOzZnSwha1zn2bVGp7S9v3DbRCZ0gvHo7H0Uc49lCNNq
         euWlcmKhmYDnZvhbqW5xhUSaM58LvwRISA0ehk0jo8wg21pNSd0rSEbbMqmlmloLGGzW
         1iPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HobQdiija1UHAC8Z9UnHwQZPe4I5ZvWSajBtFoTjVfA=;
        b=BZ9dMLCPSiKmXdf4yR+JYiB80idnkEyc4seruZseFh2rwOVeC2GtES90yTd2sV206W
         gRUEP5+jXSkulGyQuTKTCGzzPFFCrfLuEJzkml9fDv8n1DrWG1ookzgn7Pr2LxrMGCoO
         setJrTYk4XXlfmljEc9N8PmbaA9a+WNi6UqgVft87QKeCBSXsPeCAuZBgMVGJdspxJ5P
         g/8L+0yqB9EKKt/abQeTYlLKjU77UhbSIt73/UIuH0lMsBfdOXYrQQIQvgY2HfoktQkZ
         iuXZ+Fr7j4CsFmJy4hYVeK13jI/QMYBzO06jJaF2HtKyfxJdYHS+QSYRys0SHzjDXO3F
         hsnQ==
X-Gm-Message-State: AOAM533A0V/ScW1qzLFNHmgbYfmZgLTmtG5L2TcfTpDhhVijAyRE/H2L
        K7E+I5hsx4rkHNggztCe+chHpV3M9Po=
X-Google-Smtp-Source: ABdhPJxAzjdNqR48IylJ3jiZ9ZeMVn2FilIRpaRHxu0nTTVydquetyPiESvLlySU6o6PSXnmQVFYKeRmA98=
Sender: "badhri via sendgmr" <badhri@badhri.mtv.corp.google.com>
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:201:f292:1cff:fee0:66cf])
 (user=badhri job=sendgmr) by 2002:a25:6ec3:: with SMTP id j186mr3849299ybc.165.1603953113997;
 Wed, 28 Oct 2020 23:31:53 -0700 (PDT)
Date:   Wed, 28 Oct 2020 23:31:33 -0700
In-Reply-To: <20201029063138.1429760-1-badhri@google.com>
Message-Id: <20201029063138.1429760-6-badhri@google.com>
Mime-Version: 1.0
References: <20201029063138.1429760-1-badhri@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v12 05/10] usb: typec: tcpci: frs sourcing vbus callback
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
        Badhri Jagan Sridharan <badhri@google.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During FRS hardware autonomously starts to source vbus. Provide
callback to perform chip specific operations.

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
v9 is the first version of this patch in the series. Added to fix
occasional bug of vbus turning back on when disconnecting the FRS accessory
after disconnect. No changes since v9.

Changes since v10:
Added Reviewed-by: Heikki Krogerus

Changes since v11:
none
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
2.29.1.341.ge80a0c044ae-goog

