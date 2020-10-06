Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50F83284A76
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 12:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgJFKot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 06:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgJFKos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 06:44:48 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15260C061755
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 03:45:04 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id f10so3330781otb.6
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 03:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sHFXC4C/qTrkNU9oVUMsiEQDkib7MtmQqpfoGlpQq0Q=;
        b=t05lOFnfIQ3oAsZbWTXR7gsCtLvrO+LdAdM3A6daGIFlNju1JoM0Ekl40UCsO+5JCR
         jHsf/eePU7yRIda1v1GRZiyuWgBA5rbJvOfkP7GCXiHJEgolCDMl3YkVUox+jEd65WAq
         /wt3paQUr2OaUKrakYljKUhomllRpxbKZ/uvwE1f9F+kxYaSHX9TOiRZgVnHW6F9fcx9
         PswY+W9AcNdoopHWW0rUZMWJc51QMqtf2j592CR5kyUxgjRu7qgbf4Rws3KNEp+18KtA
         x+dG3rvjxDFOdJZUgaTdGbfafqqoR2HWilpQx8LZpkkAMBjG3Kc5dVpgvZrxkvZSH0vg
         UVRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=sHFXC4C/qTrkNU9oVUMsiEQDkib7MtmQqpfoGlpQq0Q=;
        b=ncA8QxOmBplgrb2iw5Tw7nzXF+rTeqxtLGFCr8lVENWQsfEhN3WYdV9iWPiT4kq/RP
         15VNB34xensNJc3HxsOBcyetnRyT/v+k2aMLGOEB6OsbWtKfDSTB+Whue0lff4ezujHD
         fFuNab7e3OCM2O5q+XLuQ4IhMmZqOZPf51pckdHAKl8orzp9kNt0QrKMLLXsE7coqXdT
         ByzlPIUj2KkW9yWl0TfM7N+YIxRlX60de9sAsQ3ernWdch8A+e0Ss28W0Won829Q8HD9
         V4kQ5u7JTDL0TKJrAX1vb4OpGULBXKCwTu5tPh+9qtvS5kM73QHYWa8DBVhsuqx2wS/Y
         HTNA==
X-Gm-Message-State: AOAM532uf6evFegM1t6q6RTO45pyohK4Csx7w35QTw1XGIADwY17rBVQ
        oSdwZeUi9miBO3XwZZgO7FDL7BBuTl0=
X-Google-Smtp-Source: ABdhPJzLkwuFWykao9/7DC3vkA+CH16UQma3xu8Fy7ATNzQqiONem56gZr4AVTPVojDLcndpcqHpjw==
X-Received: by 2002:a9d:491:: with SMTP id 17mr2582465otm.338.1601981103367;
        Tue, 06 Oct 2020 03:45:03 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s1sm745428otp.14.2020.10.06.03.45.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2020 03:45:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] printk: handle blank console arguments passed in.
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Shreyas Joshi <shreyas.joshi@biamp.com>, rostedt@goodmis.org,
        shreyasjoshi15@gmail.com, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <MN2PR17MB31979437E605257461AC003DFCF60@MN2PR17MB3197.namprd17.prod.outlook.com>
 <20200522065306.83-1-shreyas.joshi@biamp.com>
 <20200522100046.GH3464@linux-b0ei>
 <20201006025935.GA597@jagdpanzerIV.localdomain>
 <f19c18fd-20b3-b694-5448-7d899966a868@roeck-us.net>
 <20201006095226.GB32369@alley>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <24f7a6bc-c917-2bb7-0e86-9d729c18e812@roeck-us.net>
Date:   Tue, 6 Oct 2020 03:45:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201006095226.GB32369@alley>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/20 2:52 AM, Petr Mladek wrote:
> On Mon 2020-10-05 20:35:59, Guenter Roeck wrote:
>> On 10/5/20 7:59 PM, Sergey Senozhatsky wrote:
>>> On (20/05/22 12:00), Petr Mladek wrote:
>>>> On Fri 2020-05-22 16:53:06, Shreyas Joshi wrote:
>>>>> If uboot passes a blank string to console_setup then it results in a trashed memory.
>>>>> Ultimately, the kernel crashes during freeing up the memory. This fix checks if there
>>>>> is a blank parameter being passed to console_setup from uboot.
>>>>> In case it detects that the console parameter is blank then
>>>>> it doesn't setup the serial device and it gracefully exits.
>>>>>
>>> Petr, this patch's causing regressions for us. We use blank console= boot
>>> param to bypass dts. It appears that it'd be better to revert the change.
>>>
>> Not just to bypass dts, it was also possible to use console= to disable consoles
>> passed as config option, as well as other default console options. A quick test
>> confirms that this affects all platforms/architectures, not just Chromebooks.
>> Prior to this patch, it was possible to disable a default console with an
>> empty "console=" parameter. This is no longer possible. This means that
>> this patch results in a substantial (and, as far as I can see, completely
>> undiscussed) functionality change.
> 
> Where is this behavior documented, please?
> 

I don't know. I didn't find it either. All I know is that Chromebooks
apparently used it from day 1 to disable the console, and I always thought
it was official behavior until I stumbled over the problem last weekend,
tried to look it up, and failed to find it.

> I do not see it anywhere (documentation, git log, google) and it is far from
> obvious from the code. It seems that any random string would do the
> same job, e.g. console=none.
>

Agreed about the "far from obvious". From looking at the code, it seems like
an unintended (?) side effect to me.

> Of course, we need to restore the original behavior when it breaks
> existing systems. But I want to be sure that there is no better
> solution.
> 
> And it makes perfect sense to disable all consoles or drop all defined
> by dts. But I would prefer to make it more obvious way, for
> example by parameters like:
> 
>    + console=none
>    + no-console
>    + no-dtd-console
>    + no-default-console
> 
Again, the problem isn't limited to dts provided consoles, or at least
that was my understanding. I am still trying to understand how default
consoles are defined, so I may get something wrong. Anyway, personally I
liked "console=", but that is just me. Anything else should work for us
as long as it is backward compatible (which excludes the no-xxx options).

Whatever is decided, I'd like to have it made official and documented to
avoid a similar problem in the future.

> 
> JFYI, the console= parameter handling is a real historical mess. We are
> always surprised what undefined behavior people depend on. For
> example, see:
> 
>   + commit 33225d7b0ac9903c5701b ("printk: Correctly set CON_CONSDEV
>     even when preferred console was not registered")
> 
>   + commit e369d8227fd211be3624 ("printk: Fix preferred console
>     selection with multiple matches")
> 
>> I don't understand why (yet), but the patch also causes regressions with
>> seemingly unrelated functionality, specifically with dm-verity on at least
>> one Chromebook platform. I filed crbug.com/1135157 to track the problem,
>> and reverted the patch from all our stable releases immediately after
>> the last round of stable release merges.
>>
>> On a side note, I don't see the problem presumably fixed with this
>> patch in any of my tests.
> 
> Console drivers might provide a custom match() callback to handle
> various aliases. I guess that some driver wrongly matches the empty
> string stored in the array of preferred consoles.
> 

That might well be. Obviously all Chromebooks never had a problem with it.
I'll keep trying; maybe I can find a qemu emulation that crashes with it.

Unfortunately we don't have a traceback, so it is difficult to determine
what actually caused the problem. Maybe Sergey can provide one.

> There are likely other ways to fix the original problem.
> 
Most definitely. Either case, again, I'd like to make sure that we get
some official means to disable a pre-configured console using the
command lime.

Thanks,
Guenter
