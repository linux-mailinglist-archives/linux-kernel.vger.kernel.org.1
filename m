Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2E5C27B05D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 16:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgI1Oze convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 28 Sep 2020 10:55:34 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:59859 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgI1Oze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 10:55:34 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 6B4C520005;
        Mon, 28 Sep 2020 14:55:30 +0000 (UTC)
Date:   Mon, 28 Sep 2020 16:55:28 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Thirumalesha N <nthirumalesha7@gmail.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Shivamurthy Shastri <sshivamurthy@micron.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] mtd: spinand: micron: Generalize the function
 and structure names
Message-ID: <20200928165528.54e5db6e@xps13>
In-Reply-To: <CALKVOUomKLZ5GEHmXb+VfEq8UiNUpCN-Vqkx3N+yykEnCrHkDA@mail.gmail.com>
References: <20200913161533.10655-1-nthirumalesha7@gmail.com>
        <20200913161533.10655-2-nthirumalesha7@gmail.com>
        <20200915101321.1afa5033@xps13>
        <CALKVOUomKLZ5GEHmXb+VfEq8UiNUpCN-Vqkx3N+yykEnCrHkDA@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thirumalesha,

Thirumalesha N <nthirumalesha7@gmail.com> wrote on Sun, 20 Sep 2020
22:38:53 +0800:

> Hi Miquèl,
> 
> I adopted these changes as per the Boris Brezillon comments
> 
> On Tue, Sep 15, 2020 at 4:13 PM Miquel Raynal <miquel.raynal@bootlin.com>
> wrote:
> 
> > Hi Thirumalesha,
> >
> > Thirumalesha Narasimhappa <nthirumalesha7@gmail.com> wrote on Mon, 14
> > Sep 2020 00:15:32 +0800:
> >  
> > > Rename the oob structure and read/write/update function names to
> > > a generic names
> > >
> > > Signed-off-by: Thirumalesha Narasimhappa <nthirumalesha7@gmail.com>
> > > ---
> > >  drivers/mtd/nand/spi/micron.c | 80 +++++++++++++++++------------------
> > >  1 file changed, 40 insertions(+), 40 deletions(-)
> > >
> > > diff --git a/drivers/mtd/nand/spi/micron.c  
> > b/drivers/mtd/nand/spi/micron.c  
> > > index 5d370cfcdaaa..d1b1073d1a55 100644
> > > --- a/drivers/mtd/nand/spi/micron.c
> > > +++ b/drivers/mtd/nand/spi/micron.c
> > > @@ -28,7 +28,7 @@
> > >
> > >  #define MICRON_SELECT_DIE(x) ((x) << 6)
> > >
> > > -static SPINAND_OP_VARIANTS(read_cache_variants,
> > > +static SPINAND_OP_VARIANTS(quadio_read_cache_variants,
> > >               SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 2, NULL, 0),
> > >               SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
> > >               SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 1, NULL, 0),
> > > @@ -36,11 +36,11 @@ static SPINAND_OP_VARIANTS(read_cache_variants,
> > >               SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
> > >               SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
> > >
> > > -static SPINAND_OP_VARIANTS(write_cache_variants,
> > > +static SPINAND_OP_VARIANTS(x4_write_cache_variants,  
> >
> > Why quadio_read and x4_write? I don't get the logic.
> >  
> 
> IMHO, quadio_read is derived from SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP &
> x4_write is derived from SPINAND_PROG_LOAD_X4
> 
> Boris, Please correct me, if my understanding is wrong

I see.

Then please split this change, one updating the helpers with an "x4"
prefix when relevant and another one for 8 vs. grouped.

> 
> 
> > >               SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
> > >               SPINAND_PROG_LOAD(true, 0, NULL, 0));
> > >
> > > -static SPINAND_OP_VARIANTS(update_cache_variants,
> > > +static SPINAND_OP_VARIANTS(x4_update_cache_variants,
> > >               SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
> > >               SPINAND_PROG_LOAD(false, 0, NULL, 0));
> > >
> > > @@ -69,7 +69,7 @@ static int micron_8_ooblayout_free(struct mtd_info  
> > *mtd, int section,  
> > >       return 0;
> > >  }
> > >
> > > -static const struct mtd_ooblayout_ops micron_8_ooblayout = {
> > > +static const struct mtd_ooblayout_ops micron_grouped_ooblayout = {  
> >
> > Is this necessary? What does "grouped" means? Should we rename all
> > functions with _8_ in it to make sense?
> >  
> 
> IMHO, grouped means, ecc bytes are at continuous address, where as
> interleaved means ecc bytes splitted into multiple addresses

I don't like the name. Interleaved means that there are OOB bytes
stored in the data section, which is not the case here. The way OOB
bytes are organized do not seem relevant to me, I think i prefer the
"_4_/_8_" naming,even if it's not very explicit.

Also please be consistent, do not mix "_4_" and "interleaved" (see the
other patch).

Any feedback from Micron to validate these changes will be appreciated.

Thanks,
Miquèl
