Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4380627F982
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 08:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730498AbgJAGek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 02:34:40 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:43834 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgJAGej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 02:34:39 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0916YNch013296;
        Thu, 1 Oct 2020 01:34:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601534063;
        bh=XVFQ5GLbFfp9MKYTIQfqxjcku0NgzU2HqmWayPSwDzc=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=lLf3FYUNgFwfQ2v3ZS0isMYAfQ85gUFR5SPPDXvbjK0kCjz0fAW4rztXPIIG6G6Fh
         bmyEBM5L9KegNVyOpZLD2j7Fu8ftIe2aQivul+QUsCreCyEqRHoo9HmYGAaW55/3qF
         qpv2N41djolqq9m96TOX9ZW6c+TfD15hzvJ2ej7A=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0916YNtF045955
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Oct 2020 01:34:23 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 1 Oct
 2020 01:34:22 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 1 Oct 2020 01:34:22 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0916YMnH127527;
        Thu, 1 Oct 2020 01:34:22 -0500
Date:   Thu, 1 Oct 2020 12:04:21 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Bert Vermeulen <bert@biot.com>
CC:     <tudor.ambarus@microchip.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: spi-nor: Fix 3-or-4 address byte mode logic
Message-ID: <20201001063421.qcjdikj2tje3jn6k@ti.com>
References: <20200930235611.6355-1-bert@biot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200930235611.6355-1-bert@biot.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 01/10/20 01:56AM, Bert Vermeulen wrote:
> Flash chips that announce BFPT_DWORD1_ADDRESS_BYTES_3_OR_4 capability
> get an addr_width of 3. This breaks when the flash chip is actually
> larger than 16MB, since that requires a 4-byte address. The MX25L25635F
> does exactly this, breaking anything over 16MB.
> 
> spi-nor only enables 4-byte opcodes or 4-byte address mode if addr_width
> is 4, so no 4-byte mode is ever enabled. The > 16MB check in
> spi_nor_set_addr_width() only works if addr_width wasn't already set
> by the SFDP, which it was.
> 
> It could be fixed in a post_bfpt fixup for the MX25L25635F, but setting
> addr_width to 4 when BFPT_DWORD1_ADDRESS_BYTES_3_OR_4 is found fixes the
> problem for all such cases.

JESD216D.01 says: "01b: 3- or 4-Byte addressing (e.g., defaults to 
3-Byte mode; enters 4-Byte mode on command)"

So using an address width of 4 here is not necessarily the right thing 
to do. This change would break SMPT parsing for all flashes that use 
3-byte addressing by default because SMPT parsing can involve register 
reads/writes. One such device is the Cypress S28HS flash. In fact, this 
was what prompted me to write the patch [0].

Before that patch, how did MX25L25635F decide to use 4-byte addressing? 
Coming out of BFPT parsing addr_width would still be 0. My guess is that 
it would go into spi_nor_set_addr_width() with addr_width still 0 and 
then the check for (nor->mtd.size > 0x1000000) would set it to 4. Do I 
guess correctly?

In that case maybe we can do a better job of deciding what gets priority 
in the if-else chain. For example, giving addr_width from nor->info 
precedence over the one configured by SFDP can solve this problem. Then 
all you have to do is set the addr_width in the info struct, which is 
certainly easier than adding a fixup hook. There may be a more elegant 
solution to this but I haven't given it much thought.

So from my side, NACK!

> 
> Signed-off-by: Bert Vermeulen <bert@biot.com>
> ---
>  drivers/mtd/spi-nor/sfdp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
> index e2a43d39eb5f..6fedc425bcf7 100644
> --- a/drivers/mtd/spi-nor/sfdp.c
> +++ b/drivers/mtd/spi-nor/sfdp.c
> @@ -456,10 +456,10 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
>  	/* Number of address bytes. */
>  	switch (bfpt.dwords[BFPT_DWORD(1)] & BFPT_DWORD1_ADDRESS_BYTES_MASK) {
>  	case BFPT_DWORD1_ADDRESS_BYTES_3_ONLY:
> -	case BFPT_DWORD1_ADDRESS_BYTES_3_OR_4:
>  		nor->addr_width = 3;
>  		break;
>  
> +	case BFPT_DWORD1_ADDRESS_BYTES_3_OR_4:
>  	case BFPT_DWORD1_ADDRESS_BYTES_4_ONLY:
>  		nor->addr_width = 4;
>  		break;

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f9acd7fa80be6ee14aecdc54429f2a48e56224e8

-- 
Regards,
Pratyush Yadav
Texas Instruments India
