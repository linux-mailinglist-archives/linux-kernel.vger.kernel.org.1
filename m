Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED9B2D7869
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 16:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406471AbgLKPAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 10:00:01 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35632 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406434AbgLKO7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 09:59:33 -0500
Date:   Fri, 11 Dec 2020 14:58:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607698723;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RrcJY1pMHtNBm6muE7XV9I/IU+k73uFKAdDYsSA9P1Y=;
        b=l9Zf29ie/p2lwRYBVHcT+NqDJjd2eZy8e6+DufJCwshzrTXCxHICHrkyb5ZETZJwtoZPs7
        exfWOXb7f++mE2QkW64sxC3mieHXrwUxXGJThQsln8FgVceQo3xoLF+s6YjFapHqDcVDhS
        mq/GE9goP/rhpOKDkYLt5pthkBX9B4gUjAjhy8f6i9lbla+VnILgglo7ovQvsdCUzuNTPD
        PlLN6oRj318QEwNiWhAZS6N3BVmm47oe8bUN52Gg3y1T8e7jmC1tSO0AH+HFlVan3OL/wV
        YjGhyoiVTn5eudGChSKYK6hVVs2CiLVUwkq7yd1ijZbH9btmtgQvg7BW4MKBMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607698723;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RrcJY1pMHtNBm6muE7XV9I/IU+k73uFKAdDYsSA9P1Y=;
        b=PXhjs069YxvdCcPvvjVmgwy8UpyO69Es4WicjhUq/1ZbXfaco7JaJjOpjeWcltiEt36/gf
        6mZnGvIldt/xOYAg==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/gic-v3-its: Tag ITS device as
 shared if allocating for a proxy device
Cc:     Marc Zyngier <maz@kernel.org>, John Garry <john.garry@huawei.com>,
        tglx@linutronix.de
In-Reply-To: <20201129135208.680293-3-maz@kernel.org>
References: <20201129135208.680293-3-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <160769872258.3364.11400537373413179188.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     5fe71d271df8c05e1060c0184764eba18b17a96f
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/5fe71d271df8c05e1060c0184764eba18b17a96f
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Sun, 29 Nov 2020 13:52:07 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 11 Dec 2020 14:47:50 

irqchip/gic-v3-its: Tag ITS device as shared if allocating for a proxy device

The ITS already has some notion of "shared" devices. Let's map the
MSI_ALLOC_FLAGS_PROXY_DEVICE flag onto this internal property.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Tested-by: John Garry <john.garry@huawei.com>
Link: https://lore.kernel.org/r/20201129135208.680293-3-maz@kernel.org
---
 drivers/irqchip/irq-gic-v3-its.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index d74ef41..c951ad2 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3487,6 +3487,9 @@ static int its_msi_prepare(struct irq_domain *domain, struct device *dev,
 		goto out;
 	}
 
+	if (info->flags & MSI_ALLOC_FLAGS_PROXY_DEVICE)
+		its_dev->shared = true;
+
 	pr_debug("ITT %d entries, %d bits\n", nvec, ilog2(nvec));
 out:
 	mutex_unlock(&its->dev_alloc_lock);
