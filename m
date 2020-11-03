Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 363132A4AF6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 17:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbgKCQPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 11:15:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728184AbgKCQPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 11:15:46 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC09C0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 08:15:44 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id t20so7979338qvv.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 08:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nmEKn5Zrmqx5dbhUPcLYxuV5y8DB52aplLnItU43Q1c=;
        b=EK3H8Ewqk5l+B96a+MyscWTns6s6omz2s8Us8jygAnTG9bbwo2vqEuGsPI2vVM39t2
         cv/ismoz3SMJydKNJ2YS+XJXeOAXs/WG2tkQgEP7nPRfoltXBI8EYApDuN01LbjZeCSu
         FXJGbOhjcKmbfs6fdkcItuVCYZfbp5mBWgrSIjRmg4N/RrFqJK1u2GFgGI6tzCm1yPe5
         UDtq2AjHkQ3bSrfmNPuRSGF2B0GcE1shCXDicfBsdd320iew0XMVreXfq7DjXigFDUm4
         Eejnf29gbmITQcFe3U7ZEJr3mMwoUGsmmMe4fr8o0rB5a9ut6vTl+gqzaO7Ys3xWeMNi
         cm0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nmEKn5Zrmqx5dbhUPcLYxuV5y8DB52aplLnItU43Q1c=;
        b=DgHSW085iH9J0Qa1gYVcm6C4xRFOZPsNdkQQBAQPOFkcG/0aCFldKtlUaYKfHImxkk
         E0lCNT6TZ42Hfk8P3KyYlETOFjwCqoi9GrnifSmUM3sgc0L1/ggi352KwwYIkZPYtkwF
         xuyo5C5oKDHIj3dbQ6I8X/blANwByhQ4A6sAordJMWpLyhQwEhbfkuBOErkludo+muf9
         7VugVusQ3tuI/sTIB8G9F29Gzyf6dCWIi2j3ezpj8yPYvQlDbH96a5vCOgfCrYU4TzVW
         8RkbCWqzQmFv/ejgpp18ltMGubCs1dahpzjcrMZFwT45amzOepoyZ8pGIG8xxj5gXB8v
         lAZw==
X-Gm-Message-State: AOAM533mJ4FkIX9bkCL8HlHOkLzZ4kfKtCZ0OkGDQG9UazykTfsUIbrp
        SMMxirbzQPPWiLaw1czByGuVJo7YmbJmRyMSNGenu2dc/FRApQ==
X-Google-Smtp-Source: ABdhPJzTQmAlaetl/9qcOw1tsnWlmjm0Sv4ZiH3IBZaDhZp3fBshqUGyotgyg1cAVvNMfQBweQ2xPHlxc9hycXQf8qo=
X-Received: by 2002:ad4:5808:: with SMTP id dd8mr27209389qvb.58.1604420143732;
 Tue, 03 Nov 2020 08:15:43 -0800 (PST)
MIME-Version: 1.0
References: <20201028214359.384918-1-daniel.gutson@eclypsium.com>
 <20201029054110.GA3039992@kroah.com> <CAFmMkTHBXjNc0DeL0bOZfdJkZjPAHnRU1THHdk0tZcBr1yykTQ@mail.gmail.com>
 <20201029191505.GC986195@kroah.com> <CAFmMkTHniN8FA7KkknDyRU0E0JWP15dC-xMRqJb-rg8oEgCyYg@mail.gmail.com>
 <20201103160842.GA4153227@kroah.com>
In-Reply-To: <20201103160842.GA4153227@kroah.com>
From:   Daniel Gutson <daniel@eclypsium.com>
Date:   Tue, 3 Nov 2020 13:15:32 -0300
Message-ID: <CAFmMkTEdNkLdj0RRGuVrWvF=VkU4H=v=isufBEixmqNa4iVdrA@mail.gmail.com>
Subject: Re: [PATCH] mtd: spi-nor: intel-spi: Split intel-spi reading from writing
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Derek Kiernan <derek.kiernan@xilinx.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Richard Hughes <hughsient@gmail.com>,
        Alex Bazhaniuk <alex@eclypsium.com>,
        linux-mtd <linux-mtd@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 3, 2020 at 1:07 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Nov 03, 2020 at 12:18:01PM -0300, Daniel Gutson wrote:
> > On Thu, Oct 29, 2020 at 4:14 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Thu, Oct 29, 2020 at 12:39:08PM -0300, Daniel Gutson wrote:
> > > > On Thu, Oct 29, 2020 at 2:40 AM Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Wed, Oct 28, 2020 at 06:43:59PM -0300, Daniel Gutson wrote:
> > > > > > This patch separates the writing part of the intel-spi drivers
> > > > > > so the 'dangerous' part can be set/unset independently.
> > > > > > This way, the kernel can be configured to include the reading
> > > > > > parts of the driver which can be used without
> > > > > > the dangerous write operations that can turn the system
> > > > > > unbootable.
> > > > > >
> > > > > > Signed-off-by: Daniel Gutson <daniel.gutson@eclypsium.com>
> > > > > > ---
> > > > > >  drivers/mtd/spi-nor/controllers/Kconfig     | 39 ++++++++++++---------
> > > > > >  drivers/mtd/spi-nor/controllers/intel-spi.c | 12 +++++--
> > > > > >  2 files changed, 33 insertions(+), 18 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/mtd/spi-nor/controllers/Kconfig b/drivers/mtd/spi-nor/controllers/Kconfig
> > > > > > index 5c0e0ec2e6d1..491c755fea49 100644
> > > > > > --- a/drivers/mtd/spi-nor/controllers/Kconfig
> > > > > > +++ b/drivers/mtd/spi-nor/controllers/Kconfig
> > > > > > @@ -31,34 +31,41 @@ config SPI_INTEL_SPI
> > > > > >       tristate
> > > > > >
> > > > > >  config SPI_INTEL_SPI_PCI
> > > > > > -     tristate "Intel PCH/PCU SPI flash PCI driver (DANGEROUS)"
> > > > > > +     tristate "Intel PCH/PCU SPI flash PCI driver"
> > > > > >       depends on X86 && PCI
> > > > > >       select SPI_INTEL_SPI
> > > > > >       help
> > > > > > -       This enables PCI support for the Intel PCH/PCU SPI controller in
> > > > > > -       master mode. This controller is present in modern Intel hardware
> > > > > > -       and is used to hold BIOS and other persistent settings. Using
> > > > > > -       this driver it is possible to upgrade BIOS directly from Linux.
> > > > > > -
> > > > > > -       Say N here unless you know what you are doing. Overwriting the
> > > > > > -       SPI flash may render the system unbootable.
> > > > > > +       This enables read only PCI support for the Intel PCH/PCU SPI
> > > > > > +       controller in master mode. This controller is present in modern
> > > > > > +       Intel hardware and is used to hold BIOS and other persistent settings.
> > > > > > +       Using this driver it is possible to read the SPI chip directly
> > > > > > +       from Linux.
> > > > > >
> > > > > >         To compile this driver as a module, choose M here: the module
> > > > > >         will be called intel-spi-pci.
> > > > > >
> > > > > >  config SPI_INTEL_SPI_PLATFORM
> > > > > > -     tristate "Intel PCH/PCU SPI flash platform driver (DANGEROUS)"
> > > > > > +     tristate "Intel PCH/PCU SPI flash platform driver"
> > > > > >       depends on X86
> > > > > >       select SPI_INTEL_SPI
> > > > > >       help
> > > > > > -       This enables platform support for the Intel PCH/PCU SPI
> > > > > > +       This enables read only platform support for the Intel PCH/PCU SPI
> > > > > >         controller in master mode. This controller is present in modern
> > > > > > -       Intel hardware and is used to hold BIOS and other persistent
> > > > > > -       settings. Using this driver it is possible to upgrade BIOS
> > > > > > -       directly from Linux.
> > > > > > +       Intel hardware and is used to hold BIOS and other persistent settings.
> > > > > > +       Using this driver it is possible to read the SPI chip directly
> > > > > > +       from Linux.
> > > > > > +
> > > > > > +       To compile this driver as a module, choose M here: the module
> > > > > > +       will be called intel-spi-pci.
> > > > > > +
> > > > > > +config SPI_INTEL_SPI_WRITE
> > > > > > +     bool "Intel PCH/PCU SPI flash drivers write operations (DANGEROUS)"
> > > > > > +     depends on SPI_INTEL_SPI_PCI || SPI_INTEL_SPI_PLATFORM
> > > > > > +     help
> > > > > > +       This enables full read/write support for the Intel PCH/PCU SPI
> > > > > > +       controller.
> > > > > > +       Using this option it may be possible to upgrade BIOS directly
> > > > > > +       from Linux.
> > > > > >
> > > > > >         Say N here unless you know what you are doing. Overwriting the
> > > > > >         SPI flash may render the system unbootable.
> > > > > > -
> > > > > > -       To compile this driver as a module, choose M here: the module
> > > > > > -       will be called intel-spi-platform.
> > > > > > diff --git a/drivers/mtd/spi-nor/controllers/intel-spi.c b/drivers/mtd/spi-nor/controllers/intel-spi.c
> > > > > > index b54a56a68100..8d8053395c3d 100644
> > > > > > --- a/drivers/mtd/spi-nor/controllers/intel-spi.c
> > > > > > +++ b/drivers/mtd/spi-nor/controllers/intel-spi.c
> > > > > > @@ -266,6 +266,7 @@ static int intel_spi_read_block(struct intel_spi *ispi, void *buf, size_t size)
> > > > > >       return 0;
> > > > > >  }
> > > > > >
> > > > > > +#ifdef CONFIG_SPI_INTEL_SPI_WRITE
> > > > >
> > > > > <snip>
> > > > >
> > > > > Please do not add #ifdef to .c files, that's not the proper kernel
> > > > > coding style at all, and just makes maintaining this file much much
> > > > > harder over time.
> > > > >
> > > > > Split things out into two different files if you really need to do this.
> > > >
> > > > What about the static functions that I'll need to turn non-static and
> > > > in a header file?
> > > > I mean, the functions that the functions in the new file will have to call.
> > > > Should I do that, turn static functions into non-static and declared
> > > > in a header file?
> > >
> > > No idea, but again, no #ifdefs in .c files like this, that is not the
> > > proper kernel coding style as it is not maintainable for the lifespan
> > > that we have to maintain code.
> >
> > Is it acceptable to leave static functions unused and let the optimizer
> > remove them as DCE?
>
> You will get build warnings if you do that, right?

I don't know why I didn't get any unused function warning, but OK. I'm using
a decently recent gcc.

>
> You have thousands of examples of how to do this correct, it shouldn't
> be that tough :)

The job is not that tough, you are to accept changes :)


>
> thanks,
>
> greg k-h



-- 


Daniel Gutson
Engineering Director
Eclypsium, Inc.


Below The Surface: Get the latest threat research and insights on
firmware and supply chain threats from the research team at Eclypsium.
https://eclypsium.com/research/#threatreport
