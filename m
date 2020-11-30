Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8A7C2C8502
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 14:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgK3NWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 08:22:32 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:60174 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbgK3NWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 08:22:32 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AUDKivx107486;
        Mon, 30 Nov 2020 07:20:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1606742444;
        bh=+/K2hKRb4yFQ1S8essiKDUp57a+GuXxB2VSy72qWHik=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=s0MeHiUzmbuNp+WqVoprFNIW3M61M0iO0vl5mYjqtvPTCl3cdLMOA04eL3qfpAmYY
         d7PLL//JI8tEIBWvZHINxGVh7wNDVChc/apNRjz5Q8CndsEacgZeQBtazPMFt5EZOK
         CliRAV7U7FgzZp3UJRCdPR23G0EJLuI8LVe0rnX4=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AUDKiMh085505
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 30 Nov 2020 07:20:44 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 30
 Nov 2020 07:20:43 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 30 Nov 2020 07:20:43 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AUDKg3p059300;
        Mon, 30 Nov 2020 07:20:43 -0600
Date:   Mon, 30 Nov 2020 18:50:42 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     <Tudor.Ambarus@microchip.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] UBI: Do not zero out EC and VID on ECC-ed NOR
 flashes
Message-ID: <20201130132040.ouzlqm6mnhhjmkzl@ti.com>
References: <20201118182459.18197-1-p.yadav@ti.com>
 <20201118182459.18197-2-p.yadav@ti.com>
 <2f07715e-fe44-c5fd-6194-b74ba9f22545@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2f07715e-fe44-c5fd-6194-b74ba9f22545@microchip.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/11/20 10:58AM, Tudor.Ambarus@microchip.com wrote:
> On 11/18/20 8:24 PM, Pratyush Yadav wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > For NOR flashes EC and VID are zeroed out before an erase is issued to
> > make sure UBI does not mistakenly treat the PEB as used and associate it
> > with an LEB.
> > 
> > But on some flashes, like the Cypress Semper S28 SPI NOR flash family,
> > multi-pass page programming is not allowed on the default ECC scheme.
> > This means zeroing out these magic numbers will result in the flash
> > throwing a page programming error.
> > 
> > Do not zero out EC and VID for such flashes. A writesize > 1 is an
> > indication of an ECC-ed flash.
> > 
> > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> > ---
> > 
> > Notes:
> >     Changes in v2:
> > 
> >     - Use mtd->writesize to check if multi-pass programming can be done
> >       instead of using MTD_NO_MULTI_PASS_WRITE.
> >     - Remove the assertion that a NOR flash most have writesize of 1.
> > 
> >  drivers/mtd/ubi/build.c | 4 +---
> >  drivers/mtd/ubi/io.c    | 9 ++++++++-
> >  2 files changed, 9 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
> > index e85b04e9716b..25fd7816b1f4 100644
> > --- a/drivers/mtd/ubi/build.c
> > +++ b/drivers/mtd/ubi/build.c
> > @@ -628,10 +628,8 @@ static int io_init(struct ubi_device *ubi, int max_beb_per1024)
> >                 ubi->bad_peb_limit = get_bad_peb_limit(ubi, max_beb_per1024);
> >         }
> > 
> > -       if (ubi->mtd->type == MTD_NORFLASH) {
> > -               ubi_assert(ubi->mtd->writesize == 1);
> > +       if (ubi->mtd->type == MTD_NORFLASH)
> >                 ubi->nor_flash = 1;
> > -       }
> > 
> >         ubi->min_io_size = ubi->mtd->writesize;
> >         ubi->hdrs_min_io_size = ubi->mtd->writesize >> ubi->mtd->subpage_sft;
> > diff --git a/drivers/mtd/ubi/io.c b/drivers/mtd/ubi/io.c
> > index 14d890b00d2c..2f3312c31e51 100644
> > --- a/drivers/mtd/ubi/io.c
> > +++ b/drivers/mtd/ubi/io.c
> > @@ -535,7 +535,14 @@ int ubi_io_sync_erase(struct ubi_device *ubi, int pnum, int torture)
> >                 return -EROFS;
> >         }
> > 
> > -       if (ubi->nor_flash) {
> > +       /*
> > +        * If the flash is ECC-ed then we have to erase the ECC block before we
> > +        * can write to it. But the write is in preparation to an erase in the
> > +        * first place. This means we cannot zero out EC and VID before the
> > +        * erase and we just have to hope the flash starts erasing from the
> > +        * start of the page.
> > +        */
> > +       if (ubi->nor_flash && ubi->mtd->writesize == 1) {
> 
> Are there any SPI NORs with ECC block size of 4 bytes? Should we call
> nor_erase_prepare() in this case?

None that I know of. But even if there was such a flash this check would 
continue to be correct.

Like Vignesh explained in the previous version, mtd->writesize > 1 means 
that multi-pass writes are not allowed in that ECC block. So even if a 
flash has ECC block size of 4, we still are not allowed to write 4 (or 
less) bytes to it before erasing first.
 
> Anyway, there's none in SPI NOR as of now, so:
> 
> Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> >                 err = nor_erase_prepare(ubi, pnum);
> >                 if (err)
> >                         return err;
> > --
> > 2.28.0
> > 
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments India
