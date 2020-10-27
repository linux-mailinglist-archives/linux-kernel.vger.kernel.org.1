Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB8A29A6FD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 09:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895092AbgJ0IwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 04:52:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:53128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2895085AbgJ0IwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 04:52:12 -0400
Received: from localhost.localdomain (88-113-213-94.elisa-laajakaista.fi [88.113.213.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DAA822281;
        Tue, 27 Oct 2020 08:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603788731;
        bh=0nzyOPvgFX02ZXg1XJA1HS6XgUF6vw89iu8MTd8YMtk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XT81wAgp80B2PWJvEd5TMFsh7BOdbg3t9B2u9HQOTyuZRMN5bu72KjTvaJzC1slVm
         Tg1feUt3aBkhxQyb88Ec01sa2WP059DoBZY809qnGqy398YAmdSAbs/5U7X7IVhVtX
         JU8u0RF5+wYhXrxHuRx2THEOxKCIxxIxhbYRSN1g=
From:   balbi@kernel.org
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>
Subject: [PATCH 2/2] irqchip: bcm2836: fix section mismatch warning
Date:   Tue, 27 Oct 2020 10:51:57 +0200
Message-Id: <20201027085157.1964906-3-balbi@kernel.org>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201027085157.1964906-1-balbi@kernel.org>
References: <20201027085157.1964906-1-balbi@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Felipe Balbi <balbi@kernel.org>

Fix the following warning:

WARNING: modpost: vmlinux.o(.text.unlikely+0x17b2c): Section mismatch in reference from the function bcm2836_arm_irqchip_smp_init() to the function .init.text:set_smp_ipi_range()
The function bcm2836_arm_irqchip_smp_init() references
the function __init set_smp_ipi_range().
This is often because bcm2836_arm_irqchip_smp_init lacks a __init
annotation or the annotation of set_smp_ipi_range is wrong.

Signed-off-by: Felipe Balbi <balbi@kernel.org>
---
 drivers/irqchip/irq-bcm2836.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-bcm2836.c b/drivers/irqchip/irq-bcm2836.c
index 97838eb705f9..cbc7c740e4dc 100644
--- a/drivers/irqchip/irq-bcm2836.c
+++ b/drivers/irqchip/irq-bcm2836.c
@@ -244,7 +244,7 @@ static int bcm2836_cpu_dying(unsigned int cpu)
 
 #define BITS_PER_MBOX	32
 
-static void bcm2836_arm_irqchip_smp_init(void)
+static void __init bcm2836_arm_irqchip_smp_init(void)
 {
 	struct irq_fwspec ipi_fwspec = {
 		.fwnode		= intc.domain->fwnode,
-- 
2.29.1

