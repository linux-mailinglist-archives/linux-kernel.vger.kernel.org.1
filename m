Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3B12D2F32
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 17:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729374AbgLHQNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 11:13:12 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:56540 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbgLHQNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 11:13:11 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0B8GCFfw016889;
        Tue, 8 Dec 2020 10:12:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1607443935;
        bh=qyMODEZC6qKDZr+TvKNeUpnt+5/u/je0qlD1Yr8nPP8=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=Db9eI+072qeKgLOOnZj1QA/W0oJIvQwYfqFtPW6gATFxyXTLWkzCCZcGd/aOQk2xo
         fwDS9/7KHppCgDLQO5vkEGiE6Ddp6Tx/3ScG3ywqdekhYev4iRr5tLndYeDzeJD00y
         f/OraHqr/s5eI5gC1BoFlHNXZTnZ6O9iQqlpmMx0=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0B8GCEu0041582
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Dec 2020 10:12:14 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 8 Dec
 2020 10:12:14 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 8 Dec 2020 10:12:14 -0600
Received: from [10.250.233.179] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0B8GCCHU118687;
        Tue, 8 Dec 2020 10:12:12 -0600
Subject: Re: [PATCH v3 3/3] mtd: spi-nor: spansion: Set ECC block size
To:     Pratyush Yadav <p.yadav@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20201201102711.8727-1-p.yadav@ti.com>
 <20201201102711.8727-4-p.yadav@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <469a1112-93b0-1991-5a38-2142394f461f@ti.com>
Date:   Tue, 8 Dec 2020 21:42:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201201102711.8727-4-p.yadav@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/1/20 3:57 PM, Pratyush Yadav wrote:
> The S28 flash family uses 2-bit ECC by default with each ECC block being
> 16 bytes. Under this scheme multi-pass programming to an ECC block is
> not allowed. Set the writesize to make sure multi-pass programming is
> not attempted on the flash.
> 
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git spi-nor/next, thanks!
[3/3] mtd: spi-nor: spansion: Set ECC block size
      https://git.kernel.org/mtd/c/294cca6ce5


> 
> Notes:
>     No changes in v3
>     
>     New in v2.
> 
>  drivers/mtd/spi-nor/spansion.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
> index e487fd341a56..b0c5521c1e27 100644
> --- a/drivers/mtd/spi-nor/spansion.c
> +++ b/drivers/mtd/spi-nor/spansion.c
> @@ -109,6 +109,7 @@ static int spi_nor_cypress_octal_dtr_enable(struct spi_nor *nor, bool enable)
>  static void s28hs512t_default_init(struct spi_nor *nor)
>  {
>  	nor->params->octal_dtr_enable = spi_nor_cypress_octal_dtr_enable;
> +	nor->params->writesize = 16;
>  }
>  
>  static void s28hs512t_post_sfdp_fixup(struct spi_nor *nor)
> 
