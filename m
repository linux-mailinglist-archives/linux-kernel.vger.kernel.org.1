Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D52C2277854
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 20:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbgIXSPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 14:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbgIXSPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 14:15:16 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F27C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 11:15:16 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id e22so4330055edq.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 11:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OaXLD8QbuaycYNHzCawUu8+MoAplmNgO4X/Bg2jsZ9A=;
        b=vFghIhBxr0gqp1683Dad+nNv4fvmuJPctkBwURPXYF7sOpmQ7DXtLSumsfjZ5oI4s8
         JoPdwGYs1F08uIF2gUrodOg47NYjoWHzjpXiPm32tE2DxW6uTmGn06pU76bYC188LST2
         iUbP8rc50m5EfHv08KMxKrSUd5y6BATKa8oblIYMRYRZdBHMvTg0/86ACEbN7oUHEU2Z
         V+UM0LQpzJSST/+KIv09+ylAnNHP5R6rpmipZHUlXqdYlG+dKK2IZSUjZzIALQ0yz0n+
         nR3Ifaao3iVRBRpVpaKI76NEc2eCveeAKWO/f00dUul3vy/GEqUg3pLdD3N1IdcNgsSr
         dEqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OaXLD8QbuaycYNHzCawUu8+MoAplmNgO4X/Bg2jsZ9A=;
        b=UCY+0+QtumLtncsAyHe2KSlDRiUeXxOAAqtysbStBUg2yv/6sygOOhTkHuaNeKpypn
         zhEYn9NhhXSqBBR3wER1rl1APFQTGSxI1OWrQiI0Dp24Z9eHOpvTbbW3WsrEzaEjDiiz
         jduWFGTLfaFoQWEq+KBHGqFZRBmmnUjVfOlR4cVeW7smsuF5/o3U2UlPoQ1D87TnngTM
         xz0D2mld/kDd7nSEGO3kp3xyYjkVN5u7DOWzuPwUIeRYPoza3UpBaYNpQd6beiey4Rv0
         yt0kEoW3gDtXK/osOhRjvD55OZxcSM5WSoUIFnOeXIWadcTOfgpjDE877VR2NvOnmBgR
         Pcmg==
X-Gm-Message-State: AOAM530DmtZmcoRk+qDbIoOPa2sTRtrttAloyuwnoQRlYhM3ImTBJW0e
        mc86HinEX0xq00vjiWt4COxygkzTTgs=
X-Google-Smtp-Source: ABdhPJyDuP8OdBNQZAdV/D+O3J7bYDykHOoupotu5J4nHRX+mJII1J3MIWVrlkP3prbuXa2Gzz3/Cw==
X-Received: by 2002:aa7:c256:: with SMTP id y22mr95123edo.16.1600971314842;
        Thu, 24 Sep 2020 11:15:14 -0700 (PDT)
Received: from [192.168.2.202] (pd9e5a9d2.dip0.t-ipconnect.de. [217.229.169.210])
        by smtp.gmail.com with ESMTPSA id j18sm3145471edj.62.2020.09.24.11.15.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2020 11:15:13 -0700 (PDT)
Subject: Re: [RFC PATCH 6/9] surface_aggregator: Add dedicated bus and device
 type
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?Q?Bla=c5=be_Hrastnik?= <blaz@mxxn.io>,
        Dorian Stoll <dorian.stoll@tmsp.io>
References: <20200923151511.3842150-1-luzmaximilian@gmail.com>
 <20200923151511.3842150-7-luzmaximilian@gmail.com>
 <20200923173308.GA3965283@kroah.com>
 <bdb02c89-2290-f53f-65a1-fd2b42fc98a2@gmail.com>
 <20200924071213.GA597212@kroah.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <10c7c84f-153d-c2a0-827f-2d75962e4d0b@gmail.com>
Date:   Thu, 24 Sep 2020 20:15:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200924071213.GA597212@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/20 9:12 AM, Greg Kroah-Hartman wrote:
> On Wed, Sep 23, 2020 at 11:12:49PM +0200, Maximilian Luz wrote:
>> On 9/23/20 7:33 PM, Greg Kroah-Hartman wrote:
>>> On Wed, Sep 23, 2020 at 05:15:08PM +0200, Maximilian Luz wrote:
>> [...]
>>
>>> Overall, nice work on this patch, the integration to the driver core
>>> looks totally correct.  Great job.
>>
>> Thanks!
>>
>>> A few minor nits below:
>>>
>>>> --- /dev/null
>>>> +++ b/drivers/misc/surface_aggregator/bus.c
>>>> @@ -0,0 +1,419 @@
>>>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>>> +
>>>
>>> No copyright?
>>
>> As with the other files, I forgot to add that.
>>
>> [...]
>>
>>>> +int ssam_device_add(struct ssam_device *sdev)
>>>> +{
>>>> +	int status;
>>>> +
>>>> +	/*
>>>> +	 * Ensure that we can only add new devices to a controller if it has
>>>> +	 * been started and is not going away soon. This works in combination
>>>> +	 * with ssam_controller_remove_clients to ensure driver presence for the
>>>> +	 * controller device, i.e. it ensures that the controller (sdev->ctrl)
>>>> +	 * is always valid and can be used for requests as long as the client
>>>> +	 * device we add here is registered as child under it. This essentially
>>>> +	 * guarantees that the client driver can always expect the preconditions
>>>> +	 * for functions like ssam_request_sync (controller has to be started
>>>> +	 * and is not suspended) to hold and thus does not have to check for
>>>> +	 * them.
>>>> +	 *
>>>> +	 * Note that for this to work, the controller has to be a parent device.
>>>> +	 * If it is not a direct parent, care has to be taken that the device is
>>>> +	 * removed via ssam_device_remove(), as device_unregister does not
>>>> +	 * remove child devices recursively.
>>>> +	 */
>>>> +	ssam_controller_statelock(sdev->ctrl);
>>>> +
>>>> +	if (READ_ONCE(sdev->ctrl->state) != SSAM_CONTROLLER_STARTED) {
>>>
>>> You locked the state, why the READ_ONCE()?  Is taht needed?
>>
>> At this point, no. I have, at some point, decided that, since I do
>> access the state outside of that lock at some point (specifically when
>> submitting the request in ssam_request_sync_submit() to detect mis-use
>> of the AP), that I'm going to mark them all as READ_ONCE. Mostly
>> because, due to that one check, I have to set the state via WRITE_ONCE.
>> Note that that check accessing it outside of the lock is a very basic
>> validity check and actually doesn't guarantee _anything_. Again, it's
>> just there to try and spot bad API usage. Every actually valid access to
>> the state should be locked, so the rest doesn't need the READ_ONCE. I
>> can remove those if you want me to.
> 
> I would remove the ones you don't really need, but as you are doing this
> also to show intent, that should be fine.

Alright, I'll do that.

>>>> +		ssam_controller_stateunlock(sdev->ctrl);
>>>> +		return -ENXIO;
>>>
>>> odd error value, why this one?
>>
>> I generally use -ENXIO to indicate that the controller device is not
>> present, has not been initialized yet, or is being/has been shut down.
>> The error here will be caused by the controller going away (or having
>> been suspended) after the device has been created and befor the device
>> is added. I guess in case of shutdown, -ESHUTDOWN may be better, but
>> then I'm not sure what to return when the controller is suspended.
> 
> Do you really need different error values?

No, not really. -ESHUTDOWN just kind of feels wrong to me for a
suspended device (specifically as that's already returned when packets
are force-evicted when the controller is shutting down).

> Anyway, it's fine, that just seemed like an odd error for that case, but
> any error is ok.

Okay, I guess I'll keep it for now. If you or anyone else have any ideas
for replacements, I'm open to them.

>>>> +/**
>>>> + * struct ssam_device_uid - Unique identifier for SSAM device.
>>>> + * @domain:   Domain of the device.
>>>> + * @category: Target category of the device.
>>>> + * @target:   Target ID of the device.
>>>> + * @instance: Instance ID of the device.
>>>> + * @function: Sub-function of the device. This field can be used to split a
>>>> + *            single SAM device into multiple virtual subdevices to separate
>>>> + *            different functionality of that device and allow one driver per
>>>> + *            such functionality.
>>>> + */
>>>> +struct ssam_device_uid {
>>>> +	u8 domain;
>>>> +	u8 category;
>>>> +	u8 target;
>>>> +	u8 instance;
>>>> +	u8 function;
>>>> +};
>>>> +
>>>> +/*
>>>> + * Special values for device matching.
>>>> + */
>>>> +#define SSAM_ANY_TID		0xffff
>>>> +#define SSAM_ANY_IID		0xffff
>>>> +#define SSAM_ANY_FUN		0xffff
>>>
>>> These are 16 bits, but the uid values above are 8 bits.  How does that
>>> match up?
>>
>> Those values are only intended for use with the SSAM_DEVICE() macro,
>> where they are used to set the match flags. They're u16 so that they
>> don't interfere with any potentially valid ID value (0x00 to 0xff). The
>> lowest byte is specifically 0xff to make it easier to spot potential
>> mis-use in the struct above, as that's an ID that, as far as I know,
>> doesn't have any valid use (at least yet). They should never be used
>> directly with the struct above, something I should probably clarify in
>> the documentation.
> 
> Yes, documenting it would make more sense, the 8 vs. 16 threw me off
> here.

Will do that.

Thank you,
Max
