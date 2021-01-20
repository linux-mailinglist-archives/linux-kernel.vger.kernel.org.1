Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 343AE2FD26E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 15:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390368AbhATOMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 09:12:55 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48428 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389152AbhATNMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 08:12:13 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: aratiu)
        with ESMTPSA id 971571F454EF
From:   Adrian Ratiu <adrian.ratiu@collabora.com>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Adrian Ratiu <adrian.ratiu@collabora.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Collabora Kernel ML <kernel@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] arm: lib: xor-neon: remove unnecessary GCC < 4.6
 warning
In-Reply-To: <CAKwvOdkNZ09kkzi+A8diaxViqSufxrHizuBu-7quG6an3Z8iDA@mail.gmail.com>
References: <20210119131724.308884-1-adrian.ratiu@collabora.com>
 <20210119131724.308884-2-adrian.ratiu@collabora.com>
 <CAKwvOdkNZ09kkzi+A8diaxViqSufxrHizuBu-7quG6an3Z8iDA@mail.gmail.com>
Date:   Wed, 20 Jan 2021 15:11:27 +0200
Message-ID: <87o8hjg3cw.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jan 2021, Nick Desaulniers <ndesaulniers@google.com> 
wrote:
> On Tue, Jan 19, 2021 at 5:17 AM Adrian Ratiu 
> <adrian.ratiu@collabora.com> wrote: 
>> 
>> From: Nathan Chancellor <natechancellor@gmail.com> 
>> 
>> Drop warning because kernel now requires GCC >= v4.9 after 
>> commit 6ec4476ac825 ("Raise gcc version requirement to 4.9") 
>> and clarify that -ftree-vectorize now always needs enabling for 
>> GCC by directly testing the presence of CONFIG_CC_IS_GCC. 
>> 
>> Another reason to remove the warning is that Clang exposes 
>> itself as GCC < 4.6 so it triggers the warning about GCC which 
>> doesn't make much sense and misleads Clang users by telling 
>> them to update GCC. 
>> 
>> Because Clang is now supported by the kernel print a clear 
>> Clang-specific warning. 
>> 
>> Link: https://github.com/ClangBuiltLinux/linux/issues/496 Link: 
>> https://github.com/ClangBuiltLinux/linux/issues/503 
>> Reported-by: Nick Desaulniers <ndesaulniers@google.com> 
>> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com> 
> 
> This is not the version of the patch I had reviewed; please drop 
> my reviewed-by tag when you change a patch significantly, as 
> otherwise it looks like I approved this patch. 
> 
> Nacked-by: Nick Desaulniers <ndesaulniers@google.com> 
> 

Sorry for not removing the reviewed-by tags from the previous 
versions in this v4. I guess the only way forward with this is to 
actually make clang vectorization work. Also thanks for the patch 
suggestion in the other e-mail!

>> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
>> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
>> ---
>>  arch/arm/lib/xor-neon.c | 18 ++++++++++--------
>>  1 file changed, 10 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/arm/lib/xor-neon.c b/arch/arm/lib/xor-neon.c
>> index b99dd8e1c93f..f9f3601cc2d1 100644
>> --- a/arch/arm/lib/xor-neon.c
>> +++ b/arch/arm/lib/xor-neon.c
>> @@ -14,20 +14,22 @@ MODULE_LICENSE("GPL");
>>  #error You should compile this file with '-march=armv7-a -mfloat-abi=softfp -mfpu=neon'
>>  #endif
>>
>> +/*
>> + * TODO: Even though -ftree-vectorize is enabled by default in Clang, the
>> + * compiler does not produce vectorized code due to its cost model.
>> + * See: https://github.com/ClangBuiltLinux/linux/issues/503
>> + */
>> +#ifdef CONFIG_CC_IS_CLANG
>> +#warning Clang does not vectorize code in this file.
>> +#endif
>
> Arnd, remind me again why it's a bug that the compiler's cost model
> says it's faster to not produce a vectorized version of these loops?
> I stand by my previous comment: https://bugs.llvm.org/show_bug.cgi?id=40976#c8
>
>> +
>>  /*
>>   * Pull in the reference implementations while instructing GCC (through
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
>> 2.30.0
>>
>
>
> -- 
> Thanks,
> ~Nick Desaulniers
