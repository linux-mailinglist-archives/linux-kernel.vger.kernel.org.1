Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1904A295326
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 21:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440830AbgJUTzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 15:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439094AbgJUTzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 15:55:19 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2701C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 12:55:18 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id p88so3078297qtd.12
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 12:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ySDDQUVYXg1XZLrfMirp3Cf9UV0gvZGUS0mD7djyRgo=;
        b=Ve1oW0rGiEqlXnVplS6GzzcMGAUyDJoc5oqPT9uaoIK2ok+oH8ypKy9ME/giQfNtPy
         FbnUmj5qhBIXbnC1pB29fV1t1SNAG+dUECsBVIg6bK61AEdtf5PEm7RGt3IgKTpfEdEr
         3wfCABN/MGy96+ecxBOjudNtS4ujoZTxwhKupj3NsVkePPg/y6XsGeBlppBGSAlGaLAX
         JNQ+9K9wTRX1slo52xqfkPWrgMWjicm7V09uuGiCmCHc/ouMfaBYhOHNEWAB2SF4MIKg
         Fv0s26KKSnY82tW4aC2FGRctWe8KjW0El+N46Q76Q03yEe9SUIaVrsQO4cgJ0j2nEcbq
         osHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ySDDQUVYXg1XZLrfMirp3Cf9UV0gvZGUS0mD7djyRgo=;
        b=OqKze1MBWSenK5VswQiWkNeCjhc8Qjk5n7durufpRWWrZc7OSKFhweGs2XkcLe7C7p
         c2Xr6eXFcKDbGTYrxc6pA+mMulfeRKn5maWO3yU640Qk/mg2DQrNJseFGcko3MLrmj/E
         bIJkdLLzDAhxCjiNL/k6l/fA9WWU5AV/p1us28lHF3mTfIIg7yNo77TVai3t8nKAnOox
         j4hzwUQXgLKpIPJGbudkrxXgrvg0yCj0YGmwKYJIocIrNu+pOsyH3N+LoN4PbXReRiIV
         AWupFvB6IvqxHYx+CMdZhrtAJrYmiF4Bx2DjlnlnFblrO98hdbTNXyv75kFojzr4XA9M
         4H4w==
X-Gm-Message-State: AOAM531TleZS7YjxSbyY+vNs/3iM7mzd11TvuGsbK/7Emdm9bIwAb93k
        SyCR93UfsejkUoYrY2g7BYfYe346dAp5Ls9OLNUAnQ==
X-Google-Smtp-Source: ABdhPJzRf1mUOKYHOp6LTGsFpj/IsRHkAL0GcKTXP1/Y58oiEfOkdqVIeEituSuoCg/xLIA7Gv7yhyZ/1KgSSQx+WiY=
X-Received: by 2002:aed:3147:: with SMTP id 65mr4816474qtg.295.1603310117733;
 Wed, 21 Oct 2020 12:55:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200930163714.12879-1-daniel.gutson@eclypsium.com>
 <20200930163714.12879-3-daniel.gutson@eclypsium.com> <20201002134331.GA3418160@kroah.com>
In-Reply-To: <20201002134331.GA3418160@kroah.com>
From:   Daniel Gutson <daniel@eclypsium.com>
Date:   Wed, 21 Oct 2020 16:55:06 -0300
Message-ID: <CAFmMkTFP9t4NnmVc6_n=5WKoJwvSbCHgY+i=Y_PQxua_626Pfg@mail.gmail.com>
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
        linux-mtd <linux-mtd@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 2, 2020 at 10:43 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Sep 30, 2020 at 01:37:14PM -0300, Daniel Gutson wrote:
> > This patch exports the BIOS Write Enable (bioswe), BIOS
> > Lock Enable (biosle), and the SMM BIOS Write Protect (SMM_BIOSWP) fields of
> > the BIOS Control register using the platform-integrity misc kernel module.
> > The idea is to keep adding more flags, not only from the BC but also from
> > other registers in following versions.
> >
> > The goal is that the attributes are avilable to fwupd when SecureBoot
> > is turned on.
> >
> > Signed-off-by: Daniel Gutson <daniel.gutson@eclypsium.com>
>
> The subject line doesn't match what this patch does, please fix that up.
>
> But there are more core issues in this patch:
>
> >
> > ---
> >  drivers/mtd/spi-nor/controllers/Kconfig       |  1 +
> >  .../mtd/spi-nor/controllers/intel-spi-pci.c   | 75 ++++++++++++++-
> >  .../spi-nor/controllers/intel-spi-platform.c  |  2 +-
> >  drivers/mtd/spi-nor/controllers/intel-spi.c   | 91 ++++++++++++++++++-
> >  drivers/mtd/spi-nor/controllers/intel-spi.h   |  9 +-
> >  5 files changed, 171 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/mtd/spi-nor/controllers/Kconfig b/drivers/mtd/spi-nor/controllers/Kconfig
> > index 5c0e0ec2e6d1..e7eaef506fc2 100644
> > --- a/drivers/mtd/spi-nor/controllers/Kconfig
> > +++ b/drivers/mtd/spi-nor/controllers/Kconfig
> > @@ -29,6 +29,7 @@ config SPI_NXP_SPIFI
> >
> >  config SPI_INTEL_SPI
> >       tristate
> > +     depends on PLATFORM_INTEGRITY_DATA
> >
> >  config SPI_INTEL_SPI_PCI
> >       tristate "Intel PCH/PCU SPI flash PCI driver (DANGEROUS)"
> > diff --git a/drivers/mtd/spi-nor/controllers/intel-spi-pci.c b/drivers/mtd/spi-nor/controllers/intel-spi-pci.c
> > index c72aa1ab71ad..644b1a6091dc 100644
> > --- a/drivers/mtd/spi-nor/controllers/intel-spi-pci.c
> > +++ b/drivers/mtd/spi-nor/controllers/intel-spi-pci.c
> > @@ -10,11 +10,19 @@
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> >  #include <linux/pci.h>
> > +#include <linux/platform-integrity.h>
> >
> >  #include "intel-spi.h"
> >
> >  #define BCR          0xdc
> >  #define BCR_WPD              BIT(0)
> > +#define BCR_BLE              BIT(1)
> > +#define BCR_SMM_BWP  BIT(5)
> > +
> > +struct cnl_spi_attr {
> > +     struct device_attribute dev_attr;
> > +     u32 mask;
> > +};
> >
> >  static const struct intel_spi_boardinfo bxt_info = {
> >       .type = INTEL_SPI_BXT,
> > @@ -24,6 +32,70 @@ static const struct intel_spi_boardinfo cnl_info = {
> >       .type = INTEL_SPI_CNL,
> >  };
> >
> > +#ifdef CONFIG_PLATFORM_INTEGRITY_DATA
> > +static ssize_t intel_spi_cnl_spi_attr_show(struct device *dev,
> > +                                        struct device_attribute *attr,
> > +                                        char *buf, u32 mask)
> > +{
> > +     u32 bcr;
> > +
> > +     if (dev->parent == NULL)
> > +             return -EIO;
> > +
> > +     if (pci_read_config_dword(container_of(dev->parent, struct pci_dev, dev),
> > +                               BCR, &bcr) != PCIBIOS_SUCCESSFUL)
> > +             return -EIO;
> > +
> > +     return sprintf(buf, "%d\n", (int)!!(bcr & mask));
> > +}
> > +
> > +static ssize_t bioswe_show(struct device *dev, struct device_attribute *attr,
> > +                        char *buf)
> > +{
> > +     return intel_spi_cnl_spi_attr_show(dev, attr, buf, BCR_WPD);
> > +}
> > +static DEVICE_ATTR_RO(bioswe);
> > +
> > +static ssize_t biosle_show(struct device *dev, struct device_attribute *attr,
> > +                        char *buf)
> > +{
> > +     return intel_spi_cnl_spi_attr_show(dev, attr, buf, BCR_BLE);
> > +}
> > +static DEVICE_ATTR_RO(biosle);
> > +
> > +static ssize_t smm_bioswp_show(struct device *dev, struct device_attribute *attr,
> > +                            char *buf)
> > +{
> > +     return intel_spi_cnl_spi_attr_show(dev, attr, buf, BCR_SMM_BWP);
> > +}
> > +static DEVICE_ATTR_RO(smm_bioswp);
> > +
> > +static struct attribute *cnl_attrs[] = {
> > +     &dev_attr_bioswe.attr,
> > +     &dev_attr_biosle.attr,
> > +     &dev_attr_smm_bioswp.attr,
> > +     NULL
> > +};
> > +ATTRIBUTE_GROUPS(cnl);
>
> If you are forcing the driver to create the groups, then you are forcing
> us to audit each driver and verify that the files are the same name and
> such.  Put the files in the "common" code please, and if you really need
> a way to get the data out, make that a callback or something.

If I understand you correctly, you are asking the opposite that Arnd
asked me in a
previous patch version: he told me no new callbacks, just use the
device attribute API.
However I'm not sure I understand your proposal, do you mean to let
the device attr
stay in the driver file, and do the group inside the common part? Therefore,
to pass a dev attributes array to the common part?
If not, could you please explain your proposal again?

>
> Also, this name "platform integrity" is really really generic, while in
> reality you are describing something very specific.  Are you sure you
> want that?
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
