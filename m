Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A35B283013
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 07:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbgJEFYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 01:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgJEFYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 01:24:37 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D6AC0613CE;
        Sun,  4 Oct 2020 22:24:37 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id q21so7452815ota.8;
        Sun, 04 Oct 2020 22:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ejxGRfkmTUOKLaIZ5tZldJ09OoKyVEoxXtvhsOSKvS0=;
        b=VJrlunfa2nt0fas3PfzxZWr88ALtMj7jMhCPBhyJvuEgaW3XY9788+arlZRj5seGvb
         uu/LxGH61EaCoEAqnEj2iMw59B4AiLQ/J6stMlph6xuSs2EeRpRuhKwwKOiguTg3ye5/
         PYsqBNChepm+h1sh6WsmIfeV+VWwXkpDbsaOgdNr2muJtMzx3zc8GFFq1XP3IEtAEZ5o
         6RYrxRKdbGr1QGZxIjTCzAMcKqQB2M3mncTJsLSZ2EpVpvqArJkLKK0AL0AC7jL4nj8b
         c6ClOXwAkNu/S8YGkoDrO8IsmBQFKVc8bObJ7wXeK27EjJ9XQO7g3hv021kFmOgxxBJ+
         Sk3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ejxGRfkmTUOKLaIZ5tZldJ09OoKyVEoxXtvhsOSKvS0=;
        b=OklkLABDB35c7mmVLwDo210dMRdyzUg5dMo8fea21a+3iQCLRP1uuqMhuV44wl3b0G
         VAESlp/KOrzi63gyF78zq/I8F549Rn+LA97iQGYP2lGc+Butr+PKogdXcNLVx9aPEz8c
         jmSlvY0aZJw2IpRLHYE6LyYyYtIKvcUAg/OK9NeYvZvN1fkl+snNcyTWBQN5rN6fB40G
         jjKlYq2nhoN3lIFgpwQuxoL6KV3Zw7W5TzOEmPjjVzxoZQD00Qr8DAFsRXjnojEHx34K
         KIKJxi9/9ShtDg93qDVtfCmkxrKnOd6gbWLyoiqPLStpOyj8z3E+0xJbxsxBny6Oh/Yu
         5oFw==
X-Gm-Message-State: AOAM530WumCgPNyUJqo5/WNsmB6kEitMn5B3ZpukKU9OfEPIfJaJI2vG
        XeOPwTm+3aTww3+Q4AtDrl/WDCv2MD4=
X-Google-Smtp-Source: ABdhPJw8J4Av7ZmZtjnUc5lgnpcURWsguVl0sjZ1vZjT/tFZR9GQzg6QkhmTVamFzA0BtUbs/UR+Uw==
X-Received: by 2002:a9d:360b:: with SMTP id w11mr10922131otb.203.1601875476254;
        Sun, 04 Oct 2020 22:24:36 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f26sm2609296otq.50.2020.10.04.22.24.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Oct 2020 22:24:35 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v4 2/2] hwmon: pmbus: max20730: adjust the vout reading
 given voltage divider
To:     Chu Lin <linchuyuan@google.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201004031445.2321090-1-linchuyuan@google.com>
 <20201004031445.2321090-3-linchuyuan@google.com>
 <20201004154345.GA110630@roeck-us.net>
 <CAKCA56AenkTvWrNkLvJSfSC6z0kCcB=YeKA2yX69uLgF+nASbA@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <503521e1-f702-cefd-918a-cca2131272c2@roeck-us.net>
Date:   Sun, 4 Oct 2020 22:24:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAKCA56AenkTvWrNkLvJSfSC6z0kCcB=YeKA2yX69uLgF+nASbA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/20 8:07 PM, Chu Lin wrote:
> On Sun, Oct 4, 2020 at 8:43 AM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On Sun, Oct 04, 2020 at 03:14:45AM +0000, Chu Lin wrote:
>>> Problem:
>>> We use voltage dividers so that the voltage presented at the voltage
>>> sense pins is confusing. We might need to convert these readings to more
>>> meaningful readings given the voltage divider.
>>>
>>> Solution:
>>> Read the voltage divider resistance from dts and convert the voltage
>>> reading to a more meaningful reading.
>>>
>>> Testing:
>>> max20730 with voltage divider
>>>
>>> Signed-off-by: Chu Lin <linchuyuan@google.com>
>>> ---
>>> ChangeLog v1 -> v2
>>>   hwmon: pmbus: max20730:
>>>   - Don't do anything to the ret if an error is returned from pmbus_read_word
>>>   - avoid overflow when doing multiplication
>>>
>>> ChangeLog v2 -> v3
>>>   dt-bindings: hwmon: max20730:
>>>   - Provide the binding documentation in yaml format
>>>   hwmon: pmbus: max20730:
>>>   - No change
>>>
>>> ChangeLog v3 -> v4
>>>   dt-bindings: hwmon: max20730:
>>>   - Fix highefficiency to high efficiency in description
>>>   - Fix presents to present in vout-voltage-divider
>>>   - Add additionalProperties: false
>>>   hwmon: pmbus: max20730:
>>>   - No change
>>
>> You claim that there have been no changes since v2 of this patch,
>> yet you dropped my Reviewed-by: tag. Any reason ?
>>
>> Guenter
> Sorry for the confusion. I thought I can't tag the patch with the Review-by tag.
> Just to make sure I do correctly next time, once you tagged a certain
> patch in the batch
> If there is no change from version to version for this patch, I should
> carry the tags when
> submitting new revisions. Also, please let me know what is the best
> way to fix this revision?
> Should I submit a new V5 with the tag attached?
> 

Actually, if you did not make changes to a patch, you are _expected_
to carry tags forward. In many cases, submitters will even send a new
version of a patch with all new tags included (and no other changes).
This helps reviewers to keep track on what has been reviewed, acked,
or tested in a series. Dropping a tag means that you changed
a patch so substantially that the tag no longer applies (for example,
fixing a spelling error or some formatting does not normally warrant
dropping a tag). If you do drop a tag, you should explain the reason
in the change log.

That is, of course, a honor system that must not be abused
(unfortunately I have seen that abuse happen a couple of times
recently, but that is another story).

No need to re-send in this case - I'll just send another tag
to remind myself that I reviewed this patch.

Guenter

> Sincerely,
> Chu
> 
>>
>>>
>>>  drivers/hwmon/pmbus/max20730.c | 18 ++++++++++++++++++
>>>  1 file changed, 18 insertions(+)
>>>
>>> diff --git a/drivers/hwmon/pmbus/max20730.c b/drivers/hwmon/pmbus/max20730.c
>>> index a151a2b588a5..fbf2f1e6c969 100644
>>> --- a/drivers/hwmon/pmbus/max20730.c
>>> +++ b/drivers/hwmon/pmbus/max20730.c
>>> @@ -31,6 +31,7 @@ struct max20730_data {
>>>       struct pmbus_driver_info info;
>>>       struct mutex lock;      /* Used to protect against parallel writes */
>>>       u16 mfr_devset1;
>>> +     u32 vout_voltage_divider[2];
>>>  };
>>>
>>>  #define to_max20730_data(x)  container_of(x, struct max20730_data, info)
>>> @@ -114,6 +115,14 @@ static int max20730_read_word_data(struct i2c_client *client, int page,
>>>               max_c = max_current[data->id][(data->mfr_devset1 >> 5) & 0x3];
>>>               ret = val_to_direct(max_c, PSC_CURRENT_OUT, info);
>>>               break;
>>> +     case PMBUS_READ_VOUT:
>>> +             ret = pmbus_read_word_data(client, page, phase, reg);
>>> +             if (ret > 0 && data->vout_voltage_divider[0] && data->vout_voltage_divider[1]) {
>>> +                     u64 temp = DIV_ROUND_CLOSEST_ULL((u64)ret * data->vout_voltage_divider[1],
>>> +                                                      data->vout_voltage_divider[0]);
>>> +                     ret = clamp_val(temp, 0, 0xffff);
>>> +             }
>>> +             break;
>>>       default:
>>>               ret = -ENODATA;
>>>               break;
>>> @@ -364,6 +373,15 @@ static int max20730_probe(struct i2c_client *client,
>>>       data->id = chip_id;
>>>       mutex_init(&data->lock);
>>>       memcpy(&data->info, &max20730_info[chip_id], sizeof(data->info));
>>> +     if (of_property_read_u32_array(client->dev.of_node, "vout-voltage-divider",
>>> +                                    data->vout_voltage_divider,
>>> +                                    ARRAY_SIZE(data->vout_voltage_divider)) != 0)
>>> +             memset(data->vout_voltage_divider, 0, sizeof(data->vout_voltage_divider));
>>> +     if (data->vout_voltage_divider[1] < data->vout_voltage_divider[0]) {
>>> +             dev_err(dev,
>>> +                     "The total resistance of voltage divider is less than output resistance\n");
>>> +             return -ENODEV;
>>> +     }
>>>
>>>       ret = i2c_smbus_read_word_data(client, MAX20730_MFR_DEVSET1);
>>>       if (ret < 0)
>>> --
>>> 2.28.0.806.g8561365e88-goog
>>>

