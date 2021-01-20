Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 934112FDC25
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 22:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388479AbhATVyw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 20 Jan 2021 16:54:52 -0500
Received: from mail-ed1-f53.google.com ([209.85.208.53]:42912 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731038AbhATVZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 16:25:22 -0500
Received: by mail-ed1-f53.google.com with SMTP id g24so11220edw.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 13:25:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Z6bm+KeNhOA+Sfjw842s1FnVFMKm9Ys7vBrmxaK8+TQ=;
        b=byynURv+LUqkdPQpiWSlv1QL5de3EPVbXqX9lhilhG0p3/Hm3K1CZXt8FiatBoyRId
         ogqXVahcHYki8PiZwPw74HWE8rg0xa5SiIkbHKx/ZZwssREy6UWnu7DyutTb5R4Mycdv
         PIvnUNs1+PRwmBqgUj3rQp/OEgbOtLNrN6WivTVqrUbTSyjkiULlTBy2M6rIJAtpTOBi
         QmgHyCk7CTXG829PkRt9F2cIbH4nMG3r3wvsqr7noTixF9GnLj+qmSyI/TOfb8y+6tnv
         kOLR+/CJVSAevLdapKk4dJfMW20a/WpTLSTVByKpRdhp77DY+nWOos3gEM3Hsp7xB/ts
         HVTg==
X-Gm-Message-State: AOAM530DUFECGrqEoDSeI+ZP9O3MHS8bWc9mipX8TV0nOA0k+X9C4wtm
        zlY55s2YDoxfUj2AM7iPEGdC0DL5uZ55OcjKAU8=
X-Google-Smtp-Source: ABdhPJxgdLQe2K1NfnYLUJ/ndoOKOB5ymtxOtt1Ql99dZnAIoIt6XyDcTGEQFAYQystAeXqEX0kRQhXWUNZBwiVHcLI=
X-Received: by 2002:aa7:d148:: with SMTP id r8mr8716147edo.127.1611177879933;
 Wed, 20 Jan 2021 13:24:39 -0800 (PST)
MIME-Version: 1.0
References: <20210120133008.2421897-1-arnd@kernel.org> <20210120133008.2421897-3-arnd@kernel.org>
In-Reply-To: <20210120133008.2421897-3-arnd@kernel.org>
From:   Barry Song <baohua@kernel.org>
Date:   Thu, 21 Jan 2021 10:24:28 +1300
Message-ID: <CAGsJ_4ytgwEs59ji8ur3sifPAj_Pm1eGzMABTS+tdHhi5YWadg@mail.gmail.com>
Subject: Re: [PATCH 2/2] irqchip: remove sirfsoc driver
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@kernel.org> 于2021年1月21日周四 上午2:30写道：
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The CSR SiRF prima2/atlas platforms are getting removed, so this driver
> is no longer needed.
>
> Cc: Barry Song <baohua@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Barry Song <baohua@kernel.org>

> ---
>  drivers/irqchip/Makefile      |   1 -
>  drivers/irqchip/irq-sirfsoc.c | 134 ----------------------------------
>  2 files changed, 135 deletions(-)
>  delete mode 100644 drivers/irqchip/irq-sirfsoc.c
>
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index 084e11774071..37e3556df127 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -45,7 +45,6 @@ obj-$(CONFIG_I8259)                   += irq-i8259.o
>  obj-$(CONFIG_IMGPDC_IRQ)               += irq-imgpdc.o
>  obj-$(CONFIG_IRQ_MIPS_CPU)             += irq-mips-cpu.o
>  obj-$(CONFIG_IXP4XX_IRQ)               += irq-ixp4xx.o
> -obj-$(CONFIG_SIRF_IRQ)                 += irq-sirfsoc.o
>  obj-$(CONFIG_JCORE_AIC)                        += irq-jcore-aic.o
>  obj-$(CONFIG_RDA_INTC)                 += irq-rda-intc.o
>  obj-$(CONFIG_RENESAS_INTC_IRQPIN)      += irq-renesas-intc-irqpin.o
> diff --git a/drivers/irqchip/irq-sirfsoc.c b/drivers/irqchip/irq-sirfsoc.c
> deleted file mode 100644
> index c86faaa35ca4..000000000000
> --- a/drivers/irqchip/irq-sirfsoc.c
> +++ /dev/null
> @@ -1,134 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/*
> - * interrupt controller support for CSR SiRFprimaII
> - *
> - * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
> - */
> -
> -#include <linux/init.h>
> -#include <linux/io.h>
> -#include <linux/irq.h>
> -#include <linux/of.h>
> -#include <linux/of_address.h>
> -#include <linux/irqchip.h>
> -#include <linux/irqdomain.h>
> -#include <linux/syscore_ops.h>
> -#include <asm/mach/irq.h>
> -#include <asm/exception.h>
> -
> -#define SIRFSOC_INT_RISC_MASK0         0x0018
> -#define SIRFSOC_INT_RISC_MASK1         0x001C
> -#define SIRFSOC_INT_RISC_LEVEL0                0x0020
> -#define SIRFSOC_INT_RISC_LEVEL1                0x0024
> -#define SIRFSOC_INIT_IRQ_ID            0x0038
> -#define SIRFSOC_INT_BASE_OFFSET                0x0004
> -
> -#define SIRFSOC_NUM_IRQS               64
> -#define SIRFSOC_NUM_BANKS              (SIRFSOC_NUM_IRQS / 32)
> -
> -static struct irq_domain *sirfsoc_irqdomain;
> -
> -static void __iomem *sirfsoc_irq_get_regbase(void)
> -{
> -       return (void __iomem __force *)sirfsoc_irqdomain->host_data;
> -}
> -
> -static __init void sirfsoc_alloc_gc(void __iomem *base)
> -{
> -       unsigned int clr = IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN;
> -       unsigned int set = IRQ_LEVEL;
> -       struct irq_chip_generic *gc;
> -       struct irq_chip_type *ct;
> -       int i;
> -
> -       irq_alloc_domain_generic_chips(sirfsoc_irqdomain, 32, 1, "irq_sirfsoc",
> -                                      handle_level_irq, clr, set,
> -                                      IRQ_GC_INIT_MASK_CACHE);
> -
> -       for (i = 0; i < SIRFSOC_NUM_BANKS; i++) {
> -               gc = irq_get_domain_generic_chip(sirfsoc_irqdomain, i * 32);
> -               gc->reg_base = base + i * SIRFSOC_INT_BASE_OFFSET;
> -               ct = gc->chip_types;
> -               ct->chip.irq_mask = irq_gc_mask_clr_bit;
> -               ct->chip.irq_unmask = irq_gc_mask_set_bit;
> -               ct->regs.mask = SIRFSOC_INT_RISC_MASK0;
> -       }
> -}
> -
> -static void __exception_irq_entry sirfsoc_handle_irq(struct pt_regs *regs)
> -{
> -       void __iomem *base = sirfsoc_irq_get_regbase();
> -       u32 irqstat;
> -
> -       irqstat = readl_relaxed(base + SIRFSOC_INIT_IRQ_ID);
> -       handle_domain_irq(sirfsoc_irqdomain, irqstat & 0xff, regs);
> -}
> -
> -static int __init sirfsoc_irq_init(struct device_node *np,
> -       struct device_node *parent)
> -{
> -       void __iomem *base = of_iomap(np, 0);
> -       if (!base)
> -               panic("unable to map intc cpu registers\n");
> -
> -       sirfsoc_irqdomain = irq_domain_add_linear(np, SIRFSOC_NUM_IRQS,
> -                                                 &irq_generic_chip_ops, base);
> -       sirfsoc_alloc_gc(base);
> -
> -       writel_relaxed(0, base + SIRFSOC_INT_RISC_LEVEL0);
> -       writel_relaxed(0, base + SIRFSOC_INT_RISC_LEVEL1);
> -
> -       writel_relaxed(0, base + SIRFSOC_INT_RISC_MASK0);
> -       writel_relaxed(0, base + SIRFSOC_INT_RISC_MASK1);
> -
> -       set_handle_irq(sirfsoc_handle_irq);
> -
> -       return 0;
> -}
> -IRQCHIP_DECLARE(sirfsoc_intc, "sirf,prima2-intc", sirfsoc_irq_init);
> -
> -struct sirfsoc_irq_status {
> -       u32 mask0;
> -       u32 mask1;
> -       u32 level0;
> -       u32 level1;
> -};
> -
> -static struct sirfsoc_irq_status sirfsoc_irq_st;
> -
> -static int sirfsoc_irq_suspend(void)
> -{
> -       void __iomem *base = sirfsoc_irq_get_regbase();
> -
> -       sirfsoc_irq_st.mask0 = readl_relaxed(base + SIRFSOC_INT_RISC_MASK0);
> -       sirfsoc_irq_st.mask1 = readl_relaxed(base + SIRFSOC_INT_RISC_MASK1);
> -       sirfsoc_irq_st.level0 = readl_relaxed(base + SIRFSOC_INT_RISC_LEVEL0);
> -       sirfsoc_irq_st.level1 = readl_relaxed(base + SIRFSOC_INT_RISC_LEVEL1);
> -
> -       return 0;
> -}
> -
> -static void sirfsoc_irq_resume(void)
> -{
> -       void __iomem *base = sirfsoc_irq_get_regbase();
> -
> -       writel_relaxed(sirfsoc_irq_st.mask0, base + SIRFSOC_INT_RISC_MASK0);
> -       writel_relaxed(sirfsoc_irq_st.mask1, base + SIRFSOC_INT_RISC_MASK1);
> -       writel_relaxed(sirfsoc_irq_st.level0, base + SIRFSOC_INT_RISC_LEVEL0);
> -       writel_relaxed(sirfsoc_irq_st.level1, base + SIRFSOC_INT_RISC_LEVEL1);
> -}
> -
> -static struct syscore_ops sirfsoc_irq_syscore_ops = {
> -       .suspend        = sirfsoc_irq_suspend,
> -       .resume         = sirfsoc_irq_resume,
> -};
> -
> -static int __init sirfsoc_irq_pm_init(void)
> -{
> -       if (!sirfsoc_irqdomain)
> -               return 0;
> -
> -       register_syscore_ops(&sirfsoc_irq_syscore_ops);
> -       return 0;
> -}
> -device_initcall(sirfsoc_irq_pm_init);
> --
> 2.29.2
>
