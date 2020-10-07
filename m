Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA51128598F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 09:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbgJGHa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 03:30:27 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:60188 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbgJGHa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 03:30:26 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0977UFOr089215;
        Wed, 7 Oct 2020 02:30:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1602055815;
        bh=mHjIcR1lYuiovBvGBgUKM9WaqJJIFY9E/E3vhVDRG04=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=dknQjF3yX4MIJSyZelGKlVAwL57VRNgCvwJWFppFp2S6PnpIWj08U68yVvFlS0UnX
         PlkZmTZUshD7zI+XZ0fKiyxgf4W+LXx/+yNRwIfT+Io88WmlegZJoRww4iMNubN19F
         fyoQfyxuE7frKGxWeUlDCw0PWKqyO11x6F0r+TR8=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0977UF2T018810
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 7 Oct 2020 02:30:15 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 7 Oct
 2020 02:30:15 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 7 Oct 2020 02:30:15 -0500
Received: from [10.250.235.166] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0977Tumg035107;
        Wed, 7 Oct 2020 02:29:57 -0500
Subject: Re: [RESEND PATCH v2] mtd: spi-nor: Fix address width on flash chips
 > 16MB
To:     Pratyush Yadav <p.yadav@ti.com>, Bert Vermeulen <bert@biot.com>
CC:     <tudor.ambarus@microchip.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20201006132346.12652-1-bert@biot.com>
 <20201006151807.2pckm7ncply7uomc@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <096b2b97-6b6b-a46e-1239-e5d257e80c0b@ti.com>
Date:   Wed, 7 Oct 2020 12:59:56 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201006151807.2pckm7ncply7uomc@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/6/20 8:48 PM, Pratyush Yadav wrote:
> On 06/10/20 03:23PM, Bert Vermeulen wrote:
>> If a flash chip has more than 16MB capacity but its BFPT reports
>> BFPT_DWORD1_ADDRESS_BYTES_3_OR_4, the spi-nor framework defaults to 3.
>>
>> The check in spi_nor_set_addr_width() doesn't catch it because addr_width
>> did get set. This fixes that check.
>>
>> Fixes: f9acd7fa80be ("mtd: spi-nor: sfdp: default to addr_width of 3 for configurable widths")
>> Signed-off-by: Bert Vermeulen <bert@biot.com>
>> Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
>> ---
>>  drivers/mtd/spi-nor/core.c | 8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
>> index 0369d98b2d12..a2c35ad9645c 100644
>> --- a/drivers/mtd/spi-nor/core.c
>> +++ b/drivers/mtd/spi-nor/core.c
>> @@ -3009,13 +3009,15 @@ static int spi_nor_set_addr_width(struct spi_nor *nor)
>>  		/* already configured from SFDP */
>>  	} else if (nor->info->addr_width) {
>>  		nor->addr_width = nor->info->addr_width;
>> -	} else if (nor->mtd.size > 0x1000000) {
>> -		/* enable 4-byte addressing if the device exceeds 16MiB */
>> -		nor->addr_width = 4;
>>  	} else {
>>  		nor->addr_width = 3;
>>  	}
>>  
>> +	if (nor->addr_width == 3 && nor->mtd.size > 0x1000000) {
> Nitpick:    ^^^^^^^^^^^^^^^^^^^^^^^^ you can drop this part. But its 
> fine either way.
> 

I don't think its a good idea to drop nor->addr_width == 3 check as
nor->info->addr_width is permitted to have a value > 4 (although there
is no such flash today)...

> Reviewed-by: Pratyush Yadav <p.yadav@ti.com>
> 
>> +		/* enable 4-byte addressing if the device exceeds 16MiB */
>> +		nor->addr_width = 4;
>> +	}
>> +
>>  	if (nor->addr_width > SPI_NOR_MAX_ADDR_WIDTH) {
>>  		dev_dbg(nor->dev, "address width is too large: %u\n",
>>  			nor->addr_width);
> 

Regards
Vignesh
