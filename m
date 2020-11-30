Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B76652C84E2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 14:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbgK3NPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 08:15:53 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:34150 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgK3NPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 08:15:48 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AUDDrqr083502;
        Mon, 30 Nov 2020 07:13:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1606742033;
        bh=ZMa7CqsWs8Y1MDXPkyCW/iCcme+i36HSODQwwL5Sy1U=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=u2RCJkWeoVqW5E56guTFni9BdpbnN9arVSBMfgEg8K6DdNwzNZmhALND+NMvZE18k
         BfVLvWnOsatGgQJYj/zg/8N0VSSBLnWIzLbJCIZyl5Aexd1CUMLAe9+KLSFLLS+ooQ
         0GOehTkS6O5I4i0QvYpzg/803eNmr6s1thziJlRo=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AUDDrYp046597
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 30 Nov 2020 07:13:53 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 30
 Nov 2020 07:13:53 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 30 Nov 2020 07:13:53 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AUDDq4q044478;
        Mon, 30 Nov 2020 07:13:53 -0600
Date:   Mon, 30 Nov 2020 18:43:52 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     <Tudor.Ambarus@microchip.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] mtd: spi-nor: core: Allow flashes to specify MTD
 writesize
Message-ID: <20201130131350.spqvde2al4ajf4fz@ti.com>
References: <20201118182459.18197-1-p.yadav@ti.com>
 <20201118182459.18197-3-p.yadav@ti.com>
 <939dcad9-b556-ea3e-9eca-c008a86fd01b@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <939dcad9-b556-ea3e-9eca-c008a86fd01b@microchip.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/11/20 10:59AM, Tudor.Ambarus@microchip.com wrote:
> On 11/18/20 8:24 PM, Pratyush Yadav wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > Some flashes like the Cypress S28 family use ECC. Under this ECC scheme,
> > multi-pass writes to an ECC block is not allowed. In other words, once
> > data is programmed to an ECC block, it can't be programmed again without
> > erasing it first.
> > 
> > Upper layers like file systems need to be given this information so they
> > do not cause error conditions on the flash by attempting multi-pass
> > programming. This can be done by setting 'writesize' in 'struct
> > mtd_info'.
> > 
> > Set the default to 1 but allow flashes to modify it in fixup hooks. If
> > more flashes show up with this constraint in the future it might be
> > worth it to add it to 'struct flash_info', but for now increasing its
> > size is not worth it.
> > 
> > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> > ---
> > 
> > Notes:
> >     New in v2.
> > 
> >  drivers/mtd/spi-nor/core.c | 4 +++-
> >  drivers/mtd/spi-nor/core.h | 3 +++
> >  2 files changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> > index 5bee7c8da4dc..80fbcb9c0828 100644
> > --- a/drivers/mtd/spi-nor/core.c
> > +++ b/drivers/mtd/spi-nor/core.c
> > @@ -3054,6 +3054,8 @@ static int spi_nor_init_params(struct spi_nor *nor)
> >         if (!nor->params)
> >                 return -ENOMEM;
> > 
> > +       nor->params->writesize = 1;
> > +
> 
> please do default inits in spi_nor_info_init_params(). A good place would be:
> 
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -2885,6 +2885,7 @@ static void spi_nor_info_init_params(struct spi_nor *nor)
>         nor->flags |= SNOR_F_HAS_16BIT_SR;
>  
>         /* Set SPI NOR sizes. */
> +       params->writesize = 1;
>         params->size = (u64)info->sector_size * info->n_sectors;
>         params->page_size = info->page_size;

Ok.
 
> 
> >         spi_nor_info_init_params(nor);
> > 
> >         spi_nor_manufacturer_init_params(nor);
> > @@ -3430,7 +3432,7 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
> >                 mtd->name = dev_name(dev);
> >         mtd->priv = nor;
> >         mtd->type = MTD_NORFLASH;
> > -       mtd->writesize = 1;
> > +       mtd->writesize = nor->params->writesize;
> >         mtd->flags = MTD_CAP_NORFLASH;
> >         mtd->size = nor->params->size;
> >         mtd->_erase = spi_nor_erase;
> > diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
> > index 0a775a7b5606..413ea311e632 100644
> > --- a/drivers/mtd/spi-nor/core.h
> > +++ b/drivers/mtd/spi-nor/core.h
> > @@ -197,6 +197,8 @@ struct spi_nor_locking_ops {
> >   * @rdsr_dummy:                dummy cycles needed for Read Status Register command.
> >   * @rdsr_addr_nbytes:  dummy address bytes needed for Read Status Register
> >   *                     command.
> > + * @writesize          Minimal writable flash unit size. Defaults to 1. Set to
> > + *                     ECC unit size for ECC-ed flashes.
> >   * @hwcaps:            describes the read and page program hardware
> >   *                     capabilities.
> >   * @reads:             read capabilities ordered by priority: the higher index
> > @@ -222,6 +224,7 @@ struct spi_nor_flash_parameter {
> >         u32                             page_size;
> 
> I would put writesize before or after page_size, because they are related.
> Also, it would probably avoid padding.

Ok.
 
> With these addressed, one can add:
> 
> Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Thanks.
 
> >         u8                              rdsr_dummy;
> >         u8                              rdsr_addr_nbytes;
> > +       u32                             writesize;
> > 
> >         struct spi_nor_hwcaps           hwcaps;
> >         struct spi_nor_read_command     reads[SNOR_CMD_READ_MAX];
> > --
> > 2.28.0
> > 
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments India
