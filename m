Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE73127F539
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 00:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731615AbgI3Wiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 18:38:46 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:42203 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbgI3Wiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 18:38:46 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id BD51822EDE;
        Thu,  1 Oct 2020 00:38:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1601505523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dERL4nV7dCj7Ak1q24nlDbwHf/+PRBhMetovVhnlCeY=;
        b=EhcLYYzrnTQbMj0KF43owUjRi6qmpUTlAvIqeWWYBHLjXtsWIwZujZ/wqu+gGZmCn9rot3
        tzsJRMupyHdOCDUC2+a0oA+oyQxUX6LDllDOVpiPb6lOJqINHw1qebFkcG6KHw6ziT2W23
        ZkNDH5u/d0QLRSveHfvCiAhz6ibpvUw=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 01 Oct 2020 00:38:42 +0200
From:   Michael Walle <michael@walle.cc>
To:     Tudor.Ambarus@microchip.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        vigneshr@ti.com, richard@nod.at, boris.brezillon@collabora.com,
        miquel.raynal@bootlin.com
Subject: Re: [PATCH v3] mtd: spi-nor: keep lock bits if they are non-volatile
In-Reply-To: <e56c5f60-2f59-f913-6eea-3bf8dd4c0774@microchip.com>
References: <20200327155939.13153-1-michael@walle.cc>
 <e56c5f60-2f59-f913-6eea-3bf8dd4c0774@microchip.com>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <a82d1ce203383af149ed77c5fd6c8985@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tudor,

>> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
>> index cc68ea84318e..fd1c36d70a13 100644
>> --- a/drivers/mtd/spi-nor/core.c
>> +++ b/drivers/mtd/spi-nor/core.c
>> @@ -2916,20 +2916,38 @@ static int spi_nor_quad_enable(struct spi_nor 
>> *nor)
>>  }
>> 
>>  /**
>> - * spi_nor_unlock_all() - Unlocks the entire flash memory array.
>> + * spi_nor_global_unprotect() - Perform a global unprotect of the 
>> memory area.
>>   * @nor:	pointer to a 'struct spi_nor'.
>>   *
>>   * Some SPI NOR flashes are write protected by default after a 
>> power-on reset
>>   * cycle, in order to avoid inadvertent writes during power-up. 
>> Backward
>>   * compatibility imposes to unlock the entire flash memory array at 
>> power-up
>> - * by default.
>> + * by default. Do it only for flashes where the block protection bits
>> + * are volatile, this is indicated by SNOR_F_NEED_UNPROTECT.
>> + *
>> + * We cannot use spi_nor_unlock(nor->params.size) here because there 
>> are
>> + * legacy devices (eg. AT25DF041A) which need a "global unprotect" 
>> command.
>> + * This is done by writing 0b0x0000xx to the status register. This 
>> will also
>> + * work for all other flashes which have these bits mapped to BP0 to 
>> BP3.
>> + * The top most bit is ususally some kind of lock bit for the block
>> + * protection bits.
>>   */
>> -static int spi_nor_unlock_all(struct spi_nor *nor)
>> +static int spi_nor_global_unprotect(struct spi_nor *nor)
>>  {
>> -	if (nor->flags & SNOR_F_HAS_LOCK)
>> -		return spi_nor_unlock(&nor->mtd, 0, nor->params->size);
>> +	int ret;
>> 
>> -	return 0;
>> +	dev_dbg(nor->dev, "unprotecting entire flash\n");
>> +	ret = spi_nor_read_sr(nor, nor->bouncebuf);
>> +	if (ret)
>> +		return ret;
>> +
>> +	nor->bouncebuf[0] &= ~SR_GLOBAL_UNPROTECT_MASK;
>> +
>> +	/*
>> +	 * Don't use spi_nor_write_sr1_and_check() because writing the 
>> status
>> +	 * register might fail if the flash is hardware write protected.
>> +	 */
>> +	return spi_nor_write_sr(nor, nor->bouncebuf, 1);
>>  }
> 
> This won't work for all the flashes. You use a GENMASK(5, 2) to clear
> the Status Register even for BP0-2 flashes and you end up clearing 
> BIT(5)
> which can lead to side effects.
> 
> We should instead introduce a nor->params->locking_ops->global_unlock() 
> hook
> for the flashes that have special opcodes that unlock all the flash 
> blocks,
> or for the flashes that deviate from the "clear just your BP bits" 
> rule.

Wouldn't it make more sense to just set params->locking_ops for these 
flashes
to different functions? or even provide a spi_nor_global_unprotect_ops 
in
core.c and these flashes will just set them. there is no individual 
sector
range lock for these chips. just a lock all or nothing.

If it is more common and not just one vendor it might also make sense to 
add
a seperate flag which will then set the locking ops to
spi_nor_global_unprotect_ops, also it seems that there have to be two 
writes
to the status register, one to clear SPRL and then one to clear the BP 
bits.
See for example [1] Table 9-2. I'll have to go through the datasheets 
again
to see what flashes just have a global (un)protect.

[1] https://www.adestotech.com/wp-content/uploads/doc3668.pdf

-michael
