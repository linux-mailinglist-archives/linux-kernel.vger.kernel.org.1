Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4D192B2C55
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 10:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgKNJCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 04:02:47 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:12746 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbgKNJCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 04:02:46 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4CY8Vm2wftz9vCxX;
        Sat, 14 Nov 2020 10:02:40 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id MII8N_gqyiSc; Sat, 14 Nov 2020 10:02:40 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4CY8Vm1ls4z9vCjb;
        Sat, 14 Nov 2020 10:02:40 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4607C8B788;
        Sat, 14 Nov 2020 10:02:41 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id X5TeAvZWgWaQ; Sat, 14 Nov 2020 10:02:41 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6F28F8B782;
        Sat, 14 Nov 2020 10:02:40 +0100 (CET)
Subject: Re: Error: invalid switch -me200
To:     Segher Boessenkool <segher@kernel.crashing.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Brian Cain <bcain@codeaurora.org>,
        =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <202011131146.g8dPLQDD-lkp@intel.com>
 <CAFP8O3LpSmxVnjHfQAN455k1ZRg3PbgZYhWr030evCq1T10k=Q@mail.gmail.com>
 <20201113190824.GA1477315@ubuntu-m3-large-x86>
 <CAKwvOdkEtTQhDRFRV_d66FyhQBe536vRbOW=fQjesiHz3dfeBA@mail.gmail.com>
 <20201113200444.GA1496675@ubuntu-m3-large-x86>
 <CAKwvOdkBSGPaKmQY1nERVe4_n19Q=MUtuwdond=FJAAF9N9Zhg@mail.gmail.com>
 <20201114002037.GW2672@gate.crashing.org>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <14e9ce2b-1a83-5353-44c7-b0709796c70e@csgroup.eu>
Date:   Sat, 14 Nov 2020 10:02:35 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201114002037.GW2672@gate.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 14/11/2020 à 01:20, Segher Boessenkool a écrit :
> On Fri, Nov 13, 2020 at 12:14:18PM -0800, Nick Desaulniers wrote:
>>>>> Error: invalid switch -me200
>>>>> Error: unrecognized option -me200
>>>>
>>>> 251 cpu-as-$(CONFIG_E200)   += -Wa,-me200
>>>>
>>>> Are those all broken configs, or is Kconfig messed up such that
>>>> randconfig can select these when it should not?
>>>
>>> Hmmm, looks like this flag does not exist in mainline binutils? There is
>>> a thread in 2010 about this that Segher commented on:
>>>
>>> https://lore.kernel.org/linuxppc-dev/9859E645-954D-4D07-8003-FFCD2391AB6E@kernel.crashing.org/
>>>
>>> Guess this config should be eliminated?
> 
> The help text for this config options says that e200 is used in 55xx,
> and there *is* an -me5500 GAS flag (which probably does this same
> thing, too).  But is any of this tested, or useful, or wanted?
> 
> Maybe Christophe knows, cc:ed.
> 

I don't have much clue on this.

But I see on wikipedia that e5500 is a 64 bits powerpc (https://en.wikipedia.org/wiki/PowerPC_e5500)

What I see is that NXP seems to provide a GCC version that includes aditionnal cpu (e200z0 e200z2 
e200z3 e200z4 e200z6 e200z7):

valid arguments to '-mcpu=' are: 401 403 405 405fp 440 440fp 464 464fp 476 476fp 505 601 602 603 
603e 604 604e 620 630 740 7400 7450 750 801 821 823 8540 8548 860 970 G3 G4 G5 a2 cell e200z0 e200z2 
e200z3 e200z4 e200z6 e200z7 e300c2 e300c3 e500mc e500mc64 e5500 e6500 ec603e native power3 power4 
power5 power5+ power6 power6x power7 power8 powerpc powerpc64 powerpc64le rs64 titan "

https://community.nxp.com/t5/MPC5xxx/GCC-generating-not-implemented-instructions/m-p/845049

Apparently based on binutils 2.28

https://www.nxp.com/docs/en/release-note/S32DS-POWER-v1-2-RN.pdf

But that's not exactly -me200 though.

Now, I can't see any defconfig that selects CONFIG_E200, so is that worth keeping it in the kernel 
at all ?

Christophe
