Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A26952A4944
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 16:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbgKCPST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 10:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728439AbgKCPSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 10:18:14 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB7BC0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 07:18:13 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id g17so3331769qts.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 07:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vYUrpUWpmFGKJgf4Pxch6v6/MgxnA2A1h0hT6owcRkY=;
        b=SshkiWAjtFYs2rlJJ3LivK39Rr8gkIA8Xl7S4eUgo4aX0zYjWSxwI+qucQIXXgjNFO
         D2zGmrFGUPAJbdJGhdfqSVxuPamFdCqi3lmZXyizmHV9b2KCeRKVDbKPX+oLigIaGdMK
         rF2jdRAc2I3B95POI0EiNE2JIEOcw/5wQ6ObWk9F2GEhV9QZ3NDeJNaCG+2IWw3bwD6H
         1Q/rjPGRLhJh/NaJLqq1Dib/yTRQhn9tPyrHS5V3OC54q5A9ZSY+6LGw0homW7iZzx/n
         yFfjNYI06edc4zNDdFmnYHVIeC37nNX6/0Iohv7RezOIQzY+3J05NYaP/6ic3YlTZ54X
         YfZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vYUrpUWpmFGKJgf4Pxch6v6/MgxnA2A1h0hT6owcRkY=;
        b=Ak1qdwHfwMJYGtzPnZy7EfrsJpo9ITEY13fKXUQcgPnkKjz6MuPZLpr8kI1jhsvToY
         NGXRga4ffkfRPCUq6MuQcPVhkZSTbwd2XkP4Wr69Pbt2bjQP1jFokhnBBPxqdumpYioD
         F7k1D7S1YrUkxO2+B0ttQ20JFOEom/45KwCv5y/hmmaR6R+R2DeMpbZMIMz9uORpDKeM
         bgs4K93L1E99yX9dSL6aSK0o7PRz9VCA2+ZrVawiqwk9ALRfPpoPJ6FRZbVnn0C4IGI7
         KESD+Vtox1j4jIDgktEXMZnsKVgbqw4AVfUIQxIwz+60287dnzDZlyqgysiT8vtAyc7D
         PRqQ==
X-Gm-Message-State: AOAM533dlriNvE9b0UI5o4JTY6ti79duxlzRkMKQWbr/4TddimuM3dPF
        MHyje0WLBJgLuyV+V6Us+3Zy80mWf8nVb654m/2WjQ==
X-Google-Smtp-Source: ABdhPJxU0p/fXVYrNfpoYAr5eHWGTIuKMCqE7QvyT94egc1XnCWMfxjY0ABEeObwlneNVHsZlXlW0mh2pKTg6oJJHss=
X-Received: by 2002:ac8:6b51:: with SMTP id x17mr18679113qts.203.1604416692698;
 Tue, 03 Nov 2020 07:18:12 -0800 (PST)
MIME-Version: 1.0
References: <20201028214359.384918-1-daniel.gutson@eclypsium.com>
 <20201029054110.GA3039992@kroah.com> <CAFmMkTHBXjNc0DeL0bOZfdJkZjPAHnRU1THHdk0tZcBr1yykTQ@mail.gmail.com>
 <20201029191505.GC986195@kroah.com>
In-Reply-To: <20201029191505.GC986195@kroah.com>
From:   Daniel Gutson <daniel@eclypsium.com>
Date:   Tue, 3 Nov 2020 12:18:01 -0300
Message-ID: <CAFmMkTHniN8FA7KkknDyRU0E0JWP15dC-xMRqJb-rg8oEgCyYg@mail.gmail.com>
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

On Thu, Oct 29, 2020 at 4:14 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Oct 29, 2020 at 12:39:08PM -0300, Daniel Gutson wrote:
> > On Thu, Oct 29, 2020 at 2:40 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Wed, Oct 28, 2020 at 06:43:59PM -0300, Daniel Gutson wrote:
> > > > This patch separates the writing part of the intel-spi drivers
> > > > so the 'dangerous' part can be set/unset independently.
> > > > This way, the kernel can be configured to include the reading
> > > > parts of the driver which can be used without
> > > > the dangerous write operations that can turn the system
> > > > unbootable.
> > > >
> > > > Signed-off-by: Daniel Gutson <daniel.gutson@eclypsium.com>
> > > > ---
> > > >  drivers/mtd/spi-nor/controllers/Kconfig     | 39 ++++++++++++---------
> > > >  drivers/mtd/spi-nor/controllers/intel-spi.c | 12 +++++--
> > > >  2 files changed, 33 insertions(+), 18 deletions(-)
> > > >
> > > > diff --git a/drivers/mtd/spi-nor/controllers/Kconfig b/drivers/mtd/spi-nor/controllers/Kconfig
> > > > index 5c0e0ec2e6d1..491c755fea49 100644
> > > > --- a/drivers/mtd/spi-nor/controllers/Kconfig
> > > > +++ b/drivers/mtd/spi-nor/controllers/Kconfig
> > > > @@ -31,34 +31,41 @@ config SPI_INTEL_SPI
> > > >       tristate
> > > >
> > > >  config SPI_INTEL_SPI_PCI
> > > > -     tristate "Intel PCH/PCU SPI flash PCI driver (DANGEROUS)"
> > > > +     tristate "Intel PCH/PCU SPI flash PCI driver"
> > > >       depends on X86 && PCI
> > > >       select SPI_INTEL_SPI
> > > >       help
> > > > -       This enables PCI support for the Intel PCH/PCU SPI controller in
> > > > -       master mode. This controller is present in modern Intel hardware
> > > > -       and is used to hold BIOS and other persistent settings. Using
> > > > -       this driver it is possible to upgrade BIOS directly from Linux.
> > > > -
> > > > -       Say N here unless you know what you are doing. Overwriting the
> > > > -       SPI flash may render the system unbootable.
> > > > +       This enables read only PCI support for the Intel PCH/PCU SPI
> > > > +       controller in master mode. This controller is present in modern
> > > > +       Intel hardware and is used to hold BIOS and other persistent settings.
> > > > +       Using this driver it is possible to read the SPI chip directly
> > > > +       from Linux.
> > > >
> > > >         To compile this driver as a module, choose M here: the module
> > > >         will be called intel-spi-pci.
> > > >
> > > >  config SPI_INTEL_SPI_PLATFORM
> > > > -     tristate "Intel PCH/PCU SPI flash platform driver (DANGEROUS)"
> > > > +     tristate "Intel PCH/PCU SPI flash platform driver"
> > > >       depends on X86
> > > >       select SPI_INTEL_SPI
> > > >       help
> > > > -       This enables platform support for the Intel PCH/PCU SPI
> > > > +       This enables read only platform support for the Intel PCH/PCU SPI
> > > >         controller in master mode. This controller is present in modern
> > > > -       Intel hardware and is used to hold BIOS and other persistent
> > > > -       settings. Using this driver it is possible to upgrade BIOS
> > > > -       directly from Linux.
> > > > +       Intel hardware and is used to hold BIOS and other persistent settings.
> > > > +       Using this driver it is possible to read the SPI chip directly
> > > > +       from Linux.
> > > > +
> > > > +       To compile this driver as a module, choose M here: the module
> > > > +       will be called intel-spi-pci.
> > > > +
> > > > +config SPI_INTEL_SPI_WRITE
> > > > +     bool "Intel PCH/PCU SPI flash drivers write operations (DANGEROUS)"
> > > > +     depends on SPI_INTEL_SPI_PCI || SPI_INTEL_SPI_PLATFORM
> > > > +     help
> > > > +       This enables full read/write support for the Intel PCH/PCU SPI
> > > > +       controller.
> > > > +       Using this option it may be possible to upgrade BIOS directly
> > > > +       from Linux.
> > > >
> > > >         Say N here unless you know what you are doing. Overwriting the
> > > >         SPI flash may render the system unbootable.
> > > > -
> > > > -       To compile this driver as a module, choose M here: the module
> > > > -       will be called intel-spi-platform.
> > > > diff --git a/drivers/mtd/spi-nor/controllers/intel-spi.c b/drivers/mtd/spi-nor/controllers/intel-spi.c
> > > > index b54a56a68100..8d8053395c3d 100644
> > > > --- a/drivers/mtd/spi-nor/controllers/intel-spi.c
> > > > +++ b/drivers/mtd/spi-nor/controllers/intel-spi.c
> > > > @@ -266,6 +266,7 @@ static int intel_spi_read_block(struct intel_spi *ispi, void *buf, size_t size)
> > > >       return 0;
> > > >  }
> > > >
> > > > +#ifdef CONFIG_SPI_INTEL_SPI_WRITE
> > >
> > > <snip>
> > >
> > > Please do not add #ifdef to .c files, that's not the proper kernel
> > > coding style at all, and just makes maintaining this file much much
> > > harder over time.
> > >
> > > Split things out into two different files if you really need to do this.
> >
> > What about the static functions that I'll need to turn non-static and
> > in a header file?
> > I mean, the functions that the functions in the new file will have to call.
> > Should I do that, turn static functions into non-static and declared
> > in a header file?
>
> No idea, but again, no #ifdefs in .c files like this, that is not the
> proper kernel coding style as it is not maintainable for the lifespan
> that we have to maintain code.

Is it acceptable to leave static functions unused and let the optimizer
remove them as DCE? This way I would just leave the writing functions
unused and just apply the macro to the struct of the callbacks.
Otherwise, I need to move a lot of static and private macros to the
.h to allow the new file use them.

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
