Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C08FE25910B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 16:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbgIAOnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 10:43:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:57126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728604AbgIAOng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 10:43:36 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C45E21D7D;
        Tue,  1 Sep 2020 14:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598971415;
        bh=WYho98u1Z3uUEjOuiK+CeonKhHJ+0ZsBT08SZ6m+SF8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=of29RUxba+qmDgefy0G9TjNDK9JvvbXNVxokTjv9+gvqNoz9AvC8zrQcmRG3qfR27
         GShKqppTb0YEYRhAsgTLe22OXkMsMFvJasxijkL95O9hWkEoibdhfL59OlYq3gBHST
         hyZ1k/Ro1VZkfvLKN7r+JBvvUgTiBtK01j2WaZbM=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kD7VV-008IQP-L0; Tue, 01 Sep 2020 15:43:33 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Sumit Garg <sumit.garg@linaro.org>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Saravana Kannan <saravanak@google.com>,
        kernel-team@android.com,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: [PATCH v3 05/16] irqchip/gic-v3: Describe the SGI range
Date:   Tue,  1 Sep 2020 15:43:13 +0100
Message-Id: <20200901144324.1071694-6-maz@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200901144324.1071694-1-maz@kernel.org>
References: <20200901144324.1071694-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, linux@arm.linux.org.uk, tglx@linutronix.de, jason@lakedaemon.net, sumit.garg@linaro.org, Valentin.Schneider@arm.com, f.fainelli@gmail.com, gregory.clement@bootlin.com, andrew@lunn.ch, saravanak@google.com, kernel-team@android.com, valentin.schneider@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we are about to start making use of SGIs in a more conventional
way, let's describe it is the GICv3 list of interrupt types.

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 850842f27bee..f7c99a302d01 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -112,6 +112,7 @@ static DEFINE_PER_CPU(bool, has_rss);
 #define DEFAULT_PMR_VALUE	0xf0
 
 enum gic_intid_range {
+	SGI_RANGE,
 	PPI_RANGE,
 	SPI_RANGE,
 	EPPI_RANGE,
@@ -123,6 +124,8 @@ enum gic_intid_range {
 static enum gic_intid_range __get_intid_range(irq_hw_number_t hwirq)
 {
 	switch (hwirq) {
+	case 0 ... 15:
+		return SGI_RANGE;
 	case 16 ... 31:
 		return PPI_RANGE;
 	case 32 ... 1019:
@@ -148,15 +151,22 @@ static inline unsigned int gic_irq(struct irq_data *d)
 	return d->hwirq;
 }
 
-static inline int gic_irq_in_rdist(struct irq_data *d)
+static inline bool gic_irq_in_rdist(struct irq_data *d)
 {
-	enum gic_intid_range range = get_intid_range(d);
-	return range == PPI_RANGE || range == EPPI_RANGE;
+	switch (get_intid_range(d)) {
+	case SGI_RANGE:
+	case PPI_RANGE:
+	case EPPI_RANGE:
+		return true;
+	default:
+		return false;
+	}
 }
 
 static inline void __iomem *gic_dist_base(struct irq_data *d)
 {
 	switch (get_intid_range(d)) {
+	case SGI_RANGE:
 	case PPI_RANGE:
 	case EPPI_RANGE:
 		/* SGI+PPI -> SGI_base for this CPU */
@@ -253,6 +263,7 @@ static void gic_enable_redist(bool enable)
 static u32 convert_offset_index(struct irq_data *d, u32 offset, u32 *index)
 {
 	switch (get_intid_range(d)) {
+	case SGI_RANGE:
 	case PPI_RANGE:
 	case SPI_RANGE:
 		*index = d->hwirq;
@@ -1277,6 +1288,7 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 		chip = &gic_eoimode1_chip;
 
 	switch (__get_intid_range(hw)) {
+	case SGI_RANGE:
 	case PPI_RANGE:
 	case EPPI_RANGE:
 		irq_set_percpu_devid(irq);
-- 
2.27.0

