Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69F6626D8F8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 12:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgIQKZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 06:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbgIQKTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 06:19:05 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163E3C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 03:19:03 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id t4so1038213qvr.21
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 03:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=ZU+DPT22S0CV1ES1wtFAa83RDjLdxcwwskP2a3Xj38w=;
        b=u1mDyPU0nqs9XqH5wdSySLV7aOgSvluTZAD4YXy4RysXzuU07tm5o+/aik1DX57pGq
         uL9iPY/fBDQe7yOZkt4yq8zvW4LD7kxcNPbNt1QOgszjhVyFRMsP08dmrYcATtcsufTF
         uapGy7cc2Bhlg+/UulkOUNn+l4eRNMFnKKLUfb9VxrtTWshb1QBUWvj14Oo8PQCW1GXg
         MN4usefnhoKMY2lZWGUYzI333dS8G1DuDNMXcHxcrgBypgeC9cRMuH4KdtHLZNcdcnZS
         tvyQOusOb7QIi2C9Piny0GP546KAAo+kemfHkpqJKPMIptnm/SZm/dtPZz/slQU2XgQK
         ku3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=ZU+DPT22S0CV1ES1wtFAa83RDjLdxcwwskP2a3Xj38w=;
        b=cscHKfLu+6m/4kdww+EEdhTBkd3sJ76tais849z0eGqCI1fTjvV1XwPUV3PxuPRt2Y
         8BXUqiAojHVq6wtbW+7v2/FcfnOkoqPgwcaJqdwpQ+6Cs1M1lXETAjFgHnmBHtMCj6NY
         3ZSpMmtDC3PaE5kZe9vOe3y7k/BLVtAyrUkgjACp/loXPUoCVQdBnfq7XAFQTmloFK5z
         kkW1bnAPNL0XMVr54J9unyXPQrB42bzrph32lGjQq4RHF1vw2gFEFxlQytqYhGacKf+0
         F8qJ5ByI5DCFvElxOb1VgghP9sb9ldY7JYNTOjTcY3Kdh7ZlNrBXWgO7M1sNSvOil2+t
         5ZBg==
X-Gm-Message-State: AOAM533vOUdBOLuvpNC3mjOLx6iZmPzGrAR17De2GBDUCzDDv0fwWTW7
        HWVmNtbA1LKUYtU49GTsfzcDX4E2RjE=
X-Google-Smtp-Source: ABdhPJxDnWgHN2qC3rqj59a7E1XQy8vDobQsTiIdnHwfq+MyZWjuKBk/rUH9eEnO0X3gcR9QLePElYvsZms=
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:1:f292:1cff:fee0:66cf])
 (user=badhri job=sendgmr) by 2002:ad4:58e3:: with SMTP id di3mr11458117qvb.54.1600337942277;
 Thu, 17 Sep 2020 03:19:02 -0700 (PDT)
Date:   Thu, 17 Sep 2020 03:18:46 -0700
Message-Id: <20200917101856.3156869-1-badhri@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [PATCH v7 01/11] usb: typec: tcpci: Add a getter method to retrieve
 tcpm_port reference
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

Allow chip level drivers to retrieve reference to tcpm_port.

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
Change since v1:
- Changing patch version to v6 to fix version number confusion.

Change since v6:
- Rebase on usb-next
- Added Reviewed-by from Heikki.
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
2.28.0.618.gf4bc123cb7-goog

