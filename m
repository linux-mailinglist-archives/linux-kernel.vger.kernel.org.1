Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6ECB22E43D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jul 2020 05:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgG0DOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jul 2020 23:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbgG0DOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 23:14:00 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9821C0619D5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 20:13:57 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id h19so15543341ljg.13
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 20:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AYtY7Du0SSIBmGOFfAIhObGrFtoQCfrN9p7cr9Hx2EE=;
        b=SGJ595p10ldocrUFdXMnvf+IivoBgRjRAqRx/O3+1J5K5em/gqTC/vk84QVYxDkfVJ
         jX9MYW3DBkQBh5uUSQnFYyGJPElfcJ0kZHm6nNEsGRgtgZd8Wlb1nfR3PPZhu54JsTgM
         a2bNzb8ETDlx9NXTw0JSu4BiKgef5bG/tkoWS1tv5C2TYs2JbLyb/jjiqx9TwqVerAQt
         pHuPjuaHKpiLgnZmQSrr0robfz9UyoIPyIIg6n88HFJmQWLYR2GMtd4ZDAdS0tcLHma8
         lDcwavluHp48w0nAaJ9uemHksRiHN+G9bfdqN+QuLZ7L2EmMFKxecPLGAVPscw2n8PB+
         yYPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AYtY7Du0SSIBmGOFfAIhObGrFtoQCfrN9p7cr9Hx2EE=;
        b=Td9ev9EIO6oxEg/lsrjrAVxrvrnMG1/8aMsjGrzBADJN5CTRyaQV++0mFfzGdY2wHR
         bK5LidtwXfTgAwoGDeTzxK+DMgxp796Mt324gLyjlFJzOWYfoasZ53mgt1yLmW49s1NH
         LHhQVX9xn2y/lY11UpDW6p2CqW3xF9jG5Zgrj9UIuUWmT6mtOK7kf3UsV+3dc3lLmJ1q
         0C5PJ2K7kW7xn2p5ecIdlDZRIq6k/aow7hSAw828Q4mfNdUiAuCjto7I13mXpqzNg28H
         eQjKPI9cJQmP9Sodse+LFDkAs5gQKyzoexObk8MTJT/504J8mHx7Z2gKL8UgfD+hnA3h
         SvHg==
X-Gm-Message-State: AOAM531Jy9EF1I24z/gl3QQDYyd6z9BaIDzeG8M8SPBa33yvHOHpN9zY
        AbW+nfvNJE92llM7Sbzy0bI0p+QSaL+DmUyK+wotKQ==
X-Google-Smtp-Source: ABdhPJzjtxkHRQCOFbkzlTIoLleatG34kzs0z8sUrAYkt2zi0x5dSofrSESRDq4cEut8WAvF0ObtJCx6dIShD+aSofE=
X-Received: by 2002:a05:651c:1106:: with SMTP id d6mr8654740ljo.214.1595819636012;
 Sun, 26 Jul 2020 20:13:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200717084932.3449-1-masahisa.kojima@linaro.org>
 <20200717084932.3449-2-masahisa.kojima@linaro.org> <20200723023634.GI45081@linux.intel.com>
In-Reply-To: <20200723023634.GI45081@linux.intel.com>
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
Date:   Mon, 27 Jul 2020 12:13:44 +0900
Message-ID: <CADQ0-X8wYq97iqoKHAoyTN3qJf_f243e3HEhzjkbNAT-8FEEGQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] tpm: tis: add support for MMIO TPM on SynQuacer
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ardb@kernel.org, devicetree <devicetree@vger.kernel.org>,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

Thank you for your comments.

On Thu, 23 Jul 2020 at 11:36, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Fri, Jul 17, 2020 at 05:49:31PM +0900, Masahisa Kojima wrote:
> > When fitted, the SynQuacer platform exposes its SPI TPM via a MMIO
> > window that is backed by the SPI command sequencer in the SPI bus
> > controller. This arrangement has the limitation that only byte size
> > accesses are supported, and so we'll need to provide a separate module
> > that take this into account.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> > ---
> >  drivers/char/tpm/Kconfig             |  12 ++
> >  drivers/char/tpm/Makefile            |   1 +
> >  drivers/char/tpm/tpm_tis_synquacer.c | 209 +++++++++++++++++++++++++++
> >  3 files changed, 222 insertions(+)
> >  create mode 100644 drivers/char/tpm/tpm_tis_synquacer.c
> >
> > diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> > index 58b4c573d176..a18c314da211 100644
> > --- a/drivers/char/tpm/Kconfig
> > +++ b/drivers/char/tpm/Kconfig
> > @@ -74,6 +74,18 @@ config TCG_TIS_SPI_CR50
> >         If you have a H1 secure module running Cr50 firmware on SPI bus,
> >         say Yes and it will be accessible from within Linux.
> >
> > +config TCG_TIS_SYNQUACER
> > +     tristate "TPM Interface Specification 1.2 Interface / TPM 2.0 FIFO Interface (MMIO - SynQuacer)"
> > +     depends on ARCH_SYNQUACER
> > +     select TCG_TIS_CORE
> > +     help
> > +       If you have a TPM security chip that is compliant with the
> > +       TCG TIS 1.2 TPM specification (TPM1.2) or the TCG PTP FIFO
> > +       specification (TPM2.0) say Yes and it will be accessible from
> > +       within Linux on Socionext SynQuacer platform.
> > +       To compile this driver as a module, choose  M here;
> > +       the module will be called tpm_tis_synquacer.
> > +
> >  config TCG_TIS_I2C_ATMEL
> >       tristate "TPM Interface Specification 1.2 Interface (I2C - Atmel)"
> >       depends on I2C
> > diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
> > index 9567e5197f74..84db4fb3a9c9 100644
> > --- a/drivers/char/tpm/Makefile
> > +++ b/drivers/char/tpm/Makefile
> > @@ -21,6 +21,7 @@ tpm-$(CONFIG_EFI) += eventlog/efi.o
> >  tpm-$(CONFIG_OF) += eventlog/of.o
> >  obj-$(CONFIG_TCG_TIS_CORE) += tpm_tis_core.o
> >  obj-$(CONFIG_TCG_TIS) += tpm_tis.o
> > +obj-$(CONFIG_TCG_TIS_SYNQUACER) += tpm_tis_synquacer.o
> >
> >  obj-$(CONFIG_TCG_TIS_SPI) += tpm_tis_spi.o
> >  tpm_tis_spi-y := tpm_tis_spi_main.o
> > diff --git a/drivers/char/tpm/tpm_tis_synquacer.c b/drivers/char/tpm/tpm_tis_synquacer.c
> > new file mode 100644
> > index 000000000000..ac2a1d2a5001
> > --- /dev/null
> > +++ b/drivers/char/tpm/tpm_tis_synquacer.c
> > @@ -0,0 +1,209 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2020 Linaro Ltd.
> > + *
> > + * This device driver implements MMIO TPM on SynQuacer Platform.
> > + */
> > +#include <linux/acpi.h>
> > +#include <linux/init.h>
> > +#include <linux/module.h>
> > +#include <linux/slab.h>
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> > +#include <linux/kernel.h>
> > +#include "tpm.h"
> > +#include "tpm_tis_core.h"
> > +
> > +struct tpm_tis_synquacer_info {
> > +     struct resource res;
> > +     /* irq > 0 means: use irq $irq;
> > +      * irq = 0 means: autoprobe for an irq;
> > +      * irq = -1 means: no irq support
> > +      */
> > +     int irq;
> > +};
>
> According to the coding style, multi-line comments must begin with an
> empty line.
>
> Also it would be preferable to have the comment prepending the struct
> for easier read:
>
> /*
>  * irq > 0 means: use irq $irq;
>  * irq = 0 means: autoprobe for an irq;
>  * irq = -1 means: no irq support
>  */
> struct tpm_tis_synquacer_info {

I will modify.

>
> > +
> > +struct tpm_tis_synquacer_phy {
> > +     struct tpm_tis_data priv;
> > +     void __iomem *iobase;
> > +};
> > +
> > +static inline struct tpm_tis_synquacer_phy *to_tpm_tis_tcg_phy(struct tpm_tis_data *data)
> > +{
> > +     return container_of(data, struct tpm_tis_synquacer_phy, priv);
> > +}
> > +
> > +static int tpm_tis_synquacer_read_bytes(struct tpm_tis_data *data, u32 addr,
> > +                                     u16 len, u8 *result)
> > +{
> > +     struct tpm_tis_synquacer_phy *phy = to_tpm_tis_tcg_phy(data);
> > +
> > +     while (len--)
> > +             *result++ = ioread8(phy->iobase + addr);
> > +
> > +     return 0;
> > +}
> > +
> > +static int tpm_tis_synquacer_write_bytes(struct tpm_tis_data *data, u32 addr,
> > +                                      u16 len, const u8 *value)
> > +{
> > +     struct tpm_tis_synquacer_phy *phy = to_tpm_tis_tcg_phy(data);
> > +
> > +     while (len--)
> > +             iowrite8(*value++, phy->iobase + addr);
> > +
> > +     return 0;
> > +}
> > +
> > +static int tpm_tis_synquacer_read16_bw(struct tpm_tis_data *data,
> > +                                    u32 addr, u16 *result)
> > +{
> > +     struct tpm_tis_synquacer_phy *phy = to_tpm_tis_tcg_phy(data);
> > +
> > +     /*
> > +      * Due to the limitation of SPI controller on SynQuacer,
> > +      * 16/32 bits access must be done in byte-wise and descending order.
> > +      */
> > +     *result = (ioread8(phy->iobase + addr + 1) << 8) |
> > +               (ioread8(phy->iobase + addr));
> > +
> > +     return 0;
> > +}
> > +
> > +static int tpm_tis_synquacer_read32_bw(struct tpm_tis_data *data,
> > +                                    u32 addr, u32 *result)
> > +{
> > +     struct tpm_tis_synquacer_phy *phy = to_tpm_tis_tcg_phy(data);
> > +
> > +     /*
> > +      * Due to the limitation of SPI controller on SynQuacer,
> > +      * 16/32 bits access must be done in byte-wise and descending order.
> > +      */
> > +     *result = (ioread8(phy->iobase + addr + 3) << 24) |
> > +               (ioread8(phy->iobase + addr + 2) << 16) |
> > +               (ioread8(phy->iobase + addr + 1) << 8) |
> > +               (ioread8(phy->iobase + addr));
> > +
> > +     return 0;
> > +}
> > +
> > +static int tpm_tis_synquacer_write32_bw(struct tpm_tis_data *data,
> > +                                     u32 addr, u32 value)
> > +{
> > +     struct tpm_tis_synquacer_phy *phy = to_tpm_tis_tcg_phy(data);
> > +
> > +     /*
> > +      * Due to the limitation of SPI controller on SynQuacer,
> > +      * 16/32 bits access must be done in byte-wise and descending order.
> > +      */
> > +     iowrite8(value >> 24, phy->iobase + addr + 3);
> > +     iowrite8(value >> 16, phy->iobase + addr + 2);
> > +     iowrite8(value >> 8, phy->iobase + addr + 1);
> > +     iowrite8(value, phy->iobase + addr);
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct tpm_tis_phy_ops tpm_tcg_bw = {
> > +     .read_bytes     = tpm_tis_synquacer_read_bytes,
> > +     .write_bytes    = tpm_tis_synquacer_write_bytes,
> > +     .read16         = tpm_tis_synquacer_read16_bw,
> > +     .read32         = tpm_tis_synquacer_read32_bw,
> > +     .write32        = tpm_tis_synquacer_write32_bw,
> > +};
> > +
> > +static int tpm_tis_synquacer_init(struct device *dev,
> > +                               struct tpm_tis_synquacer_info *tpm_info)
> > +{
> > +     struct tpm_tis_synquacer_phy *phy;
> > +
> > +     phy = devm_kzalloc(dev, sizeof(struct tpm_tis_synquacer_phy), GFP_KERNEL);
> > +     if (phy == NULL)
> > +             return -ENOMEM;
> > +
> > +     phy->iobase = devm_ioremap_resource(dev, &tpm_info->res);
> > +     if (IS_ERR(phy->iobase))
> > +             return PTR_ERR(phy->iobase);
> > +
> > +     return tpm_tis_core_init(dev, &phy->priv, tpm_info->irq, &tpm_tcg_bw,
> > +                              ACPI_HANDLE(dev));
> > +}
> > +
> > +static SIMPLE_DEV_PM_OPS(tpm_tis_synquacer_pm, tpm_pm_suspend, tpm_tis_resume);
> > +
> > +static int tpm_tis_synquacer_probe(struct platform_device *pdev)
> > +{
> > +     struct tpm_tis_synquacer_info tpm_info = {};
> > +     struct resource *res;
> > +
> > +     res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +     if (res == NULL) {
> > +             dev_err(&pdev->dev, "no memory resource defined\n");
> > +             return -ENODEV;
> > +     }
> > +     tpm_info.res = *res;
> > +
> > +     tpm_info.irq = -1;
> > +
> > +     return tpm_tis_synquacer_init(&pdev->dev, &tpm_info);
> > +}
> > +
> > +static int tpm_tis_synquacer_remove(struct platform_device *pdev)
> > +{
> > +     struct tpm_chip *chip = dev_get_drvdata(&pdev->dev);
> > +
> > +     tpm_chip_unregister(chip);
> > +     tpm_tis_remove(chip);
> > +
> > +     return 0;
> > +}
> > +
> > +#ifdef CONFIG_OF
> > +static const struct of_device_id tis_synquacer_of_platform_match[] = {
> > +     {.compatible = "socionext,synquacer-tpm-mmio"},
> > +     {},
> > +};
> > +MODULE_DEVICE_TABLE(of, tis_synquacer_of_platform_match);
> > +#endif
> > +
> > +#ifdef CONFIG_ACPI
> > +static const struct acpi_device_id tpm_synquacer_acpi_tbl[] = {
> > +     { "SCX0009" },
> > +     {},
> > +};
> > +MODULE_DEVICE_TABLE(acpi, tpm_synquacer_acpi_tbl);
> > +#endif
> > +
> > +static struct platform_driver tis_synquacer_drv = {
> > +     .probe = tpm_tis_synquacer_probe,
> > +     .remove = tpm_tis_synquacer_remove,
> > +     .driver = {
> > +             .name           = "tpm_tis_synquacer",
> > +             .pm             = &tpm_tis_synquacer_pm,
> > +             .of_match_table = of_match_ptr(tis_synquacer_of_platform_match),
> > +             .acpi_match_table = ACPI_PTR(tpm_synquacer_acpi_tbl),
> > +     },
> > +};
> > +
> > +static int __init tpm_tis_synquacer_module_init(void)
> > +{
> > +     int rc;
> > +
> > +     rc = platform_driver_register(&tis_synquacer_drv);
> > +     if (rc)
> > +             return rc;
> > +
> > +     return 0;
> > +}
> > +
> > +static void __exit tpm_tis_synquacer_module_exit(void)
> > +{
> > +     platform_driver_unregister(&tis_synquacer_drv);
> > +}
> > +
> > +module_init(tpm_tis_synquacer_module_init);
> > +module_exit(tpm_tis_synquacer_module_exit);
> > +MODULE_AUTHOR("Masahisa Kojima (masahisa.kojima@linaro.org)");
>
> It is completely redundant field because authorship is part of the
> commit object itself. And it does not tell the truth after a while
> anyway. MODULE_AUTHOR() made more sense before there was any sort of
> legit versio control in place.
>
> I think it would be better not to have it as we don't have any use
> for this data. It is just cruft hanging there.

OK, I will remove MODULE_AUTHOR() line.
I will also plan to remove MODULE_VERSION("2.0").
tpm_tis_spi_main.c only has MODULE_DESCRIPTION() and MODULE_LICENSE(),
I plan to follow this example.

Regards,
Masahisa

>
> > +MODULE_DESCRIPTION("TPM MMIO Driver for Socionext SynQuacer platform");
> > +MODULE_VERSION("2.0");
> > +MODULE_LICENSE("GPL");
> > --
> > 2.20.1
> >
>
> /Jarkko
