Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 829D92A4488
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 12:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbgKCLsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 06:48:43 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:56880 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728806AbgKCLsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 06:48:43 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A3BmM8u074461;
        Tue, 3 Nov 2020 05:48:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604404102;
        bh=IZa5WQc/rpESZXfuIe4RXI1Md5tFfA37aiQeWFMk2EQ=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=o0Ug5DF1aIFS93loCiRQlMiaqfdqEubpibLn2Qssa8nE9gh9nT8FCfV+YDzWs7ElN
         7d7axnXwd4LtsyIWw9BOCBVM7dZvnPnycAnZIA3AgjKWWD3sAEDa9Vx2uS2AIsuArf
         11r7kfne0brpCU2d36vS5NuxvPtl3yBJWV9A1otM=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A3BmMKZ063138
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Nov 2020 05:48:22 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 3 Nov
 2020 05:48:21 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 3 Nov 2020 05:48:21 -0600
Received: from [10.250.233.179] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A3BmJW0056886;
        Tue, 3 Nov 2020 05:48:20 -0600
Subject: Re: [PATCH 2/3] UBI: Do not zero out EC and VID when multi-pass
 writes are not supported
To:     Pratyush Yadav <p.yadav@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20201012180404.6476-1-p.yadav@ti.com>
 <20201012180404.6476-3-p.yadav@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <f013d7af-6e1d-5b8f-4a23-7f6c150f896a@ti.com>
Date:   Tue, 3 Nov 2020 17:18:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201012180404.6476-3-p.yadav@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/12/20 11:34 PM, Pratyush Yadav wrote:
> For NOR flashes EC and VID are zeroed out before an erase is issued to
> make sure UBI does not mistakenly treat the PEB as used and associate it
> with an LEB.
> 
> But on some flashes, like the Cypress Semper S28 SPI NOR flash family,
> multi-pass page programming is not allowed on the default ECC scheme.
> This means zeroing out these magic numbers will result in the flash
> throwing a page programming error.
> 
> Do not zero out EC and VID when multi-pass writes are not supported.
> 
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> ---
>  drivers/mtd/ubi/io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/ubi/io.c b/drivers/mtd/ubi/io.c
> index 14d890b00d2c..4023fc4886e3 100644
> --- a/drivers/mtd/ubi/io.c
> +++ b/drivers/mtd/ubi/io.c
> @@ -535,7 +535,7 @@ int ubi_io_sync_erase(struct ubi_device *ubi, int pnum, int torture)
>  		return -EROFS;
>  	}
>  
> -	if (ubi->nor_flash) {
> +	if (ubi->nor_flash && !(ubi->mtd->flags & MTD_NO_MULTI_PASS_WRITE)) {
>  		err = nor_erase_prepare(ubi, pnum);
>  		if (err)
>  			return err;
> 

You may want to get rid of assertion for mtd->writesize != 1 in case of
MTD_NORFLASH.

See drivers/mtd/ubi/build.c::631

        if (ubi->mtd->type == MTD_NORFLASH) {
                ubi_assert(ubi->mtd->writesize == 1);
                ubi->nor_flash = 1;
        }

Regards
Vignesh
