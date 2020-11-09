Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9A4D2AC579
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 20:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730582AbgKITvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 14:51:54 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41918 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730047AbgKITvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 14:51:54 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: aratiu)
        with ESMTPSA id 1FCDD1F45004
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
In-Reply-To: <CAKwvOdkodob0M0r_AK_4nG3atLGMyNENMd6qVAHSPa92Zh7UZA@mail.gmail.com>
References: <20201106051436.2384842-1-adrian.ratiu@collabora.com>
 <20201106051436.2384842-3-adrian.ratiu@collabora.com>
 <20201106101419.GB3811063@ubuntu-m3-large-x86>
 <87wnyyvh56.fsf@collabora.com>
 <CAKwvOdkodob0M0r_AK_4nG3atLGMyNENMd6qVAHSPa92Zh7UZA@mail.gmail.com>
Date:   Mon, 09 Nov 2020 21:53:31 +0200
Message-ID: <871rh2i9xg.fsf@iwork.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Nov 2020, Nick Desaulniers <ndesaulniers@google.com> 
wrote:
> On Fri, Nov 6, 2020 at 3:50 AM Adrian Ratiu 
> <adrian.ratiu@collabora.com> wrote: 
>> 
>> Hi Nathan, 
>> 
>> On Fri, 06 Nov 2020, Nathan Chancellor 
>> <natechancellor@gmail.com> wrote: 
>> > + Ard, who wrote this code. 
>> > 
>> > On Fri, Nov 06, 2020 at 07:14:36AM +0200, Adrian Ratiu wrote: 
>> >> Due to a Clang bug [1] neon autoloop vectorization does not 
>> >> happen or happens badly with no gains and considering 
>> >> previous GCC experiences which generated unoptimized code 
>> >> which was worse than the default asm implementation, it is 
>> >> safer to default clang builds to the known good generic 
>> >> implementation.  The kernel currently supports a minimum 
>> >> Clang version of v10.0.1, see commit 1f7a44f63e6c 
>> >> ("compiler-clang: add build check for clang 10.0.1").   When 
>> >> the bug gets eventually fixed, this commit could be reverted 
>> >> or, if the minimum clang version bump takes a long time, a 
>> >> warning could be added for users to upgrade their compilers 
>> >> like was done for GCC.   [1] 
>> >> https://bugs.llvm.org/show_bug.cgi?id=40976  Signed-off-by: 
>> >> Adrian Ratiu <adrian.ratiu@collabora.com> 
>> > 
>> > Thank you for the patch! We are also tracking this here: 
>> > 
>> > https://github.com/ClangBuiltLinux/linux/issues/496 
>> > 
>> > It was on my TODO to revist getting the warning eliminated, 
>> > which likely would have involved a patch like this as well. 
>> > 
>> > I am curious if it is worth revisting or dusting off Arnd's 
>> > patch in the LLVM bug tracker first. I have not tried it 
>> > personally. If that is not a worthwhile option, I am fine 
>> > with this for now. It would be nice to try and get a fix 
>> > pinned down on the LLVM side at some point but alas, finite 
>> > amount of resources and people :( 
>> 
>> I tested Arnd's kernel patch from the LLVM bugtracker [1], but 
>> with the Clang v10.0.1 I still get warnings like the following 
>> even though the __restrict workaround seems to affect the 
>> generated instructions: 
>> 
>> ./include/asm-generic/xor.h:15:2: remark: the cost-model 
>> indicates that interleaving is not beneficial 
>> [-Rpass-missed=loop-vectorize] 
>> ./include/asm-generic/xor.h:11:1: remark: List vectorization 
>> was possible but not beneficial with cost 0 >= 0 
>> [-Rpass-missed=slp-vectorizer] xor_8regs_2(unsigned long bytes, 
>> unsigned long *__restrict p1, unsigned long *__restrict p2) 
> 
> If it's just a matter of overruling the cost model #pragma clang 
> loop vectorize(enable) 
> 
> will do the trick. 
> 
> Indeed, ``` diff --git a/include/asm-generic/xor.h 
> b/include/asm-generic/xor.h index b62a2a56a4d4..8796955498b7 
> 100644 --- a/include/asm-generic/xor.h +++ 
> b/include/asm-generic/xor.h @@ -12,6 +12,7 @@ 
> xor_8regs_2(unsigned long bytes, unsigned long *p1, unsigned 
> long *p2) 
>  { 
>         long lines = bytes / (sizeof (long)) / 8; 
> 
> +#pragma clang loop vectorize(enable) 
>         do { 
>                 p1[0] ^= p2[0]; p1[1] ^= p2[1]; 
> @@ -32,6 +33,7 @@ xor_8regs_3(unsigned long bytes, unsigned long 
> *p1, unsigned long *p2, 
>  { 
>         long lines = bytes / (sizeof (long)) / 8; 
> 
> +#pragma clang loop vectorize(enable) 
>         do { 
>                 p1[0] ^= p2[0] ^ p3[0]; p1[1] ^= p2[1] ^ p3[1]; 
> @@ -53,6 +55,7 @@ xor_8regs_4(unsigned long bytes, unsigned long 
> *p1, unsigned long *p2, 
>  { 
>         long lines = bytes / (sizeof (long)) / 8; 
> 
> +#pragma clang loop vectorize(enable) 
>         do { 
>                 p1[0] ^= p2[0] ^ p3[0] ^ p4[0]; p1[1] ^= p2[1] ^ 
>                 p3[1] ^ p4[1]; 
> @@ -75,6 +78,7 @@ xor_8regs_5(unsigned long bytes, unsigned long 
> *p1, unsigned long *p2, 
>  { 
>         long lines = bytes / (sizeof (long)) / 8; 
> 
> +#pragma clang loop vectorize(enable) 
>         do { 
>                 p1[0] ^= p2[0] ^ p3[0] ^ p4[0] ^ p5[0]; p1[1] ^= 
>                 p2[1] ^ p3[1] ^ p4[1] ^ p5[1]; 
> ``` seems to generate the vectorized code. 
> 
> Why don't we find a way to make those pragma's more toolchain 
> portable, rather than open coding them like I have above rather 
> than this series? 

Hi again Nick,

How did you verify the above pragmas generate correct vectorized 
code?  Have you tested this specific use case?

I'm asking because overrulling the cost model might not be enough, 
the only thing I can confirm is that the generated code is 
changed, but not that it is correct in any way. The object disasm 
also looks weird, but I don't have enough knowledge to start 
debugging what's happening within LLVM/Clang itself.

I also get some new warnings with your code [1], besides the 
previously 'vectorization was possible but not beneficial' which 
is still present. It is quite funny because these two warnings 
seem to contradict themselves. :)

At this point I do not trust the compiler and am inclined to do 
like was done for GCC when it was broken: disable the optimization 
and warn users to upgrade after the compiler is fixed and 
confirmed to work.

If you agree I can send a v2 with this and also drop the GCC 
pragma as Arvind and Ard suggested.

Kind regards,
Adrian

[1]
./include/asm-generic/xor.h:11:1: warning: loop not vectorized: 
the optimizer was unable to perform the requested transformation; 
the transformation might be disabled or specified as part of an 
unsupported transformation ordering 
[-Wpass-failed=transform-warning] xor_8regs_2(unsigned long bytes, 
unsigned long *p1, unsigned long *p2) 


>
> -- 
> Thanks,
> ~Nick Desaulniers
