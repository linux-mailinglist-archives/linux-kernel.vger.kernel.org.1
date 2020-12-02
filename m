Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1522CB3CC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 05:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387515AbgLBEJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 23:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387479AbgLBEJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 23:09:44 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADBCC061A47
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 20:08:48 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id u37so334089ybi.15
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 20:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=bhuIWbpu6FdJx5JrXNuQlsi08GfmooSMSEdjQVGorE8=;
        b=M0j6Ff/q/vb+xRcydAOACekI0KNqgy8p0TBSABbNJun+7927Ftk9FuzEQLwbQpJw2T
         nltS5LSPbYJ/lhZnDMG0mExt6DpIO3BeabGNddhkbbwODvYn9ecW1WIgoUGbfTCQ46m0
         ZOsvGj+aiJL4TGTK+O1ST5DiN1KJKEpGZ1DnyBUcv26vFncQEZjxpMu9tWADdunfRHGl
         tjCIQGBxr1ZZyaNhyAWR7c654xiwP0t0IIwjf2XrJ7O6q6+Clb/PCm2WHM1BrzCyqIAD
         lee/DRuhFP+PxgJk3PR2pWITzgHOktTTJrhCdl3iVM6M1rtwtPyqmbYrgM13Yme5jDqw
         Eplg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bhuIWbpu6FdJx5JrXNuQlsi08GfmooSMSEdjQVGorE8=;
        b=XXXLzvZPn3oHM8VvUPqvwxmG4jxgOacomUm8U3Dr7OkA9M+l1UEA9GDgB3t9gZFeEO
         YurxHqbQFDVwqmymud+2G5t0mGHyoa4zTHJ+LRuqn8mjM9nQxP/T5depn+fsxSe+7Wsf
         Ar3ur/M8p36ai0YI5rHrbd+9PtG01/lHK1Jdhd2obvGdCkVZN/647KSs23maODuQ25yc
         z3lAGj264MAnUBLok7Vqvpafy+5OPWdHkZ4Fk2gZyf5L9SqZk4lj/RW0YntU3rmBfjp3
         d4WTH9HSDBgNT1zcQ+rREE5lG0ZKY6VmQdYQuZG9JcUFAzhX2r1SdJhm0v5evyJFaLSJ
         ykEw==
X-Gm-Message-State: AOAM533Vs69Y7Yoi2wUrTlE5qvmtZn5h3MGuPtSvTylBmDvR2gWo9lDs
        8Zv+KZ3xoAXngT7sFSWpLkld31qNZCA=
X-Google-Smtp-Source: ABdhPJw1O7Q1ymh1n46yPe1RPHJcZ/ALGgKKGQ6sN8Ec58cqaXJXSQjCBrWq9ZNz0HA3ZTlsz+AGdJ1oAF4=
Sender: "badhri via sendgmr" <badhri@badhri.mtv.corp.google.com>
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:201:f292:1cff:fee0:66cf])
 (user=badhri job=sendgmr) by 2002:a5b:10:: with SMTP id a16mr1024380ybp.242.1606882128094;
 Tue, 01 Dec 2020 20:08:48 -0800 (PST)
Date:   Tue,  1 Dec 2020 20:08:40 -0800
In-Reply-To: <20201202040840.663578-1-badhri@google.com>
Message-Id: <20201202040840.663578-3-badhri@google.com>
Mime-Version: 1.0
References: <20201202040840.663578-1-badhri@google.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH v2 3/3] usb: typec: tcpci_maxim: Enable VSAFE0V signalling
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

Unmask EXTENDED_STATUS_MASK.vSafe0V, ALERT.Extended_Status
and set vbus_vsafe0v to enable VSAFE0V signalling.

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
Changes since v1:
- Setting auto_discharge_disconnect to true instead of 1 as
  suggested by Guenter.
---
 drivers/usb/typec/tcpm/tcpci_maxim.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm/tcpci_maxim.c b/drivers/usb/typec/tcpm/tcpci_maxim.c
index c1797239bf08..319266329b42 100644
--- a/drivers/usb/typec/tcpm/tcpci_maxim.c
+++ b/drivers/usb/typec/tcpm/tcpci_maxim.c
@@ -112,11 +112,18 @@ static void max_tcpci_init_regs(struct max_tcpci_chip *chip)
 		return;
 	}
 
+	/* Enable VSAFE0V detection */
+	ret = max_tcpci_write8(chip, TCPC_EXTENDED_STATUS_MASK, TCPC_EXTENDED_STATUS_VSAFE0V);
+	if (ret < 0) {
+		dev_err(chip->dev, "Unable to unmask TCPC_EXTENDED_STATUS_VSAFE0V ret:%d\n", ret);
+		return;
+	}
+
 	alert_mask = TCPC_ALERT_TX_SUCCESS | TCPC_ALERT_TX_DISCARDED | TCPC_ALERT_TX_FAILED |
 		TCPC_ALERT_RX_HARD_RST | TCPC_ALERT_RX_STATUS | TCPC_ALERT_CC_STATUS |
 		TCPC_ALERT_VBUS_DISCNCT | TCPC_ALERT_RX_BUF_OVF | TCPC_ALERT_POWER_STATUS |
 		/* Enable Extended alert for detecting Fast Role Swap Signal */
-		TCPC_ALERT_EXTND;
+		TCPC_ALERT_EXTND | TCPC_ALERT_EXTENDED_STATUS;
 
 	ret = max_tcpci_write16(chip, TCPC_ALERT_MASK, alert_mask);
 	if (ret < 0) {
@@ -315,6 +322,12 @@ static irqreturn_t _max_tcpci_irq(struct max_tcpci_chip *chip, u16 status)
 		}
 	}
 
+	if (status & TCPC_ALERT_EXTENDED_STATUS) {
+		ret = max_tcpci_read8(chip, TCPC_EXTENDED_STATUS, (u8 *)&reg_status);
+		if (ret >= 0 && (reg_status & TCPC_EXTENDED_STATUS_VSAFE0V))
+			tcpm_vbus_change(chip->port);
+	}
+
 	if (status & TCPC_ALERT_RX_STATUS)
 		process_rx(chip, status);
 
@@ -442,6 +455,7 @@ static int max_tcpci_probe(struct i2c_client *client, const struct i2c_device_id
 	chip->data.init = tcpci_init;
 	chip->data.frs_sourcing_vbus = max_tcpci_frs_sourcing_vbus;
 	chip->data.auto_discharge_disconnect = true;
+	chip->data.vbus_vsafe0v = true;
 
 	max_tcpci_init_regs(chip);
 	chip->tcpci = tcpci_register_port(chip->dev, &chip->data);
-- 
2.29.2.576.ga3fc446d84-goog

