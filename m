Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D087F2DABB6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 12:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbgLOLQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 06:16:15 -0500
Received: from foss.arm.com ([217.140.110.172]:34394 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727761AbgLOLPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 06:15:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 24E381FB;
        Tue, 15 Dec 2020 03:14:58 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A0273F66E;
        Tue, 15 Dec 2020 03:14:56 -0800 (PST)
References: <20201109094121.29975-1-valentin.schneider@arm.com> <20201109094121.29975-4-valentin.schneider@arm.com> <20201215002134.GA182208@roeck-us.net> <38f8fbe9ceb7a0adb47e62d62260b297@kernel.org>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Andrew Lunn <andrew@lunn.ch>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Scott Branden <sbranden@broadcom.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH 3/5] irqchip/bcm2836: Make IPIs use handle_percpu_devid_irq()
Message-ID: <jhjim93tj6l.mognet@arm.com>
In-reply-to: <38f8fbe9ceb7a0adb47e62d62260b297@kernel.org>
Date:   Tue, 15 Dec 2020 11:14:50 +0000
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 15/12/20 10:19, Marc Zyngier wrote:
> Hi Gunter,
>
> On 2020-12-15 00:21, Guenter Roeck wrote:
>> On Mon, Nov 09, 2020 at 09:41:19AM +0000, Valentin Schneider wrote:
>>> As done for the Arm GIC irqchips, move IPIs to
>>> handle_percpu_devid_irq() as
>>> handle_percpu_devid_fasteoi_ipi() isn't actually required.
>>>
>>> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
>>
>> This patch results in boot failures (silent stall) for the qemu
>> raspi2 emulation. Unfortunately it can not be reverted because
>> handle_percpu_devid_fasteoi_ipi no longer exists in next-20201214,
>> so I don't know if it is the only problem.
>
> This is odd. This works just fine for me on both the RPi2 and 3
> emulation, running a full Debian userspace. Could this be caused
> by the version of QEMU you are using? Here's what I have:
>
> $ qemu-system-arm --version
> QEMU emulator version 5.1.0 (Debian 1:5.1+dfsg-4+b1)
>
> Could you try the following hack and let me know if that helps?
>

Thanks for looking into this. It does look like I inverted the ordering of
that mailbox write vs the handling of the IPI. I don't see how the IPI
could mess with the mailbox (unless some creative use of irq_work /
smp_call), but in any case having the write in irq_ack() as you've done
below should restore said ordering.

> Thanks,
>
>          M.
>
> diff --git a/drivers/irqchip/irq-bcm2836.c
> b/drivers/irqchip/irq-bcm2836.c
> index 5f5eb8877c41..25c9a9c06e41 100644
> --- a/drivers/irqchip/irq-bcm2836.c
> +++ b/drivers/irqchip/irq-bcm2836.c
> @@ -167,7 +167,7 @@ static void bcm2836_arm_irqchip_handle_ipi(struct
> irq_desc *desc)
>       chained_irq_exit(chip, desc);
>   }
>
> -static void bcm2836_arm_irqchip_ipi_eoi(struct irq_data *d)
> +static void bcm2836_arm_irqchip_ipi_ack(struct irq_data *d)
>   {
>       int cpu = smp_processor_id();
>
> @@ -195,7 +195,7 @@ static struct irq_chip bcm2836_arm_irqchip_ipi = {
>       .name		= "IPI",
>       .irq_mask	= bcm2836_arm_irqchip_dummy_op,
>       .irq_unmask	= bcm2836_arm_irqchip_dummy_op,
> -	.irq_eoi	= bcm2836_arm_irqchip_ipi_eoi,
> +	.irq_ack	= bcm2836_arm_irqchip_ipi_ack,
>       .ipi_send_mask	= bcm2836_arm_irqchip_ipi_send_mask,
>   };
