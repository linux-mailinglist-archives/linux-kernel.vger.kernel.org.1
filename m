Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB7132D7887
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 16:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437390AbgLKPAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 10:00:37 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35648 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406439AbgLKO7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 09:59:33 -0500
Date:   Fri, 11 Dec 2020 14:58:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607698724;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E3L1b4e5DhldPXmweuBJdvwXwOnTSAgweq3f/Yj6sfg=;
        b=QHuVaAG+DZzCGQTBYptiA3wUBQ2RJHiSCLXMhkQwaZtGAPqSJHZJY5kPCAZzvH2G5HdW1l
        /nkmoA9dlfkL6cgdvQdgFsGBXbb4B5enZ7DdqW4kJxVdZIRbb4g+t65z7dV44KmXAlXJbP
        X/l6E+bKk3q8HYSuoZahZjjpRaKGT9UM/JQ4knWN8VlrThcbiq9d7v+1y3Dtasp7KmF78c
        SYhHGUKG4sdCYh3AS4T2HkbQOIPdPwWuEF9a6foklNEp3kKeLLcg8+G4o1EjX7l/S6auCO
        jVnbvMQVKxLWSYgDiDm30OZRLwqk2ENwcaoNZR70C12PuU+Vw2TJCA85/DE3MA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607698724;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E3L1b4e5DhldPXmweuBJdvwXwOnTSAgweq3f/Yj6sfg=;
        b=fCcfpYA4Jlupenwk7RXJFTjChen3SjLzlVbgBjjSi48UYkGw0Nb6zeO3Xr4qRa2eDy+RdJ
        Fo/YMkbj3ZZV2jAQ==
From:   "irqchip-bot for Valentin Schneider" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/bcm2836: Make IPIs use
 handle_percpu_devid_irq()
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20201109094121.29975-4-valentin.schneider@arm.com>
References: <20201109094121.29975-4-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <160769872377.3364.1347365614733814798.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     ffdad793d579c9286c7b67a86d1a3c890fb32082
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/ffdad793d579c9286c7b67a86d1a3c890fb32082
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Mon, 09 Nov 2020 09:41:19 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 11 Dec 2020 14:47:50 

irqchip/bcm2836: Make IPIs use handle_percpu_devid_irq()

As done for the Arm GIC irqchips, move IPIs to handle_percpu_devid_irq() as
handle_percpu_devid_fasteoi_ipi() isn't actually required.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20201109094121.29975-4-valentin.schneider@arm.com
---
 drivers/irqchip/irq-bcm2836.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-bcm2836.c b/drivers/irqchip/irq-bcm2836.c
index cbc7c74..5f5eb88 100644
--- a/drivers/irqchip/irq-bcm2836.c
+++ b/drivers/irqchip/irq-bcm2836.c
@@ -209,7 +209,7 @@ static int bcm2836_arm_irqchip_ipi_alloc(struct irq_domain *d,
 		irq_set_percpu_devid(virq + i);
 		irq_domain_set_info(d, virq + i, i, &bcm2836_arm_irqchip_ipi,
 				    d->host_data,
-				    handle_percpu_devid_fasteoi_ipi,
+				    handle_percpu_devid_irq,
 				    NULL, NULL);
 	}
 
