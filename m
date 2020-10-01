Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7649227FEB3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 13:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731893AbgJAL42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 07:56:28 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54684 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731670AbgJAL42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 07:56:28 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 091BuGJv084959;
        Thu, 1 Oct 2020 06:56:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601553376;
        bh=CVKY5T/YKKZG90aaeqafF0OA/PsmDSYnTFMbTSYWs44=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=K0v0C7RdqkYGQvWpbcxjqQDYwj/G38eHeRaDouqxWWlg7BEmCfnSRjZ2SKWs/iU2k
         bN3u2FNjWgS+enMz1uuDV8znWSNY6SBkc3EPQYjpukeyTTgz/4qZWS78ky0lnPC9oe
         ud24s1Yo7vLCFpbPiN/IOa0nlg8nr32/AHJnzjGE=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 091BuG7v002616
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Oct 2020 06:56:16 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 1 Oct
 2020 06:56:16 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 1 Oct 2020 06:56:15 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 091BuFIC046820;
        Thu, 1 Oct 2020 06:56:15 -0500
Date:   Thu, 1 Oct 2020 17:26:14 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     <Tudor.Ambarus@microchip.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nsekhar@ti.com>, <boris.brezillon@collabora.com>
Subject: Re: [PATCH v14 10/15] mtd: spi-nor: Parse SFDP SCCR Map
Message-ID: <20201001115612.7i4d2wmeinv2kyz5@ti.com>
References: <20200930185732.6201-1-p.yadav@ti.com>
 <20200930185732.6201-11-p.yadav@ti.com>
 <81fa2331-d808-fed6-232f-f8b67e7e9dac@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <81fa2331-d808-fed6-232f-f8b67e7e9dac@microchip.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/10/20 08:20AM, Tudor.Ambarus@microchip.com wrote:
> On 9/30/20 9:57 PM, Pratyush Yadav wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > From: Tudor Ambarus <tudor.ambarus@microchip.com>
> > 
> > Parse just the 22nd dword and look for the 'DTR Octal Mode Enable
> > Volatile bit'.
> > 
> > SPI_NOR_IO_MODE_EN_VOLATILE should be set just for the flashes
> > that don't define the optional SFDP SCCR Map. For the others,
> > let the SFDP do its job and fill the SNOR_F_IO_MODE_EN_VOLATILE
> > flag. We avoid this way polluting the flash flags when declaring
> > one.
> > 
> > Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> > ---
> >  drivers/mtd/spi-nor/sfdp.c | 52 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 52 insertions(+)
> > 
> > diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
> > index ebc1188f7533..0b5b9ea44cfc 100644
> > --- a/drivers/mtd/spi-nor/sfdp.c
> > +++ b/drivers/mtd/spi-nor/sfdp.c
> >         return ret;
> >  }
> > 
> > +#define SCCR_DWORD22_OCTAL_DTR_EN_VOLATILE             BIT(31)
> > +
> > +/**
> > + * spi_nor_parse_sccr() - Parse the Status, Control and Configuration Register
> > + *                        Map.
> > + * @nor:               pointer to a 'struct spi_nor'
> > + * @sccr_header:       pointer to the 'struct sfdp_parameter_header' describing
> > + *                     the SCCR Map table length and version.
> > + * @params:            pointer to the 'struct spi_nor_flash_parameter' to be.
> > + *
> > + * Return: 0 on success, -errno otherwise.
> > + */
> > +static int spi_nor_parse_sccr(struct spi_nor *nor,
> > +                             const struct sfdp_parameter_header *sccr_header,
> > +                             struct spi_nor_flash_parameter *params)
> > +{
> > +       u32 *dwords, addr;
> > +       size_t len;
> > +       int ret;
> > +       u8 io_mode_en_volatile;
> 
> would a bool work here?

It should. I'll change it.
 
> > +
> > +       len = sccr_header->length * sizeof(*dwords);
> > +       dwords = kmalloc(len, GFP_KERNEL);
> > +       if (!dwords)
> > +               return -ENOMEM;
> > +
> > +       addr = SFDP_PARAM_HEADER_PTP(sccr_header);
> > +       ret = spi_nor_read_sfdp(nor, addr, len, dwords);
> > +       if (ret)
> > +               goto out;
> > +
> > +       le32_to_cpu_array(dwords, sccr_header->length);
> > +
> > +       io_mode_en_volatile = FIELD_GET(SCCR_DWORD22_OCTAL_DTR_EN_VOLATILE,
> > +                                       dwords[22]);
> > +
> > +       if (io_mode_en_volatile)
> > +               nor->flags |= SNOR_F_IO_MODE_EN_VOLATILE;
> > +
> > +out:
> > +       kfree(dwords);
> > +       return ret;
> > +}
> > +
> >  /**
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments India
