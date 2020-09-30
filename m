Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29AF127E33C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 10:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbgI3IDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 04:03:35 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:47492 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728367AbgI3IDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 04:03:34 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08U83Mjc007039;
        Wed, 30 Sep 2020 03:03:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601453002;
        bh=TURRr3OYeVMlDnx4zpyv8iXB01n2XSC3osa95n3/QHU=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=W4ta0/Hu0YjOYM7k7PyeWgcqO6DWV+GDnWC9uLyEK3sS4F1oFvo1zDOvHvZEBL7it
         PHPWRCKCx1kz/RyN9/nilOOG2+xho0OB8YLkt6zIzzP7V+m0K1B6NlSSy9VnccDu/t
         FobHBe49TgPCvIoj+/+KelexPYJE0qk9hcfz82YA=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08U83LTi062209
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Sep 2020 03:03:21 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 30
 Sep 2020 03:03:21 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 30 Sep 2020 03:03:21 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08U83KLX034362;
        Wed, 30 Sep 2020 03:03:20 -0500
Date:   Wed, 30 Sep 2020 13:33:19 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     <Tudor.Ambarus@microchip.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nsekhar@ti.com>, <boris.brezillon@collabora.com>
Subject: Re: [PATCH v13 13/15] mtd: spi-nor: core: expose
 spi_nor_default_setup() in core.h
Message-ID: <20200930080317.hy2h6hlkbaxqea3f@ti.com>
References: <20200916124418.833-1-p.yadav@ti.com>
 <20200916124418.833-14-p.yadav@ti.com>
 <ef62bf4e-1b2c-aa3e-39b7-fd8d118e582d@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ef62bf4e-1b2c-aa3e-39b7-fd8d118e582d@microchip.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/09/20 07:51AM, Tudor.Ambarus@microchip.com wrote:
> On 9/16/20 3:44 PM, Pratyush Yadav wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > Flashes might want to add a custom setup hook to configure the flash in
> > the proper mode for operation. But after that, they would still want to
> > run the default setup hook because it selects the read, program, and
> > erase operations. Since there is little point in repeating all that
> > code, expose the spi_nor_default_setup() in core.h to
> > manufacturer-specific files.
> 
> But you don't use it in the following patches. Can we drop this one for now?

I used it for earlier versions but not for the latest ones. This can be 
dropped for now.

> > 
> > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> > ---
> >  drivers/mtd/spi-nor/core.c | 4 ++--
> >  drivers/mtd/spi-nor/core.h | 3 +++
> >  2 files changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> > index d5c92c9c7307..34edfcf33172 100644
> > --- a/drivers/mtd/spi-nor/core.c
> > +++ b/drivers/mtd/spi-nor/core.c
> > @@ -2759,8 +2759,8 @@ static int spi_nor_select_erase(struct spi_nor *nor)
> >         return 0;
> >  }
> > 
> > -static int spi_nor_default_setup(struct spi_nor *nor,
> > -                                const struct spi_nor_hwcaps *hwcaps)
> > +int spi_nor_default_setup(struct spi_nor *nor,
> > +                         const struct spi_nor_hwcaps *hwcaps)
> >  {
> >         struct spi_nor_flash_parameter *params = nor->params;
> >         u32 ignored_mask, shared_mask;
> > diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
> > index e2c7324d997e..10dc03506f93 100644
> > --- a/drivers/mtd/spi-nor/core.h
> > +++ b/drivers/mtd/spi-nor/core.h
> > @@ -453,6 +453,9 @@ int spi_nor_post_bfpt_fixups(struct spi_nor *nor,
> >                              const struct sfdp_bfpt *bfpt,
> >                              struct spi_nor_flash_parameter *params);
> > 
> > +int spi_nor_default_setup(struct spi_nor *nor,
> > +                         const struct spi_nor_hwcaps *hwcaps);
> > +
> >  static struct spi_nor __maybe_unused *mtd_to_spi_nor(struct mtd_info *mtd)
> >  {
> >         return mtd->priv;
> > --
> > 2.28.0
> > 
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments India
