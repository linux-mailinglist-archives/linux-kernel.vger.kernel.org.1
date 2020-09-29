Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 684B827CE1C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 14:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbgI2Mv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 08:51:58 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:53764 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728447AbgI2Mv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 08:51:56 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08TCpZaM007685;
        Tue, 29 Sep 2020 07:51:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601383895;
        bh=hiA4CemB1Q1XHmbfcV4K/ZoN/+gJe0fRHuHo1omg+Iw=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=nldLH60DOVEXZTiyicdZzJO6aT3Dsh/lAA03+Dj91M60YCpEwZFmzq/14lMT9w/N2
         8LPdf0X3fdHt+UNdsVH7HqUCEzcXBEG84U0hKM1BVBr4ugnZft2qy1qASbi+7PwlBv
         7IohsaMfhB8PPWeTAQi37+VB6mWJ16v5SmkjH2yY=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08TCpZUQ074329
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 29 Sep 2020 07:51:35 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 29
 Sep 2020 07:51:34 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 29 Sep 2020 07:51:34 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08TCpXqV018648;
        Tue, 29 Sep 2020 07:51:34 -0500
Date:   Tue, 29 Sep 2020 18:21:33 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     <Tudor.Ambarus@microchip.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nsekhar@ti.com>, <boris.brezillon@collabora.com>
Subject: Re: [PATCH v13 09/15] mtd: spi-nor: core: enable octal DTR mode when
 possible
Message-ID: <20200929125131.fmztz4rr2iuj6uof@ti.com>
References: <20200916124418.833-1-p.yadav@ti.com>
 <20200916124418.833-10-p.yadav@ti.com>
 <feb046fd-a9ea-9ea3-55f7-bf823ed1e61f@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <feb046fd-a9ea-9ea3-55f7-bf823ed1e61f@microchip.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/09/20 11:26AM, Tudor.Ambarus@microchip.com wrote:
> Hi,
> 
> On 9/16/20 3:44 PM, Pratyush Yadav wrote:
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
> > index 87c568debf14..6ee93544d72f 100644
> > --- a/drivers/mtd/spi-nor/core.c
> > +++ b/drivers/mtd/spi-nor/core.c
> > @@ -3069,6 +3069,35 @@ static int spi_nor_init_params(struct spi_nor *nor)
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
> >   * spi_nor_quad_enable() - enable/disable Quad I/O if needed.
> >   * @nor:                pointer to a 'struct spi_nor'
> > @@ -3109,6 +3138,12 @@ static int spi_nor_init(struct spi_nor *nor)
> >  {
> >         int err;
> > 
> > +       err = spi_nor_octal_dtr_enable(nor, true);
> > +       if (err) {
> > +               dev_dbg(nor->dev, "octal mode not supported\n");
> > +               return err;
> > +       }
> > +
> >         err = spi_nor_quad_enable(nor, true);
> 
> Is it possible to enable octal dtr and quad at the same time?
> Maybe an 'if/else if' here depending on the values of nor->read_proto and
> nor->write_proto

No it is not. If you look inside spi_nor_octal_dtr_enable() and 
spi_nor_quad_enable(), they both are a no-op if the protocol does not 
match. spi_nor_quad_enable() was already doing it this way so I made 
spi_nor_octal_dtr_enable() follow suit. So this is effectively an 
if-else on the value of nor->read_proto. I don't think an explicit one 
is needed.

-- 
Regards,
Pratyush Yadav
Texas Instruments India
