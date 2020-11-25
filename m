Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1310F2C4776
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 19:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733065AbgKYSSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 13:18:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730596AbgKYSSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 13:18:01 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9163BC0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 10:18:00 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id A8B4122FEB;
        Wed, 25 Nov 2020 19:17:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1606328278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x0kuIvFihZoeqWGQmI7Xv7pq6wumViJEtZy5++CA2uM=;
        b=u1N93bDHH7F/rYWm4kfztU9JIq39mvMuoIiTh/Ugk463yKAMakfw2vnwTntWbYwC7Xnpjc
        nIo3v39LbH8sF1WZUI3JFmZyrTQed0uYGvnIOove4XZXC1qOTWaY0pSp/Z8uXG+2FAsebY
        lpxP53FK5p84aT4hayKU36nf1BcXaas=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 25 Nov 2020 19:17:57 +0100
From:   Michael Walle <michael@walle.cc>
To:     Tudor.Ambarus@microchip.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        boris.brezillon@collabora.com
Subject: Re: [PATCH v5 1/3] mtd: spi-nor: atmel: remove global protection flag
In-Reply-To: <7b5159c1-5457-b43c-2bf2-1a17ed6df34a@microchip.com>
References: <20201003153235.29762-1-michael@walle.cc>
 <20201003153235.29762-2-michael@walle.cc>
 <7b5159c1-5457-b43c-2bf2-1a17ed6df34a@microchip.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <f9724ff71809557283beb7c8c4d4b356@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2020-11-24 20:09, schrieb Tudor.Ambarus@microchip.com:
> On 10/3/20 6:32 PM, Michael Walle wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know 
>> the content is safe
>> 
>> This is considered bad for the following reasons:
>>  (1) We only support the block protection with BPn bits for write
>>      protection. Not all Atmel parts support this.
>>  (2) Newly added flash chip will automatically inherit the "has
>>      locking" support and thus needs to explicitly tested. Better
>>      be opt-in instead of opt-out.
>>  (3) There are already supported flashes which doesn't support
>>      the locking scheme. So I assume this wasn't properly tested
>>      before adding that chip; which enforces my previous argument
>>      that locking support should be an opt-in.
>> 
>> Remove the global flag and add individual flags to all flashes which
>> supports BP locking. In particular the following flashes don't support
>> the BP scheme:
>>  - AT26F004
>>  - AT25SL321
>>  - AT45DB081D
>> 
>> Please note, that some flashes which are marked as SPI_NOR_HAS_LOCK 
>> just
>> support Global Protection, i.e. not our supported block protection
>> locking scheme. This is to keep backwards compatibility with the
>> current "unlock all at boot" mechanism. In particular the following
>> flashes doesn't have BP bits:
>>  - AT25DF041A
>>  - AT25DF321
>>  - AT25DF321A
>>  - AT25DF641
>>  - AT26DF081A
>>  - AT26DF161A
>>  - AT26DF321
>> 
>> Signed-off-by: Michael Walle <michael@walle.cc>
> 
> Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
>> ---
>> changes since v4:
>>  - none
>> 
>> changes since v3/v2/v1:
>>  - there was no such version because this patch was bundled with 
>> another
>>    patch
>> 
>> changes since RFC:
>>  - mention the flashes which just support the "Global Unprotect" in 
>> the
>>    commit message
>> 
>>  drivers/mtd/spi-nor/atmel.c | 28 +++++++++-------------------
>>  1 file changed, 9 insertions(+), 19 deletions(-)
>> 
>> diff --git a/drivers/mtd/spi-nor/atmel.c b/drivers/mtd/spi-nor/atmel.c
>> index 3f5f21a473a6..49d392c6c8bc 100644
>> --- a/drivers/mtd/spi-nor/atmel.c
>> +++ b/drivers/mtd/spi-nor/atmel.c
>> @@ -10,37 +10,27 @@
>> 
>>  static const struct flash_info atmel_parts[] = {
>>         /* Atmel -- some are (confusingly) marketed as "DataFlash" */
>> -       { "at25fs010",  INFO(0x1f6601, 0, 32 * 1024,   4, SECT_4K) },
>> -       { "at25fs040",  INFO(0x1f6604, 0, 64 * 1024,   8, SECT_4K) },
>> +       { "at25fs010",  INFO(0x1f6601, 0, 32 * 1024,   4, SECT_4K | 
>> SPI_NOR_HAS_LOCK) },
> 
> https://datasheetspdf.com/pdf-file/587164/ATMELCorporation/AT25FS010/1
> BP bits are at bit 2, 3, 5 and 6.
> BP0, BP1, BP3, BP4 and WPEN, are nonvolatile cells
> 
>> +       { "at25fs040",  INFO(0x1f6604, 0, 64 * 1024,   8, SECT_4K | 
>> SPI_NOR_HAS_LOCK) },
> 
> https://datasheetspdf.com/pdf-file/587165/ATMELCorporation/AT25FS040/1
> BP bits are at bit 2, 3, 4, 5, and 6.
> BP0, BP1, BP2, BP3, BP4 are nonvolatile cells
> 
>> 
>> -       { "at25df041a", INFO(0x1f4401, 0, 64 * 1024,   8, SECT_4K) },
>> -       { "at25df321",  INFO(0x1f4700, 0, 64 * 1024,  64, SECT_4K) },
>> -       { "at25df321a", INFO(0x1f4701, 0, 64 * 1024,  64, SECT_4K) },
>> -       { "at25df641",  INFO(0x1f4800, 0, 64 * 1024, 128, SECT_4K) },
>> +       { "at25df041a", INFO(0x1f4401, 0, 64 * 1024,   8, SECT_4K | 
>> SPI_NOR_HAS_LOCK) },
> 
> https://datasheetspdf.com/pdf-file/975331/Adesto/AT25DF041A/1
> Global Protect/Unprotect using Write SR command:
> Global Unlock: write 0x00 to SR
> Global Lock: Read SR. If SR.SPRL is 1 write 0xff to SR, else write 
> 0x7f.

That is not my understanding. Quote:
   To perform a Global Protect, the appropriate WP pin and SPRL
   conditions must be met, and the system must write a logical “1”
   to bits 5, 4, 3, and 2 of the Status Register.

And
   Conversely, to per-form a Global Unprotect, the same WP and SPRL
   conditions must be met but the system must write a logical “0” to
   bits 5, 4, 3, and 2 of the Status Register

Keep in mind that bit 5, 4, 3 and 2 is exactly the
ATMEL_SR_GLOBAL_PROTECT_MASK. The SPRL bit is handled in the unlock()
function. Accoring to table 9.2 you also have to first disable the SPRL
bit and then write the BP bits to zero.

-michael
