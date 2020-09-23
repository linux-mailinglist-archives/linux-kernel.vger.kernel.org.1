Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD06275F48
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 20:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgIWSDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 14:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbgIWSDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 14:03:42 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62F7C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 11:03:41 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id n13so673530edo.10
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 11:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LEzQpkXPLqdJoK2l/i3Yr1Vc4AJIq+Q7kFLBAXmNj+0=;
        b=UawtYeudxTjT09+Xacop62iOvaf12lE0hNJMbS0lhEdcazN1GWZeVw0X95Y5Bd3tdS
         gdo765KZ+Adr8TVfajpKiVtxZUIZME8VfyF8Q7XNO7vAGJZuCVhTohjMBv8XWjTqTRUg
         JWUAWSlC+fuvUKTlmQv0TDv7IECWS7by228u4xB72vRvBcT4wui+npz+mLJrDSnPQgiJ
         kW1pb115cwpOe6pymGsHF4bNxZtfXCdKzBLLtuz6GuQAsiG2/l3kVTENxoMBrm8KdLrr
         wYs/7Kyv/4pMySFdcKrfVhnGQRC+Xs6uUn8hTVMCNlGqbhSDUMw6Oim7Jv4VGKmOlYkG
         Q6NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LEzQpkXPLqdJoK2l/i3Yr1Vc4AJIq+Q7kFLBAXmNj+0=;
        b=Hi47Li1w7l1XwI/o95gLcOgJOmzw2s3tbmcIhQ+s7ENVW+nksSH7/yGVPSeowdA4Ia
         qPssPWrsBsQAwgbZeSueWUtwH6y4hVFXEW+AWnO90Os2v9QzU6aTA5zmlxV+QCenF5fB
         Cm0g/ArqOT1L7VOWadTSxNVVXX7WGMAmVrBkzuAKRJo2E4kSOhHIA8cG9WFZ0vniTkbp
         hIo71uV9gA8KRGBtqr9RDXV/NRxjtckcEIWrwOLE9kLyqMWZj/QoS0jq7paybw60c/uj
         6d4XUYfq1xlFUM+CgQ1/TLmrXbFwEUM5wPyIUcGucqSx8/OkfkzuxQAKQ/i1XY7C7zaa
         EnLQ==
X-Gm-Message-State: AOAM531KDnhbzBeZEIwOKT89WEH7kM9W6ma4VJ1RXyhuJDzR+gvM1wCQ
        T4CxZ6lfDNC5gh8bKqP+rGjPHmBUOxs=
X-Google-Smtp-Source: ABdhPJwtg52AGv6WiwEsgh+K3J5ZBy4UXzUshoIfkvJtbDPk7EG2b+31UC+ZN0eS2owcHO1HwM3Q3A==
X-Received: by 2002:a05:6402:1773:: with SMTP id da19mr529879edb.171.1600884220471;
        Wed, 23 Sep 2020 11:03:40 -0700 (PDT)
Received: from [192.168.2.202] (pd9e5a9df.dip0.t-ipconnect.de. [217.229.169.223])
        by smtp.gmail.com with ESMTPSA id s19sm547958eja.54.2020.09.23.11.03.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2020 11:03:39 -0700 (PDT)
Subject: Re: [RFC PATCH 8/9] surface_aggregator: Add DebugFS interface
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?Q?Bla=c5=be_Hrastnik?= <blaz@mxxn.io>,
        Dorian Stoll <dorian.stoll@tmsp.io>
References: <20200923151511.3842150-1-luzmaximilian@gmail.com>
 <20200923151511.3842150-9-luzmaximilian@gmail.com>
 <20200923161416.GA3723109@kroah.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <7d571ed4-862e-cfbd-44d4-0fda25f03294@gmail.com>
Date:   Wed, 23 Sep 2020 20:03:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200923161416.GA3723109@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/20 6:14 PM, Greg Kroah-Hartman wrote:
> On Wed, Sep 23, 2020 at 05:15:10PM +0200, Maximilian Luz wrote:
[...]

>> +// SPDX-License-Identifier: GPL-2.0-or-later
>
> Are you sure about -or-later?  I have to ask.

Fairly, unless there are any complications with integration of this code
that I'm not aware of.

> And no copyright line?

Forgot to add that, sorry. Will add it for the next version. That's also
the case for all other files.

[...]

>> +
>> +out:
>> +	// always try to set response-length and status
>> +	tmp = put_user(rsp.length, &r->response.length);
>> +	if (!ret)
>> +		ret = tmp;
> 
> Is that the correct error to return if put_user() fails?  Hint, I don't
> think so...

So the -EFAULT returned by put_user should have precedence? I was aiming
for "in case it fails, return with the first error".

[...]

>> +static long ssam_dbg_device_ioctl(struct file *file, unsigned int cmd,
>> +				    unsigned long arg)
>> +{
>> +	switch (cmd) {
>> +	case SSAM_DBG_IOCTL_GETVERSION:
>> +		return ssam_dbg_if_getversion(file, arg);
> 
> Not needed, please drop.
> 
>> +
>> +	case SSAM_DBG_IOCTL_REQUEST:
>> +		return ssam_dbg_if_request(file, arg);
>> +
>> +	default:
>> +		return -ENOIOCTLCMD;
> 
> Wrong error value.

I assume -ENOTTY would be correct/preferred then? Kernel doc suggests
that either one of the two would be correct and essentially result in
the same behavior.

[...]

> Listen, I'm all for doing whatever you want in debugfs, but why are you
> doing random ioctls here?  Why not just read/write a file to do what you
> need/want to do here instead?

Two reasons, mostly: First, the IOCTL allows me to execute requests in
parallel with just one open file descriptor and not having to maintain
some sort of back-buffer to wait around until the reader gets to reading
the thing. I've used that for stress-testing the EC communication in the
past, which had some issues (dropping bytes, invalid CRCs, ...) under
heavy(-ish) load. Second, I'm considering adding support for events to
this device in the future by having user-space receive events by reading
from the device. Events would also be enabled or disabled via an IOCTL.
That could be implemented in a second device though. Events were also my
main reason for adding a version to this interface: Discerning between
one that has event support and one that has not.

> 
> And again, no versioning, that is never needed.
> 

Got it, will drop that.

[...]

>> +static void ssam_dbg_device_release(struct device *dev)
>> +{
>> +	// nothing to do
> 
> That's a lie, and the old documentation would allow me to make fun of
> you for trying to work around the kernel's error messages here.
> 
> But I'll be nice and just ask, why do you think it is ok to work around
> a message that someone has spent a lot of time and energy to provide to
> you, saying that you are doing something wrong, by ignoring that and
> providing an empty function?  Not kind...

Sorry about that, but may get a pointer to that particular message? This
setup has been pretty much copied from existing kernel drivers (see
/drivers/platform/x86/intel_pmc_core_pltdrv.c for one) and I thought
that I can get around having to dynamically allocate a platform device
since it's guaranteed to be only there once.

There was no workaround or unkindness of any sorts intended.

>> +}
>> +
>> +static struct platform_device ssam_dbg_device = {
>> +	.name = SSAM_DBG_DEVICE_NAME,
>> +	.id = PLATFORM_DEVID_NONE,
>> +	.dev.release = ssam_dbg_device_release,
>> +};
> 
> Dynamic structures that are static are, well, wrong :)

I assume the correct way would be to allocate the device dynamically and
this holds for all devices?

Sorry if I'm asking such basic questions, but I have not found anything
regarding this in the documentation, although I have to confess that I
only skimmed over a larger part, so that's very likely my fault.

> I appreciate the initiative by creating a fake platform device and
> driver to bind to that device.  But I don't think any of it is needed at
> all, you have made your work a lot harder than you needed to here.  This
> whole file can be _much_ smaller and simpler and not abuse the kernel
> apis so badly :)

So just tack it onto the core driver? My intention was to keep it a bit
more separate from the core, but adding it directly would indeed reduce
the amount of code.

Thanks,
Max
