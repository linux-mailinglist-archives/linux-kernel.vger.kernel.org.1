Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D46FE2ADE85
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 19:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731432AbgKJSik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 13:38:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbgKJSii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 13:38:38 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEB5C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 10:38:38 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id z1so6902356plo.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 10:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JNtxpvgTzc5bWZyw6T79iLEmXOORaSxkxOXcRqjSA+I=;
        b=V/VVmTtXtVXUoX0xiC+htY7zcW6cDZ/uZrpw8Vv1p0KSrc0jY/U0wHOTlxdsBmT/q7
         r1rhVY+SkgJ1qsiCGrF+qclgswNfzxWRCqsuC2mBzmszQtmT1K/25f/9OQ/Zl+h1ju5B
         acjLvA149zV09j/yr6EjiTxyC4XNguiMmUTSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JNtxpvgTzc5bWZyw6T79iLEmXOORaSxkxOXcRqjSA+I=;
        b=jxEYk9H8GMZpJ62/8trolCn7ueu+NlTtfn3MUyOZpMEtQ1SYlPT+4ZuBEXeeHlCN8/
         2Snf6GjXmaEhGibB4ySS+J7ESu3DY9aYnV0E4/+faOZkiwG87Yd2sVNebh7HC99UDrA6
         txP2fp3hIXIOD6HTSZMijsLNY22EDNTwjdm7CpUgraLFXoAUHMm/enJGdp4uhZvYI4tz
         lfYocvxFx/S8JTe4+LhsC70J2xabsY7K8+nWYDAeBwADfLnHFxqZXsI3NAUWB3wR+zCa
         zjU8ap3Peq6IneEQC6tv5ykVH7nJJPdfkwHycKCdgYQP/sDXvHH1rHVAjxPG6SEYmlbx
         3+3A==
X-Gm-Message-State: AOAM532ixwes7MJX3bFPpXNbBm5dCXu4rtbHhbTeSQkNUNxGCeEmvBfO
        f5KjderVZ1aYv6uq04vEB3LSFQ==
X-Google-Smtp-Source: ABdhPJwZst0MZyXR65rSaIlrFNRU9vo5YsOT+aFXxCustmHvFtkJ62MJjWSkSdoywaMu8jqj5N2CpQ==
X-Received: by 2002:a17:902:d211:b029:d7:cd5e:2857 with SMTP id t17-20020a170902d211b02900d7cd5e2857mr14664521ply.45.1605033518156;
        Tue, 10 Nov 2020 10:38:38 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id x18sm9187988pfi.206.2020.11.10.10.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 10:38:37 -0800 (PST)
From:   Jim Quinlan <james.quinlan@broadcom.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc:     linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 2/2] firmware: arm_scmi: Augment SMC/HVC to allow optional interrupt
Date:   Tue, 10 Nov 2020 13:38:19 -0500
Message-Id: <20201110183827.19731-2-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201110183827.19731-1-james.quinlan@broadcom.com>
References: <20201110183827.19731-1-james.quinlan@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000b8ec7405b3c4fca6"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000b8ec7405b3c4fca6

The SMC/HVC SCMI transport is modified to allow the completion of an SCMI
message to be indicated by an interrupt rather than the return of the smc
call.  This accommodates the existing behavior of the BrcmSTB SCMI
"platform" whose SW is already out in the field and cannot be changed.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/firmware/arm_scmi/smc.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/firmware/arm_scmi/smc.c b/drivers/firmware/arm_scmi/smc.c
index 82a82a5dc86a..3bf935dbd00e 100644
--- a/drivers/firmware/arm_scmi/smc.c
+++ b/drivers/firmware/arm_scmi/smc.c
@@ -9,9 +9,11 @@
 #include <linux/arm-smccc.h>
 #include <linux/device.h>
 #include <linux/err.h>
+#include <linux/interrupt.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/of_irq.h>
 #include <linux/slab.h>
 
 #include "common.h"
@@ -23,6 +25,8 @@
  * @shmem: Transmit/Receive shared memory area
  * @shmem_lock: Lock to protect access to Tx/Rx shared memory area
  * @func_id: smc/hvc call function id
+ * @irq: Optional; employed when platforms indicates msg completion by intr.
+ * @tx_complete: Optional, employed only when irq is valid.
  */
 
 struct scmi_smc {
@@ -30,8 +34,19 @@ struct scmi_smc {
 	struct scmi_shared_mem __iomem *shmem;
 	struct mutex shmem_lock;
 	u32 func_id;
+	int irq;
+	struct completion tx_complete;
 };
 
+static irqreturn_t smc_msg_done_isr(int irq, void *data)
+{
+	struct scmi_smc *scmi_info = data;
+
+	complete(&scmi_info->tx_complete);
+
+	return IRQ_HANDLED;
+}
+
 static bool smc_chan_available(struct device *dev, int idx)
 {
 	struct device_node *np = of_parse_phandle(dev->of_node, "shmem", 0);
@@ -79,6 +94,20 @@ static int smc_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
 	if (ret < 0)
 		return ret;
 
+	/* Optional feature -- signal message completion using an interrupt */
+	ret = of_irq_get_byname(cdev->of_node, "msg-serviced");
+	if (ret > 0) {
+		scmi_info->irq = ret;
+		ret = devm_request_irq(dev, ret, smc_msg_done_isr,
+				       IRQF_NO_SUSPEND,
+				       dev_name(dev),
+				       scmi_info);
+		if (ret) {
+			dev_err(dev, "failed to setup SCMI smc irq\n");
+			return ret;
+		}
+		init_completion(&scmi_info->tx_complete);
+	}
 	scmi_info->func_id = func_id;
 	scmi_info->cinfo = cinfo;
 	mutex_init(&scmi_info->shmem_lock);
@@ -111,6 +140,8 @@ static int smc_send_message(struct scmi_chan_info *cinfo,
 	shmem_tx_prepare(scmi_info->shmem, xfer);
 
 	arm_smccc_1_1_invoke(scmi_info->func_id, 0, 0, 0, 0, 0, 0, 0, &res);
+	if (scmi_info->irq)
+		wait_for_completion(&scmi_info->tx_complete);
 	scmi_rx_callback(scmi_info->cinfo, shmem_read_header(scmi_info->shmem));
 
 	mutex_unlock(&scmi_info->shmem_lock);
-- 
2.17.1


--000000000000b8ec7405b3c4fca6
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
mOxPm7sNHsn0TVdPryi9+T2d8fVC/kUmuEdTYP/Hdu4W4b4T9BcW57fInYrmaJ+uotS6X59rAgMB
AAGjggHRMIIBzTAOBgNVHQ8BAf8EBAMCBaAwgZ4GCCsGAQUFBwEBBIGRMIGOME0GCCsGAQUFBzAC
hkFodHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc3BlcnNvbmFsc2lnbjJzaGEy
ZzNvY3NwLmNydDA9BggrBgEFBQcwAYYxaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL2dzcGVy
c29uYWxzaWduMnNoYTJnMzBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYm
aHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBEBgNVHR8E
PTA7MDmgN6A1hjNodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzcGVyc29uYWxzaWduMnNoYTJn
My5jcmwwJQYDVR0RBB4wHIEaamFtZXMucXVpbmxhbkBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYI
KwYBBQUHAwQwHwYDVR0jBBgwFoAUaXKCYjFnlUSFd5GAxAQ2SZ17C2EwHQYDVR0OBBYEFNYm4GDl
4WOt3laB3gNKFfYyaM8bMA0GCSqGSIb3DQEBCwUAA4IBAQBD+XYEgpG/OqeRgXAgDF8sa+lQ/00T
wCP/3nBzwZPblTyThtDE/iaL/YZ5rdwqXwdCnSFh9cMhd/bnA+Eqw89clgTixvz9MdL9Vuo8LACI
VpHO+sxZ2Cu3bO5lpK+UVCyr21y1zumOICsOuu4MJA5mtkpzBXQiA7b/ogjGxG+5iNjt9FAMX4JP
V6GuAMmRknrzeTlxPy40UhUcRKk6Nm8mxl3Jh4KB68z7NFVpIx8G5w5I7S5ar1mLGNRjtFZ0RE4O
lcCwKVGUXRaZMgQGrIhxGVelVgrcBh2vjpndlv733VI2VKE/TvV5MxMGU18RnogYSm66AEFA/Zb+
5ztz1AtIMYICbzCCAmsCAQEwbTBdMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBu
di1zYTEzMDEGA1UEAxMqR2xvYmFsU2lnbiBQZXJzb25hbFNpZ24gMiBDQSAtIFNIQTI1NiAtIEcz
AgwTv2xmtR4KOmK4QvMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEILOK0EYoMJAv
rfpR3GoZwFZmMcfOoHfc6RiqaamhlBOSMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIwMTExMDE4MzgzOFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQDOFrlSiBpKI3AJC36yLWH35XpqZoSX
z4SFEWLgofD0F7rN0eVb47NONaddtX9/U97jRZGMRInwFTlXW3KRk7Gl5SA/7+iqJSNgsTCvicfP
VgobBgHFn5r/4ixVq9Z+D93wLCQnJ5UYITmngwGIweQM6yRmNNi8aKTmBcZMZUOjBSaY6h8G89Uz
cXLUCAAurUNJNzIr+E7NCcFicdrZpeoYiIkE6qUZrhIo7pnFx2d/JtNTV92/hxtaIjwEySNFH4D7
0bu/lD9BZMAMymZlkLakJJ/S9HKiQiXtUUeZzQt3ShvcSx2gv4irFPtmQwCOYBHlgGuooLKz/HHM
lVEfZyrS
--000000000000b8ec7405b3c4fca6--
