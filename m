Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19A4A2C867C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 15:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbgK3ORZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 09:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgK3ORY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 09:17:24 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A129C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 06:16:44 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 9501822EDE;
        Mon, 30 Nov 2020 15:16:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1606745802;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mc9pLI7KaYmunkJKO/az4YUmYOWPtXleDysNMdmHYns=;
        b=vf875Nc16yGE6Yw0Xl77YgoC6sIvkgvMSScvFPTwKepO/ZfzFHvlWePWWaF7mjWxRaZl1X
        LivP6SyL7Ncx6iJH1uaBzAGoabgv+GxbQdRDtFV6h3n7e2VlmlmfGXWhHhHnuswF2obdRn
        9Xv2Zt2JAxg2suGPDEsUH7Da6UD8jm4=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 30 Nov 2020 15:16:41 +0100
From:   Michael Walle <michael@walle.cc>
To:     Tudor.Ambarus@microchip.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        boris.brezillon@collabora.com
Subject: Re: [PATCH v6 4/5] mtd: spi-nor: atmel: Fix unlock_all() for
 AT25FS010/040
In-Reply-To: <ba9850c1-a684-6376-7331-2e09567dcb73@microchip.com>
References: <20201126202614.5710-1-michael@walle.cc>
 <20201126202614.5710-5-michael@walle.cc>
 <ba9850c1-a684-6376-7331-2e09567dcb73@microchip.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <a8ce7d3a61d6f7bd988917291e938954@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2020-11-28 09:25, schrieb Tudor.Ambarus@microchip.com:
> On 11/26/20 10:26 PM, Michael Walle wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know 
>> the content is safe
>> 
>> These flashes have some weird BP bits mapping which aren't supported 
>> in
>> the current locking code. Just add a simple unlock op to unprotect the
>> entire flash array which is needed for legacy behavior.
>> 
>> Signed-off-by: Michael Walle <michael@walle.cc>
>> ---
>> changes since v5
>>  - new patch
>> 
>>  drivers/mtd/spi-nor/atmel.c | 53 
>> +++++++++++++++++++++++++++++++++++--
>>  drivers/mtd/spi-nor/core.c  |  2 +-
>>  drivers/mtd/spi-nor/core.h  |  1 +
>>  3 files changed, 53 insertions(+), 3 deletions(-)
>> 
>> diff --git a/drivers/mtd/spi-nor/atmel.c b/drivers/mtd/spi-nor/atmel.c
>> index 49d392c6c8bc..fe6a4653823d 100644
>> --- a/drivers/mtd/spi-nor/atmel.c
>> +++ b/drivers/mtd/spi-nor/atmel.c
>> @@ -8,10 +8,59 @@
>> 
>>  #include "core.h"
>> 
>> +/*
>> + * The Atmel AT25FS010/AT25FS040 parts have some weird configuration 
>> for the
>> + * block protection bits. We don't support them. But legacy behaviour 
>> in linux
>> + * is to unlock the whole flash array on startup. Therefore, we have 
>> to support
>> + * exactly this operation.
>> + */
>> +static int atmel_at25fs_lock(struct spi_nor *nor, loff_t ofs, 
>> uint64_t len)
>> +{
>> +       return -EOPNOTSUPP;
>> +}
>> +
>> +static int atmel_at25fs_unlock(struct spi_nor *nor, loff_t ofs, 
>> uint64_t len)
>> +{
>> +       /* We only support unlocking the whole flash array */
>> +       if (ofs || len != nor->params->size)
>> +               return -EINVAL;
>> +
>> +       /*
>> +        * Write 0x00 to the status register to try to disable the 
>> write
>> +        * protection. This will fail if SRWD (the datasheet calls it 
>> WPEN) is
>> +        * set. But there is nothing we can do.
>> +        */
> 
> can't we do the same as you did in 5/5?

Sure, but - assuming it is only used for the legacy unlock all operation 
- the
outcome will be the same. It will either keep being locked or all will 
be
unlocked.

That being said, I can also change it to the same as the 
global_unprotect().
I don't have any option on that other than this is simpler.

-michael
