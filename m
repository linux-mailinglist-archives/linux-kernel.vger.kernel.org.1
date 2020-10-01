Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2065D27FBA5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 10:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731645AbgJAIk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 04:40:27 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38180 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgJAIk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 04:40:27 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0918eGbw054980;
        Thu, 1 Oct 2020 03:40:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601541616;
        bh=frk6Lhc3oP5D7E8gBZ7NBofC/QdfSriomB2pUt4hw6c=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=oGhoyQCI9bWlELh+WtgszYg467uGze4nsmH/N5fiED1iEYKlogAkwtlHZe2N6mS3o
         4UHfJYRmKTui7hLfkCPu4hAOXNhKcla7BjF516ZlmiDoiGxrXSXOf45vQ7PDA3Nxhn
         +ElOAWbPXIsMp9Fy+J7exhhAm1EampHNJEix7Y+4=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0918eG9g092231;
        Thu, 1 Oct 2020 03:40:16 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 1 Oct
 2020 03:40:16 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 1 Oct 2020 03:40:16 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0918eFnU027625;
        Thu, 1 Oct 2020 03:40:16 -0500
Date:   Thu, 1 Oct 2020 14:10:15 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     <Tudor.Ambarus@microchip.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nsekhar@ti.com>, <boris.brezillon@collabora.com>
Subject: Re: [PATCH v14 14/15] mtd: spi-nor: spansion: add support for
 Cypress Semper flash
Message-ID: <20201001084012.wumsndtwe4qeuklt@ti.com>
References: <20200930185732.6201-1-p.yadav@ti.com>
 <20200930185732.6201-15-p.yadav@ti.com>
 <b5663e72-b67c-cb2c-e46c-62262a65cd44@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b5663e72-b67c-cb2c-e46c-62262a65cd44@microchip.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/10/20 08:35AM, Tudor.Ambarus@microchip.com wrote:
> On 9/30/20 9:57 PM, Pratyush Yadav wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > The Cypress Semper flash is an xSPI compliant octal DTR flash. Add
> > support for using it in octal DTR mode.
> > 
> > The flash by default boots in a hybrid sector mode. But the sector map
> > table on the part I had was programmed incorrectly and the SMPT values
> > on the flash don't match the public datasheet. Specifically, in some
> > places erase type 3 was used instead of 4. In addition, the region sizes
> > were incorrect in some places. So, for testing I set CFR3N[3] to enable
> > uniform sector sizes. Since the uniform sector mode bit is a
> > non-volatile bit, this series does not change it to avoid making any
> > permanent changes to the flash configuration. The correct data to
> > implement a fixup is not available right now and will be done in a
> > follow-up patch if needed.
> > 
> > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> > ---
> >  drivers/mtd/spi-nor/spansion.c | 160 +++++++++++++++++++++++++++++++++
> >  1 file changed, 160 insertions(+)
> > 
> > diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
> > index 8429b4af999a..dc6b14aba405 100644
> > --- a/drivers/mtd/spi-nor/spansion.c
> > +++ b/drivers/mtd/spi-nor/spansion.c
> > @@ -8,6 +8,161 @@
> > 
> >  #include "core.h"
> > 
> > +#define SPINOR_OP_RD_ANY_REG                   0x65    /* Read any register */
> > +#define SPINOR_OP_WR_ANY_REG                   0x71    /* Write any register */
> > +#define SPINOR_REG_CYPRESS_CFR2V               0x00800003
> > +#define SPINOR_REG_CYPRESS_CFR2V_MEMLAT_11_24  0xb
> > +#define SPINOR_REG_CYPRESS_CFR3V               0x00800004
> > +#define SPINOR_REG_CYPRESS_CFR3V_PGSZ          BIT(4) /* Page size. */
> > +#define SPINOR_REG_CYPRESS_CFR5V               0x00800006
> > +#define SPINOR_REG_CYPRESS_CFR5V_OCT_DTR_EN    0x3
> > +#define SPINOR_REG_CYPRESS_CFR5V_OCT_DTR_DS    0
> > +#define SPINOR_OP_CYPRESS_RD_FAST              0xee
> > +
> > +/**
> > + * spi_nor_cypress_octal_dtr_enable() - Enable octal DTR on Cypress flashes.
> > + * @nor:               pointer to a 'struct spi_nor'
> > + * @enable:              whether to enable or disable Octal DTR
> > + *
> > + * This also sets the memory access latency cycles to 24 to allow the flash to
> > + * run at up to 200MHz.
> > + *
> > + * Return: 0 on success, -errno otherwise.
> > + */
> > +static int spi_nor_cypress_octal_dtr_enable(struct spi_nor *nor, bool enable)
> > +{
> > +       struct spi_mem_op op;
> > +       u8 *buf = nor->bouncebuf;
> > +       int ret;
> > +
> > +       if (enable) {
> > +               /* Use 24 dummy cycles for memory array reads. */
> > +               ret = spi_nor_write_enable(nor);
> > +               if (ret)
> > +                       return ret;
> > +
> > +               *buf = SPINOR_REG_CYPRESS_CFR2V_MEMLAT_11_24;
> > +               op = (struct spi_mem_op)
> > +                       SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WR_ANY_REG, 1),
> > +                                  SPI_MEM_OP_ADDR(3, SPINOR_REG_CYPRESS_CFR2V,
> > +                                                  1),
> > +                                  SPI_MEM_OP_NO_DUMMY,
> > +                                  SPI_MEM_OP_DATA_OUT(1, buf, 1));
> > +
> > +               ret = spi_mem_exec_op(nor->spimem, &op);
> > +               if (ret) {
> > +                       dev_dbg(nor->dev,
> > +                               "failed to set default memory latency value: %d\n",
> > +                                ret);
> 
> Why do you consider the message important? I'm asking for consistency
> reasons, below on the next exec_op call there's no dev_dbg message.
> I would get rid of the dev_dbg entirely, the error code should be enough,
> but I agree that this might be just a personal preference. So, do as you
> prefer, but try to be consistent across the code.

Yes it is mostly personal preference, but I don't mind either way. I'll 
drop the dev_dbg().
 
> > +                       return ret;
> > +               }
> > +
> > +               ret = spi_nor_wait_till_ready(nor);
> > +               if (ret)
> > +                       return ret;
> > +
> > +               nor->read_dummy = 24;
> > +       }
> > +
> > +       /* Set/unset the octal and DTR enable bits. */
> > +       ret = spi_nor_write_enable(nor);
> > +       if (ret)
> > +               return ret;
> > +
> > +       if (enable)
> > +               *buf = SPINOR_REG_CYPRESS_CFR5V_OCT_DTR_EN;
> > +       else
> > +               *buf = SPINOR_REG_CYPRESS_CFR5V_OCT_DTR_DS;
> > +
> > +       op = (struct spi_mem_op)
> > +               SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WR_ANY_REG, 1),
> > +                          SPI_MEM_OP_ADDR(enable ? 3 : 4,
> > +                                          SPINOR_REG_CYPRESS_CFR5V,
> > +                                          1),
> > +                          SPI_MEM_OP_NO_DUMMY,
> > +                          SPI_MEM_OP_DATA_OUT(1, buf, 1));
> > +
> > +       if (!enable)
> > +               spi_nor_spimem_setup_op(nor, &op, SNOR_PROTO_8_8_8_DTR);
> > +
> > +       ret = spi_mem_exec_op(nor->spimem, &op);
> > +       if (ret)
> > +               return ret;
> > +
> > +       /* Give some time for the mode change to take place. */
> > +       usleep_range(400, 600);
> > +
> > +       return 0;
> > +}
> > +
> > +static void s28hs512t_default_init(struct spi_nor *nor)
> > +{
> > +       nor->params->octal_dtr_enable = spi_nor_cypress_octal_dtr_enable;
> > +}
> > +
> > +static void s28hs512t_post_sfdp_fixup(struct spi_nor *nor)
> > +{
> > +       /*
> > +        * On older versions of the flash the xSPI Profile 1.0 table has the
> > +        * 8D-8D-8D Fast Read opcode as 0x00. But it actually should be 0xEE.
> > +        */
> > +       if (nor->params->reads[SNOR_CMD_READ_8_8_8_DTR].opcode == 0)
> > +               nor->params->reads[SNOR_CMD_READ_8_8_8_DTR].opcode =
> > +                       SPINOR_OP_CYPRESS_RD_FAST;
> > +
> > +       /* This flash is also missing the 4-byte Page Program opcode bit. */
> > +       spi_nor_set_pp_settings(&nor->params->page_programs[SNOR_CMD_PP],
> > +                               SPINOR_OP_PP_4B, SNOR_PROTO_1_1_1);
> > +       /*
> > +        * Since xSPI Page Program opcode is backward compatible with
> > +        * Legacy SPI, use Legacy SPI opcode there as well.
> > +        */
> > +       spi_nor_set_pp_settings(&nor->params->page_programs[SNOR_CMD_PP_8_8_8_DTR],
> > +                               SPINOR_OP_PP_4B, SNOR_PROTO_8_8_8_DTR);
> > +
> > +       /*
> > +        * The xSPI Profile 1.0 table advertises the number of additional
> > +        * address bytes needed for Read Status Register command as 0 but the
> > +        * actual value for that is 4.
> > +        */
> > +       nor->params->rdsr_addr_nbytes = 4;
> > +}
> > +
> > +static int s28hs512t_post_bfpt_fixup(struct spi_nor *nor,
> > +                                    const struct sfdp_parameter_header *bfpt_header,
> > +                                    const struct sfdp_bfpt *bfpt,
> > +                                    struct spi_nor_flash_parameter *params)
> > +{
> > +       /*
> > +        * The BFPT table advertises a 512B page size but the page size is
> > +        * actually configurable (with the default being 256B). Read from
> > +        * CFR3V[4] and set the correct size.
> > +        */
> > +       struct spi_mem_op op =
> > +               SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RD_ANY_REG, 1),
> > +                          SPI_MEM_OP_ADDR(3, SPINOR_REG_CYPRESS_CFR3V, 1),
> > +                          SPI_MEM_OP_NO_DUMMY,
> > +                          SPI_MEM_OP_DATA_IN(1, nor->bouncebuf, 1));
> > +       int ret;
> > +
> > +       ret = spi_mem_exec_op(nor->spimem, &op);
> > +       if (ret)
> > +               return ret;
> 
> no need to wait after CFR3V?

It is a read operation. We don't need to wait after reads.
 
> Cheers,
> ta
> 
> > +
> > +       if (nor->bouncebuf[0] & SPINOR_REG_CYPRESS_CFR3V_PGSZ)
> > +               params->page_size = 512;
> > +       else
> > +               params->page_size = 256;
> > +
> > +       return 0;
> > +}
> > +
> > +static struct spi_nor_fixups s28hs512t_fixups = {
> > +       .default_init = s28hs512t_default_init,
> > +       .post_sfdp = s28hs512t_post_sfdp_fixup,
> > +       .post_bfpt = s28hs512t_post_bfpt_fixup,
> > +};
> > +
> >  static int
> >  s25fs_s_post_bfpt_fixups(struct spi_nor *nor,
> >                          const struct sfdp_parameter_header *bfpt_header,
> > @@ -104,6 +259,11 @@ static const struct flash_info spansion_parts[] = {
> >                              SPI_NOR_4B_OPCODES) },
> >         { "cy15x104q",  INFO6(0x042cc2, 0x7f7f7f, 512 * 1024, 1,
> >                               SPI_NOR_NO_ERASE) },
> > +       { "s28hs512t",   INFO(0x345b1a,      0, 256 * 1024, 256,
> > +                            SECT_4K | SPI_NOR_OCTAL_DTR_READ |
> > +                             SPI_NOR_OCTAL_DTR_PP)
> > +         .fixups = &s28hs512t_fixups,
> > +       },
> >  };
> > 
> >  static void spansion_post_sfdp_fixups(struct spi_nor *nor)
> > --
> > 2.28.0
> > 
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments India
