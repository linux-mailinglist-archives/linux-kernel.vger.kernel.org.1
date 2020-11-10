Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF542AE474
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 00:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732378AbgKJXyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 18:54:47 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:32774 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732345AbgKJXyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 18:54:46 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: aratiu)
        with ESMTPSA id 0F4511F4565A
From:   Adrian Ratiu <adrian.ratiu@collabora.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Russell King <linux@armlinux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH 2/2] arm: lib: xor-neon: disable clang vectorization
In-Reply-To: <CAKwvOdkm3u83TQDBB-fC0TwKZCFXGh5sAfahKXxA+mnzgDid_w@mail.gmail.com>
References: <20201106051436.2384842-1-adrian.ratiu@collabora.com>
 <20201106051436.2384842-3-adrian.ratiu@collabora.com>
 <20201106101419.GB3811063@ubuntu-m3-large-x86>
 <87wnyyvh56.fsf@collabora.com>
 <CAKwvOdkodob0M0r_AK_4nG3atLGMyNENMd6qVAHSPa92Zh7UZA@mail.gmail.com>
 <871rh2i9xg.fsf@iwork.i-did-not-set--mail-host-address--so-tickle-me>
 <CAKwvOdkm3u83TQDBB-fC0TwKZCFXGh5sAfahKXxA+mnzgDid_w@mail.gmail.com>
Date:   Wed, 11 Nov 2020 01:56:22 +0200
Message-ID: <87sg9ghil5.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Nov 2020, Nick Desaulniers <ndesaulniers@google.com> 
wrote:
> On Mon, Nov 9, 2020 at 11:51 AM Adrian Ratiu 
> <adrian.ratiu@collabora.com> wrote: 
>> 
>> On Fri, 06 Nov 2020, Nick Desaulniers <ndesaulniers@google.com> 
>> wrote: 
>> > +#pragma clang loop vectorize(enable) 
>> >         do { 
>> >                 p1[0] ^= p2[0] ^ p3[0] ^ p4[0] ^ p5[0]; p1[1] 
>> >                 ^= p2[1] ^ p3[1] ^ p4[1] ^ p5[1]; 
>> > ``` seems to generate the vectorized code. 
>> > 
>> > Why don't we find a way to make those pragma's more toolchain 
>> > portable, rather than open coding them like I have above 
>> > rather than this series? 
>> 
>> Hi again Nick, 
>> 
>> How did you verify the above pragmas generate correct 
>> vectorized code?  Have you tested this specific use case? 
> 
> I read the disassembly before and after my suggested use of 
> pragmas; look for vld/vstr.  You can also add 
> -Rpass-missed=loop-vectorize to CFLAGS_xor-neon.o in 
> arch/arm/lib/Makefile and rebuild arch/arm/lib/xor-neon.o with 
> CONFIG_BTRFS enabled. 
> 
>> 
>> I'm asking because overrulling the cost model might not be 
>> enough, the only thing I can confirm is that the generated code 
>> is changed, but not that it is correct in any way. The object 
>> disasm also looks weird, but I don't have enough knowledge to 
>> start debugging what's happening within LLVM/Clang itself. 
> 
> It doesn't "look weird" to me. The loop is versioned based on a 
> comparison whether the parameters alias or not. There's a 
> non-vectorized version if the parameters are equal or close 
> enough to overlap.  There's another version of the loop that's 
> vectorized.  If you want just the vectorized version, then you 
> have to mark the parameters as __restrict qualified, then check 
> that all callers are ok with that. 
> 

Thank you for the explanation, that does make sense now. I'm just 
a compiler optimization noob, sorry. All your help is much 
appreciated.

>> 
>> I also get some new warnings with your code [1], besides the 
>> previously 'vectorization was possible but not beneficial' 
>> which is still present. It is quite funny because these two 
>> warnings seem to contradict themselves. :) 
> 
> From which compiler?  ``` $ clang 
> -Wpass-failed=transform-warning -c -x c /dev/null warning: 
> unknown warning option '-Wpass-failed=transform-warning'; did 
> you mean '-Wprofile-instr-missing'? [-Wunknown-warning-option] 
> ``` 

I'm using Clang 10.0.1-1 from the Arch Linux repo.

In the LLVM sources that transform-warning appears to be 
documented under 
llvm-10.0.1.src/docs/Passes.rst:1227:-transform-warning

Here's a build log: http://ix.io/2DIc

I always get those warnings with the pragma change you suggested, 
even on clean builds on latest linux-next.

I looked at the Arch PKGBUILD and they don't appear to do anything 
special other than patching to enable SSP and PIE by default (eg 
llvm bug 13410).

> 
> The pragma is clang specific, hence my recommendation to wrap it 
> in an #ifdef __clang__. 
>

Yes, I understand that. :)
 
>> 
>> At this point I do not trust the compiler and am inclined to do 
> 
> Nonsense. 
> 
>> like was done for GCC when it was broken: disable the 
>> optimization and warn users to upgrade after the compiler is 
>> fixed and confirmed to work. 
>> 
>> If you agree I can send a v2 with this and also drop the GCC 
>> pragma as Arvind and Ard suggested. 
> 
> If you resend "this" as in 2/2, I will NACK it.  There's nothing 
> wrong with the cost model; it's saying there's little point in 
> generating the vectorized version because you're still going to 
> need a non-vectorized loop version anyways.  Claiming there is a 
> compiler bug here is dubious just because the cost models 
> between two compilers differ slightly.

Ok, so that "remark" from the compiler is safe to ignore.

> 
> Resend the patch removing the warning, remove the GCC pragma, 
> but if you want to change anything here for Clang, use `#pragma 
> clang loop vectorize(enable)` wrapped in an `#ifdef __clang__`. 
>

Thanks for making the NACK clear, so the way forward is to either 
use the pragma if I can figure out the new 'loop not vectorized' 
warning (which might also be a red herring) or just leave Clang as 
is. :)

>>
>> Kind regards,
>> Adrian
>>
>> [1]
>> ./include/asm-generic/xor.h:11:1: warning: loop not vectorized:
>> the optimizer was unable to perform the requested transformation;
>> the transformation might be disabled or specified as part of an
>> unsupported transformation ordering
>> [-Wpass-failed=transform-warning] xor_8regs_2(unsigned long bytes,
>> unsigned long *p1, unsigned long *p2)
>
>
> -- 
> Thanks,
> ~Nick Desaulniers
