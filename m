Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43E5028DFA9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 13:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387649AbgJNLM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 07:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387592AbgJNLM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 07:12:58 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0965DC061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 04:12:57 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id c20so1770848pfr.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 04:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SKgoeb2sQC7EsxoClVm7L3B4m5FY4cggAP6CyWZ0QJ4=;
        b=MMQn1HxAw/5HZN6E99ENJxg+pIPfiiKZv5G5Rl2fkTznbb5Dj8uynfA8lYT7tDLiZ7
         Ay8vBQvah6h4kxUV1R1aZ9oEkvKGj/bzq82P2YdtNeBcvvyNU6Mfq5vBCmGJkHLw9JEB
         DXPYph8KS9RzenPcuN5hjykrPD7W4PaFqVZitmYZI75OTsrIgroCRkF4/YdMi+cHcWLm
         ocPAwexfm0MAO8Dg7X6zSsb2WleF7rmz3j2i9DnH2bM9zUYRdi/CrkwBnuDcjkrnMoHi
         u/BwCXEpHRMqLX6FpyiJeO/bhtzozc5oQorwcwenTeLWenwMjk4FXaZaBJSzyDEn4E1G
         hPrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SKgoeb2sQC7EsxoClVm7L3B4m5FY4cggAP6CyWZ0QJ4=;
        b=Ol7mAKkGaJtGmNDFCMClChU+MSUtNciNVU716679OT2Jz6tFN1aEjNLIh4oRm3bIs1
         kEwVApNxNIauabBQtveyknpWlfXlblevB3iD2+nqSkTGpzPlzLf/I6hXLmucb4dxRt9x
         60SB7obXJ+1dGPjlrqATYsCj8DuPjj3DLR70VOejuNoS9gBOU3P2LH5JgE6T6uOpwNSu
         dbuF6+O/bDXeX5h3qkKQVdFeGU9SV57UBeIcv2u66SzXeNSA4gEm2xcZtqsfdAnQsl+x
         1tPrArAjwVR4WX3lpaQUIbmOSYYjo+87nH7/haFL9PZidr/t30sGIYC157M8mmP6007g
         wCTw==
X-Gm-Message-State: AOAM531uaFhBN9iWqYad/r0qlmH47hMpp+qOsm+HbFuJi2PneMeQHQjh
        apC18vK0gNH1eUkg8yrV+oqs+A==
X-Google-Smtp-Source: ABdhPJwvoPqSTeDCjNjszJCXG1jgM+7fBedU3mgHJpvhE8Qr2Y4Y8e/gDZVOKFSpCznoGmJn4ALIyg==
X-Received: by 2002:a63:e44b:: with SMTP id i11mr3523192pgk.431.1602673976593;
        Wed, 14 Oct 2020 04:12:56 -0700 (PDT)
Received: from localhost.localdomain ([117.252.65.235])
        by smtp.gmail.com with ESMTPSA id f21sm3060102pfk.169.2020.10.14.04.12.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Oct 2020 04:12:55 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     maz@kernel.org, catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, tglx@linutronix.de,
        jason@lakedaemon.net, mark.rutland@arm.com,
        julien.thierry.kdev@gmail.com, dianders@chromium.org,
        daniel.thompson@linaro.org, jason.wessel@windriver.com,
        msys.mizuma@gmail.com, ito-yuichi@fujitsu.com,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v5 2/5] irqchip/gic-v3: Enable support for SGIs to act as NMIs
Date:   Wed, 14 Oct 2020 16:42:08 +0530
Message-Id: <1602673931-28782-3-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1602673931-28782-1-git-send-email-sumit.garg@linaro.org>
References: <1602673931-28782-1-git-send-email-sumit.garg@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to handle SGIs as regular NMIs. As SGIs or IPIs defaults to a
special flow handler: handle_percpu_devid_fasteoi_ipi(), so skip NMI
handler update in case of SGIs.

Also, enable NMI support prior to gic_smp_init() as allocation of SGIs
as IRQs/NMIs happen as part of this routine.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/irqchip/irq-gic-v3.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 16fecc0..5efc865 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -477,6 +477,11 @@ static int gic_irq_nmi_setup(struct irq_data *d)
 	if (WARN_ON(gic_irq(d) >= 8192))
 		return -EINVAL;
 
+	if (get_intid_range(d) == SGI_RANGE) {
+		gic_irq_set_prio(d, GICD_INT_NMI_PRI);
+		return 0;
+	}
+
 	/* desc lock should already be held */
 	if (gic_irq_in_rdist(d)) {
 		u32 idx = gic_get_ppi_index(d);
@@ -514,6 +519,11 @@ static void gic_irq_nmi_teardown(struct irq_data *d)
 	if (WARN_ON(gic_irq(d) >= 8192))
 		return;
 
+	if (get_intid_range(d) == SGI_RANGE) {
+		gic_irq_set_prio(d, GICD_INT_DEF_PRI);
+		return;
+	}
+
 	/* desc lock should already be held */
 	if (gic_irq_in_rdist(d)) {
 		u32 idx = gic_get_ppi_index(d);
@@ -1708,6 +1718,7 @@ static int __init gic_init_bases(void __iomem *dist_base,
 
 	gic_dist_init();
 	gic_cpu_init();
+	gic_enable_nmi_support();
 	gic_smp_init();
 	gic_cpu_pm_init();
 
@@ -1719,8 +1730,6 @@ static int __init gic_init_bases(void __iomem *dist_base,
 			gicv2m_init(handle, gic_data.domain);
 	}
 
-	gic_enable_nmi_support();
-
 	return 0;
 
 out_free:
-- 
2.7.4

