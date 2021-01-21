Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 868702FEA93
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 13:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730455AbhAUMrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 07:47:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:60288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731298AbhAUMpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 07:45:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B3E20239FF
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 12:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611233074;
        bh=myULDxLA57azPbQV/b8fZy9KYbD60iB/nUkEu01fjvc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TBr3PDGjSGNlQHaYgWN56fsatwC3dfS9HVIUCDgezfKgOFXzA7Db3bxB6hvWkhee2
         MMArq9NgrkuINVYKQ/26jtPQxWBoyHGrIGNcFBrD8B/5xV84ADsaJ60AXLu70T4Y9y
         ZsD+K0SexIZZ+Nd1zHQueQOOPa6TXYZzW8Km848tMlVlmM7DHj5X9WG2JIc3d2d/OG
         j+g2FwSUMXqjjUbzWyv1j5ZyDFQB8tc6Sq7VJJIq+b8DTG7vw1IxQqOmGDZFIiNSQm
         21ogVXjQ6EIYcz90a+N2DWVDZDhc2ft0/0ln0MuoEqzGTm+VT5biJZ+vuqq2mV6qsG
         XJrd/Hp6sT7lA==
Received: by mail-ot1-f48.google.com with SMTP id v1so1425970ott.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 04:44:34 -0800 (PST)
X-Gm-Message-State: AOAM530PHLc4rqr5/p01Dz4iz14MUfqdBvq9DwKQKn4AHUkMOHwWStvb
        yEjd/p77OH3jo26gw/9AiOjRL/95NpBcz1v30iI=
X-Google-Smtp-Source: ABdhPJwLKTUzkB8CP1EzpBdWoaJP4pt2eCRtFjV0UOYIXGY7x5yVsPgKDybYei9Z5/D76Lw031hliJrud2qIQjmQZto=
X-Received: by 2002:a05:6830:139a:: with SMTP id d26mr10307664otq.305.1611233073918;
 Thu, 21 Jan 2021 04:44:33 -0800 (PST)
MIME-Version: 1.0
References: <20210120132717.395873-1-mohamed.mediouni@caramail.com> <20210120132717.395873-8-mohamed.mediouni@caramail.com>
In-Reply-To: <20210120132717.395873-8-mohamed.mediouni@caramail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 21 Jan 2021 13:44:17 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1qeVxTxZXpfMe70zpPCSBrTOz23ZTR=PHgw0PP9GUvbw@mail.gmail.com>
Message-ID: <CAK8P3a1qeVxTxZXpfMe70zpPCSBrTOz23ZTR=PHgw0PP9GUvbw@mail.gmail.com>
Subject: Re: [RFC PATCH 7/7] irqchip/apple-aic: add SMP support to the Apple
 AIC driver.
To:     Mohamed Mediouni <mohamed.mediouni@caramail.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Hector Martin <marcan@marcan.st>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Stan Skowronek <stan@corellium.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 2:27 PM Mohamed Mediouni
<mohamed.mediouni@caramail.com> wrote:

> +#ifdef CONFIG_SMP
> +static void apple_aic_ipi_send_mask(struct irq_data *d,
> +                                   const struct cpumask *mask)

Not sure we care about the #ifdef here, given that arch/arm64 does not
allow building a kernel without CONFIG_SMP.

> +       /*
> +     * Ensure that stores to Normal memory are visible to the
> +     * other CPUs before issuing the IPI.
> +     */
> +       wmb();
> +
> +       for_each_cpu (cpu, mask) {
> +               smp_mb__before_atomic();
> +               atomic_or(1u << irqnr, per_cpu_ptr(&aic_ipi_mask, cpu));
> +               smp_mb__after_atomic();
> +               lcpu = get_cpu();
> +               if (aic.fast_ipi) {
> +                       if ((lcpu >> 2) == (cpu >> 2))
> +                               write_sysreg(cpu & 3, SR_APPLE_IPI_LOCAL);
> +                       else
> +                               write_sysreg((cpu & 3) | ((cpu >> 2) << 16),
> +                                            SR_APPLE_IPI_REMOTE);
> +               } else
> +                       writel(lcpu == cpu ? REG_IPI_FLAG_SELF :
> +                                                  (REG_IPI_FLAG_OTHER << cpu),
> +                              aic.base + REG_IPI_SET);
> +               put_cpu();
> +       }
> +
> +       /* Force the above writes to be executed */
> +       if (aic.fast_ipi)
> +               isb();
> +}

Since this just loops over all CPUs, I'd probably just turn it into
an ipi_send_single() callback and have the caller do the
loop for simplicity.

I also have the feeling that splitting one hardware IPI into multiple
logical interrupts, which are then all registered by the same irq
handler adds a little more complexity than necessary.

Changing this would of course require modifications to
arch/arm64/kernel/smp.c, which is hardwired to use
CONFIG_GENERIC_IRQ_IPI in smp_cross_call(), and allowing
a different code path there may be worse than emulating an
irqchip.

> @@ -186,8 +325,11 @@ static int __init apple_aic_init(struct device_node *node,
>         if (WARN(!aic.base, "unable to map aic registers\n"))
>                 return -EINVAL;
>
> +       aic.fast_ipi = of_property_read_bool(node, "fast-ipi");

Where is this property documented, and what decides which one to use?

        Arnd
