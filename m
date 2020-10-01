Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA5427FA9E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 09:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731106AbgJAHu3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 1 Oct 2020 03:50:29 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:40701 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgJAHuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 03:50:18 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 8C3872000C;
        Thu,  1 Oct 2020 07:50:14 +0000 (UTC)
Date:   Thu, 1 Oct 2020 09:50:12 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     <Tudor.Ambarus@microchip.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nsekhar@ti.com>, <boris.brezillon@collabora.com>
Subject: Re: [PATCH v14 01/15] mtd: spi-nor: core: use EOPNOTSUPP instead of
 ENOTSUPP
Message-ID: <20201001095012.5c331bf8@xps13>
In-Reply-To: <20201001073425.txsfdngrsugsy6uf@ti.com>
References: <20200930185732.6201-1-p.yadav@ti.com>
        <20200930185732.6201-2-p.yadav@ti.com>
        <5340adf5-1bb2-1eff-3812-6976b3b76faf@microchip.com>
        <20201001073425.txsfdngrsugsy6uf@ti.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Pratyush Yadav <p.yadav@ti.com> wrote on Thu, 1 Oct 2020 13:04:27 +0530:

> On 01/10/20 07:19AM, Tudor.Ambarus@microchip.com wrote:
> > On 9/30/20 9:57 PM, Pratyush Yadav wrote:  
> > > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe

It seems that your mailer/server introduced that line automatically,
can you do something to avoid it?

> > > 
> > > ENOTSUPP is not a SUSV4 error code. Using EOPNOTSUPP is preferred
> > > in its stead.

I ran into this checkpatch.pl error recently, I count 80+ iterations in
drivers/mtd/ so perhaps having a subsystem wide replacement will be
nice. I'm fine with this patch though as it is addressing all SPI-NOR
cases already.

Cheers,
Miquèl

> > > 
> > > Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>  
> > 
> > The R-b tag should be after your S-o-b. This applies to other
> > patches in the series too. No need to resubmit, it can be fixed when
> > applying.  
> 
> If we're using chronological order then I first added your Reviewed-by, 
> and then signed off before resending the patches. So that way s-o-b 
> comes after r-b.
> 
> Anyway, it doesn't really matter. Use whichever order you prefer.
>  
> > > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> > > ---
> > >  drivers/mtd/spi-nor/core.c | 10 +++++-----
> > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> > > index 0369d98b2d12..4d0f8d165544 100644
> > > --- a/drivers/mtd/spi-nor/core.c
> > > +++ b/drivers/mtd/spi-nor/core.c
> > > @@ -2281,7 +2281,7 @@ static int spi_nor_hwcaps_pp2cmd(u32 hwcaps)
> > >   *@nor:        pointer to a 'struct spi_nor'
> > >   *@op:         pointer to op template to be checked
> > >   *
> > > - * Returns 0 if operation is supported, -ENOTSUPP otherwise.
> > > + * Returns 0 if operation is supported, -EOPNOTSUPP otherwise.
> > >   */
> > >  static int spi_nor_spimem_check_op(struct spi_nor *nor,
> > >                                    struct spi_mem_op *op)
> > > @@ -2295,12 +2295,12 @@ static int spi_nor_spimem_check_op(struct spi_nor *nor,
> > >         op->addr.nbytes = 4;
> > >         if (!spi_mem_supports_op(nor->spimem, op)) {
> > >                 if (nor->mtd.size > SZ_16M)
> > > -                       return -ENOTSUPP;
> > > +                       return -EOPNOTSUPP;
> > > 
> > >                 /* If flash size <= 16MB, 3 address bytes are sufficient */
> > >                 op->addr.nbytes = 3;
> > >                 if (!spi_mem_supports_op(nor->spimem, op))
> > > -                       return -ENOTSUPP;
> > > +                       return -EOPNOTSUPP;
> > >         }
> > > 
> > >         return 0;
> > > @@ -2312,7 +2312,7 @@ static int spi_nor_spimem_check_op(struct spi_nor *nor,
> > >   *@nor:         pointer to a 'struct spi_nor'
> > >   *@read:        pointer to op template to be checked
> > >   *
> > > - * Returns 0 if operation is supported, -ENOTSUPP otherwise.
> > > + * Returns 0 if operation is supported, -EOPNOTSUPP otherwise.
> > >   */
> > >  static int spi_nor_spimem_check_readop(struct spi_nor *nor,
> > >                                        const struct spi_nor_read_command *read)
> > > @@ -2338,7 +2338,7 @@ static int spi_nor_spimem_check_readop(struct spi_nor *nor,
> > >   *@nor:         pointer to a 'struct spi_nor'
> > >   *@pp:          pointer to op template to be checked
> > >   *
> > > - * Returns 0 if operation is supported, -ENOTSUPP otherwise.
> > > + * Returns 0 if operation is supported, -EOPNOTSUPP otherwise.
> > >   */
> > >  static int spi_nor_spimem_check_pp(struct spi_nor *nor,
> > >                                    const struct spi_nor_pp_command *pp)
> > > --
> > > 2.28.0
> > >   
> >   
> 




Thanks,
Miquèl
