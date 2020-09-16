Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97BC426CCCD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgIPUte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbgIPRAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:00:20 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84226C02C2A0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 08:23:37 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id j2so6670734eds.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 08:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DRbP+7SdkWQESgEtNxmeP5hoxbUaM2iKai6pMQX1vug=;
        b=Brc+1/E+cB29BI7DTS7yUQnsiIfW6eM9kWjDAE9NssK174mLXwXWbaDi88NiKeEBla
         F+7XBlexVYoHyLTgIF6DdQRjikDawKuLJ3A1f8OsJAuRcv2S6rAzbVpmnUOv1QrT/Pg3
         o0Ysygps5mDejqSYe4I4P2PRxD+1+sYgkN8TA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DRbP+7SdkWQESgEtNxmeP5hoxbUaM2iKai6pMQX1vug=;
        b=XPoY25m9IiZPBXcpAVcByfRi5+iR0aCftU2/CpdTODgK+tDp29htuSzcVg0oUxvc8i
         LciWHDXOAn41EX+zfPi2824n2qwZhjs6e4+B2hZ01UF+o6TQSBtf8+vOCJ/TAljCvDNt
         Kge1TWKdbfCugfi6Lh1iqyy+3PIOq5oizf1H3GsKHQ9IVR2WDGtBKy79V93dnuG9iZ5c
         eySNJm3FJw4EL2niwRxMFIp2CyWWYac+kIc+VgGnn4MmyESO91s2Hc/1NQdzzrsMu9uw
         Ytk36U1we+aeeZE9PbKA/j+qL+/IecADs9GG5Uy87ZCNdxXN0yABJIL3fs6iaKulrayZ
         X66A==
X-Gm-Message-State: AOAM531qQCBm/GeZbacpOE7JQCrgCLRPrrdC2j6DKfOTTLD8dlAlEtDr
        JU96tj+eTkQsPcVfXue3530q/B9P1Fp08Oak
X-Google-Smtp-Source: ABdhPJwqZhC0SYi5fPy1gl0R3Iq8bTCN6AvPWAjCDVo3fdhYPwiQHUAakNsGANH2OrpyIOu1QpBjkg==
X-Received: by 2002:a05:6402:2c7:: with SMTP id b7mr29015476edx.125.1600269815725;
        Wed, 16 Sep 2020 08:23:35 -0700 (PDT)
Received: from [192.168.1.149] (5.186.115.188.cgn.fibianet.dk. [5.186.115.188])
        by smtp.gmail.com with ESMTPSA id v26sm2268478edw.64.2020.09.16.08.23.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2020 08:23:35 -0700 (PDT)
Subject: Re: [PATCH] scripts/setlocalversion: make git describe output more
 reliable
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Brian Norris <briannorris@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200910112701.13853-1-linux@rasmusvillemoes.dk>
 <CAK7LNARE6NpCYAd7=--m-oO8_LweBWhP2aWfSRdTz=TX8dM5rw@mail.gmail.com>
 <CA+ASDXOuK=iCdzWbtc+aRhBy=8xy860XqxwJg+wFuQaXKfg3UQ@mail.gmail.com>
 <f3ce9b3e-d3c1-a96b-e14b-a8d3c4600b09@rasmusvillemoes.dk>
 <CAK7LNATJ2seAuYpi-WPdLNFn2C9Vwm494nk-SWvgBJB3CmCJrw@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <fd1bb3d9-2b21-c330-7fa8-02ec76292d8b@rasmusvillemoes.dk>
Date:   Wed, 16 Sep 2020 17:23:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAK7LNATJ2seAuYpi-WPdLNFn2C9Vwm494nk-SWvgBJB3CmCJrw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/09/2020 16.28, Masahiro Yamada wrote:
> On Fri, Sep 11, 2020 at 5:28 PM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
>>
>> On 10/09/2020 21.05, Brian Norris wrote:
>>> On Thu, Sep 10, 2020 at 7:35 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>>>> On Thu, Sep 10, 2020 at 8:57 PM Rasmus Villemoes
>>>> <linux@rasmusvillemoes.dk> wrote:
>>>>> So in order to avoid `uname -a` output relying on such random details
>>>>> of the build environment which are rather hard to ensure are
>>>>> consistent between developers and buildbots, use an explicit
>>>>> --abbrev=15 option (and for consistency, also use rev-parse --short=15
>>>>> for the unlikely case of no signed tags being usable).
>>>
>>> For the patch:
>>>
>>> Reviewed-by: Brian Norris <briannorris@chromium.org>
>>>
>>>> I agree that any randomness should be avoided.
>>>>
>>>> My question is, do we need 15-digits?
>>> ...
>>>> So, I think the conflict happens
>>>> only when we have two commits that start with the same 7-digits
>>>> in the _same_ release. Is this correct?
>>
>> No.
>>
>>> For git-describe (the case where we have a tag to base off):
>>> "use <n> digits, or as many digits as needed to form a unique object name"
>>
>> Yes, the abbreviated hash that `git describe` produces is unique among
>> all objects (and objects are more than just commits) in the current
>> repo, so what matters for probability-of-collision is the total number
>> of objects - linus.git itself probably grows ~60000 objects per release.
>>
>> As for "do we need 15 digits", well, in theory the next time I merge the
>> next rt-stable tag into our kernel I could end up with a commit that
>> matches some existing object in the first 33 hex chars at which point I
>> should have chosen 34 - but of course that's so unlikely that it's
>> irrelevant.
>>
>> But the upshot of that is that there really is no objective answer to
>> "how many digits do we need", so it becomes a tradeoff between "low
>> enough probability that anyone anywhere in the next few years would have
>> needed more than X when building their own kernel" and readability of
>> `uname -r` etc. So I decided somewhat arbitrarily that each time one
>> rolls a new release, there should be less than 1e-9 probability that
>> HEAD collides with some other object when abbreviated to X hexchars.
>> X=12 doesn't pass that criteria even when the repo has only 10M objects
>> (and, current linus.git already has objects that need 12 to be unique,
>> so such collisions do happen in practice, though of course very rarely).
>> 13 and 14 are just weird numbers, so I ended with 15, which also allows
>> many many more objects in the repo before the probability crosses that
>> 1e-9 threshold.
>>
> 
> 
> This is because you use the output from git as-is.
> 
> Why are you still trying to rely on such obscure behavior of git?
> 
> 
> It is pretty easy to get the fixed number of digits reliably.
> 
> For example,
> git rev-parse --verify HEAD 2>/dev/null | cut -c1-7
> 
> 
> It always returns a 7-digits hash,
> and two different people will get the same result for sure.
> 
> Your solution, --short=15, means "at least 15",
> which still contains ambiguity.
> 
> 
> 
> As I already noted, the kernelrelease string is
> constructed in this format:
> 
> <kernel-version>-<number-of-commits-on-top>-<abbreviated-commit-hash>
> 
> 
> For example, if I enable CONFIG_LOCALVERSION_AUTO=y
> in today's Linus tree, I got this:
> 
> 5.9.0-rc5-00005-gfc4f28bb3daf
> 
> 
> What if the number of digits were 7?
> 
> 5.9.0-rc5-00005-gfc4f28b
> 
> I see no problem here.

The problem is that currently, the build relies on things which cannot
easily be controlled or reproduced between different developers: Apart
from git version (which is reasonable to mandate is the same, just like
one must use same compiler, binutils etc. to get binary reproducible
output), it depends on whether ~/.gitconfig has a core.abbrev setting -
and even worse, it depends on the _total number of objects in the source
git repo_, i.e. something that has nothing to do with what is currently
in the work tree at all.

And that leads to real bugs when one builds external modules that end up
in one directory in the rootfs, while `uname -r` tells modprobe to look
in some other directory (differing in the length of the abbreviated hash).

> Even if we have another object that starts with "fc4f28b",
> the kernelrelease string is still unique thanks to the
> <kernel-version>-<number-of-commits-on-top> prefix.
> 
> Why do we care about the uniqueness of the abbreviated
> hash in the whole git history?

Because when I ask a customer "what kernel are you running", and they
tell me "4.19.45-rt67-00567-123abc8", I prefer that 123abc8 uniquely
identifies the right commit, instead of me having to dig around each of
the commits starting with that prefix and see which one of them matches
"is exactly 567 commits from 4.19.45-rt67". 7 hexchars is nowhere near
enough for that today, which is why Linus himself did that "auto-tune
abbrev based on repo size" patch for git.git.

But what I mostly care about is getting a consistent result. And yes,
you're right that the porcelain command 'git describe' could end up
using something more than 15 digits (though that's extremely unlikely).
So if you prefer, I can try to rewrite the logic purely in terms of
plumbing commands. But that's a much more invasive patch, and one would
obviously lose the guarantee of the abbreviation being unique among
current git objects.

Alternatively, would you consider a Kconfig knob, LOCALVERSION_ABBREV?

Rasmus
