Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF0D829F5B8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 21:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgJ2UAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 16:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgJ2T7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 15:59:40 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E390DC0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 12:59:40 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id x13so3235383pgp.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 12:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AEXgwq3FKjZj4Ce/uZ/F5+MLx8Ti1Cj9YgDrjQQ/bpM=;
        b=ELI5DEnI01IcMOiUY6hndtm/vrpna6Bub6ULNC0s13OHzznYIvSz2iUaTwbPTyDuwN
         3oWS8stKa7XGbCLmgpgerbzjLqO5aSD/dKzbrUnEPYv/GVEIqPOQc8FngleE8mr68bty
         uhPEY/DlFx/KDsVciqzz+MOxlR3GXzLLAIm6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AEXgwq3FKjZj4Ce/uZ/F5+MLx8Ti1Cj9YgDrjQQ/bpM=;
        b=RncD1+5PjoMnBiovqhodWPibWN3upGqERQfyGZRXN0XcEEC9E8Rg0BwtVU3MFkJym4
         0jiK3eRjR14EiAfg2CR2LwoGidXrDREQyyO+pNrohpEOylpTj0oqtMfNB5w4iNdDnS9s
         ZoOIgRiU/bHhWbAXAXmjYxsSRS4D5dyNj3vYuMbbNpLcoGeL3yjtAVetjgus+XA4Qh8/
         XBjHfne6fFrbpdvLPrejL727BEhLw1qayHSeLjRol3h8S4jcsz5YK5HwO6hQZ+1maNpX
         AhL3opR6MeAxv1v1BwPt1mfX7stni/PcVCA3L6iF3YfL0axWHgRRpi0uR17LhPMQ8GL6
         rjtg==
X-Gm-Message-State: AOAM530Zn+GLrlco3GyZg9JVO9O31cVVtf3uwGkbe+gtpf1CVoe0rzHj
        cCU9Z04tGptIImDkl0vtslkIWQ==
X-Google-Smtp-Source: ABdhPJxw2btUQCiyWuXnf9YWx0cW+IeYiSD6HvXNtuz6KayzYKPDm/QPcGxnTLZfRvEc+ZIdzMc3PQ==
X-Received: by 2002:a62:cf06:0:b029:161:90d5:c19f with SMTP id b6-20020a62cf060000b029016190d5c19fmr6004159pfg.37.1604001580308;
        Thu, 29 Oct 2020 12:59:40 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id z27sm3682662pfr.206.2020.10.29.12.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 12:59:39 -0700 (PDT)
From:   Jim Quinlan <james.quinlan@broadcom.com>
To:     sudeep.holla@arm.com, bcm-kernel-feedback-list@broadcom.com,
        james.quinlan@broadcom.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-kernel@vger.kernel.org (open list),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE)
Subject: [PATCH v4 2/2] mailbox: Add Broadcom STB mailbox driver
Date:   Thu, 29 Oct 2020 15:59:07 -0400
Message-Id: <20201029195913.5927-3-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201029195913.5927-1-james.quinlan@broadcom.com>
References: <20201029195913.5927-1-james.quinlan@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000007012eb05b2d4b86d"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000007012eb05b2d4b86d

This is a simple mailbox driver to be used by the SCMI protocol stack.  It
only implements the agent-to-platform channel; we may implement the
platform-to-agent channel in the future.  An unusual aspect of this driver
is how the completion of an SCMI message is indicated.  An SCMI message is
initiated with an ARM SMC call, but the return of this call does not
indicate the execution or completion of the message.  Rather, the message's
completion is signaled by an interrupt.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/mailbox/Kconfig           |  12 +++
 drivers/mailbox/Makefile          |   2 +
 drivers/mailbox/brcmstb-mailbox.c | 167 ++++++++++++++++++++++++++++++
 3 files changed, 181 insertions(+)
 create mode 100644 drivers/mailbox/brcmstb-mailbox.c

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 05b1009e2820..b1e697e8d5f9 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -254,4 +254,16 @@ config QCOM_IPCC
 	  acts as an interrupt controller for receiving interrupts from clients.
 	  Say Y here if you want to build this driver.
 
+config BRCMSTB_MBOX
+	tristate "Broadcom STB Mailbox"
+	depends on ARM64 || ARM
+	depends on ARM_SCMI_PROTOCOL && ARCH_BRCMSTB
+	default ARM_SCMI_PROTOCOL && ARCH_BRCMSTB
+	help
+	  Mailbox implementation of the Broadcom STB for the sole purposes
+	  of SCMI communication.  This is used by the SCMI drivers to
+	  communicate with FW that runs in EL3.  This mailbox only implements
+	  the agent-to-platform channgel of SCMI but may be augmented in
+	  the future to add the platform-to-agent channel.
+
 endif
diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index 2e06e02b2e03..95fbcd121f2e 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -54,3 +54,5 @@ obj-$(CONFIG_SUN6I_MSGBOX)	+= sun6i-msgbox.o
 obj-$(CONFIG_SPRD_MBOX)		+= sprd-mailbox.o
 
 obj-$(CONFIG_QCOM_IPCC)		+= qcom-ipcc.o
+
+obj-$(CONFIG_BRCMSTB_MBOX)	+= brcmstb-mailbox.o
diff --git a/drivers/mailbox/brcmstb-mailbox.c b/drivers/mailbox/brcmstb-mailbox.c
new file mode 100644
index 000000000000..d9e953995417
--- /dev/null
+++ b/drivers/mailbox/brcmstb-mailbox.c
@@ -0,0 +1,167 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2017-2020, Broadcom */
+
+#include <linux/kernel.h>
+#include <linux/interrupt.h>
+#include <linux/mailbox_controller.h>
+#include <linux/mailbox_client.h>
+#include <linux/module.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/arm-smccc.h>
+
+#define BRCM_SCMI_SMC_OEM_FUNC	0x400
+#define BRCM_SCMI_MBOX_NUM	0
+#define BRCM_FID(ch) ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, \
+			IS_ENABLED(CONFIG_ARM64), \
+			ARM_SMCCC_OWNER_OEM, \
+			BRCM_SCMI_SMC_OEM_FUNC + (ch))
+enum {
+	A2P_CHAN = 0,
+	NUM_CHAN
+};
+
+struct chan_priv {
+	unsigned int mbox_num;
+	unsigned int ch;
+};
+
+struct brcm_mbox {
+	struct mbox_controller controller;
+	int irqs[NUM_CHAN];
+};
+
+static struct mbox_chan *brcm_mbox_of_xlate(struct mbox_controller *controller,
+					    const struct of_phandle_args *sp)
+{
+	unsigned int ch = sp->args[0];
+	struct brcm_mbox *mbox
+		= container_of(controller, struct brcm_mbox, controller);
+
+	if (!mbox || ch >= NUM_CHAN)
+		return ERR_PTR(-ENOENT);
+
+	return &mbox->controller.chans[ch];
+}
+
+static int announce_msg(unsigned int mbox_num, unsigned int ch)
+{
+	struct arm_smccc_res res;
+
+	if (ch >= NUM_CHAN)
+		return -EIO;
+	arm_smccc_smc(BRCM_FID(ch), mbox_num, 0, 0, 0, 0, 0, 0, &res);
+	if (res.a0)
+		return -EIO;
+	return 0;
+}
+
+static int brcm_mbox_send_data(struct mbox_chan *chan, void *data)
+{
+	struct chan_priv *priv = chan->con_priv;
+
+	return announce_msg(priv->mbox_num, priv->ch);
+}
+
+static int brcm_mbox_startup(struct mbox_chan *chan)
+{
+	return 0;
+}
+
+static const struct mbox_chan_ops brcm_mbox_ops = {
+	.send_data = brcm_mbox_send_data,
+	.startup = brcm_mbox_startup,
+};
+
+static irqreturn_t brcm_a2p_isr(int irq, void *data)
+{
+	struct mbox_chan *chan = data;
+
+	mbox_chan_received_data(chan, NULL);
+	return IRQ_HANDLED;
+}
+
+static int brcm_mbox_probe(struct platform_device *pdev)
+{
+	struct brcm_mbox *mbox;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct chan_priv *chan_priv;
+	int ret;
+
+	if (!np)
+		return -EINVAL;
+
+	mbox = devm_kzalloc(&pdev->dev, sizeof(*mbox), GFP_KERNEL);
+	if (!mbox)
+		return -ENOMEM;
+
+	/* Allocate channels */
+	mbox->controller.chans = devm_kzalloc(
+		&pdev->dev, NUM_CHAN * sizeof(struct mbox_chan), GFP_KERNEL);
+	if (!mbox->controller.chans)
+		return -ENOMEM;
+	chan_priv = devm_kzalloc(
+		&pdev->dev, NUM_CHAN * sizeof(struct chan_priv), GFP_KERNEL);
+	if (!chan_priv)
+		return -ENOMEM;
+
+	mbox->irqs[A2P_CHAN] = platform_get_irq(pdev, 0);
+	ret = devm_request_irq(&pdev->dev, mbox->irqs[A2P_CHAN], brcm_a2p_isr,
+				IRQF_NO_SUSPEND, "brcm: SCMI a2p intr",
+				&mbox->controller.chans[A2P_CHAN]);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to setup SCMI a2p isr\n");
+		return ret;
+	}
+	chan_priv[A2P_CHAN].mbox_num = BRCM_SCMI_MBOX_NUM;
+	chan_priv[A2P_CHAN].ch = A2P_CHAN;
+	mbox->controller.chans[A2P_CHAN].con_priv = &chan_priv[A2P_CHAN];
+	mbox->controller.num_chans++;
+	mbox->controller.dev = &pdev->dev;
+	mbox->controller.ops = &brcm_mbox_ops;
+	mbox->controller.of_xlate = brcm_mbox_of_xlate;
+	ret = mbox_controller_register(&mbox->controller);
+	if (ret) {
+		dev_err(dev, "failed to register BrcmSTB mbox\n");
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, mbox);
+	return 0;
+}
+
+static int brcm_mbox_remove(struct platform_device *pdev)
+{
+	struct brcm_mbox *mbox = platform_get_drvdata(pdev);
+
+	mbox_controller_unregister(&mbox->controller);
+
+	return 0;
+}
+
+static const struct of_device_id brcm_mbox_of_match[] = {
+	{ .compatible = "brcm,brcmstb-mbox", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, brcm_mbox_of_match);
+
+static struct platform_driver brcm_mbox_driver = {
+	.probe = brcm_mbox_probe,
+	.remove = brcm_mbox_remove,
+	.driver = {
+		.name = "brcm_mbox",
+		.of_match_table = brcm_mbox_of_match,
+	},
+};
+
+module_platform_driver(brcm_mbox_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Broadcom STB SCMI Mailbox driver");
+MODULE_AUTHOR("Broadcom");
-- 
2.17.1


--0000000000007012eb05b2d4b86d
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
AgwTv2xmtR4KOmK4QvMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIKYzpIoVNXsZ
lG8rP7Ubv6M31g7j9KXqKiFspImq/IN9MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIwMTAyOTE5NTk0MFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQC7gNeHIPTGnN5eNK2/HTSOLRTmItSj
ZSH4s1a2wpfMT1SoHjIk5yfJnoS873I4VlJ5W0/6OK/uowdDJknndAa7XZNWBOyBa4rHFxuj/xZl
NQa9gzp7hbK6l0dLeYNp5dy9QaE0DHnuzyOA1S1+WIh7MWah6ly1lEXvVcyhrSpBN7IfQzzx5Hoo
pkWaO8i9ZumIO878qb7IX0OqsCUZKTsnL52XXZypcv9D+cqimhzWSelVz4gbx1TW+TiFedV05vsZ
tSC5DpM+Sun/e3gdq3L0ryIGBrXPHgcViWuuo2fmIg+QNSmPe4og/8OL5LUtYCEUd1wbIja6gVjt
LuZUAPYu
--0000000000007012eb05b2d4b86d--
