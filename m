Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 125432D7883
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 16:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406508AbgLKPAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 10:00:39 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35640 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406436AbgLKO7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 09:59:33 -0500
Date:   Fri, 11 Dec 2020 14:58:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607698723;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xyaHt2zIXaYn3fiLUmQBUX//vhqDDBTg7Nbt7D7kG70=;
        b=1hpMbR0vxvnROx92SK0VrZeVbpflELoyuXjHyvlJWT4hY+2nb8G4JOxwbNZ4U7PplEE6os
        0rfqp6EkH1I1j4kPqZM3orGYJ4Cj1cpOg1VOvLON3tmh63LR9i0xtBn+/J5N8WPtbxSrh9
        6MmS1CRAzIpy7mTbrYbViHqZiqOeEBFUUXik3xEzTgb+o8h2oOHwT4tz5CMogn5EBPTgcD
        Rtdd2mHocx3PsdwJt/4cj8BOC69xLyOsTTsKltRr6u4IUmsUenbhe5fkw4NNU3PPvVtVnL
        5cZBgmkJ1VoNMDWQU5zYCE0ceYY5OAqESb8jpw9wsfcSmopy3lbbrXEZMxbL0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607698723;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xyaHt2zIXaYn3fiLUmQBUX//vhqDDBTg7Nbt7D7kG70=;
        b=0P6hik5T0jXBE2/Jq8A7jSQBNu2I3OXyOhHWXv380Z12SeqD+R00lZQZf+oR/CPMvNVF+N
        SvsGIww+4GBszPBg==
From:   "irqchip-bot for Lokesh Vutla" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/ti-sci-inta: Fix printing of inta
 id on probe success
Cc:     Lokesh Vutla <lokeshvutla@ti.com>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: <20201102120614.11109-1-lokeshvutla@ti.com>
References: <20201102120614.11109-1-lokeshvutla@ti.com>
MIME-Version: 1.0
Message-ID: <160769872314.3364.5509986571776404073.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     b10d5fd489b0c67f59cbdd28d95f4bd9f76a62f2
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/b10d5fd489b0c67f59cbdd28d95f4bd9f76a62f2
Author:        Lokesh Vutla <lokeshvutla@ti.com>
AuthorDate:    Mon, 02 Nov 2020 17:36:14 +05:30
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 11 Dec 2020 14:47:50 

irqchip/ti-sci-inta: Fix printing of inta id on probe success

On a successful probe, the driver tries to print a success message with
INTA device id. It uses pdev->id for printing the id but id is stored in
inta->ti_sci_id. Fix it by correcting the dev_info parameter.

Fixes: 5c4b585d2910 ("irqchip/ti-sci-inta: Add support for INTA directly connecting to GIC")
Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20201102120614.11109-1-lokeshvutla@ti.com
---
 drivers/irqchip/irq-ti-sci-inta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-ti-sci-inta.c b/drivers/irqchip/irq-ti-sci-inta.c
index b2ab8db..532d0ae 100644
--- a/drivers/irqchip/irq-ti-sci-inta.c
+++ b/drivers/irqchip/irq-ti-sci-inta.c
@@ -726,7 +726,7 @@ static int ti_sci_inta_irq_domain_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&inta->vint_list);
 	mutex_init(&inta->vint_mutex);
 
-	dev_info(dev, "Interrupt Aggregator domain %d created\n", pdev->id);
+	dev_info(dev, "Interrupt Aggregator domain %d created\n", inta->ti_sci_id);
 
 	return 0;
 }
