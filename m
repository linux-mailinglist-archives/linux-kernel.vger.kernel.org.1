Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 730E827E6BB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 12:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbgI3KfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 06:35:25 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:51674 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgI3KfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 06:35:24 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08UAZDj3063753;
        Wed, 30 Sep 2020 05:35:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601462113;
        bh=W3tHgrOnXpMaWWgD0wlfrfSuQNfKi2zpaLt3SGvhb5o=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=bOGg4TpkJccZJ6NABfzDiococTta9DWyHMKTlzdxfdGjeWc3X8oAOoX31nEKKjVgo
         QRCwueP5WRmzVykkoTJ4657SRmeO18pi2DzPRpXZdS/CBJ5LcohXxfrNTuIHMlLeni
         dZLpDMjYsgueH93ZB5+KaA6zvbNp9QmEFVstuOFM=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08UAZDax110293;
        Wed, 30 Sep 2020 05:35:13 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 30
 Sep 2020 05:35:12 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 30 Sep 2020 05:35:12 -0500
Received: from [10.250.235.166] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08UAZAoM003708;
        Wed, 30 Sep 2020 05:35:10 -0500
Subject: Re: [PATCH v3] mtd: spi-nor: keep lock bits if they are non-volatile
To:     Michael Walle <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
References: <20200327155939.13153-1-michael@walle.cc>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <523c3645-e37d-5d86-ba91-5c1be9e3881e@ti.com>
Date:   Wed, 30 Sep 2020 16:05:09 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200327155939.13153-1-michael@walle.cc>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/27/20 9:29 PM, Michael Walle wrote:
> Traditionally, linux unlocks the whole flash because there are legacy
> devices which has the write protections bits set by default at startup.
> If you actually want to use the flash protection bits, eg. because there
> is a read-only part for a bootloader, this automatic unlocking is
> harmful. If there is no hardware write protection in place (usually
> called WP#), a startup of the kernel just discards this protection.
> 
[...]
> Further, the commit 3e0930f109e76 ("mtd: spi-nor: Rework the disabling of
> block write protection") expanded the unlock_all() feature to ANY flash
> which supports locking.
> 

Appreciate the detail commit log.

> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
> changes since v2:
>  - add Kconfig option to be able to retain legacy behaviour
>  - rebased the patch due to the spi-nor rewrite
>  - dropped the Fixes: tag, it doens't make sense after the spi-nor rewrite
>  - mention commit 3e0930f109e76 which further modified the unlock
>    behaviour.
> 
> changes since v1:
>  - completely rewrote patch, the first version used a device tree flag
> 
>  drivers/mtd/spi-nor/Kconfig | 35 +++++++++++++++++++++++++++++
>  drivers/mtd/spi-nor/atmel.c | 24 +++++++++++++-------
>  drivers/mtd/spi-nor/core.c  | 44 ++++++++++++++++++++++++++++---------
>  drivers/mtd/spi-nor/core.h  |  6 +++++
>  drivers/mtd/spi-nor/esmt.c  |  6 ++---
>  drivers/mtd/spi-nor/intel.c |  6 ++---
>  drivers/mtd/spi-nor/sst.c   | 21 +++++++++---------
>  include/linux/mtd/spi-nor.h |  6 +++++
>  8 files changed, 114 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/Kconfig b/drivers/mtd/spi-nor/Kconfig
> index 6e816eafb312..647de17c81e2 100644
> --- a/drivers/mtd/spi-nor/Kconfig
> +++ b/drivers/mtd/spi-nor/Kconfig
> @@ -24,6 +24,41 @@ config MTD_SPI_NOR_USE_4K_SECTORS
>  	  Please note that some tools/drivers/filesystems may not work with
>  	  4096 B erase size (e.g. UBIFS requires 15 KiB as a minimum).
>  
> +choice
> +	prompt "Write protection at boot"
> +	default MTD_SPI_NOR_WP_DISABLE

These choice control how BP0-X bits are manipulated on boot. Hence, to
be consistent should use Block Protection (BP) terminology throughout.

This would also be inline with most flash datasheets which also use term BP

> +
> +config MTD_SPI_NOR_WP_DISABLE
> +	bool "Disable WP on any flashes (legacy behaviour)"
> +	help
> +	  This option disables the write protection on any SPI flashes at
> +	  boot-up.
> +
> +	  Don't use this if you intent to use the write protection of your
> +	  SPI flash. This is only to keep backwards compatibility.
> +
> +config MTD_SPI_NOR_WP_DISABLE_ON_VOLATILE
> +	bool "Disable WP on flashes w/ volatile protection bits"
> +	help
> +	  Some SPI flashes have volatile block protection bits, ie. after a
> +	  power-up or a reset the flash is write protected by default.
> +
> +	  This option disables the write protection for these kind of flashes
> +	  while keeping it enabled for any other SPI flashes which have
> +	  non-volatile block protection bits.
> +
> +	  If you are unsure, select this option.
> +
> +config MTD_SPI_NOR_WP_KEEP
> +	bool "Keep write protection as is"
> +	help
> +	  If you select this option the write protection of any SPI flashes
> +	  will not be changed. If your flash is write protected or will be
> +	  automatically write protected after power-up you have to manually
> +	  unlock it before you are able to write to it.
> +
> +endchoice
> +
>  source "drivers/mtd/spi-nor/controllers/Kconfig"
>  
>  endif # MTD_SPI_NOR

[...]

> diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
> index 6f2f6b27173f..9a33c023717f 100644
> --- a/drivers/mtd/spi-nor/core.h
> +++ b/drivers/mtd/spi-nor/core.h
> @@ -26,6 +26,7 @@ enum spi_nor_option_flags {
>  	SNOR_F_HAS_SR_TB_BIT6	= BIT(11),
>  	SNOR_F_HAS_4BIT_BP      = BIT(12),
>  	SNOR_F_HAS_SR_BP3_BIT6  = BIT(13),
> +	SNOR_F_NEED_UNPROTECT	= BIT(14),
>  };
>  
>  struct spi_nor_read_command {
> @@ -311,6 +312,11 @@ struct flash_info {
>  					 * BP3 is bit 6 of status register.
>  					 * Must be used with SPI_NOR_4BIT_BP.
>  					 */
> +#define SPI_NOR_UNPROTECT	BIT(19)	/*
> +					 * Flash is write-protected after
> +					 * power-up and needs a global
> +					 * unprotect.
> +					 */
>  

It would be better to name the flag to indicate BP bits are volatile or
powers up locked instead of SPI_NOR_UNPROTECT. This makes it easier to
understand what this flag means wrt flash HW feature. Maybe:

SPI_NOR_LOCKED_ON_POWER_UP or SPI_NOR_BP_IS_VOLATILE

Reset looks fine to me

[...]

Regards
Vignesh
