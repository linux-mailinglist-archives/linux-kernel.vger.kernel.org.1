Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D62A2AB3CE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 10:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729071AbgKIJmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 04:42:54 -0500
Received: from foss.arm.com ([217.140.110.172]:36246 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729038AbgKIJmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 04:42:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1470811B3;
        Mon,  9 Nov 2020 01:42:52 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 618A33F718;
        Mon,  9 Nov 2020 01:42:50 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Subject: [PATCH 2/5] irqchip/armada-370-xp: Make IPIs use handle_percpu_devid_irq()
Date:   Mon,  9 Nov 2020 09:41:18 +0000
Message-Id: <20201109094121.29975-3-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201109094121.29975-1-valentin.schneider@arm.com>
References: <20201109094121.29975-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As done for the Arm GIC irqchips, move IPIs to handle_percpu_devid_irq() as
handle_percpu_devid_fasteoi_ipi() isn't actually required.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 drivers/irqchip/irq-armada-370-xp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index d7eb2e93db8f..32938dfc0e46 100644
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
 
-- 
2.27.0

