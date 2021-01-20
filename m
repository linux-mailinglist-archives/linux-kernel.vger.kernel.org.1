Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD192FD38E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 16:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390381AbhATPKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 10:10:25 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:54537 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390855AbhATPC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 10:02:57 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 714C622727;
        Wed, 20 Jan 2021 16:02:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1611154925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sUHuaCPz16VMa7CYH8WbEw6Xdv8BgjZHYjL6590ZBPc=;
        b=uheoepFQtsTTigNWCwM48rCQ2vQd7kXwLLUWWEAbcWX0dujmbKPuCDvw0EPLqiG2FG5eNe
        Xi9jnS/JNKVvt9Knkf+e2CxjLqYd/q6j5+P1ISsc/Cy5Q4P2nX3xTK1v5C8iLW9XARHeKQ
        upEs8IEhrxDY2E3FDw2bHDIvyrL2y3Q=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 20 Jan 2021 16:02:05 +0100
From:   Michael Walle <michael@walle.cc>
To:     Tudor.Ambarus@microchip.com
Cc:     vigneshr@ti.com, p.yadav@ti.com, miquel.raynal@bootlin.com,
        richard@nod.at, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, Kavyasree.Kotagiri@microchip.com
Subject: Re: [PATCH v2 2/2] mtd: spi-nor: sst: Add support for Global Unlock
 on sst26vf
In-Reply-To: <ad0cc416-73b7-f626-115f-d192fac17957@microchip.com>
References: <20210120131914.277363-1-tudor.ambarus@microchip.com>
 <20210120131914.277363-2-tudor.ambarus@microchip.com>
 <b3a61abec8927c7229c27415d2c769a8@walle.cc>
 <ad0cc416-73b7-f626-115f-d192fac17957@microchip.com>
User-Agent: Roundcube Webmail/1.4.10
Message-ID: <447aca9c61a45b05f7869b9747e2c301@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-01-20 15:52, schrieb Tudor.Ambarus@microchip.com:
> On 1/20/21 4:05 PM, Michael Walle wrote:
>>> diff --git a/drivers/mtd/spi-nor/sst.c b/drivers/mtd/spi-nor/sst.c
>>> index 00e48da0744a..d6e1396abb96 100644
>>> --- a/drivers/mtd/spi-nor/sst.c
>>> +++ b/drivers/mtd/spi-nor/sst.c
>>> @@ -8,6 +8,39 @@
>>> 
>>>  #include "core.h"
>>> 
>>> +static int sst26vf_lock(struct spi_nor *nor, loff_t ofs, uint64_t 
>>> len)
>>> +{
>>> +     return -EOPNOTSUPP;
>>> +}
>>> +
>>> +static int sst26vf_unlock(struct spi_nor *nor, loff_t ofs, uint64_t
>>> len)
>>> +{
>>> +     if (ofs == 0 && len == nor->params->size)
>>> +             return spi_nor_global_block_unlock(nor);
>> 
>> 
>> Some blocks might not be unlocked because they are permanently
>> locked. Does it make sense to read BPNV of the control register
>> and add a debug message here?
> 
> It would, yes. If any block is permanently locked in the unlock_all 
> case,
> I'll just print a dbg message and return -EINVAL. Sounds good?

spi_nor_sr_unlock(), atmel_at25fs_unlock() and atmel_global_unprotect()
will return -EIO in case the SR wasn't writable.

-michael
