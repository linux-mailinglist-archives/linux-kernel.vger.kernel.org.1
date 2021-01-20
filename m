Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 704652FD683
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 18:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391013AbhATRHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 12:07:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391054AbhATPuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 10:50:03 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D0EC0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 07:49:23 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 2A3D022727;
        Wed, 20 Jan 2021 16:49:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1611157761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mUzrNzLNRcIreZmsLWq69k96pnmltY8SD1QI1C8Xvtc=;
        b=L5pQvWqhEA+gLO4h7w/qbBgpTvDHeGlyG6fzjNFNthQiS4SuUVhd987+sn7ePNgqYGZM4y
        jI7Cco9UbSUoHU1Jg7ygI/FOs3VSTIpAj2WiVGZbAgerBBFYTFLcJnPU25j1m9UweQYQ5K
        Nchsvs9cGuSTWwUZJwoFXYl2wSaiclo=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 20 Jan 2021 16:49:21 +0100
From:   Michael Walle <michael@walle.cc>
To:     Tudor.Ambarus@microchip.com
Cc:     vigneshr@ti.com, p.yadav@ti.com, miquel.raynal@bootlin.com,
        richard@nod.at, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, Kavyasree.Kotagiri@microchip.com
Subject: Re: [PATCH v2 2/2] mtd: spi-nor: sst: Add support for Global Unlock
 on sst26vf
In-Reply-To: <8a0e7885-4b9e-be62-eb46-1af74c65afa8@microchip.com>
References: <20210120131914.277363-1-tudor.ambarus@microchip.com>
 <20210120131914.277363-2-tudor.ambarus@microchip.com>
 <b3a61abec8927c7229c27415d2c769a8@walle.cc>
 <ad0cc416-73b7-f626-115f-d192fac17957@microchip.com>
 <447aca9c61a45b05f7869b9747e2c301@walle.cc>
 <8a0e7885-4b9e-be62-eb46-1af74c65afa8@microchip.com>
User-Agent: Roundcube Webmail/1.4.10
Message-ID: <e1e5f647fd9e91538fd730c626beff52@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-01-20 16:39, schrieb Tudor.Ambarus@microchip.com:
> On 1/20/21 5:02 PM, Michael Walle wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know 
>> the content is safe
>> 
>> Am 2021-01-20 15:52, schrieb Tudor.Ambarus@microchip.com:
>>> On 1/20/21 4:05 PM, Michael Walle wrote:
>>>>> diff --git a/drivers/mtd/spi-nor/sst.c b/drivers/mtd/spi-nor/sst.c
>>>>> index 00e48da0744a..d6e1396abb96 100644
>>>>> --- a/drivers/mtd/spi-nor/sst.c
>>>>> +++ b/drivers/mtd/spi-nor/sst.c
>>>>> @@ -8,6 +8,39 @@
>>>>> 
>>>>>  #include "core.h"
>>>>> 
>>>>> +static int sst26vf_lock(struct spi_nor *nor, loff_t ofs, uint64_t
>>>>> len)
>>>>> +{
>>>>> +     return -EOPNOTSUPP;
>>>>> +}
>>>>> +
>>>>> +static int sst26vf_unlock(struct spi_nor *nor, loff_t ofs, 
>>>>> uint64_t
>>>>> len)
>>>>> +{
>>>>> +     if (ofs == 0 && len == nor->params->size)
>>>>> +             return spi_nor_global_block_unlock(nor);
>>>> 
>>>> 
>>>> Some blocks might not be unlocked because they are permanently
>>>> locked. Does it make sense to read BPNV of the control register
>>>> and add a debug message here?
>>> 
>>> It would, yes. If any block is permanently locked in the unlock_all
>>> case,
>>> I'll just print a dbg message and return -EINVAL. Sounds good?
>> 
>> spi_nor_sr_unlock(), atmel_at25fs_unlock() and 
>> atmel_global_unprotect()
>> will return -EIO in case the SR wasn't writable.
> 
> You mean in the spi_nor_write_sr_and_check() calls. -EIO is fine
> there if what we wrote is different than what we read back, it would
> indicate an IO error.
> 
> GBULK command clears all the write-protection bits in the Block
> Protection register, except for those bits that have been permanently
> locked down. So even if we have few blocks permanently locked, i.e.
> CR.BPNV == 1, the GBULK can clear the protection for the remaining
> blocks. So not really an IO error, but rather an -EINVAL, because
> the user asks to unlock more than we can.

Doesn't EINVAL indicate wrong parameters, but does nothing? In this
case, unlock would be partially successful.

In any case, my point was that depending on the underlying locking
ops, either -EIO or -EINVAL is returned if spi_nor_unlock() fails
for the same reason, that is unlock() wasn't possible because of
some sort of hardware write protection. And IMHO it should return
the same errno (whatever the correct errno is in this case).

-michael
