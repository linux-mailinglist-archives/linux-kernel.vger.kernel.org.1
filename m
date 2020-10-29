Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 221D829EEF2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 15:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgJ2O6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 10:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbgJ2O6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 10:58:24 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0456AC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 07:58:24 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id b19so1428493pld.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 07:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8pOpPNam2BTL4szbnxJp4LS7vtJkYCW9OQ62wkxqSGo=;
        b=d4YEK6c+aXhdjFTqmGhY5o8SuZY7WS/1K0GQ7coVqZjtPIRNT31ygAkXKM+0b8Cz7J
         Z9CJ/SiroSskJaVVdglsaR8HhSB7ot1ghCZPKR6Afh7QxtFOKNoX0V86SKUGy0MaVUAh
         oD9LEiThc7e3P0cjKaqpm6I+usWW3anEnwx++BsIRCtKtifzZ/w6rQbvWjtYpodzZySD
         TpdZ2NA//D+0r92Qdo9qqzshvqhgItM9Eq/J6DUAPx2yWFUaPtigaKlQcjHnE5Lfq3qY
         m/ZwzFTzazI3Gn8Fod+uh5QKs8ZoY1E94tJeQfheL/SMYKT5ktXiLZvWeEXSyN7Hp3hi
         et4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8pOpPNam2BTL4szbnxJp4LS7vtJkYCW9OQ62wkxqSGo=;
        b=coQgr77KHgUBiH9m4s7PXey7uiK3tx8/p11X+txPjiAQYQzsw/AGyUJrLy0tHRfEQe
         wiCLJ6+J/Zu4nhyZ2H6NfoIOBhFMBH4GEKfdoG0ZAjC65GtlshsHLewb/VwRqB2QTiCn
         ZxNKYi0BwWe2Dfp6XuJf99GXfDsZCP6xViHIUiTX8pSDvxDI12ABwTQTtFqmyksX6kFm
         vjhmVO+nD+Yd+V9Pu/EQpbT1bUvfY7/yJZaxziC0hBbF5LIDdYwHwr/jouNHGlJZbY2J
         3CfqySNoy74Su4vQj1ZcNRrGgplXYsGXnQMmtvWx90xoz1ruTsjxYIn6WBrzgfMw/XH9
         FxoQ==
X-Gm-Message-State: AOAM531C5vrDLWbDKXKKgcZQDYj4WDWWf4E2C0J6Mz3w1HRCzlKi6lcW
        ZE1uRMaoDzdRjyeT0OHthK0tTQ==
X-Google-Smtp-Source: ABdhPJwYY+sLvKRydFtz0q7pz4SlUKeWiDAtVfW3mm3RtKchc6SPXmugbyHmOESAVp4iW2TmjgIRSg==
X-Received: by 2002:a17:902:7249:b029:d6:4d:7d82 with SMTP id c9-20020a1709027249b02900d6004d7d82mr4522122pll.74.1603983503591;
        Thu, 29 Oct 2020 07:58:23 -0700 (PDT)
Received: from localhost.localdomain ([117.252.71.231])
        by smtp.gmail.com with ESMTPSA id j11sm3085082pfc.64.2020.10.29.07.58.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Oct 2020 07:58:22 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     maz@kernel.org, catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, tglx@linutronix.de,
        jason@lakedaemon.net, linux@armlinux.org.uk,
        tsbogend@alpha.franken.de, mpe@ellerman.id.au, davem@davemloft.net,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        mark.rutland@arm.com, julien.thierry.kdev@gmail.com,
        dianders@chromium.org, daniel.thompson@linaro.org,
        jason.wessel@windriver.com, msys.mizuma@gmail.com,
        ito-yuichi@fujitsu.com, kgdb-bugreport@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v6 2/7] irqchip/gic-v3: Enable support for SGIs to act as NMIs
Date:   Thu, 29 Oct 2020 20:26:22 +0530
Message-Id: <1603983387-8738-3-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1603983387-8738-1-git-send-email-sumit.garg@linaro.org>
References: <1603983387-8738-1-git-send-email-sumit.garg@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to handle SGIs as pseudo NMIs. As SGIs or IPIs default to a
special flow handler: handle_percpu_devid_fasteoi_ipi(), so skip NMI
handler update in case of SGIs.

Also, enable NMI support prior to gic_smp_init() as allocation of SGIs
as IRQs/NMIs happen as part of this routine.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/irqchip/irq-gic-v3.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 16fecc0..7010ae2 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -461,6 +461,7 @@ static u32 gic_get_ppi_index(struct irq_data *d)
 static int gic_irq_nmi_setup(struct irq_data *d)
 {
 	struct irq_desc *desc = irq_to_desc(d->irq);
+	u32 idx;
 
 	if (!gic_supports_nmi())
 		return -EINVAL;
@@ -478,16 +479,22 @@ static int gic_irq_nmi_setup(struct irq_data *d)
 		return -EINVAL;
 
 	/* desc lock should already be held */
-	if (gic_irq_in_rdist(d)) {
-		u32 idx = gic_get_ppi_index(d);
+	switch (get_intid_range(d)) {
+	case SGI_RANGE:
+		break;
+	case PPI_RANGE:
+	case EPPI_RANGE:
+		idx = gic_get_ppi_index(d);
 
 		/* Setting up PPI as NMI, only switch handler for first NMI */
 		if (!refcount_inc_not_zero(&ppi_nmi_refs[idx])) {
 			refcount_set(&ppi_nmi_refs[idx], 1);
 			desc->handle_irq = handle_percpu_devid_fasteoi_nmi;
 		}
-	} else {
+		break;
+	default:
 		desc->handle_irq = handle_fasteoi_nmi;
+		break;
 	}
 
 	gic_irq_set_prio(d, GICD_INT_NMI_PRI);
@@ -498,6 +505,7 @@ static int gic_irq_nmi_setup(struct irq_data *d)
 static void gic_irq_nmi_teardown(struct irq_data *d)
 {
 	struct irq_desc *desc = irq_to_desc(d->irq);
+	u32 idx;
 
 	if (WARN_ON(!gic_supports_nmi()))
 		return;
@@ -515,14 +523,20 @@ static void gic_irq_nmi_teardown(struct irq_data *d)
 		return;
 
 	/* desc lock should already be held */
-	if (gic_irq_in_rdist(d)) {
-		u32 idx = gic_get_ppi_index(d);
+	switch (get_intid_range(d)) {
+	case SGI_RANGE:
+		break;
+	case PPI_RANGE:
+	case EPPI_RANGE:
+		idx = gic_get_ppi_index(d);
 
 		/* Tearing down NMI, only switch handler for last NMI */
 		if (refcount_dec_and_test(&ppi_nmi_refs[idx]))
 			desc->handle_irq = handle_percpu_devid_irq;
-	} else {
+		break;
+	default:
 		desc->handle_irq = handle_fasteoi_irq;
+		break;
 	}
 
 	gic_irq_set_prio(d, GICD_INT_DEF_PRI);
@@ -1708,6 +1722,7 @@ static int __init gic_init_bases(void __iomem *dist_base,
 
 	gic_dist_init();
 	gic_cpu_init();
+	gic_enable_nmi_support();
 	gic_smp_init();
 	gic_cpu_pm_init();
 
@@ -1719,8 +1734,6 @@ static int __init gic_init_bases(void __iomem *dist_base,
 			gicv2m_init(handle, gic_data.domain);
 	}
 
-	gic_enable_nmi_support();
-
 	return 0;
 
 out_free:
-- 
2.7.4

