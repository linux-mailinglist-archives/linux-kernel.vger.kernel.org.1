Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCA4D2C5C1A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 19:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404578AbgKZSo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 13:44:58 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:56205 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403877AbgKZSo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 13:44:58 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 8F09922FB3;
        Thu, 26 Nov 2020 19:44:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1606416296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F4G3wkfyZh+ZkhkCWeNqDVduF80380aDLmzrc2B9C6Y=;
        b=JqAOtACUBQd/vNEiis8fLuLUGckSv8RLxJjx4vecIMdxJT/Ty3mrcRprE1/28VoZq4H0AU
        JzGXFZ/txkSxTl99uoGgH1mOgHI5eYD1dIbmhkkg9LmLkAqlazY8nx9O4lIHJXqPVkLb2v
        GoPfhaZ/sjp+WadqDoG2JTy9cUsMsYk=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 26 Nov 2020 19:44:53 +0100
From:   Michael Walle <michael@walle.cc>
To:     Tudor.Ambarus@microchip.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        boris.brezillon@collabora.com
Subject: Re: [PATCH v5 1/3] mtd: spi-nor: atmel: remove global protection flag
In-Reply-To: <40cab307-1ef5-92e0-c922-9766f5ddf6d6@microchip.com>
References: <20201003153235.29762-1-michael@walle.cc>
 <20201003153235.29762-2-michael@walle.cc>
 <7b5159c1-5457-b43c-2bf2-1a17ed6df34a@microchip.com>
 <f9724ff71809557283beb7c8c4d4b356@walle.cc>
 <40cab307-1ef5-92e0-c922-9766f5ddf6d6@microchip.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <44ec82d4e287ff1b05bb9f6ded085dc0@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2020-11-26 17:42, schrieb Tudor.Ambarus@microchip.com:
> On 11/25/20 8:17 PM, Michael Walle wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know 
>> the content is safe
>> 
>> Am 2020-11-24 20:09, schrieb Tudor.Ambarus@microchip.com:
>>> On 10/3/20 6:32 PM, Michael Walle wrote:
>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you 
>>>> know
>>>> the content is safe
>>>> 
>>>> This is considered bad for the following reasons:
>>>>  (1) We only support the block protection with BPn bits for write
>>>>      protection. Not all Atmel parts support this.
>>>>  (2) Newly added flash chip will automatically inherit the "has
>>>>      locking" support and thus needs to explicitly tested. Better
>>>>      be opt-in instead of opt-out.
>>>>  (3) There are already supported flashes which doesn't support
>>>>      the locking scheme. So I assume this wasn't properly tested
>>>>      before adding that chip; which enforces my previous argument
>>>>      that locking support should be an opt-in.
>>>> 
>>>> Remove the global flag and add individual flags to all flashes which
>>>> supports BP locking. In particular the following flashes don't 
>>>> support
>>>> the BP scheme:
>>>>  - AT26F004
>>>>  - AT25SL321
>>>>  - AT45DB081D
>>>> 
>>>> Please note, that some flashes which are marked as SPI_NOR_HAS_LOCK
>>>> just
>>>> support Global Protection, i.e. not our supported block protection
>>>> locking scheme. This is to keep backwards compatibility with the
>>>> current "unlock all at boot" mechanism. In particular the following
>>>> flashes doesn't have BP bits:
>>>>  - AT25DF041A
>>>>  - AT25DF321
>>>>  - AT25DF321A
>>>>  - AT25DF641
>>>>  - AT26DF081A
>>>>  - AT26DF161A
>>>>  - AT26DF321
>>>> 
>>>> Signed-off-by: Michael Walle <michael@walle.cc>
>>> 
>>> Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
>>> 
>>>> ---
>>>> changes since v4:
>>>>  - none
>>>> 
>>>> changes since v3/v2/v1:
>>>>  - there was no such version because this patch was bundled with
>>>> another
>>>>    patch
>>>> 
>>>> changes since RFC:
>>>>  - mention the flashes which just support the "Global Unprotect" in
>>>> the
>>>>    commit message
>>>> 
>>>>  drivers/mtd/spi-nor/atmel.c | 28 +++++++++-------------------
>>>>  1 file changed, 9 insertions(+), 19 deletions(-)
>>>> 
>>>> diff --git a/drivers/mtd/spi-nor/atmel.c 
>>>> b/drivers/mtd/spi-nor/atmel.c
>>>> index 3f5f21a473a6..49d392c6c8bc 100644
>>>> --- a/drivers/mtd/spi-nor/atmel.c
>>>> +++ b/drivers/mtd/spi-nor/atmel.c
>>>> @@ -10,37 +10,27 @@
>>>> 
>>>>  static const struct flash_info atmel_parts[] = {
>>>>         /* Atmel -- some are (confusingly) marketed as "DataFlash" 
>>>> */
>>>> -       { "at25fs010",  INFO(0x1f6601, 0, 32 * 1024,   4, SECT_4K) 
>>>> },
>>>> -       { "at25fs040",  INFO(0x1f6604, 0, 64 * 1024,   8, SECT_4K) 
>>>> },
>>>> +       { "at25fs010",  INFO(0x1f6601, 0, 32 * 1024,   4, SECT_4K |
>>>> SPI_NOR_HAS_LOCK) },
>>> 
>>> https://datasheetspdf.com/pdf-file/587164/ATMELCorporation/AT25FS010/1
>>> BP bits are at bit 2, 3, 5 and 6.
>>> BP0, BP1, BP3, BP4 and WPEN, are nonvolatile cells
>>> 
>>>> +       { "at25fs040",  INFO(0x1f6604, 0, 64 * 1024,   8, SECT_4K |
>>>> SPI_NOR_HAS_LOCK) },
>>> 
>>> https://datasheetspdf.com/pdf-file/587165/ATMELCorporation/AT25FS040/1
>>> BP bits are at bit 2, 3, 4, 5, and 6.
>>> BP0, BP1, BP2, BP3, BP4 are nonvolatile cells
>>> 
>>>> 
>>>> -       { "at25df041a", INFO(0x1f4401, 0, 64 * 1024,   8, SECT_4K) 
>>>> },
>>>> -       { "at25df321",  INFO(0x1f4700, 0, 64 * 1024,  64, SECT_4K) 
>>>> },
>>>> -       { "at25df321a", INFO(0x1f4701, 0, 64 * 1024,  64, SECT_4K) 
>>>> },
>>>> -       { "at25df641",  INFO(0x1f4800, 0, 64 * 1024, 128, SECT_4K) 
>>>> },
>>>> +       { "at25df041a", INFO(0x1f4401, 0, 64 * 1024,   8, SECT_4K |
>>>> SPI_NOR_HAS_LOCK) },
>>> 
>>> https://datasheetspdf.com/pdf-file/975331/Adesto/AT25DF041A/1
>>> Global Protect/Unprotect using Write SR command:
>>> Global Unlock: write 0x00 to SR
>>> Global Lock: Read SR. If SR.SPRL is 1 write 0xff to SR, else write
>>> 0x7f.
>> 
>> That is not my understanding. Quote:
>>   To perform a Global Protect, the appropriate WP pin and SPRL
>>   conditions must be met, and the system must write a logical “1”
>>   to bits 5, 4, 3, and 2 of the Status Register.
>> 
>> And
>>   Conversely, to per-form a Global Unprotect, the same WP and SPRL
>>   conditions must be met but the system must write a logical “0” to
>>   bits 5, 4, 3, and 2 of the Status Register
>> 
>> Keep in mind that bit 5, 4, 3 and 2 is exactly the
>> ATMEL_SR_GLOBAL_PROTECT_MASK. The SPRL bit is handled in the unlock()
>> function. Accoring to table 9.2 you also have to first disable the 
>> SPRL
>> bit and then write the BP bits to zero.
>> 
> 
> We took this on irc, I try to summarize the conclusions:
> 1/ for global unlock protect we have to first set SPRL to zero, if not 
> already
> set, then to set the BP bits to zero
> 2/ for global lock protect, SPRL and BP bits should be written in one 
> shot

This is the other way around from the datasheet:
https://www.adestotech.com/wp-content/uploads/doc3668.pdf

   When changing the SPRL bit to a logical “1” from a logical “0”, it
   is also possible to perform a Global Protect or Global Unprotect at
   the same time by writing the appropriate values into bits 5, 4, 3,
   and 2 of the Status Register.

Doing Global Protect and setting SPRL=1 at the same time is also 
possible,
see Table 9-2. That is pretty clear.

Therefore, we could do both lock and unlock in one step. But one thing I
didn't consider is that it may be possible that clearing will fail if 
WP#
is asserted. The current patch will check that and report an error. I'd
like to keep that.

> 3/ consider WP#: set SPRL to 1 when something is locked, set it to zero
> if nothing is locked.

Ack. This follows the behavior of the current locking mechanism for 
flashes
with BP bits.

> 4/ at25fs010 and at25fs040 have a BPn mechanism that uses BP4, similar 
> to
> what we have in spi_nor_sr_locking_ops(). We decided that it doesn't 
> worth
> to pollute the core function just for these flashes, they will have 
> their
> own fixup hook. We can't use the hook introduced in 3/3 because those
> flashes are using "individual sector protection", and even if the
> "global protect/unprotect feature" is close to writing a 0x0 to SR,
> eventually the "individual sector protection" locking mechanism should 
> be
> extended to also support individual sector locking.

Ack

-michael
