Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF3D22A4AC3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 17:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbgKCQHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 11:07:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:45220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbgKCQHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 11:07:51 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 852B920773;
        Tue,  3 Nov 2020 16:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604419670;
        bh=0C3Om95v4rkiVPQy1gKQdTuxFaRCNJMzTxnpPVwYvNA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jeufbIs6Do9Xlt93/4Oy0lYISit5zvCR+D6O2O2yK5AfuMY09BvsVQARycPHlN6IE
         +l1s6BOvazyFgnAO3ki4rD7/43g+IuFxowO9eJH7uBQl009UZ55jTDoTXclib9iTnM
         aP2bIB4eTZtxm/MGS9HFML5+O8+r31Fbo8vRrmRI=
Date:   Tue, 3 Nov 2020 17:08:42 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel Gutson <daniel@eclypsium.com>
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
Subject: Re: [PATCH] mtd: spi-nor: intel-spi: Split intel-spi reading from
 writing
Message-ID: <20201103160842.GA4153227@kroah.com>
References: <20201028214359.384918-1-daniel.gutson@eclypsium.com>
 <20201029054110.GA3039992@kroah.com>
 <CAFmMkTHBXjNc0DeL0bOZfdJkZjPAHnRU1THHdk0tZcBr1yykTQ@mail.gmail.com>
 <20201029191505.GC986195@kroah.com>
 <CAFmMkTHniN8FA7KkknDyRU0E0JWP15dC-xMRqJb-rg8oEgCyYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFmMkTHniN8FA7KkknDyRU0E0JWP15dC-xMRqJb-rg8oEgCyYg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 03, 2020 at 12:18:01PM -0300, Daniel Gutson wrote:
> On Thu, Oct 29, 2020 at 4:14 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Oct 29, 2020 at 12:39:08PM -0300, Daniel Gutson wrote:
> > > On Thu, Oct 29, 2020 at 2:40 AM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Wed, Oct 28, 2020 at 06:43:59PM -0300, Daniel Gutson wrote:
> > > > > This patch separates the writing part of the intel-spi drivers
> > > > > so the 'dangerous' part can be set/unset independently.
> > > > > This way, the kernel can be configured to include the reading
> > > > > parts of the driver which can be used without
> > > > > the dangerous write operations that can turn the system
> > > > > unbootable.
> > > > >
> > > > > Signed-off-by: Daniel Gutson <daniel.gutson@eclypsium.com>
> > > > > ---
> > > > >  drivers/mtd/spi-nor/controllers/Kconfig     | 39 ++++++++++++---------
> > > > >  drivers/mtd/spi-nor/controllers/intel-spi.c | 12 +++++--
> > > > >  2 files changed, 33 insertions(+), 18 deletions(-)
> > > > >
> > > > > diff --git a/drivers/mtd/spi-nor/controllers/Kconfig b/drivers/mtd/spi-nor/controllers/Kconfig
> > > > > index 5c0e0ec2e6d1..491c755fea49 100644
> > > > > --- a/drivers/mtd/spi-nor/controllers/Kconfig
> > > > > +++ b/drivers/mtd/spi-nor/controllers/Kconfig
> > > > > @@ -31,34 +31,41 @@ config SPI_INTEL_SPI
> > > > >       tristate
> > > > >
> > > > >  config SPI_INTEL_SPI_PCI
> > > > > -     tristate "Intel PCH/PCU SPI flash PCI driver (DANGEROUS)"
> > > > > +     tristate "Intel PCH/PCU SPI flash PCI driver"
> > > > >       depends on X86 && PCI
> > > > >       select SPI_INTEL_SPI
> > > > >       help
> > > > > -       This enables PCI support for the Intel PCH/PCU SPI controller in
> > > > > -       master mode. This controller is present in modern Intel hardware
> > > > > -       and is used to hold BIOS and other persistent settings. Using
> > > > > -       this driver it is possible to upgrade BIOS directly from Linux.
> > > > > -
> > > > > -       Say N here unless you know what you are doing. Overwriting the
> > > > > -       SPI flash may render the system unbootable.
> > > > > +       This enables read only PCI support for the Intel PCH/PCU SPI
> > > > > +       controller in master mode. This controller is present in modern
> > > > > +       Intel hardware and is used to hold BIOS and other persistent settings.
> > > > > +       Using this driver it is possible to read the SPI chip directly
> > > > > +       from Linux.
> > > > >
> > > > >         To compile this driver as a module, choose M here: the module
> > > > >         will be called intel-spi-pci.
> > > > >
> > > > >  config SPI_INTEL_SPI_PLATFORM
> > > > > -     tristate "Intel PCH/PCU SPI flash platform driver (DANGEROUS)"
> > > > > +     tristate "Intel PCH/PCU SPI flash platform driver"
> > > > >       depends on X86
> > > > >       select SPI_INTEL_SPI
> > > > >       help
> > > > > -       This enables platform support for the Intel PCH/PCU SPI
> > > > > +       This enables read only platform support for the Intel PCH/PCU SPI
> > > > >         controller in master mode. This controller is present in modern
> > > > > -       Intel hardware and is used to hold BIOS and other persistent
> > > > > -       settings. Using this driver it is possible to upgrade BIOS
> > > > > -       directly from Linux.
> > > > > +       Intel hardware and is used to hold BIOS and other persistent settings.
> > > > > +       Using this driver it is possible to read the SPI chip directly
> > > > > +       from Linux.
> > > > > +
> > > > > +       To compile this driver as a module, choose M here: the module
> > > > > +       will be called intel-spi-pci.
> > > > > +
> > > > > +config SPI_INTEL_SPI_WRITE
> > > > > +     bool "Intel PCH/PCU SPI flash drivers write operations (DANGEROUS)"
> > > > > +     depends on SPI_INTEL_SPI_PCI || SPI_INTEL_SPI_PLATFORM
> > > > > +     help
> > > > > +       This enables full read/write support for the Intel PCH/PCU SPI
> > > > > +       controller.
> > > > > +       Using this option it may be possible to upgrade BIOS directly
> > > > > +       from Linux.
> > > > >
> > > > >         Say N here unless you know what you are doing. Overwriting the
> > > > >         SPI flash may render the system unbootable.
> > > > > -
> > > > > -       To compile this driver as a module, choose M here: the module
> > > > > -       will be called intel-spi-platform.
> > > > > diff --git a/drivers/mtd/spi-nor/controllers/intel-spi.c b/drivers/mtd/spi-nor/controllers/intel-spi.c
> > > > > index b54a56a68100..8d8053395c3d 100644
> > > > > --- a/drivers/mtd/spi-nor/controllers/intel-spi.c
> > > > > +++ b/drivers/mtd/spi-nor/controllers/intel-spi.c
> > > > > @@ -266,6 +266,7 @@ static int intel_spi_read_block(struct intel_spi *ispi, void *buf, size_t size)
> > > > >       return 0;
> > > > >  }
> > > > >
> > > > > +#ifdef CONFIG_SPI_INTEL_SPI_WRITE
> > > >
> > > > <snip>
> > > >
> > > > Please do not add #ifdef to .c files, that's not the proper kernel
> > > > coding style at all, and just makes maintaining this file much much
> > > > harder over time.
> > > >
> > > > Split things out into two different files if you really need to do this.
> > >
> > > What about the static functions that I'll need to turn non-static and
> > > in a header file?
> > > I mean, the functions that the functions in the new file will have to call.
> > > Should I do that, turn static functions into non-static and declared
> > > in a header file?
> >
> > No idea, but again, no #ifdefs in .c files like this, that is not the
> > proper kernel coding style as it is not maintainable for the lifespan
> > that we have to maintain code.
> 
> Is it acceptable to leave static functions unused and let the optimizer
> remove them as DCE?

You will get build warnings if you do that, right?

You have thousands of examples of how to do this correct, it shouldn't
be that tough :)

thanks,

greg k-h
