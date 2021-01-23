Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78102301551
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 14:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbhAWNFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 08:05:17 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:47251 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbhAWNFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 08:05:14 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id B36A222FB3;
        Sat, 23 Jan 2021 14:04:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1611407064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qfLRrUpC1xu9tbasyiSVT9jQyfPb/fwDXgh3c3C0p0U=;
        b=F+NNlD9MKOQra11Grf6UZUbNgdDoD/lfwt6jBGEt8QQQ7I5wzlaqgbbazL4Fq96nZk+YTU
        RTMtuule+dRmBs4RX8kp6Nimezzftgqdi2g8fnjd5ZHhMmRWhkFRsKvso4/cgY1YPTD4lf
        QdEIcVGeiA4QUXZ01GVLzKRb6Af6zMQ=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 23 Jan 2021 14:04:19 +0100
From:   Michael Walle <michael@walle.cc>
To:     Tudor.Ambarus@microchip.com
Cc:     liew.s.piaw@gmail.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mtd: spi-nor: macronix: enable 4-bit BP support for
 MX25L6405D
In-Reply-To: <93b7f8e8-cdf4-5b09-da17-636d8fcaf0ee@microchip.com>
References: <20201208011938.GB12175@DESKTOP-8REGVGF.localdomain>
 <20201208015730.12351-1-liew.s.piaw@gmail.com>
 <93b7f8e8-cdf4-5b09-da17-636d8fcaf0ee@microchip.com>
User-Agent: Roundcube Webmail/1.4.10
Message-ID: <0fb41db8c9495e2dcca9f2da48670555@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-01-23 13:18, schrieb Tudor.Ambarus@microchip.com:
> Hi, Sieng,
> 
> On 12/8/20 3:57 AM, Sieng Piaw Liew wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know 
>> the content is safe
>> 
>> Enable 4-bit Block Protect support for MX256405D and its variants 
>> using
>> the same ID.
>> 
>> Tested on Innacom W3400V6 router with MX25L6406E chip.

MX25L6406E?

>> https://github.com/openwrt/openwrt/pull/3501
>> 
>> Signed-off-by: Sieng Piaw Liew <liew.s.piaw@gmail.com>
>> ---
>> Changes in v2:
>> - Add SPI_NOR_HAS_LOCK which SPI_NOR_4BIT_BP required.
>> 
>>  drivers/mtd/spi-nor/macronix.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/mtd/spi-nor/macronix.c 
>> b/drivers/mtd/spi-nor/macronix.c
>> index 9203abaac229..033ede381673 100644
>> --- a/drivers/mtd/spi-nor/macronix.c
>> +++ b/drivers/mtd/spi-nor/macronix.c
>> @@ -42,7 +42,9 @@ static const struct flash_info macronix_parts[] = {
>>         { "mx25l1606e",  INFO(0xc22015, 0, 64 * 1024,  32, SECT_4K) },
>>         { "mx25l3205d",  INFO(0xc22016, 0, 64 * 1024,  64, SECT_4K) },
>>         { "mx25l3255e",  INFO(0xc29e16, 0, 64 * 1024,  64, SECT_4K) },
>> -       { "mx25l6405d",  INFO(0xc22017, 0, 64 * 1024, 128, SECT_4K) },
>> +       { "mx25l6405d",  INFO(0xc22017, 0, 64 * 1024, 128,
>> +                             SECT_4K | SPI_NOR_HAS_LOCK |
>> +                             SPI_NOR_4BIT_BP) },
> 
> I've read again the datasheet[1], and to me it looks like we
> don't support the locking scheme for this flash.
> What mx25l6405d calls BP3, we refer to as Top/Bottom support (TB bit).
> The problem that I see is that mx25l6405d uses some kind of twisted
> TB bit.
> 
> For example, for BP3=1, BP2=0, BP1=0, BP0=1, the flash's datasheet
> states that the lower half blocks are protected (0th-63th), while in
> our code we would expect that just the lower first two blocks to be
> protected (0th and 1st). We need new support for this flash.

I double checked that and we don't support this. BP3 is indeed some
kind of TB bit. But not the TB bit which is currently supported. I
guess with the current code, protection scheme can be supported iff
BP3 == 0.

-michael
