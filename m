Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EECE27E55D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 11:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbgI3Jk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 05:40:27 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40262 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728500AbgI3Jk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 05:40:27 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08U9e6OX043951;
        Wed, 30 Sep 2020 04:40:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601458806;
        bh=KCmXt6m7Rv8hOJZq8QJiUqI+hcs587SPq0k6bMwb4+M=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=kGM8wh9MdSDS0BicpexwEIinc8VH6nmnZ3VbE4WdCLYsHE+z4Ig4a0GQGTwHSo1tj
         G/zLeeJcmLzNjNcyTRcYjglRTmeAPylHJNvb2wDu5yMw+wiXD9j8G5TqE2hJVsKPHy
         rwFct1UMYEYRse55WPh1hD3qTpOsPz9d+F6IYSqo=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08U9e6w5088130
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Sep 2020 04:40:06 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 30
 Sep 2020 04:40:06 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 30 Sep 2020 04:40:05 -0500
Received: from [10.250.235.166] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08U9e3Jq089623;
        Wed, 30 Sep 2020 04:40:04 -0500
Subject: Re: [RESEND PATCH 2/2] mtd: spi-nor: enable lock interface for
 macronix chips
To:     Ivan Mikhaylov <i.mikhaylov@yadro.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20200921112450.4824-1-i.mikhaylov@yadro.com>
 <20200921112450.4824-3-i.mikhaylov@yadro.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <cb47d79f-ecbb-f0ec-388e-b56ba740045e@ti.com>
Date:   Wed, 30 Sep 2020 15:10:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200921112450.4824-3-i.mikhaylov@yadro.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/21/20 4:54 PM, Ivan Mikhaylov wrote:
> Add locks for whole macronix chip series with BP0-2 and BP0-3 bits.
> 
> Tested with mx25l51245g(BP0-3).

Since you have only tested on flash that have 4bit BP, please don't
modify flashes that have 3bit BP. Lets be conservative and enable only
things that have been tested else we may end up with broken feature from
day 1.

Regards
Vignesh

> 
> Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>
> ---
>  drivers/mtd/spi-nor/macronix.c | 75 ++++++++++++++++++++++------------
>  1 file changed, 50 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
> index 96735d83c77c..80de43eb05d6 100644
> --- a/drivers/mtd/spi-nor/macronix.c
> +++ b/drivers/mtd/spi-nor/macronix.c
> @@ -37,53 +37,78 @@ static const struct flash_info macronix_parts[] = {
>  	/* Macronix */
>  	{ "mx25l512e",   INFO(0xc22010, 0, 64 * 1024,   1, SECT_4K) },
>  	{ "mx25l2005a",  INFO(0xc22012, 0, 64 * 1024,   4, SECT_4K) },
> -	{ "mx25l4005a",  INFO(0xc22013, 0, 64 * 1024,   8, SECT_4K) },
> -	{ "mx25l8005",   INFO(0xc22014, 0, 64 * 1024,  16, 0) },
> -	{ "mx25l1606e",  INFO(0xc22015, 0, 64 * 1024,  32, SECT_4K) },
> -	{ "mx25l3205d",  INFO(0xc22016, 0, 64 * 1024,  64, SECT_4K) },
> -	{ "mx25l3255e",  INFO(0xc29e16, 0, 64 * 1024,  64, SECT_4K) },
> -	{ "mx25l6405d",  INFO(0xc22017, 0, 64 * 1024, 128, SECT_4K) },
> -	{ "mx25u2033e",  INFO(0xc22532, 0, 64 * 1024,   4, SECT_4K) },
> +	{ "mx25l4005a",  INFO(0xc22013, 0, 64 * 1024,   8,
> +			      SECT_4K | SPI_NOR_HAS_LOCK) },
> +	{ "mx25l8005",   INFO(0xc22014, 0, 64 * 1024,  16,
> +			      SPI_NOR_HAS_LOCK) },
> +	{ "mx25l1606e",  INFO(0xc22015, 0, 64 * 1024,  32,
> +			      SECT_4K | SPI_NOR_HAS_LOCK | SPI_NOR_4BIT_BP) },
> +	{ "mx25l3205d",  INFO(0xc22016, 0, 64 * 1024,  64,
> +			      SECT_4K | SPI_NOR_HAS_LOCK | SPI_NOR_4BIT_BP) },
> +	{ "mx25l3255e",  INFO(0xc29e16, 0, 64 * 1024,  64,
> +			      SECT_4K | SPI_NOR_HAS_LOCK | SPI_NOR_4BIT_BP) },
> +	{ "mx25l6405d",  INFO(0xc22017, 0, 64 * 1024, 128,
> +			      SECT_4K | SPI_NOR_HAS_LOCK | SPI_NOR_4BIT_BP) },
> +	{ "mx25u2033e",  INFO(0xc22532, 0, 64 * 1024,   4,
> +			      SECT_4K | SPI_NOR_HAS_LOCK) },
>  	{ "mx25u3235f",	 INFO(0xc22536, 0, 64 * 1024,  64,
>  			      SECT_4K | SPI_NOR_DUAL_READ |
> -			      SPI_NOR_QUAD_READ) },
> -	{ "mx25u4035",   INFO(0xc22533, 0, 64 * 1024,   8, SECT_4K) },
> -	{ "mx25u8035",   INFO(0xc22534, 0, 64 * 1024,  16, SECT_4K) },
> -	{ "mx25u6435f",  INFO(0xc22537, 0, 64 * 1024, 128, SECT_4K) },
> -	{ "mx25l12805d", INFO(0xc22018, 0, 64 * 1024, 256, 0) },
> -	{ "mx25l12855e", INFO(0xc22618, 0, 64 * 1024, 256, 0) },
> +			      SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK |
> +			      SPI_NOR_4BIT_BP) },
> +	{ "mx25u4035",   INFO(0xc22533, 0, 64 * 1024,   8,
> +			      SECT_4K | SPI_NOR_HAS_LOCK | SPI_NOR_4BIT_BP) },
> +	{ "mx25u8035",   INFO(0xc22534, 0, 64 * 1024,  16,
> +			      SECT_4K | SPI_NOR_HAS_LOCK | SPI_NOR_4BIT_BP) },
> +	{ "mx25u6435f",  INFO(0xc22537, 0, 64 * 1024, 128,
> +			      SECT_4K | SPI_NOR_HAS_LOCK | SPI_NOR_4BIT_BP) },
> +	{ "mx25l12805d", INFO(0xc22018, 0, 64 * 1024, 256,
> +			      SPI_NOR_HAS_LOCK | SPI_NOR_4BIT_BP) },
> +	{ "mx25l12855e", INFO(0xc22618, 0, 64 * 1024, 256,
> +			      SPI_NOR_HAS_LOCK | SPI_NOR_4BIT_BP) },
>  	{ "mx25r3235f",  INFO(0xc22816, 0, 64 * 1024,  64,
>  			      SECT_4K | SPI_NOR_DUAL_READ |
> -			      SPI_NOR_QUAD_READ) },
> +			      SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK |
> +			      SPI_NOR_4BIT_BP) },
>  	{ "mx25u12835f", INFO(0xc22538, 0, 64 * 1024, 256,
>  			      SECT_4K | SPI_NOR_DUAL_READ |
> -			      SPI_NOR_QUAD_READ) },
> +			      SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK |
> +			      SPI_NOR_4BIT_BP) },
>  	{ "mx25l25635e", INFO(0xc22019, 0, 64 * 1024, 512,
> -			      SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
> +			      SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
> +			      SPI_NOR_HAS_LOCK | SPI_NOR_4BIT_BP)
>  		.fixups = &mx25l25635_fixups },
>  	{ "mx25u25635f", INFO(0xc22539, 0, 64 * 1024, 512,
> -			      SECT_4K | SPI_NOR_4B_OPCODES) },
> +			      SECT_4K | SPI_NOR_4B_OPCODES | SPI_NOR_HAS_LOCK |
> +			      SPI_NOR_4BIT_BP) },
>  	{ "mx25u51245g", INFO(0xc2253a, 0, 64 * 1024, 1024,
>  			      SECT_4K | SPI_NOR_DUAL_READ |
> -			      SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
> +			      SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES |
> +			      SPI_NOR_HAS_LOCK | SPI_NOR_4BIT_BP) },
>  	{ "mx25v8035f",  INFO(0xc22314, 0, 64 * 1024,  16,
>  			      SECT_4K | SPI_NOR_DUAL_READ |
> -			      SPI_NOR_QUAD_READ) },
> -	{ "mx25l25655e", INFO(0xc22619, 0, 64 * 1024, 512, 0) },
> +			      SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK |
> +			      SPI_NOR_4BIT_BP) },
> +	{ "mx25l25655e", INFO(0xc22619, 0, 64 * 1024, 512,
> +			      SPI_NOR_HAS_LOCK | SPI_NOR_4BIT_BP) },
>  	{ "mx25l51245g", INFO(0xc2201a, 0, 64 * 1024, 1024,
>  			      SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
> -			      SPI_NOR_4B_OPCODES) },
> +			      SPI_NOR_4B_OPCODES | SPI_NOR_HAS_LOCK |
> +			      SPI_NOR_4BIT_BP) },
>  	{ "mx66l51235l", INFO(0xc2201a, 0, 64 * 1024, 1024,
>  			      SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
> -			      SPI_NOR_4B_OPCODES) },
> +			      SPI_NOR_4B_OPCODES | SPI_NOR_HAS_LOCK |
> +			      SPI_NOR_4BIT_BP) },
>  	{ "mx66u51235f", INFO(0xc2253a, 0, 64 * 1024, 1024,
>  			      SECT_4K | SPI_NOR_DUAL_READ |
> -			      SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
> +			      SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES |
> +			      SPI_NOR_HAS_LOCK | SPI_NOR_4BIT_BP) },
>  	{ "mx66l1g45g",  INFO(0xc2201b, 0, 64 * 1024, 2048,
>  			      SECT_4K | SPI_NOR_DUAL_READ |
> -			      SPI_NOR_QUAD_READ) },
> +			      SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK |
> +			      SPI_NOR_4BIT_BP) },
>  	{ "mx66l1g55g",  INFO(0xc2261b, 0, 64 * 1024, 2048,
> -			      SPI_NOR_QUAD_READ) },
> +			      SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK |
> +			      SPI_NOR_4BIT_BP) },
>  };
>  
>  static void macronix_default_init(struct spi_nor *nor)
> 
