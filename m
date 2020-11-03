Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 757342A456D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 13:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbgKCMpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 07:45:44 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:38844 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbgKCMpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 07:45:43 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A3CjU30093058;
        Tue, 3 Nov 2020 06:45:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604407530;
        bh=MX6c8hjcZDZUesVswKmxwJG1AWhIKQOHy2Qu8D7QvJg=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=uaS1XINNYyC0R4S5tpUfC7m9Pf6LJJLEsRUVV7cPrn6drpafw+CLXOlLf7ryjg8kn
         M3DvKSAJDnwg4ribErcNQryKtbC9SDj0BOGZxba6m+sk5th1B1myRSRxpdYpmeB3SZ
         Yhd4UU/012yXsBaY12YsmVU+V/ISTmk1swng2P1k=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A3CjU4b059231
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Nov 2020 06:45:30 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 3 Nov
 2020 06:45:30 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 3 Nov 2020 06:45:30 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A3CjTv0038496;
        Tue, 3 Nov 2020 06:45:30 -0600
Date:   Tue, 3 Nov 2020 18:15:29 +0530
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
Message-ID: <20201103124527.x6mp6slck44aotzn@ti.com>
References: <20201012180404.6476-1-p.yadav@ti.com>
 <20201027111804.e27pyvf62eksngmp@ti.com>
 <CAFLxGvxc=EqBStzLz3ApwYDomKMe=WeK22ohfPQs1WrMCsaVQg@mail.gmail.com>
 <fa578bda-132a-320a-264c-d973bae194dd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <fa578bda-132a-320a-264c-d973bae194dd@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/11/20 05:05PM, Vignesh Raghavendra wrote:
> 
> 
> On 11/1/20 3:14 AM, Richard Weinberger wrote:
> > On Tue, Oct 27, 2020 at 12:24 PM Pratyush Yadav <p.yadav@ti.com> wrote:
> >>> [0] https://lore.kernel.org/linux-mtd/20201005153138.6437-1-p.yadav@ti.com/
> >>
> >> Ping. Any comments on the series?
> > 
> > From the UBIFS point of view I'd like to avoid as many device specific
> > settings as possible.
> > We check already for NOR flash, checking for NOR *and* SPI_NOR_NO_MULTI_PASS_PP
> > feels a bit clumsy.
> > 
> > Tudor, what do you think about SPI_NOR_NO_MULTI_PASS_PP?
> > This kind of NOR seems to be a little NAND'ish. Maybe we can hide this detail
> > in the mtd framework?
> > 
> 
> Agree with Richard. I don't see need for SPI_NOR_NO_MULTI_PASS_PP. From
> MTD point of view setting mtd->writesize to be equal to pagesize should
> be enough. Its upto clients of MTD devices to ensure there is no multi
> pass programming within a "writesize" block.

That is what I initially thought too but then I realized that multi-pass 
programming is completely different from page-size programming. Instead 
of writing 4 bytes twice, you can zero out the entire page in one single 
operation. You would be compliant with the write size requirement but 
you still do multi-pass programming because you did not erase the page 
before this operation.

It is also not completely correct to say the Cypress S28 flash has a 
write size of 256. You _can_ write one byte if you want. You just can't 
write to that page again without erasing it first. For example, if a 
file system only wants to write 128 bytes on a page, it can do so 
without having to write the whole page. It just needs to make sure it 
doesn't write to it again without erasing first.

nor_erase_prepare() was written to handle quirks of some specific 
devices. Not every device starts filling zeroes from the end of a page. 
So we have device-specific code in UBIFS already. You will obviously 
need device-specific settings to have control over that code.

One might argue that we should move nor_erase_prepare() out of UBIFS. 
But requiring a flash to start erasing from the start of the page is a 
UBIFS-specific requirement. Other users of a flash might not care about 
it at all.

And so we have ourselves a bit of a conundrum. Adding 
SPI_NOR_NO_MULTI_PASS_PP is IMHO the least disruptive answer. If the 
file system wants to do multi-pass page programming on NOR flashes, how 
else do we tell it not to do it for this specific flash?

> If this is not clear in the current documentation of struct mtd, then
> that can be updated.

-- 
Regards,
Pratyush Yadav
Texas Instruments India
