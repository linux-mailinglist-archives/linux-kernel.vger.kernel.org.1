Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 045B82FA172
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 14:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404613AbhARN05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 08:26:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404561AbhARNZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 08:25:58 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4404DC061575
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 05:25:18 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1l1UWy-0000Re-Lc; Mon, 18 Jan 2021 14:25:16 +0100
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Subject: Re: [PATCH v3 2/2] nvmem: core: skip nodes with compatibles other
 than "nvmem-cell"
To:     Kamel Bouhara <kamel.bouhara@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     kernel@pengutronix.de, ceggers@arri.de,
        linux-kernel@vger.kernel.org
References: <20200428111829.2215-1-a.fatoum@pengutronix.de>
 <20200428111829.2215-3-a.fatoum@pengutronix.de>
 <ee29ed40-a665-2b78-4049-506b718094bf@bootlin.com>
Message-ID: <e806046e-fc53-5a77-46ed-4f668ef2e6e7@pengutronix.de>
Date:   Mon, 18 Jan 2021 14:25:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <ee29ed40-a665-2b78-4049-506b718094bf@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Kamel,

On 30.12.20 14:43, Kamel Bouhara wrote:
> Hi Ahmad,
> 
> On 4/28/20 1:18 PM, Ahmad Fatoum wrote:
>> The nvmem cell binding used to apply to all objects which match
>> "^.*@[0-9a-f]+$", without taking a compatible into account, which
>> precluded extension of EEPROMs by child nodes other than nvmem.
>>
>> A previous commit changed the binding, so that nvmem cells that
>> feature a compatible property must have "nvmem-cell" as the value,
>> otherwise they are skipped.
>>
>> Adjust the driver to observe the new binding change. This change
>> does not change behavior for any device tree that was already
>> compliant with the nvmem binding.
>>
>> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> 
> Tested-by: Kamel Bouhara <kamel.bouhara@bootlin.com>

Thanks for testing. Could you share what use case you have for this?

Rob had objections to this approach:
https://lore.kernel.org/linux-devicetree/20200512141834.GA3023@bogus/

But solving it within a partition doesn't address my original problem:
https://lore.kernel.org/lkml/f03ecee7-c4b6-7a59-7ab8-42c5dfcaffc4@pengutronix.de/

I just sent out a v4, which added you in CC.

Cheers,
Ahmad

> 
>> ---
>>   drivers/nvmem/core.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
>> index 05c6ae4b0b97..eb697f5ad07d 100644
>> --- a/drivers/nvmem/core.c
>> +++ b/drivers/nvmem/core.c
>> @@ -547,6 +547,10 @@ static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
>>       parent = dev->of_node;
>>         for_each_child_of_node(parent, child) {
>> +        if (of_find_property(child, "compatible", NULL) &&
>> +            !of_device_is_compatible(child, "nvmem-cell"))
>> +            continue;
>> +
>>           addr = of_get_property(child, "reg", &len);
>>           if (!addr || (len < 2 * sizeof(u32))) {
>>               dev_err(dev, "nvmem: invalid reg on %pOF\n", child);
>>
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
