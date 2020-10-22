Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F68F2962B4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 18:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2901795AbgJVQem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 12:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2897232AbgJVQel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 12:34:41 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F24C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 09:34:41 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id a28so2631721ljn.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 09:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=40vMF3ziPu0bTT+J0yUW2LzbplLLn0NsSahmoH7oJZs=;
        b=Qm7k0npENoDRfhOP4QmzDgOhpCgHdeCL8fkCFFKbMySaB7z9o5i6HlS7AOruQLIyf+
         kotLAYkfOrs086VdrINDThTNRQioCjg3qA+gZGlLvIYrFgZWK3Emdepfoa9VihepIQ7o
         2wUQtkpH4nckjMLIMifgQ9/W4q/6KJ3hEhuVV5ucqYGABM6IwQGaQXEbBZqJ5Ooq8/C2
         QJlQblzjLnRk7pNKyqjq/iR60lYiNnIr2g5npZUEN4fj7oFYurBjbMhI7ZwumC/bujYm
         53QTy9SU+JurZjMxCwGhTHecr/34aeMtfjcq1/xNZ7MXnve7RM/4NSuhiFYC07WIuOYN
         JViw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=40vMF3ziPu0bTT+J0yUW2LzbplLLn0NsSahmoH7oJZs=;
        b=VwEWwgbkF/SJzXWYL1XOuKNUKOEfKguPmh3Z0w8QZYRSj/rBrHxAzR3e/GMJ2gcOvA
         Gy/UuLcV0Mm0JqX/cat/pR0ruKS76STO38Ry4VApySuZYO/WMYMlCiJUkAZMsQlCGFtq
         GLHQW3BgyUhMN324sRtLejt9JoV0k6jlAE/O2UR6Z1T0xVdWEjtJD0ZkGgf5SFJWn/fa
         HapzbnrJ3XN9Vfcu2Ugh30iyKWVeCBXeMGUqDtFVScswAAgA/euP3BR5OL1TdTw10Ehi
         5Vf2e5IkLngfTTaG9ySpqTPVT1JCey6eOCqewV1WB5/w3ZGbZcGCAa0k2rwYIrBjwZMJ
         F/wg==
X-Gm-Message-State: AOAM533MwCgXm4R/u+UlwRrCQ51jrVjOCLh+EO2HOvyaJwaacTX4ubau
        MMEuLbqr2aPDriWB9WXT2EY=
X-Google-Smtp-Source: ABdhPJyQWNX16e5/kuwSMP9hA5z2JtTbEHvcH5yedOmwod4Dii8i3TD4ofJIhHLMWCEv7zPftvIZUw==
X-Received: by 2002:a05:651c:20d:: with SMTP id y13mr1328273ljn.425.1603384479618;
        Thu, 22 Oct 2020 09:34:39 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-186.dynamic.spd-mgts.ru. [109.252.193.186])
        by smtp.googlemail.com with ESMTPSA id g22sm331505lfh.31.2020.10.22.09.34.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2020 09:34:39 -0700 (PDT)
Subject: Re: [PATCH v1] ARM: vfp: Use long jump to fix THUMB2 kernel
 compilation error
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Ingo Molnar <mingo@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20201021225737.739-1-digetx@gmail.com>
 <202010211637.7CFD8435@keescook>
 <773fbdb0-5fc4-ab39-e72d-89845faa4c6d@gmail.com>
 <202010212028.32E8A5EF9B@keescook>
 <CAMj1kXHXN56xmuwVG3P93Jjwd+NxXTYHtfibPWg5TUADucOdWg@mail.gmail.com>
 <1d2e2b5d-3035-238c-d2ca-14c0c209a6a1@gmail.com>
 <CAMj1kXERX_Bv1MdfafOVmdmDXPio6Uj897ZZZ7qRERbCXYw_iQ@mail.gmail.com>
 <20201022161118.GP1551@shell.armlinux.org.uk>
 <CAMj1kXGExnUrTuosMpX2NN3=j0HF-8_s1SzLaTyBvq4_LQNT-w@mail.gmail.com>
 <20201022162334.GQ1551@shell.armlinux.org.uk>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <53e78602-6370-aeb1-398b-5c065dd562f8@gmail.com>
Date:   Thu, 22 Oct 2020 19:34:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201022162334.GQ1551@shell.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

22.10.2020 19:23, Russell King - ARM Linux admin пишет:
> On Thu, Oct 22, 2020 at 06:20:40PM +0200, Ard Biesheuvel wrote:
>> On Thu, 22 Oct 2020 at 18:11, Russell King - ARM Linux admin
>> <linux@armlinux.org.uk> wrote:
>>>
>>> On Thu, Oct 22, 2020 at 06:06:32PM +0200, Ard Biesheuvel wrote:
>>>> On Thu, 22 Oct 2020 at 17:57, Dmitry Osipenko <digetx@gmail.com> wrote:
>>>>>
>>>>> 22.10.2020 10:06, Ard Biesheuvel пишет:
>>>>>> On Thu, 22 Oct 2020 at 05:30, Kees Cook <keescook@chromium.org> wrote:
>>>>>>>
>>>>>>> On Thu, Oct 22, 2020 at 03:00:06AM +0300, Dmitry Osipenko wrote:
>>>>>>>> 22.10.2020 02:40, Kees Cook пишет:
>>>>>>>>> On Thu, Oct 22, 2020 at 01:57:37AM +0300, Dmitry Osipenko wrote:
>>>>>>>>>> The vfp_kmode_exception() function now is unreachable using relative
>>>>>>>>>> branching in THUMB2 kernel configuration, resulting in a "relocation
>>>>>>>>>> truncated to fit: R_ARM_THM_JUMP19 against symbol `vfp_kmode_exception'"
>>>>>>>>>> linker error. Let's use long jump in order to fix the issue.
>>>>>>>>>
>>>>>>>>> Eek. Is this with gcc or clang?
>>>>>>>>
>>>>>>>> GCC 9.3.0
>>>>>>>>
>>>>>>>>>> Fixes: eff8728fe698 ("vmlinux.lds.h: Add PGO and AutoFDO input sections")
>>>>>>>>>
>>>>>>>>> Are you sure it wasn't 512dd2eebe55 ("arm/build: Add missing sections") ?
>>>>>>>>> That commit may have implicitly moved the location of .vfp11_veneer,
>>>>>>>>> though I thought I had chosen the correct position.
>>>>>>>>
>>>>>>>> I re-checked that the fixes tag is correct.
>>>>>>>>
>>>>>>>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>>>>>>>> ---
>>>>>>>>>>  arch/arm/vfp/vfphw.S | 3 ++-
>>>>>>>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/arch/arm/vfp/vfphw.S b/arch/arm/vfp/vfphw.S
>>>>>>>>>> index 4fcff9f59947..6e2b29f0c48d 100644
>>>>>>>>>> --- a/arch/arm/vfp/vfphw.S
>>>>>>>>>> +++ b/arch/arm/vfp/vfphw.S
>>>>>>>>>> @@ -82,7 +82,8 @@ ENTRY(vfp_support_entry)
>>>>>>>>>>    ldr     r3, [sp, #S_PSR]        @ Neither lazy restore nor FP exceptions
>>>>>>>>>>    and     r3, r3, #MODE_MASK      @ are supported in kernel mode
>>>>>>>>>>    teq     r3, #USR_MODE
>>>>>>>>>> -  bne     vfp_kmode_exception     @ Returns through lr
>>>>>>>>>> +  ldr     r1, =vfp_kmode_exception
>>>>>>>>>> +  bxne    r1                      @ Returns through lr
>>>>>>>>>>
>>>>>>>>>>    VFPFMRX r1, FPEXC               @ Is the VFP enabled?
>>>>>>>>>>    DBGSTR1 "fpexc %08x", r1
>>>>>>>>>
>>>>>>>>> This seems like a workaround though? I suspect the vfp11_veneer needs
>>>>>>>>> moving?
>>>>>>>>>
>>>>>>>>
>>>>>>>> I don't know where it needs to be moved. Please feel free to make a
>>>>>>>> patch if you have a better idea, I'll be glad to test it.
>>>>>>>
>>>>>>> I might have just been distracted by the common "vfp" prefix. It's
>>>>>>> possible that the text section shuffling just ended up being very large,
>>>>>>> so probably this patch is right then!
>>>>>>>
>>>>>>
>>>>>> I already sent a fix for this issue:
>>>>>>
>>>>>> https://www.armlinux.org.uk/developer/patches/viewpatch.php?id=9018/1
>>>>>>
>>>>>
>>>>> The offending commit contains stable tag, so I assume that fixes tag is
>>>>> mandatory. Yours patch misses the fixes tag.
>>>>
>>>> Russell, mind adding that? Or would you like me to update the patch in
>>>> the patch system?
>>>
>>> Rather than adding the IT, I'm suggesting that we solve it a different
>>> way - ensuring that the two bits of code are co-located. There's no
>>> reason for them to be separated, and the assembly code entry point is
>>> already called indirectly.
>>>
>>> The problem is the assembly ends up in the .text section which ends up
>>> at the start of the binary, but depending on the compiler, functions
>>> in .c files end up in their own sections. It would be good if, as
>>> Dmitry has shown that it is indeed possible, to have them co-located.
>>
>> Why is that better? I provided a minimal fix which has zero impact on
>> ARM builds, and minimal impact on Thumb2 builds, given that it retains
>> the exact same semantics as before, but using a different opcode.
> 
> I think you just described the reason there. Why should we force
> everything to use a different opcode when a short jump _should_
> suffice?
> 
> Your patch may be a single line, but it has a slightly greater
> impact than the alternative two line solution.
> 

But the two line change isn't portable to stable kernels as-is, isn't it?
