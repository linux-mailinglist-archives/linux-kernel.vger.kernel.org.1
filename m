Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3820423E0C3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Aug 2020 20:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729802AbgHFSiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Aug 2020 14:38:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:58704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729268AbgHFSfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 14:35:22 -0400
Received: from localhost.localdomain (unknown [194.230.155.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEDA522E03;
        Thu,  6 Aug 2020 18:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596738243;
        bh=19UAshGsZFByjxw/aSzh0Z+vb1p8CceYaowS8Z/9iZg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nBIXHt6BD7bu9YKm6SGfQefDgMp4yTD7C4X5F+YWz9/xT40rusPWXccz/CjQy4xRR
         1nDngaN5OmaCmfryBkNOScYWHyU3HyXefCs2apd46s0WTbblvgak1E8vlQKKZu+rp5
         kHpj4c04WnpG+MkflTaJ+/sv3P+5axMKuR8q44Xc=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 32/41] ARM: s3c24xx: bast: avoid irq_desc array usage
Date:   Thu,  6 Aug 2020 20:20:49 +0200
Message-Id: <20200806182059.2431-32-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806181932.2253-1-krzk@kernel.org>
References: <20200806181932.2253-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Once we move to sparse irqs, the irq_desc[] array is no
longer accessible, so replace the two uses in bast-irq.c.
The first one can use irq_to_desc(), the second one seems
completely unneeded as we already have a pointer to the
correct descriptor.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/mach-s3c24xx/bast-irq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/bast-irq.c b/arch/arm/mach-s3c24xx/bast-irq.c
index a6db5e2c910c..141a35d58dd7 100644
--- a/arch/arm/mach-s3c24xx/bast-irq.c
+++ b/arch/arm/mach-s3c24xx/bast-irq.c
@@ -62,7 +62,7 @@ bast_pc104_mask(struct irq_data *data)
 static void
 bast_pc104_maskack(struct irq_data *data)
 {
-	struct irq_desc *desc = irq_desc + BAST_IRQ_ISA;
+	struct irq_desc *desc = irq_to_desc(BAST_IRQ_ISA);
 
 	bast_pc104_mask(data);
 	desc->irq_data.chip->irq_ack(&desc->irq_data);
@@ -94,8 +94,6 @@ static void bast_irq_pc104_demux(struct irq_desc *desc)
 
 	if (unlikely(stat == 0)) {
 		/* ack if we get an irq with nothing (ie, startup) */
-
-		desc = irq_desc + BAST_IRQ_ISA;
 		desc->irq_data.chip->irq_ack(&desc->irq_data);
 	} else {
 		/* handle the IRQ */
-- 
2.17.1

