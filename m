Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E03D027E2D7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 09:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbgI3HpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 03:45:05 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42970 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgI3HpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 03:45:05 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08U7is5E129606;
        Wed, 30 Sep 2020 02:44:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601451894;
        bh=YQoym++Sx485ijHB6h7Qf7noUsG0wxw/BtlAQa7xaZI=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=WAgaX7zyEUTrUm190dhZFg4fgSdm9GuQ96HDPiY56QqH+UyZc9PRfvGZ3L7UEHTsp
         EMy68wGwmlocNUZcCGAqsMAmuCBG9lEK5BnY/ezd86vDDkYjFoRf1Czi5RQNbm9SoV
         Ooj4pXbxjdvwEJWlC4zYpKkUaD2w6w3gMEjNo1I0=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08U7isfW092457
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Sep 2020 02:44:54 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 30
 Sep 2020 02:44:54 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 30 Sep 2020 02:44:54 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08U7irPY078049;
        Wed, 30 Sep 2020 02:44:54 -0500
Date:   Wed, 30 Sep 2020 13:14:53 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     <Tudor.Ambarus@microchip.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nsekhar@ti.com>, <boris.brezillon@collabora.com>
Subject: Re: [PATCH v13 12/15] mtd: spi-nor: core: disable Octal DTR mode on
 suspend.
Message-ID: <20200930074451.exudmq4p7isdwhwd@ti.com>
References: <20200916124418.833-1-p.yadav@ti.com>
 <20200916124418.833-13-p.yadav@ti.com>
 <83e9675b-e60b-6fe4-619d-9e81b26632ec@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <83e9675b-e60b-6fe4-619d-9e81b26632ec@microchip.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/09/20 07:40AM, Tudor.Ambarus@microchip.com wrote:
> On 9/16/20 3:44 PM, Pratyush Yadav wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > On resume, the init procedure will be run that will re-enable it.
> > 
> > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> 
> > ---
> >  drivers/mtd/spi-nor/core.c | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> > 
> > diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> > index 853dfa02f0de..d5c92c9c7307 100644
> > --- a/drivers/mtd/spi-nor/core.c
> > +++ b/drivers/mtd/spi-nor/core.c
> > @@ -3212,6 +3212,23 @@ static void spi_nor_soft_reset(struct spi_nor *nor)
> >         usleep_range(SPI_NOR_SRST_SLEEP_MIN, SPI_NOR_SRST_SLEEP_MAX);
> >  }
> > 
> > +/* mtd suspend handler */
> > +static int spi_nor_suspend(struct mtd_info *mtd)
> > +{
> > +       struct spi_nor *nor = mtd_to_spi_nor(mtd);
> > +       struct device *dev = nor->dev;
> > +       int ret;
> > +
> > +       /* Disable octal DTR mode if we enabled it. */
> > +       ret = spi_nor_octal_dtr_enable(nor, false);
> > +       if (ret) {
> > +               dev_err(dev, "suspend() failed\n");
> 
> we can get rid of dev local variable as it is used only once. you can use
> nor->dev directly

Ok.
 
> > +               return ret;
> > +       }
> 
> and maybe just return ret; directly. spi_nor_octal_dtr_enable() returns 0 on
> success.

Ok.
 
> Looks good.
>  

-- 
Regards,
Pratyush Yadav
Texas Instruments India
