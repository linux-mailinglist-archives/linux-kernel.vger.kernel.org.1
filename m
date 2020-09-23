Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23D732762F0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 23:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgIWVMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 17:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgIWVMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 17:12:53 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7289AC0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 14:12:53 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id b12so1177204edz.11
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 14:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lnTcNK2k5fhZGNVa9CuuWbk6pDcOcS1Nz4vHbVvTkuU=;
        b=WUQJzX6RFjg4AvlvsUiAgpD4njD/IuA8/hukmCvV0irPWx4lmWaso1x3YGr0l5Nr7g
         AWApXVWhaXrLyGUvwdqg2I2cGxDP81sDjlBOu8uLIlTP3Q27m/7parwErgy/eHcxrxuj
         YAvcWDOqT+0g+LWWOGZqz/d5jNijbq42P1rzjy3jdW/tNly17+13qwHiPp0Om1y2Dr8R
         iNJ87HrwniQBvXBQBQotNuioOSjgpg8Z/UADm1uQk9lXHCi0O2e/dVVTzqWg1ThkVEkE
         L2+NunMgbDpzS+klTrv/18uvOL+IZ7dqyTUvwWWjhRg3oeN5woDGpaTkMZ/apWLIluJf
         0JiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lnTcNK2k5fhZGNVa9CuuWbk6pDcOcS1Nz4vHbVvTkuU=;
        b=I8xlnzlYiQelPlGeiLzBukvUdfJZ1BCp8l1z4296kJeaqjvuV99OEOO1Qa0Os3c+xy
         yrqPCGAz87KfJUzUoMtAe9CY4c8l9LQ80enazi8zNbFPKf4Pe6hxgOpXxdx8iZ76iZYo
         f4P6dvjz/IuHJsOHnrdY7s2J4oFjv/nTMVkKuc0th1CmUv/AQaqEOvBOiEucwlP2UFiG
         aOBq4Uv8T9jSV8oyzs7mLZUFHkmhpWw8FTKj+JmWheVGjDRa9n9hMMbfXWvgCbNHNiog
         3tSJHYrTutCheQ0YgZslZMm/DuP+HqM9uNSLYf00C7zj/hzfuiUSC9E0cjPbPKdZE6eD
         QPrg==
X-Gm-Message-State: AOAM531aosRxkmdKS00ja6RQ7YJC3exXJ0bn9Anm+04nZ6sA5MD0nWAJ
        KkiJ4T7IH8ujbU0k1adqMpU=
X-Google-Smtp-Source: ABdhPJz6jKe6ym3iMeOo/AVaDHAXT39sS4h73JExvhoZ2DPW4zHYyGWuIqGc0FWsokk3d35eonytbQ==
X-Received: by 2002:aa7:c70a:: with SMTP id i10mr1322163edq.218.1600895571951;
        Wed, 23 Sep 2020 14:12:51 -0700 (PDT)
Received: from [192.168.2.202] (pd9e5a9df.dip0.t-ipconnect.de. [217.229.169.223])
        by smtp.gmail.com with ESMTPSA id i3sm856497edn.55.2020.09.23.14.12.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2020 14:12:51 -0700 (PDT)
Subject: Re: [RFC PATCH 6/9] surface_aggregator: Add dedicated bus and device
 type
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?Q?Bla=c5=be_Hrastnik?= <blaz@mxxn.io>,
        Dorian Stoll <dorian.stoll@tmsp.io>
References: <20200923151511.3842150-1-luzmaximilian@gmail.com>
 <20200923151511.3842150-7-luzmaximilian@gmail.com>
 <20200923173308.GA3965283@kroah.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <bdb02c89-2290-f53f-65a1-fd2b42fc98a2@gmail.com>
Date:   Wed, 23 Sep 2020 23:12:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200923173308.GA3965283@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/20 7:33 PM, Greg Kroah-Hartman wrote:
> On Wed, Sep 23, 2020 at 05:15:08PM +0200, Maximilian Luz wrote:
[...]

> Overall, nice work on this patch, the integration to the driver core
> looks totally correct.  Great job.

Thanks!

> A few minor nits below:
> 
>> --- /dev/null
>> +++ b/drivers/misc/surface_aggregator/bus.c
>> @@ -0,0 +1,419 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +
> 
> No copyright?

As with the other files, I forgot to add that.

[...]

>> +int ssam_device_add(struct ssam_device *sdev)
>> +{
>> +	int status;
>> +
>> +	/*
>> +	 * Ensure that we can only add new devices to a controller if it has
>> +	 * been started and is not going away soon. This works in combination
>> +	 * with ssam_controller_remove_clients to ensure driver presence for the
>> +	 * controller device, i.e. it ensures that the controller (sdev->ctrl)
>> +	 * is always valid and can be used for requests as long as the client
>> +	 * device we add here is registered as child under it. This essentially
>> +	 * guarantees that the client driver can always expect the preconditions
>> +	 * for functions like ssam_request_sync (controller has to be started
>> +	 * and is not suspended) to hold and thus does not have to check for
>> +	 * them.
>> +	 *
>> +	 * Note that for this to work, the controller has to be a parent device.
>> +	 * If it is not a direct parent, care has to be taken that the device is
>> +	 * removed via ssam_device_remove(), as device_unregister does not
>> +	 * remove child devices recursively.
>> +	 */
>> +	ssam_controller_statelock(sdev->ctrl);
>> +
>> +	if (READ_ONCE(sdev->ctrl->state) != SSAM_CONTROLLER_STARTED) {
> 
> You locked the state, why the READ_ONCE()?  Is taht needed?

At this point, no. I have, at some point, decided that, since I do
access the state outside of that lock at some point (specifically when
submitting the request in ssam_request_sync_submit() to detect mis-use
of the AP), that I'm going to mark them all as READ_ONCE. Mostly
because, due to that one check, I have to set the state via WRITE_ONCE.
Note that that check accessing it outside of the lock is a very basic
validity check and actually doesn't guarantee _anything_. Again, it's
just there to try and spot bad API usage. Every actually valid access to
the state should be locked, so the rest doesn't need the READ_ONCE. I
can remove those if you want me to.

>> +		ssam_controller_stateunlock(sdev->ctrl);
>> +		return -ENXIO;
> 
> odd error value, why this one?

I generally use -ENXIO to indicate that the controller device is not
present, has not been initialized yet, or is being/has been shut down.
The error here will be caused by the controller going away (or having
been suspended) after the device has been created and befor the device
is added. I guess in case of shutdown, -ESHUTDOWN may be better, but
then I'm not sure what to return when the controller is suspended.

>> +/**
>> + * struct ssam_device_uid - Unique identifier for SSAM device.
>> + * @domain:   Domain of the device.
>> + * @category: Target category of the device.
>> + * @target:   Target ID of the device.
>> + * @instance: Instance ID of the device.
>> + * @function: Sub-function of the device. This field can be used to split a
>> + *            single SAM device into multiple virtual subdevices to separate
>> + *            different functionality of that device and allow one driver per
>> + *            such functionality.
>> + */
>> +struct ssam_device_uid {
>> +	u8 domain;
>> +	u8 category;
>> +	u8 target;
>> +	u8 instance;
>> +	u8 function;
>> +};
>> +
>> +/*
>> + * Special values for device matching.
>> + */
>> +#define SSAM_ANY_TID		0xffff
>> +#define SSAM_ANY_IID		0xffff
>> +#define SSAM_ANY_FUN		0xffff
> 
> These are 16 bits, but the uid values above are 8 bits.  How does that
> match up?

Those values are only intended for use with the SSAM_DEVICE() macro,
where they are used to set the match flags. They're u16 so that they
don't interfere with any potentially valid ID value (0x00 to 0xff). The
lowest byte is specifically 0xff to make it easier to spot potential
mis-use in the struct above, as that's an ID that, as far as I know,
doesn't have any valid use (at least yet). They should never be used
directly with the struct above, something I should probably clarify in
the documentation.

>> +/**
>> + * SSAM_DEVICE() - Initialize a &struct ssam_device_id with the given
>> + * parameters.
>> + * @d:   Domain of the device.
>> + * @cat: Target category of the device.
>> + * @tid: Target ID of the device.
>> + * @iid: Instance ID of the device.
>> + * @fun: Sub-function of the device.
>> + *
>> + * Initializes a &struct ssam_device_id with the given parameters. See &struct
>> + * ssam_device_uid for details regarding the parameters. The special values
>> + * %SSAM_ANY_TID, %SSAM_ANY_IID, and %SSAM_ANY_FUN can be used to specify that
>> + * matching should ignore target ID, instance ID, and/or sub-function,
>> + * respectively. This macro initializes the ``match_flags`` field based on the
>> + * given parameters.
>> + */
>> +#define SSAM_DEVICE(d, cat, tid, iid, fun)					\
>> +	.match_flags = (((tid) != SSAM_ANY_TID) ? SSAM_MATCH_TARGET : 0)	\
>> +		     | (((iid) != SSAM_ANY_IID) ? SSAM_MATCH_INSTANCE : 0)	\
>> +		     | (((fun) != SSAM_ANY_FUN) ? SSAM_MATCH_FUNCTION : 0),	\
>> +	.domain   = d,								\
>> +	.category = cat,							\
>> +	.target   = ((tid) != SSAM_ANY_TID) ? (tid) : 0,			\
>> +	.instance = ((iid) != SSAM_ANY_IID) ? (iid) : 0,			\
>> +	.function = ((fun) != SSAM_ANY_FUN) ? (fun) : 0				\
> 
> Again, the 16 vs 8 bits here feels odd.  No casting???

I could add casts, but I don't really see any reason why. All valid
inputs for this macro are either u8 or SSAM_ANY_[TID,IID,FUN], for the
respective parameter. Other values are considered invalid. So the
assignment should, if used correctly, only ever assign u8 (zero in case
of the one special value). I do somewhat hope that the compiler would
complain about an overflow if someone entered any non-special fixed
value larger than U8_MAX if I don't cast here. Casting would remove
those warnings. I should probably explicitly say that the input type is
u8 in the documentation though.

>> +/**
>> + * ssam_device_get() - Increment reference count of SSAM client device.
>> + * @sdev: The device to increment the reference count of.
>> + *
>> + * Increments the reference count of the given SSAM client device by
>> + * incrementing the reference count of the enclosed &struct device via
>> + * get_device().
>> + *
>> + * See ssam_device_put() for the counter-part of this function.
>> + *
>> + * Return: Returns the device provided as input.
>> + */
>> +static inline struct ssam_device *ssam_device_get(struct ssam_device *sdev)
>> +{
>> +	get_device(&sdev->dev);
>> +	return sdev;
> 
> Do you want to check if sdev is NULL or not here before referencing
> it?

That would be a good idea.

>> +}
>> +
>> +/**
>> + * ssam_device_put() - Decrement reference count of SSAM client device.
>> + * @sdev: The device to decrement the reference count of.
>> + *
>> + * Decrements the reference count of the given SSAM client device by
>> + * decrementing the reference count of the enclosed &struct device via
>> + * put_device().
>> + *
>> + * See ssam_device_get() for the counter-part of this function.
>> + */
>> +static inline void ssam_device_put(struct ssam_device *sdev)
>> +{
>> +	put_device(&sdev->dev);
> 
> Same here, do you need to check?
> 
> anyway, again, nice work, if only all of my code reviews were this easy
> :)

Wow, thank you for the praise!

Regards,
Max
