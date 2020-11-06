Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF442A9736
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 14:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbgKFNoZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 6 Nov 2020 08:44:25 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:51497 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbgKFNoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 08:44:25 -0500
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 3FF1DFF803;
        Fri,  6 Nov 2020 13:44:22 +0000 (UTC)
Date:   Fri, 6 Nov 2020 14:44:20 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     vigneshr@ti.com, richard@nod.at, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH 00/23] Rid W=1 warnings in MTD
Message-ID: <20201106144420.13c18b97@xps13>
In-Reply-To: <20201106133247.GI2063125@dell>
References: <20201102115406.1074327-1-lee.jones@linaro.org>
        <20201106133247.GI2063125@dell>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

Lee Jones <lee.jones@linaro.org> wrote on Fri, 6 Nov 2020 13:32:47
+0000:

> > This set is part of a larger effort attempting to clean-up W=1
> > kernel builds, which are currently overwhelmingly riddled with
> > niggly little warnings.
> > 
> > Lee Jones (23):
> >   mtd: mtdpart: Fix misdocumented function parameter 'mtd'
> >   mtd: devices: phram: File headers are not good candidates for
> >     kernel-doc
> >   mtd: nand: onenand: onenand_base: Fix expected kernel-doc formatting
> >   mtd: devices: docg3: Fix kernel-doc 'bad line' and 'excessive doc'
> >     issues
> >   mtd: mtdcore: Fix misspelled function parameter 'section'
> >   mtd: nand: onenand: onenand_bbt: Fix expected kernel-doc formatting
> >   mtd: spi-nor: controllers: hisi-sfc: Demote non-conformant kernel-doc
> >   mtd: ubi: build: Document 'ubi_num' in struct mtd_dev_param
> >   mtd: nand: spi: toshiba: Demote non-conformant kernel-doc header
> >   mtd: ubi: kapi: Correct documentation for 'ubi_leb_read_sg's 'sgl'
> >     parameter
> >   mtd: ubi: eba: Fix a couple of misdocumentation issues
> >   mtd: ubi: wl: Fix a couple of kernel-doc issues
> >   mtd: nand: raw: brcmnand: brcmnand: Demote non-conformant kernel-doc
> >     headers
> >   mtd: ubi: gluebi: Fix misnamed function parameter documentation
> >   mtd: nand: raw: diskonchip: Marking unused variables as
> >     __always_unused
> >   mtd: nand: raw: cafe_nand: Remove superfluous param doc and add
> >     another
> >   mtd: nand: raw: s3c2410: Add documentation for 2 missing struct
> >     members
> >   mtd: nand: raw: omap_elm: Finish half populated function header,
> >     demote empty ones
> >   mtd: nand: raw: omap2: Fix a bunch of kernel-doc misdemeanours
> >   mtd: nand: raw: sunxi_nand: Document 'sunxi_nfc's 'caps' member
> >   mtd: nand: raw: arasan-nand-controller: Document 'anfc_op's 'buf'
> >     member
> >   mtd: nand: onenand: onenand_base: Fix some kernel-doc misdemeanours
> >   mtd: devices: powernv_flash: Add function names to headers and fix
> >     'dev'  
> 
> May I ask; what is the plan for these patches please?
> 
> Do you plan on taking the ones that do not require re-work, rather
> than fixing up and re-submitting the whole set.  It would certainly
> save a lot of mailing list churn if that were the case.
> 
> Either way, let me know and I will abide by your decision.
> 

I would prefer receiving a v2 with all the patches if you don't mind.

Thanks,
Miquèl
