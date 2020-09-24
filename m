Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9308D27788F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 20:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728747AbgIXSki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 14:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbgIXSki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 14:40:38 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA041C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 11:40:37 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id b12so4349809edz.11
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 11:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Sl4h7biFYu3LMf1sX/N8/Ldva5q8XZy69drEdHEwD40=;
        b=fswH2dxPqL7Ql84dUmCR2mmIxWWlX1St2mHY+pdCT5oex5so0894+pg/ZXrWAgHjYb
         MFr7tAG6uDTCKj8FyPsGUT5X5SOLeYgH/0py/Hr+54xbfhBsCHgs+bS/k6aCdmC/fSW+
         vGr3Pd8R4cyZpkttwpRB0tUjTI+cCFy59YoAkhcVavEMq5myTnfsne1n4K7H/hlnxhqt
         xzftvYM67SGwQ+Dc4hodCMjN6Emc+O6feBrUT2CNQBJDNaJ0PzOe26Y7ZaHGKD8BuN1F
         YP+/w1kfP3hP0ARBe69P5Qh5IyexsUeSITkj4lj4nk4gqgcsnimfzEVdPSepR21ihmgh
         9++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Sl4h7biFYu3LMf1sX/N8/Ldva5q8XZy69drEdHEwD40=;
        b=lIoJ7LLc04hLaFgb+hOaBDL1FbXDR2kr6M1s7gz2XV+YMBCjl7uu34gcBhhxgjnq76
         5OYL18CqmWQnZ0ToFE57FIg/Yav7HQUUfAE4P16YqEXmoIxnBbvghmaBNek/uY23hcBq
         llqRSJzoS0czh7Njr5YwFJPI7gCffBPTM/g0dMo/Al1q43vmXQAIm2FIcVEORMe6aFBY
         azZJ/ueGOHoEYwy1hahamMK6N75jlenQVPzzHGP/M86IUwmiTAYNRm24R/rxcDGEOFUD
         y+AVyoZcU8fFEg+vCANkIlcS/XH8kgpgpoQC3x4O4SjEuVl5UNgEbwq7zO7ucX3/mNBY
         GzUQ==
X-Gm-Message-State: AOAM5336fd1Lp9rnXtftlWifwIeC3DZ4MjzrzPZ4GaUM0yDtY0AiECDs
        WTMg0rpUdoXkVaweaNCIdllkOFWPpQg=
X-Google-Smtp-Source: ABdhPJx338sZpcoZMH0b9I4xOPXq/lTTAcY27/RRn1XYt0UgyEM2w+Obk6uCRjOMo0Wt+h/ok1ez3Q==
X-Received: by 2002:a50:e68a:: with SMTP id z10mr203871edm.100.1600972836464;
        Thu, 24 Sep 2020 11:40:36 -0700 (PDT)
Received: from [192.168.2.202] (pd9e5a9d2.dip0.t-ipconnect.de. [217.229.169.210])
        by smtp.gmail.com with ESMTPSA id v2sm169912ejh.57.2020.09.24.11.40.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2020 11:40:35 -0700 (PDT)
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
 <33ebf267-0216-4480-4217-2e5cbf9dbe52@gmail.com>
 <20200924064614.GA593984@kroah.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <681bb644-5acc-b299-561a-757ac3db24b5@gmail.com>
Date:   Thu, 24 Sep 2020 20:40:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200924064614.GA593984@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/20 8:46 AM, Greg Kroah-Hartman wrote:
> On Thu, Sep 24, 2020 at 12:06:54AM +0200, Maximilian Luz wrote:
>> On 9/23/20 8:29 PM, Greg Kroah-Hartman wrote:
>>> On Wed, Sep 23, 2020 at 08:03:38PM +0200, Maximilian Luz wrote:
>>>> On 9/23/20 6:14 PM, Greg Kroah-Hartman wrote:
>>
>> [...]
>>
>>>> So the -EFAULT returned by put_user should have precedence? I was aiming
>>>> for "in case it fails, return with the first error".
>>>
>>> -EFAULT trumps everything :)
>>
>> Perfect, thanks!
>>
>>>>> Listen, I'm all for doing whatever you want in debugfs, but why are you
>>>>> doing random ioctls here?  Why not just read/write a file to do what you
>>>>> need/want to do here instead?
>>>>
>>>> Two reasons, mostly: First, the IOCTL allows me to execute requests in
>>>> parallel with just one open file descriptor and not having to maintain
>>>> some sort of back-buffer to wait around until the reader gets to reading
>>>> the thing. I've used that for stress-testing the EC communication in the
>>>> past, which had some issues (dropping bytes, invalid CRCs, ...) under
>>>> heavy(-ish) load. Second, I'm considering adding support for events to
>>>> this device in the future by having user-space receive events by reading
>>>> from the device. Events would also be enabled or disabled via an IOCTL.
>>>> That could be implemented in a second device though. Events were also my
>>>> main reason for adding a version to this interface: Discerning between
>>>> one that has event support and one that has not.
>>>
>>> A misc device can also do this, much simpler, right?  Why not use that?
>>
>> Sorry to ask so many questions, just want to make sure I understand you
>> correctly:
>>
>>   - So you suggest I go with a misc device instead of putting this into
>>     debugfs?
> 
> Yes.
> 
>>   - And I keep the IOCTL?
> 
> If you need it, although the interface Arnd says might be much simpler
> (read/write)
> 
>>   - Can I still tell people to not use it and that it's not my fault if a
>>     change in the interface breaks their tools if it's not in debugfs?
> 
> Yes :)
> 
>>   - Also load it via a separate module (module_misc_device, I assume)?
> 
> That works.
> 
>> One reason why the platform_device approach is practical in this
>> scenario is that I can leverage the driver core to defer probing and
>> thus defer creating the device if the controller isn't there yet.
> 
> That's fine, and is a nice abuse of the platform driver interface.  I
> say "abuse" because we really don't have a simpler way to do this at the
> moment, but this really isn't a platform device...

Yeah, it is a bit of a hack...

>> Similarly, the driver is automatically unbound if the controller goes
>> away and the device should be destroyed. All of this should currently be
>> handled via the device link created by ssam_client_bind() (unless I
>> really misunderstood those).
> 
> That all is fine, just create the misc device when your driver binds to
> the device, just like you create the debugfs file entries today.
> There's no difference except you get a "real" char device node instead
> of a debugfs file.
> 
>> I should be able to handle that by having the device refuse to open the
>> file if the controller isn't there. Holding the state-lock during the
>> request execution should ensure that the controller doesn't get shut
>> down.
> 
> Nah, no need for that, again, keep the platform driver/device and then
> create the misc device (and remove it) where you are creating/removing
> the debugfs files.

Okay, I'll do that. Thank you!

>>> A simple misc device would make it very simple and easy to do instead,
>>> why not do that?
>>
>> Again, I considered the probe deferring of the platform driver fairly
>> handy (in addition to having the implicit debugfs warning of "don't rely
>> on this"), but if you prefer me implementing this as misc device, I'll
>> do that.
> 
> The "joy" of creating a user api is that no matter how much you tell
> people "do not depend on this", they will, so no matter the file being
> in debugfs, or a misc device, you might be stuck with it for forever,
> sorry.

Hmm, true. I'm fairly confident that the request-IOCTL, as is right now,
should be sound (regarding to 5th and later gen. requests). It also can
be extended in a non-breaking way to handle events by reading from the
device in the future. So might as well commit to that.

Thanks,
Max
