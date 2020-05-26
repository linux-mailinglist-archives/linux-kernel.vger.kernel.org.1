Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33B111C8396
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 09:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgEGHgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 03:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725834AbgEGHgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 03:36:47 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971B1C061A41
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 00:36:46 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id z2so3341487iol.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 00:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=izaC0j97DaEKeWCVsCGRwOFQb7MeNG6AyPzpQh6sfPU=;
        b=c1QbtHwkMQwm1lStyF86Ezx5rzlYQTI7Gd32BWAMTad1lET7RxRG96/ZyNAa0lWZgi
         jAKxt+Z8dD53SeH0xJDt3n4hoiJfIdVzYLiumVXiPvdwhw4uRfCScA028Z8nmu+CgGAy
         Qrl4Qy6OUmThArCylKm6AbYDL2ohS7DjGGSkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=izaC0j97DaEKeWCVsCGRwOFQb7MeNG6AyPzpQh6sfPU=;
        b=CKkBJpN0/wbdN5NMZxhRHovikoS4X1/OWsTLBKIp5ipXC5KoPZwPzdUmTVifHJ7SrG
         jjGGMBLP1bo9v6utyRPDvLrI9/89/xUW8HgqbfTY+s+cf5RJwdjdPVzYM7DDqtbLRI9z
         j1rTaXjSZLF6RfQGOhmrNan3mkWlSIFsjgCw9uNGaDQcwQrcMvdyY/sjQ3+Nr6guAynA
         Dsq3RfqKiOwD8qsXb0OpV3Vg1ud+lu6qzlECeaW+o/Mg3a+2nClTPNKsDBomlBa3PXU/
         KzeTL4JlYeG7HVD5IsfQPMGKBB9U5IeXtc7irDJRl8wKfSMRFylPPPslaxLZsDEJY6nl
         EsxA==
X-Gm-Message-State: AGi0PuZu9muvx4V8eIwM8eNsXQYzeYQ9dJQxczFjQqnzHUf4Sa++Ircw
        GENkrn4SY1KGCWY6sBySyQs8v0RF8wD/uGpZ0T6IEw==
X-Google-Smtp-Source: APiQypLpq8huNxkhKDsHKb6+tSygwEJaTcwboqexXdJmXAAKs6Kn4dvmnWL1eZ5wk46A23oHuVJmrRRiqSUQuHS+m9g=
X-Received: by 2002:a02:6983:: with SMTP id e125mr12598539jac.47.1588837005803;
 Thu, 07 May 2020 00:36:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200425133939.3508912-0-mholenko@antmicro.com>
 <20200425133939.3508912-3-mholenko@antmicro.com> <aa7c915310753b042be35758893dee91d3651ffc.camel@kernel.crashing.org>
In-Reply-To: <aa7c915310753b042be35758893dee91d3651ffc.camel@kernel.crashing.org>
From:   Mateusz Holenko <mholenko@antmicro.com>
Date:   Thu, 7 May 2020 09:36:34 +0200
Message-ID: <CAPk366T3ACKrKX=RZwcN3D+Gy43-EGA+6vpwvOh5SKLXd1BM1Q@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] drivers/soc/litex: add LiteX SoC Controller driver
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Stafford Horne <shorne@gmail.com>,
        Karol Gugala <kgugala@antmicro.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Filip Kokosinski <fkokosinski@antmicro.com>,
        Pawel Czarnecki <pczarnecki@internships.antmicro.com>,
        Joel Stanley <joel@jms.id.au>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Maxime Ripard <mripard@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 5:12 AM Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> On Sat, 2020-04-25 at 13:42 +0200, Mateusz Holenko wrote:
> > From: Pawel Czarnecki <pczarnecki@internships.antmicro.com>
> >
> > This commit adds driver for the FPGA-based LiteX SoC
> > Controller from LiteX SoC builder.
>
> Sorry for jumping in late, Joel only just pointed me to this :)
>
> > + * The purpose of `litex_set_reg`/`litex_get_reg` is to implement
> > + * the logic of writing to/reading from the LiteX CSR in a single
> > + * place that can be then reused by all LiteX drivers.
> > + */
> > +void litex_set_reg(void __iomem *reg, unsigned long reg_size,
> > +                 unsigned long val)
> > +{
> > +     unsigned long shifted_data, shift, i;
> > +     unsigned long flags;
> > +
> > +     spin_lock_irqsave(&csr_lock, flags);
> > +
> > +     for (i = 0; i < reg_size; ++i) {
> > +             shift = ((reg_size - i - 1) * LITEX_SUBREG_SIZE_BIT);
> > +             shifted_data = val >> shift;
> > +
> > +             __raw_writel(shifted_data, reg + (LITEX_REG_SIZE * i));
> > +     }
> > +
> > +     spin_unlock_irqrestore(&csr_lock, flags);
> > +}
> > +
> > +unsigned long litex_get_reg(void __iomem *reg, unsigned long reg_size)
> > +{
> > +     unsigned long shifted_data, shift, i;
> > +     unsigned long result = 0;
> > +     unsigned long flags;
> > +
> > +     spin_lock_irqsave(&csr_lock, flags);
> > +
> > +     for (i = 0; i < reg_size; ++i) {
> > +             shifted_data = __raw_readl(reg + (LITEX_REG_SIZE * i));
> > +
> > +             shift = ((reg_size - i - 1) * LITEX_SUBREG_SIZE_BIT);
> > +             result |= (shifted_data << shift);
> > +     }
> > +
> > +     spin_unlock_irqrestore(&csr_lock, flags);
> > +
> > +     return result;
> > +}
>
> I really don't like the fact that the register sizes & sub sizes are
> #defined. As your comment explains, this makes it harder to support
> other configurations. This geometry should come from the device-tree
> instead.

This is a valid point - putting those parameters into DT would indeed allow
for more flexibility. Currently we are focusing on supporting a single LiteX
configuration (32-bit/8-bit bus) and that's why those parameters got fixed.

Adding support for other configurations however is not just changing those
two parameters (which should be fairly easy by itself), but also
handling different
registers layout for a single peripheral (in different configurations
CSRs offsets and sizes may differ).

Since this adds another layer of complexity we want to start with a simpler
version that can be extended in the future.

> Also this while thing is rather gross (and the lock will not help
> performance). Why can't CSRs be normally memory mapped always instead ?

Using a different LiteX configuration 32-bit/32-bit bus would solve
the problem -
a single LiteX CSR would map nicely to a single 32-bit memory pointer and no
loop/locks would be needed.

In the default configuration (32-bit/8-bit bus) there are gaps between bytes
(as Gabriel Somlo already explained in his mail) which need to be handled
"manually".

> Even when transporting them on a HW bus that's smaller, the HW bus
> conversion should be able to do the break-down into a multi-breat
> transfer rather than doing that in SW.
>
> Or at least have a fast-path if the register size is no larger than the
> sub size, so you can use a normal ioread32/iowrite32.

Again - this is possible, but using a non-default 32-bit/32-bit bus LiteX
configuration.

> Also I wonder ... last I played with LiteX, it would re-generate the
> register layout (including the bit layout inside registers potentially)
> rather enthousiastically, making it pretty hard to have a fixed
> register layout for use by a kernel driver. Was this addressed ?

TBH I never experienced bit layout inside a register to change by itself,
but I agree that using different bus width configurations causes CSRs
to be splitted into 4/2/1 32-bit registers (changing de facto the layout
from the SW perspective) - that's why we provide helper functions
in this file.

It is possible to have different configurations of a peripheral
in LiteX that e.g, turns features on/off - this might cause some CSRs
to shift and result in incompatibilities. There are ways in LiteX
to avoid such problems if the model is properly designed, though.

Another aspect of LiteX is that the order in which separate peripherals
(modules) are created results in a different memory map of the whole SoC.
This, however, is easily addressed by using a dynamically generated DT
and do not require the code of drivers to be altered in any way.

> Cheers,
> Ben.
>
>

Thanks for your comments!


-- 
Mateusz Holenko
Antmicro Ltd | www.antmicro.com
Roosevelta 22, 60-829 Poznan, Poland
