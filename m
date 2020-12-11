Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F01402D786A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 16:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406478AbgLKPAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 10:00:01 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35684 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406441AbgLKO7d (ORCPT
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
        bh=tR8t3A9bnOHhiymlrgzl7tFYO7MIjEUTj08jzo0yXlo=;
        b=mRTUbQ0VAfdfipDCi+N3hUbAqcMCpqIq1dmwEOgKe3DuIKYejBDHKt/SzRYndNHHHPITtb
        G6mnSd4Bqwmm2McgskxBJOy2LZfhLtB4RuvVWNhfxT8eMTNqr77IgInmx5ZH8ZxOX93b+R
        azttGtJH0BmVpsNTy2DCeUYDuK3RjOlztyMpBfhCz6UieD3JZEgx6E6rknEQwVIIq3q8Io
        CEsmR2FPvkAuJzWTJWhmpAzOZkDIfUya8AG8m1Dd+iOMNfFFVDjv/8bYhM9wTkRvekM3BV
        w5t9myjmCZYbLq3JPXFwwtrLm2AVu29+8S1LjZL2ZHMq60QVYO02cqkYUqBK+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607698724;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tR8t3A9bnOHhiymlrgzl7tFYO7MIjEUTj08jzo0yXlo=;
        b=XIESsGJIA8rglQoF45cCZiz3udXuXNulZlCxGzUZoP9CW28LiAKmYcDQ6IhMrmeJyuKlff
        JlkdSDDiTVEg+HDQ==
From:   "irqchip-bot for Valentin Schneider" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/armada-370-xp: Make IPIs use
 handle_percpu_devid_irq()
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20201109094121.29975-3-valentin.schneider@arm.com>
References: <20201109094121.29975-3-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <160769872396.3364.6273500545929819356.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     e52e73b7e9f7d08b8c2ef6fb1657105093e22a03
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/e52e73b7e9f7d08b8c2ef6fb1657105093e22a03
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Mon, 09 Nov 2020 09:41:18 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 11 Dec 2020 14:47:50 

irqchip/armada-370-xp: Make IPIs use handle_percpu_devid_irq()

As done for the Arm GIC irqchips, move IPIs to handle_percpu_devid_irq() as
handle_percpu_devid_fasteoi_ipi() isn't actually required.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20201109094121.29975-3-valentin.schneider@arm.com
---
 drivers/irqchip/irq-armada-370-xp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index d7eb2e9..32938df 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -382,7 +382,7 @@ static int armada_370_xp_ipi_alloc(struct irq_domain *d,
 		irq_set_percpu_devid(virq + i);
 		irq_domain_set_info(d, virq + i, i, &ipi_irqchip,
 				    d->host_data,
-				    handle_percpu_devid_fasteoi_ipi,
+				    handle_percpu_devid_irq,
 				    NULL, NULL);
 	}
 
