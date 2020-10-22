Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5522961F6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 17:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368850AbgJVP5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 11:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S368843AbgJVP5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 11:57:06 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E974C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 08:57:06 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id l2so2921992lfk.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 08:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FUryJEIXnDLKEMSXSydi6jtnD40HcZjEUUUxEwfqCOg=;
        b=pl+Y8YHzzZxuhuZ+yn7vvTfjDyAZO3oFAeq+K8fjFxkouCCMEHhucqV8PixGcfELES
         0GBxjQWMBiag7aRZyp/m8mvbnK3DdQjAi7cmw0AE+ebDBoa81Mkw4XaErByaaoUH57tP
         HORd9yzHQX/sjvCzvLcXxbRrowPZr5KjneIL8mQynnGkMu2bxiIDSuxbFGZK9mr3rALW
         9JSNR5A7TJR4NyjYEKW102bKabxWCW2GRf4Sy5gpMGGcmsu3e4SjrpfJ6MO7UmkNV/1K
         i+q0JijBaHipdDUJk7Olb9D9ZtCMDIe1RTVq3jT+JzOYSy1c71ig+tnWMZG26GZo7i24
         hExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FUryJEIXnDLKEMSXSydi6jtnD40HcZjEUUUxEwfqCOg=;
        b=DiOcGn+L8AARFHEm5ioTKEA4MblvqGaoRIA6lVRugA/UM0iwj54Pgz6a0t/oo4GEY5
         6ioLrcXKQpcheq6yHJ+/HDHX2TtUccySec3HSlg6qBTcJSzSNK4bbLqRc69OHYn7o/rt
         aAiYlMneLMuHrVrCHa9cdhZg1s+hj/dFBdVnejxbwkbiOpYNxdK9A5/Qhv0gd185mXe4
         plVEpTZ7Sk6xWpw8L8cZJA3yxzcR4D0JvsosdSvtsK1Mt8MFoWSjt1TPQ3fJ4nzzDS0O
         IOnkg2bQi6/bx4OvLMLlRDeRRSC86YDCytDMi4B7cy2RsBVJOuGYVIWLhkOeXXj0A4Nx
         WL+A==
X-Gm-Message-State: AOAM533R6vruZvVz51aoBlGRUFC52TTkT6CeQ5+oPSa9twmqlWzFhjvG
        zfZ/NPN2h9/I7VTHoETxuJc=
X-Google-Smtp-Source: ABdhPJyy65vxcVnWX41tA1iJlap0cTPbGRxI8BZ5phQHTj7HLeC9miZNBgC98HZwRN9lJReV306eYg==
X-Received: by 2002:a19:2408:: with SMTP id k8mr1162845lfk.80.1603382224861;
        Thu, 22 Oct 2020 08:57:04 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-186.dynamic.spd-mgts.ru. [109.252.193.186])
        by smtp.googlemail.com with ESMTPSA id m26sm319986lfq.296.2020.10.22.08.57.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2020 08:57:04 -0700 (PDT)
Subject: Re: [PATCH v1] ARM: vfp: Use long jump to fix THUMB2 kernel
 compilation error
To:     Ard Biesheuvel <ardb@kernel.org>, Kees Cook <keescook@chromium.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Ingo Molnar <mingo@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20201021225737.739-1-digetx@gmail.com>
 <202010211637.7CFD8435@keescook>
 <773fbdb0-5fc4-ab39-e72d-89845faa4c6d@gmail.com>
 <202010212028.32E8A5EF9B@keescook>
 <CAMj1kXHXN56xmuwVG3P93Jjwd+NxXTYHtfibPWg5TUADucOdWg@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <1d2e2b5d-3035-238c-d2ca-14c0c209a6a1@gmail.com>
Date:   Thu, 22 Oct 2020 18:57:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAMj1kXHXN56xmuwVG3P93Jjwd+NxXTYHtfibPWg5TUADucOdWg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

22.10.2020 10:06, Ard Biesheuvel пишет:
> On Thu, 22 Oct 2020 at 05:30, Kees Cook <keescook@chromium.org> wrote:
>>
>> On Thu, Oct 22, 2020 at 03:00:06AM +0300, Dmitry Osipenko wrote:
>>> 22.10.2020 02:40, Kees Cook пишет:
>>>> On Thu, Oct 22, 2020 at 01:57:37AM +0300, Dmitry Osipenko wrote:
>>>>> The vfp_kmode_exception() function now is unreachable using relative
>>>>> branching in THUMB2 kernel configuration, resulting in a "relocation
>>>>> truncated to fit: R_ARM_THM_JUMP19 against symbol `vfp_kmode_exception'"
>>>>> linker error. Let's use long jump in order to fix the issue.
>>>>
>>>> Eek. Is this with gcc or clang?
>>>
>>> GCC 9.3.0
>>>
>>>>> Fixes: eff8728fe698 ("vmlinux.lds.h: Add PGO and AutoFDO input sections")
>>>>
>>>> Are you sure it wasn't 512dd2eebe55 ("arm/build: Add missing sections") ?
>>>> That commit may have implicitly moved the location of .vfp11_veneer,
>>>> though I thought I had chosen the correct position.
>>>
>>> I re-checked that the fixes tag is correct.
>>>
>>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>>> ---
>>>>>  arch/arm/vfp/vfphw.S | 3 ++-
>>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/arch/arm/vfp/vfphw.S b/arch/arm/vfp/vfphw.S
>>>>> index 4fcff9f59947..6e2b29f0c48d 100644
>>>>> --- a/arch/arm/vfp/vfphw.S
>>>>> +++ b/arch/arm/vfp/vfphw.S
>>>>> @@ -82,7 +82,8 @@ ENTRY(vfp_support_entry)
>>>>>    ldr     r3, [sp, #S_PSR]        @ Neither lazy restore nor FP exceptions
>>>>>    and     r3, r3, #MODE_MASK      @ are supported in kernel mode
>>>>>    teq     r3, #USR_MODE
>>>>> -  bne     vfp_kmode_exception     @ Returns through lr
>>>>> +  ldr     r1, =vfp_kmode_exception
>>>>> +  bxne    r1                      @ Returns through lr
>>>>>
>>>>>    VFPFMRX r1, FPEXC               @ Is the VFP enabled?
>>>>>    DBGSTR1 "fpexc %08x", r1
>>>>
>>>> This seems like a workaround though? I suspect the vfp11_veneer needs
>>>> moving?
>>>>
>>>
>>> I don't know where it needs to be moved. Please feel free to make a
>>> patch if you have a better idea, I'll be glad to test it.
>>
>> I might have just been distracted by the common "vfp" prefix. It's
>> possible that the text section shuffling just ended up being very large,
>> so probably this patch is right then!
>>
> 
> I already sent a fix for this issue:
> 
> https://www.armlinux.org.uk/developer/patches/viewpatch.php?id=9018/1
> 

The offending commit contains stable tag, so I assume that fixes tag is
mandatory. Yours patch misses the fixes tag.
