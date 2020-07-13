Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC0121C0AA
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jul 2020 01:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbgGJXSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jul 2020 19:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbgGJXSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 19:18:39 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A9FC08E6DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 16:18:39 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ls15so3240953pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 16:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qMRZ0NHrlcURRoHaqKwJd/gScGKjURbuurmLT4oMPDs=;
        b=siq3ZbTA8BVqEbOmQpqqMzjRPpTkpPlIz/ks6NqaULMEejA4YkYv/HOK6AB6c+Ru+p
         ckwa3ejAbmLnY6HDT2jT1n3vgy5z0SZ5gwYKdDBCDLbwXFqjP8vpJUm6QCqnF0ADlMxO
         GGp2Ei5aYGCGgTYSI3DhWhxfJjbcxSCrq0KA11CGIHICNMJVAiJWmBzlP1w8NjNZTQan
         tB0EzrdMVX7bbGxfULnfdLFA2ZeO6gq5lb7AVAuGBMpXVG8DefbouKG/WLX1Pq6VDCTc
         yr7XR4303DU9x7jRegGN4vnjs5SN6h2yHTK7gcCMKMWE1D+G7o/sYapLeCwE4Noj7ZsW
         KH3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qMRZ0NHrlcURRoHaqKwJd/gScGKjURbuurmLT4oMPDs=;
        b=FrIwXPpAEyLpESX1O587GcChXLK4bAmr/xAIi1KwxZMcJwwW+7GIdA1wOI3Ev6L4FG
         vcsPNuqfniSC0EXSe+CGMT9cUv1NP7usmP5ptJGK+HbLFZlrhpBjBAJ+M0p8bMGQyWdp
         84T8UXnvmF8P/ZhZp7QBq6ywl6kDBiICvX8UxGrS8IgSs0IjP1sY/ygJhvU1h6r3rGLn
         PkxGBt4h/nuKGYHe2pr/VZAOTi9fxp11918LMuy0+z3LWjxu6zJyzh9TcFpZ2G9OCadX
         iEsjgxF98nHS9P+9AG5eRV/FiNRyQGucIipqUqDKVl2TV0FOnpfondjWypJm6y6fw0jm
         tfrA==
X-Gm-Message-State: AOAM531VaNlPMcndaJFuhv/lnOpFTaJSDHrW04qosfUpBc+mOWTWjLzJ
        44/iPz/l9ieeAVK6VpxocBeRbh5RN48=
X-Google-Smtp-Source: ABdhPJwSbb79kmY7DkCicu1bibjmRmwkDhPsaYe4S7la9jpHz+4d4wDYfZdkm3pwOOLNjGKLc5IpCQ==
X-Received: by 2002:a17:90a:b00e:: with SMTP id x14mr8327273pjq.57.1594423118394;
        Fri, 10 Jul 2020 16:18:38 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id c14sm7296382pfj.82.2020.07.10.16.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 16:18:37 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Saravana Kannan <saravanak@google.com>,
        Todd Kjos <tkjos@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-gpio@vger.kernel.org
Subject: [PATCH v3 3/3] irqchip: Allow QCOM_PDC to be loadable as a permanent module
Date:   Fri, 10 Jul 2020 23:18:24 +0000
Message-Id: <20200710231824.60699-4-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200710231824.60699-1-john.stultz@linaro.org>
References: <20200710231824.60699-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allows qcom-pdc driver to be loaded as a permanent module

Also, due to the fact that IRQCHIP_DECLARE becomes a no-op when
building as a module, we have to replace it with platform driver
hooks explicitly.

Thanks to Saravana for his help on pointing out the
IRQCHIP_DECLARE issue and guidance on a solution.

Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Maulik Shah <mkshah@codeaurora.org>
Cc: Lina Iyer <ilina@codeaurora.org>
Cc: Saravana Kannan <saravanak@google.com>
Cc: Todd Kjos <tkjos@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: iommu@lists.linux-foundation.org
Cc: linux-gpio@vger.kernel.org
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v2: Fix spelling, include order and set suppress_bind_attrs
    suggested by Maulik Shah

v3: Drop conditional usage of IRQCHIP_DECLARE as suggested
    by Stephen Boyd and Marc Zyngier
---
 drivers/irqchip/Kconfig    |  2 +-
 drivers/irqchip/qcom-pdc.c | 28 +++++++++++++++++++++++++++-
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 216b3b8392b5..cc285c1a54c1 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -425,7 +425,7 @@ config GOLDFISH_PIC
          for Goldfish based virtual platforms.
 
 config QCOM_PDC
-	bool "QCOM PDC"
+	tristate "QCOM PDC"
 	depends on ARCH_QCOM
 	select IRQ_DOMAIN_HIERARCHY
 	help
diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
index 6ae9e1f0819d..5b624e3295e4 100644
--- a/drivers/irqchip/qcom-pdc.c
+++ b/drivers/irqchip/qcom-pdc.c
@@ -11,9 +11,11 @@
 #include <linux/irqdomain.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
+#include <linux/of_irq.h>
 #include <linux/soc/qcom/irq.h>
 #include <linux/spinlock.h>
 #include <linux/slab.h>
@@ -430,4 +432,28 @@ static int qcom_pdc_init(struct device_node *node, struct device_node *parent)
 	return ret;
 }
 
-IRQCHIP_DECLARE(qcom_pdc, "qcom,pdc", qcom_pdc_init);
+static int qcom_pdc_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct device_node *parent = of_irq_find_parent(np);
+
+	return qcom_pdc_init(np, parent);
+}
+
+static const struct of_device_id qcom_pdc_match_table[] = {
+	{ .compatible = "qcom,pdc" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, qcom_pdc_match_table);
+
+static struct platform_driver qcom_pdc_driver = {
+	.probe = qcom_pdc_probe,
+	.driver = {
+		.name = "qcom-pdc",
+		.of_match_table = qcom_pdc_match_table,
+		.suppress_bind_attrs = true,
+	},
+};
+module_platform_driver(qcom_pdc_driver);
+MODULE_DESCRIPTION("Qualcomm Technologies, Inc. Power Domain Controller");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

