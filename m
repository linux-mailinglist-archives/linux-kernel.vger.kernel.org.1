Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A54FC298CF7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 13:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1775332AbgJZMhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 08:37:52 -0400
Received: from mail-qv1-f65.google.com ([209.85.219.65]:44243 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439577AbgJZMhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 08:37:51 -0400
Received: by mail-qv1-f65.google.com with SMTP id s17so4137866qvr.11
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 05:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Nq+7NyNTbAx4Ps20fgi56SMmGvohJC1hDfoq3olgA+Q=;
        b=PxeF3OO9Lioh+HDQIdtsbUJ9Coe+xqm2bkztjkCDflovbRzebmXiJKRQD//D4jTHGV
         xjWzG2lMrc2xz07H8PyzRPAYnwpAZasdmS4CGEtZgKb7nB1ugZB/B5XtdltgmuxXQCQO
         09Xb8uTF/1foJutpAW1l9SsGN7xgDECSH+rahP3vUNO/fAHtxBPSZEjlRATIVBmvNzxK
         Y0oETfXRq9QRrfzYrJVV6FrjkGxjxaD6xNQCmq9zEtbYQdDeBG0EkdHfOt68BOhYcVQv
         VrtKRWNkhCAJSmovwbJoRlcDW9urCZ+cTCKasp+mBNIgj+D/3jsu3gfwfiJ8yEDzjpIw
         /gqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Nq+7NyNTbAx4Ps20fgi56SMmGvohJC1hDfoq3olgA+Q=;
        b=stZRViOGFrX5PpAYgTreZbSKVmTuUn7EUS1nOIiQIoOVygUGEc7beoggLq4gwlGMyO
         exfMAmz6uiL7M/vLLootY/O/W9wtrRpwvkb3iGvoYH/znroEKIN2k0pylSNXoLZIDFGI
         s/1XRNMmEOs28M4EvJ2vAa4NJGdZqr/KnKPdFF11ZwdEUfeKwGztk9EYm09vQ+yKBCwp
         EwG8SfgusFbXFYLp4cnGkVJM4HDUDHRvywGYVNrAFyewVteRf0opyXSz5tov2YAMsw39
         VwfVrcUvtPKtDJ6GGCk9Q7pg0iZX3ol/eaPLYvfH6zbFllQdZMfoIKfkdvcg6GxcFL7h
         Fhjg==
X-Gm-Message-State: AOAM531qVP0T542BaWvcXHmHTaukAoamzwXAK07Nak2uKwW69hbMb2yh
        EWf+ztj8GUEnFxLpwVnjvIGnww==
X-Google-Smtp-Source: ABdhPJyfyt44WwU+Lex5W8E9TDc6IgKk7NzkdnRJJ65NuKJhMSrNDoTVQ9/9KJRkVHA1WkSPhVQbfw==
X-Received: by 2002:a0c:82c4:: with SMTP id i62mr13569400qva.28.1603715868334;
        Mon, 26 Oct 2020 05:37:48 -0700 (PDT)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id v65sm6511846qkb.88.2020.10.26.05.37.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2020 05:37:47 -0700 (PDT)
Subject: Re: [PATCH 10/11] [DEBUG] firmware: arm_scmi: add custom_dummy SCMI
 devname
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
References: <20201014150545.44807-1-cristian.marussi@arm.com>
 <20201014150545.44807-11-cristian.marussi@arm.com>
 <c0a300b7-7589-bfb1-6731-f07fdd7391fd@linaro.org>
 <20201021113505.GD20482@e120937-lin>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <7658875c-ea5f-d231-9514-5021e9d62807@linaro.org>
Date:   Mon, 26 Oct 2020 08:37:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201021113505.GD20482@e120937-lin>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/21/20 7:35 AM, Cristian Marussi wrote:
> On Tue, Oct 20, 2020 at 10:49:23PM -0400, Thara Gopinath wrote:
>>
>>
>> On 10/14/20 11:05 AM, Cristian Marussi wrote:
>>> Add custom_dummy SCMI devname.
>>>
>>> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
>>> ---
>>>    drivers/firmware/arm_scmi/driver.c | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
>>> index 55df134c2338..5c39a738866a 100644
>>> --- a/drivers/firmware/arm_scmi/driver.c
>>> +++ b/drivers/firmware/arm_scmi/driver.c
>>> @@ -993,6 +993,7 @@ static struct scmi_prot_devnames devnames[] = {
>>>    	{ SCMI_PROTOCOL_CLOCK,  { "clocks" },},
>>>    	{ SCMI_PROTOCOL_SENSOR, { "hwmon" },},
>>>    	{ SCMI_PROTOCOL_RESET,  { "reset" },},
>>> +	{ SCMI_PROTOCOL_CUSTOM_DUMMY,  { "custom_dummy" },},
>>
>> Hi Cristian,
>>
>> Thanks for the sample dummy custom protocol and driver!
>> The problem with adding scmi devname into the array is that every time a
>> custom vendor protocol is added, the array has to be extended. Instead since
>> the scmi spec supports the range 0x80-0xff for custom protocols, why not
>> check for that range in scmi_create_protocol_devices and go ahead with
>> registering the creating the protocol device via
>> scmi_create_protocol_device?
>>
> 
> Hi,
> 
> so this is really a good point, and in fact in some earlier (non-public)
> iterations I had a mechanism to just get rid of these device tables,
> thinking that if you want to enable custom protocols loading, it seemed
> better to let the related devices being created dynamically at will, so
> that an SCMI driver can just 'declare' its own device name and that will
> be created if the corresponding protocol is found in the DT and
> implemented in fw.
> 
> Anyway this complicated the code a lot in some dubious ways.
> 
> In a built-in scenario you end up with your driver being probe before the
> platform SCMI driver, so you cannot create the device straight away in
> your driver (there's not even an SCMI bus still) and you anyway need the
> platform SCMI driver to be up and running to check the DT and initialize
> basic transport to talk to the fw and check the protocol is supported by
> fw before creating the device itself: so I ended up basically having the
> SCMI driver just 'requesting' some device name to the core and then having
> the core creating the device later on when the SCMI platform was probed
> iff the DT and the fw supported that protocol (or immediately if your
> driver was a module and the SCMI platform was already initialized)
> 
> All of the above, even if working, led to a lot of machinery to track all
> these requested devices properly and properly create/destroy them, and
> also it does not seem the right thing to do, since it's basically
> mimicing/duplicating all the usual probe deferring standard mechanism.
> 
> Maybe this could have been addressed in different ways but I've not
> explored further.
> 
> So at the end I removed such dynamic device creation support from this
> series.
> 
> Now you proposal would be, if I understood correctly, to just create
> straight away a custom device whenever its protocol is defined in the DT
> and supported by fw, so that the custom driver above would not have to
> declare anything statically, and it will just be associated with some
> "dev_proto_99" matching just on protocol number.
> 
> I'd like this option because it simplifies a lot the above issues, but
> I don't think it is viable because in this way you are no more able to
> define 2 distinct SCMI drivers for the same protocol (like you
> can do now defining multiple names in the match table: as an example you
> could not create a different "custom_dummy_2" SCMI driver using the
> custom protocol 0x99, because there;s only one single "dev_proto_99"
> device created and already probed for "custom_dummy".

Hi,

Apologies for the delay in this reply as it took me a while to figure 
out in the code what is happening around this. So if I understand you 
correctly, the table is required to support multiple drivers (which is 
today 2) for a protocol which in turn means creating devices for these 
drivers. But drivers/firmware/arm_scmi/driver.c is the wrong place to 
define these dev names. Like any other device/driver pair in the kernel 
, why is this info not conveyed from DT ?

It should be fairly straightforward to have scmi_dev_match_id to match 
the device compatible string passed via dt node with a driver  that is 
attached to scmi_bus.

Now, the questions is, is there any existing implementation that 
requires 2 separate devices with 2 separate drivers for a protocol? I am 
using 2 here because MAX_SCMI_DEV_PER_PROTOCOL is defined as 2 today in 
the framework. If not, I will just drop this and just create a device 
for every protocol that gets conveyed from DT. If yes, I will look at 
passing that info from DT either as a compatible string or as a number 
so that you can dynamically build the name when creating device.
The problem with this table is every time anyone wants to support a new 
driver, the table has to be updated. Ideally, framework files should not 
require any modification to support an extension protocol.

> 
> So the problem is again that if you want to support multiple SCMI
> drivers they have to be able to declare their own devname, against which
> the platform SCMI driver can match and initialized if needed the
> underlying device.
> 
> In short, I want certainly to explore the dynamic device creation
> further, but for the moment I put it apart trying to consolidate
> all the rest.
> 
> Maybe I could re-introduce something better later on in future versions
> of this series, or maybe just address this a distinct series later on.
> 
> Sorry for the flood-style email :D

No issues!

> 
> Thanks
> 
> Cristian
> 
>>
>>>    };
>>>    static inline void
>>>
>>
>> -- 
>> Warm Regards
>> Thara

-- 
Warm Regards
Thara
