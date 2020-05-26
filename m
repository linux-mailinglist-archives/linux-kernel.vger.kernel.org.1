Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45B0E19F7CD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Apr 2020 16:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbgDFOUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 10:20:40 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36877 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728200AbgDFOUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 10:20:40 -0400
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1jLScB-0005ab-4w; Mon, 06 Apr 2020 16:20:39 +0200
Subject: Re: [PATCH v2] nvmem: core: don't consider subnodes not matching
 binding
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     kernel@pengutronix.de, Christian Eggers <CEggers@arri.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20200323152850.32657-1-a.fatoum@pengutronix.de>
 <d59007d1-f4e3-f550-cecd-64b788a534bc@linaro.org>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <bb0dcf33-f67d-7078-9341-08282d8da217@pengutronix.de>
Date:   Mon, 6 Apr 2020 16:20:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <d59007d1-f4e3-f550-cecd-64b788a534bc@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 4/6/20 2:33 PM, Srinivas Kandagatla wrote:
> 
> 
> On 23/03/2020 15:28, Ahmad Fatoum wrote:
>> The nvmem cell binding applies to objects which match "^.*@[0-9a-f]+$",
>> but so far the driver has matched all objects and failed if they didn't
>> have the expected properties.
>>
>> The driver's behavior in this regard precludes future extension of
>> EEPROMs by child nodes other than nvmem and clashes with the barebox
>> bootloader binding that extends the fixed-partitions MTD binding to
>> EEPROMs as it tries to interpret the "fixed-partitions"-compatible
>> partitions node as a nvmem cell.
>>
>> Solve this issue by skipping all subnodes that don't contain an @.
>>
>> This still allows for cell names like `partitions@0,0', but this
> NACK.. thats nasty hack!
> Its standard practice as per device tree specs to have nodes name as "node-name@unit-address"
> 
> Ref: https://github.com/devicetree-org/devicetree-specification/releases/download/v0.3/devicetree-specification-v0.3.pdf

I didn't say otherwise. I just argued if we verify there's a @ symbol in the
node name, before considering whether it is a NVMEM cell, we will skip fixed-partitions
while adhering to the NVMEM cell binding.

>> is much less likely to cause future collisions.
> 
> There have been discussions on this topic in the past at:
> 
> https://patchwork.ozlabs.org/patch/890741/
> 
> We need to come up with a better solution!

Thanks for the link, I didn't find it when I searched whether this has
come up before.

As you probably noticed, your suggested approach there wouldn't work for me though,
because this time it can't be worked around in the MTD driver.
If the suggestion here is not palatable, how do you think about (in
my preferred order):

- If the cell has a compatible node, it must be "nvmem-cell".
  Otherwise, a cell with a compatible node is skipped.

- Adding a nvmem cell container with a compatible and making support for
  the old binding configurable

- Skipping cells that are malformed and lack a reg = < > property _without_
  error

Cheers
Ahmad

> 
> --srini
> 
>>
>> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
>> ---
>> v1 -> v2:
>>    use ->full_name instead of ->name as to not break existing correct
>>    cells (Christian)
>> ---
>>   drivers/nvmem/core.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
>> index ef326f243f36..f051051fb1a8 100644
>> --- a/drivers/nvmem/core.c
>> +++ b/drivers/nvmem/core.c
>> @@ -278,6 +278,8 @@ static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
>>       parent = dev->of_node;
>>         for_each_child_of_node(parent, child) {
>> +        if (!strchr(kbasename(child->full_name), '@'))
>> +            continue;
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
