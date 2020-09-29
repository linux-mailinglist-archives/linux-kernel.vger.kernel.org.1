Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0CB727D3CE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 18:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729748AbgI2Qpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 12:45:31 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48366 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbgI2Qpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 12:45:31 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08TGjLsI098287;
        Tue, 29 Sep 2020 11:45:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601397921;
        bh=ymJKx0eDQZcZfgK90TEOQHU5xYJMOSKKLJqeosF8wws=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=uynt3jodojKWE7JVAEqLbjhlZ7AfJzQssyGSXHpkA5ir4OVuSucEB51Jgc4mmWU+K
         A7kjCsuvOs8kpOddHBiqH8e6AWnGSgxSnmpA+blAod+46HVF4ci2a1lgGbhzMMOMH1
         kOF8+guGtbve1CV7mZul6qBSif86OAgqu+tnFwSs=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08TGjKu0044835
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 29 Sep 2020 11:45:21 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 29
 Sep 2020 11:45:20 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 29 Sep 2020 11:45:20 -0500
Received: from [10.250.235.166] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08TGjHed024553;
        Tue, 29 Sep 2020 11:45:18 -0500
Subject: Re: [RFC PATCH 2/3] mtd: spi-nor: Introduce
 MTD_SPI_NOR_ALLOW_STATEFUL_MODES
To:     Tudor Ambarus <tudor.ambarus@microchip.com>, <p.yadav@ti.com>,
        <boris.brezillon@collabora.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20200916124418.833-1-p.yadav@ti.com>
 <20200929095951.1575658-1-tudor.ambarus@microchip.com>
 <20200929095951.1575658-3-tudor.ambarus@microchip.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <ad264ac0-3dbd-2bde-1ff4-4176fcf3665c@ti.com>
Date:   Tue, 29 Sep 2020 22:15:17 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200929095951.1575658-3-tudor.ambarus@microchip.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/29/20 3:29 PM, Tudor Ambarus wrote:
> Some users may teach their bootloaders to discover and recover a
> flash even when left in a statefull mode (a X-X-X I/O mode that is
> configured via a non-volatile bit).
> 
> Provide a way for those users to enter in stateful modes. A reset
> or a crash will leave the flash in full I/O mode and if the bootloader
> does not know how to recover, the SPI NOR boot will be broken.
> 
> Flashes that will enable stateful modes will be accepted only if a
> hook to recover from the stateful mode is provided in the kernel.
> With this, even if a user will break its SPI NOR boot, it'll be able
> to recover the flash at the kernel level (on those systems that have
> at least another boot media). Both the Kconfig and the acceptance
> restriction are needed, so that we don't end up completely hopeless
> and look at a flash for which there is no software to discover and
> recover the flash. Even if we can recover the flash from a stateful
> mode in kernel, entering the stateful mode is still dangerous if one's
> bootloader can't handle it. We need a way to pass the responsibility
> to the user and let him decide conciously about the risks of allowing
> stateful modes.
> 

Recovering from non-volatile (NV) stateful mode would mean unsetting
some NV bit. Doing this for every boot would mean NV bit will wear out
quite quickly which is a concern. And sometimes NV Octal Enable bits are
OTP only (Some Macronix flashes).

NV bits are not to be fiddled with too often. One would set stateful
mode in NV way only if entire system is capable of handling this
somehow. But, IMHO, since SPI NOR core currently does not support
flashes that boot in Quad or Octal mode  at the moment, SPI NOR core
should not bother providing a hook for manipulating NV IO mode settings.

So my recommendation is to not support writing to non volatile IO modes
bits unless absolutely necessary.

Regards
Vignesh

> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  drivers/mtd/spi-nor/Kconfig | 10 ++++++++++
>  drivers/mtd/spi-nor/core.c  |  2 ++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/Kconfig b/drivers/mtd/spi-nor/Kconfig
> index ffc4b380f2b1..ab62457559b2 100644
> --- a/drivers/mtd/spi-nor/Kconfig
> +++ b/drivers/mtd/spi-nor/Kconfig
> @@ -24,6 +24,16 @@ config MTD_SPI_NOR_USE_4K_SECTORS
>  	  Please note that some tools/drivers/filesystems may not work with
>  	  4096 B erase size (e.g. UBIFS requires 15 KiB as a minimum).
>  
> +config MTD_SPI_NOR_ALLOW_STATEFUL_MODES
> +	bool "Allow stateful modes (DANGEROUS)"
> +	help
> +	  Allow the flash to enter in full I/O mode via a non-volatile bit.
> +	  A reset or a crash will leave the flash in the full I/O mode and if
> +	  the bootloader does not know how to recover, the SPI NOR boot will be
> +	  broken.
> +
> +	  Say N, unless you absolutely know what you are doing.
> +
>  source "drivers/mtd/spi-nor/controllers/Kconfig"
>  
>  endif # MTD_SPI_NOR
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index c149b318e2e8..e89c3ea9a736 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -3089,8 +3089,10 @@ static int spi_nor_octal_dtr_enable(struct spi_nor *nor, bool enable)
>  	      nor->write_proto == SNOR_PROTO_8_8_8_DTR))
>  		return 0;
>  
> +#ifndef CONFIG_MTD_SPI_NOR_ALLOW_STATEFUL_MODES
>  	if (!(nor->flags & SNOR_F_IO_MODE_EN_VOLATILE))
>  		return 0;
> +#endif
>  
>  	ret = nor->params->octal_dtr_enable(nor, enable);
>  	if (ret)
> 
