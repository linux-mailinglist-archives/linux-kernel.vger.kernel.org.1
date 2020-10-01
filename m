Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7FF2800F3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 16:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732357AbgJAOMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 10:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732104AbgJAOMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 10:12:46 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6E2C0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 07:12:46 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id ADE9122F99;
        Thu,  1 Oct 2020 16:12:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1601561563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qodIbGrXANDGKnUR1bw4HfdmzWfDoTXlWQOLVl/G1lM=;
        b=QCCMutQGnM/MkO/M2OBM5f6bbV86/EX5KZ5MaZqcbaOXLrkdQ2xPqKrqlY39tEKWA+edUz
        Kn5Y8Ap/5Iz0xg0+OddlEJyArziOBzbD5Gqb2utnXvDdpYOo1QItT8TMuq5Is2XztB3aCL
        ZamsV+YtiKoOUKZY5VTOH6slwNmKKAg=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 01 Oct 2020 16:12:43 +0200
From:   Michael Walle <michael@walle.cc>
To:     Tudor.Ambarus@microchip.com
Cc:     linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Subject: Re: [RFC PATCH 1/2] mtd: spi-nor: atmel: remove global
 SNOR_F_HAS_LOCK
In-Reply-To: <5eb8f95c-e9d5-6043-fb7d-bffcda044262@microchip.com>
References: <20201001122828.23186-1-michael@walle.cc>
 <5eb8f95c-e9d5-6043-fb7d-bffcda044262@microchip.com>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <871da0d058ba89320615098ee26150b3@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2020-10-01 16:06, schrieb Tudor.Ambarus@microchip.com:
> On 10/1/20 3:28 PM, Michael Walle wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know 
>> the content is safe
>> 
>> This is considered bad for the following reasons:
>>  (1) We only support the block protection with BPn bits for write
>>      protection. Not all Atmel parts support this.
>>  (2) Newly added flash chip will automatically inherit the "has
>>      locking" support and thus needs to explicitly tested. Better
>>      be opt-in instead of opt-out.
>>  (3) There are already supported flashes which don't support the 
>> locking
>>          scheme. So I assume this wasn't properly tested before adding 
>> that
>>          chip; which enforces my previous argument that locking 
>> support should
>>          be an opt-in.
>> 
>> Remove the global flag and add individual flags to all flashes
>> which supports BP locking. In particular the following flashes
>> don't support the BP scheme:
>>  - AT26F004
>>  - AT25SL321
>>  - AT45DB081D
>> 
>> Signed-off-by: Michael Walle <michael@walle.cc>
>> ---
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
>> +       { "at25fs040",  INFO(0x1f6604, 0, 64 * 1024,   8, SECT_4K | 
>> SPI_NOR_HAS_LOCK) },
> 
> after a quick look in the datasheets of these flashes, I suspect that
> what we have now in the SPI NOR core for SR locking does not work for
> them. They probably supported just "unlock all", clearing all the
> BP bits. Anyway, different problem.
>> 
>> -       { "at25df041a", INFO(0x1f4401, 0, 64 * 1024,   8, SECT_4K) },
>> -       { "at25df321",  INFO(0x1f4700, 0, 64 * 1024,  64, SECT_4K) },
>> -       { "at25df321a", INFO(0x1f4701, 0, 64 * 1024,  64, SECT_4K) },
>> -       { "at25df641",  INFO(0x1f4800, 0, 64 * 1024, 128, SECT_4K) },
>> +       { "at25df041a", INFO(0x1f4401, 0, 64 * 1024,   8, SECT_4K | 
>> SPI_NOR_HAS_LOCK) },
> 
> this one does not support BP locking:
> https://www.adestotech.com/wp-content/uploads/doc3668.pdf
> 
>> +       { "at25df321",  INFO(0x1f4700, 0, 64 * 1024,  64, SECT_4K | 
>> SPI_NOR_HAS_LOCK) },
> 
> neither this one:
> https://datasheet.octopart.com/AT25DF321-S3U-Atmel-datasheet-8700896.pdf
> 
>> +       { "at25df321a", INFO(0x1f4701, 0, 64 * 1024,  64, SECT_4K | 
>> SPI_NOR_HAS_LOCK) },
> 
> nor this one: https://www.adestotech.com/wp-content/uploads/doc3686.pdf
> 
>> +       { "at25df641",  INFO(0x1f4800, 0, 64 * 1024, 128, SECT_4K | 
>> SPI_NOR_HAS_LOCK) },
> 
> nor this one: https://www.adestotech.com/wp-content/uploads/doc3680.pdf
> 
> I stop here.

These are all the ones which use the global unlock. I cannot just skip
the HAS_LOCK bit here, because otherwise this patch wouldn't be 
backwards
compatibe. Yes I missed that in the commit log, my bad.

-michael
