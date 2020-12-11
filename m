Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCE162D7877
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 16:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406515AbgLKPAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 10:00:40 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35734 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406449AbgLKO7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 09:59:37 -0500
Date:   Fri, 11 Dec 2020 14:58:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607698726;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZDitruWG2mjm+8OCjAFPP8kViYiWrc/wdrnBEMF+9QE=;
        b=cUdMikcfHGS7vLj6yogpcLyXSBmQc+DWHabH4WGEjIvBMJVpYaOYX7camBrehCSxc+iIt6
        TMkafutPljzkkTQIhUBXiiH6lwhVf5Qw6cBe3EeQAyZq0RQo5JEJ0AY2U0LExUVs0X5eNP
        FeBKgq0YxAsYzL2Nq4YGTrHKXP1nsEJgDv41g1Uh44kf9OqIJ1qYB2ZnXweJKuRRm7nBFA
        Z6YHO5+ULhy6vYDHngF6gHGwOKEwMyYdjDcO1+JMitS1ZQHFtl90X7s1HP88uLaJm+PkDH
        cCUtH4jDJcLoudVDZSVuhZN6j9+2XLkmIGMbpRDMuane/zbHyx3tG2PXCzrzHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607698726;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZDitruWG2mjm+8OCjAFPP8kViYiWrc/wdrnBEMF+9QE=;
        b=Y3ah3rAgWtNOQ3OVOyKVhiNGVNLigBMmCKRDAsN9AHGBOC3LnFBATcZ7PhdmAXRfBOsocd
        /8uA5rMJRglOzpAA==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/alpine-msi: Fix freeing of
 interrupts on allocation error path
Cc:     Marc Zyngier <maz@kernel.org>, Antoine Tenart <atenart@kernel.org>,
        Tsahee Zidenberg <tsahee@annapurnalabs.com>, tglx@linutronix.de
In-Reply-To: <20201129135525.396671-1-maz@kernel.org>
References: <20201129135525.396671-1-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <160769872564.3364.7955510196873731229.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     3841245e8498a789c65dedd7ffa8fb2fee2c0684
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/3841245e8498a789c65dedd7ffa8fb2fee2c0684
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Sun, 29 Nov 2020 13:55:25 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 11 Dec 2020 14:45:22 

irqchip/alpine-msi: Fix freeing of interrupts on allocation error path

The alpine-msi driver has an interesting allocation error handling,
where it frees the same interrupts repeatedly. Hilarity follows.

This code is probably never executed, but let's fix it nonetheless.

Fixes: e6b78f2c3e14 ("irqchip: Add the Alpine MSIX interrupt controller")
Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Antoine Tenart <atenart@kernel.org>
Cc: Tsahee Zidenberg <tsahee@annapurnalabs.com>
Cc: Antoine Tenart <atenart@kernel.org>
Link: https://lore.kernel.org/r/20201129135525.396671-1-maz@kernel.org
---
 drivers/irqchip/irq-alpine-msi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-alpine-msi.c b/drivers/irqchip/irq-alpine-msi.c
index 23a3b87..ede02dc 100644
--- a/drivers/irqchip/irq-alpine-msi.c
+++ b/drivers/irqchip/irq-alpine-msi.c
@@ -165,8 +165,7 @@ static int alpine_msix_middle_domain_alloc(struct irq_domain *domain,
 	return 0;
 
 err_sgi:
-	while (--i >= 0)
-		irq_domain_free_irqs_parent(domain, virq, i);
+	irq_domain_free_irqs_parent(domain, virq, i - 1);
 	alpine_msix_free_sgi(priv, sgi, nr_irqs);
 	return err;
 }
