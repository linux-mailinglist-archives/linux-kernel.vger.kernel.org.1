Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 823152935B3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 09:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405073AbgJTHZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 03:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404957AbgJTHZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 03:25:39 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CDCC0613CE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 00:25:39 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id i1so815440wro.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 00:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5VVp9f2mNGJBAPSam5WAwT9+D2hhOYou5JVDpyV+vTE=;
        b=NSkbzTZOOWvKxO+K8beU0TuLtC+EhYTVh4cLRQfh07M7CeXj01rirwDHwhv03iukUI
         6Eham2e0OYUeeGdLnLS05txGs1E4dJjEecyYBFchFd8kpidB8TwFBAGBSLN9evwx/LrH
         IyU0ZlNbzKhWzmzJbRXUEHb5fYP5iE7ESljMWz5NxJqaPcbo23B3xiRx/7FRtvcNxbPU
         9K0yBkRb/EvtSSFv10okNilxl2YR6nrQUgCQb0btTeHy/TvrqJxTPV+ZG7oWTD7U60WH
         WV2FwUtCcv5udgwZB9LZ7eEDsGVIGskjNYfv+vnPGBoOIOuF7ZgtsQfljv4jY99wNI8h
         EupA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5VVp9f2mNGJBAPSam5WAwT9+D2hhOYou5JVDpyV+vTE=;
        b=QD1uXAVqXnSvbfmSg2tmtq44vBjfwmdeEf8JJ+asisEmrHvvToSy4tf+RjH9idlwiU
         pPRSR8nCqtx6mot74gfFiV4Z3m3YEVflSvsHy2dLvuKJgl8iSZjPcJKMs7wDz0bSUe1s
         3qgeqew+b2dBe1x2GhO90yy6OlzkYWGZt3zcjtZLGE73HR3eq58GJ8ExtplgsLpIx26o
         rmW/rJqIUuxddHd1dQtki6MbbX1GykvYD9mJaCWzY0J9T+ROjcgjDwolT66GyLooVlaW
         VBvQaYCkh2xXMty9p3ZjrIPOE7cXhPR599MLm3ixVpXsF4hl42In0dKRT825AuP5ejAq
         emww==
X-Gm-Message-State: AOAM531nYqtAzDbSLSdQUtSrpiewU0JYCjoV+CQowFD/33ovlWNYoHbE
        MDCvlGTiePqlNQaZpeEcN8ea7w==
X-Google-Smtp-Source: ABdhPJyORIB9h8Z8aEJH+MxJnEe9wdeWTY1kS1pNnj75OXxGJTFJmRZev/Gi14x7t/L+Uewe1kfpyg==
X-Received: by 2002:a5d:63cb:: with SMTP id c11mr1706150wrw.243.1603178738057;
        Tue, 20 Oct 2020 00:25:38 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:3c62:4f82:8f5f:de74])
        by smtp.gmail.com with ESMTPSA id j5sm1487325wrx.88.2020.10.20.00.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 00:25:37 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     maz@kernel.org
Cc:     jbrunet@baylibre.com, linux-amlogic@lists.infradead.org,
        khilman@baylibre.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 1/2] irqchip: irq-meson-gpio: make it possible to build as a module
Date:   Tue, 20 Oct 2020 09:25:31 +0200
Message-Id: <20201020072532.949137-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201020072532.949137-1-narmstrong@baylibre.com>
References: <20201020072532.949137-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to reduce the kernel Image size on multi-platform distributions,
make it possible to build the Amlogic GPIO IRQ controller as a module
by switching it to a platform driver.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/irqchip/Kconfig          |  5 +-
 drivers/irqchip/irq-meson-gpio.c | 89 ++++++++++++++++++++------------
 2 files changed, 59 insertions(+), 35 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index bfc9719dbcdc..04fbae99a429 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -410,8 +410,9 @@ config IRQ_UNIPHIER_AIDET
 	  Support for the UniPhier AIDET (ARM Interrupt Detector).
 
 config MESON_IRQ_GPIO
-       bool "Meson GPIO Interrupt Multiplexer"
-       depends on ARCH_MESON
+       tristate "Meson GPIO Interrupt Multiplexer"
+       depends on ARCH_MESON || COMPILE_TEST
+       default ARCH_MESON
        select IRQ_DOMAIN_HIERARCHY
        help
          Support Meson SoC Family GPIO Interrupt Multiplexer
diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-gpio.c
index bc7aebcc96e9..e3b462bd3981 100644
--- a/drivers/irqchip/irq-meson-gpio.c
+++ b/drivers/irqchip/irq-meson-gpio.c
@@ -15,6 +15,7 @@
 #include <linux/irqchip.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/of_irq.h>
 
 #define NUM_CHANNEL 8
 #define MAX_INPUT_MUX 256
@@ -136,6 +137,7 @@ static const struct of_device_id meson_irq_gpio_matches[] = {
 struct meson_gpio_irq_controller {
 	const struct meson_gpio_irq_params *params;
 	void __iomem *base;
+	struct irq_domain *domain;
 	u32 channel_irqs[NUM_CHANNEL];
 	DECLARE_BITMAP(channel_map, NUM_CHANNEL);
 	spinlock_t lock;
@@ -436,8 +438,8 @@ static const struct irq_domain_ops meson_gpio_irq_domain_ops = {
 	.translate	= meson_gpio_irq_domain_translate,
 };
 
-static int __init meson_gpio_irq_parse_dt(struct device_node *node,
-					  struct meson_gpio_irq_controller *ctl)
+static int meson_gpio_irq_parse_dt(struct device_node *node,
+				   struct meson_gpio_irq_controller *ctl)
 {
 	const struct of_device_id *match;
 	int ret;
@@ -463,63 +465,84 @@ static int __init meson_gpio_irq_parse_dt(struct device_node *node,
 	return 0;
 }
 
-static int __init meson_gpio_irq_of_init(struct device_node *node,
-					 struct device_node *parent)
+static int meson_gpio_intc_probe(struct platform_device *pdev)
 {
-	struct irq_domain *domain, *parent_domain;
+	struct device_node *node = pdev->dev.of_node, *parent;
 	struct meson_gpio_irq_controller *ctl;
+	struct irq_domain *parent_domain;
+	struct resource *res;
 	int ret;
 
+	parent = of_irq_find_parent(node);
 	if (!parent) {
-		pr_err("missing parent interrupt node\n");
+		dev_err(&pdev->dev, "missing parent interrupt node\n");
 		return -ENODEV;
 	}
 
 	parent_domain = irq_find_host(parent);
 	if (!parent_domain) {
-		pr_err("unable to obtain parent domain\n");
+		dev_err(&pdev->dev, "unable to obtain parent domain\n");
 		return -ENXIO;
 	}
 
-	ctl = kzalloc(sizeof(*ctl), GFP_KERNEL);
+	ctl = devm_kzalloc(&pdev->dev, sizeof(*ctl), GFP_KERNEL);
 	if (!ctl)
 		return -ENOMEM;
 
 	spin_lock_init(&ctl->lock);
 
-	ctl->base = of_iomap(node, 0);
-	if (!ctl->base) {
-		ret = -ENOMEM;
-		goto free_ctl;
-	}
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	ctl->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(ctl->base))
+		return PTR_ERR(ctl->base);
 
 	ret = meson_gpio_irq_parse_dt(node, ctl);
 	if (ret)
-		goto free_channel_irqs;
-
-	domain = irq_domain_create_hierarchy(parent_domain, 0,
-					     ctl->params->nr_hwirq,
-					     of_node_to_fwnode(node),
-					     &meson_gpio_irq_domain_ops,
-					     ctl);
-	if (!domain) {
-		pr_err("failed to add domain\n");
-		ret = -ENODEV;
-		goto free_channel_irqs;
+		return ret;
+
+	ctl->domain = irq_domain_create_hierarchy(parent_domain, 0,
+						  ctl->params->nr_hwirq,
+						  of_node_to_fwnode(node),
+						  &meson_gpio_irq_domain_ops,
+						  ctl);
+	if (!ctl->domain) {
+		dev_err(&pdev->dev, "failed to add domain\n");
+		return -ENODEV;
 	}
 
-	pr_info("%d to %d gpio interrupt mux initialized\n",
-		ctl->params->nr_hwirq, NUM_CHANNEL);
+	platform_set_drvdata(pdev, ctl);
+
+	dev_info(&pdev->dev, "%d to %d gpio interrupt mux initialized\n",
+		 ctl->params->nr_hwirq, NUM_CHANNEL);
 
 	return 0;
+}
 
-free_channel_irqs:
-	iounmap(ctl->base);
-free_ctl:
-	kfree(ctl);
+static int meson_gpio_intc_remove(struct platform_device *pdev)
+{
+	struct meson_gpio_irq_controller *ctl = platform_get_drvdata(pdev);
 
-	return ret;
+	irq_domain_remove(ctl->domain);
+
+	return 0;
 }
 
-IRQCHIP_DECLARE(meson_gpio_intc, "amlogic,meson-gpio-intc",
-		meson_gpio_irq_of_init);
+static const struct of_device_id meson_gpio_intc_of_match[] = {
+	{ .compatible = "amlogic,meson-gpio-intc", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, meson_gpio_intc_of_match);
+
+static struct platform_driver meson_gpio_intc_driver = {
+	.probe  = meson_gpio_intc_probe,
+	.remove = meson_gpio_intc_remove,
+	.driver = {
+		.name = "meson-gpio-intc",
+		.of_match_table = meson_gpio_intc_of_match,
+	},
+};
+module_platform_driver(meson_gpio_intc_driver);
+
+MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:meson-gpio-intc");
-- 
2.25.1

