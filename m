Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22F682A29D2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 12:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbgKBLrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 06:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728664AbgKBLqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 06:46:01 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDCDC061A4F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 03:45:58 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id y14so10869518pfp.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 03:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8pOpPNam2BTL4szbnxJp4LS7vtJkYCW9OQ62wkxqSGo=;
        b=YVW84JmDAp8DIjenSpzHBz73rPBLIFXlDsIDnEzlxzixQWBzr5oubMrEB0suStZQDA
         5u6FcZCH8rb7meD9z1wNrw22eNmKkh3xbRJmMpuejN6q8yErP4k0xoX3Gm7mNElk5dwo
         IpBqFT+p+1Yu0zC1WTwVvn3fcNkP0p7hLTpUCXn+z4h+j74HvR7GvqMCTfcEpU71h3iM
         lQq9D0AfCb5fCIHihCcJGevGeBlNDHbCIgPFT0G3YCr7VP39+goGdwX8dAbQGQsyd02H
         QK5fpZergbM89BpvkMNpkQzDgvXD4K3gCopYVu+qJ/nfsrOElciYmtrDgPaXhj4dFbT1
         vq5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8pOpPNam2BTL4szbnxJp4LS7vtJkYCW9OQ62wkxqSGo=;
        b=g+Qx42lI+HkItfeCwU5tSHJDh6IoL/Zf100oWHwxlH3o6k2WipUCz26ATs936hddFx
         AQDzq0MPvJguR3QjJcAqcQHqdRvp7N2Bg+7g9sYYd8+9SpIesz4cw+OqG/bN/z08IYp1
         XQkVKIBxoAnEpO8ynilRYrZDXRNsi4o8mF958XeVGPUQLqKZsUaWJApN7OR8qiqZrgwn
         P5wRPGNtWSf7lorl2r8M/fy3HD8F3QQlrO9Bpv4AwyZ0R3fnjrzIr8O2z1UwHRCgPKXo
         cmLZrLSB03VIo0YZ/rK8jjoekFnsWCA+GWB2U3QAum43vSz4x9lqxzEiAwQF20wMnu5v
         ieqQ==
X-Gm-Message-State: AOAM5307hzBCBlNzs4zlo/UTjoRykYa8Waz5PQPvcsh5mDSu3CSm+jCX
        DW/Fv7lOw9EVIYOPJg4DF9PwMg==
X-Google-Smtp-Source: ABdhPJwO3VPcjiMibXY/VqKjgGT4CpMVBqGEJct7m1nqiv5+M4BIMRRSqvYKD5zYQ9yu5ohzOtLOmA==
X-Received: by 2002:a17:90b:111:: with SMTP id p17mr17758894pjz.159.1604317558334;
        Mon, 02 Nov 2020 03:45:58 -0800 (PST)
Received: from localhost.localdomain ([122.173.169.225])
        by smtp.gmail.com with ESMTPSA id y5sm14276184pfq.79.2020.11.02.03.45.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Nov 2020 03:45:57 -0800 (PST)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     maz@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        daniel.thompson@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, tglx@linutronix.de,
        jason@lakedaemon.net, linux@armlinux.org.uk,
        tsbogend@alpha.franken.de, mpe@ellerman.id.au, davem@davemloft.net,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        mark.rutland@arm.com, julien.thierry.kdev@gmail.com,
        dianders@chromium.org, jason.wessel@windriver.com,
        msys.mizuma@gmail.com, ito-yuichi@fujitsu.com,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v7 2/7] irqchip/gic-v3: Enable support for SGIs to act as NMIs
Date:   Mon,  2 Nov 2020 17:14:42 +0530
Message-Id: <1604317487-14543-3-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604317487-14543-1-git-send-email-sumit.garg@linaro.org>
References: <1604317487-14543-1-git-send-email-sumit.garg@linaro.org>
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

