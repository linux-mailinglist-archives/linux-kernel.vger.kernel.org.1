Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A37B2D276A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 10:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbgLHJWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 04:22:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728617AbgLHJWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 04:22:51 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF5DC061749
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 01:22:11 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id p6so6679477plo.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 01:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Z5PVIm5f40Ykr9jrfkxQ9QiDEmPvmPkwevbJQJktVLc=;
        b=T5HkCUzFavECBYHXL00oNX4J7+4PnugKfPimRhmXUjZ4/coPgoNA0da8MuofvF3M1s
         91fOhEEbfwmAvWaZSlGJRbeV2I6v855qe8seBFfw2aZnuIIkX3oJqRJdProcateDOQVT
         DyPFs9e++5mrex5buyLmdLjqVqIW0h91bK0LcDSGFi17MpqjP6qLE0GmQZaPVkHZ35HJ
         RSDQonVD+ia1OQK73bYeDJhxgfntA9+XxmFOsegR41E4zlVCtPmh1L6lwqz7chSy0Ap9
         YsElhuK3z39Ae97d0TL1iFbnmpbxjMtADXIEpgGgwE7ROoJGJekCtbq+bJyDf8C2sMmI
         8eVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Z5PVIm5f40Ykr9jrfkxQ9QiDEmPvmPkwevbJQJktVLc=;
        b=EuypwtAytvwe4uD3rAZFoFKovB6xMLF2i06o9n59PRXCHsyKD3nE2X6oJHRUtyc+wx
         52iKnS7/pcj+XxcSUfpY4QfoI5RbqpFHavlleZx5I3IqgInmGQFs564AEjoUUP+u/Rjq
         uvPhscOe/OCjOP8MeyWReU0Boar0iLChNUzRFnmorqRZ5imtqN+DbAD3pf8z+t/lzyp5
         /g+1nNN+VGzWxlNx0uhKjWPPoqfzSrbsQG38yanvzZ7zOPIZe+bjL0Ehgd7C31g5o2U5
         UmsKmEV1bqQtFNYeVXCOnLOJ2UOEusP3JRR/Yiy+HRwD5dwE9qKX5b6ANV/jBW/XU2U+
         JBiQ==
X-Gm-Message-State: AOAM533pTE8Vqq1o6ii6aX+ngPeFHj9CMVsw2ns19/JLdg1H9idr1XUQ
        CmqViiREAZ6wB06ornJ/RXz/8hCNpXXw
X-Google-Smtp-Source: ABdhPJxm6roTwt1s1DaAPuWAXFLMeWuQaDcztKu3ME1XYrJ/J2QBWjzx5hvQ23Bz5IazSWxNUKZ+4w==
X-Received: by 2002:a17:902:8d8b:b029:da:b943:dcf2 with SMTP id v11-20020a1709028d8bb02900dab943dcf2mr20142422plo.1.1607419331263;
        Tue, 08 Dec 2020 01:22:11 -0800 (PST)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id b22sm11524157pfo.163.2020.12.08.01.21.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Dec 2020 01:22:10 -0800 (PST)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64/irq: report bug if NR_IPI greater than max SGI during compile time
Date:   Tue,  8 Dec 2020 17:21:44 +0800
Message-Id: <1607419304-26140-1-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although there is a runtime WARN_ON() when NR_IPR > max SGI, it had better
do the check during built time, and associate these related code together.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm64/kernel/smp.c                | 2 ++
 drivers/irqchip/irq-gic-v3.c           | 2 +-
 drivers/irqchip/irq-gic.c              | 2 +-
 include/linux/irqchip/arm-gic-common.h | 2 ++
 4 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 18e9727..9fc383c 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -33,6 +33,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/kexec.h>
 #include <linux/kvm_host.h>
+#include <linux/irqchip/arm-gic-common.h>
 
 #include <asm/alternative.h>
 #include <asm/atomic.h>
@@ -76,6 +77,7 @@ enum ipi_msg_type {
 	IPI_WAKEUP,
 	NR_IPI
 };
+static_assert(NR_IPI <= MAX_SGI_NUM);
 
 static int ipi_irq_base __read_mostly;
 static int nr_ipi __read_mostly = NR_IPI;
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 16fecc0..ee13f85 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1162,7 +1162,7 @@ static void __init gic_smp_init(void)
 				  gic_starting_cpu, NULL);
 
 	/* Register all 8 non-secure SGIs */
-	base_sgi = __irq_domain_alloc_irqs(gic_data.domain, -1, 8,
+	base_sgi = __irq_domain_alloc_irqs(gic_data.domain, -1, MAX_SGI_NUM,
 					   NUMA_NO_NODE, &sgi_fwspec,
 					   false, NULL);
 	if (WARN_ON(base_sgi <= 0))
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 6053245..07d36de 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -845,7 +845,7 @@ static __init void gic_smp_init(void)
 				  "irqchip/arm/gic:starting",
 				  gic_starting_cpu, NULL);
 
-	base_sgi = __irq_domain_alloc_irqs(gic_data[0].domain, -1, 8,
+	base_sgi = __irq_domain_alloc_irqs(gic_data[0].domain, -1, MAX_SGI_NUM,
 					   NUMA_NO_NODE, &sgi_fwspec,
 					   false, NULL);
 	if (WARN_ON(base_sgi <= 0))
diff --git a/include/linux/irqchip/arm-gic-common.h b/include/linux/irqchip/arm-gic-common.h
index fa8c045..7e45a9f 100644
--- a/include/linux/irqchip/arm-gic-common.h
+++ b/include/linux/irqchip/arm-gic-common.h
@@ -16,6 +16,8 @@
 					(GICD_INT_DEF_PRI << 8) |\
 					GICD_INT_DEF_PRI)
 
+#define MAX_SGI_NUM			8
+
 enum gic_type {
 	GIC_V2,
 	GIC_V3,
-- 
2.7.5

