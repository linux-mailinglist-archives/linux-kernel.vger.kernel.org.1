Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97200303D1D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 13:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403986AbhAZKPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:15:18 -0500
Received: from mout.gmx.net ([212.227.15.18]:60493 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731872AbhAYT1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 14:27:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611602707;
        bh=WD7kwxIaNHhYLM92UP8GGTogzM00eiSS8vNSCVZIrLk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Cu3A2hQQImTUPYaf+CNiZ5iGeHRwDtp332CJBOAdBtsuzS8ZEYMcSm8+zDYoTxUIj
         /PIkv9uikK5YALvOCh5MEs/ek531/IFwVU3js7++EWbzCgJ6TtFOW2MpSj1+5p/Mgm
         PjSuVKy1P/KPRuhzVLfU+WUMEhrVixAcDFWZp55k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.169.109]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDywo-1lBrGB2ocu-00A2DZ; Mon, 25
 Jan 2021 20:25:07 +0100
Subject: Re: hppa64-linux-ld: mm/hugetlb.o(.text+0x50dc): cannot reach printk
To:     John David Anglin <dave.anglin@bell.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-parisc@vger.kernel.org
Cc:     kbuild-all@lists.01.org, LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        kernel test robot <lkp@intel.com>
References: <202101162230.XswE8zOX-lkp@intel.com>
 <CAKwvOd=rrTLc510cEA84BC_zzYVQ0ifPEMhRRtU-cyYPs_E4eA@mail.gmail.com>
 <bed0d008-c5c0-011e-6f1e-fb248f97c009@bell.net>
From:   Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
 c2TFWAS8k6RLkk41ZUU8ENX8+qZx/Q==
Message-ID: <88735d3b-1b56-bc8a-2183-1f9549626002@gmx.de>
Date:   Mon, 25 Jan 2021 20:25:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <bed0d008-c5c0-011e-6f1e-fb248f97c009@bell.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Wr8997aFBZJboRPDdoph52A6OgE4eJFRMnihQaX6lWJ2lS+BRgw
 s8jG9hfaRKKlAtTSDEWoLr2Jlq9bVDKUrhf7/4gzT+LT3vHK3i/N8JU0N5qnOhXOp7MvOde
 /8NTlXj8BWlVxYcgVpzQMZv2jV78HET8T3qPntvtUjIhIFiqQoRPvG2VAXDxXmrQscPAv1I
 Bo+60V4JwWZQE1v02nZug==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:IC8/PXqzOUc=:RZ4cgUlLb4EBcFmDvMeI+0
 8YI541v7gmxuKYgpVwhACunodJz+jrbifomHeLRJxTWrehF3vdg29d2n/TTDt79sMC6ZGe/49
 56p8a3wUFGyyDPyweN89gwmL0BH+yB1PJrzTNzA4LCp0n/Wuf1Ta4ISe5CJgZd2rHKQFmDiux
 D+UcjoErW2tW9dUWt+1H5DOsNb3baIhhzPRXh6A/yz/LD+XLohs2/GQlCpnmykCI1sPUeCqIH
 hOzFpWiwph0s4+coMAnYABJGknY7xjnHxjyGNvhZ5pzULvL0lqKRgACoKnaiKObSrou4SUFWc
 UHFn5x30ZwTmmnoD3RfWN6pDqkPEl7PXr5dvR+Oo3IcLmBIzWiTWkdGdBfsioTIAb6Jc0ILJD
 s078dfSbjk0q7e+zEVCBJ1qSXPbPehu6CO1uiW96mF4PXZNGy1qhBTMEVKb/hXX+WgqElW433
 Upp2aPPPekPxNKNPqYD4xeSZGIBYGR4arZ964ACTPfsP5y1SKl6ReRSA5htFuJRDmlFa+KZDg
 Qf9/KApguAL1ogd+XONZ34vIHsQWs+Ki3xJBGMJhFovb1WQyCnMIkBr5QDn43TSLFa+IuXIyK
 u3ke1A0T/kYEUVuwvJY/I3D+5g6ZSuoJlR4Qn+6P6zz8eAYTf7LNNNwlisRpb5ZOZTKMLAKOR
 EImWi1aE1cpOG+Gc77UK+fLnuq4dS65r9CzaVwbvNNy7eTiK04qRuD/K83S+d0zODEZPS6RcJ
 tQkhuHkGvfTkJXs7sS2lalZlLKeRlX5qkX+dYMW5kkBqp3RPTyk3/If9+4tm6rBoSXowpWXj/
 cSShpBxvng4zXjJJkwriRTjQ4VdYsS2JZnZAHXs4EPuRIMbosqwh7bn2K5iUNzC0AquQV8bQH
 2ppDxOlcW5zuTl7XxHHA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/21 7:34 PM, John David Anglin wrote:
> For calls, this issue can be avoided with -mlong-calls option.=C2=A0 Wit=
hout this, 64-bit calls are limited to
> a 22-bit pc-relative offset (8 MB).=C2=A0 This does make branches somewh=
at less efficient.=C2=A0 At the moment,
> the 64-bit linker does not support adding branch extending stubs.
>
> Thunks are currently limited to a 17-bit pc-relative offset.

When using huge pages, I've tried to set up a lds layout in which
all init functions are in one page which can be deleted afterwards.
I assume that's why they can't be reached.

I'll look into the issue if I can reproduce it.
Will keep you updated.

Helge

> Regards,
> Dave
>
> On 2021-01-25 12:54 p.m., Nick Desaulniers wrote:
>> I suspect that adding some more sections here makes the distance
>> between other sections too large to encode?  IIRC, arm (32b) linker
>> can emit "range extending thunks" to help jump large distances.  Not
>> sure what to make of this report; I wouldn't have expected this GCC
>> randconfig to generate code in any of the sections that were added to
>> the linkerscript in
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3Deff8728fe69880d3f7983bec3fb6cea4c306261f.
>>
>> On Sat, Jan 16, 2021 at 6:37 AM kernel test robot <lkp@intel.com> wrote=
:
>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux=
.git master
>>> head:   1d94330a437a573cfdf848f6743b1ed169242c8a
>>> commit: eff8728fe69880d3f7983bec3fb6cea4c306261f vmlinux.lds.h: Add PG=
O and AutoFDO input sections
>>> date:   5 months ago
>>> config: parisc-randconfig-r032-20210116 (attached as .config)
>>> compiler: hppa64-linux-gcc (GCC) 9.3.0
>>> reproduce (this is a W=3D1 build):
>>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/=
sbin/make.cross -O ~/bin/make.cross
>>>         chmod +x ~/bin/make.cross
>>>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/lin=
ux.git/commit/?id=3Deff8728fe69880d3f7983bec3fb6cea4c306261f
>>>         git remote add linus https://git.kernel.org/pub/scm/linux/kern=
el/git/torvalds/linux.git
>>>         git fetch --no-tags linus master
>>>         git checkout eff8728fe69880d3f7983bec3fb6cea4c306261f
>>>         # save the attached .config to linux build tree
>>>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-9.3.0 make.c=
ross ARCH=3Dparisc
>>>
>>> If you fix the issue, kindly add following tag as appropriate
>>> Reported-by: kernel test robot <lkp@intel.com>
>>>
>>> All errors (new ones prefixed by >>):
>>>
>>>    hppa64-linux-ld: mm/page_alloc.o(.ref.text+0x110): cannot reach unk=
nown
>>>    hppa64-linux-ld: mm/memblock.o(.text+0x27c): cannot reach __warn_pr=
intk
>>>    hppa64-linux-ld: mm/memblock.o(.meminit.text+0xc4): cannot reach pr=
intk
>>>    hppa64-linux-ld: mm/memblock.o(.meminit.text+0x140): cannot reach p=
rintk
>>>    hppa64-linux-ld: mm/memblock.o(.meminit.text+0x1e0): cannot reach m=
emmove
>>>    hppa64-linux-ld: mm/memblock.o(.meminit.text+0x314): cannot reach m=
emmove
>>>    hppa64-linux-ld: mm/memblock.o(.meminit.text+0x428): cannot reach m=
emmove
>>>    hppa64-linux-ld: mm/memblock.o(.meminit.text+0x5d4): cannot reach _=
_warn_printk
>>>    hppa64-linux-ld: mm/memblock.o(.meminit.text+0xb20): cannot reach p=
rintk
>>>    hppa64-linux-ld: mm/memblock.o(.meminit.text+0xce8): cannot reach p=
rintk
>>>    hppa64-linux-ld: mm/memblock.o(.meminit.text+0xd30): cannot reach p=
rintk
>>>    hppa64-linux-ld: mm/memblock.o(.meminit.text+0xd4c): cannot reach m=
emcpy
>>>    hppa64-linux-ld: mm/memblock.o(.meminit.text+0x1130): cannot reach =
printk
>>>    hppa64-linux-ld: mm/memblock.o(.meminit.text+0x11e0): cannot reach =
printk
>>>    hppa64-linux-ld: mm/memblock.o(.meminit.text+0x16d8): cannot reach =
printk
>>>    hppa64-linux-ld: mm/memblock.o(.meminit.text+0x1788): cannot reach =
printk
>>>    hppa64-linux-ld: mm/memblock.o(.meminit.text+0x1e04): cannot reach =
printk
>>>    hppa64-linux-ld: mm/memblock.o(.meminit.text+0x1e2c): cannot reach =
printk
>>>    hppa64-linux-ld: mm/memblock.o(.init.text+0x24): cannot reach strst=
r
>>>    hppa64-linux-ld: mm/memblock.o(.init.text+0x100): cannot reach __wa=
rn_printk
>>>    hppa64-linux-ld: mm/memblock.o(.init.text+0x118): cannot reach dump=
_stack
>>>    hppa64-linux-ld: mm/memblock.o(.init.text+0x220): cannot reach prin=
tk
>>>    hppa64-linux-ld: mm/memblock.o(.init.text+0x48c): cannot reach prin=
tk
>>>    hppa64-linux-ld: mm/memblock.o(.init.text+0x55c): cannot reach prin=
tk
>>>    hppa64-linux-ld: mm/memblock.o(.init.text+0x62c): cannot reach prin=
tk
>>>    hppa64-linux-ld: mm/memblock.o(.init.text+0x720): cannot reach prin=
tk
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x4cc): cannot reach _raw_spin_=
lock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x580): cannot reach _raw_spin_=
unlock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x690): cannot reach _raw_spin_=
unlock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x768): cannot reach _raw_spin_=
unlock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x7c8): cannot reach _raw_spin_=
lock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x938): cannot reach _raw_spin_=
lock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x980): cannot reach _raw_spin_=
unlock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0xaf8): cannot reach sprintf
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0xb60): cannot reach sprintf
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0xbd0): cannot reach sprintf
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0xc38): cannot reach sprintf
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0xcd8): cannot reach _raw_spin_=
lock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0xcf0): cannot reach _raw_spin_=
unlock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0xd7c): cannot reach __next_nod=
e_in
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0xdb4): cannot reach __next_nod=
e_in
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0xeb8): cannot reach _raw_spin_=
unlock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0xec8): cannot reach _raw_spin_=
lock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0xf58): cannot reach sprintf
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x1638): cannot reach _raw_spin=
_lock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x16d8): cannot reach _raw_spin=
_unlock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x1764): cannot reach _raw_spin=
_lock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x17d0): cannot reach _raw_spin=
_unlock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x1974): cannot reach _raw_spin=
_lock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x1990): cannot reach _raw_spin=
_unlock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x19b4): cannot reach _raw_spin=
_lock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x19d4): cannot reach _raw_spin=
_unlock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x1d88): cannot reach _raw_spin=
_lock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x1db0): cannot reach _raw_spin=
_unlock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x2588): cannot reach _raw_spin=
_lock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x2658): cannot reach _raw_spin=
_unlock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x26a8): cannot reach _raw_spin=
_lock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x26e4): cannot reach _raw_spin=
_unlock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x27b0): cannot reach _raw_spin=
_lock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x2964): cannot reach _raw_spin=
_lock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x2984): cannot reach _raw_spin=
_unlock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x29bc): cannot reach _raw_spin=
_unlock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x2a00): cannot reach _raw_spin=
_lock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x2a40): cannot reach _raw_spin=
_unlock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x2b38): cannot reach _raw_spin=
_lock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x2b58): cannot reach _raw_spin=
_unlock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x2c14): cannot reach _raw_spin=
_unlock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x2c8c): cannot reach _raw_spin=
_lock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x2ccc): cannot reach _raw_spin=
_lock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x2df4): cannot reach _raw_spin=
_unlock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x2ed8): cannot reach _raw_spin=
_lock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x2f38): cannot reach _raw_spin=
_unlock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x2f60): cannot reach _raw_spin=
_lock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x2f84): cannot reach _raw_spin=
_lock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x2fc8): cannot reach _raw_spin=
_lock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x3018): cannot reach _raw_spin=
_unlock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x3044): cannot reach _raw_spin=
_unlock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x3218): cannot reach _raw_spin=
_lock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x3308): cannot reach _raw_spin=
_unlock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x340c): cannot reach __xchg64
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x3580): cannot reach _raw_spin=
_lock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x35b0): cannot reach _raw_spin=
_unlock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x3604): cannot reach _raw_spin=
_unlock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x3aa0): cannot reach _raw_spin=
_lock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x3b00): cannot reach _raw_spin=
_unlock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x3efc): cannot reach down_writ=
e
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x4484): cannot reach _raw_spin=
_lock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x46ac): cannot reach _raw_spin=
_unlock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x4814): cannot reach _raw_spin=
_lock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x485c): cannot reach _raw_spin=
_unlock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x48cc): cannot reach _raw_spin=
_unlock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x4a1c): cannot reach _raw_spin=
_lock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x4a88): cannot reach _raw_spin=
_unlock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x4b14): cannot reach _raw_spin=
_lock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x4c0c): cannot reach _raw_spin=
_unlock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x4cc0): cannot reach _raw_spin=
_lock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x4d18): cannot reach _raw_spin=
_unlock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x4dd4): cannot reach _raw_spin=
_unlock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x4ed4): cannot reach __muldi3
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x5008): cannot reach sprintf
>>>>> hppa64-linux-ld: mm/hugetlb.o(.text+0x50dc): cannot reach printk
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x51bc): cannot reach __muldi3
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x5348): cannot reach _raw_spin=
_unlock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x535c): cannot reach _raw_spin=
_unlock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x53d8): cannot reach _raw_spin=
_lock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x53ec): cannot reach _raw_spin=
_lock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x565c): cannot reach down_read
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x5890): cannot reach _raw_spin=
_unlock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x58d4): cannot reach _raw_spin=
_lock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x59f4): cannot reach _raw_spin=
_unlock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x5b94): cannot reach _raw_spin=
_lock_irqsave
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x5bf4): cannot reach _raw_spin=
_unlock_irqrestore
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x5c14): cannot reach _raw_spin=
_lock_irqsave
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x5c34): cannot reach _raw_spin=
_unlock_irqrestore
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x5f58): cannot reach _raw_spin=
_unlock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x5fdc): cannot reach _raw_spin=
_lock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x613c): cannot reach _raw_spin=
_unlock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x6248): cannot reach _raw_spin=
_lock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x643c): cannot reach down_writ=
e
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x64c0): cannot reach _raw_spin=
_lock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x6690): cannot reach _raw_spin=
_lock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x66c0): cannot reach _raw_spin=
_unlock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x69a0): cannot reach _raw_spin=
_lock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x69c0): cannot reach _raw_spin=
_unlock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x69d0): cannot reach _raw_spin=
_unlock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x6a00): cannot reach ___rateli=
mit
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x6a28): cannot reach printk
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x6a80): cannot reach _raw_spin=
_lock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x6bf4): cannot reach _raw_spin=
_unlock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x6d98): cannot reach mutex_unl=
ock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x6de0): cannot reach down_read
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x6df4): cannot reach mutex_loc=
k
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x705c): cannot reach _raw_spin=
_unlock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x7344): cannot reach down_read
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x74ac): cannot reach mutex_loc=
k
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x74e0): cannot reach _raw_spin=
_lock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x7708): cannot reach _raw_spin=
_unlock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x77b0): cannot reach mutex_unl=
ock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x7830): cannot reach mutex_unl=
ock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x794c): cannot reach _raw_spin=
_lock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x7978): cannot reach _raw_spin=
_unlock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x7998): cannot reach mutex_unl=
ock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x7b14): cannot reach _raw_spin=
_unlock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x7bfc): cannot reach _raw_spin=
_lock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x7ce4): cannot reach _raw_spin=
_lock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x7e84): cannot reach _raw_spin=
_unlock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x7f0c): cannot reach _raw_spin=
_unlock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x8068): cannot reach _raw_spin=
_unlock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x8084): cannot reach _raw_spin=
_unlock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x80b4): cannot reach _raw_spin=
_unlock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x8240): cannot reach _raw_spin=
_lock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x8314): cannot reach _raw_spin=
_unlock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x8518): cannot reach _raw_spin=
_unlock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x85e0): cannot reach _raw_spin=
_unlock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x8624): cannot reach _raw_spin=
_unlock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x87a8): cannot reach _raw_spin=
_unlock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x8868): cannot reach down_writ=
e
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x889c): cannot reach _raw_spin=
_unlock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x88ec): cannot reach _raw_spin=
_lock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x8d40): cannot reach _raw_spin=
_lock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x8d60): cannot reach _raw_spin=
_unlock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x8d9c): cannot reach _raw_spin=
_lock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x8db8): cannot reach _raw_spin=
_unlock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x8e78): cannot reach _raw_spin=
_lock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x8ea0): cannot reach __muldi3
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x8ec0): cannot reach _raw_spin=
_unlock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x8fd0): cannot reach __warn_pr=
intk
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x9074): cannot reach _raw_spin=
_unlock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x90a4): cannot reach _raw_spin=
_lock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x90d4): cannot reach _raw_spin=
_unlock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x92ec): cannot reach _raw_spin=
_lock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x9334): cannot reach __cmpxchg=
_u32
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x93dc): cannot reach _raw_spin=
_unlock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x9454): cannot reach _raw_spin=
_lock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x9558): cannot reach _raw_spin=
_unlock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x969c): cannot reach _raw_spin=
_lock
>>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x96ac): cannot reach _raw_spin=
_unlock
>>>    hppa64-linux-ld: mm/hugetlb.o(.init.text+0x248): cannot reach print=
k
>>>    hppa64-linux-ld: mm/hugetlb.o(.init.text+0x26c): cannot reach print=
k
>>>    hppa64-linux-ld: mm/hugetlb.o(.init.text+0x36c): cannot reach print=
k
>>>    hppa64-linux-ld: mm/hugetlb.o(.init.text+0x3d0): cannot reach print=
k
>>>    hppa64-linux-ld: mm/hugetlb.o(.init.text+0x3ec): cannot reach sscan=
f
>>>    hppa64-linux-ld: mm/hugetlb.o(.init.text+0x568): cannot reach snpri=
ntf
>>>    hppa64-linux-ld: mm/hugetlb.o(.init.text+0x728): cannot reach print=
k
>>>    hppa64-linux-ld: mm/hugetlb.o(.init.text+0x744): cannot reach print=
k
>>>    hppa64-linux-ld: mm/hugetlb.o(.init.text+0x8d4): cannot reach _raw_=
spin_lock
>>>    hppa64-linux-ld: mm/hugetlb.o(.init.text+0x900): cannot reach _raw_=
spin_unlock
>>>    hppa64-linux-ld: mm/hugetlb.o(.init.text+0xa40): cannot reach print=
k
>>>    hppa64-linux-ld: mm/hugetlb.o(.init.text+0xa70): cannot reach kobje=
ct_create_and_add
>>>    hppa64-linux-ld: mm/hugetlb.o(.init.text+0xb64): cannot reach kobje=
ct_create_and_add
>>>    hppa64-linux-ld: mm/hugetlb.o(.init.text+0xb9c): cannot reach kobje=
ct_put
>>>    hppa64-linux-ld: mm/hugetlb.o(.init.text+0xbb4): cannot reach print=
k
>>>    hppa64-linux-ld: mm/hugetlb.o(.init.text+0xc84): cannot reach __mul=
di3
>>>    hppa64-linux-ld: mm/hugetlb.o(.init.text+0xde8): cannot reach mempa=
rse
>>>    hppa64-linux-ld: mm/hugetlb.o(.init.text+0xec0): cannot reach print=
k
>>>    hppa64-linux-ld: mm/hugetlb.o(.init.text+0xef0): cannot reach unkno=
wn
>>>    hppa64-linux-ld: mm/hugetlb.o(.init.text+0xf94): cannot reach mempa=
rse
>>>    hppa64-linux-ld: mm/hugetlb.o(.init.text+0xfcc): cannot reach print=
k
>>>    hppa64-linux-ld: mm/hugetlb.o(.init.text+0xfe4): cannot reach unkno=
wn
>>>    hppa64-linux-ld: mm/slab.o(.text+0x490): cannot reach __udivdi3
>>>    hppa64-linux-ld: mm/slab.o(.text+0x4ac): cannot reach __umoddi3
>>>
>>> ---
>>> 0-DAY CI Kernel Test Service, Intel Corporation
>>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>>
>>
>
>

