Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5097286E87
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 08:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbgJHGQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 02:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728736AbgJHGQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 02:16:25 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66CDC0613DE
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 23:16:23 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id a27so3025124pfl.17
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 23:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=IvjkXzvW+6lNlW1+WxkRnhzLSIktZGiqYABylT0P1Jw=;
        b=ECVBCFHoGJFmlpmlKxY54GiGeVoQi6NcJEP/nSDJkt2B6grDRwwJGVDCa0/LgBWVIN
         zn3PmJb0jK4lLns5VDA6CDyZZiIy76K5gxtplBJjT+t0x20Vzl2/OuMwwPuMlrJfHzC3
         na1Ihx/iD9EBZF54ppUOafLfUg1+coxmJrS5sdHLZ4VlErLuxMfw8ZpUHC78jfcT9bYu
         UlwUJnUoltWqbrZorRJLBggOsSnavm13Yi1tSLHhxI5qRV37U7JtrNdbCouaEBuAeucq
         3RcR2MJ0QMToN5dgsg1RHrTMd8y2MWrcund/qlE4TFVRfKsFAdaXkF6ClR+Hygfylov+
         xfgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IvjkXzvW+6lNlW1+WxkRnhzLSIktZGiqYABylT0P1Jw=;
        b=kqALtKGQuJO3FUF0WElG4GWELw4pRBpDIsRT+mk+wQCwOl6C8U/kABf1sqfatAhcgl
         h9ZAVjfpL4YQq1U2KOciZfaWRSAL3R1NtRcb79gDvnxr8L79+LkXOLqhVR9Dl+f/cEJp
         97zxyXj0id8zaR8LG++2wmOT9Y/WNCDYiBq8aMSZZRSL0tZsVixOMbr1i2oru24hUgdL
         HQlvIgC5gpXqoOC8nVUmyvSbBroJMSCg2Q04QHgOrvBb1hqBtV6GUWIHq7tuR9tyMbTd
         qG8XKBplOQEWNuV9kBfx0Yv40cSH/6GzlXWLdIyLQPl8rPIJN753Z/zicNSCEOTOqUfr
         6DrQ==
X-Gm-Message-State: AOAM532GfnROZ1LOLixod7BAo7YJm3/SwksjXYuWW1EU5TPirgdwY8Vv
        D+ZVykBksjHb5Mjxu8Xnf9JTKuTSuOM=
X-Google-Smtp-Source: ABdhPJy9elM1FPyXKazUGzgY9O12LDmXbvBYh2mrZEhM4EuaT853sVF3jhlNBHpNw/AT77Zg5Yvy7W4Gzyg=
Sender: "badhri via sendgmr" <badhri@badhri.mtv.corp.google.com>
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:1:f292:1cff:fee0:66cf])
 (user=badhri job=sendgmr) by 2002:a62:1414:0:b029:152:44af:42e with SMTP id
 20-20020a6214140000b029015244af042emr6108924pfu.66.1602137783217; Wed, 07 Oct
 2020 23:16:23 -0700 (PDT)
Date:   Wed,  7 Oct 2020 23:15:51 -0700
In-Reply-To: <20201008061556.1402293-1-badhri@google.com>
Message-Id: <20201008061556.1402293-11-badhri@google.com>
Mime-Version: 1.0
References: <20201008061556.1402293-1-badhri@google.com>
X-Mailer: git-send-email 2.28.0.806.g8561365e88-goog
Subject: [PATCH v10 10/15] usb: typec: tcpci: frs sourcing vbus callback
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

During FRS hardware autonomously starts to source vbus. Provide
callback to perform chip specific operations.

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
v9 is the first version of this patch in the series. Added to fix
occasional bug of vbus turning back on when disconnecting the FRS accessory
after disconnect. No changes since v9.
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
2.28.0.806.g8561365e88-goog

