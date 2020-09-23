Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43005276388
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 00:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgIWWG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 18:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbgIWWG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 18:06:57 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A74C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 15:06:57 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id j2so1318174eds.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 15:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kH3tFSeK0gm4nSYlQkT/6+0HXkSaOgyJNFaBi5l/4i4=;
        b=bAjbrW4EhxSIJ/U+/shIACnrAjmY/IdUZsr7eBIdvDuV0DWgjrv4Blm9OXILcM9VjJ
         OlxUBXiEm55WauBeDeYpQftNiniTJj1sQvQ6y3CuiQOMoLdtQBTfp66+IBpcL5BYPSv3
         W68NNMVcuCk7A2/6adW9hY+ZUcmefV0uuaS+N3COxf4v0Pd3zd5jVLPB7jHwq/rljV3f
         iV6TyProf7QEmpCH3IFewlNZw1SMI1audXOOi1DOety9nUb68ToISavdrg+OUdu0H71l
         wKfguzw6Cja3S38hUqIidGZlOsznJWyUtqSAo417QDtoJHaR0MzkIUWs4EKf9E0i4YDD
         4oiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kH3tFSeK0gm4nSYlQkT/6+0HXkSaOgyJNFaBi5l/4i4=;
        b=eJ82iIuX4A9jFt2MTXvJkiQl0aJnQcADUX0Sxl937Z9AWet0XRO/Rx8vTMib8z+h4N
         5F8I28iVTLTjHRAVf9syI+Z83e+sJq1kZEoLeRkgF7JhfCPaZTLQkfv3sKYiDKTHu+nh
         eaxAvRUzLWqKORk/JzBKXcmBupVTZX14YheBKLlye1SGVaZe1+B+oAJx81QIuz8RJcnA
         j95m5ThVLhSovW4SKfH37QLFlctYY0Z3THxIOhn9V7vWEjEeH5i9DyS81+O3SgbbLxNj
         0s8fzHRfRr4Inp8QiX/a9KCU2PX8/rs/d/RhIYH7mpXkNUhobidtac+0IzuO0TTcAlLy
         lu1w==
X-Gm-Message-State: AOAM532s+I+hpzU3jjdHXJoey/K2MganLqtYNNatXjsjufW7DpF3iAnG
        yDBGJskoAp30Lii+lGkMjOQ=
X-Google-Smtp-Source: ABdhPJza2+pW/I5PKGe9L9Y4eCWk1HLfPjaHgwUKEAq0hWTFhVYK65V4NPSBBX9yMm5PUb2r+h7m0g==
X-Received: by 2002:aa7:c511:: with SMTP id o17mr1541668edq.300.1600898816093;
        Wed, 23 Sep 2020 15:06:56 -0700 (PDT)
Received: from [192.168.2.202] (pd9e5a9df.dip0.t-ipconnect.de. [217.229.169.223])
        by smtp.gmail.com with ESMTPSA id b16sm852854eju.64.2020.09.23.15.06.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2020 15:06:55 -0700 (PDT)
Subject: Re: [RFC PATCH 8/9] surface_aggregator: Add DebugFS interface
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?Q?Bla=c5=be_Hrastnik?= <blaz@mxxn.io>,
        Dorian Stoll <dorian.stoll@tmsp.io>
References: <20200923151511.3842150-1-luzmaximilian@gmail.com>
 <20200923151511.3842150-9-luzmaximilian@gmail.com>
 <20200923161416.GA3723109@kroah.com>
 <7d571ed4-862e-cfbd-44d4-0fda25f03294@gmail.com>
 <20200923182948.GA107114@kroah.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <33ebf267-0216-4480-4217-2e5cbf9dbe52@gmail.com>
Date:   Thu, 24 Sep 2020 00:06:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200923182948.GA107114@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/20 8:29 PM, Greg Kroah-Hartman wrote:
> On Wed, Sep 23, 2020 at 08:03:38PM +0200, Maximilian Luz wrote:
>> On 9/23/20 6:14 PM, Greg Kroah-Hartman wrote:

[...]

>> So the -EFAULT returned by put_user should have precedence? I was aiming
>> for "in case it fails, return with the first error".
> 
> -EFAULT trumps everything :)

Perfect, thanks!

>>> Listen, I'm all for doing whatever you want in debugfs, but why are you
>>> doing random ioctls here?  Why not just read/write a file to do what you
>>> need/want to do here instead?
>>
>> Two reasons, mostly: First, the IOCTL allows me to execute requests in
>> parallel with just one open file descriptor and not having to maintain
>> some sort of back-buffer to wait around until the reader gets to reading
>> the thing. I've used that for stress-testing the EC communication in the
>> past, which had some issues (dropping bytes, invalid CRCs, ...) under
>> heavy(-ish) load. Second, I'm considering adding support for events to
>> this device in the future by having user-space receive events by reading
>> from the device. Events would also be enabled or disabled via an IOCTL.
>> That could be implemented in a second device though. Events were also my
>> main reason for adding a version to this interface: Discerning between
>> one that has event support and one that has not.
> 
> A misc device can also do this, much simpler, right?  Why not use that?

Sorry to ask so many questions, just want to make sure I understand you
correctly:

  - So you suggest I go with a misc device instead of putting this into
    debugfs?

  - And I keep the IOCTL?

  - Can I still tell people to not use it and that it's not my fault if a
    change in the interface breaks their tools if it's not in debugfs?

  - Also load it via a separate module (module_misc_device, I assume)?

One reason why the platform_device approach is practical in this
scenario is that I can leverage the driver core to defer probing and
thus defer creating the device if the controller isn't there yet.
Similarly, the driver is automatically unbound if the controller goes
away and the device should be destroyed. All of this should currently be
handled via the device link created by ssam_client_bind() (unless I
really misunderstood those).

I should be able to handle that by having the device refuse to open the
file if the controller isn't there. Holding the state-lock during the
request execution should ensure that the controller doesn't get shut
down.

> Oh, after fixing up the issues that Arnd pointed out of course :)

Sure :)

>>>> +static void ssam_dbg_device_release(struct device *dev)
>>>> +{
>>>> +	// nothing to do
>>>
>>> That's a lie, and the old documentation would allow me to make fun of
>>> you for trying to work around the kernel's error messages here.
>>>
>>> But I'll be nice and just ask, why do you think it is ok to work around
>>> a message that someone has spent a lot of time and energy to provide to
>>> you, saying that you are doing something wrong, by ignoring that and
>>> providing an empty function?  Not kind...
>>
>> Sorry about that, but may get a pointer to that particular message? This
>> setup has been pretty much copied from existing kernel drivers (see
>> /drivers/platform/x86/intel_pmc_core_pltdrv.c for one)
> 
> Oh wow, time to go yell at people, thanks for pointing that out...
> 
>> and I thought
>> that I can get around having to dynamically allocate a platform device
>> since it's guaranteed to be only there once.
>>
>> There was no workaround or unkindness of any sorts intended.
> 
> See device_release() in drivers/base/core.c for the error message you
> would have gotten that this empty function "works around".

Ah, Documentation/core-api/kobject.rst does explain things a lot better,
thanks! I was only looking at the driver, device, and platform docs so
that's something I've missed completely...

>>>> +}
>>>> +
>>>> +static struct platform_device ssam_dbg_device = {
>>>> +	.name = SSAM_DBG_DEVICE_NAME,
>>>> +	.id = PLATFORM_DEVID_NONE,
>>>> +	.dev.release = ssam_dbg_device_release,
>>>> +};
>>>
>>> Dynamic structures that are static are, well, wrong :)
>>
>> I assume the correct way would be to allocate the device dynamically and
>> this holds for all devices?
>>
>> Sorry if I'm asking such basic questions, but I have not found anything
>> regarding this in the documentation, although I have to confess that I
>> only skimmed over a larger part, so that's very likely my fault.
>>
>>> I appreciate the initiative by creating a fake platform device and
>>> driver to bind to that device.  But I don't think any of it is needed at
>>> all, you have made your work a lot harder than you needed to here.  This
>>> whole file can be _much_ smaller and simpler and not abuse the kernel
>>> apis so badly :)
>>
>> So just tack it onto the core driver? My intention was to keep it a bit
>> more separate from the core, but adding it directly would indeed reduce
>> the amount of code.
> 
> A simple misc device would make it very simple and easy to do instead,
> why not do that?

Again, I considered the probe deferring of the platform driver fairly
handy (in addition to having the implicit debugfs warning of "don't rely
on this"), but if you prefer me implementing this as misc device, I'll
do that.

Thanks,
Max
