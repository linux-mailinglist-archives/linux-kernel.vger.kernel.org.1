Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8707F26B809
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 02:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgIPAfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 20:35:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:46496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726490AbgIONkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 09:40:43 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7D51222C2;
        Tue, 15 Sep 2020 13:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600177220;
        bh=i1RznCTmfw0gls/KJHH1mjWlrZkmsd0/IrQtSoEcbYY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P1MnlP2htQKZmZslq7kalm+V63+aO5Njm3ZCM+0mpTohZ+l+BTSCKKk6yvhOQUjf9
         Y5JZi2nkTQ1p1EFbBU+yAYjV+UZSP5P2/2KIUBV8+9nu4Vth4dtvHcgNxc1wl1udYb
         sdRnTJv6+FQ+03ErnOUYi0ezX94xA4uBa0tgYR+k=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kIBBy-00C1TP-A2; Tue, 15 Sep 2020 14:40:18 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        kernel-team@android.com
Subject: [PATCH 2/2] irqchip/gic: Cleanup Franken-GIC handling
Date:   Tue, 15 Sep 2020 14:39:44 +0100
Message-Id: <20200915133944.1285456-3-maz@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200915133944.1285456-1-maz@kernel.org>
References: <20200915133944.1285456-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, m.szyprowski@samsung.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have a static key identifying Samsung's unique creation,
let's replace the indirect call to compute the base addresses by
a simple test on the static key.

Faster, cheaper, negative diffstat.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic.c | 48 +++++++++------------------------------
 1 file changed, 11 insertions(+), 37 deletions(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 84a2d2a1aab7..98743afdaea6 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -83,9 +83,6 @@ struct gic_chip_data {
 #endif
 	struct irq_domain *domain;
 	unsigned int gic_irqs;
-#ifdef CONFIG_GIC_NON_BANKED
-	void __iomem *(*get_base)(union gic_base *);
-#endif
 };
 
 #ifdef CONFIG_BL_SWITCHER
@@ -125,32 +122,6 @@ static struct gic_chip_data gic_data[CONFIG_ARM_GIC_MAX_NR] __read_mostly;
 static struct gic_kvm_info gic_v2_kvm_info;
 
 #ifdef CONFIG_GIC_NON_BANKED
-static void __iomem *gic_get_percpu_base(union gic_base *base)
-{
-	return raw_cpu_read(*base->percpu_base);
-}
-
-static void __iomem *gic_get_common_base(union gic_base *base)
-{
-	return base->common_base;
-}
-
-static inline void __iomem *gic_data_dist_base(struct gic_chip_data *data)
-{
-	return data->get_base(&data->dist_base);
-}
-
-static inline void __iomem *gic_data_cpu_base(struct gic_chip_data *data)
-{
-	return data->get_base(&data->cpu_base);
-}
-
-static inline void gic_set_base_accessor(struct gic_chip_data *data,
-					 void __iomem *(*f)(union gic_base *))
-{
-	data->get_base = f;
-}
-
 static DEFINE_STATIC_KEY_FALSE(frankengic_key);
 static DEFINE_PER_CPU(u32, sgi_intid);
 
@@ -173,10 +144,20 @@ static inline u32 get_sgi_intid(void)
 {
 	return this_cpu_read(sgi_intid);
 }
+
+static inline void __iomem *__get_base(union gic_base *base)
+{
+	if (is_frankengic())
+		return raw_cpu_read(*base->percpu_base);
+
+	return base->common_base;
+}
+
+#define gic_data_dist_base(d)	__get_base(&(d)->dist_base)
+#define gic_data_cpu_base(d)	__get_base(&(d)->cpu_base)
 #else
 #define gic_data_dist_base(d)	((d)->dist_base.common_base)
 #define gic_data_cpu_base(d)	((d)->cpu_base.common_base)
-#define gic_set_base_accessor(d, f)
 #define enable_frankengic()	do { } while(0)
 #define is_frankengic()		false
 #define set_sgi_intid(i)	do { } while(0)
@@ -741,11 +722,6 @@ static int gic_notifier(struct notifier_block *self, unsigned long cmd,	void *v)
 	int i;
 
 	for (i = 0; i < CONFIG_ARM_GIC_MAX_NR; i++) {
-#ifdef CONFIG_GIC_NON_BANKED
-		/* Skip over unused GICs */
-		if (!gic_data[i].get_base)
-			continue;
-#endif
 		switch (cmd) {
 		case CPU_PM_ENTER:
 			gic_cpu_save(&gic_data[i]);
@@ -1187,7 +1163,6 @@ static int gic_init_bases(struct gic_chip_data *gic,
 		}
 
 		enable_frankengic();
-		gic_set_base_accessor(gic, gic_get_percpu_base);
 	} else {
 		/* Normal, sane GIC... */
 		WARN(gic->percpu_offset,
@@ -1195,7 +1170,6 @@ static int gic_init_bases(struct gic_chip_data *gic,
 		     gic->percpu_offset);
 		gic->dist_base.common_base = gic->raw_dist_base;
 		gic->cpu_base.common_base = gic->raw_cpu_base;
-		gic_set_base_accessor(gic, gic_get_common_base);
 	}
 
 	/*
-- 
2.28.0

