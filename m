Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D037327E1E3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 08:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbgI3GzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 02:55:25 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:33128 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbgI3GzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 02:55:25 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08U6tH3S111524;
        Wed, 30 Sep 2020 01:55:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601448917;
        bh=SjwzTMQn23wkJCILPpI4P6hiSeNglvKKYyq3k2vlQng=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=t3QoV6nRSNnRHIAcSrC7Zz5zfRkl/uPdPNQ/2iZhNQaDFdugJWy9g1OS1pfcTQGLP
         usYqIX146qqvqtOZgw7b2pyoqdiiQozpUUncbN/WqHJcX0uMNDKJu5Yi1jcnY89eed
         j+dQGrrxFrmRiP7cQuTgPCkGDbWKmYHsEcoJsUEA=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08U6tH3r004249
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Sep 2020 01:55:17 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 30
 Sep 2020 01:55:17 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 30 Sep 2020 01:55:17 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08U6tGxX115213;
        Wed, 30 Sep 2020 01:55:17 -0500
Date:   Wed, 30 Sep 2020 12:25:15 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     <Tudor.Ambarus@microchip.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nsekhar@ti.com>, <boris.brezillon@collabora.com>
Subject: Re: [PATCH v13 08/15] mtd: spi-nor: core: do 2 byte reads for SR and
 FSR in DTR mode
Message-ID: <20200930065513.bwieuiyt4hwwgods@ti.com>
References: <20200916124418.833-1-p.yadav@ti.com>
 <20200916124418.833-9-p.yadav@ti.com>
 <6198a69a-2800-d14f-1d29-9511ba6a3f5f@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6198a69a-2800-d14f-1d29-9511ba6a3f5f@microchip.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/09/20 06:50AM, Tudor.Ambarus@microchip.com wrote:
> On 9/16/20 3:44 PM, Pratyush Yadav wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > Some controllers, like the cadence qspi controller, have trouble reading
> > only 1 byte in DTR mode. So, do 2 byte reads for SR and FSR commands in
> 
> did you get garbage when reading only one byte?

Yes.
 
> > DTR mode, and then discard the second byte.
> > 
> > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> > ---
> >  drivers/mtd/spi-nor/core.c | 15 +++++++++++++--
> >  1 file changed, 13 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> > index 88c9e18067f4..87c568debf14 100644
> > --- a/drivers/mtd/spi-nor/core.c
> > +++ b/drivers/mtd/spi-nor/core.c
> > @@ -368,7 +368,7 @@ int spi_nor_write_disable(struct spi_nor *nor)
> >   * spi_nor_read_sr() - Read the Status Register.
> >   * @nor:       pointer to 'struct spi_nor'.
> >   * @sr:                pointer to a DMA-able buffer where the value of the
> > - *              Status Register will be written.
> > + *              Status Register will be written. Should be at least 2 bytes.
> >   *
> >   * Return: 0 on success, -errno otherwise.
> >   */
> > @@ -386,6 +386,11 @@ static int spi_nor_read_sr(struct spi_nor *nor, u8 *sr)
> >                 if (spi_nor_protocol_is_dtr(nor->reg_proto)) {
> >                         op.addr.nbytes = nor->params->rdsr_addr_nbytes;
> >                         op.dummy.nbytes = nor->params->rdsr_dummy;
> > +                       /*
> > +                        * We don't want to read only one byte in DTR mode. So,
> > +                        * read 2 and then discard the second byte.
> > +                        */
> > +                       op.data.nbytes = 2;
> 
> just for octal dtr, but should be fine if you update the previous patch

Ok.

-- 
Regards,
Pratyush Yadav
Texas Instruments India
