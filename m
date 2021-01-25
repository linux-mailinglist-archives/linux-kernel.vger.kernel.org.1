Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA8123038B8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 10:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390869AbhAZJJi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 26 Jan 2021 04:09:38 -0500
Received: from belmont79srvr.owm.bell.net ([184.150.200.79]:53034 "EHLO
        mtlfep01.bell.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730458AbhAYSrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 13:47:04 -0500
X-Greylist: delayed 707 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Jan 2021 13:47:02 EST
Received: from bell.net mtlfep01 184.150.200.30 by mtlfep01.bell.net
          with ESMTP
          id <20210125183428.LZOG120733.mtlfep01.bell.net@mtlspm01.bell.net>;
          Mon, 25 Jan 2021 13:34:28 -0500
Received: from [192.168.2.49] (really [70.50.109.22]) by mtlspm01.bell.net
          with ESMTP
          id <20210125183428.WVFJ130487.mtlspm01.bell.net@[192.168.2.49]>;
          Mon, 25 Jan 2021 13:34:28 -0500
To:     Nick Desaulniers <ndesaulniers@google.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        deller@gmx.de, linux-parisc@vger.kernel.org
Cc:     kbuild-all@lists.01.org, LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        kernel test robot <lkp@intel.com>
References: <202101162230.XswE8zOX-lkp@intel.com>
 <CAKwvOd=rrTLc510cEA84BC_zzYVQ0ifPEMhRRtU-cyYPs_E4eA@mail.gmail.com>
From:   John David Anglin <dave.anglin@bell.net>
Subject: Re: hppa64-linux-ld: mm/hugetlb.o(.text+0x50dc): cannot reach printk
Message-ID: <bed0d008-c5c0-011e-6f1e-fb248f97c009@bell.net>
Date:   Mon, 25 Jan 2021 13:34:28 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAKwvOd=rrTLc510cEA84BC_zzYVQ0ifPEMhRRtU-cyYPs_E4eA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-CM-Analysis: v=2.4 cv=cZIXElPM c=1 sm=1 tr=0 ts=600f0f34 a=S6gQgrXzeH76ECG4GouVuA==:117 a=S6gQgrXzeH76ECG4GouVuA==:17 a=IkcTkHD0fZMA:10 a=EmqxpYm9HcoA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=i-5SCMXTAAAA:20 a=i3X5FwGiAAAA:8 a=FBHGMhGWAAAA:8 a=yRC9fba0LiWuTPqrjCQA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=mmqRlSCDY2ywfjPLJ4af:22 a=9gvnlMMaQFpL9xblJ6ne:22
X-CM-Envelope: MS4xfA3IhXP2MKD/icKKaCQXJ4K0jNVxw4Qp/f30doegR4L/Fo6/24GObNOPOLafHv1xMErOcZ1EE8E5opgA1HhYGKFUw5iMejcavNPaKDNd42hBDqAEfXj/ t+xjxv2FGBaUYG5xIhqWvvdJID9Om4rRjDIe0gpaiH9j7jjUvlydCqpDVpDNQPHKwkmfVSkSPiRu7MDLeiEBPfc8XKNUgAN5ba0iSU/rittIOs1cvCpmaCMr 2ECQmfeE8WToI8fPfFiUbQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For calls, this issue can be avoided with -mlong-calls option.  Without this, 64-bit calls are limited to
a 22-bit pc-relative offset (8 MB).  This does make branches somewhat less efficient.  At the moment,
the 64-bit linker does not support adding branch extending stubs.

Thunks are currently limited to a 17-bit pc-relative offset.

Regards,
Dave

On 2021-01-25 12:54 p.m., Nick Desaulniers wrote:
> I suspect that adding some more sections here makes the distance
> between other sections too large to encode?  IIRC, arm (32b) linker
> can emit "range extending thunks" to help jump large distances.  Not
> sure what to make of this report; I wouldn't have expected this GCC
> randconfig to generate code in any of the sections that were added to
> the linkerscript in
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=eff8728fe69880d3f7983bec3fb6cea4c306261f.
>
> On Sat, Jan 16, 2021 at 6:37 AM kernel test robot <lkp@intel.com> wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   1d94330a437a573cfdf848f6743b1ed169242c8a
>> commit: eff8728fe69880d3f7983bec3fb6cea4c306261f vmlinux.lds.h: Add PGO and AutoFDO input sections
>> date:   5 months ago
>> config: parisc-randconfig-r032-20210116 (attached as .config)
>> compiler: hppa64-linux-gcc (GCC) 9.3.0
>> reproduce (this is a W=1 build):
>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=eff8728fe69880d3f7983bec3fb6cea4c306261f
>>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>         git fetch --no-tags linus master
>>         git checkout eff8728fe69880d3f7983bec3fb6cea4c306261f
>>         # save the attached .config to linux build tree
>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=parisc
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>    hppa64-linux-ld: mm/page_alloc.o(.ref.text+0x110): cannot reach unknown
>>    hppa64-linux-ld: mm/memblock.o(.text+0x27c): cannot reach __warn_printk
>>    hppa64-linux-ld: mm/memblock.o(.meminit.text+0xc4): cannot reach printk
>>    hppa64-linux-ld: mm/memblock.o(.meminit.text+0x140): cannot reach printk
>>    hppa64-linux-ld: mm/memblock.o(.meminit.text+0x1e0): cannot reach memmove
>>    hppa64-linux-ld: mm/memblock.o(.meminit.text+0x314): cannot reach memmove
>>    hppa64-linux-ld: mm/memblock.o(.meminit.text+0x428): cannot reach memmove
>>    hppa64-linux-ld: mm/memblock.o(.meminit.text+0x5d4): cannot reach __warn_printk
>>    hppa64-linux-ld: mm/memblock.o(.meminit.text+0xb20): cannot reach printk
>>    hppa64-linux-ld: mm/memblock.o(.meminit.text+0xce8): cannot reach printk
>>    hppa64-linux-ld: mm/memblock.o(.meminit.text+0xd30): cannot reach printk
>>    hppa64-linux-ld: mm/memblock.o(.meminit.text+0xd4c): cannot reach memcpy
>>    hppa64-linux-ld: mm/memblock.o(.meminit.text+0x1130): cannot reach printk
>>    hppa64-linux-ld: mm/memblock.o(.meminit.text+0x11e0): cannot reach printk
>>    hppa64-linux-ld: mm/memblock.o(.meminit.text+0x16d8): cannot reach printk
>>    hppa64-linux-ld: mm/memblock.o(.meminit.text+0x1788): cannot reach printk
>>    hppa64-linux-ld: mm/memblock.o(.meminit.text+0x1e04): cannot reach printk
>>    hppa64-linux-ld: mm/memblock.o(.meminit.text+0x1e2c): cannot reach printk
>>    hppa64-linux-ld: mm/memblock.o(.init.text+0x24): cannot reach strstr
>>    hppa64-linux-ld: mm/memblock.o(.init.text+0x100): cannot reach __warn_printk
>>    hppa64-linux-ld: mm/memblock.o(.init.text+0x118): cannot reach dump_stack
>>    hppa64-linux-ld: mm/memblock.o(.init.text+0x220): cannot reach printk
>>    hppa64-linux-ld: mm/memblock.o(.init.text+0x48c): cannot reach printk
>>    hppa64-linux-ld: mm/memblock.o(.init.text+0x55c): cannot reach printk
>>    hppa64-linux-ld: mm/memblock.o(.init.text+0x62c): cannot reach printk
>>    hppa64-linux-ld: mm/memblock.o(.init.text+0x720): cannot reach printk
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x4cc): cannot reach _raw_spin_lock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x580): cannot reach _raw_spin_unlock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x690): cannot reach _raw_spin_unlock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x768): cannot reach _raw_spin_unlock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x7c8): cannot reach _raw_spin_lock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x938): cannot reach _raw_spin_lock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x980): cannot reach _raw_spin_unlock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0xaf8): cannot reach sprintf
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0xb60): cannot reach sprintf
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0xbd0): cannot reach sprintf
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0xc38): cannot reach sprintf
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0xcd8): cannot reach _raw_spin_lock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0xcf0): cannot reach _raw_spin_unlock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0xd7c): cannot reach __next_node_in
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0xdb4): cannot reach __next_node_in
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0xeb8): cannot reach _raw_spin_unlock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0xec8): cannot reach _raw_spin_lock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0xf58): cannot reach sprintf
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x1638): cannot reach _raw_spin_lock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x16d8): cannot reach _raw_spin_unlock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x1764): cannot reach _raw_spin_lock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x17d0): cannot reach _raw_spin_unlock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x1974): cannot reach _raw_spin_lock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x1990): cannot reach _raw_spin_unlock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x19b4): cannot reach _raw_spin_lock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x19d4): cannot reach _raw_spin_unlock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x1d88): cannot reach _raw_spin_lock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x1db0): cannot reach _raw_spin_unlock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x2588): cannot reach _raw_spin_lock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x2658): cannot reach _raw_spin_unlock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x26a8): cannot reach _raw_spin_lock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x26e4): cannot reach _raw_spin_unlock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x27b0): cannot reach _raw_spin_lock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x2964): cannot reach _raw_spin_lock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x2984): cannot reach _raw_spin_unlock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x29bc): cannot reach _raw_spin_unlock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x2a00): cannot reach _raw_spin_lock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x2a40): cannot reach _raw_spin_unlock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x2b38): cannot reach _raw_spin_lock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x2b58): cannot reach _raw_spin_unlock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x2c14): cannot reach _raw_spin_unlock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x2c8c): cannot reach _raw_spin_lock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x2ccc): cannot reach _raw_spin_lock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x2df4): cannot reach _raw_spin_unlock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x2ed8): cannot reach _raw_spin_lock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x2f38): cannot reach _raw_spin_unlock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x2f60): cannot reach _raw_spin_lock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x2f84): cannot reach _raw_spin_lock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x2fc8): cannot reach _raw_spin_lock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x3018): cannot reach _raw_spin_unlock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x3044): cannot reach _raw_spin_unlock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x3218): cannot reach _raw_spin_lock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x3308): cannot reach _raw_spin_unlock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x340c): cannot reach __xchg64
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x3580): cannot reach _raw_spin_lock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x35b0): cannot reach _raw_spin_unlock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x3604): cannot reach _raw_spin_unlock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x3aa0): cannot reach _raw_spin_lock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x3b00): cannot reach _raw_spin_unlock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x3efc): cannot reach down_write
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x4484): cannot reach _raw_spin_lock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x46ac): cannot reach _raw_spin_unlock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x4814): cannot reach _raw_spin_lock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x485c): cannot reach _raw_spin_unlock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x48cc): cannot reach _raw_spin_unlock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x4a1c): cannot reach _raw_spin_lock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x4a88): cannot reach _raw_spin_unlock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x4b14): cannot reach _raw_spin_lock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x4c0c): cannot reach _raw_spin_unlock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x4cc0): cannot reach _raw_spin_lock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x4d18): cannot reach _raw_spin_unlock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x4dd4): cannot reach _raw_spin_unlock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x4ed4): cannot reach __muldi3
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x5008): cannot reach sprintf
>>>> hppa64-linux-ld: mm/hugetlb.o(.text+0x50dc): cannot reach printk
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x51bc): cannot reach __muldi3
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x5348): cannot reach _raw_spin_unlock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x535c): cannot reach _raw_spin_unlock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x53d8): cannot reach _raw_spin_lock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x53ec): cannot reach _raw_spin_lock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x565c): cannot reach down_read
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x5890): cannot reach _raw_spin_unlock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x58d4): cannot reach _raw_spin_lock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x59f4): cannot reach _raw_spin_unlock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x5b94): cannot reach _raw_spin_lock_irqsave
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x5bf4): cannot reach _raw_spin_unlock_irqrestore
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x5c14): cannot reach _raw_spin_lock_irqsave
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x5c34): cannot reach _raw_spin_unlock_irqrestore
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x5f58): cannot reach _raw_spin_unlock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x5fdc): cannot reach _raw_spin_lock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x613c): cannot reach _raw_spin_unlock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x6248): cannot reach _raw_spin_lock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x643c): cannot reach down_write
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x64c0): cannot reach _raw_spin_lock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x6690): cannot reach _raw_spin_lock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x66c0): cannot reach _raw_spin_unlock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x69a0): cannot reach _raw_spin_lock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x69c0): cannot reach _raw_spin_unlock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x69d0): cannot reach _raw_spin_unlock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x6a00): cannot reach ___ratelimit
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x6a28): cannot reach printk
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x6a80): cannot reach _raw_spin_lock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x6bf4): cannot reach _raw_spin_unlock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x6d98): cannot reach mutex_unlock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x6de0): cannot reach down_read
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x6df4): cannot reach mutex_lock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x705c): cannot reach _raw_spin_unlock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x7344): cannot reach down_read
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x74ac): cannot reach mutex_lock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x74e0): cannot reach _raw_spin_lock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x7708): cannot reach _raw_spin_unlock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x77b0): cannot reach mutex_unlock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x7830): cannot reach mutex_unlock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x794c): cannot reach _raw_spin_lock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x7978): cannot reach _raw_spin_unlock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x7998): cannot reach mutex_unlock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x7b14): cannot reach _raw_spin_unlock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x7bfc): cannot reach _raw_spin_lock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x7ce4): cannot reach _raw_spin_lock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x7e84): cannot reach _raw_spin_unlock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x7f0c): cannot reach _raw_spin_unlock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x8068): cannot reach _raw_spin_unlock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x8084): cannot reach _raw_spin_unlock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x80b4): cannot reach _raw_spin_unlock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x8240): cannot reach _raw_spin_lock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x8314): cannot reach _raw_spin_unlock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x8518): cannot reach _raw_spin_unlock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x85e0): cannot reach _raw_spin_unlock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x8624): cannot reach _raw_spin_unlock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x87a8): cannot reach _raw_spin_unlock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x8868): cannot reach down_write
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x889c): cannot reach _raw_spin_unlock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x88ec): cannot reach _raw_spin_lock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x8d40): cannot reach _raw_spin_lock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x8d60): cannot reach _raw_spin_unlock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x8d9c): cannot reach _raw_spin_lock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x8db8): cannot reach _raw_spin_unlock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x8e78): cannot reach _raw_spin_lock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x8ea0): cannot reach __muldi3
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x8ec0): cannot reach _raw_spin_unlock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x8fd0): cannot reach __warn_printk
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x9074): cannot reach _raw_spin_unlock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x90a4): cannot reach _raw_spin_lock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x90d4): cannot reach _raw_spin_unlock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x92ec): cannot reach _raw_spin_lock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x9334): cannot reach __cmpxchg_u32
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x93dc): cannot reach _raw_spin_unlock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x9454): cannot reach _raw_spin_lock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x9558): cannot reach _raw_spin_unlock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x969c): cannot reach _raw_spin_lock
>>    hppa64-linux-ld: mm/hugetlb.o(.text+0x96ac): cannot reach _raw_spin_unlock
>>    hppa64-linux-ld: mm/hugetlb.o(.init.text+0x248): cannot reach printk
>>    hppa64-linux-ld: mm/hugetlb.o(.init.text+0x26c): cannot reach printk
>>    hppa64-linux-ld: mm/hugetlb.o(.init.text+0x36c): cannot reach printk
>>    hppa64-linux-ld: mm/hugetlb.o(.init.text+0x3d0): cannot reach printk
>>    hppa64-linux-ld: mm/hugetlb.o(.init.text+0x3ec): cannot reach sscanf
>>    hppa64-linux-ld: mm/hugetlb.o(.init.text+0x568): cannot reach snprintf
>>    hppa64-linux-ld: mm/hugetlb.o(.init.text+0x728): cannot reach printk
>>    hppa64-linux-ld: mm/hugetlb.o(.init.text+0x744): cannot reach printk
>>    hppa64-linux-ld: mm/hugetlb.o(.init.text+0x8d4): cannot reach _raw_spin_lock
>>    hppa64-linux-ld: mm/hugetlb.o(.init.text+0x900): cannot reach _raw_spin_unlock
>>    hppa64-linux-ld: mm/hugetlb.o(.init.text+0xa40): cannot reach printk
>>    hppa64-linux-ld: mm/hugetlb.o(.init.text+0xa70): cannot reach kobject_create_and_add
>>    hppa64-linux-ld: mm/hugetlb.o(.init.text+0xb64): cannot reach kobject_create_and_add
>>    hppa64-linux-ld: mm/hugetlb.o(.init.text+0xb9c): cannot reach kobject_put
>>    hppa64-linux-ld: mm/hugetlb.o(.init.text+0xbb4): cannot reach printk
>>    hppa64-linux-ld: mm/hugetlb.o(.init.text+0xc84): cannot reach __muldi3
>>    hppa64-linux-ld: mm/hugetlb.o(.init.text+0xde8): cannot reach memparse
>>    hppa64-linux-ld: mm/hugetlb.o(.init.text+0xec0): cannot reach printk
>>    hppa64-linux-ld: mm/hugetlb.o(.init.text+0xef0): cannot reach unknown
>>    hppa64-linux-ld: mm/hugetlb.o(.init.text+0xf94): cannot reach memparse
>>    hppa64-linux-ld: mm/hugetlb.o(.init.text+0xfcc): cannot reach printk
>>    hppa64-linux-ld: mm/hugetlb.o(.init.text+0xfe4): cannot reach unknown
>>    hppa64-linux-ld: mm/slab.o(.text+0x490): cannot reach __udivdi3
>>    hppa64-linux-ld: mm/slab.o(.text+0x4ac): cannot reach __umoddi3
>>
>> ---
>> 0-DAY CI Kernel Test Service, Intel Corporation
>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>
>


-- 
John David Anglin  dave.anglin@bell.net


