Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB0C2E007C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 19:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbgLUSyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 13:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgLUSym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 13:54:42 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C38C0613D6;
        Mon, 21 Dec 2020 10:54:02 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id s75so12293328oih.1;
        Mon, 21 Dec 2020 10:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4jp7QRkp9t9nUV5yJoaxxs7UbfaoT81JLHi6AlSaPrg=;
        b=Q53ubYpPuTIT09V7L1hQHOC5RPYvgkZEx30HUZjf6BRjkR9AgSKCmzCJY/X4ZiU3AE
         whNXRUz5ZNheDcwnYaiWZbZKrg7R3w4HgwNXeeZtgxjO1FUlcte8hM+oPMb6lfR9qhh5
         8CGuJnpYIp2etRASRpU6yxqmMbuOypc0p1tR6Qmc/ohW1GYtc5IOKgLk7FkItowDbkpP
         bkkI8npMsVC4cEGF91wBdcm3yZ5LimwlNombi4Q+QFamc3gioWuP+qZyXeVhA8X5x/Ra
         etIvVof3YPyOSRrnsfwx+L/pt6s3fjKnAa1PsAfaSqfJL+o6nEAWugC1pK9iTxM0Dw1h
         +3gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=4jp7QRkp9t9nUV5yJoaxxs7UbfaoT81JLHi6AlSaPrg=;
        b=TEnmKcqaixyscqgx7kiOZqLu2+2b0zUegkvWkG5598f6A2JrOqRUpfPbrnVjDKO3+E
         d9zNIuBpVJSE2DtOfaWy2w2hwTn/nKXfOm6HgXLCrcATHM8rBr9hCaw9nS/EEYtESXNs
         2Z952kWWpGzwIttU2loY9yosZRTjJ/V4TLtxTj193T7anetPD0H2zwygm3Xj7zUUPFdr
         31uckRdt8ELELCN8y9FhR3CBNSck5vckF1rXSbXj0dX9st0yDgANYiS9ZSUKR2GImMR/
         As8luHUJG3UpfN4yw+wYij5wt9BjUez8na/8qOhguq4qvcbIvWOZoexFGwtRjek0h+le
         o6/w==
X-Gm-Message-State: AOAM533sv/2WQMDFcBcx6UmJCj4f/6OGIpiIoTDG9CgVqyQwR1WXxs8R
        HKs/053SmMNToxicrpN8D/UOshTx2yI=
X-Google-Smtp-Source: ABdhPJzVa7KaXR5PzjaXiYGtDEQWqsBBR7j0Nbmtf51cFmeGMTTJLSG2iq25BnwfUXf5LZnBTtiKsg==
X-Received: by 2002:aca:5d42:: with SMTP id r63mr11951048oib.94.1608576841597;
        Mon, 21 Dec 2020 10:54:01 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t12sm3874774oot.21.2020.12.21.10.53.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Dec 2020 10:54:00 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH 1/2] hwmon: (pmbus) Add a NO_PEC flag to probe chips with
 faulty CAPABILITY
To:     Eddie James <eajames@linux.ibm.com>, linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jdelvare@suse.com, bjwyman@gmail.com
References: <20201221163058.33257-1-eajames@linux.ibm.com>
 <20201221163058.33257-2-eajames@linux.ibm.com>
 <f96ded73-93de-dc7d-36af-7f100e71817a@roeck-us.net>
 <d64b8971e5d14106e3f51fd4f0328762ec35cd7c.camel@linux.ibm.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <7ee04917-d023-8888-9f3f-4303c496f80d@roeck-us.net>
Date:   Mon, 21 Dec 2020 10:53:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d64b8971e5d14106e3f51fd4f0328762ec35cd7c.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/20 10:32 AM, Eddie James wrote:
> On Mon, 2020-12-21 at 08:54 -0800, Guenter Roeck wrote:
>> On 12/21/20 8:30 AM, Eddie James wrote:
>>> Some PMBus chips don't respond with valid data when reading the
>>> CAPABILITY register. For instance the register may report that the
>>> chip supports PEC when in reality it does not. For such chips, PEC
>>> must not be enabled while probing the chip, so add a flag so that
>>> device drivers can force PEC off.
>>>
>>
>> I think the flag should indicate that the capability register
>> shall not be read/used. That the capability register is currently
>> only used to check for PEC is secondary. We might,for example,
>> start using it to check for alert support or to check the numeric
>> format.
> 
> OK, that makes sense. I'll rename the flag in v2, how does
> PMBUS_NO_CAPABILITY sound?
> 

sgtm

Thanks,
Guenter

> Thanks for the quick reply,
> Eddie
> 
>>
>> Thanks,
>> Guenter
>>
>>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>>> ---
>>>  drivers/hwmon/pmbus/pmbus_core.c |  8 +++++---
>>>  include/linux/pmbus.h            | 10 ++++++++++
>>>  2 files changed, 15 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/hwmon/pmbus/pmbus_core.c
>>> b/drivers/hwmon/pmbus/pmbus_core.c
>>> index 192442b3b7a2..3de1657dde35 100644
>>> --- a/drivers/hwmon/pmbus/pmbus_core.c
>>> +++ b/drivers/hwmon/pmbus/pmbus_core.c
>>> @@ -2204,9 +2204,11 @@ static int pmbus_init_common(struct
>>> i2c_client *client, struct pmbus_data *data,
>>>  	}
>>>  
>>>  	/* Enable PEC if the controller supports it */
>>> -	ret = i2c_smbus_read_byte_data(client, PMBUS_CAPABILITY);
>>> -	if (ret >= 0 && (ret & PB_CAPABILITY_ERROR_CHECK))
>>> -		client->flags |= I2C_CLIENT_PEC;
>>> +	if (!(data->flags & PMBUS_NO_PEC)) {
>>> +		ret = i2c_smbus_read_byte_data(client,
>>> PMBUS_CAPABILITY);
>>> +		if (ret >= 0 && (ret & PB_CAPABILITY_ERROR_CHECK))
>>> +			client->flags |= I2C_CLIENT_PEC;
>>> +	}
>>>  
>>>  	/*
>>>  	 * Check if the chip is write protected. If it is, we can not
>>> clear
>>> diff --git a/include/linux/pmbus.h b/include/linux/pmbus.h
>>> index 1ea5bae708a1..9bdc8a581b03 100644
>>> --- a/include/linux/pmbus.h
>>> +++ b/include/linux/pmbus.h
>>> @@ -34,6 +34,16 @@
>>>   */
>>>  #define PMBUS_WRITE_PROTECTED	BIT(1)
>>>  
>>> +/*
>>> + * PMBUS_NO_PEC
>>> + *
>>> + * Some PMBus chips don't respond with valid data when reading the
>>> CAPABILITY
>>> + * register. In this case, the register may report that the chip
>>> supports PEC
>>> + * with bit 7 (PB_CAPABILITY_ERROR_CHECK) when in reality it's not
>>> supported.
>>> + * For such chips, PEC must not be enabled before probing the
>>> chip.
>>> + */
>>> +#define PMBUS_NO_PEC			BIT(2)
>>> +
>>>  struct pmbus_platform_data {
>>>  	u32 flags;		/* Device specific flags */
>>>  
>>>
> 

