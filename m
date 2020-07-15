Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E71072215D5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 22:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgGOULm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 16:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbgGOULm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 16:11:42 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F54C061755;
        Wed, 15 Jul 2020 13:11:41 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id m9so2585277pfh.0;
        Wed, 15 Jul 2020 13:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QEte5yNsE5y2ncLAdypHTajLLlG57RU7vNQUHh2/tfg=;
        b=NVhrjMJ0PTz5g+43Zyve8FkaddgwKmjfyk0jNoBOBD+l0kGxBKu93bBF4wWskDPidO
         zemXB1/T8qeWdgC/81R1XQ8u4lNy2mygQIr0qailVfzOaIiqnKA0Lgr+lqPy8bypbPNH
         OXxEAbsawoOZulPrig0VgGykA7bV8D5PL0Apl6BV6FYwjobafSwP2R0O5tklAKBp7z/G
         +VymKldm6Izfynw2lkLbAIecT207aZuiS3Qj3il1GscU5sVg/4XpEaudEO1AX8WDTxiN
         7viemEOvxIM9/+SjsgWe10+mKkTP/Ezx8GICvJcuIODdl2DxEJY3HIZawOACRu5C3FYt
         v+IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=QEte5yNsE5y2ncLAdypHTajLLlG57RU7vNQUHh2/tfg=;
        b=nWsuAXa44yAJvr3HV7XHZWb8KHwvHC3daNTIaNdXoT53WUh34TonGD/6223+y6gyvB
         CL/YilZ3DaQtv6MKqVo/XHZ3VrtWDU8XZ/evWPOH8uhLgnyxUhMy0vD9hrbouEwpFdpq
         CzM4/M+9OZ8Hn85EaCVvyujIbmGwCJbyoRki3J81TSIYiSawJFQMCAqLT9eJSeuau8bT
         WBNYyBSbhxsl+ncaFEZ5sdHr4lw1nZjVJY+c75g8YjjcEytuWJrJOhm+JB7iruYxMYTW
         A+HddmyEDr75sCdJgjVYufwNxxPufsFwyXJrKkjqt6J2Xf2gCqoGq3ttfs6ZH1lNPnpO
         Jlig==
X-Gm-Message-State: AOAM531sdbDqDHI0OSrhfJGIR06oEu5DBo2kGFmqUTvg4iyjimxSKRzr
        9oHzmAStXa1HgMTNxJ1t8Ky30iDk
X-Google-Smtp-Source: ABdhPJxCT3hnx6APT+vymIOBE6vxgy8J36a6MXuZANkE0mtY2X6k4nIrqiigu5ihwziYur9can2qHA==
X-Received: by 2002:a63:5509:: with SMTP id j9mr1201398pgb.195.1594843901313;
        Wed, 15 Jul 2020 13:11:41 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u66sm2775232pfb.191.2020.07.15.13.11.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2020 13:11:40 -0700 (PDT)
Subject: Re: [PATCH v2] hwmon: corsair-cpro: Change to HID driver
To:     Marius Zachmann <mail@mariuszachmann.de>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200715151419.43134-1-mail@mariuszachmann.de>
 <51449356.7lugSRDzgr@marius>
 <9fc09eec-7921-68ab-b3c7-1d83d3e09817@roeck-us.net>
 <3864498.z6qT3ff8q6@marius>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <7a45a7ac-ef4d-b9c8-fac7-6c226baf1329@roeck-us.net>
Date:   Wed, 15 Jul 2020 13:11:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <3864498.z6qT3ff8q6@marius>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/15/20 12:55 PM, Marius Zachmann wrote:
> On 15.07.20 at 21:49:59 CEST, Guenter Roeck wrote
>> On 7/15/20 12:12 PM, Marius Zachmann wrote:
>>> On 15.07.20 at 17:35:08 CEST, Guenter Roeck wrote
>>>> On 7/15/20 8:14 AM, Marius Zachmann wrote:
>>>>> This changes corsair-cpro to a hid driver using hid reports.
>>>>>
>>>>> Signed-off-by: Marius Zachmann <mail@mariuszachmann.de>
>>>>>
>>>>> ---
>>>>
>>> ...
>>>>> -module_usb_driver(ccp_driver);
>>>>> +static int __init ccp_init(void)
>>>>> +{
>>>>> +	return hid_register_driver(&ccp_driver);
>>>>> +}
>>>>> +
>>>>> +static void __exit ccp_exit(void)
>>>>> +{
>>>>> +	hid_unregister_driver(&ccp_driver);
>>>>> +}
>>>>> +
>>>>> +/* make sure it is loaded after hid */
>>>>> +late_initcall(ccp_init);
>>>>> +module_exit(ccp_exit);
>>>>
>>>> Sorry for not noticing before, but can you use module_hid_driver() ?
>>>> That seems to work for other hid drivers.
>>>>
>>>> Thanks,
>>>> Guenter
>>>>
>>>
>>> When using module_hid_driver() and compiling the driver as built-in
>>> the driver init function will get called before hid and fail registering
>>> the driver. late_initcall forces it to be loaded after hid.
>>>
>>
>> That seems odd. Why does no other hid driver have that problem ?
>> Your argument is pretty much that module_hid_driver() would not work,
>> which seems unlikely.
>>
>> Thanks,
>> Guenter
>>
> 
> The order of initcalls is determined by the build order. Hwmon subsystem
> gets build before hid subsystem and therefore the initcalls are earlier
> than hid. But hid_register_driver needs the hid driver to be there.
> 
Hmm. I am not happy, but I guess we'll have to live with it.

Can you add the detailed explanation to the comment above ?
"make sure it is loaded after hid" doesn't tell the whole story,
and I want to avoid having to deal with "cleanup" patches later.

Alternatively, I wonder if it would make sense to force
this driver to be built as module. Have you thought about that ?

Thanks,
Guenter
