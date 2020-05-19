Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF96A1DA480
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 00:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbgESWZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 18:25:49 -0400
Received: from foss.arm.com ([217.140.110.172]:42390 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbgESWZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 18:25:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6491830E;
        Tue, 19 May 2020 15:25:47 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 13FE93F52E;
        Tue, 19 May 2020 15:25:45 -0700 (PDT)
References: <20200519161755.209565-1-maz@kernel.org> <20200519161755.209565-2-maz@kernel.org>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Sumit Garg <sumit.garg@linaro.org>, kernel-team@android.com
Subject: Re: [PATCH 01/11] genirq: Add fasteoi IPI flow
In-reply-to: <20200519161755.209565-2-maz@kernel.org>
Date:   Tue, 19 May 2020 23:25:43 +0100
Message-ID: <jhj8shnr28o.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 19/05/20 17:17, Marc Zyngier wrote:
> For irqchips using the fasteoi flow, IPIs are a bit special.
>
> They need to be EOId early (before calling the handler), as
> funny things may happen in the handler (they do not necessarily
> behave like a normal interrupt), and that the arch code is
> already handling the stats.
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  include/linux/irq.h |  1 +
>  kernel/irq/chip.c   | 26 ++++++++++++++++++++++++++
>  2 files changed, 27 insertions(+)
>
> diff --git a/include/linux/irq.h b/include/linux/irq.h
> index 8d5bc2c237d7..726f94d8b8cc 100644
> --- a/include/linux/irq.h
> +++ b/include/linux/irq.h
> @@ -621,6 +621,7 @@ static inline int irq_set_parent(int irq, int parent_irq)
>   */
>  extern void handle_level_irq(struct irq_desc *desc);
>  extern void handle_fasteoi_irq(struct irq_desc *desc);
> +extern void handle_percpu_devid_fasteoi_ipi(struct irq_desc *desc);
>  extern void handle_edge_irq(struct irq_desc *desc);
>  extern void handle_edge_eoi_irq(struct irq_desc *desc);
>  extern void handle_simple_irq(struct irq_desc *desc);
> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> index 41e7e37a0928..7b0b789cfed4 100644
> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
> @@ -955,6 +955,32 @@ void handle_percpu_devid_irq(struct irq_desc *desc)
>               chip->irq_eoi(&desc->irq_data);
>  }
>
> +/**
> + * handle_percpu_devid_fasteoi_ipi - Per CPU local IPI handler with per cpu
> + *				     dev ids
> + * @desc:	the interrupt description structure for this irq
> + *
> + * The biggest differences with the IRQ version are that:
> + * - the interrupt is EOIed early, as the IPI could result in a context
> + *   switch, and we need to make sure the IPI can fire again
> + * - Stats are usually handled at the architecture level, so we ignore them
> + *   here
> + */
> +void handle_percpu_devid_fasteoi_ipi(struct irq_desc *desc)
> +{
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	struct irqaction *action = desc->action;
> +	unsigned int irq = irq_desc_get_irq(desc);
> +	irqreturn_t res;
> +

Tied to the following patch, does that want something like

+	if (!irq_settings_is_no_accounting(desc))
+		__kstat_incr_irqs_this_cpu(desc);
+

While I'm at it, now that we would have IPIs as 'normal' interrupts, what
prevents us from getting rid of the arch-side accounting? Is it just that
we are keeping it as long as handle_IPI() lives, or are there more hurdles
hidden around?

> +	if (chip->irq_eoi)
> +		chip->irq_eoi(&desc->irq_data);
> +
> +	trace_irq_handler_entry(irq, action);
> +	res = action->handler(irq, raw_cpu_ptr(action->percpu_dev_id));
> +	trace_irq_handler_exit(irq, action, res);
> +}
> +
>  /**
>   * handle_percpu_devid_fasteoi_nmi - Per CPU local NMI handler with per cpu
>   *				     dev ids
