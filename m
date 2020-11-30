Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B59832C86EE
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 15:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbgK3OjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 09:39:02 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:56373 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgK3OjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 09:39:01 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 13BE423E4A;
        Mon, 30 Nov 2020 15:38:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1606747098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wRCzlM6l0FzoZkgYZ53dsulJ7jTTWRd5Ml+ouASdkyE=;
        b=fVoMUsHsBZ7tyifCm1x9rlEuw+ICtgjfE7BmjIz5vEsUfrs5g3BIGKpKvnHYD5YUnzRBEi
        Q0RAPbZuib923n4gFIyc2KELcksdPxdzjCJxFb8FcwjhchGawsu1DwlMAsrJrHFSru6+rC
        cauOpmUTXeO4zTG2W8Ikn3DMZ2mJYEI=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 30 Nov 2020 15:38:18 +0100
From:   Michael Walle <michael@walle.cc>
To:     Tudor.Ambarus@microchip.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        boris.brezillon@collabora.com
Subject: Re: [PATCH v6 5/5] mtd: spi-nor: keep lock bits if they are
 non-volatile
In-Reply-To: <432b31a7-2560-3b83-44d2-aa82c2e322ae@microchip.com>
References: <20201126202614.5710-1-michael@walle.cc>
 <20201126202614.5710-6-michael@walle.cc>
 <432b31a7-2560-3b83-44d2-aa82c2e322ae@microchip.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <46c99138eb6ce251bc741d358388c219@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2020-11-28 11:17, schrieb Tudor.Ambarus@microchip.com:
> On 11/26/20 10:26 PM, Michael Walle wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know 
>> the content is safe
>> 
>> Traditionally, linux unlocks the whole flash because there are legacy
>> devices which has the write protections bits set by default at 
>> startup.
>> If you actually want to use the flash protection bits, eg. because 
>> there
>> is a read-only part for a bootloader, this automatic unlocking is
>> harmful. If there is no hardware write protection in place (usually
>> called WP#), a startup of the kernel just discards this protection.
>> 
>> I've gone through the datasheets of all the flashes (except the Intel
>> ones where I could not find any datasheet nor reference) which 
>> supports
>> the unlocking feature and looked how the sector protection was
>> implemented. The currently supported flashes can be divided into the
>> following two categories:
>>  (1) block protection bits are non-volatile. Thus they keep their 
>> values
>>      at reset and power-cycle
>>  (2) flashes where these bits are volatile. After reset or 
>> power-cycle,
>>      the whole memory array is protected.
>>      (a) some devices needs a special "Global Unprotect" command, eg.
>>          the Atmel AT25DF041A.
>>      (b) some devices require to clear the BPn bits in the status
>>          register.
>> 
>> Due to the reasons above, we do not want to clear the bits for flashes
>> which belong to category (1). Fortunately for us, only Atmel flashes
>> fall into category (2a). Implement the "Global Protect" and "Global
>> Unprotect" commands for these. For (2b) we can use normal block
>> protection locking scheme.
>> 
>> This patch adds a new flag to indicate the case (2). Only if we have
>> such a flash we unlock the whole flash array. To be backwards 
>> compatible
>> it also introduces a kernel configuration option which restores the
>> complete legacy behavior ("Disable write protection on any flashes").
>> Hopefully, this will clean up "unlock the entire flash for legacy
>> devices" once and for all.
>> 
>> For reference here are the actually commits which introduced the 
>> legacy
>> behaviour (and extended the behaviour to other chip manufacturers):
> 
> typo: behavior
> 
>> 
>> commit f80e521c916cb ("mtd: m25p80: add support for the Intel/Numonyx 
>> {16,32,64}0S33B SPI flash chips")
>> commit ea60658a08f8f ("mtd: m25p80: disable SST software protection 
>> bits by default")
>> commit 7228982442365 ("[MTD] m25p80: fix bug - ATmel spi flash fails 
>> to be copied to")
>> 
>> Actually, this might also fix handling of the Atmel AT25DF flashes,
>> because the original commit 7228982442365 ("[MTD] m25p80: fix bug -
>> ATmel spi flash fails to be copied to") was writing a 0 to the status
>> register, which is a "Global Unprotect". This might not be the case in
>> the current code which only handles the block protection bits BP2, BP1
>> and BP0. Thus, it depends on the current contents of the status 
>> register
>> if this unlock actually corresponds to a "Global Unprotect" command. 
>> In
>> the worst case, the current code might leave the AT25DF flashes in a
>> write protected state.
>> 
>> The commit 191f5c2ed4b6f ("mtd: spi-nor: use 16-bit WRR command when 
>> QE
>> is set on spansion flashes") changed that behaviour by just clearing 
>> BP2
>> to BP0 instead of writing a 0 to the status register.
>> 
>> Further, the commit 3e0930f109e76 ("mtd: spi-nor: Rework the disabling
>> of block write protection") expanded the unlock_all() feature to ANY
>> flash which supports locking.
>> 
>> Signed-off-by: Michael Walle <michael@walle.cc>
>> ---
>> changes since v5:
>>  - also set SRWD bit for the "Global Protect" command
>>  - use spi_nor_write_sr() instead of spi_nor_write_sr_and_check() to 
>> send
>>    the "Global Protect" or "Global Unprotect" command
>>  - mark ESMT F25L32QA as non-volatile as indicated in a newer 
>> datasheet
>>    revision
>>  - rebased to latest tree
>> 
>> changes since v4:
>>  - made atmel_global_protection_default_init() static, spotted by
>>    lkp@intel.com
>> 
>> changes since v3:
>>  - now defaulting to MTD_SPI_NOR_WP_DISABLE_ON_VOLATILE, suggested by 
>> Vignesh
>>  - restored the original spi_nor_unlock_all(), instead add individual
>>    locking ops for the "Global Protect" scheme in atmel.c. This was 
>> tested
>>    partly with the AT25SL321 (for the test I added the fixups to this
>>    flash).
>>  - renamed SPI_NOR_UNPROTECT to SPI_NOR_WP_IS_VOLATILE. Suggested by
>>    Vingesh, although I've renamed it to a more general 
>> "WP_IS_VOLATILE"
>>    because either the BP bits or the individual sector locks might be
>>    volatile.
>>  - add mention of both block protection bits and "Global Unprotect" 
>> command
>>    in the Kconfig help text.
>> 
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
>>  drivers/mtd/spi-nor/Kconfig |  42 ++++++++++++
>>  drivers/mtd/spi-nor/atmel.c | 127 
>> ++++++++++++++++++++++++++++++++++--
>>  drivers/mtd/spi-nor/core.c  |  36 ++++++----
>>  drivers/mtd/spi-nor/core.h  |   8 +++
>>  drivers/mtd/spi-nor/esmt.c  |   2 +-
>>  drivers/mtd/spi-nor/intel.c |   9 ++-
>>  drivers/mtd/spi-nor/sst.c   |  21 +++---
>>  7 files changed, 213 insertions(+), 32 deletions(-)
>> 
>> diff --git a/drivers/mtd/spi-nor/Kconfig b/drivers/mtd/spi-nor/Kconfig
>> index ffc4b380f2b1..11e6658ee85d 100644
>> --- a/drivers/mtd/spi-nor/Kconfig
>> +++ b/drivers/mtd/spi-nor/Kconfig
>> @@ -24,6 +24,48 @@ config MTD_SPI_NOR_USE_4K_SECTORS
>>           Please note that some tools/drivers/filesystems may not work 
>> with
>>           4096 B erase size (e.g. UBIFS requires 15 KiB as a minimum).
>> 
>> +choice
>> +       prompt "Write protection at boot"
>> +       default MTD_SPI_NOR_WP_DISABLE_ON_VOLATILE
>> +
>> +config MTD_SPI_NOR_WP_DISABLE
> 
> Maybe it's just me, but when I see WP, I think about the WP# signal, 
> which is
> somehow related. I think I would prefer to use  SWP instead, which 
> comes from
> Software Write Protection, which should be good for both the BPn 
> protection
> and for the Individual Sector Protection with its Global Lock and 
> Unlock.

I don't know either. Somehow the SWP will become a true hw write 
protection
with the WP# pin. But I tend to agree, I'll change it to SWP.

> 
> I won't stall the series just for this, so do as you prefer.
> 
>> +       bool "Disable WP on any flashes (legacy behaviour)"
> 
> typo: behavior

Just out of curiosity, is kernel doc strict American English?

> 
>> +       help
>> +         This option disables the write protection on any SPI flashes 
>> at
> 
> If you'll choose SWP, you have to update description here and there. 
> For
> example s/write protection/software write protection.
> 
>> +         boot-up.
>> +
>> +         Depending on the flash chip this either clears the block 
>> protection
>> +         bits or does a "Global Unprotect" command.
>> +
>> +         Don't use this if you intent to use the write protection of 
>> your
>> +         SPI flash. This is only to keep backwards compatibility.
>> +
>> +config MTD_SPI_NOR_WP_DISABLE_ON_VOLATILE
>> +       bool "Disable WP on flashes w/ volatile protection bits"
>> +       help
>> +         Some SPI flashes have volatile block protection bits, ie. 
>> after a
>> +         power-up or a reset the flash is write protected by default.
>> +
>> +         This option disables the write protection for these kind of 
>> flashes
>> +         while keeping it enabled for any other SPI flashes which 
>> have
>> +         non-volatile write protection bits.
>> +
>> +         If the write protection will be disabled depending on the 
>> flash
>> +         either the block protection bits are cleared or a "Global 
>> Unprotect"
>> +         command is issued.
>> +
>> +         If you are unsure, select this option.
>> +
>> +config MTD_SPI_NOR_WP_KEEP
>> +       bool "Keep write protection as is"
>> +       help
>> +         If you select this option the write protection of any SPI 
>> flashes
>> +         will not be changed. If your flash is write protected or 
>> will be
>> +         automatically write protected after power-up you have to 
>> manually
>> +         unlock it before you are able to write to it.
>> +
>> +endchoice
>> +
>>  source "drivers/mtd/spi-nor/controllers/Kconfig"
>> 
>>  endif # MTD_SPI_NOR
>> diff --git a/drivers/mtd/spi-nor/atmel.c b/drivers/mtd/spi-nor/atmel.c
>> index fe6a4653823d..215df7c4272b 100644
>> --- a/drivers/mtd/spi-nor/atmel.c
>> +++ b/drivers/mtd/spi-nor/atmel.c
>> @@ -8,6 +8,8 @@
>> 
>>  #include "core.h"
>> 
>> +#define ATMEL_SR_GLOBAL_PROTECT_MASK GENMASK(5, 2)
>> +
>>  /*
>>   * The Atmel AT25FS010/AT25FS040 parts have some weird configuration 
>> for the
>>   * block protection bits. We don't support them. But legacy behaviour 
>> in linux
>> @@ -55,6 +57,103 @@ static const struct spi_nor_fixups 
>> atmel_at25fs_fixups = {
>>         .default_init = atmel_at25fs_default_init,
>>  };
>> 
>> +/**
>> + * atmel_set_global_protection - Do a Global Protect or Unprotect 
>> command
>> + * @nor:       pointer to 'struct spi_nor'
>> + * @ofs:       offset in bytes
>> + * @len:       len in bytes
>> + * @is_protect:        if true do a Global Protect otherwise it is a 
>> Global Unprotect
>> + *
>> + * Return: 0 on success, -error otherwise.
>> + */
>> +static int atmel_set_global_protection(struct spi_nor *nor, loff_t 
>> ofs,
>> +                                      uint64_t len, bool is_protect)
>> +{
>> +       int ret;
>> +       u8 sr;
>> +
>> +       /* We only support locking the whole flash array */
>> +       if (ofs || len != nor->params->size)
>> +               return -EINVAL;
>> +
>> +       ret = spi_nor_read_sr(nor, nor->bouncebuf);
>> +       if (ret)
>> +               return ret;
> 
> maybe a new line in between.

ok

>> +       sr = nor->bouncebuf[0];
>> +
>> +       /* SRWD bit needs to be cleared, otherwise the protection 
>> doesn't change */
>> +       if (sr & SR_SRWD) {
>> +               sr &= ~SR_SRWD;
>> +               ret = spi_nor_write_sr_and_check(nor, sr);
>> +               if (ret) {
>> +                       dev_err(nor->dev, "unable to clear SRWD bit, 
>> WP# asserted?\n");
> 
> spi_nor_write_sr_and_check() already prints a dev_dbg(). If you find a
> second message
> useful, you should use dev_dbg for low level info.

The intention for this was to make the user aware the reason why the 
unlock
might not work. The reason I chose dev_err() was that its unlikely that 
John
Doe will have debug enabled. But I already came up with another reason 
why
this is bad: Everytime the kernel will start an unlock all might raise 
that
error. Therefore, I guess the kernel is the wrong place for that.

> 
>> +                       return ret;
>> +               }
>> +       }
>> +
>> +       if (is_protect) {
>> +               sr |= ATMEL_SR_GLOBAL_PROTECT_MASK;
>> +               /*
>> +                * Set the SRWD bit again as soon as we are protecting
>> +                * anything. This will ensure that the WP# pin is 
>> working
>> +                * correctly. By doing this we also behave the same as
>> +                * spi_nor_sr_lock(), which sets SRWD if any block 
>> protection
>> +                * is active.
>> +                */
>> +               sr |= SR_SRWD;
>> +       } else {
>> +               sr &= ~ATMEL_SR_GLOBAL_PROTECT_MASK;
>> +       }
>> +
>> +       nor->bouncebuf[0] = sr;
>> +
>> +       /*
>> +        * We cannot use the spi_nor_write_sr_and_check() because this 
>> command
>> +        * isn't really setting any bits, instead it is an pseudo 
>> command for
>> +        * "Global Unprotect" or "Global Protect"
>> +        */
>> +       return spi_nor_write_sr(nor, nor->bouncebuf, 1);
>> +}
>> +
>> +static int atmel_global_protect(struct spi_nor *nor, loff_t ofs, 
>> uint64_t len)
>> +{
>> +       return atmel_set_global_protection(nor, ofs, len, true);
>> +}
>> +
>> +static int atmel_global_unprotect(struct spi_nor *nor, loff_t ofs, 
>> uint64_t len)
>> +{
>> +       return atmel_set_global_protection(nor, ofs, len, false);
>> +}
>> +
>> +static int atmel_is_global_protected(struct spi_nor *nor, loff_t ofs, 
>> uint64_t len)
>> +{
>> +       int ret;
>> +
>> +       if (ofs >= nor->params->size || (ofs + len) > 
>> nor->params->size)
>> +               return -EINVAL;
>> +
>> +       ret = spi_nor_read_sr(nor, nor->bouncebuf);
>> +       if (ret)
>> +               return ret;
>> +
>> +       return ((nor->bouncebuf[0] & ATMEL_SR_GLOBAL_PROTECT_MASK) == 
>> ATMEL_SR_GLOBAL_PROTECT_MASK);
>> +}
>> +
>> +static const struct spi_nor_locking_ops atmel_global_protection_ops = 
>> {
>> +       .lock = atmel_global_protect,
>> +       .unlock = atmel_global_unprotect,
>> +       .is_locked = atmel_is_global_protected,
>> +};
>> +
>> +static void atmel_global_protection_default_init(struct spi_nor *nor)
>> +{
>> +       nor->params->locking_ops = &atmel_global_protection_ops;
>> +}
>> +
>> +static const struct spi_nor_fixups atmel_global_protection_fixups = {
>> +       .default_init = atmel_global_protection_default_init,
>> +};
>> +
>>  static const struct flash_info atmel_parts[] = {
>>         /* Atmel -- some are (confusingly) marketed as "DataFlash" */
>>         { "at25fs010",  INFO(0x1f6601, 0, 32 * 1024,   4, SECT_4K | 
>> SPI_NOR_HAS_LOCK)
>> @@ -62,18 +161,32 @@ static const struct flash_info atmel_parts[] = {
>>         { "at25fs040",  INFO(0x1f6604, 0, 64 * 1024,   8, SECT_4K | 
>> SPI_NOR_HAS_LOCK)
>>                 .fixups = &atmel_at25fs_fixups },
>> 
>> -       { "at25df041a", INFO(0x1f4401, 0, 64 * 1024,   8, SECT_4K | 
>> SPI_NOR_HAS_LOCK) },
>> -       { "at25df321",  INFO(0x1f4700, 0, 64 * 1024,  64, SECT_4K | 
>> SPI_NOR_HAS_LOCK) },
>> -       { "at25df321a", INFO(0x1f4701, 0, 64 * 1024,  64, SECT_4K | 
>> SPI_NOR_HAS_LOCK) },
>> -       { "at25df641",  INFO(0x1f4800, 0, 64 * 1024, 128, SECT_4K | 
>> SPI_NOR_HAS_LOCK) },
>> +       { "at25df041a", INFO(0x1f4401, 0, 64 * 1024,   8,
>> +                            SECT_4K | SPI_NOR_HAS_LOCK | 
>> SPI_NOR_WP_IS_VOLATILE)
>> +                       .fixups = &atmel_global_protection_fixups },
>> +       { "at25df321",  INFO(0x1f4700, 0, 64 * 1024,  64,
>> +                            SECT_4K | SPI_NOR_HAS_LOCK | 
>> SPI_NOR_WP_IS_VOLATILE)
>> +                       .fixups = &atmel_global_protection_fixups },
>> +       { "at25df321a", INFO(0x1f4701, 0, 64 * 1024,  64,
>> +                            SECT_4K | SPI_NOR_HAS_LOCK | 
>> SPI_NOR_WP_IS_VOLATILE)
>> +                       .fixups = &atmel_global_protection_fixups },
>> +       { "at25df641",  INFO(0x1f4800, 0, 64 * 1024, 128,
>> +                            SECT_4K | SPI_NOR_HAS_LOCK | 
>> SPI_NOR_WP_IS_VOLATILE)
>> +                       .fixups = &atmel_global_protection_fixups },
>> 
>>         { "at25sl321",  INFO(0x1f4216, 0, 64 * 1024, 64,
>>                              SECT_4K | SPI_NOR_DUAL_READ | 
>> SPI_NOR_QUAD_READ) },
>> 
>>         { "at26f004",   INFO(0x1f0400, 0, 64 * 1024,  8, SECT_4K) },
>> -       { "at26df081a", INFO(0x1f4501, 0, 64 * 1024, 16, SECT_4K | 
>> SPI_NOR_HAS_LOCK) },
>> -       { "at26df161a", INFO(0x1f4601, 0, 64 * 1024, 32, SECT_4K | 
>> SPI_NOR_HAS_LOCK) },
>> -       { "at26df321",  INFO(0x1f4700, 0, 64 * 1024, 64, SECT_4K | 
>> SPI_NOR_HAS_LOCK) },
>> +       { "at26df081a", INFO(0x1f4501, 0, 64 * 1024, 16,
>> +                            SECT_4K | SPI_NOR_HAS_LOCK | 
>> SPI_NOR_WP_IS_VOLATILE)
>> +                       .fixups = &atmel_global_protection_fixups },
>> +       { "at26df161a", INFO(0x1f4601, 0, 64 * 1024, 32,
>> +                            SECT_4K | SPI_NOR_HAS_LOCK | 
>> SPI_NOR_WP_IS_VOLATILE)
>> +                       .fixups = &atmel_global_protection_fixups },
>> +       { "at26df321",  INFO(0x1f4700, 0, 64 * 1024, 64,
>> +                            SECT_4K | SPI_NOR_HAS_LOCK | 
>> SPI_NOR_WP_IS_VOLATILE)
>> +                       .fixups = &atmel_global_protection_fixups },
>> 
>>         { "at45db081d", INFO(0x1f2500, 0, 64 * 1024, 16, SECT_4K) },
>>  };
>> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
>> index 8c06a28a90de..8354ce0c8810 100644
>> --- a/drivers/mtd/spi-nor/core.c
>> +++ b/drivers/mtd/spi-nor/core.c
>> @@ -377,7 +377,7 @@ int spi_nor_write_disable(struct spi_nor *nor)
>>   *
>>   * Return: 0 on success, -errno otherwise.
>>   */
>> -static int spi_nor_read_sr(struct spi_nor *nor, u8 *sr)
>> +int spi_nor_read_sr(struct spi_nor *nor, u8 *sr)
>>  {
>>         int ret;
>> 
>> @@ -1049,7 +1049,7 @@ static int 
>> spi_nor_write_16bit_cr_and_check(struct spi_nor *nor, u8 cr)
>>   *
>>   * Return: 0 on success, -errno otherwise.
>>   */
>> -static int spi_nor_write_sr_and_check(struct spi_nor *nor, u8 sr1)
>> +int spi_nor_write_sr_and_check(struct spi_nor *nor, u8 sr1)
>>  {
>>         if (nor->flags & SNOR_F_HAS_16BIT_SR)
>>                 return spi_nor_write_16bit_sr_and_check(nor, sr1);
>> @@ -3124,15 +3124,14 @@ static int spi_nor_quad_enable(struct spi_nor 
>> *nor)
>>   * spi_nor_unlock_all() - Unlocks the entire flash memory array.
>>   * @nor:       pointer to a 'struct spi_nor'.
>>   *
>> - * Some SPI NOR flashes are write protected by default after a 
>> power-on reset
>> - * cycle, in order to avoid inadvertent writes during power-up. 
>> Backward
>> - * compatibility imposes to unlock the entire flash memory array at 
>> power-up
>> - * by default.
>> + * Return: 0 on success, -errno otherwise.
>>   */
>>  static int spi_nor_unlock_all(struct spi_nor *nor)
>>  {
>> -       if (nor->flags & SNOR_F_HAS_LOCK)
>> +       if (nor->flags & SNOR_F_HAS_LOCK) {
>> +               dev_dbg(nor->dev, "unprotecting entire flash\n");
>>                 return spi_nor_unlock(&nor->mtd, 0, 
>> nor->params->size);
>> +       }
>> 
>>         return 0;
>>  }
>> @@ -3153,10 +3152,23 @@ static int spi_nor_init(struct spi_nor *nor)
>>                 return err;
>>         }
>> 
>> -       err = spi_nor_unlock_all(nor);
>> -       if (err) {
>> -               dev_dbg(nor->dev, "Failed to unlock the entire flash 
>> memory array\n");
>> -               return err;
>> +       /*
>> +        * Some SPI NOR flashes are write protected by default after a 
>> power-on
>> +        * reset cycle, in order to avoid inadvertent writes during 
>> power-up.
>> +        * Backward compatibility imposes to unlock the entire flash 
>> memory
>> +        * array at power-up by default. Depending on the kernel 
>> configuration
>> +        * (1) we do nothing, (2) we unlock the entire flash in any 
>> case or (3)
>> +        * just do it actually powers up write-protected. The latter 
>> is
> 
> do it if it actually powers up
> 
> How about: (1) do nothing, (2) always unlock the entire flash array, 
> (3) unlock
> the entire flash array only when the software protection bits are 
> volatile.

ok

>> +        * indicated by SNOR_F_WP_IS_VOLATILE.
>> +        */
>> +       if (IS_ENABLED(CONFIG_MTD_SPI_NOR_WP_DISABLE) ||
>> +           (IS_ENABLED(CONFIG_MTD_SPI_NOR_WP_DISABLE_ON_VOLATILE) &&
>> +            nor->flags & SNOR_F_WP_IS_VOLATILE)) {
>> +               err = spi_nor_unlock_all(nor);
>> +               if (err) {
>> +                       dev_err(nor->dev, "Failed to unlock the entire 
>> flash memory array\n");
> 
> dev_dbg for low level info

Is this low level info or an actual error? Which raises the question:
should spi_nor_unlock_all() in case SWRD couldn't be cleared and thus
should all the spi_nor_init fail of this? Or should it rather be a
soft error?

Also I don't know how spi_nor_sr_unlock() will behave.

>> +                       return err;
>> +               }
>>         }
>> 
[..]

-michael
