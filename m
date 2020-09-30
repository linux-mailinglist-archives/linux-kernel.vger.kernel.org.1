Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA1827E1DA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 08:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgI3Gxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 02:53:47 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:32852 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbgI3Gxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 02:53:41 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08U6rTN5110868;
        Wed, 30 Sep 2020 01:53:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601448809;
        bh=kuqOovhebiQ7NwjpoSxWqBC4z/r9Z+K+9RBLLoXIuqU=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=fFTnK5Qr0rOuIGmKdM+ZKUmKMez01uIPlUntsNCx4QD/JhHi4zpATFkXPqcmOWl3w
         N9MhYnJUSS+7rWac67Fh1rlzfz9/Wno+6jAgNOowgo/sHweogimWebqm/pRKYK3PyY
         Ur/vboEWTkyux8icLHGzBJh6BRYGGej7YQSmmGgM=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08U6rTCP026890;
        Wed, 30 Sep 2020 01:53:29 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 30
 Sep 2020 01:53:29 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 30 Sep 2020 01:53:29 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08U6rS0n111859;
        Wed, 30 Sep 2020 01:53:28 -0500
Date:   Wed, 30 Sep 2020 12:23:27 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     <Tudor.Ambarus@microchip.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nsekhar@ti.com>, <boris.brezillon@collabora.com>
Subject: Re: [PATCH v13 06/15] mtd: spi-nor: sfdp: parse xSPI Profile 1.0
 table
Message-ID: <20200930065325.umw6kf3m3vzq4r5z@ti.com>
References: <20200916124418.833-1-p.yadav@ti.com>
 <20200916124418.833-7-p.yadav@ti.com>
 <c4ff4fba-cad5-de10-93e8-97a4e2edecf0@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c4ff4fba-cad5-de10-93e8-97a4e2edecf0@microchip.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/09/20 06:44AM, Tudor.Ambarus@microchip.com wrote:
> On 9/16/20 3:44 PM, Pratyush Yadav wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > This table is indication that the flash is xSPI compliant and hence
> > supports octal DTR mode. Extract information like the fast read opcode,
> > dummy cycles, the number of dummy cycles needed for a Read Status
> > Register command, and the number of address bytes needed for a Read
> > Status Register command.
> > 
> > We don't know what speed the controller is running at. Find the fast
> > read dummy cycles for the fastest frequency the flash can run at to be
> > sure we are never short of dummy cycles. If nothing is available,
> > default to 20. Flashes that use a different value should update it in
> > their fixup hooks.
> > 
> > Since we want to set read settings, expose spi_nor_set_read_settings()
> > in core.h.
> > 
> > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> > ---
> >  drivers/mtd/spi-nor/core.c |  2 +-
> >  drivers/mtd/spi-nor/core.h | 10 +++++
> >  drivers/mtd/spi-nor/sfdp.c | 91 ++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 102 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> > index 7445d7122304..cbb1aab27d03 100644
> > --- a/drivers/mtd/spi-nor/core.c
> > +++ b/drivers/mtd/spi-nor/core.c
...
> > @@ -1108,6 +1110,91 @@ static int spi_nor_parse_4bait(struct spi_nor 
> > *nor,
> >         return ret;
> >  }
> > 
> > +#define PROFILE1_DWORD1_RDSR_ADDR_BYTES                BIT(29)
> > +#define PROFILE1_DWORD1_RDSR_DUMMY             BIT(28)
> > +#define PROFILE1_DWORD1_RD_FAST_CMD            GENMASK(15, 8)
> > +#define PROFILE1_DWORD4_DUMMY_200MHZ           GENMASK(11, 7)
> > +#define PROFILE1_DWORD5_DUMMY_166MHZ           GENMASK(31, 27)
> > +#define PROFILE1_DWORD5_DUMMY_133MHZ           GENMASK(21, 17)
> > +#define PROFILE1_DWORD5_DUMMY_100MHZ           GENMASK(11, 7)
> > +#define PROFILE1_DUMMY_DEFAULT                 20
> > +
> > +/**
> > + * spi_nor_parse_profile1() - parse the xSPI Profile 1.0 table
> > + * @nor:               pointer to a 'struct spi_nor'
> > + * @profile1_header:   pointer to the 'struct sfdp_parameter_header' describing
> > + *                     the 4-Byte Address Instruction Table length and version.
> 
> Profile 1.0 Table

Oops! Will fix.
 
> > + * @params:            pointer to the 'struct spi_nor_flash_parameter' to be.
> > + *
> > + * Return: 0 on success, -errno otherwise.
> > + */
...
> > +       /*
> > +        * We don't know what speed the controller is running at. Find the
> > +        * dummy cycles for the fastest frequency the flash can run at to be
> > +        * sure we are never short of dummy cycles. A value of 0 means the
> > +        * frequency is not supported.
> > +        *
> > +        * Default to PROFILE1_DUMMY_DEFAULT if we don't find anything, and let
> > +        * flashes set the correct value if needed in their fixup hooks.
> > +        */
> > +       dummy = FIELD_GET(PROFILE1_DWORD4_DUMMY_200MHZ, dwords[3]);
> > +       if (!dummy)
> > +               dummy = FIELD_GET(PROFILE1_DWORD5_DUMMY_166MHZ, dwords[4]);
> > +       if (!dummy)
> > +               dummy = FIELD_GET(PROFILE1_DWORD5_DUMMY_133MHZ, dwords[4]);
> > +       if (!dummy)
> > +               dummy = FIELD_GET(PROFILE1_DWORD5_DUMMY_100MHZ, dwords[4]);
> > +       if (!dummy)
> > +               dummy = PROFILE1_DUMMY_DEFAULT;
> 
> just a dev_dbg here, without assuming what default value means

And we leave dummy to 0, correct?

-- 
Regards,
Pratyush Yadav
Texas Instruments India
