Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 648EE284A21
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 12:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgJFKHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 06:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgJFKHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 06:07:15 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98A7C0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 03:07:14 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id kk9so1387887pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 03:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
        bh=H2/CbI90H2tHFtM2OpSUvOgxOAT8HyZq+cctKYqiYE4=;
        b=Z1T7S9H6EltX9KhInaiMv+jpLWHhmt6VObsrvE3EVxUJ4wrM/vUCgirPIeCP/6wzFZ
         Oj6hmfSNqY0KY+uiNKG/O7+16OMBWKRtikjzuG0WpGWZIvi15cHm6ffLeMAMq/QfokeW
         nSqhi3g8jUJrGqarUvhVTTfXqGWqviagOanHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc;
        bh=H2/CbI90H2tHFtM2OpSUvOgxOAT8HyZq+cctKYqiYE4=;
        b=Bg1D8ynAAZy4YNU1KHMBDp3Mk3pOT5jkerNXa+6tP5zdLKhEM8doS3MM+cPsub82S8
         ifNGN/tEenHy58lJdlxNpM0z2446c36JVvpTIKAoKT+y9ZQbfdaCW1MkODQhopG6GSpG
         p6J3e9lu7/lNXO5Ja3ZXda+HtJPh0njo3b1ZojxC7pig3UhPCoz5QG4LeGJqqKXDIA9p
         JoWDqrKoN6O6mHQkJNkb4nol5+2xoGogtEtYO4+JHzOpXAk0MUfAn1YyT/oyXoqqETyA
         UxpcU7LXFCkrqLd8S0XP8BEDxczDoAXYDcSGN/+pw0QnrcBgAZu+g8AYp54KiXvo8iPS
         Dc5w==
X-Gm-Message-State: AOAM530rSLfwEpnD3e3WDWbBp5yTEux1yDj0m/k2idWchp/AJ9gcrmtO
        7VPOgpeyKebHi7KjwgkpeqajhmOdXzrKvPcU4TchBQ==
X-Received: by 2002:a17:90a:94cc:: with SMTP id j12mt2698698pjw.106.1601978834178;
 Tue, 06 Oct 2020 03:07:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAMuHMdUBCf8DsRBvXxxrfrQsab3kOwy95u-KwkdvaSY0vXQnXQ@mail.gmail.com>
 <20200925150607.GB470906@errol.ini.cmu.edu>
In-Reply-To: <20200925150607.GB470906@errol.ini.cmu.edu>
From:   Mateusz Holenko <mholenko@antmicro.com>
Date:   Tue, 6 Oct 2020 12:07:01 +0200
Message-ID: <CAPk366QwL0hvKa6tmMt69WsWFnP3HOxBPYLRMbQgxLXyWvuPyA@mail.gmail.com>
Subject: Re: [PATCH v11 3/5] drivers/soc/litex: add LiteX SoC Controller driver
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gabriel,

On Fri, Sep 25, 2020 at 5:06 PM Gabriel L. Somlo <gsomlo@gmail.com> wrote:
>
> Hi Geert, Mateusz,
>
> On Fri, Sep 25, 2020 at 03:16:02PM +0200, Geert Uytterhoeven wrote:
> > Hi Mateusz,
> >
> > On Wed, Sep 23, 2020 at 12:10 PM Mateusz Holenko <mholenko@antmicro.com> wrote:
> > > From: Pawel Czarnecki <pczarnecki@internships.antmicro.com>
> > >
> > > This commit adds driver for the FPGA-based LiteX SoC
> > > Controller from LiteX SoC builder.
> > >
> > > Co-developed-by: Mateusz Holenko <mholenko@antmicro.com>
> > > Signed-off-by: Mateusz Holenko <mholenko@antmicro.com>
> > > Signed-off-by: Pawel Czarnecki <pczarnecki@internships.antmicro.com>
> >
> > Thanks for your patch!
> >
> > > --- /dev/null
> > > +++ b/drivers/soc/litex/Kconfig
> > > @@ -0,0 +1,15 @@
> > > +# SPDX-License_Identifier: GPL-2.0
> > > +
> > > +menu "Enable LiteX SoC Builder specific drivers"
> > > +
> > > +config LITEX_SOC_CONTROLLER
> > > +       tristate "Enable LiteX SoC Controller driver"
> > > +       depends on OF || COMPILE_TEST
> > > +       help
> > > +         This option enables the SoC Controller Driver which verifies
> > > +         LiteX CSR access and provides common litex_get_reg/litex_set_reg
> > > +         accessors.
> > > +         All drivers that use functions from litex.h must depend on
> > > +         LITEX_SOC_CONTROLLER.
> >
> > I'm wondering if it makes sense to have them depend on a "simpler"
> > symbol instead, e.g. LITEX?
> >
> > Currently the SoC controller is limited to I/O accessors and a simple
> > register compatibility check, but you may want to extend it with more
> > features later, so you probably want to keep the LITEX_SOC_CONTROLLER.
> > Hence you could add
> >
> >     config LITEX
> >         bool
> >
> > and let LITEX_SOC_CONTROLLER select LITEX.
> >
> > > --- /dev/null
> > > +++ b/drivers/soc/litex/litex_soc_ctrl.c
> > > @@ -0,0 +1,194 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * LiteX SoC Controller Driver
> > > + *
> > > + * Copyright (C) 2020 Antmicro <www.antmicro.com>
> > > + *
> > > + */
> > > +
> > > +#include <linux/litex.h>
> > > +#include <linux/device.h>
> > > +#include <linux/errno.h>
> > > +#include <linux/of.h>
> > > +#include <linux/of_platform.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/printk.h>
> > > +#include <linux/module.h>
> > > +#include <linux/errno.h>
> > > +#include <linux/io.h>
> > > +
> > > +/*
> > > + * The parameters below are true for LiteX SoC
> >
> > SoCs
> >
> > > + * configured for 8-bit CSR Bus, 32-bit aligned.
> > > + *
> > > + * Supporting other configurations will require
> > > + * extending the logic in this header.
> >
> > This is no longer a header file.
> >
> > > + */
> > > +#define LITEX_REG_SIZE             0x4
> > > +#define LITEX_SUBREG_SIZE          0x1
> > > +#define LITEX_SUBREG_SIZE_BIT      (LITEX_SUBREG_SIZE * 8)
> > > +
> > > +static DEFINE_SPINLOCK(csr_lock);
> > > +
> > > +/*
> > > + * LiteX SoC Generator, depending on the configuration,
> > > + * can split a single logical CSR (Control & Status Register)
> > > + * into a series of consecutive physical registers.
> > > + *
> > > + * For example, in the configuration with 8-bit CSR Bus,
> > > + * 32-bit aligned (the default one for 32-bit CPUs) a 32-bit
> > > + * logical CSR will be generated as four 32-bit physical registers,
> > > + * each one containing one byte of meaningful data.
> > > + *
> > > + * For details see: https://github.com/enjoy-digital/litex/wiki/CSR-Bus
> > > + *
> > > + * The purpose of `litex_set_reg`/`litex_get_reg` is to implement
> > > + * the logic of writing to/reading from the LiteX CSR in a single
> > > + * place that can be then reused by all LiteX drivers.
> > > + */
> > > +void litex_set_reg(void __iomem *reg, unsigned long reg_size,
> > > +                   unsigned long val)
> > > +{
> > > +       unsigned long shifted_data, shift, i;
> > > +       unsigned long flags;
> > > +
> > > +       spin_lock_irqsave(&csr_lock, flags);
> > > +
> > > +       for (i = 0; i < reg_size; ++i) {
> > > +               shift = ((reg_size - i - 1) * LITEX_SUBREG_SIZE_BIT);
> > > +               shifted_data = val >> shift;
> > > +
> > > +               writel((u32 __force)cpu_to_le32(shifted_data), reg + (LITEX_REG_SIZE * i));
> > > +       }
> > > +
> > > +       spin_unlock_irqrestore(&csr_lock, flags);
> > > +}
> > > +EXPORT_SYMBOL_GPL(litex_set_reg);
> >
> > I'm still wondering about the overhead of loops and multiple accesses,
> > and the need for them (see also BenH's earlier comment).
> > If e.g. the register widths change for LiteUART (currently they're
> > hardcoded to one), would you still consider it using the same
> > programming interface, and thus compatible with "litex,liteuart"?
>
> There's been talk within the LiteX dev community to standardize on a
> LITEX_SUBREG_SIZE of 0x4 (i.e., using all 32 bits of a 32-bit
> (LITEX_REG_SIZE) aligned MMIO location). Early 32-bit (vexriscv based)
> Linux capable LiteX designs started out with only the 8 LSBits used
> within a 32-bit MMIO location, but 64-bit (Rocket chip) based LiteX SoCs
> use 4-byte aligned, fully populated MMIO registers (i.e., both
> LITEX_SUBREG_SIZE *and* LITEX_REG_SIZE are 4). There's also been talk of
> deprecating LITEX_SUBREG_SIZE == 0x1 for "linux-capable LiteX builds",
> but nothing definitive yet AFAIK.

I agree that having LITEX_SUBREG_SIZE equal to 4 would make the code
much simpler.

I believe, however, that at the moment LiteX (for 32-bit CPUs) and
both main 32-bit Linux capable LiteX-based platforms
(https://github.com/litex-hub/linux-on-litex-vexriscv and
https://github.com/timvideos/litex-buildenv) by default generate SoC
with 8-bit data width and that's why the driver currently targets this
configuration.

> As long as adding LITEX_SUBREG_SIZE 0x4 (either as a config option, or
> as a hard-coded default in a subsequent version) won't break things, we
> should be safe going forward afaict.

I'm totally open for extending/changing the default LITEX_SUBREG_SIZE
value for this driver once the default configuration for LiteX
platforms changes.

> Geert: note that LiteX has wider-than-32-bit registers spread across
> multiple 32-bit aligned, 8- or 32-bit wide "subregisters", so looping
> and shifting will still be necessary, even with LITEX_SUBREG_SIZE 0x4.

There are also situations (like the GPIO controller) where the layout
of registers is dynamic and depends on the LiteX configuration (number
of supported pins).
In this situation we need to read the configuration from DT and keep
the driver flexible by using dynamic, loop-based CSR accessors.

That's why I believe we could have both - fast, non-loop based
accessors for common registers widths 8/32/64/etc. and the current
implementation where runtime flexibility is required (at the cost of
performance).

> > The spinlock access will probably become the source of lock contention
> > later, especially when considering SMP variants.
> >
> > > +/*
> > > + * Check LiteX CSR read/write access
> > > + *
> > > + * This function reads and writes a scratch register in order
> > > + * to verify if CSR access works.
> > > + *
> > > + * In case any problems are detected, the driver should panic.
> > > + *
> > > + * Access to the LiteX CSR is, by design, done in CPU native
> > > + * endianness. The driver should not dynamically configure
> > > + * access functions when the endianness mismatch is detected.
> > > + * Such situation indicates problems in the soft SoC design
> > > + * and should be solved at the LiteX generator level,
> > > + * not in the software.
> > > + */
> > > +static int litex_check_csr_access(void __iomem *reg_addr)
> > > +{
> > > +       unsigned long reg;
> > > +
> > > +       reg = litex_get_reg(reg_addr + SCRATCH_REG_OFF, SCRATCH_REG_SIZE);
> > > +
> > > +       if (reg != SCRATCH_REG_VALUE) {
> > > +               panic("Scratch register read error! Expected: 0x%x but got: 0x%lx",
> > > +                       SCRATCH_REG_VALUE, reg);
> >
> > Do you think the user will ever see this panic message? (see below)
> >
> > > +               return -EINVAL;
> >
> > Good ;-)  All of BUG()/WARN()/panic() may be compiled out, depending on
> > config options, so the system may continue running beyond the panic()
> > call.
> >
> > > +static int litex_soc_ctrl_probe(struct platform_device *pdev)
> > > +{
> > > +       int result;
> > > +       struct device *dev;
> > > +       struct device_node *node;
> > > +       struct litex_soc_ctrl_device *soc_ctrl_dev;
> > > +
> > > +       dev = &pdev->dev;
> > > +       node = dev->of_node;
> > > +       if (!node)
> > > +               return -ENODEV;
> >
> > FYI, this cannot happen.
> >
> > > +
> > > +       soc_ctrl_dev = devm_kzalloc(dev, sizeof(*soc_ctrl_dev), GFP_KERNEL);
> > > +       if (!soc_ctrl_dev)
> > > +               return -ENOMEM;
> > > +
> > > +       soc_ctrl_dev->base = devm_platform_ioremap_resource(pdev, 0);
> > > +       if (IS_ERR(soc_ctrl_dev->base))
> > > +               return PTR_ERR(soc_ctrl_dev->base);
> > > +
> > > +       result = litex_check_csr_access(soc_ctrl_dev->base);
> > > +       if (result) {
> > > +               /* LiteX CSRs access is broken which means that
> > > +                * none of LiteX drivers will most probably
> > > +                * operate correctly
> > > +                */
> > > +               WARN(1, "Failed to validate CSR registers, the system is probably broken.\n");
> >
> > WARN(result, ...)
> >
> > But is this WARN() needed? You have already called panic() before.
> >
> > > +       }
> > > +
> > > +       return result;
> > > +}
> > > +
> > > +static struct platform_driver litex_soc_ctrl_driver = {
> > > +       .driver = {
> > > +               .name = "litex-soc-controller",
> > > +               .of_match_table = of_match_ptr(litex_soc_ctrl_of_match)
> > > +       },
> > > +       .probe = litex_soc_ctrl_probe,
> > > +};
> > > +
> > > +module_platform_driver(litex_soc_ctrl_driver);
> >
> > module_platform_driver() means this driver is probed quite late in the
> > boot sequence.  Currently the only other LiteX driver is liteuart, which
> > is probed at more or less the same time, but I can envision more early
> > drivers to be added later (typically interrupt/clock controllers and
> > timers not integrated into the main CPU core).
> > Note that even liteuart will run earlier, and thus access CSR registers
> > before the check has run, when using e.g. earlycon...
> >
> > > --- /dev/null
> > > +++ b/include/linux/litex.h
> > > @@ -0,0 +1,24 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +/*
> > > + * Common LiteX header providing
> > > + * helper functions for accessing CSRs.
> > > + *
> > > + * Implementation of the functions is provided by
> > > + * the LiteX SoC Controller driver.
> > > + *
> > > + * Copyright (C) 2019-2020 Antmicro <www.antmicro.com>
> > > + */
> > > +
> > > +#ifndef _LINUX_LITEX_H
> > > +#define _LINUX_LITEX_H
> > > +
> > > +#include <linux/io.h>
> > > +#include <linux/types.h>
> > > +#include <linux/compiler_types.h>
> > > +
> > > +void litex_set_reg(void __iomem *reg, unsigned long reg_sz, unsigned long val);
> > > +
> > > +unsigned long litex_get_reg(void __iomem *reg, unsigned long reg_sz);
> >
> > Perhaps you can add static inline litex_{read,write}{8,16,32}() wrappers,
> > so drivers don't have to pass the reg_sz parameter explicitly,
> > and to make it look more like accessors of other bus types?
>
> Seconded -- perhaps simply cut'n'paste and/or adapt from
> https://github.com/litex-hub/linux/blob/litex-rocket-rebase/include/linux/litex.h#L78
> (from the 64-bit port of the LiteX linux patch set)
>
> Cheers,
> --Gabriel

Best regards,
Mateusz

--
Mateusz Holenko
Antmicro Ltd | www.antmicro.com
Roosevelta 22, 60-829 Poznan, Poland
