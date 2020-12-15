Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5C62DAABE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 11:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgLOKUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 05:20:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:40496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727075AbgLOKTx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 05:19:53 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0641D20888;
        Tue, 15 Dec 2020 10:19:13 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kp7QF-001Rnq-0p; Tue, 15 Dec 2020 10:19:11 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 15 Dec 2020 10:19:10 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Andrew Lunn <andrew@lunn.ch>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Scott Branden <sbranden@broadcom.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH 3/5] irqchip/bcm2836: Make IPIs use
 handle_percpu_devid_irq()
In-Reply-To: <20201215002134.GA182208@roeck-us.net>
References: <20201109094121.29975-1-valentin.schneider@arm.com>
 <20201109094121.29975-4-valentin.schneider@arm.com>
 <20201215002134.GA182208@roeck-us.net>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <38f8fbe9ceb7a0adb47e62d62260b297@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: linux@roeck-us.net, valentin.schneider@arm.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, andrew@lunn.ch, Lorenzo.Pieralisi@arm.com, jason@lakedaemon.net, sbranden@broadcom.com, gregory.clement@bootlin.com, f.fainelli@gmail.com, rjui@broadcom.com, tglx@linutronix.de, sebastian.hesselbarth@gmail.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gunter,

On 2020-12-15 00:21, Guenter Roeck wrote:
> On Mon, Nov 09, 2020 at 09:41:19AM +0000, Valentin Schneider wrote:
>> As done for the Arm GIC irqchips, move IPIs to 
>> handle_percpu_devid_irq() as
>> handle_percpu_devid_fasteoi_ipi() isn't actually required.
>> 
>> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> 
> This patch results in boot failures (silent stall) for the qemu
> raspi2 emulation. Unfortunately it can not be reverted because
> handle_percpu_devid_fasteoi_ipi no longer exists in next-20201214,
> so I don't know if it is the only problem.

This is odd. This works just fine for me on both the RPi2 and 3
emulation, running a full Debian userspace. Could this be caused
by the version of QEMU you are using? Here's what I have:

$ qemu-system-arm --version
QEMU emulator version 5.1.0 (Debian 1:5.1+dfsg-4+b1)

Could you try the following hack and let me know if that helps?

Thanks,

         M.

diff --git a/drivers/irqchip/irq-bcm2836.c 
b/drivers/irqchip/irq-bcm2836.c
index 5f5eb8877c41..25c9a9c06e41 100644
--- a/drivers/irqchip/irq-bcm2836.c
+++ b/drivers/irqchip/irq-bcm2836.c
@@ -167,7 +167,7 @@ static void bcm2836_arm_irqchip_handle_ipi(struct 
irq_desc *desc)
  	chained_irq_exit(chip, desc);
  }

-static void bcm2836_arm_irqchip_ipi_eoi(struct irq_data *d)
+static void bcm2836_arm_irqchip_ipi_ack(struct irq_data *d)
  {
  	int cpu = smp_processor_id();

@@ -195,7 +195,7 @@ static struct irq_chip bcm2836_arm_irqchip_ipi = {
  	.name		= "IPI",
  	.irq_mask	= bcm2836_arm_irqchip_dummy_op,
  	.irq_unmask	= bcm2836_arm_irqchip_dummy_op,
-	.irq_eoi	= bcm2836_arm_irqchip_ipi_eoi,
+	.irq_ack	= bcm2836_arm_irqchip_ipi_ack,
  	.ipi_send_mask	= bcm2836_arm_irqchip_ipi_send_mask,
  };
-- 
Jazz is not dead. It just smells funny...
