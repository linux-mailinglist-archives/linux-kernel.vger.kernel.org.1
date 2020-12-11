Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1582D7886
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 16:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437407AbgLKPAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 10:00:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406440AbgLKO7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 09:59:32 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B27C061794
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 06:58:46 -0800 (PST)
Date:   Fri, 11 Dec 2020 14:58:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607698723;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gUx5KAONi1b5hQHuOr/VvbGIFNnuChGkLLv/k+vESa0=;
        b=l3cTSTIkYfag9OKODFWxeu5a3apNX5AHr84QmliTJPwtifeS6WjR6DqRQFjr5Zmle1zMXl
        YNcZ8KhHWSrhfw23CSkXRtNbvwri55fxR65chOifFjeEty7MUDPeP+xyuo+t+KULBiD7o4
        C06uPNeBY0oqDMz9ZjxktL4DwF2mWICVPtqCXs4qjf5BLj14uBeBOddAujtprf79deerE2
        KKrpYg98N1nQwidjVgQYEk6I6TF0NcEZiZP1h7EuQx2xu2tORVHLAV0SxMDb5VnYwXB4Ri
        k2PrfOkSgjmFglVSvNHGVGYTZG/2vlOSb0PoH4X4E5Xh3+crzB4fU7nxZGqC8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607698723;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gUx5KAONi1b5hQHuOr/VvbGIFNnuChGkLLv/k+vESa0=;
        b=esCBBnlWTe3MA3yxX5BJfPI/cWdYkU1hLzJ19ftjIV7LyfF1fFOZJJpQhMIsiOStmuLiXT
        zrQOgsem1F5Ta8CQ==
From:   "irqchip-bot for Lokesh Vutla" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/ti-sci-intr: Fix freeing of irqs
Cc:     Lokesh Vutla <lokeshvutla@ti.com>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: <20201102120631.11165-1-lokeshvutla@ti.com>
References: <20201102120631.11165-1-lokeshvutla@ti.com>
MIME-Version: 1.0
Message-ID: <160769872290.3364.7461141585787072778.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     fc6c7cd3878641fd43189f15697e7ad0871f5c1a
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/fc6c7cd3878641fd43189f15697e7ad0871f5c1a
Author:        Lokesh Vutla <lokeshvutla@ti.com>
AuthorDate:    Mon, 02 Nov 2020 17:36:31 +05:30
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 11 Dec 2020 14:47:50 

irqchip/ti-sci-intr: Fix freeing of irqs

ti_sci_intr_irq_domain_free() assumes that out_irq of intr is stored in
data->chip_data and uses it for calling ti_sci irq_free() and then
mark the out_irq as available resource. But ti_sci_intr_irq_domain_alloc()
is storing p_hwirq(parent's hardware irq) which is translated from out_irq.
This is causing resource leakage and eventually out_irq resources might
be exhausted. Fix ti_sci_intr_irq_domain_alloc() by storing the out_irq
in data->chip_data.

Fixes: a5b659bd4bc7 ("irqchip/ti-sci-intr: Add support for INTR being a parent to INTR")
Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20201102120631.11165-1-lokeshvutla@ti.com
---
 drivers/irqchip/irq-ti-sci-intr.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/irqchip/irq-ti-sci-intr.c b/drivers/irqchip/irq-ti-sci-intr.c
index ac9d6d6..fe8fad2 100644
--- a/drivers/irqchip/irq-ti-sci-intr.c
+++ b/drivers/irqchip/irq-ti-sci-intr.c
@@ -129,7 +129,7 @@ static void ti_sci_intr_irq_domain_free(struct irq_domain *domain,
  * @virq:	Corresponding Linux virtual IRQ number
  * @hwirq:	Corresponding hwirq for the IRQ within this IRQ domain
  *
- * Returns parent irq if all went well else appropriate error pointer.
+ * Returns intr output irq if all went well else appropriate error pointer.
  */
 static int ti_sci_intr_alloc_parent_irq(struct irq_domain *domain,
 					unsigned int virq, u32 hwirq)
@@ -173,7 +173,7 @@ static int ti_sci_intr_alloc_parent_irq(struct irq_domain *domain,
 	if (err)
 		goto err_msg;
 
-	return p_hwirq;
+	return out_irq;
 
 err_msg:
 	irq_domain_free_irqs_parent(domain, virq, 1);
@@ -198,19 +198,19 @@ static int ti_sci_intr_irq_domain_alloc(struct irq_domain *domain,
 	struct irq_fwspec *fwspec = data;
 	unsigned long hwirq;
 	unsigned int flags;
-	int err, p_hwirq;
+	int err, out_irq;
 
 	err = ti_sci_intr_irq_domain_translate(domain, fwspec, &hwirq, &flags);
 	if (err)
 		return err;
 
-	p_hwirq = ti_sci_intr_alloc_parent_irq(domain, virq, hwirq);
-	if (p_hwirq < 0)
-		return p_hwirq;
+	out_irq = ti_sci_intr_alloc_parent_irq(domain, virq, hwirq);
+	if (out_irq < 0)
+		return out_irq;
 
 	irq_domain_set_hwirq_and_chip(domain, virq, hwirq,
 				      &ti_sci_intr_irq_chip,
-				      (void *)(uintptr_t)p_hwirq);
+				      (void *)(uintptr_t)out_irq);
 
 	return 0;
 }
