Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E237129F039
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 16:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbgJ2PjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 11:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727290AbgJ2PjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 11:39:20 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31BE9C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 08:39:20 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id i21so1551422qka.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 08:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YpMSMpdWnDI27qe4/zeIevbA7qnkbhvCd6XQnOrBtHo=;
        b=MvRibrIYNg0MeSZyYa9mK5H+6bXdx7o39FoBXfKv+n6NGem2zAA0tqMOm8vfI0leJw
         JWUs+IYXRbzpZG/oSIkGnv3ljCxoH8nNAmgGvssJ3ksWnMzN3H4TNwpgxITeXMig0MtN
         4QXYfhEN73/wbEvIUXrddTw6VFRtlhh83ch7JtCfG9cwA26Sr4WcUXShte+yisZaJxo6
         uUPkWv0YbHYf8wqbK1Kpw9dc9uuTSBKA0e+ROsPul5RDQCZINks6lQK7FgrD7VOnor2H
         CawPfyaw26oqXCdBXFBVMVYMYrzoevbsBdn0HyA0wYwYFE9emYIWAwnLVkQRFS+WmqVR
         U1jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YpMSMpdWnDI27qe4/zeIevbA7qnkbhvCd6XQnOrBtHo=;
        b=d1U0VcQmw61lbLMtU04nNU8JagbZ/xutJmlk7bT8G0X8GXwzD+4kFqY/tL2bO8RW5g
         /HcbKMNYWYLZ8ZZ4972rhZISII6/i0CER3l0oxVrEiu35APEIfJS4kRPMhuM4BaqubdB
         CiG+eiP2UHmvMd21HzPyugYc0YiuLhSmUprfCMdmATYB+eZwzgwetM9ZCpqavJq2+U2M
         M2n2gC7Xc0/kiSj9mQXrik6XznakDbLy2j4Mi1ZlunKq99tuNWd8mJtAe5Ygou5Wvq9V
         1qJJDgcpR8VviDlFfov65olBP4bU1xa8sCWpi06xWH+BKDRIgdLvbCQvNde0O11Y0iq+
         hSpw==
X-Gm-Message-State: AOAM530nMipNT0sCzxUzNO9fQCi6ycFiGvE/YV3/3t5z9ac5QIITBlMR
        aaZXd7/G5XEN6o/fpZnzL3U+GkQthrM+iLHC7IRnMQ==
X-Google-Smtp-Source: ABdhPJxpVMOLJjj0KrRm94hDKYZszMjxYwzxQp5Z8jS/NgD+6SKT0KDkCCiO2OEDnCgVxhaQMDvEsxTan1bMOUlIxJY=
X-Received: by 2002:a05:620a:21d1:: with SMTP id h17mr4460360qka.368.1603985959134;
 Thu, 29 Oct 2020 08:39:19 -0700 (PDT)
MIME-Version: 1.0
References: <20201028214359.384918-1-daniel.gutson@eclypsium.com> <20201029054110.GA3039992@kroah.com>
In-Reply-To: <20201029054110.GA3039992@kroah.com>
From:   Daniel Gutson <daniel@eclypsium.com>
Date:   Thu, 29 Oct 2020 12:39:08 -0300
Message-ID: <CAFmMkTHBXjNc0DeL0bOZfdJkZjPAHnRU1THHdk0tZcBr1yykTQ@mail.gmail.com>
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

On Thu, Oct 29, 2020 at 2:40 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Oct 28, 2020 at 06:43:59PM -0300, Daniel Gutson wrote:
> > This patch separates the writing part of the intel-spi drivers
> > so the 'dangerous' part can be set/unset independently.
> > This way, the kernel can be configured to include the reading
> > parts of the driver which can be used without
> > the dangerous write operations that can turn the system
> > unbootable.
> >
> > Signed-off-by: Daniel Gutson <daniel.gutson@eclypsium.com>
> > ---
> >  drivers/mtd/spi-nor/controllers/Kconfig     | 39 ++++++++++++---------
> >  drivers/mtd/spi-nor/controllers/intel-spi.c | 12 +++++--
> >  2 files changed, 33 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/mtd/spi-nor/controllers/Kconfig b/drivers/mtd/spi-nor/controllers/Kconfig
> > index 5c0e0ec2e6d1..491c755fea49 100644
> > --- a/drivers/mtd/spi-nor/controllers/Kconfig
> > +++ b/drivers/mtd/spi-nor/controllers/Kconfig
> > @@ -31,34 +31,41 @@ config SPI_INTEL_SPI
> >       tristate
> >
> >  config SPI_INTEL_SPI_PCI
> > -     tristate "Intel PCH/PCU SPI flash PCI driver (DANGEROUS)"
> > +     tristate "Intel PCH/PCU SPI flash PCI driver"
> >       depends on X86 && PCI
> >       select SPI_INTEL_SPI
> >       help
> > -       This enables PCI support for the Intel PCH/PCU SPI controller in
> > -       master mode. This controller is present in modern Intel hardware
> > -       and is used to hold BIOS and other persistent settings. Using
> > -       this driver it is possible to upgrade BIOS directly from Linux.
> > -
> > -       Say N here unless you know what you are doing. Overwriting the
> > -       SPI flash may render the system unbootable.
> > +       This enables read only PCI support for the Intel PCH/PCU SPI
> > +       controller in master mode. This controller is present in modern
> > +       Intel hardware and is used to hold BIOS and other persistent settings.
> > +       Using this driver it is possible to read the SPI chip directly
> > +       from Linux.
> >
> >         To compile this driver as a module, choose M here: the module
> >         will be called intel-spi-pci.
> >
> >  config SPI_INTEL_SPI_PLATFORM
> > -     tristate "Intel PCH/PCU SPI flash platform driver (DANGEROUS)"
> > +     tristate "Intel PCH/PCU SPI flash platform driver"
> >       depends on X86
> >       select SPI_INTEL_SPI
> >       help
> > -       This enables platform support for the Intel PCH/PCU SPI
> > +       This enables read only platform support for the Intel PCH/PCU SPI
> >         controller in master mode. This controller is present in modern
> > -       Intel hardware and is used to hold BIOS and other persistent
> > -       settings. Using this driver it is possible to upgrade BIOS
> > -       directly from Linux.
> > +       Intel hardware and is used to hold BIOS and other persistent settings.
> > +       Using this driver it is possible to read the SPI chip directly
> > +       from Linux.
> > +
> > +       To compile this driver as a module, choose M here: the module
> > +       will be called intel-spi-pci.
> > +
> > +config SPI_INTEL_SPI_WRITE
> > +     bool "Intel PCH/PCU SPI flash drivers write operations (DANGEROUS)"
> > +     depends on SPI_INTEL_SPI_PCI || SPI_INTEL_SPI_PLATFORM
> > +     help
> > +       This enables full read/write support for the Intel PCH/PCU SPI
> > +       controller.
> > +       Using this option it may be possible to upgrade BIOS directly
> > +       from Linux.
> >
> >         Say N here unless you know what you are doing. Overwriting the
> >         SPI flash may render the system unbootable.
> > -
> > -       To compile this driver as a module, choose M here: the module
> > -       will be called intel-spi-platform.
> > diff --git a/drivers/mtd/spi-nor/controllers/intel-spi.c b/drivers/mtd/spi-nor/controllers/intel-spi.c
> > index b54a56a68100..8d8053395c3d 100644
> > --- a/drivers/mtd/spi-nor/controllers/intel-spi.c
> > +++ b/drivers/mtd/spi-nor/controllers/intel-spi.c
> > @@ -266,6 +266,7 @@ static int intel_spi_read_block(struct intel_spi *ispi, void *buf, size_t size)
> >       return 0;
> >  }
> >
> > +#ifdef CONFIG_SPI_INTEL_SPI_WRITE
>
> <snip>
>
> Please do not add #ifdef to .c files, that's not the proper kernel
> coding style at all, and just makes maintaining this file much much
> harder over time.
>
> Split things out into two different files if you really need to do this.

What about the static functions that I'll need to turn non-static and
in a header file?
I mean, the functions that the functions in the new file will have to call.
Should I do that, turn static functions into non-static and declared
in a header file?


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
