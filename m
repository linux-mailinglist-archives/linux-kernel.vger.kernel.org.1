Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE9CB2DE901
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 19:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbgLRSl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 13:41:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728666AbgLRSl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 13:41:26 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E8DC061282
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 10:40:45 -0800 (PST)
Date:   Fri, 18 Dec 2020 18:40:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1608316844;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E4jfBfaAOGv+NSGS5a+O4lm+MKRAim9j7ZCYrPA3rmY=;
        b=4BQZxX1m3F9Enr1QWwY4AU8ompcLwX0n3EKSUAjePgodAmQLxICudxFeQ2HzomVoyRGUu7
        xvbTNPCeD1u051/IMZnG8RQp3eQ9X8c26Usl+Cui2rhpEhm8F0Ma/mJKkJLIdpkqOyvSdU
        elLjsgE4hBd/SoC+t1XBiwOVHLF7CUBwy4evIpgavtUG8QCWeCIX3yGex686+JLKMX1R4E
        LgwA2X07jFPnTothD98dbVETAAklO03oVkfb0uTkiiAz0MlVHE9wJ3zZ6R0DZJYVM80BAP
        mzOzBgT/amK06RdDyI2eNbAxUqGjK953x55ZviJxumiBzFnu4Z7Cj9pmTU521Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1608316844;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E4jfBfaAOGv+NSGS5a+O4lm+MKRAim9j7ZCYrPA3rmY=;
        b=KVZ3/0TlP6UHBHT4VkAJ9YKsTz9voOEAlnyv1tpgmRNlEcZMwSoelpz1WVoWZNEFXs++oj
        T24DLRaENPDREtBg==
From:   "irqchip-bot for Zenghui Yu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] genirq/msi: Initialize msi_alloc_info
 before calling msi_domain_prepare_irqs()
Cc:     Zenghui Yu <yuzenghui@huawei.com>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: <20201218060039.1770-1-yuzenghui@huawei.com>
References: <20201218060039.1770-1-yuzenghui@huawei.com>
MIME-Version: 1.0
Message-ID: <160831684367.22759.9553900200069848407.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     06fde695ee76429634c1e8c8c1154035aa61191e
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/06fde695ee76429634c1e8c8c1154035aa61191e
Author:        Zenghui Yu <yuzenghui@huawei.com>
AuthorDate:    Fri, 18 Dec 2020 14:00:39 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 18 Dec 2020 17:42:18 

genirq/msi: Initialize msi_alloc_info before calling msi_domain_prepare_irqs()

Since commit 5fe71d271df8 ("irqchip/gic-v3-its: Tag ITS device as shared if
allocating for a proxy device"), some of the devices are wrongly marked as
"shared" by the ITS driver on systems equipped with the ITS(es). The
problem is that the @info->flags may not be initialized anywhere and we end
up looking at random bits on the stack. That's obviously not good.

We can perform the initialization in the IRQ core layer before calling
msi_domain_prepare_irqs(), which is neat enough.

Fixes: 5fe71d271df8 ("irqchip/gic-v3-its: Tag ITS device as shared if allocating for a proxy device")
Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20201218060039.1770-1-yuzenghui@huawei.com
---
 kernel/irq/msi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 2c0c4d6..dc0e2d7 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -402,7 +402,7 @@ int __msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
 	struct msi_domain_ops *ops = info->ops;
 	struct irq_data *irq_data;
 	struct msi_desc *desc;
-	msi_alloc_info_t arg;
+	msi_alloc_info_t arg = { };
 	int i, ret, virq;
 	bool can_reserve;
 
