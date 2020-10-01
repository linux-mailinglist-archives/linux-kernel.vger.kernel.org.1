Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC53027FBBB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 10:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731626AbgJAImW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 04:42:22 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:47560 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730902AbgJAImW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 04:42:22 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0918gAlJ021630;
        Thu, 1 Oct 2020 03:42:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601541730;
        bh=l9E4iTEIYD2L6+jDXJU9JrWEdUYoAxixqNC6l8k2lmI=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=WmMhcXxCmTEMe5l5Y5vbnXG91qSCEZoHf/sYK4N5bZ/GFvj1uGosuUGy2ELeZInqu
         I0ARLMn5TsLf7yuZLCYxFUqahPy/mu2t6nQLydA/cmTJqe03N8e3t3Xc3G5TVjkx03
         N4b+mDMUqLALzHZYN75IKuf7di29Bci6x74Z8nT0=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0918gALN005822
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Oct 2020 03:42:10 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 1 Oct
 2020 03:42:10 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 1 Oct 2020 03:42:10 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0918g9sl030651;
        Thu, 1 Oct 2020 03:42:09 -0500
Date:   Thu, 1 Oct 2020 14:12:08 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     <Tudor.Ambarus@microchip.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nsekhar@ti.com>, <boris.brezillon@collabora.com>
Subject: Re: [PATCH v14 08/15] mtd: spi-nor: core: enable octal DTR mode when
 possible
Message-ID: <20201001084206.ma4beblucowmtwgq@ti.com>
References: <20200930185732.6201-1-p.yadav@ti.com>
 <20200930185732.6201-9-p.yadav@ti.com>
 <3e162719-80c7-03dc-dc2a-29a46bc4cb2c@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3e162719-80c7-03dc-dc2a-29a46bc4cb2c@microchip.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/10/20 08:09AM, Tudor.Ambarus@microchip.com wrote:
> On 9/30/20 9:57 PM, Pratyush Yadav wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > Allow flashes to specify a hook to enable octal DTR mode. Use this hook
> > whenever possible to get optimal transfer speeds.
> > 
> > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> > ---
> >  drivers/mtd/spi-nor/core.c | 35 +++++++++++++++++++++++++++++++++++
> >  drivers/mtd/spi-nor/core.h |  2 ++
> >  2 files changed, 37 insertions(+)
> > 
> > diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> > index 73a26e7e32c2..6b54a923002a 100644
> > --- a/drivers/mtd/spi-nor/core.c
> > +++ b/drivers/mtd/spi-nor/core.c
> > @@ -3068,6 +3068,35 @@ static int spi_nor_init_params(struct spi_nor *nor)
> >         return 0;
> >  }
> > 
> > +/** spi_nor_octal_dtr_enable() - enable Octal DTR I/O if needed
> > + * @nor:                 pointer to a 'struct spi_nor'
> > + * @enable:              whether to enable or disable Octal DTR
> > + *
> > + * Return: 0 on success, -errno otherwise.
> > + */
> > +static int spi_nor_octal_dtr_enable(struct spi_nor *nor, bool enable)
> > +{
> > +       int ret;
> > +
> > +       if (!nor->params->octal_dtr_enable)
> > +               return 0;
> > +
> > +       if (!(nor->read_proto == SNOR_PROTO_8_8_8_DTR &&
> > +             nor->write_proto == SNOR_PROTO_8_8_8_DTR))
> > +               return 0;
> > +
> > +       ret = nor->params->octal_dtr_enable(nor, enable);
> 
> Ideally patch 9/15 and 10/15 should have been before 8/15. We should deny
> the access to octal dtr enable for NV flashes since moment 0.

Ok. I'll re-order them.
 
> > +       if (ret)
> > +               return ret;
> > +
> > +       if (enable)
> > +               nor->reg_proto = SNOR_PROTO_8_8_8_DTR;
> > +       else
> > +               nor->reg_proto = SNOR_PROTO_1_1_1;
> > +
> > +       return 0;
> > +}
> > +
> >  /**
> >   * spi_nor_quad_enable() - enable Quad I/O if needed.
> >   * @nor:                pointer to a 'struct spi_nor'
> > @@ -3107,6 +3136,12 @@ static int spi_nor_init(struct spi_nor *nor)
> >  {
> >         int err;
> > 
> > +       err = spi_nor_octal_dtr_enable(nor, true);
> > +       if (err) {
> > +               dev_dbg(nor->dev, "octal mode not supported\n");
> > +               return err;
> > +       }
> > +
> >         err = spi_nor_quad_enable(nor);
> >         if (err) {
> >                 dev_dbg(nor->dev, "quad mode not supported\n");
> > diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
> > index 9a33c8d07335..5cfe2db9ee13 100644
> > --- a/drivers/mtd/spi-nor/core.h
> > +++ b/drivers/mtd/spi-nor/core.h
> > @@ -203,6 +203,7 @@ struct spi_nor_locking_ops {
> >   *                      higher index in the array, the higher priority.
> >   * @erase_map:         the erase map parsed from the SFDP Sector Map Parameter
> >   *                      Table.
> > + * @octal_dtr_enable:  enables SPI NOR octal DTR mode.
> >   * @quad_enable:       enables SPI NOR quad mode.
> >   * @set_4byte_addr_mode: puts the SPI NOR in 4 byte addressing mode.
> >   * @convert_addr:      converts an absolute address into something the flash
> > @@ -226,6 +227,7 @@ struct spi_nor_flash_parameter {
> > 
> >         struct spi_nor_erase_map        erase_map;
> > 
> > +       int (*octal_dtr_enable)(struct spi_nor *nor, bool enable);
> >         int (*quad_enable)(struct spi_nor *nor);
> >         int (*set_4byte_addr_mode)(struct spi_nor *nor, bool enable);
> >         u32 (*convert_addr)(struct spi_nor *nor, u32 addr);
> > --
> > 2.28.0
> > 
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments India
