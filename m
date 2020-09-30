Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2611D27F583
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 00:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731896AbgI3Wvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 18:51:43 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:51025 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731808AbgI3Wvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 18:51:42 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 1E4A022EDE;
        Thu,  1 Oct 2020 00:51:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1601506300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0yBPgimlAnB9qjnYhtR1UnHNO8xcwVbFDrDVCIQ51JU=;
        b=MAY7Kkf68Sql2fBLQ6/Lvko6HSUWAvwe/B5CgSYoWPkGYLvwVAHJBDBMJXxqRohGAP47l+
        lPmpi1vWpo9AKiRyDghQImyvmtnm8uepVcNJBnIO0Q7U/QjCKM5/t7u82KxSlm5loB0ywn
        igk0rUL33G1BHdeicVH8DvZsL6ilroc=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 01 Oct 2020 00:51:39 +0200
From:   Michael Walle <michael@walle.cc>
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: Re: [PATCH v3] mtd: spi-nor: keep lock bits if they are non-volatile
In-Reply-To: <523c3645-e37d-5d86-ba91-5c1be9e3881e@ti.com>
References: <20200327155939.13153-1-michael@walle.cc>
 <523c3645-e37d-5d86-ba91-5c1be9e3881e@ti.com>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <fb33aa707744ad6c25a4d332e7d73c58@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2020-09-30 12:35, schrieb Vignesh Raghavendra:
[..]
>> Signed-off-by: Michael Walle <michael@walle.cc>
>> ---
>> changes since v2:
>>  - add Kconfig option to be able to retain legacy behaviour
>>  - rebased the patch due to the spi-nor rewrite
>>  - dropped the Fixes: tag, it doens't make sense after the spi-nor 
>> rewrite
>>  - mention commit 3e0930f109e76 which further modified the unlock
>>    behaviour.
>> 
>> changes since v1:
>>  - completely rewrote patch, the first version used a device tree flag
>> 
>>  drivers/mtd/spi-nor/Kconfig | 35 +++++++++++++++++++++++++++++
>>  drivers/mtd/spi-nor/atmel.c | 24 +++++++++++++-------
>>  drivers/mtd/spi-nor/core.c  | 44 
>> ++++++++++++++++++++++++++++---------
>>  drivers/mtd/spi-nor/core.h  |  6 +++++
>>  drivers/mtd/spi-nor/esmt.c  |  6 ++---
>>  drivers/mtd/spi-nor/intel.c |  6 ++---
>>  drivers/mtd/spi-nor/sst.c   | 21 +++++++++---------
>>  include/linux/mtd/spi-nor.h |  6 +++++
>>  8 files changed, 114 insertions(+), 34 deletions(-)
>> 
>> diff --git a/drivers/mtd/spi-nor/Kconfig b/drivers/mtd/spi-nor/Kconfig
>> index 6e816eafb312..647de17c81e2 100644
>> --- a/drivers/mtd/spi-nor/Kconfig
>> +++ b/drivers/mtd/spi-nor/Kconfig
>> @@ -24,6 +24,41 @@ config MTD_SPI_NOR_USE_4K_SECTORS
>>  	  Please note that some tools/drivers/filesystems may not work with
>>  	  4096 B erase size (e.g. UBIFS requires 15 KiB as a minimum).
>> 
>> +choice
>> +	prompt "Write protection at boot"
>> +	default MTD_SPI_NOR_WP_DISABLE
> 
> These choice control how BP0-X bits are manipulated on boot. Hence, to
> be consistent should use Block Protection (BP) terminology throughout.
> 
> This would also be inline with most flash datasheets which also use 
> term BP

Where should I mention the BP bits? In the choice or in the help text.
I tried to keep the choice prompt as easy to understand as possible, so 
an
user who doesn't know anything about how the write protection actually 
works
can still make that choice (without first reading a datasheet). Also 
keep in
mind, that there is also the per sector locking. Wouldn't this option 
also
apply to that?

Therefore, I'd mention in the help text, that (currently) the BP bits 
are
affected.

>> +
>> +config MTD_SPI_NOR_WP_DISABLE
>> +	bool "Disable WP on any flashes (legacy behaviour)"
>> +	help
>> +	  This option disables the write protection on any SPI flashes at
>> +	  boot-up.
>> +
>> +	  Don't use this if you intent to use the write protection of your
>> +	  SPI flash. This is only to keep backwards compatibility.
>> +
>> +config MTD_SPI_NOR_WP_DISABLE_ON_VOLATILE
>> +	bool "Disable WP on flashes w/ volatile protection bits"
>> +	help
>> +	  Some SPI flashes have volatile block protection bits, ie. after a
>> +	  power-up or a reset the flash is write protected by default.
>> +
>> +	  This option disables the write protection for these kind of 
>> flashes
>> +	  while keeping it enabled for any other SPI flashes which have
>> +	  non-volatile block protection bits.
>> +
>> +	  If you are unsure, select this option.
>> +
>> +config MTD_SPI_NOR_WP_KEEP
>> +	bool "Keep write protection as is"
>> +	help
>> +	  If you select this option the write protection of any SPI flashes
>> +	  will not be changed. If your flash is write protected or will be
>> +	  automatically write protected after power-up you have to manually
>> +	  unlock it before you are able to write to it.
>> +
>> +endchoice
>> +
>>  source "drivers/mtd/spi-nor/controllers/Kconfig"
>> 
>>  endif # MTD_SPI_NOR
> 
> [...]
> 
>> diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
>> index 6f2f6b27173f..9a33c023717f 100644
>> --- a/drivers/mtd/spi-nor/core.h
>> +++ b/drivers/mtd/spi-nor/core.h
>> @@ -26,6 +26,7 @@ enum spi_nor_option_flags {
>>  	SNOR_F_HAS_SR_TB_BIT6	= BIT(11),
>>  	SNOR_F_HAS_4BIT_BP      = BIT(12),
>>  	SNOR_F_HAS_SR_BP3_BIT6  = BIT(13),
>> +	SNOR_F_NEED_UNPROTECT	= BIT(14),
>>  };
>> 
>>  struct spi_nor_read_command {
>> @@ -311,6 +312,11 @@ struct flash_info {
>>  					 * BP3 is bit 6 of status register.
>>  					 * Must be used with SPI_NOR_4BIT_BP.
>>  					 */
>> +#define SPI_NOR_UNPROTECT	BIT(19)	/*
>> +					 * Flash is write-protected after
>> +					 * power-up and needs a global
>> +					 * unprotect.
>> +					 */
>> 
> 
> It would be better to name the flag to indicate BP bits are volatile or
> powers up locked instead of SPI_NOR_UNPROTECT. This makes it easier to
> understand what this flag means wrt flash HW feature. Maybe:
> 
> SPI_NOR_LOCKED_ON_POWER_UP or SPI_NOR_BP_IS_VOLATILE

SPI_NOR_BP_IS_VOLATILE sounds good to me.

-michael
