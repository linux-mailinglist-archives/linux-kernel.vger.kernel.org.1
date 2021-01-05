Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 392E82EAB82
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 14:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730533AbhAENFT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 5 Jan 2021 08:05:19 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:43373 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729829AbhAENFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 08:05:17 -0500
Received: from xps13 (lfbn-tou-1-1535-bdcst.w90-89.abo.wanadoo.fr [90.89.98.255])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 82D77240008;
        Tue,  5 Jan 2021 13:04:32 +0000 (UTC)
Date:   Tue, 5 Jan 2021 14:04:31 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     linux-mtd@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        richard@nod.at, vigneshr@ti.com
Subject: Re: [PATCH 1/1] mtd: spinand: add support for Foresee FS35ND01G
Message-ID: <20210105140431.185e8ce1@xps13>
In-Reply-To: <CAFr9PXmPEQ2poQUTtaBH4CZ-S+sJjoUjJ5D_qA5aHZj7AASg7w@mail.gmail.com>
References: <20201229055059.2255021-1-daniel@0x0f.com>
        <20201229055059.2255021-2-daniel@0x0f.com>
        <20210104151746.21cdde24@xps13>
        <CAFr9PXmPEQ2poQUTtaBH4CZ-S+sJjoUjJ5D_qA5aHZj7AASg7w@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Daniel Palmer <daniel@0x0f.com> wrote on Tue, 5 Jan 2021 21:18:21 +0900:

> Hi Miquel,
> 
> On Mon, 4 Jan 2021 at 23:17, Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > Perhaps giving the link of the datasheet here makes sense.  
> 
> Noted. I'll put that into v2.
> 
> > > +#define SPINAND_MFR_LONGSYS          0xcd  
> >
> > Nitpick: I personally prefer uppercase hex numbers.
> >  
> 
> Noted.
> 
> > > +                  NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
> > > +                  NAND_ECCREQ(4, 512),
> > > +                  SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> > > +                                           &write_cache_variants,
> > > +                                           &update_cache_variants),  
> >
> > This device probably supports more variants (especially dual/quad
> > ones) but I guess it's not a problem to not have them here right now.  
> 
> Right now I can't really test dual or quad because my SPI driver
> doesn't know to do dual or quad io.
> I plan to add those in once I can validate they work.
> 
> > > +                  SPINAND_HAS_QE_BIT,
> > > +                  SPINAND_ECCINFO(NULL,
> > > +                                  NULL)),  
> >
> > You should define the ->ecc and ->free hooks of the
> > mtd_ooblayout_ops structure and point to it here. It defines the free
> > OOB bytes and bytes used by the on-die ECC engine. You should find this
> > in the datasheet. You may look at other manufacturer drivers for
> > examples of how it should be implemented. It is the way to tell the
> > upper layers that eg. "byte 2 to 17 are ECC bytes, 18 until the end are
> > free to use".  
> 
> Ok I'll add those in. Is there a way I can test that my implementation is right?
> I.e. is writing something, reading it back and checking if the data is
> correct a good enough test here?
> I don't really want to make it look like this flash is supported and
> break someone's data. :)

You may try to use flash_erase/nandwrite/nanddump from the mtd-utils
package. You may first use a dummy functions and declare the entire
zone free (except for the bad block marker at the beginning).

Then, you may write the entire OOB area in regular mode then read it in
raw mode (-n). Sometimes the ECC bytes are not visible, in this case it
may be worth trying writing the OOB area with known data and read it
back and see what you get. But these information probably are in the
datasheet.

Good luck,
Miquèl
