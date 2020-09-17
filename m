Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39EB326D8CA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 12:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbgIQKVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 06:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbgIQKTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 06:19:54 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A95CC061223
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 03:19:23 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id a20so1044624qvk.17
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 03:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=zA8H3BQ321UpucntWuiVfxAfRqKe+kAL/iAoCw9UxL4=;
        b=G+4A8/0gdofBLcAtqzPJ11hiAfJvCOToPGpDq4JYHATKs3obIqAJeDjtJrOYKTZdQJ
         d4c+HT4BAp8cxTKGPUzMtjMJcwzbePIs6u1cDh2vXwAjf1kJ+4FuybZJOmPjqxGPfnNS
         L5TQ3O3HGATgnfcSiRr3Dlay4elOCCrZO0iIwjXYkHbeNNa+UoB5xt6+P3D8HjQob3Ea
         p/nO3TeEtxdeVO8oSvvaLUmdcRF74GeM7hQRmGAucU5Mf658ajsvKj9QRDnbc1EH08VX
         LG7x2WwD3bANCyktJpWpGqoWgGgijkQ/oWh9gm7E3tVCOoJXAeNZOu8rbRghTp40Thia
         H2jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zA8H3BQ321UpucntWuiVfxAfRqKe+kAL/iAoCw9UxL4=;
        b=OLhkFGQiLzLnq0ktzwedzkTkZCE4OMIOvSFMEJdmgBPuKacvhiHJPFHD/5CZWgnND0
         FgZOB9GgDut2DxT8rPZ8vkm6qLEBUmyT2ihwk5ojnQrEvizj9WXe0QXp2N/Ml5dO17Aq
         lmQCZytDCUsui+dDDkXLaaAq1y/n3ug0SnuinLxqeCvIYjtt+jowbye7020dmWX0tKf7
         h/uCLPJfNXrqgSRVIClV4LHIbCpQHAfQF3miG2HL0x0ZAPu9fQ/uctqHqGpPceD59ggV
         g8Catd31axSqqIUyNe6iqGx1krxaTEtpK83onavyZiTpAxifggp0sJT5I4aNEkJxiqzV
         ku5Q==
X-Gm-Message-State: AOAM531yneCeUuMlx4e7iMKcQr0syCBC3XDhpe0Gs5m05eK3O6x14k96
        aatUJSqHlB84snj5trRo/AVUOwtOw/g=
X-Google-Smtp-Source: ABdhPJwhGj45LAfuUF5VbI1E2LAchAMspUnyS+Ogf0Nn60XZNsfspZtS6tkP8eOdt3LFhRLZPHKPjodGQjU=
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:1:f292:1cff:fee0:66cf])
 (user=badhri job=sendgmr) by 2002:a0c:f30f:: with SMTP id j15mr11306123qvl.51.1600337962491;
 Thu, 17 Sep 2020 03:19:22 -0700 (PDT)
Date:   Thu, 17 Sep 2020 03:18:56 -0700
In-Reply-To: <20200917101856.3156869-1-badhri@google.com>
Message-Id: <20200917101856.3156869-11-badhri@google.com>
Mime-Version: 1.0
References: <20200917101856.3156869-1-badhri@google.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [PATCH v7 11/11] usb: typec: tcpci_maxim: Implemnent set_auto_vbus_discharge_threshold
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

Programs VBUS_SINK_DISCONNECT_THRESHOLD based on the power_role,
voltage requested as sink, mode of operation.

The programmed threshold is based on vSinkDisconnect and
vSinkDisconnectPD values.

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
Changes since v1:
- Changing patch version to v6 to fix version number confusion.

Changes since v6:
- Rebase on usb-next.
---
 drivers/usb/typec/tcpm/tcpci_maxim.c | 48 ++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpci_maxim.c b/drivers/usb/typec/tcpm/tcpci_maxim.c
index 723d7dd38f75..8289b596d2ee 100644
--- a/drivers/usb/typec/tcpm/tcpci_maxim.c
+++ b/drivers/usb/typec/tcpm/tcpci_maxim.c
@@ -137,6 +137,52 @@ static void max_tcpci_init_regs(struct max_tcpci_chip *chip)
 		return;
 }
 
+static int max_tcpci_set_auto_vbus_discharge_threshold(struct tcpci *tcpci, struct tcpci_data *data,
+						       enum typec_role port_role,
+						       enum typec_pwr_opmode mode, bool pps_active,
+						       u32 requested_vbus_voltage_mv)
+{
+	struct max_tcpci_chip *chip = tdata_to_max_tcpci(data);
+	u32 threshold = 0;
+	u8 pwr_ctrl;
+
+	/*
+	 * Indicates that vbus is going to go away due PR_SWAP, hard reset etc.
+	 * Do not discharge vbus here.
+	 */
+	if (requested_vbus_voltage_mv == 0)
+		goto write_thresh;
+
+	if (port_role == TYPEC_SINK) {
+		max_tcpci_read8(chip, TCPC_POWER_CTRL, &pwr_ctrl);
+		if (pwr_ctrl & TCPC_FAST_ROLE_SWAP_EN) {
+			/* To prevent disconnect when the source is fast role swap is capable. */
+			threshold = 3500;
+		} else if (mode == TYPEC_PWR_MODE_PD) {
+			if (pps_active)
+				threshold = (95 * requested_vbus_voltage_mv / 100) - 850;
+			else
+				threshold = (95 * requested_vbus_voltage_mv / 100) - 1250;
+		} else {
+			/* 3.5V for non-pd sink */
+			threshold = 3500;
+		}
+	} else {
+		/* 4V for source */
+		threshold = 4000;
+	}
+
+	threshold = threshold / TCPC_VBUS_SINK_DISCONNECT_THRESH_LSB;
+
+	if (threshold > TCPC_VBUS_SINK_DISCONNECT_THRESH_MAX) {
+		dev_err(chip->dev, "VBUS_SINK_DISCONNECT_THRESH out of range");
+		return -EINVAL;
+	}
+
+write_thresh:
+	return max_tcpci_write16(chip, TCPC_VBUS_SINK_DISCONNECT_THRESH, threshold);
+}
+
 static void process_rx(struct max_tcpci_chip *chip, u16 status)
 {
 	struct pd_message msg;
@@ -441,6 +487,8 @@ static int max_tcpci_probe(struct i2c_client *client, const struct i2c_device_id
 	chip->data.start_drp_toggling = max_tcpci_start_toggling;
 	chip->data.TX_BUF_BYTE_x_hidden = true;
 	chip->data.init = tcpci_init;
+	chip->data.set_auto_vbus_discharge_threshold = max_tcpci_set_auto_vbus_discharge_threshold;
+	chip->data.auto_discharge_disconnect = true;
 
 	max_tcpci_init_regs(chip);
 	chip->tcpci = tcpci_register_port(chip->dev, &chip->data);
-- 
2.28.0.618.gf4bc123cb7-goog

