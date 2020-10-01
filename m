Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5F727FA59
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 09:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731032AbgJAHep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 03:34:45 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:54372 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgJAHeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 03:34:44 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0917YTDN032463;
        Thu, 1 Oct 2020 02:34:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601537669;
        bh=TRbqOzn7ubE4907l7PLq3YbRxbStioDDZZZZr7W6VLk=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=HeSMjJTIZ/IxUHCmyFFH2aR2NzZAdp1cOrda9x4wCSFUebQUdSkeVtnGxk7KGLQSQ
         Eimpr3yaWUykO+h6mCzJGo7gsMVi6yGFcfVsfdyROLkEfn3NkbWXupzGqBHc1bH50Y
         YevUCKXAG7ZXspmDtJQYgYZtlSuRBiAe6gxZ6VlU=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0917YTlC117202;
        Thu, 1 Oct 2020 02:34:29 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 1 Oct
 2020 02:34:29 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 1 Oct 2020 02:34:29 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0917YS6i101061;
        Thu, 1 Oct 2020 02:34:28 -0500
Date:   Thu, 1 Oct 2020 13:04:27 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     <Tudor.Ambarus@microchip.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nsekhar@ti.com>, <boris.brezillon@collabora.com>
Subject: Re: [PATCH v14 01/15] mtd: spi-nor: core: use EOPNOTSUPP instead of
 ENOTSUPP
Message-ID: <20201001073425.txsfdngrsugsy6uf@ti.com>
References: <20200930185732.6201-1-p.yadav@ti.com>
 <20200930185732.6201-2-p.yadav@ti.com>
 <5340adf5-1bb2-1eff-3812-6976b3b76faf@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5340adf5-1bb2-1eff-3812-6976b3b76faf@microchip.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/10/20 07:19AM, Tudor.Ambarus@microchip.com wrote:
> On 9/30/20 9:57 PM, Pratyush Yadav wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > ENOTSUPP is not a SUSV4 error code. Using EOPNOTSUPP is preferred
> > in its stead.
> > 
> > Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> The R-b tag should be after your S-o-b. This applies to other
> patches in the series too. No need to resubmit, it can be fixed when
> applying.

If we're using chronological order then I first added your Reviewed-by, 
and then signed off before resending the patches. So that way s-o-b 
comes after r-b.

Anyway, it doesn't really matter. Use whichever order you prefer.
 
> > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> > ---
> >  drivers/mtd/spi-nor/core.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> > index 0369d98b2d12..4d0f8d165544 100644
> > --- a/drivers/mtd/spi-nor/core.c
> > +++ b/drivers/mtd/spi-nor/core.c
> > @@ -2281,7 +2281,7 @@ static int spi_nor_hwcaps_pp2cmd(u32 hwcaps)
> >   *@nor:        pointer to a 'struct spi_nor'
> >   *@op:         pointer to op template to be checked
> >   *
> > - * Returns 0 if operation is supported, -ENOTSUPP otherwise.
> > + * Returns 0 if operation is supported, -EOPNOTSUPP otherwise.
> >   */
> >  static int spi_nor_spimem_check_op(struct spi_nor *nor,
> >                                    struct spi_mem_op *op)
> > @@ -2295,12 +2295,12 @@ static int spi_nor_spimem_check_op(struct spi_nor *nor,
> >         op->addr.nbytes = 4;
> >         if (!spi_mem_supports_op(nor->spimem, op)) {
> >                 if (nor->mtd.size > SZ_16M)
> > -                       return -ENOTSUPP;
> > +                       return -EOPNOTSUPP;
> > 
> >                 /* If flash size <= 16MB, 3 address bytes are sufficient */
> >                 op->addr.nbytes = 3;
> >                 if (!spi_mem_supports_op(nor->spimem, op))
> > -                       return -ENOTSUPP;
> > +                       return -EOPNOTSUPP;
> >         }
> > 
> >         return 0;
> > @@ -2312,7 +2312,7 @@ static int spi_nor_spimem_check_op(struct spi_nor *nor,
> >   *@nor:         pointer to a 'struct spi_nor'
> >   *@read:        pointer to op template to be checked
> >   *
> > - * Returns 0 if operation is supported, -ENOTSUPP otherwise.
> > + * Returns 0 if operation is supported, -EOPNOTSUPP otherwise.
> >   */
> >  static int spi_nor_spimem_check_readop(struct spi_nor *nor,
> >                                        const struct spi_nor_read_command *read)
> > @@ -2338,7 +2338,7 @@ static int spi_nor_spimem_check_readop(struct spi_nor *nor,
> >   *@nor:         pointer to a 'struct spi_nor'
> >   *@pp:          pointer to op template to be checked
> >   *
> > - * Returns 0 if operation is supported, -ENOTSUPP otherwise.
> > + * Returns 0 if operation is supported, -EOPNOTSUPP otherwise.
> >   */
> >  static int spi_nor_spimem_check_pp(struct spi_nor *nor,
> >                                    const struct spi_nor_pp_command *pp)
> > --
> > 2.28.0
> > 
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments India
