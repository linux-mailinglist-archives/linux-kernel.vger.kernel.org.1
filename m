Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C906C2DE8FF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 19:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbgLRSl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 13:41:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbgLRSlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 13:41:25 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91151C0617B0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 10:40:45 -0800 (PST)
Date:   Fri, 18 Dec 2020 18:40:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1608316843;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6SYP1UqNBzhgmR9vajnzHsKxFlT9ERvxB+ikOGX3JQw=;
        b=ETs+VYlJ9yPzeTczZs1fqRnZmE4cLV9A++bcvpEVqzvntjkkUk6BqGWFeFW6nL66T5j2X+
        NVbCKZR0RSAD5T7mRrroSQnaQm2BiufgvY2v6dJI6r5r0EH9UULlg5UKlIyO83NW8FUAjA
        iP4Y0IK76r1Lcx+7xK+TdxH1ieLWLBL+7mkr2f1RcbgdtSnho3FIFqVuGUzImsoAP52Kn4
        3a0Hmdar51Wrqh9FTS2xw3bvBVWoFaSEU4gM4kh9E5/QK9GvYRcMyO7HwXsuEH53+Pv1Cm
        4Ku87SPZS9QxHnUvAzRkR2Ln6bY62AbBYgiHZudz/2JY7lxAehWWRWx4jao86Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1608316843;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6SYP1UqNBzhgmR9vajnzHsKxFlT9ERvxB+ikOGX3JQw=;
        b=6zzEe0DoE2saxtrHAWV+PCaSjKzdkHd5M0u3HDW4zqm5Eei1RBdAkz1+PQMUaiz/b1lB1C
        0syxLuFLL0tRQcCw==
From:   "irqchip-bot for Zheng Yongjun" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/irq-sl28cpld: Convert comma to semicolon
Cc:     Zheng Yongjun <zhengyongjun3@huawei.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20201214133530.3783-1-zhengyongjun3@huawei.com>
References: <20201214133530.3783-1-zhengyongjun3@huawei.com>
MIME-Version: 1.0
Message-ID: <160831684334.22759.13415840458012921671.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     e90f55e0196a66f8e9e445f7f33f876dd889be9a
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/e90f55e0196a66f8e9e445f7f33f876dd889be9a
Author:        Zheng Yongjun <zhengyongjun3@huawei.com>
AuthorDate:    Mon, 14 Dec 2020 21:35:30 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 18 Dec 2020 17:43:47 

irqchip/irq-sl28cpld: Convert comma to semicolon

Replace a comma between expression statements by a semicolon.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20201214133530.3783-1-zhengyongjun3@huawei.com
---
 drivers/irqchip/irq-sl28cpld.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-sl28cpld.c b/drivers/irqchip/irq-sl28cpld.c
index 0aa50d0..fbb3544 100644
--- a/drivers/irqchip/irq-sl28cpld.c
+++ b/drivers/irqchip/irq-sl28cpld.c
@@ -66,7 +66,7 @@ static int sl28cpld_intc_probe(struct platform_device *pdev)
 	irqchip->chip.num_regs = 1;
 	irqchip->chip.status_base = base + INTC_IP;
 	irqchip->chip.mask_base = base + INTC_IE;
-	irqchip->chip.mask_invert = true,
+	irqchip->chip.mask_invert = true;
 	irqchip->chip.ack_base = base + INTC_IP;
 
 	return devm_regmap_add_irq_chip_fwnode(dev, dev_fwnode(dev),
