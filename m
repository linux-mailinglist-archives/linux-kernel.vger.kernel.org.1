Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 255FE2C47F0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 19:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732892AbgKYSwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 13:52:37 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:55831 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731511AbgKYSwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 13:52:37 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 92A4A22FEB;
        Wed, 25 Nov 2020 19:52:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1606330352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5b56CBLECMvLLKiJplwMaGwXiawOOTRdGRqJJQKr60I=;
        b=jvW56JVaOaX6AwYedmmrRJoWAYryzNh2J+8S2X67C/ELepCS/uQIn29w0kdulebLeY7Ns0
        2CgSVxsaKLaecMat8AipHEJBhQmiWBd/jUQI5rmOZngk9PzFUzvzlHCU5l9TAlepTVLf5L
        eYALLM6Xxprz7sCwLA60fSQfXL/xw9k=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 25 Nov 2020 19:52:32 +0100
From:   Michael Walle <michael@walle.cc>
To:     Tudor.Ambarus@microchip.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        boris.brezillon@collabora.com
Subject: Re: [PATCH v5 3/3] mtd: spi-nor: keep lock bits if they are
 non-volatile
In-Reply-To: <e9437b3e-de44-7b17-df2c-6a8502b48ca4@microchip.com>
References: <20201003153235.29762-1-michael@walle.cc>
 <20201003153235.29762-4-michael@walle.cc>
 <e9437b3e-de44-7b17-df2c-6a8502b48ca4@microchip.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <f6344b9cb5c61c3bfd075e231b708269@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2020-11-25 13:21, schrieb Tudor.Ambarus@microchip.com:
[..]
>> diff --git a/drivers/mtd/spi-nor/atmel.c b/drivers/mtd/spi-nor/atmel.c
>> index 49d392c6c8bc..19665095aeab 100644
>> --- a/drivers/mtd/spi-nor/atmel.c
>> +++ b/drivers/mtd/spi-nor/atmel.c
>> @@ -8,23 +8,120 @@
>> 
>>  #include "core.h"
>> 
>> +#define ATMEL_SR_GLOBAL_PROTECT_MASK GENMASK(5, 2)
>> +
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
>> +                       return ret;
>> +               }
>> +       }
>> +
>> +       if (is_protect)
>> +               sr |= ATMEL_SR_GLOBAL_PROTECT_MASK;
>> +       else
>> +               sr &= ~ATMEL_SR_GLOBAL_PROTECT_MASK;
>> +
>> +       return spi_nor_write_sr_and_check(nor, sr);
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
> 
> Skimming through my notes in 1/3, I'm guessing this will not work for 
> any
> of the atmel flashes that we currently have.
> 
> Can we instead return -EOPNOTSUPP for .is_locked and .lock and just
> write a 0x00 to SR
> for the .unlock method?

As mentioned in my previous reply to 1/3 I don't think it is enough to
just write 0 because you first have to disable the SPRL.

For the other ops, for what atmel flash do you think this won't work?

All the flashes which uses these ops were marked as "Global
Protect/Unprotect same as in at25df041a." by you. So I think it should
work on all of these. Or am I missing something here?

[..]

>> diff --git a/drivers/mtd/spi-nor/esmt.c b/drivers/mtd/spi-nor/esmt.c
>> index c93170008118..c2ebf29d95f2 100644
>> --- a/drivers/mtd/spi-nor/esmt.c
>> +++ b/drivers/mtd/spi-nor/esmt.c
>> @@ -11,9 +11,13 @@
>>  static const struct flash_info esmt_parts[] = {
>>         /* ESMT */
>>         { "f25l32pa", INFO(0x8c2016, 0, 64 * 1024, 64,
>> -                          SECT_4K | SPI_NOR_HAS_LOCK) },
>> +                          SECT_4K | SPI_NOR_HAS_LOCK | 
>> SPI_NOR_WP_IS_VOLATILE) },
> 
> https://www.esmt.com.tw/upload/pdf/ESMT/datasheets/F25L32PA.pdf
> BP GENMASK(4,2), volatile, ok
> 
>>         { "f25l32qa", INFO(0x8c4116, 0, 64 * 1024, 64,
>> -                          SECT_4K | SPI_NOR_HAS_LOCK) },
>> +                          SECT_4K | SPI_NOR_HAS_LOCK | 
>> SPI_NOR_WP_IS_VOLATILE) },
> 
> https://datasheetspdf.com/pdf-file/796196/ESMT/F25L32QA/1
> Datasheet states that "BP0~3, QE and BPL bits are non-volatile."
> At the same time, it says: "After power-up, BP3, BP2, BP1 and BP0 bits
> are set to 0."

Mhh I had this datasheet:
https://www.esmt.com.tw/upload/pdf/ESMT/datasheets/F25L32QA.pdf

In that one they are volatile.. but yours is a newer version. So I
guess the flashes with the PA suffix have volatile BP and the QA ones
have the non-volatile version.

> Maybe factory default setting for BPn is 0? Let's treat them as NV, as 
> in
> f25l64qa.

Yes will fix it.

> Do we need BP3?

Rather the top bottom bit. But that is outside of the scope of this 
patch.
And as per your rule, as I don't have this particular flash I cannot 
test
and thus couldn't add the TB bit (technically). But if you like I can do
another patch (outside of this series and after it is applied) which 
will
add the TB bit flag.

> 
>> +       /*
>> +        * According to the datasheet the BPn bits are non-volatile, 
>> whereas
>> +        * they are volatile for the smaller f25l32qa.
>> +        */
>>         { "f25l64qa", INFO(0x8c4117, 0, 64 * 1024, 128,
>>                            SECT_4K | SPI_NOR_HAS_LOCK) },
> 
> https://datasheetspdf.com/pdf-file/967488/EliteSemiconductor/F25L64QA/1
> BP GENMASK(5, 2), non-volatile.
> 
> BP3?

Same as F25L32QA.

> 
> 
>>  };
>> diff --git a/drivers/mtd/spi-nor/intel.c b/drivers/mtd/spi-nor/intel.c
>> index d8196f101368..c45ea0ad01f0 100644
>> --- a/drivers/mtd/spi-nor/intel.c
>> +++ b/drivers/mtd/spi-nor/intel.c
>> @@ -10,9 +10,9 @@
>> 
>>  static const struct flash_info intel_parts[] = {
>>         /* Intel/Numonyx -- xxxs33b */
>> -       { "160s33b",  INFO(0x898911, 0, 64 * 1024,  32, 0) },
>> -       { "320s33b",  INFO(0x898912, 0, 64 * 1024,  64, 0) },
>> -       { "640s33b",  INFO(0x898913, 0, 64 * 1024, 128, 0) },
>> +       { "160s33b",  INFO(0x898911, 0, 64 * 1024,  32, 
>> SPI_NOR_WP_IS_VOLATILE) },
>> +       { "320s33b",  INFO(0x898912, 0, 64 * 1024,  64, 
>> SPI_NOR_WP_IS_VOLATILE) },
>> +       { "640s33b",  INFO(0x898913, 0, 64 * 1024, 128, 
>> SPI_NOR_WP_IS_VOLATILE) },
> 
> http://www.datasheet.hk/view_download.php?id=1561787&file=0282\qh25f016s33b8_649107.pdf
> BP GENMASK(4,2) all volatile, all set to 1 at power-up.
> 
> You can add SPI_NOR_HAS_LOCK to each flash, and get rid of the 
> manufacturer
> generalization.

ok

> 
>>  };
>> 
>>  static void intel_default_init(struct spi_nor *nor)
>> diff --git a/drivers/mtd/spi-nor/sst.c b/drivers/mtd/spi-nor/sst.c
>> index 8b169fa4102a..5e4450877d66 100644
>> --- a/drivers/mtd/spi-nor/sst.c
>> +++ b/drivers/mtd/spi-nor/sst.c
>> @@ -11,26 +11,27 @@
>>  static const struct flash_info sst_parts[] = {
>>         /* SST -- large erase sizes are "overlays", "sectors" are 4K 
>> */
>>         { "sst25vf040b", INFO(0xbf258d, 0, 64 * 1024,  8,
>> -                             SECT_4K | SST_WRITE | SPI_NOR_HAS_LOCK) 
>> },
>> +                             SECT_4K | SST_WRITE | SPI_NOR_HAS_LOCK | 
>> SPI_NOR_WP_IS_VOLATILE) },
>>         { "sst25vf080b", INFO(0xbf258e, 0, 64 * 1024, 16,
>> -                             SECT_4K | SST_WRITE | SPI_NOR_HAS_LOCK) 
>> },
>> +                             SECT_4K | SST_WRITE | SPI_NOR_HAS_LOCK | 
>> SPI_NOR_WP_IS_VOLATILE) },
>>         { "sst25vf016b", INFO(0xbf2541, 0, 64 * 1024, 32,
>> -                             SECT_4K | SST_WRITE | SPI_NOR_HAS_LOCK) 
>> },
>> +                             SECT_4K | SST_WRITE | SPI_NOR_HAS_LOCK | 
>> SPI_NOR_WP_IS_VOLATILE) },
>>         { "sst25vf032b", INFO(0xbf254a, 0, 64 * 1024, 64,
>> -                             SECT_4K | SST_WRITE | SPI_NOR_HAS_LOCK) 
>> },
>> -       { "sst25vf064c", INFO(0xbf254b, 0, 64 * 1024, 128, SECT_4K | 
>> SPI_NOR_HAS_LOCK) },
>> +                             SECT_4K | SST_WRITE | SPI_NOR_HAS_LOCK | 
>> SPI_NOR_WP_IS_VOLATILE) },
>> +       { "sst25vf064c", INFO(0xbf254b, 0, 64 * 1024, 128,
>> +                             SECT_4K | SPI_NOR_HAS_LOCK | 
>> SPI_NOR_WP_IS_VOLATILE) },
> 
> Looks like BP3 is needed here.

https://ww1.microchip.com/downloads/en/DeviceDoc/20005036C.pdf

agreed. But again cannot test it. Would add it as a seperate patch
to this series. (or leave it like it is)

> 
>>         { "sst25wf512",  INFO(0xbf2501, 0, 64 * 1024,  1,
>> -                             SECT_4K | SST_WRITE | SPI_NOR_HAS_LOCK) 
>> },
>> +                             SECT_4K | SST_WRITE | SPI_NOR_HAS_LOCK | 
>> SPI_NOR_WP_IS_VOLATILE) },
>>         { "sst25wf010",  INFO(0xbf2502, 0, 64 * 1024,  2,
>> -                             SECT_4K | SST_WRITE | SPI_NOR_HAS_LOCK) 
>> },
>> +                             SECT_4K | SST_WRITE | SPI_NOR_HAS_LOCK | 
>> SPI_NOR_WP_IS_VOLATILE) },
>>         { "sst25wf020",  INFO(0xbf2503, 0, 64 * 1024,  4,
>> -                             SECT_4K | SST_WRITE | SPI_NOR_HAS_LOCK) 
>> },
>> +                             SECT_4K | SST_WRITE | SPI_NOR_HAS_LOCK | 
>> SPI_NOR_WP_IS_VOLATILE) },
>>         { "sst25wf020a", INFO(0x621612, 0, 64 * 1024,  4, SECT_4K | 
>> SPI_NOR_HAS_LOCK) },
>>         { "sst25wf040b", INFO(0x621613, 0, 64 * 1024,  8, SECT_4K | 
>> SPI_NOR_HAS_LOCK) },
> 
> These two flashes have just two BP bits located at bit 2 and 3.
> Probably will work.

Mhh? What datasheet were you looking at? There are three BPs:
https://ww1.microchip.com/downloads/en/DeviceDoc/SST25WF040B-4-Mbit-1.8V-SPI-Serial-Flash-Data-Sheet-DS20005193E.pdf

Ahh here are the tables which only inidicate two. But there are three.
https://ww1.microchip.com/downloads/en/DeviceDoc/20005016C.pdf

And yes since the rework of the BP bits algorithm this should work
as expected. Its just because the flash is too small to actually fill
up all the BP bits.

-michael
