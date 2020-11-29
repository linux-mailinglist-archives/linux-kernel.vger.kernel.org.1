Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5E4D2C7974
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 14:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbgK2NxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 08:53:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:34976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726462AbgK2NxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 08:53:06 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D7E52084C;
        Sun, 29 Nov 2020 13:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606657945;
        bh=n2tV1p816OOCVHx87N6We4fpb9I40M9zLfrltyfP5Kc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wgSRkb4L70Ipu46a86jrB1DrXqIB2Z3ES0eWCv9xepSUDeWd/Ae/bhYvNMFQuu6md
         baHKc4fGRj51sWAM4WdybHGdd4akX8oayscvvFrjlAKB+s4BWn8pmhA+ydrtjmKaXp
         LYl/DU6KK9Z8XSxPVDKwXmQ3aHmZBqJ8l77/RJNU=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kjN7n-00ETZs-TV; Sun, 29 Nov 2020 13:52:24 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>, john.garry@huawei.com
Subject: [PATCH 2/3] irqchip/gic-v3-its: Tag ITS device as shared if allocating for a proxy device
Date:   Sun, 29 Nov 2020 13:52:07 +0000
Message-Id: <20201129135208.680293-3-maz@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201129135208.680293-1-maz@kernel.org>
References: <20201129135208.680293-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, tglx@linutronix.de, john.garry@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ITS already has some notion of "shared" devices. Let's map the
MSI_ALLOC_FLAGS_PROXY_DEVICE flag onto this internal property.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 0fec31931e11..b99a8ec6585e 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3488,6 +3488,9 @@ static int its_msi_prepare(struct irq_domain *domain, struct device *dev,
 		goto out;
 	}
 
+	if (info->flags & MSI_ALLOC_FLAGS_PROXY_DEVICE)
+		its_dev->shared = true;
+
 	pr_debug("ITT %d entries, %d bits\n", nvec, ilog2(nvec));
 out:
 	mutex_unlock(&its->dev_alloc_lock);
-- 
2.28.0

