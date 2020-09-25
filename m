Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08B132785C8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 13:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbgIYL16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 07:27:58 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:46374 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728038AbgIYL16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 07:27:58 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08PBRZa1072742;
        Fri, 25 Sep 2020 06:27:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601033255;
        bh=EcrVhMqmWzfcEKwR8uHmPN0ZHL5ElCCD0dmA86rC5RM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=KqNMyH/TArPmxaVOEN21GUzUoA/WhaIpDaqkf58+hR1fXpWbVSGfyyN1nR+C/7WNd
         Nh03W4qa4zU0TR7QyZ3966VidxCLCOXrDb4j6iYY4SqYe9qE0R/p/nekGnb7t6uaoK
         3cBgKNi1SLxicjulXsrp8TXrWFI8X4oEXtzSlUp0=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08PBRZs4056153
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 25 Sep 2020 06:27:35 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 25
 Sep 2020 06:27:34 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 25 Sep 2020 06:27:35 -0500
Received: from [10.250.235.166] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08PBRWGR072022;
        Fri, 25 Sep 2020 06:27:33 -0500
Subject: Re: [PATCH] mtd: spi-nor: macronix: Add SECT_4K to mx25l12805d
To:     Robert Marko <robert.marko@sartura.hr>,
        <tudor.ambarus@microchip.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Luka Perkov <luka.perkov@sartura.hr>
References: <20200915100623.708736-1-robert.marko@sartura.hr>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <6693ac3b-bf07-4a02-caca-5285dabdbb14@ti.com>
Date:   Fri, 25 Sep 2020 16:57:31 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200915100623.708736-1-robert.marko@sartura.hr>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/15/20 3:36 PM, Robert Marko wrote:
> According to the mx25l12805d datasheet it supports using 4K or 64K sectors.
> So lets add the SECT_4K to enable 4K sector usage.
> 
> Datasheet: https://www.mxic.com.tw/Lists/Datasheet/Attachments/7321/MX25L12805D,%203V,%20128Mb,%20v1.2.pdf

Have you tested this feature on a real HW?

> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> Cc: Luka Perkov <luka.perkov@sartura.hr>
> ---
>  drivers/mtd/spi-nor/macronix.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
> index f97f3d127575..9203abaac229 100644
> --- a/drivers/mtd/spi-nor/macronix.c
> +++ b/drivers/mtd/spi-nor/macronix.c
> @@ -50,7 +50,7 @@ static const struct flash_info macronix_parts[] = {
>  	{ "mx25u4035",   INFO(0xc22533, 0, 64 * 1024,   8, SECT_4K) },
>  	{ "mx25u8035",   INFO(0xc22534, 0, 64 * 1024,  16, SECT_4K) },
>  	{ "mx25u6435f",  INFO(0xc22537, 0, 64 * 1024, 128, SECT_4K) },
> -	{ "mx25l12805d", INFO(0xc22018, 0, 64 * 1024, 256, 0) },
> +	{ "mx25l12805d", INFO(0xc22018, 0, 64 * 1024, 256, SECT_4K) },
>  	{ "mx25l12855e", INFO(0xc22618, 0, 64 * 1024, 256, 0) },
>  	{ "mx25r1635f",  INFO(0xc22815, 0, 64 * 1024,  32,
>  			      SECT_4K | SPI_NOR_DUAL_READ |
> 

Regards
Vignesh
