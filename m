Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C93A626B921
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 02:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgIPA5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 20:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgIOLPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 07:15:01 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7ADC061354
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 04:01:23 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id c2so2374618ljj.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 04:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xSpHbTMRF5l19WgNcjU80aU88bYV7d4gSwfI8EzLalw=;
        b=yyMFQuI1h5MjsRDh0RoPYqvdO2aC3fzk9cDPN3EHzGepEPWwIEyol3ueu7Hy7yX885
         /vMQOv/HuZEiJlLgzQDEkAQ/OhDV11uwUhB20gy9kW619W25vBSOAy78Ed6JLB5zT6H+
         bCsMheI3kKxWDFjKGRg9W2oSRzE8u2OMnUjXlQUpXNo7d0n6aTrPAA/3atamjonMaStz
         8+1EvJKaQZGQhi4wziZqDEV9/5qri1Z2ouN1LZbQIQh2QhPApL8E8MUaVeB3HRV9/H8x
         Gw5udUfFW/LpvPSpTuQRhk6wAKk4k1GVGWNDNYU5Iwv2d52NUyAJqlTZMEIjhYcQcS4W
         TVhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xSpHbTMRF5l19WgNcjU80aU88bYV7d4gSwfI8EzLalw=;
        b=KOKFLjjc59c8dB0edKAb8Dw6qOFcwmExVQ/wbmYYoJkJGgHhOLPUoTce0QBPsrg/my
         tyh+jqJ6HUfc9daVoE/rTsmWbvtLCrCZzau5iZaIefqbyXMgc+iOOXebFEfjlgKFmsfb
         GkzpL0qYvp59FUUib+bCaAcAp+DlVfc+rklSZo0FOWYAo/Di/pynJBitJcR05N5/Vk42
         60wG1pYIYuHmh1dP29phZhIcObzeBPjBFZbmJE+KlOvcFs7TRiPHViKb0CYtPGaIm+NP
         f/nK8ncSKYn7Vp4BTRXOfHgHq+UPXEa3YoHdIo9n2q6UxynkRp5icrO2N0bOY6R0Tw4v
         G2Jg==
X-Gm-Message-State: AOAM5319KS06YVp6dDFSrZVwsNThkUQeadleNBS3GxqdGLcCo2jX1htS
        2MYltaot/aATmd95kjg5jFWcOQ==
X-Google-Smtp-Source: ABdhPJyhY6Qj6I9pnmWznT01a1K+SmOxj2MXEqZY9LkwAQW/Lq+lEQgWKmGKEGFDvSdunafFRasYiQ==
X-Received: by 2002:a2e:a543:: with SMTP id e3mr6304643ljn.33.1600167682043;
        Tue, 15 Sep 2020 04:01:22 -0700 (PDT)
Received: from gilgamesh.semihalf.com (193-106-246-138.noc.fibertech.net.pl. [193.106.246.138])
        by smtp.gmail.com with ESMTPSA id n3sm4588916ljj.59.2020.09.15.04.01.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2020 04:01:21 -0700 (PDT)
From:   Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
To:     tglx@linutronix.de, jason@lakedaemon.net, maz@kernel.org,
        s-anna@ti.com
Cc:     grzegorz.jaszczyk@linaro.org, robh+dt@kernel.org,
        lee.jones@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, david@lechnology.com,
        praneeth@ti.com
Subject: [PATCH v6 3/5] irqchip/irq-pruss-intc: Add logic for handling reserved interrupts
Date:   Tue, 15 Sep 2020 13:00:49 +0200
Message-Id: <1600167651-20851-4-git-send-email-grzegorz.jaszczyk@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600167651-20851-1-git-send-email-grzegorz.jaszczyk@linaro.org>
References: <1600167651-20851-1-git-send-email-grzegorz.jaszczyk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suman Anna <s-anna@ti.com>

The PRUSS INTC has a fixed number of output interrupt lines that are
connected to a number of processors or other PRUSS instances or other
devices (like DMA) on the SoC. The output interrupt lines 2 through 9
are usually connected to the main Arm host processor and are referred
to as host interrupts 0 through 7 from ARM/MPU perspective.

All of these 8 host interrupts are not always exclusively connected
to the Arm interrupt controller. Some SoCs have some interrupt lines
not connected to the Arm interrupt controller at all, while a few others
have the interrupt lines connected to multiple processors in which they
need to be partitioned as per SoC integration needs. For example, AM437x
and 66AK2G SoCs have 2 PRUSS instances each and have the host interrupt 5
connected to the other PRUSS, while AM335x has host interrupt 0 shared
between MPU and TSC_ADC and host interrupts 6 & 7 shared between MPU and
a DMA controller.

Add logic to the PRUSS INTC driver to ignore both these shared and
invalid interrupts.

Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
---
v5->v6:
- No change.
v4->v5:
- Rename: s/invalid_intr/irqs_reserved/
v3->v4:
- Due to changes in DT bindings which converts irqs-reserved
  property from uint8-array to bitmask requested by Rob introduce
  relevant changes in the driver.
- Merge the irqs-reserved and irqs-shared to one property since they
  can be handled by one logic (relevant change was introduced to DT
  binding).
- Update commit message.
v2->v3:
- Extra checks for (intc->irqs[i]) in error/remove path was moved from
  "irqchip/irq-pruss-intc: Add a PRUSS irqchip driver for PRUSS
  interrupts" to this patch
v1->v2:
- https://patchwork.kernel.org/patch/11069757/
---
 drivers/irqchip/irq-pruss-intc.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-pruss-intc.c b/drivers/irqchip/irq-pruss-intc.c
index 319e431..396dc55 100644
--- a/drivers/irqchip/irq-pruss-intc.c
+++ b/drivers/irqchip/irq-pruss-intc.c
@@ -484,7 +484,7 @@ static int pruss_intc_probe(struct platform_device *pdev)
 	struct pruss_intc *intc;
 	struct pruss_host_irq_data *host_data;
 	int i, irq, ret;
-	u8 max_system_events;
+	u8 max_system_events, irqs_reserved = 0;
 
 	data = of_device_get_match_data(dev);
 	if (!data)
@@ -504,6 +504,16 @@ static int pruss_intc_probe(struct platform_device *pdev)
 	if (IS_ERR(intc->base))
 		return PTR_ERR(intc->base);
 
+	ret = of_property_read_u8(dev->of_node, "ti,irqs-reserved",
+				  &irqs_reserved);
+
+	/*
+	 * The irqs-reserved is used only for some SoC's therefore not having
+	 * this property is still valid
+	 */
+	if (ret < 0 && ret != -EINVAL)
+		return ret;
+
 	pruss_intc_init(intc);
 
 	mutex_init(&intc->lock);
@@ -514,6 +524,9 @@ static int pruss_intc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	for (i = 0; i < MAX_NUM_HOST_IRQS; i++) {
+		if (irqs_reserved & BIT(i))
+			continue;
+
 		irq = platform_get_irq_byname(pdev, irq_names[i]);
 		if (irq <= 0) {
 			ret = (irq == 0) ? -EINVAL : irq;
@@ -538,8 +551,11 @@ static int pruss_intc_probe(struct platform_device *pdev)
 	return 0;
 
 fail_irq:
-	while (--i >= 0)
-		irq_set_chained_handler_and_data(intc->irqs[i], NULL, NULL);
+	while (--i >= 0) {
+		if (intc->irqs[i])
+			irq_set_chained_handler_and_data(intc->irqs[i], NULL,
+							 NULL);
+	}
 
 	irq_domain_remove(intc->domain);
 
@@ -553,8 +569,11 @@ static int pruss_intc_remove(struct platform_device *pdev)
 	unsigned int hwirq;
 	int i;
 
-	for (i = 0; i < MAX_NUM_HOST_IRQS; i++)
-		irq_set_chained_handler_and_data(intc->irqs[i], NULL, NULL);
+	for (i = 0; i < MAX_NUM_HOST_IRQS; i++) {
+		if (intc->irqs[i])
+			irq_set_chained_handler_and_data(intc->irqs[i], NULL,
+							 NULL);
+	}
 
 	for (hwirq = 0; hwirq < max_system_events; hwirq++)
 		irq_dispose_mapping(irq_find_mapping(intc->domain, hwirq));
-- 
2.7.4

