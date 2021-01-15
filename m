Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2712F80DD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 17:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbhAOQeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 11:34:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbhAOQeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 11:34:13 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABCFC061793
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 08:33:32 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 33so6728452pgv.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 08:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=62Wh0CeYlqFdRUYiB3/MOzXQKL6e2IcczSb2KRUZCqI=;
        b=OuyIjO3hp0uQC2TSHc2qrTIXxfnOs7ztiwn9EZ7R5CzNuGeG0A4f6aKQO9vUq6cIza
         nkLu/E+w0oU4SYLPL0alNRU23Oe6NzHShuBDdUYlJBx4um1+6OAYYfMtZGhT+lHDEfCM
         kNy0YXyn32VkUVrOgRDPt+mNlq1eGL2LghbD/ixdvFv3doHDTtjIArc5oq5elbXUSOrQ
         VlsSYynidpdk9q3U0ydVU8MEF0lxkc11FZwxEzwEE04BSrbtr/bwDjjQpq3Mu6iqP0w0
         sLyQitiaMKL7RwolGt6EY2YUkuJ3sFXbb+nRQLWMB7EIe0DVHegQ1hmG/Yl+Fo/3aPze
         xx5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=62Wh0CeYlqFdRUYiB3/MOzXQKL6e2IcczSb2KRUZCqI=;
        b=XJD6AzMifvHWPuIioIU8VNP0yFIA3gb5JoQqIXzriM6rkQFG1i3wceEP76mU8m75Xj
         kl3Ija0wEsOu94IWJ1kKGs8UyKZv6WElv6kNkmjOqsVWJcMvOJNHhuTg58OLFyjXdNDo
         uP7HHaAc4g6bYSxt1dArw/R1YRX8qb+DnF655tK0OU7cIvuut/62KSWcQdmuE40JyI3Z
         KZSkaklLWpf7zQcg0GKZR9UIZzRLdl5yy4f8VcWxGmpZqja//9503est8F058lzGQB6k
         VBxbZPj3olCTHrbUuYrZDyQcoLbKD/mf2VWuVMEcJ9VEMBsZ/XnJM/YbVvmqBV6jBYCN
         9C7Q==
X-Gm-Message-State: AOAM531hZfgh62pYIgkeRYi6cwfkRpuGUGolDkHvitSeZjk0cYIOAi1I
        Tt2MisGvjnv4UW4C2IGNN3P8TqAWOmus
X-Google-Smtp-Source: ABdhPJyhoTSneMN702u7mmXV5SKQRhJqAx9inqTZ/91e9ET9qgOo5p861OBlWOzP9+MW/eDDPo76oOUiwFcL
Sender: "kyletso via sendgmr" <kyletso@kyletso.ntc.corp.google.com>
X-Received: from kyletso.ntc.corp.google.com ([2401:fa00:fc:202:c526:801e:f282:58de])
 (user=kyletso job=sendgmr) by 2002:a62:b410:0:b029:1a4:7868:7e4e with SMTP id
 h16-20020a62b4100000b02901a478687e4emr13709797pfn.62.1610728412345; Fri, 15
 Jan 2021 08:33:32 -0800 (PST)
Date:   Sat, 16 Jan 2021 00:33:11 +0800
Message-Id: <20210115163311.391332-1-kyletso@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH] usb: typec: tcpm: Create legacy PDOs for PD2 connection
From:   Kyle Tso <kyletso@google.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kyle Tso <kyletso@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the port partner is PD2, the PDOs of the local port should follow the
format defined in PD2 Spec. Dynamically modify the pre-defined PD3 PDOs
and transform them into PD2 format before sending them to the PD2 port
partner.

Signed-off-by: Kyle Tso <kyletso@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 62 +++++++++++++++++++++++++++++------
 include/linux/usb/pd.h        |  1 +
 2 files changed, 53 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 22a85b396f69..1220ab1ed47d 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -911,13 +911,47 @@ static int tcpm_set_pwr_role(struct tcpm_port *port, enum typec_role role)
 	return 0;
 }
 
+/*
+ * Transform the PDO to be compliant to PD rev2.0.
+ * Return 0 if the PDO type is not defined in PD rev2.0.
+ * Otherwise, return the converted PDO.
+ */
+static u32 tcpm_forge_legacy_pdo(struct tcpm_port *port, u32 pdo, enum typec_role role)
+{
+	switch (pdo_type(pdo)) {
+	case PDO_TYPE_FIXED:
+		if (role == TYPEC_SINK)
+			return pdo & ~PDO_FIXED_FRS_CURR_MASK;
+		else
+			return pdo & ~PDO_FIXED_UNCHUNK_EXT;
+	case PDO_TYPE_VAR:
+	case PDO_TYPE_BATT:
+		return pdo;
+	case PDO_TYPE_APDO:
+	default:
+		return 0;
+	}
+}
+
 static int tcpm_pd_send_source_caps(struct tcpm_port *port)
 {
 	struct pd_message msg;
-	int i;
+	u32 pdo;
+	unsigned int i, nr_pdo = 0;
 
 	memset(&msg, 0, sizeof(msg));
-	if (!port->nr_src_pdo) {
+
+	for (i = 0; i < port->nr_src_pdo; i++) {
+		if (port->negotiated_rev >= PD_REV30) {
+			msg.payload[nr_pdo++] =	cpu_to_le32(port->src_pdo[i]);
+		} else {
+			pdo = tcpm_forge_legacy_pdo(port, port->src_pdo[i], TYPEC_SOURCE);
+			if (pdo)
+				msg.payload[nr_pdo++] = cpu_to_le32(pdo);
+		}
+	}
+
+	if (!nr_pdo) {
 		/* No source capabilities defined, sink only */
 		msg.header = PD_HEADER_LE(PD_CTRL_REJECT,
 					  port->pwr_role,
@@ -930,10 +964,8 @@ static int tcpm_pd_send_source_caps(struct tcpm_port *port)
 					  port->data_role,
 					  port->negotiated_rev,
 					  port->message_id,
-					  port->nr_src_pdo);
+					  nr_pdo);
 	}
-	for (i = 0; i < port->nr_src_pdo; i++)
-		msg.payload[i] = cpu_to_le32(port->src_pdo[i]);
 
 	return tcpm_pd_transmit(port, TCPC_TX_SOP, &msg);
 }
@@ -941,10 +973,22 @@ static int tcpm_pd_send_source_caps(struct tcpm_port *port)
 static int tcpm_pd_send_sink_caps(struct tcpm_port *port)
 {
 	struct pd_message msg;
-	int i;
+	u32 pdo;
+	unsigned int i, nr_pdo = 0;
 
 	memset(&msg, 0, sizeof(msg));
-	if (!port->nr_snk_pdo) {
+
+	for (i = 0; i < port->nr_snk_pdo; i++) {
+		if (port->negotiated_rev >= PD_REV30) {
+			msg.payload[nr_pdo++] =	cpu_to_le32(port->snk_pdo[i]);
+		} else {
+			pdo = tcpm_forge_legacy_pdo(port, port->snk_pdo[i], TYPEC_SINK);
+			if (pdo)
+				msg.payload[nr_pdo++] = cpu_to_le32(pdo);
+		}
+	}
+
+	if (!nr_pdo) {
 		/* No sink capabilities defined, source only */
 		msg.header = PD_HEADER_LE(PD_CTRL_REJECT,
 					  port->pwr_role,
@@ -957,10 +1001,8 @@ static int tcpm_pd_send_sink_caps(struct tcpm_port *port)
 					  port->data_role,
 					  port->negotiated_rev,
 					  port->message_id,
-					  port->nr_snk_pdo);
+					  nr_pdo);
 	}
-	for (i = 0; i < port->nr_snk_pdo; i++)
-		msg.payload[i] = cpu_to_le32(port->snk_pdo[i]);
 
 	return tcpm_pd_transmit(port, TCPC_TX_SOP, &msg);
 }
diff --git a/include/linux/usb/pd.h b/include/linux/usb/pd.h
index bb9a782e1411..88f64bce5dea 100644
--- a/include/linux/usb/pd.h
+++ b/include/linux/usb/pd.h
@@ -225,6 +225,7 @@ enum pd_pdo_type {
 #define PDO_FIXED_EXTPOWER		BIT(27) /* Externally powered */
 #define PDO_FIXED_USB_COMM		BIT(26) /* USB communications capable */
 #define PDO_FIXED_DATA_SWAP		BIT(25) /* Data role swap supported */
+#define PDO_FIXED_UNCHUNK_EXT		BIT(24) /* Unchunked Extended Message supported (Source) */
 #define PDO_FIXED_FRS_CURR_MASK		(BIT(24) | BIT(23)) /* FR_Swap Current (Sink) */
 #define PDO_FIXED_FRS_CURR_SHIFT	23
 #define PDO_FIXED_VOLT_SHIFT		10	/* 50mV units */
-- 
2.30.0.284.gd98b1dd5eaa7-goog

