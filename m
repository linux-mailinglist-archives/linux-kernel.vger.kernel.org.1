Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD742807F9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 21:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733072AbgJAToN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 15:44:13 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59246 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732755AbgJAToN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 15:44:13 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 091JhqXo049716;
        Thu, 1 Oct 2020 14:43:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601581432;
        bh=KDQ2HaZEXUkl7oL661s31lWASXgw47ixpbSHIn2BxmU=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=Sbc9E2kimU3SqjdGpz4mv76HJEEECi+o1/Ggn+Hk3gIlPiSm89iKC2LuXfr1Rj+Gb
         grHTJXdA5s4kW+Dw04eedoc26V0OMh16kNNkpQjeIiJQMCglMhNv9ojpSuez+csxYT
         AyIRcK+hCR+AYgs5VcXsYIfnCj5EF1n6WSpNBCiY=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 091Jhp22015635
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Oct 2020 14:43:52 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 1 Oct
 2020 14:43:51 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 1 Oct 2020 14:43:51 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 091JhorI057643;
        Thu, 1 Oct 2020 14:43:51 -0500
Date:   Fri, 2 Oct 2020 01:13:50 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     <Tudor.Ambarus@microchip.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nsekhar@ti.com>, <boris.brezillon@collabora.com>
Subject: Re: [PATCH v14 15/15] mtd: spi-nor: micron-st: allow using
 MT35XU512ABA in Octal DTR mode
Message-ID: <20201001194348.d2j6bctouwt5mrzk@ti.com>
References: <20200930185732.6201-1-p.yadav@ti.com>
 <20200930185732.6201-16-p.yadav@ti.com>
 <dd899747-f1eb-2253-9677-8d82c9f73ea6@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <dd899747-f1eb-2253-9677-8d82c9f73ea6@microchip.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/10/20 08:38AM, Tudor.Ambarus@microchip.com wrote:
> On 9/30/20 9:57 PM, Pratyush Yadav wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > Since this flash doesn't have a Profile 1.0 table, the Octal DTR
> > capabilities are enabled in the post SFDP fixup, along with the 8D-8D-8D
> > fast read settings.
> > 
> > Enable Octal DTR mode with 20 dummy cycles to allow running at the
> > maximum supported frequency of 200Mhz.
> > 
> > The flash supports the soft reset sequence. So, add the flag in the
> > flash's info.
> > 
> > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> > ---
> >  drivers/mtd/spi-nor/micron-st.c | 100 +++++++++++++++++++++++++++++++-
> >  1 file changed, 99 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
> > index ef3695080710..b0002c29fd37 100644
> > --- a/drivers/mtd/spi-nor/micron-st.c
> > +++ b/drivers/mtd/spi-nor/micron-st.c
> > @@ -8,10 +8,108 @@
> > 
> >  #include "core.h"
> > 
> > +#define SPINOR_OP_MT_DTR_RD    0xfd    /* Fast Read opcode in DTR mode */
> > +#define SPINOR_OP_MT_RD_ANY_REG        0x85    /* Read volatile register */
> > +#define SPINOR_OP_MT_WR_ANY_REG        0x81    /* Write volatile register */
> > +#define SPINOR_REG_MT_CFR0V    0x00    /* For setting octal DTR mode */
> > +#define SPINOR_REG_MT_CFR1V    0x01    /* For setting dummy cycles */
> > +#define SPINOR_MT_OCT_DTR      0xe7    /* Enable Octal DTR. */
> > +#define SPINOR_MT_EXSPI                0xff    /* Enable Extended SPI (default) */
> > +
> > +static int spi_nor_micron_octal_dtr_enable(struct spi_nor *nor, bool enable)
> > +{
> > +       struct spi_mem_op op;
> > +       u8 *buf = nor->bouncebuf;
> > +       int ret;
> > +
> > +       if (enable) {
> > +               /* Use 20 dummy cycles for memory array reads. */
> > +               ret = spi_nor_write_enable(nor);
> > +               if (ret)
> > +                       return ret;
> > +
> > +               *buf = 20;
> > +               op = (struct spi_mem_op)
> > +                       SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_MT_WR_ANY_REG, 1),
> > +                                  SPI_MEM_OP_ADDR(3, SPINOR_REG_MT_CFR1V, 1),
> > +                                  SPI_MEM_OP_NO_DUMMY,
> > +                                  SPI_MEM_OP_DATA_OUT(1, buf, 1));
> > +
> > +               ret = spi_mem_exec_op(nor->spimem, &op);
> > +               if (ret)
> > +                       return ret;
> > +
> > +               ret = spi_nor_wait_till_ready(nor);
> > +               if (ret)
> > +                       return ret;
> > +       }
> > +
> > +       ret = spi_nor_write_enable(nor);
> > +       if (ret)
> > +               return ret;
> > +
> > +       if (enable)
> > +               *buf = SPINOR_MT_OCT_DTR;
> > +       else
> > +               *buf = SPINOR_MT_EXSPI;
> > +
> > +       op = (struct spi_mem_op)
> > +               SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_MT_WR_ANY_REG, 1),
> > +                          SPI_MEM_OP_ADDR(enable ? 3 : 4,
> > +                                          SPINOR_REG_MT_CFR0V, 1),
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
> 
> Don't we need to still read the Status Register here? The same question
> applies for the previous patch.

We do, and I even added a check here after reading your email. But in 
practice I realized that all we get from it is a false sense of 
security. If the sleep is too little, then the read status register will 
give out garbage data (or might even hang the controller) because the 
flash is still in a transition state. If the sleep is long enough then 
the read status register will tell us the flash is ready on the first 
try and we don't really gain any new insight.
 
> > +
> > +       return 0;
> > +}
> > +
> > +static void mt35xu512aba_default_init(struct spi_nor *nor)
> > +{
> > +       nor->params->octal_dtr_enable = spi_nor_micron_octal_dtr_enable;
> > +}
> > +
> > +static void mt35xu512aba_post_sfdp_fixup(struct spi_nor *nor)
> > +{
> > +       /* Set the Fast Read settings. */
> > +       nor->params->hwcaps.mask |= SNOR_HWCAPS_READ_8_8_8_DTR;
> > +       spi_nor_set_read_settings(&nor->params->reads[SNOR_CMD_READ_8_8_8_DTR],
> > +                                 0, 20, SPINOR_OP_MT_DTR_RD,
> > +                                 SNOR_PROTO_8_8_8_DTR);
> > +
> > +       nor->cmd_ext_type = SPI_NOR_EXT_REPEAT;
> > +       nor->params->rdsr_dummy = 8;
> > +       nor->params->rdsr_addr_nbytes = 0;
> > +
> > +       /*
> > +        * The BFPT quad enable field is set to a reserved value so the quad
> > +        * enable function is ignored by spi_nor_parse_bfpt(). Make sure we
> > +        * disable it.
> > +        */
> > +       nor->params->quad_enable = NULL;
> > +}
> > +
> > +static struct spi_nor_fixups mt35xu512aba_fixups = {
> > +       .default_init = mt35xu512aba_default_init,
> > +       .post_sfdp = mt35xu512aba_post_sfdp_fixup,
> > +};
> > +
> >  static const struct flash_info micron_parts[] = {
> >         { "mt35xu512aba", INFO(0x2c5b1a, 0, 128 * 1024, 512,
> >                                SECT_4K | USE_FSR | SPI_NOR_OCTAL_READ |
> > -                              SPI_NOR_4B_OPCODES) },
> > +                              SPI_NOR_4B_OPCODES | SPI_NOR_OCTAL_DTR_READ |
> > +                              SPI_NOR_OCTAL_DTR_PP |
> > +                              SPI_NOR_IO_MODE_EN_VOLATILE)
> > +         .fixups = &mt35xu512aba_fixups},
> >         { "mt35xu02g", INFO(0x2c5b1c, 0, 128 * 1024, 2048,
> >                             SECT_4K | USE_FSR | SPI_NOR_OCTAL_READ |
> >                             SPI_NOR_4B_OPCODES) },
> > --
> > 2.28.0
> > 
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments India
