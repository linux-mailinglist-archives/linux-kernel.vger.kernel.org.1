Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA71E2B911A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 12:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgKSLgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 06:36:07 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:36899 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbgKSLgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 06:36:07 -0500
Received: from mail-qv1-f71.google.com ([209.85.219.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <gpiccoli@canonical.com>)
        id 1kfiDG-0001pi-Oz
        for linux-kernel@vger.kernel.org; Thu, 19 Nov 2020 11:34:54 +0000
Received: by mail-qv1-f71.google.com with SMTP id y8so4206898qvu.22
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 03:34:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=y6I8e6byYUCnlLetfrW6fWVf+L40tuRRv7qqRllB1ak=;
        b=GbEm1qF5HZKYTp/eHfEGpdm5GpDxSAFTo1/XSfKxBSQXRAl6okKcZJcGH7hPITI0Gj
         m+QBs95fZM/nq8IqeVeD44NlC4gOZy8319jAXGyIQCWPOBXYnGdaWwmvutwT3Q38StiC
         lajm/P+R3dK/cf1k4oNTvNrj/ozC0KzoOf3xYXL7u3SDPncrdCmBrHYF1AXDnGdeFvSc
         f1weFMzgApvcen4vrwwxC9ZXl5EnrSratrk37Mbef000SdJgCRIQng+Wru2P7/Au0Wib
         rUJy7+cluyyDEckFylwvghDHlX3hp0LhJV0zfhrTU3PWcEfxjRJIr+HqRPkwxHMD2JHg
         AsRA==
X-Gm-Message-State: AOAM530iVKJ5WHqKgAdLD74PvTtySTgWyq8tCZJ41t+Gsli++KUsvHV5
        bbNFbEzNMAzL2Xfag6ivmKV7gN8zTj4xvkhMVBQJgssArA6OelBUQLe6hb5jB+0Akeg1r/IVUJo
        xtTud4LFQkAKCLKqTL/1cGxBmDO7VemuW0h0Demv8/g==
X-Received: by 2002:a37:68d5:: with SMTP id d204mr10531454qkc.198.1605785693714;
        Thu, 19 Nov 2020 03:34:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwwmOKQHgcc//fqvSJDDXvUpViltGEBapCyJ5wOmCHAfBVH5ofbMk/6Rk86S+7ES7yeiLCZXg==
X-Received: by 2002:a37:68d5:: with SMTP id d204mr10531426qkc.198.1605785693424;
        Thu, 19 Nov 2020 03:34:53 -0800 (PST)
Received: from [192.168.1.75] ([177.215.76.189])
        by smtp.gmail.com with ESMTPSA id d66sm18155730qke.132.2020.11.19.03.34.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2020 03:34:52 -0800 (PST)
Subject: Re: [PATCH v3] sched/fair: fix unthrottle_cfs_rq for leaf_cfs_rq list
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Tao Zhou <t1zhou@163.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        SeongJae Park <sjpark@amazon.com>,
        Ben Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Tao Zhou <zohooouoto@zoho.com.cn>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Tao Zhou <ouwen210@hotmail.com>, Phil Auld <pauld@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        Gavin Guo <gavin.guo@canonical.com>, halves@canonical.com,
        nivedita.singhvi@canonical.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "# v4 . 16+" <stable@vger.kernel.org>
References: <17fc60a3-cc50-7cff-eb46-904c2f0c416e@canonical.com>
 <20201118235015.GB6015@geo.homenetwork>
 <20201119003319.GA6805@geo.homenetwork>
 <CAKfTPtBYm8UtBBnbc7qddA2_OAa3vwH=KoHNgvsQJ9zO2KocYQ@mail.gmail.com>
From:   "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Autocrypt: addr=gpiccoli@canonical.com; prefer-encrypt=mutual; keydata=
 xsBNBFpVBxcBCADPNKmu2iNKLepiv8+Ssx7+fVR8lrL7cvakMNFPXsXk+f0Bgq9NazNKWJIn
 Qxpa1iEWTZcLS8ikjatHMECJJqWlt2YcjU5MGbH1mZh+bT3RxrJRhxONz5e5YILyNp7jX+Vh
 30rhj3J0vdrlIhPS8/bAt5tvTb3ceWEic9mWZMsosPavsKVcLIO6iZFlzXVu2WJ9cov8eQM/
 irIgzvmFEcRyiQ4K+XUhuA0ccGwgvoJv4/GWVPJFHfMX9+dat0Ev8HQEbN/mko/bUS4Wprdv
 7HR5tP9efSLucnsVzay0O6niZ61e5c97oUa9bdqHyApkCnGgKCpg7OZqLMM9Y3EcdMIJABEB
 AAHNLUd1aWxoZXJtZSBHLiBQaWNjb2xpIDxncGljY29saUBjYW5vbmljYWwuY29tPsLAdwQT
 AQgAIQUCWmClvQIbAwULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRDOR5EF9K/7Gza3B/9d
 5yczvEwvlh6ksYq+juyuElLvNwMFuyMPsvMfP38UslU8S3lf+ETukN1S8XVdeq9yscwtsRW/
 4YoUwHinJGRovqy8gFlm3SAtjfdqysgJqUJwBmOtcsHkmvFXJmPPGVoH9rMCUr9s6VDPox8f
 q2W5M7XE9YpsfchS/0fMn+DenhQpV3W6pbLtuDvH/81GKrhxO8whSEkByZbbc+mqRhUSTdN3
 iMpRL0sULKPVYbVMbQEAnfJJ1LDkPqlTikAgt3peP7AaSpGs1e3pFzSEEW1VD2jIUmmDku0D
 LmTHRl4t9KpbU/H2/OPZkrm7809QovJGRAxjLLPcYOAP7DUeltvezsBNBFpVBxcBCADbxD6J
 aNw/KgiSsbx5Sv8nNqO1ObTjhDR1wJw+02Bar9DGuFvx5/qs3ArSZkl8qX0X9Vhptk8rYnkn
 pfcrtPBYLoux8zmrGPA5vRgK2ItvSc0WN31YR/6nqnMfeC4CumFa/yLl26uzHJa5RYYQ47jg
 kZPehpc7IqEQ5IKy6cCKjgAkuvM1rDP1kWQ9noVhTUFr2SYVTT/WBHqUWorjhu57/OREo+Tl
 nxI1KrnmW0DbF52tYoHLt85dK10HQrV35OEFXuz0QPSNrYJT0CZHpUprkUxrupDgkM+2F5LI
 bIcaIQ4uDMWRyHpDbczQtmTke0x41AeIND3GUc+PQ4hWGp9XABEBAAHCwF8EGAEIAAkFAlpV
 BxcCGwwACgkQzkeRBfSv+xv1wwgAj39/45O3eHN5pK0XMyiRF4ihH9p1+8JVfBoSQw7AJ6oU
 1Hoa+sZnlag/l2GTjC8dfEGNoZd3aRxqfkTrpu2TcfT6jIAsxGjnu+fUCoRNZzmjvRziw3T8
 egSPz+GbNXrTXB8g/nc9mqHPPprOiVHDSK8aGoBqkQAPZDjUtRwVx112wtaQwArT2+bDbb/Y
 Yh6gTrYoRYHo6FuQl5YsHop/fmTahpTx11IMjuh6IJQ+lvdpdfYJ6hmAZ9kiVszDF6pGFVkY
 kHWtnE2Aa5qkxnA2HoFpqFifNWn5TyvJFpyqwVhVI8XYtXyVHub/WbXLWQwSJA4OHmqU8gDl
 X18zwLgdiQ==
Message-ID: <7c9462c9-8908-8592-0727-9117d4173724@canonical.com>
Date:   Thu, 19 Nov 2020 08:34:46 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtBYm8UtBBnbc7qddA2_OAa3vwH=KoHNgvsQJ9zO2KocYQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/11/2020 05:36, Vincent Guittot wrote:
> On Thu, 19 Nov 2020 at 01:36, Tao Zhou <t1zhou@163.com> wrote:
>>
>> On Thu, Nov 19, 2020 at 07:50:15AM +0800, Tao Zhou wrote:
>>> On Wed, Nov 18, 2020 at 07:56:38PM -0300, Guilherme G. Piccoli wrote:
>>>> Hi Vincent (and all CCed), I'm sorry to ping about such "old" patch, but
>>>> we experienced a similar condition to what this patch addresses; it's an
>>>> older kernel (4.15.x) but when suggesting the users to move to an
>>>> updated 5.4.x kernel, we noticed that this patch is not there, although
>>>> similar ones are (like [0] and [1]).
>>>>
>>>> So, I'd like to ask if there's any particular reason to not backport
>>>> this fix to stable kernels, specially the longterm 5.4. The main reason
>>>> behind the question is that the code is very complex for non-experienced
>>>> scheduler developers, and I'm afraid in suggesting such backport to 5.4
>>>> and introduce complex-to-debug issues.
>>>>
>>>> Let me know your thoughts Vincent (and all CCed), thanks in advance.
>>>> Cheers,
>>>>
>>>>
>>>> Guilherme
>>>>
>>>>
>>>> P.S. For those that deleted this thread from the email client, here's a
>>>> link:
>>>> https://lore.kernel.org/lkml/20200513135528.4742-1-vincent.guittot@linaro.org/
>>>>
>>>>
>>>> [0]
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fe61468b2cb
>>>>
>>>> [1]
>>>> https://lore.kernel.org/lkml/20200506141821.GA9773@lorien.usersys.redhat.com/
>>>> <- great thread BTW!
>>>
>>> 'sched/fair: Fix unthrottle_cfs_rq() for leaf_cfs_rq list" failed to apply to
>>> 5.4-stable tree'
>>>
>>> You could check above. But I do not have the link about this. Can't search it
>>> on LKML web: https://lore.kernel.org/lkml/
>>>
>>> BTW: 'ouwen210@hotmail.com' and 'zohooouoto@zoho.com.cn' all is myself.
>>>
>>> Sorry for the confusing..
>>>
>>> Thanks.
>>
>> Sorry again. I forget something. It is in the stable.
>>
>> Here it is:
>>
>>   https://lore.kernel.org/stable/159041776924279@kroah.com/
> 
> I think it has never been applied to stable.
> As you mentioned, the backport has been sent :
> https://lore.kernel.org/stable/20200525172709.GB7427@vingu-book/
> 
> I received another emailed in September and pointed out to the
> backport : https://www.spinics.net/lists/stable/msg410445.html
> 
> 
>>

Thanks a lot Tao and Vincent! Nice to know that you already worked the
backport, gives much more confidence when the author does that heheh

So, this should go to stable 5.4.y, but not 4.19.y IIUC?
Cheers,


Guilherme
