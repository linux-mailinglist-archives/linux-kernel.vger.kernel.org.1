Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4D182A7F92
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 14:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730270AbgKENVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 08:21:46 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:33124 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729113AbgKENUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 08:20:15 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A5DJsSR098062;
        Thu, 5 Nov 2020 07:19:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604582394;
        bh=0qHAFsOzwvqtIpEDT9UpQO7R066zTF/Z4aiWxAAUldc=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=q2zJCP8U41EUlG0Gw0vqxU5pwaMKdbgDZao0RuIguCt6aGt6FRkea/5Ql5ktdfyGH
         yEssWLsB1A3samTGkOGI6vvdavkSDulswC5+JzGDqbIFKM5UOXByPg0u9PiO8+j8c2
         nuk93pI1z23/fLDToG1OOCa0uvPBiUaUEwSxMqzI=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A5DJsKF102644
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 5 Nov 2020 07:19:54 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 5 Nov
 2020 07:19:53 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 5 Nov 2020 07:19:53 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A5DJq3X103771;
        Thu, 5 Nov 2020 07:19:53 -0600
Date:   Thu, 5 Nov 2020 18:49:52 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>
CC:     Richard Weinberger <richard.weinberger@gmail.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        <linux-mtd@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] mtd: Make sure UBIFS does not do multi-pass page
 programming on flashes that don't support it
Message-ID: <20201105131950.73iqi5izdi6w5nog@ti.com>
References: <20201012180404.6476-1-p.yadav@ti.com>
 <20201027111804.e27pyvf62eksngmp@ti.com>
 <CAFLxGvxc=EqBStzLz3ApwYDomKMe=WeK22ohfPQs1WrMCsaVQg@mail.gmail.com>
 <fa578bda-132a-320a-264c-d973bae194dd@ti.com>
 <20201103124527.x6mp6slck44aotzn@ti.com>
 <4c0e3207-72a4-8c1a-5fca-e9f30cc60828@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4c0e3207-72a4-8c1a-5fca-e9f30cc60828@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/11/20 05:51PM, Vignesh Raghavendra wrote:
> 
> 
> On 11/3/20 6:15 PM, Pratyush Yadav wrote:
> > On 03/11/20 05:05PM, Vignesh Raghavendra wrote:
> >>
> >>
> >> On 11/1/20 3:14 AM, Richard Weinberger wrote:
> >>> On Tue, Oct 27, 2020 at 12:24 PM Pratyush Yadav <p.yadav@ti.com> wrote:
> >>>>> [0] https://lore.kernel.org/linux-mtd/20201005153138.6437-1-p.yadav@ti.com/
> >>>>
> >>>> Ping. Any comments on the series?
> >>>
> >>> From the UBIFS point of view I'd like to avoid as many device specific
> >>> settings as possible.
> >>> We check already for NOR flash, checking for NOR *and* SPI_NOR_NO_MULTI_PASS_PP
> >>> feels a bit clumsy.
> >>>
> >>> Tudor, what do you think about SPI_NOR_NO_MULTI_PASS_PP?
> >>> This kind of NOR seems to be a little NAND'ish. Maybe we can hide this detail
> >>> in the mtd framework?
> >>>
> >>
> >> Agree with Richard. I don't see need for SPI_NOR_NO_MULTI_PASS_PP. From
> >> MTD point of view setting mtd->writesize to be equal to pagesize should
> >> be enough. Its upto clients of MTD devices to ensure there is no multi
> >> pass programming within a "writesize" block.
> > 
> > That is what I initially thought too but then I realized that multi-pass 
> > programming is completely different from page-size programming. Instead 
> > of writing 4 bytes twice, you can zero out the entire page in one single 
> > operation. You would be compliant with the write size requirement but 
> > you still do multi-pass programming because you did not erase the page 
> > before this operation.
> > 
> 
> Right...
> 
> > It is also not completely correct to say the Cypress S28 flash has a 
> > write size of 256. You _can_ write one byte if you want. You just can't 
> > write to that page again without erasing it first. For example, if a 
> > file system only wants to write 128 bytes on a page, it can do so 
> > without having to write the whole page. It just needs to make sure it 
> > doesn't write to it again without erasing first.
> > 
> 
> As per documentation:
> mtd_info::writesize: "In case of ECC-ed NOR it is of ECC block size"
> 
> This means, it is block on which ECC is calculated on ECC-ed NOR and
> thus needs to be erased every time before being updated.
> 
> Looking at flash datasheet, this seems to be 16 bytes.
> 
> So mtd->writesize = 16 and not 256 (or pagesize)

Ok.
 
> Also, It does not imply length of data being written has to be multiple
> of it. At least NAND subsystem does not seem to care that during  writes
> len < mtd->writesize[1].

Ok.
 
> > nor_erase_prepare() was written to handle quirks of some specific 
> > devices. Not every device starts filling zeroes from the end of a page. 
> > So we have device-specific code in UBIFS already. You will obviously 
> > need device-specific settings to have control over that code.
> > 
> 
> UBIFS intends to be robust against rogue power cuts and therefore would
> need to ensure some consistency during erase which explains flash
> specific quirk here.

Yes. There is no arguing if this is needed. The only question is how to 
skip it on flashes that don't support doing this.
 
> > One might argue that we should move nor_erase_prepare() out of UBIFS. 
> > But requiring a flash to start erasing from the start of the page is a 
> > UBIFS-specific requirement. Other users of a flash might not care about 
> > it at all.
> > 
> 
> Yes. But I don't see much harm done.
> 
> > And so we have ourselves a bit of a conundrum. Adding 
> > SPI_NOR_NO_MULTI_PASS_PP is IMHO the least disruptive answer. If the 
> > file system wants to do multi-pass page programming on NOR flashes, how 
> > else do we tell it not to do it for this specific flash?
> > 
> 
> I see don't see need for SPI_NOR_NO_MULTI_PASS_PP as
> SPI_NOR_NO_MULTI_PASS_PP is implied within a ECC block and writesize is
> supposed to represent the same.

Ok. So we can control the execution of nor_erase_prepare() with 
mtd->writesize. Will re-roll. Thanks.
 
> >> If this is not clear in the current documentation of struct mtd, then
> >> that can be updated.
> > 
> 
> [1]
> https://elixir.bootlin.com/linux/latest/source/drivers/mtd/nand/raw/nand_base.c#L4166

-- 
Regards,
Pratyush Yadav
Texas Instruments India
