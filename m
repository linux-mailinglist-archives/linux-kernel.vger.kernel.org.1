Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8135E2EB3B9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 20:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731068AbhAETw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 14:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727243AbhAETw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 14:52:56 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEC9C061796
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 11:52:16 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id n4so457162iow.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 11:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MUmClyAZBPlE7Le4cgLYa46jVi3l4PFDRJWl+ePxKps=;
        b=MavlyPFNkKPuclSzMb3GoGCfiFYFDPAmLM8mrU9ii2oKdjb7M97cCdw/FUvuAD/tvg
         qq80P25bb9inOMZpNdKnChezh+SuNcWIWhM0gUJtKJ1GzE8B03EeNBPUGFdJgsY1XClt
         FntkhRU4Vp9vqMA3qc2iwIvwycZCbNKL7ELQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MUmClyAZBPlE7Le4cgLYa46jVi3l4PFDRJWl+ePxKps=;
        b=g//tAaF0+7Z4S1qdSUkEEjpzThQKBD2/b5DKCkGCijF92f+avLN73YPkZ0AxvEp/er
         c80SSOi9OafJg2daAwrnEiCuuE2Jg8edOJBqA+zZS8XrJmmtz5ctMwOAW8QlNYMr+L42
         AQ9Pz+wLjRzcqj9obnWprBjNzSviK6cTmm1QMy+a9dNnwT1EnEFQxs4tJjbDodMpT7nG
         bvfsGlxx1DrPl8jjJmz/Hi+uKZ1UbNY+IOl/OmHR8fFmRWk5u/UojtUc30m1prFFp83V
         KfxGGXtVh1k3hOxu0hMUIrUzwuWMcGHpw+4e5acdRUCXJEzh8KUv52K/xsfE2xu0lvtH
         ARZg==
X-Gm-Message-State: AOAM5303Mb53u7jcKCUfiUXDizPvjg45OHm4IVhHJXyroxOFBJSlY5XK
        PIywVidQFjc3dQ3KpmJh2Awvig==
X-Google-Smtp-Source: ABdhPJy/4xKWsJqauwUWBPNxLIHPJbD9egorxkf2SJisb+l9V4Udu88+b7tT5z8D0BRnhFfsm2SDhQ==
X-Received: by 2002:a5e:8344:: with SMTP id y4mr549885iom.116.1609876335465;
        Tue, 05 Jan 2021 11:52:15 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id r11sm152669ilg.39.2021.01.05.11.52.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jan 2021 11:52:14 -0800 (PST)
Subject: Re: [PATCH] kunit: tool: Force the use of the 'tty' console for UML
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>, David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20201222073900.3490607-1-davidgow@google.com>
 <20201222111102.GC4077@smile.fi.intel.com>
 <4ae7779c-15c5-0474-5840-44531dcf1d94@linuxfoundation.org>
 <X/SSJQ+I5zEMaYYJ@alley>
 <3828c7ee-52b0-42f9-5771-74ef9386756c@linuxfoundation.org>
 <20210105185731.GT4077@smile.fi.intel.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <918b2d05-f51b-0866-89b3-19a016abdaa3@linuxfoundation.org>
Date:   Tue, 5 Jan 2021 12:52:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210105185731.GT4077@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/5/21 11:57 AM, Andy Shevchenko wrote:
> On Tue, Jan 05, 2021 at 09:34:33AM -0700, Shuah Khan wrote:
>> On 1/5/21 9:21 AM, Petr Mladek wrote:
>>> On Mon 2021-01-04 09:23:57, Shuah Khan wrote:
>>>> On 12/22/20 4:11 AM, Andy Shevchenko wrote:
>>>>> On Mon, Dec 21, 2020 at 11:39:00PM -0800, David Gow wrote:
>>>>>> kunit_tool relies on the UML console outputting printk() output to the
>>>>>> tty in order to get results. Since the default console driver could
>>>>>> change, pass 'console=tty' to the kernel.
>>>>>>
>>>>>> This is triggered by a change[1] to use ttynull as a fallback console
>>>>>> driver which -- by chance or by design -- seems to have changed the
>>>>>> default console output on UML, breaking kunit_tool. While this may be
>>>>>> fixed, we should be less fragile to such changes in the default.
>>>>>>
>>>>>> [1]:
>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=757055ae8dedf5333af17b3b5b4b70ba9bc9da4e
>>>>>
>>>>> Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>>>> Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>>>>
>>>>
>>>> Thank you all. Now in linux-kselftest kunit-fixes branch.
>>>>
>>>> Will send this up for rc3.
>>>>
>>>> Sorry for the delay - have been away from the keyboard for a
>>>> bit.
>>>
>>> JFYI, I am not sure that this is the right solution. I am
>>> looking into it, see
>>> https://lore.kernel.org/linux-kselftest/X%2FSRA1P8t+ONZFKb@alley/
>>> for more details.
>>>
>>
>> Thanks Petr. I will hold off on sending the patch up to Linus and
>> let you find a the right solution.
> 
> Please. leave it in Linux Next at least. Otherwise kunit will be broken for a
> long time which is not good.
> 
> 

Yes. That is the plan. It will be in there until real fix comes in.

thanks,
-- Shuah
