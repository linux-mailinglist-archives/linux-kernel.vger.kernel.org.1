Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61D512FD1C5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 14:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389839AbhATN0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 08:26:12 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48526 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389027AbhATNTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 08:19:03 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: aratiu)
        with ESMTPSA id 0296C1F455A1
From:   Adrian Ratiu <adrian.ratiu@collabora.com>
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Adrian Ratiu <adrian.ratiu@collabora.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        kernel@collabora.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] arm: lib: xor-neon: remove unnecessary GCC < 4.6
 warning
In-Reply-To: <20210119215435.GA1727211@ubuntu-m3-large-x86>
References: <20210119131724.308884-1-adrian.ratiu@collabora.com>
 <20210119131724.308884-2-adrian.ratiu@collabora.com>
 <20210119215435.GA1727211@ubuntu-m3-large-x86>
Date:   Wed, 20 Jan 2021 15:18:17 +0200
Message-ID: <87lfcng31i.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jan 2021, Nathan Chancellor <natechancellor@gmail.com> 
wrote:
> On Tue, Jan 19, 2021 at 03:17:23PM +0200, Adrian Ratiu wrote: 
>> From: Nathan Chancellor <natechancellor@gmail.com>  Drop 
>> warning because kernel now requires GCC >= v4.9 after commit 
>> 6ec4476ac825 ("Raise gcc version requirement to 4.9") and 
>> clarify that -ftree-vectorize now always needs enabling for GCC 
>> by directly testing the presence of CONFIG_CC_IS_GCC.   Another 
>> reason to remove the warning is that Clang exposes itself as 
>> GCC < 4.6 so it triggers the warning about GCC which doesn't 
>> make much sense and misleads Clang users by telling them to 
>> update GCC.   Because Clang is now supported by the kernel 
>> print a clear Clang-specific warning.   Link: 
>> https://github.com/ClangBuiltLinux/linux/issues/496 Link: 
>> https://github.com/ClangBuiltLinux/linux/issues/503 
>> Reported-by: Nick Desaulniers <ndesaulniers@google.com> 
>> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com> 
>> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com> 
>> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com> 
> 
> The commit message looks like it is written by me but I never 
> added a Clang specific warning. I appreciate wanting to give me 
> credit but when you change things about my original commit 
> message, please make it clear that you did the edits, something 
> like: 
> 
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com> 
> [adrian: Add clang specific warning] Signed-off-by: Adrian Ratiu 
> <adrian.ratiu@collabora.com> 
> 

Thanks for the suggestion. Makes sense. I contemplated adding 
another patch by me on top but thought it was too much 
churn. Sorry if my edits were unclear.

>> --- 
>>  arch/arm/lib/xor-neon.c | 18 ++++++++++-------- 1 file 
>>  changed, 10 insertions(+), 8 deletions(-) 
>>  diff --git a/arch/arm/lib/xor-neon.c b/arch/arm/lib/xor-neon.c 
>> index b99dd8e1c93f..f9f3601cc2d1 100644 --- 
>> a/arch/arm/lib/xor-neon.c +++ b/arch/arm/lib/xor-neon.c @@ 
>> -14,20 +14,22 @@ MODULE_LICENSE("GPL"); 
>>  #error You should compile this file with '-march=armv7-a 
>>  -mfloat-abi=softfp -mfpu=neon' #endif  
>> +/* + * TODO: Even though -ftree-vectorize is enabled by 
>> default in Clang, the + * compiler does not produce vectorized 
>> code due to its cost model.  + * See: 
>> https://github.com/ClangBuiltLinux/linux/issues/503 + */ 
>> +#ifdef CONFIG_CC_IS_CLANG +#warning Clang does not vectorize 
>> code in this file.  +#endif 
> 
> I really do not like this. With the GCC specific warning, the 
> user could just upgrade their GCC. With this warning, it is 
> basically telling them don't use clang, in which case, it would 
> just be better to disable this code altogether. I would rather 
> see: 
> 
> 1. Just don't build this file with clang altogether, which I 
> believe was 
>    v1's 2/2 patch. 
> 
> OR 
> 
> 2. Use the pragma: 
> 
> #pragma clang loop vectorize(enable) 
> 
> as Nick suggests in v1's 2/2 patch. 
> 
> Alternatively, __restrict__ sounds like it might be beneficial 
> for both GCC and clang: 
> 
> https://lore.kernel.org/lkml/20201112215033.GA438824@rani.riverdale.lan/ 
> 

Option 1 from v1 got clearly NACKed by Nick a while back so the 
only option gonig forward is to also fix clang vectorization 
together with these changes so the warning becomes unnecessary.

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
