Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2C0B2AD843
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 15:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730519AbgKJOHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 09:07:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgKJOHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 09:07:31 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F92BC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 06:07:30 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id i6so17723545lfd.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 06:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fyaFDmv9n+DlMi8b29T94TKK3unvJxPiu1LCzCeynyI=;
        b=Q/yUQX4/IOYYhSKBfHS9CgoDBsSKp0lu3yzAF0Naw1H/lDuR9BuQbpehzCBE+20iY3
         o9GV0/JHeVsWYLEfp49eOomatnayOJ8oq1oVkhXUxX+Yd22Ye78ib+fKenEaEoMZgVB4
         a9CbT5Y3c/6tPP/pNGCdh2e6gurCI71W88FBN/sPSfir9Y20jkY+saf7cmJ4pHvzDg01
         Ix98/vh6D/Lu4YciKimPfqwlzSDgQP0gexwW1oOuHtHmUutuBjYPNO0TI09nM5ur83F2
         sH+oaY9SXgIG/ApqfpPo5RDDlJI812rk3BV1VI6IIhHFHJ5TbqiKaiwgyTPeHFTHj4jT
         GhJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fyaFDmv9n+DlMi8b29T94TKK3unvJxPiu1LCzCeynyI=;
        b=tDJpCvXKbJLIYHKY0GIJWp6nsMA/rDXK9hX+4NrFQyEscGVWgA7IB+1rk3TR/3j7dx
         lfKWo1Riq0KPPZ1S5qLFsOaGk7kA7F81n7kyI+f1P8p7nt5YeqRorXSlT1YZwnqZd05M
         JeduRaAdujG/3ZBkOjkEX0sd3rTq7J1tYeAcF9/cibyfaj3SLQBRFTJbZgeImoFLFAYU
         Xy6KulT82q/SN94QP2wEYOiYkDbsbj2OK1t3Y5rII3E26HcyuUjKYtwi6hBVKQ7B0qMZ
         H7NCqlduKxDoP0PvgBQqttqTAWQY6Zv07ouQXGpeUn9ZqtqRMlPzV23aCH0nVWYB66lR
         LEmQ==
X-Gm-Message-State: AOAM532cvDmhhs5eop4Y7kpwayiE2ZNa9UHqcIrKLRyY/fFDDgvc0o5B
        nPOPEJor+wtfj7TRHRddh4ZWutcRFwXIhxZfm6jJUJZUC03/Lw==
X-Google-Smtp-Source: ABdhPJzzaH5GLfhRaUWu5NGdK1eBNucf3k4+1Vl4b2g/6vugVqyiM2XuXC8siEttFWDkrjZDXfPiW00sXTITd5LlNTM=
X-Received: by 2002:ac2:483b:: with SMTP id 27mr2376786lft.551.1605017249001;
 Tue, 10 Nov 2020 06:07:29 -0800 (PST)
MIME-Version: 1.0
References: <20200930163714.12879-1-daniel.gutson@eclypsium.com>
 <20200930163714.12879-3-daniel.gutson@eclypsium.com> <20201002134331.GA3418160@kroah.com>
 <CAFmMkTFP9t4NnmVc6_n=5WKoJwvSbCHgY+i=Y_PQxua_626Pfg@mail.gmail.com>
In-Reply-To: <CAFmMkTFP9t4NnmVc6_n=5WKoJwvSbCHgY+i=Y_PQxua_626Pfg@mail.gmail.com>
From:   Daniel Gutson <daniel@eclypsium.com>
Date:   Tue, 10 Nov 2020 11:07:15 -0300
Message-ID: <CAFmMkTG0Sq0nUmuqSVCMhnrkWmKiseh==SbRsbM0jNVomiBHMA@mail.gmail.com>
Subject: Re: [PATCH 2/2] Platform integrity information in sysfs (version 9)
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
        linux-mtd <linux-mtd@lists.infradead.org>,
        Yoav Yaari <yoav.yaari@eclypsium.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 4:55 PM Daniel Gutson <daniel@eclypsium.com> wrote:
>
> On Fri, Oct 2, 2020 at 10:43 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Sep 30, 2020 at 01:37:14PM -0300, Daniel Gutson wrote:
> > > This patch exports the BIOS Write Enable (bioswe), BIOS
> > > Lock Enable (biosle), and the SMM BIOS Write Protect (SMM_BIOSWP) fields of
> > > the BIOS Control register using the platform-integrity misc kernel module.
> > > The idea is to keep adding more flags, not only from the BC but also from
> > > other registers in following versions.
> > >
> > > The goal is that the attributes are avilable to fwupd when SecureBoot
> > > is turned on.
> > >
> > > Signed-off-by: Daniel Gutson <daniel.gutson@eclypsium.com>
> >
> > The subject line doesn't match what this patch does, please fix that up.
> >
> > But there are more core issues in this patch:
> >
> > >
> > > ---
> > >  drivers/mtd/spi-nor/controllers/Kconfig       |  1 +
> > >  .../mtd/spi-nor/controllers/intel-spi-pci.c   | 75 ++++++++++++++-
> > >  .../spi-nor/controllers/intel-spi-platform.c  |  2 +-
> > >  drivers/mtd/spi-nor/controllers/intel-spi.c   | 91 ++++++++++++++++++-
> > >  drivers/mtd/spi-nor/controllers/intel-spi.h   |  9 +-
> > >  5 files changed, 171 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/mtd/spi-nor/controllers/Kconfig b/drivers/mtd/spi-nor/controllers/Kconfig
> > > index 5c0e0ec2e6d1..e7eaef506fc2 100644
> > > --- a/drivers/mtd/spi-nor/controllers/Kconfig
> > > +++ b/drivers/mtd/spi-nor/controllers/Kconfig
> > > @@ -29,6 +29,7 @@ config SPI_NXP_SPIFI
> > >
> > >  config SPI_INTEL_SPI
> > >       tristate
> > > +     depends on PLATFORM_INTEGRITY_DATA
> > >
> > >  config SPI_INTEL_SPI_PCI
> > >       tristate "Intel PCH/PCU SPI flash PCI driver (DANGEROUS)"
> > > diff --git a/drivers/mtd/spi-nor/controllers/intel-spi-pci.c b/drivers/mtd/spi-nor/controllers/intel-spi-pci.c
> > > index c72aa1ab71ad..644b1a6091dc 100644
> > > --- a/drivers/mtd/spi-nor/controllers/intel-spi-pci.c
> > > +++ b/drivers/mtd/spi-nor/controllers/intel-spi-pci.c
> > > @@ -10,11 +10,19 @@
> > >  #include <linux/kernel.h>
> > >  #include <linux/module.h>
> > >  #include <linux/pci.h>
> > > +#include <linux/platform-integrity.h>
> > >
> > >  #include "intel-spi.h"
> > >
> > >  #define BCR          0xdc
> > >  #define BCR_WPD              BIT(0)
> > > +#define BCR_BLE              BIT(1)
> > > +#define BCR_SMM_BWP  BIT(5)
> > > +
> > > +struct cnl_spi_attr {
> > > +     struct device_attribute dev_attr;
> > > +     u32 mask;
> > > +};
> > >
> > >  static const struct intel_spi_boardinfo bxt_info = {
> > >       .type = INTEL_SPI_BXT,
> > > @@ -24,6 +32,70 @@ static const struct intel_spi_boardinfo cnl_info = {
> > >       .type = INTEL_SPI_CNL,
> > >  };
> > >
> > > +#ifdef CONFIG_PLATFORM_INTEGRITY_DATA
> > > +static ssize_t intel_spi_cnl_spi_attr_show(struct device *dev,
> > > +                                        struct device_attribute *attr,
> > > +                                        char *buf, u32 mask)
> > > +{
> > > +     u32 bcr;
> > > +
> > > +     if (dev->parent == NULL)
> > > +             return -EIO;
> > > +
> > > +     if (pci_read_config_dword(container_of(dev->parent, struct pci_dev, dev),
> > > +                               BCR, &bcr) != PCIBIOS_SUCCESSFUL)
> > > +             return -EIO;
> > > +
> > > +     return sprintf(buf, "%d\n", (int)!!(bcr & mask));
> > > +}
> > > +
> > > +static ssize_t bioswe_show(struct device *dev, struct device_attribute *attr,
> > > +                        char *buf)
> > > +{
> > > +     return intel_spi_cnl_spi_attr_show(dev, attr, buf, BCR_WPD);
> > > +}
> > > +static DEVICE_ATTR_RO(bioswe);
> > > +
> > > +static ssize_t biosle_show(struct device *dev, struct device_attribute *attr,
> > > +                        char *buf)
> > > +{
> > > +     return intel_spi_cnl_spi_attr_show(dev, attr, buf, BCR_BLE);
> > > +}
> > > +static DEVICE_ATTR_RO(biosle);
> > > +
> > > +static ssize_t smm_bioswp_show(struct device *dev, struct device_attribute *attr,
> > > +                            char *buf)
> > > +{
> > > +     return intel_spi_cnl_spi_attr_show(dev, attr, buf, BCR_SMM_BWP);
> > > +}
> > > +static DEVICE_ATTR_RO(smm_bioswp);
> > > +
> > > +static struct attribute *cnl_attrs[] = {
> > > +     &dev_attr_bioswe.attr,
> > > +     &dev_attr_biosle.attr,
> > > +     &dev_attr_smm_bioswp.attr,
> > > +     NULL
> > > +};
> > > +ATTRIBUTE_GROUPS(cnl);
> >
> > If you are forcing the driver to create the groups, then you are forcing
> > us to audit each driver and verify that the files are the same name and
> > such.  Put the files in the "common" code please, and if you really need
> > a way to get the data out, make that a callback or something.
>
> If I understand you correctly, you are asking the opposite that Arnd
> asked me in a
> previous patch version: he told me no new callbacks, just use the
> device attribute API.
> However I'm not sure I understand your proposal, do you mean to let
> the device attr
> stay in the driver file, and do the group inside the common part? Therefore,
> to pass a dev attributes array to the common part?
> If not, could you please explain your proposal again?


ping please.

>
> >
> > Also, this name "platform integrity" is really really generic, while in
> > reality you are describing something very specific.  Are you sure you
> > want that?
> >
> > thanks,
> >
> > greg k-h
>
>
>
> --
>
>
> Daniel Gutson
> Engineering Director
> Eclypsium, Inc.
>
>
> Below The Surface: Get the latest threat research and insights on
> firmware and supply chain threats from the research team at Eclypsium.
> https://eclypsium.com/research/#threatreport



-- 


Daniel Gutson
Engineering Director
Eclypsium, Inc.


Below The Surface: Get the latest threat research and insights on
firmware and supply chain threats from the research team at Eclypsium.
https://eclypsium.com/research/#threatreport
