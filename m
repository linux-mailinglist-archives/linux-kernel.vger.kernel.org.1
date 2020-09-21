Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB8E8273334
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 21:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgIUT4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 15:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727244AbgIUT4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 15:56:01 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F20C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 12:56:01 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id q2so14039548ybo.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 12:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=UYdZsbRRn0ngJ7bp1PZbaVObPNEy0F/LDH2oLgnJ+1Y=;
        b=FfGltcomG8zE8J9z8QDGQdn1bE5ren29TUCOaytLkD/duuDzhuy+St8rIBXWrrfUkI
         jqnW3Litk/BDspNQE9AUIyxNApoOUtLYnhcYcpYrm2pGw8tuwuyy+/RX0QZYEuGGtxVm
         b+7HrlQl4Jb36vcefnKHPpNWkRn4RItmKyb2TKtNYyRF+SMR263h/+h5R0Rbi3zgsLH+
         qhoiwzD26yZbHi4UROICtnG3FKoiNaUzo8lCpZeUFNAoGtG5Rv5/jqEHz1ZYgNDm5hGd
         paqjlBCf5blo1tu2bUaMMcB/qjInBRZ67AacUc642ZNE89uDi6IscpBbYDcd0ilZVWy9
         81qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=UYdZsbRRn0ngJ7bp1PZbaVObPNEy0F/LDH2oLgnJ+1Y=;
        b=grQBrqxA6oXQORa1g7VkDhSi8oHbS0sAiGwGHceWYmzM6aKG66P2kguERE0ILf1WDS
         501ncB47+btHe3lWrPgvUaW6rIdScWsjDl3zx6wlO0cogFpZM0oPD2VWrWvwof1Eg72C
         jkIbjW1hlFd5pAVaYh6fyo9Hu6ihQXt5FJhBQxsdPEGZ58aW/ujHv06cgP+OK6WH4C5m
         hI25hBmdG88YtxG5sLm6nR83pOSHRE6hKVziJRUmVT03zYfzIyHMLPSEpkNZ31qqmmud
         TJuMV0z3dlAqOUwqa4yUuWGaRTCQQqwUEx23bIF9OtwQ3lzyzmB92Itv0auwmgCsFH6F
         8KSg==
X-Gm-Message-State: AOAM533PngKTsA4xJLksx5glrWUybSgiuI65w6uPOr0WPc1rOkRnRemf
        vFxnjVf29zecbO7zCovvajTNuwuIvPI=
X-Google-Smtp-Source: ABdhPJxwzYsjMlODwBB0tpJIPRdXie9IZw+XcAwSixFh2guUyZ+jFmUmn/Y4WKWTbZgx9L4MheMdZm2K5eY=
Sender: "badhri via sendgmr" <badhri@badhri.mtv.corp.google.com>
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:1:f292:1cff:fee0:66cf])
 (user=badhri job=sendgmr) by 2002:a25:244a:: with SMTP id k71mr2218204ybk.504.1600718160665;
 Mon, 21 Sep 2020 12:56:00 -0700 (PDT)
Date:   Mon, 21 Sep 2020 12:55:45 -0700
Message-Id: <20200921195555.1050731-1-badhri@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v8 01/11] usb: typec: tcpci: Add a getter method to retrieve
 tcpm_port reference
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

Allow chip level drivers to retrieve reference to tcpm_port.

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
Change since v1:
- Changing patch version to v6 to fix version number confusion.

Change since v6:
- Rebase on usb-next
- Added Reviewed-by from Heikki.

Change since v7:
- Rebase on usb-next
---
 drivers/usb/typec/tcpm/tcpci.c | 6 ++++++
 drivers/usb/typec/tcpm/tcpci.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
index 7d9491ba62fb..b960fe5a0f28 100644
--- a/drivers/usb/typec/tcpm/tcpci.c
+++ b/drivers/usb/typec/tcpm/tcpci.c
@@ -38,6 +38,12 @@ struct tcpci_chip {
 	struct tcpci_data data;
 };
 
+struct tcpm_port *tcpci_get_tcpm_port(struct tcpci *tcpci)
+{
+	return tcpci->port;
+}
+EXPORT_SYMBOL_GPL(tcpci_get_tcpm_port);
+
 static inline struct tcpci *tcpc_to_tcpci(struct tcpc_dev *tcpc)
 {
 	return container_of(tcpc, struct tcpci, tcpc);
diff --git a/drivers/usb/typec/tcpm/tcpci.h b/drivers/usb/typec/tcpm/tcpci.h
index cf9d8b63adcb..04c49a0b0368 100644
--- a/drivers/usb/typec/tcpm/tcpci.h
+++ b/drivers/usb/typec/tcpm/tcpci.h
@@ -150,4 +150,6 @@ struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *data);
 void tcpci_unregister_port(struct tcpci *tcpci);
 irqreturn_t tcpci_irq(struct tcpci *tcpci);
 
+struct tcpm_port;
+struct tcpm_port *tcpci_get_tcpm_port(struct tcpci *tcpci);
 #endif /* __LINUX_USB_TCPCI_H */
-- 
2.28.0.681.g6f77f65b4e-goog

