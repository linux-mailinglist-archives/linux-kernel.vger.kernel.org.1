Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFF1127FEEB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 14:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732086AbgJAM0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 08:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731888AbgJAM0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 08:26:47 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BB7C0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 05:26:47 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 14FD422F99;
        Thu,  1 Oct 2020 14:26:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1601555204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YlhjVwPQ/MXstwRRmKyPtrXhpk9JTYKjp4oRrLNhj9E=;
        b=SfPB4RzB3yM0xeJVaFKDk7JH9EDC4SLEA1L+yvV0t3Zg63A6JeYnaQTuVK86ZAKB1JNdlY
        LkS1lSlorI+6AQ0yS6TSMvoPUKdgr1tOWJm2CKPk+mC38hDCD97KJzsas1ubs4sEqw7AvK
        zLx5lDp0ulN26usPwuis+pWLEGQTpKs=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 01 Oct 2020 14:26:43 +0200
From:   Michael Walle <michael@walle.cc>
To:     Tudor.Ambarus@microchip.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        vigneshr@ti.com, richard@nod.at, boris.brezillon@collabora.com,
        miquel.raynal@bootlin.com
Subject: Re: [PATCH v3] mtd: spi-nor: keep lock bits if they are non-volatile
In-Reply-To: <2df08e26-b773-9fa5-fd69-6575d3e50f67@microchip.com>
References: <20200327155939.13153-1-michael@walle.cc>
 <e56c5f60-2f59-f913-6eea-3bf8dd4c0774@microchip.com>
 <a82d1ce203383af149ed77c5fd6c8985@walle.cc>
 <bec5b899-fbd2-1c29-611c-654f17e63dbf@microchip.com>
 <8cbaef6c7565deed1109fe958291d9e0@walle.cc>
 <2df08e26-b773-9fa5-fd69-6575d3e50f67@microchip.com>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <8eeb398d9252547adeed5470254a68fb@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tudor,

Am 2020-10-01 13:46, schrieb Tudor.Ambarus@microchip.com:
>> Am 2020-10-01 09:07, schrieb Tudor.Ambarus@microchip.com:
>>>>>> diff --git a/drivers/mtd/spi-nor/core.c 
>>>>>> b/drivers/mtd/spi-nor/core.c
>>>>>> index cc68ea84318e..fd1c36d70a13 100644
>>>>>> --- a/drivers/mtd/spi-nor/core.c
>>>>>> +++ b/drivers/mtd/spi-nor/core.c
>>>>>> @@ -2916,20 +2916,38 @@ static int spi_nor_quad_enable(struct
>>>>>> spi_nor
>>>>>> *nor)
>>>>>>  }
>>>>>> 
>>>>>>  /**
>>>>>> - * spi_nor_unlock_all() - Unlocks the entire flash memory array.
>>>>>> + * spi_nor_global_unprotect() - Perform a global unprotect of the
>>>>>> memory area.
>>>>>>   * @nor:    pointer to a 'struct spi_nor'.
>>>>>>   *
>>>>>>   * Some SPI NOR flashes are write protected by default after a
>>>>>> power-on reset
>>>>>>   * cycle, in order to avoid inadvertent writes during power-up.
>>>>>> Backward
>>>>>>   * compatibility imposes to unlock the entire flash memory array 
>>>>>> at
>>>>>> power-up
>>>>>> - * by default.
>>>>>> + * by default. Do it only for flashes where the block protection
>>>>>> bits
>>>>>> + * are volatile, this is indicated by SNOR_F_NEED_UNPROTECT.
>>>>>> + *
>>>>>> + * We cannot use spi_nor_unlock(nor->params.size) here because
>>>>>> there
>>>>>> are
>>>>>> + * legacy devices (eg. AT25DF041A) which need a "global 
>>>>>> unprotect"
>>>>>> command.
>>>>>> + * This is done by writing 0b0x0000xx to the status register. 
>>>>>> This
>>>>>> will also
>>>>>> + * work for all other flashes which have these bits mapped to BP0
>>>>>> to
>>>>>> BP3.
>>>>>> + * The top most bit is ususally some kind of lock bit for the 
>>>>>> block
>>>>>> + * protection bits.
>>>>>>   */
>>>>>> -static int spi_nor_unlock_all(struct spi_nor *nor)
>>>>>> +static int spi_nor_global_unprotect(struct spi_nor *nor)
>>>>>>  {
>>>>>> -    if (nor->flags & SNOR_F_HAS_LOCK)
>>>>>> -            return spi_nor_unlock(&nor->mtd, 0, 
>>>>>> nor->params->size);
>>>>>> +    int ret;
>>>>>> 
>>>>>> -    return 0;
>>>>>> +    dev_dbg(nor->dev, "unprotecting entire flash\n");
>>>>>> +    ret = spi_nor_read_sr(nor, nor->bouncebuf);
>>>>>> +    if (ret)
>>>>>> +            return ret;
>>>>>> +
>>>>>> +    nor->bouncebuf[0] &= ~SR_GLOBAL_UNPROTECT_MASK;
>>>>>> +
>>>>>> +    /*
>>>>>> +     * Don't use spi_nor_write_sr1_and_check() because writing 
>>>>>> the
>>>>>> status
>>>>>> +     * register might fail if the flash is hardware write
>>>>>> protected.
>>>>>> +     */
>>>>>> +    return spi_nor_write_sr(nor, nor->bouncebuf, 1);
>>>>>>  }
>>>>> 
>>>>> This won't work for all the flashes. You use a GENMASK(5, 2) to 
>>>>> clear
>>>>> the Status Register even for BP0-2 flashes and you end up clearing
>>>>> BIT(5)
>>>>> which can lead to side effects.
>>>>> 
>>>>> We should instead introduce a
>>>>> nor->params->locking_ops->global_unlock()
>>>>> hook
>>>>> for the flashes that have special opcodes that unlock all the flash
>>>>> blocks,
>>>>> or for the flashes that deviate from the "clear just your BP bits"
>>>>> rule.
>>>> 
>>>> Wouldn't it make more sense to just set params->locking_ops for 
>>>> these
>>>> flashes
>>>> to different functions? or even provide a 
>>>> spi_nor_global_unprotect_ops
>>>> in
>>>> core.c and these flashes will just set them. there is no individual
>>>> sector
>>>> range lock for these chips. just a lock all or nothing.
>>> 
>>> I like the idea of having all locking related functions placed in a
>>> single
>>> place, thus the global_unlock() should be inside locking_ops struct.
>> 
>> My point was that this global unlock shouldn't be a special case for 
>> the
>> current spi_nor_unlock() but just another "how to unlock the flash"
>> function
>> and thus should replace the original unlock op. For example, it is 
>> also
>> likely
>> that you need a special global lock (i.e. write all 1's).
>> 
>> static int spi_nor_global_unlock()
>> {
>>   write_sr(0); /* actually it will be a read-modify write */
>> }
>> 
>> static int spi_nor_global_lock()
>> {
>>   write_sr(0x1c);
>> }
>> 
>> static int spi_nor_is_global_locked()
>> {
>>   return read_sr() & 0x1c;
>> }
>> 
>> const struct spi_nor_locking_ops spi_nor_sr_locking_ops = {
>>         .lock = spi_nor_global_unlock,
>>         .unlock = spi_nor_global_lock,
>>         .is_locked = spi_nor_is_global_locked,
>> };
> 
> Meh, this would be valid only if the flash supports _just_ global 
> (un)lock,
> without supporting locking on a smaller granularity.

Most (all?) of these flashes will support the per-sector protection, 
which
we doesn't support. So yes, this is currently a shortcut for the flashes
which were unlocked by default in the past, but doesn't fall into the BP
bits category.

It doesn't feel right to add this as a special case to the current
spi_nor_lock(), which is really a spi_nor_bp_lock(). And this locking
has nothing to do with BP bits. If there would be support for per-sector
protection, then this would end up there. But there isn't.

> Otherwise, people will
> get lazy and just add support for global (unlock) without introducing
> software for smaller granularity locking, which would be a pity.

I can't relate to this. If people need per-sector locking, there will
eventually be code. If people just need a protect all or nothing, well
then.

> If there's such a case, those functions should be manufacturer/flash 
> specific.

Lucky me, this is (at the moment) just Atmel. So is it acceptable,
if I'll put this global unlock ops into atmel.c? I mean eventually, this
will be replaced by proper per-sector locking. It is just there to 
support
the flashes which was already unlocked that way in the past. In terms
of backward compatibility there won't be more flashes which need this
global unlock.

But then this relates to the question how I should name the menuconfig
choices. Because these flashes doesn't have the block protection bits.

-michael
