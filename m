Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C54042E9D30
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 19:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbhADSiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 13:38:06 -0500
Received: from vern.gendns.com ([98.142.107.122]:39606 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbhADSiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 13:38:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5BYF65U7qjLGCDhDXQ6WVMeSp4lcIaka2HzC0I24YYE=; b=ucSIWy1FxPCpTVUnyKMXLe6VIc
        /BnMeex4D2LqzEpQP3I6uQDt0t2sZqvJpbRZVuxVW47bAi5gdbP75PNLzMBSn1Ny2+A+29xdDjDHg
        bDTsuZIVuMBxu5eFJcQEYKA1TkeJesan4k2G/TQh+yXAeWL5UAnsXW3EZeWspQuJC5k1blCeQ3NCj
        zIpDdYWWfMyI2Q6iUGcS2TMYDGwS/9hlfep8sZruFxn8kw05NGXG5+hhdv6WKRE2iEKRGgvh7n1BE
        WByC5+XmVDxLpLbdV6RgkJ1RohqVPFTjOyMUJXeIx4UzAC7JPJAbZBNEAjXHNZjyIRRF+1WIVPu6c
        QZRb31Kw==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:51220 helo=freyr.lechnology.com)
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <david@lechnology.com>)
        id 1kwUjK-0004S9-28; Mon, 04 Jan 2021 13:37:22 -0500
From:   David Lechner <david@lechnology.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Lechner <david@lechnology.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Suman Anna <s-anna@ti.com>,
        Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] irqchip/irq-pruss-intc: implement set_type() callback
Date:   Mon,  4 Jan 2021 12:36:56 -0600
Message-Id: <20210104183656.333256-1-david@lechnology.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This implements the irqchip set_type() callback for the TI PRUSS
interrupt controller. This is needed for cases where an event needs
to be active low.

According to the technical reference manual, the polarity should always
be set to high, however in practice, the polarity needs to be set low
for the McASP Tx/Rx system event in conjunction with soft UART PRU
firmware for TI AM18XX SoCs, otherwise it doesn't work.

Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/irqchip/irq-pruss-intc.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/irqchip/irq-pruss-intc.c b/drivers/irqchip/irq-pruss-intc.c
index 5409016e6ca0..f882af8a7ded 100644
--- a/drivers/irqchip/irq-pruss-intc.c
+++ b/drivers/irqchip/irq-pruss-intc.c
@@ -334,6 +334,32 @@ static void pruss_intc_irq_unmask(struct irq_data *data)
 	pruss_intc_write_reg(intc, PRU_INTC_EISR, hwirq);
 }
 
+static int pruss_intc_irq_set_type(struct irq_data *data, unsigned int type)
+{
+	struct pruss_intc *intc = irq_data_get_irq_chip_data(data);
+	u32 reg, bit, val;
+
+	if (type & IRQ_TYPE_LEVEL_MASK) {
+		/* polarity register */
+		reg = PRU_INTC_SIPR(data->hwirq / 32);
+		bit = BIT(data->hwirq % 32);
+		val = pruss_intc_read_reg(intc, reg);
+
+		/*
+		 * This check also ensures that IRQ_TYPE_DEFAULT will result
+		 * in setting the level to high.
+		 */
+		if (type & IRQ_TYPE_LEVEL_HIGH)
+			val |= bit;
+		else
+			val &= ~bit;
+
+		pruss_intc_write_reg(intc, reg, val);
+	}
+
+	return 0;
+}
+
 static int pruss_intc_irq_reqres(struct irq_data *data)
 {
 	if (!try_module_get(THIS_MODULE))
@@ -389,6 +415,7 @@ static struct irq_chip pruss_irqchip = {
 	.irq_ack		= pruss_intc_irq_ack,
 	.irq_mask		= pruss_intc_irq_mask,
 	.irq_unmask		= pruss_intc_irq_unmask,
+	.irq_set_type		= pruss_intc_irq_set_type,
 	.irq_request_resources	= pruss_intc_irq_reqres,
 	.irq_release_resources	= pruss_intc_irq_relres,
 	.irq_get_irqchip_state	= pruss_intc_irq_get_irqchip_state,
-- 
2.25.1

