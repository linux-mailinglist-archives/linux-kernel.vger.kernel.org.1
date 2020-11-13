Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8835E2B19A9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 12:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgKMLKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 06:10:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbgKMLGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 06:06:10 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308E3C061A4E
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 03:05:45 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: aratiu)
        with ESMTPSA id 723CD1F468E1
From:   Adrian Ratiu <adrian.ratiu@collabora.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Arvind Sankar <nivedita@alum.mit.edu>, kernel@collabora.com,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] arm: lib: xor-neon: remove unnecessary GCC < 4.6
 warning
In-Reply-To: <CAMj1kXFbLRTvGuRt5J3-oEuJrrHFV9+SBGFFDNsAftGUbwoTPw@mail.gmail.com>
References: <20201112212457.2042105-1-adrian.ratiu@collabora.com>
 <20201112212457.2042105-2-adrian.ratiu@collabora.com>
 <CAMj1kXFbLRTvGuRt5J3-oEuJrrHFV9+SBGFFDNsAftGUbwoTPw@mail.gmail.com>
Date:   Fri, 13 Nov 2020 13:07:21 +0200
Message-ID: <87mtzljz12.fsf@iwork.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

On Fri, 13 Nov 2020, Ard Biesheuvel <ardb@kernel.org> wrote:
> On Thu, 12 Nov 2020 at 22:23, Adrian Ratiu 
> <adrian.ratiu@collabora.com> wrote: 
>> 
>> From: Nathan Chancellor <natechancellor@gmail.com> 
>> 
>> Drop warning because kernel now requires GCC >= v4.9 after 
>> commit 6ec4476ac825 ("Raise gcc version requirement to 4.9"). 
>> 
>> Reported-by: Nick Desaulniers <ndesaulniers@google.com> 
>> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com> 
>> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com> 
> 
> Again, this does not do what it says on the tin. 
> 
> If you want to disable the pragma for Clang, call that out in 
> the commit log, and don't hide it under a GCC version change.

I am not doing anything for Clang in this series.

The option to auto-vectorize in Clang is enabled by default but 
doesn't work for some reason (likely to do with how it computes 
the cost model, so maybe not even a bug at all) and if we enable 
it explicitely (eg via a Clang specific pragma) we get some 
warnings we currently do not understand, so I am not changing the 
Clang behaviour at the recommendation of Nick.

So this is only for GCC as the "tin" says :) We can fix clang 
separately as the Clang bug has always been present and is 
unrelated.

> 
> Without the pragma, the generated code is the same as the 
> generic code, so it makes no sense to build xor-neon.ko at all, 
> right? 
>

Yes that is correct and that is the reason why in v1 I opted to 
not build xor-neon.ko for Clang anymore, but that got NACKed, so 
here I'm fixing the low hanging fruit: the very obvious & clear 
GCC problems.


>> ---
>>  arch/arm/lib/xor-neon.c | 9 +--------
>>  1 file changed, 1 insertion(+), 8 deletions(-)
>>
>> diff --git a/arch/arm/lib/xor-neon.c b/arch/arm/lib/xor-neon.c
>> index b99dd8e1c93f..e1e76186ec23 100644
>> --- a/arch/arm/lib/xor-neon.c
>> +++ b/arch/arm/lib/xor-neon.c
>> @@ -19,15 +19,8 @@ MODULE_LICENSE("GPL");
>>   * -ftree-vectorize) to attempt to exploit implicit parallelism and emit
>>   * NEON instructions.
>>   */
>> -#if __GNUC__ > 4 || (__GNUC__ == 4 && __GNUC_MINOR__ >= 6)
>> +#ifdef CONFIG_CC_IS_GCC
>>  #pragma GCC optimize "tree-vectorize"
>> -#else
>> -/*
>> - * While older versions of GCC do not generate incorrect code, they fail to
>> - * recognize the parallel nature of these functions, and emit plain ARM code,
>> - * which is known to be slower than the optimized ARM code in asm-arm/xor.h.
>> - */
>> -#warning This code requires at least version 4.6 of GCC
>>  #endif
>>
>>  #pragma GCC diagnostic ignored "-Wunused-variable"
>> --
>> 2.29.2
>>
