Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5A0284A26
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 12:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgJFKLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 06:11:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:56822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725891AbgJFKLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 06:11:44 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CF3B206CB;
        Tue,  6 Oct 2020 10:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601979104;
        bh=y6sw+9UqcCw1K4zL+X8JeaJ21hZxWlVi1L/6R4CeGng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JvI4G2qxaaicO+5U+JGcn8IDN6VXKRg87Cfsmp+1D5LsqnAXUf6pNxTyoxHfmwWf7
         ATYRLyYv9BNWp5BK7o3G+YZmkAFyVxsZGkbLD6rRSMTZgjbXvB/mgt5eIzBwJf3gvH
         UM3eyQSUWEjYOaWoq9PdMii1gp2cH0CLwtE9K1Yo=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kPjwc-0002Qo-Jx; Tue, 06 Oct 2020 11:11:42 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Venkat Reddy Talla <vreddytalla@nvidia.com>,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com
Subject: [PATCH v2 2/4] gpio: tegra186: Allow optional irq parent callbacks
Date:   Tue,  6 Oct 2020 11:11:35 +0100
Message-Id: <20201006101137.1393797-3-maz@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201006101137.1393797-1-maz@kernel.org>
References: <20201006101137.1393797-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, thierry.reding@gmail.com, jonathanh@nvidia.com, digetx@gmail.com, skomatineni@nvidia.com, vreddytalla@nvidia.com, tglx@linutronix.de, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the tegra186 GPIO driver resistent to variable depth
interrupt hierarchy, which we are about to introduce.

No functionnal change yet.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/gpio/gpio-tegra186.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-tegra186.c b/drivers/gpio/gpio-tegra186.c
index 178e9128ded0..9500074b1f1b 100644
--- a/drivers/gpio/gpio-tegra186.c
+++ b/drivers/gpio/gpio-tegra186.c
@@ -430,7 +430,18 @@ static int tegra186_irq_set_type(struct irq_data *data, unsigned int type)
 	else
 		irq_set_handler_locked(data, handle_edge_irq);
 
-	return irq_chip_set_type_parent(data, type);
+	if (data->parent_data)
+		return irq_chip_set_type_parent(data, type);
+
+	return 0;
+}
+
+static int tegra186_irq_set_wake(struct irq_data *data, unsigned int on)
+{
+	if (data->parent_data)
+		return irq_chip_set_wake_parent(data, on);
+
+	return 0;
 }
 
 static void tegra186_gpio_irq(struct irq_desc *desc)
@@ -678,7 +689,7 @@ static int tegra186_gpio_probe(struct platform_device *pdev)
 	gpio->intc.irq_mask = tegra186_irq_mask;
 	gpio->intc.irq_unmask = tegra186_irq_unmask;
 	gpio->intc.irq_set_type = tegra186_irq_set_type;
-	gpio->intc.irq_set_wake = irq_chip_set_wake_parent;
+	gpio->intc.irq_set_wake = tegra186_irq_set_wake;
 
 	irq = &gpio->gpio.irq;
 	irq->chip = &gpio->intc;
-- 
2.28.0

