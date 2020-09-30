Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD1D927E2CE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 09:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbgI3HnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 03:43:23 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:60966 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgI3HnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 03:43:22 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08U7hB0T032138;
        Wed, 30 Sep 2020 02:43:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601451791;
        bh=ZF9wqdv0lxa8bwgZCPJ8AXia4qC5XXcG4E2TUV5895o=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=PGUux8Zj+mGgWNFAn1ICugJ1fZnuQkOnAuLTjeRLzHiA1jROPsP90+p3uOCbdpXit
         K9lMyuZq0/gvgEfd3QwhkC/YfXNt7Wp3F3xQvAuuVWJdD+Qpx4akO2toUIIIiRbRZ4
         mxxS6mLKUaULAVGTWwBL2KRIJycakc//Of/yC9E0=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08U7hBWD090407
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Sep 2020 02:43:11 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 30
 Sep 2020 02:43:11 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 30 Sep 2020 02:43:11 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08U7hAoo074277;
        Wed, 30 Sep 2020 02:43:11 -0500
Date:   Wed, 30 Sep 2020 13:13:09 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     <Tudor.Ambarus@microchip.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nsekhar@ti.com>, <boris.brezillon@collabora.com>
Subject: Re: [PATCH v13 11/15] mtd: spi-nor: core: perform a Soft Reset on
 shutdown
Message-ID: <20200930074307.rdi6352fy3is6gjq@ti.com>
References: <20200916124418.833-1-p.yadav@ti.com>
 <20200916124418.833-12-p.yadav@ti.com>
 <20200929130838.4hfa2y3qoxissdus@ti.com>
 <a32450dc-8db3-597c-34b0-68632ac27184@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a32450dc-8db3-597c-34b0-68632ac27184@microchip.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/09/20 07:32AM, Tudor.Ambarus@microchip.com wrote:
> On 9/29/20 4:08 PM, Pratyush Yadav wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > On 16/09/20 06:14PM, Pratyush Yadav wrote:
> >> Perform a Soft Reset on shutdown on flashes that support it so that the
> >> flash can be reset to its initial state and any configurations made by
> >> spi-nor (given that they're only done in volatile registers) will be
> >> reset. This will hand back the flash in pristine state for any further
> >> operations on it.
> >>
> >> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> >> ---
> >>  drivers/mtd/spi-nor/core.c  | 41 +++++++++++++++++++++++++++++++++++++
> >>  include/linux/mtd/spi-nor.h |  2 ++
> >>  2 files changed, 43 insertions(+)
> >>
> >> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> >> index 6ee93544d72f..853dfa02f0de 100644
> >> --- a/drivers/mtd/spi-nor/core.c
> >> +++ b/drivers/mtd/spi-nor/core.c
> >> @@ -40,6 +40,9 @@
> >>
> >>  #define SPI_NOR_MAX_ADDR_WIDTH       4
> >>
> >> +#define SPI_NOR_SRST_SLEEP_MIN 200
> >> +#define SPI_NOR_SRST_SLEEP_MAX 400
> >> +
> >>  /**
> >>   * spi_nor_get_cmd_ext() - Get the command opcode extension based on the
> >>   *                      extension type.
> >> @@ -3174,6 +3177,41 @@ static int spi_nor_init(struct spi_nor *nor)
> >>       return 0;
> >>  }
> >>
> >> +static void spi_nor_soft_reset(struct spi_nor *nor)
> >> +{
> >> +     struct spi_mem_op op;
> >> +     int ret;
> >> +
> >> +     op = (struct spi_mem_op)SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_SRSTEN, 8),
> 
> can we avoid the cast?

No. The compiler complains about "expected expression before '{' token". 
We can avoid it if the assignment is with the declaration but then we 
can't re-use the variable op for the second command.

I like the cast better than using separate variables for the two (or 
more in other cases) commands we execute.
 
> > 
> > The buswidth used here should be 1 instead of 8. It makes no difference
> > in practice because the call to spi_nor_spimem_setup_op() immediately
> > after will over-write it to the correct value anyway, but let's follow
> > the style followed throughout the rest of the codebase. Will fix in the
> > next version.
> 
> or you can just set the buswidth to 0 so that the reader rises his eyebrow
> and search for where it is updated. If you like it better you'll have to change
> throughout the entire code base, maybe in 4/15 where setup_op is introduced.

Ok. Will change it.
 
> > 
> >> +                     SPI_MEM_OP_NO_DUMMY,
> >> +                     SPI_MEM_OP_NO_ADDR,
> >> +                     SPI_MEM_OP_NO_DATA);
> >> +     spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
> 
> Still not a big fan of this, but we can update the op init later on. How
> about some new lines around spi_nor_spimem_setup_op()? First time I read
> the code I haven't seen it.

Ok.
 
> >> +     ret = spi_mem_exec_op(nor->spimem, &op);
> >> +     if (ret) {
> >> +             dev_warn(nor->dev, "Software reset failed: %d\n", ret);
> >> +             return;
> >> +     }
> >> +
> >> +     op = (struct spi_mem_op)SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_SRST, 8),
> > 
> > Same here.
> > 
> >> +                     SPI_MEM_OP_NO_DUMMY,
> >> +                     SPI_MEM_OP_NO_ADDR,
> >> +                     SPI_MEM_OP_NO_DATA);
> >> +     spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
> >> +     ret = spi_mem_exec_op(nor->spimem, &op);
> >> +     if (ret) {
> >> +             dev_warn(nor->dev, "Software reset failed: %d\n", ret);
> >> +             return;
> >> +     }
> >> +
> >> +     /*
> >> +      * Software Reset is not instant, and the delay varies from flash to
> >> +      * flash. Looking at a few flashes, most range somewhere below 100
> >> +      * microseconds. So, sleep for a range of 200-400 us.
> >> +      */
> >> +     usleep_range(SPI_NOR_SRST_SLEEP_MIN, SPI_NOR_SRST_SLEEP_MAX);
> >> +}
> >> +
> >>  /* mtd resume handler */
> >>  static void spi_nor_resume(struct mtd_info *mtd)
> >>  {

-- 
Regards,
Pratyush Yadav
Texas Instruments India
