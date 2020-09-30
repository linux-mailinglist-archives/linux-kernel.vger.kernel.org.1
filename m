Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B544527E545
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 11:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbgI3Jg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 05:36:59 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:39526 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728570AbgI3Jg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 05:36:59 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08U9aoRt042843;
        Wed, 30 Sep 2020 04:36:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601458610;
        bh=sFPkPqeYpg9a/lBkzRRN9aDvogNT35tbuNNhoeQ3PUU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=KQ+ZYMwV6+HJ1lCuvzMY5WXUE/oXOqZquFSNDODvW5SOpcJgRScxuCiuOoKEhsnv+
         Q8q/1DK/36wA+mbjnYkLzytOld13HuRcCPvlGQW3GpdvNJ/xQN5u5SIkj5s8lDUOU+
         TSi3fPvxS9WvihLdmihwR/SrmsXFnlMyvu4jbih4=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08U9aoHg026202;
        Wed, 30 Sep 2020 04:36:50 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 30
 Sep 2020 04:36:49 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 30 Sep 2020 04:36:49 -0500
Received: from [10.250.235.166] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08U9akFP083973;
        Wed, 30 Sep 2020 04:36:47 -0500
Subject: Re: [RESEND PATCH 1/2] mtd: spi-nor: do not touch TB bit without
 SPI_NOR_HAS_TB
To:     Ivan Mikhaylov <i.mikhaylov@yadro.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20200921112450.4824-1-i.mikhaylov@yadro.com>
 <20200921112450.4824-2-i.mikhaylov@yadro.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <9bfb10df-64d8-4a5e-b0ad-a8b5f4efc56f@ti.com>
Date:   Wed, 30 Sep 2020 15:06:46 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200921112450.4824-2-i.mikhaylov@yadro.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/21/20 4:54 PM, Ivan Mikhaylov wrote:
> Some chips like macronix don't have TB(Top/Bottom protection)
> bit in the status register. Do not write tb_mask inside status
> register, unless SPI_NOR_HAS_TB is present for the chip.
> 

Not entirely accurate.. Macronix chips have TB bit in config register
and is OTP and hence should not be touched ideally...

You still need to "read" that bit to determine actual scheme (Top vs
Bottom). This is needs to be done before 2/2 enables SPI_NOR_HAS_LOCK
flag for macronix flashes.

> Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>
> ---
>  drivers/mtd/spi-nor/core.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 0369d98b2d12..f9853dd566dc 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -1735,13 +1735,18 @@ static int spi_nor_sr_lock(struct spi_nor *nor, loff_t ofs, uint64_t len)
>  			return -EINVAL;
>  	}
>  
> -	status_new = (status_old & ~mask & ~tb_mask) | val;
> +	if (nor->flags & SNOR_F_HAS_SR_TB)
> +		status_new = (status_old & ~mask & ~tb_mask) | val;
> +	else
> +		status_new = (status_old & ~mask) | val;
>  
>  	/* Disallow further writes if WP pin is asserted */
>  	status_new |= SR_SRWD;
>  

I guess macronix does not support SR_SRWD right? This needs special
treatment as well.

So either, macronix.c should implements its own locking ops or convert
this function in to more generic library so that its suitable to be
called from macronix.c file while hiding vendor specific stuff in that
driver,

Regards
Vignesh

