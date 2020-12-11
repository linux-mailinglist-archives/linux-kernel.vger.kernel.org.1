Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5606B2D7878
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 16:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437457AbgLKPAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 10:00:40 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35644 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406438AbgLKO7d (ORCPT
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
        bh=d2tbW1CPJfyQkgR+kEkqrtKqo+yF+OU7x1Tkz7QCIkA=;
        b=wGFZIaqP4Jm2iMf4p405Jq1MmhVbjLfKaGnYB3JDhFPC1UWKJmqh/6m/TL9eimDs8rWIg0
        q4A3FdltaoJtv+mW1KSwK2iBPaTyYVnMPgPNOw6dsGUDopD7KhiqU/iPS+S22dlp4X2rnG
        WcWsMloz5Gbfv0XWSFvZtJuc2Dhc1gNp/pl4x/3FS9KCS4FGuMPqvaBm1HLRmlfnGjcpRY
        T3hTBvSkvZ/8sjYLUNilxU+iKBrzRwH7zCjABqhYqnnlpeXVybbqrP4mI3MBrayBMljvbE
        y9fxhJtaVX4n8+dbX01t+hDT5Rx6aiy2200M9B1xz3bXZAlF8BGW9w0JcIpeWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607698724;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d2tbW1CPJfyQkgR+kEkqrtKqo+yF+OU7x1Tkz7QCIkA=;
        b=FMKoAFqsyacCdIepde2DVKzXhs1+lhWNYO+PA3eRCib9jtihfTkg5nMWa6NzdPkmDqQTdh
        XmR6f3OQ/T4ngCAw==
From:   "irqchip-bot for Valentin Schneider" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/hip04: Make IPIs use
 handle_percpu_devid_irq()
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20201109094121.29975-5-valentin.schneider@arm.com>
References: <20201109094121.29975-5-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <160769872362.3364.18286586109832582708.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     a2e042e13ff322ad523a2f131dd6e03e8bc05053
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/a2e042e13ff322ad523a2f131dd6e03e8bc05053
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Mon, 09 Nov 2020 09:41:20 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 11 Dec 2020 14:47:50 

irqchip/hip04: Make IPIs use handle_percpu_devid_irq()

As done for the Arm GIC irqchips, move IPIs to handle_percpu_devid_irq() as
handle_percpu_devid_fasteoi_ipi() isn't actually required.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20201109094121.29975-5-valentin.schneider@arm.com
---
 drivers/irqchip/irq-hip04.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-hip04.c b/drivers/irqchip/irq-hip04.c
index 9b73dcf..a6ed877 100644
--- a/drivers/irqchip/irq-hip04.c
+++ b/drivers/irqchip/irq-hip04.c
@@ -296,11 +296,7 @@ static void hip04_irq_cpu_init(struct hip04_irq_data *intc)
 static int hip04_irq_domain_map(struct irq_domain *d, unsigned int irq,
 				irq_hw_number_t hw)
 {
-	if (hw < 16) {
-		irq_set_percpu_devid(irq);
-		irq_set_chip_and_handler(irq, &hip04_irq_chip,
-					 handle_percpu_devid_fasteoi_ipi);
-	} else if (hw < 32) {
+	if (hw < 32) {
 		irq_set_percpu_devid(irq);
 		irq_set_chip_and_handler(irq, &hip04_irq_chip,
 					 handle_percpu_devid_irq);
