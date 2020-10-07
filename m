Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 048C3285F76
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 14:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbgJGMqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 08:46:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:58294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728320AbgJGMp7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 08:45:59 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D1112080A;
        Wed,  7 Oct 2020 12:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602074758;
        bh=TNw0xhLAmuLxi/z2k28H4w4A4c5/Nmqw8znZJEz8AkA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t3fGeAIb3VbFeJuvTeZAe7GaAWh24Ii9Fm6DJiHD38zIwko2TyuELqmX941euuVgx
         f6/MhB26wzGxeSZ5T+qHiy4fARHLh6c8R7YhlzZuR/4kr+IGU36NllGC5dn/Q517Kg
         zHsemVg+AzYofk0dL8LxfWHVsWB4HaE8tKSuxr/8=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kQ8pQ-000M8V-Rv; Wed, 07 Oct 2020 13:45:56 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Venkat Reddy Talla <vreddytalla@nvidia.com>,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com
Subject: [PATCH v3 3/4] soc/tegra: pmc: Allow optional irq parent callbacks
Date:   Wed,  7 Oct 2020 13:45:43 +0100
Message-Id: <20201007124544.1397322-4-maz@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201007124544.1397322-1-maz@kernel.org>
References: <20201007124544.1397322-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, thierry.reding@gmail.com, jonathanh@nvidia.com, digetx@gmail.com, skomatineni@nvidia.com, vreddytalla@nvidia.com, tglx@linutronix.de, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the PMC driver resistent to variable depth interrupt hierarchy,
which we are about to introduce.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/soc/tegra/pmc.c | 36 ++++++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index d332e5d9abac..b39536c68f45 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -2184,6 +2184,34 @@ static int tegra186_pmc_irq_set_type(struct irq_data *data, unsigned int type)
 	return 0;
 }
 
+static void tegra_irq_mask_parent(struct irq_data *data)
+{
+	if (data->parent_data)
+		irq_chip_mask_parent(data);
+}
+
+static void tegra_irq_unmask_parent(struct irq_data *data)
+{
+	if (data->parent_data)
+		irq_chip_unmask_parent(data);
+}
+
+static void tegra_irq_eoi_parent(struct irq_data *data)
+{
+	if (data->parent_data)
+		irq_chip_eoi_parent(data);
+}
+
+static int tegra_irq_set_affinity_parent(struct irq_data *data,
+					 const struct cpumask *dest,
+					 bool force)
+{
+	if (data->parent_data)
+		return irq_chip_set_affinity_parent(data, dest, force);
+
+	return -EINVAL;
+}
+
 static int tegra_pmc_irq_init(struct tegra_pmc *pmc)
 {
 	struct irq_domain *parent = NULL;
@@ -2199,10 +2227,10 @@ static int tegra_pmc_irq_init(struct tegra_pmc *pmc)
 		return 0;
 
 	pmc->irq.name = dev_name(pmc->dev);
-	pmc->irq.irq_mask = irq_chip_mask_parent;
-	pmc->irq.irq_unmask = irq_chip_unmask_parent;
-	pmc->irq.irq_eoi = irq_chip_eoi_parent;
-	pmc->irq.irq_set_affinity = irq_chip_set_affinity_parent;
+	pmc->irq.irq_mask = tegra_irq_mask_parent;
+	pmc->irq.irq_unmask = tegra_irq_unmask_parent;
+	pmc->irq.irq_eoi = tegra_irq_eoi_parent;
+	pmc->irq.irq_set_affinity = tegra_irq_set_affinity_parent;
 	pmc->irq.irq_set_type = pmc->soc->irq_set_type;
 	pmc->irq.irq_set_wake = pmc->soc->irq_set_wake;
 
-- 
2.28.0

