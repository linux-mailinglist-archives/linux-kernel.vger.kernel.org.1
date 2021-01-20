Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 686982FD601
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 17:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391549AbhATQtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 11:49:20 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:42537 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391659AbhATQsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 11:48:09 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id D72EE22727;
        Wed, 20 Jan 2021 17:47:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1611161246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u4wx+DAuNXnn48tFtGcIcB1I4EME04LspQ3CfIceYDY=;
        b=dHh95gnl5GLBDRo3Z5fa/8fhWWMxqKQ89fCrkyEnESYB2/l7R23AGYxeaHB4Fyt9XhiSGU
        NhMkKiLgTBnyXQfJF2+TA3xKMi4gEeK9HBrH+mjnyEjhDxFQAS2PmScyf74BUThpFFIrfB
        3NgdV7M9kUOikDrNuwFbYbPX/+JFLBw=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 20 Jan 2021 17:47:25 +0100
From:   Michael Walle <michael@walle.cc>
To:     Tudor.Ambarus@microchip.com
Cc:     vigneshr@ti.com, p.yadav@ti.com, miquel.raynal@bootlin.com,
        richard@nod.at, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, Kavyasree.Kotagiri@microchip.com
Subject: Re: [PATCH v2 2/2] mtd: spi-nor: sst: Add support for Global Unlock
 on sst26vf
In-Reply-To: <6c4adaa7-9397-2373-16aa-a3dd2775c63f@microchip.com>
References: <20210120131914.277363-1-tudor.ambarus@microchip.com>
 <20210120131914.277363-2-tudor.ambarus@microchip.com>
 <b3a61abec8927c7229c27415d2c769a8@walle.cc>
 <ad0cc416-73b7-f626-115f-d192fac17957@microchip.com>
 <447aca9c61a45b05f7869b9747e2c301@walle.cc>
 <8a0e7885-4b9e-be62-eb46-1af74c65afa8@microchip.com>
 <e1e5f647fd9e91538fd730c626beff52@walle.cc>
 <6c4adaa7-9397-2373-16aa-a3dd2775c63f@microchip.com>
User-Agent: Roundcube Webmail/1.4.10
Message-ID: <c62393288e9d82b08d14d74a9a8389ad@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-01-20 17:25, schrieb Tudor.Ambarus@microchip.com:
> On 1/20/21 5:49 PM, Michael Walle wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know 
>> the content is safe
>> 
>> Am 2021-01-20 16:39, schrieb Tudor.Ambarus@microchip.com:
>>> On 1/20/21 5:02 PM, Michael Walle wrote:
>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you 
>>>> know
>>>> the content is safe
>>>> 
>>>> Am 2021-01-20 15:52, schrieb Tudor.Ambarus@microchip.com:
>>>>> On 1/20/21 4:05 PM, Michael Walle wrote:
>>>>>>> diff --git a/drivers/mtd/spi-nor/sst.c 
>>>>>>> b/drivers/mtd/spi-nor/sst.c
>>>>>>> index 00e48da0744a..d6e1396abb96 100644
>>>>>>> --- a/drivers/mtd/spi-nor/sst.c
>>>>>>> +++ b/drivers/mtd/spi-nor/sst.c
>>>>>>> @@ -8,6 +8,39 @@
>>>>>>> 
>>>>>>>  #include "core.h"
>>>>>>> 
>>>>>>> +static int sst26vf_lock(struct spi_nor *nor, loff_t ofs, 
>>>>>>> uint64_t
>>>>>>> len)
>>>>>>> +{
>>>>>>> +     return -EOPNOTSUPP;
>>>>>>> +}
>>>>>>> +
>>>>>>> +static int sst26vf_unlock(struct spi_nor *nor, loff_t ofs,
>>>>>>> uint64_t
>>>>>>> len)
>>>>>>> +{
>>>>>>> +     if (ofs == 0 && len == nor->params->size)
>>>>>>> +             return spi_nor_global_block_unlock(nor);
>>>>>> 
>>>>>> 
>>>>>> Some blocks might not be unlocked because they are permanently
>>>>>> locked. Does it make sense to read BPNV of the control register
>>>>>> and add a debug message here?
>>>>> 
>>>>> It would, yes. If any block is permanently locked in the unlock_all
>>>>> case,
>>>>> I'll just print a dbg message and return -EINVAL. Sounds good?
>>>> 
>>>> spi_nor_sr_unlock(), atmel_at25fs_unlock() and
>>>> atmel_global_unprotect()
>>>> will return -EIO in case the SR wasn't writable.
>>> 
>>> You mean in the spi_nor_write_sr_and_check() calls. -EIO is fine
>>> there if what we wrote is different than what we read back, it would
>>> indicate an IO error.
>>> 
>>> GBULK command clears all the write-protection bits in the Block
>>> Protection register, except for those bits that have been permanently
>>> locked down. So even if we have few blocks permanently locked, i.e.
>>> CR.BPNV == 1, the GBULK can clear the protection for the remaining
>>> blocks. So not really an IO error, but rather an -EINVAL, because
>>> the user asks to unlock more than we can.
>> 
>> Doesn't EINVAL indicate wrong parameters, but does nothing? In this
>> case, unlock would be partially successful.
>> 
> yes, that's what I said I'll do: "If any block is permanently locked
> in the unlock_all case, I'll just print a dbg message and return 
> -EINVAL",
> without sending a GBULK cmd. Caller wrongly asks to unlock all, when we
> can just unlock partial memory.

Doh, I've missed that you will do it beforehand. Yes then EINVAL
is fine by me.

But you won't unlock the flash during startup (given the config option
is enabled) if any blocks has been permanently locked. Thus if just the
topmost 4k block is permanently locked down, the whole flash wouldn't be
writable, right?. I don't have a strong opinion on that.

-michael

> 
> It's similar to what is at:
> https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git/tree/drivers/mtd/spi-nor/core.c?h=spi-nor/next#n1946
> 
>> In any case, my point was that depending on the underlying locking
>> ops, either -EIO or -EINVAL is returned if spi_nor_unlock() fails
>> for the same reason, that is unlock() wasn't possible because of
>> some sort of hardware write protection. And IMHO it should return
>> the same errno (whatever the correct errno is in this case).
>> 
> 
> But the reasons are different: 1/caller wrongly asks to unlock
> more than we can, thus -EINVAL 2/ -EIO when we don't read what
> we expect to read.

-michael
