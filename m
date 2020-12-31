Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20DA32E7D81
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Dec 2020 01:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbgLaAjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 19:39:06 -0500
Received: from mga06.intel.com ([134.134.136.31]:40962 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbgLaAjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 19:39:06 -0500
IronPort-SDR: QgOBoX9SNfkztQyAfUXIoPqsSfQ+oB267J67ptsStmfsJSKkV4fxD1NqDYjvA0rrjnRRmsl8Cw
 cZbpWEC3g6QQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9850"; a="238208001"
X-IronPort-AV: E=Sophos;i="5.78,462,1599548400"; 
   d="scan'208";a="238208001"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2020 16:38:24 -0800
IronPort-SDR: kPJYKoMwI6pXg9DAma481Sf49+NNWrqZE3OmDWpvurQO7Drd9nlQYnS36h7iB1T6mwIsulqK5d
 RfQpuHbAW7Ng==
X-IronPort-AV: E=Sophos;i="5.78,462,1599548400"; 
   d="scan'208";a="348037595"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.117]) ([10.239.13.117])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2020 16:38:20 -0800
Subject: Re: [LKP] Re: [kasan] 97593cad00: RIP:kasan_record_aux_stack
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        kernel test robot <oliver.sang@intel.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>
References: <20201230031436.GB22185@xsang-OptiPlex-9020>
 <CAHk-=wgGVoa0jzo5CmtHHmAD44qX+aaa6GOEATiABPKh3Lh5Xg@mail.gmail.com>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <3fdd267a-5a4f-fee8-e0ee-94d1b5229f81@intel.com>
Date:   Thu, 31 Dec 2020 08:37:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgGVoa0jzo5CmtHHmAD44qX+aaa6GOEATiABPKh3Lh5Xg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/31/20 4:49 AM, Linus Torvalds wrote:
> On Tue, Dec 29, 2020 at 6:59 PM kernel test robot <oliver.sang@intel.com> wrote:
>> [  235.553325] BUG: sleeping function called from invalid context at arch/x86/mm/fault.c:1351
>> [  235.554684] in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 7515, name: trinity-c1
>> [  235.555890] 2 locks held by trinity-c1/7515:
>> [  235.556506]  #0: ffffffff8323dd38 (&ids->rwsem){....}-{3:3}, at: semctl_down+0x6d/0x686
>> [  235.557684]  #1: ffff888128ccc868 (&mm->mmap_lock#2){....}-{3:3}, at: do_user_addr_fault+0x196/0x59e
>> [  235.559020] CPU: 1 PID: 7515 Comm: trinity-c1 Not tainted 5.10.0-g97593cad003c #2
>> [  235.560317] Call Trace:
>> [  235.560767]  dump_stack+0x7d/0xa3
>> [  235.561371]  ___might_sleep+0x2c4/0x2df
>> [  235.562063]  ? do_user_addr_fault+0x196/0x59e
>> [  235.562834]  do_user_addr_fault+0x234/0x59e
>> [  235.563519]  exc_page_fault+0x70/0x8b
>> [  235.564112]  asm_exc_page_fault+0x1b/0x20
> Btw, I wonder if the kernel test robot dumps could be please run through the
>
>   scripts/decode_stacktrace.sh
>
> script to give line numbers and inlining information?
>
> That does require CONFIG_DEBUG_INFO to work, but it would help things
> like this when you don't have to try to guess where the exact access
> happens.
>
> Now, in this case, it seems to be a recursive issue with the original
> fault happening in:
>
>> [  235.564754] RIP: 0010:kasan_record_aux_stack+0x64/0x74
> And yeah, that explains why it then bisects to 97593cad003c ("kasan:
> sanitize objects when metadata doesn't fit")
>
> The faulting instruction sequence decodes to
>
>    10:   48 39 f3                cmp    %rsi,%rbx
>    13:   48 0f 46 f3             cmovbe %rbx,%rsi
>    17:   e8 6f e5 ff ff          callq  .. something ..
>    1c:   bf 00 08 00 00          mov    $0x800,%edi
>    21:   48 89 c3                mov    %rax,%rbx
>    24:*  8b 40 08                mov    0x8(%rax),%eax           <--
> trapping instruction
>    27:   89 43 0c                mov    %eax,0xc(%rbx)
>
> and I *think* that "call something" is the call to
> kasan_get_alloc_meta. And there is no check for a NULL return.
>
> So I think this was already fixed by commit 13384f6125ad ("kasan: fix
> null pointer dereference in kasan_record_aux_stack").
>
> But see about that "decode_stacktrace,sh" script request. I thought I
> had already asked for this, but I now realize that I think that was
> just for syzbot.
>
> Can we do that for these kernel test robot reports too? Please?
>
>               Linus

Hi Linus,

Sorry for the inconvenience and we're working on it right now.

Happy New Year!

Best Regards,
Rong Chen

