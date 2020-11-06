Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6C462A95C3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 12:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbgKFLuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 06:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbgKFLuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 06:50:19 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB6FC0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 03:50:19 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: aratiu)
        with ESMTPSA id 952321F40EB1
From:   Adrian Ratiu <adrian.ratiu@collabora.com>
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH 2/2] arm: lib: xor-neon: disable clang vectorization
In-Reply-To: <20201106101419.GB3811063@ubuntu-m3-large-x86>
References: <20201106051436.2384842-1-adrian.ratiu@collabora.com>
 <20201106051436.2384842-3-adrian.ratiu@collabora.com>
 <20201106101419.GB3811063@ubuntu-m3-large-x86>
Date:   Fri, 06 Nov 2020 13:50:13 +0200
Message-ID: <87wnyyvh56.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,

On Fri, 06 Nov 2020, Nathan Chancellor <natechancellor@gmail.com> 
wrote:
> + Ard, who wrote this code. 
> 
> On Fri, Nov 06, 2020 at 07:14:36AM +0200, Adrian Ratiu wrote: 
>> Due to a Clang bug [1] neon autoloop vectorization does not 
>> happen or happens badly with no gains and considering previous 
>> GCC experiences which generated unoptimized code which was 
>> worse than the default asm implementation, it is safer to 
>> default clang builds to the known good generic implementation. 
>> The kernel currently supports a minimum Clang version of 
>> v10.0.1, see commit 1f7a44f63e6c ("compiler-clang: add build 
>> check for clang 10.0.1").   When the bug gets eventually fixed, 
>> this commit could be reverted or, if the minimum clang version 
>> bump takes a long time, a warning could be added for users to 
>> upgrade their compilers like was done for GCC.   [1] 
>> https://bugs.llvm.org/show_bug.cgi?id=40976  Signed-off-by: 
>> Adrian Ratiu <adrian.ratiu@collabora.com> 
> 
> Thank you for the patch! We are also tracking this here: 
> 
> https://github.com/ClangBuiltLinux/linux/issues/496 
> 
> It was on my TODO to revist getting the warning eliminated, 
> which likely would have involved a patch like this as well. 
> 
> I am curious if it is worth revisting or dusting off Arnd's 
> patch in the LLVM bug tracker first. I have not tried it 
> personally. If that is not a worthwhile option, I am fine with 
> this for now. It would be nice to try and get a fix pinned down 
> on the LLVM side at some point but alas, finite amount of 
> resources and people :( 

I tested Arnd's kernel patch from the LLVM bugtracker [1], but 
with the Clang v10.0.1 I still get warnings like the following 
even though the __restrict workaround seems to affect the 
generated instructions:

./include/asm-generic/xor.h:15:2: remark: the cost-model indicates 
that interleaving is not beneficial [-Rpass-missed=loop-vectorize] 
./include/asm-generic/xor.h:11:1: remark: List vectorization was 
possible but not beneficial with cost 0 >= 0 
[-Rpass-missed=slp-vectorizer] xor_8regs_2(unsigned long bytes, 
unsigned long *__restrict p1, unsigned long *__restrict p2)

[1] https://bugs.llvm.org/show_bug.cgi?id=40976#c6

> 
> Should no other options come to fruition from further 
> discussions, you can carry my tag forward: 
> 
> Acked-by: Nathan Chancellor <natechancellor@gmail.com> 
> 
> Hopefully others can comment soon.

In my opinion we have 3 ways to go regarding this:

1. Leave it as is and try to notify the user of the breakage (eg 
add a new warning). You previously said this is not a good idea 
because the user can't do anything about it. I agree.

2. Somehow work around the compiler bug in the kernel which is 
what the LLVM bugtracker patch tries to do. This is a slippery 
slope even if we somehow get it right, especially since multiple 
Clang versions might be supported in the future and we don't know 
when the bug will be properly fixed by the compiler. In addition 
we're enabling and "hiding" possibly undefined behaviour.

3. Disable the broken feature and once the compiler bug is fixed 
enable it back warning users of old compilers that there is an 
action they can take: upgrade. This is exactly how this was 
handled for GCC previously, so there is a precedent.

This implements the 3'rd scenario which is also the first thing 
Arnd suggested in the original patch. :)

Adrian

>
>> ---
>>  arch/arm/include/asm/xor.h | 3 ++-
>>  arch/arm/lib/Makefile      | 3 +++
>>  arch/arm/lib/xor-neon.c    | 4 ++++
>>  3 files changed, 9 insertions(+), 1 deletion(-)
>> 
>> diff --git a/arch/arm/include/asm/xor.h b/arch/arm/include/asm/xor.h
>> index aefddec79286..49937dafaa71 100644
>> --- a/arch/arm/include/asm/xor.h
>> +++ b/arch/arm/include/asm/xor.h
>> @@ -141,7 +141,8 @@ static struct xor_block_template xor_block_arm4regs = {
>>  		NEON_TEMPLATES;			\
>>  	} while (0)
>>  
>> -#ifdef CONFIG_KERNEL_MODE_NEON
>> +/* disabled on clang/arm due to https://bugs.llvm.org/show_bug.cgi?id=40976 */
>> +#if defined(CONFIG_KERNEL_MODE_NEON) && !defined(CONFIG_CC_IS_CLANG)
>>  
>>  extern struct xor_block_template const xor_block_neon_inner;
>>  
>> diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
>> index 6d2ba454f25b..53f9e7dd9714 100644
>> --- a/arch/arm/lib/Makefile
>> +++ b/arch/arm/lib/Makefile
>> @@ -43,8 +43,11 @@ endif
>>  $(obj)/csumpartialcopy.o:	$(obj)/csumpartialcopygeneric.S
>>  $(obj)/csumpartialcopyuser.o:	$(obj)/csumpartialcopygeneric.S
>>  
>> +# disabled on clang/arm due to https://bugs.llvm.org/show_bug.cgi?id=40976
>> +ifndef CONFIG_CC_IS_CLANG
>>  ifeq ($(CONFIG_KERNEL_MODE_NEON),y)
>>    NEON_FLAGS			:= -march=armv7-a -mfloat-abi=softfp -mfpu=neon
>>    CFLAGS_xor-neon.o		+= $(NEON_FLAGS)
>>    obj-$(CONFIG_XOR_BLOCKS)	+= xor-neon.o
>>  endif
>> +endif
>> diff --git a/arch/arm/lib/xor-neon.c b/arch/arm/lib/xor-neon.c
>> index e1e76186ec23..84c91c48dfa2 100644
>> --- a/arch/arm/lib/xor-neon.c
>> +++ b/arch/arm/lib/xor-neon.c
>> @@ -18,6 +18,10 @@ MODULE_LICENSE("GPL");
>>   * Pull in the reference implementations while instructing GCC (through
>>   * -ftree-vectorize) to attempt to exploit implicit parallelism and emit
>>   * NEON instructions.
>> +
>> + * On Clang the loop vectorizer is enabled by default, but due to a bug
>> + * (https://bugs.llvm.org/show_bug.cgi?id=40976) vectorization is broke
>> + * so xor-neon is disabled in favor of the default reg implementations.
>>   */
>>  #ifdef CONFIG_CC_IS_GCC
>>  #pragma GCC optimize "tree-vectorize"
>> -- 
>> 2.29.0
>> 
