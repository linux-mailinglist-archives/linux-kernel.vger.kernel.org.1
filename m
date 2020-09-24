Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47CDC276603
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 03:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgIXBsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 21:48:21 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:37943 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725208AbgIXBsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 21:48:21 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0U9uw7o0_1600912112;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U9uw7o0_1600912112)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 24 Sep 2020 09:48:33 +0800
Subject: Re: a bug on 5.9-rc6
To:     Yang Shi <shy828301@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, Qian Cai <cai@lca.pw>
References: <c41149a8-211e-390b-af1d-d5eee690fecb@linux.alibaba.com>
 <f9ae9d60-8cdd-c3a8-d6f9-6f84be29c2ea@linux.alibaba.com>
 <CAHbLzkqkK2qqsUznZvOteCRA1C2dhZq-bXAPdWcwO1_0ihRYeg@mail.gmail.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <0ceec009-4b4f-444a-6102-3d7030ed74a8@linux.alibaba.com>
Date:   Thu, 24 Sep 2020 09:46:19 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAHbLzkqkK2qqsUznZvOteCRA1C2dhZq-bXAPdWcwO1_0ihRYeg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2020/9/24 上午8:31, Yang Shi 写道:
> Looks like the same problem as
> https://lore.kernel.org/linux-mm/a46e9bbef2ed4e17778f5615e818526ef848d791.camel@redhat.com/
> 

Right, At least they share the same path:

[ 1841.628726]  bad_page.cold.130+0x63/0x93
[ 1841.632776]  free_pcp_prepare+0x20b/0x250
[ 1841.636908]  free_unref_page+0x18/0x90

CC: Qian Cai.

Thanks!
Alex

> 
> On Wed, Sep 23, 2020 at 5:24 PM Alex Shi <alex.shi@linux.alibaba.com> wrote:
>>
>>
>> 在 2020/9/22 下午10:03, Alex Shi 写道:
>>>
>>> I just found a bug on recent upstream kernel on my x86 box.
>>>       325d0eab4f31 Merge branch 'akpm' (patches from Andrew)
>>> The last good kernel I known is 5.9-rc2.
>>
>>
>> This bug still exist on 5.9-rc6.
>>
>> I found it in doing stress kernel build on swapping, while run
>> kernel selftest's vmtest like:
>>         for ((i=0;i<8000;i++)); do ./run_vmtests ; sleep 1; done
>>
>> It take time.
>> I will try to do bisect when things down in hands.
>>
>> Thanks
>> Alex
>>>
>>> Thanks
>>> Alex
>>>
>>> Linux aliy8 5.9.0-rc5-00156-g325d0eab4f31 #88 SMP PREEMPT Mon Sep 21 08:48:19 CST 2020 x86_64 x86_64 x86_64 GNU/Linux
>>>
>>>  1841.488609] BUG: Bad page state in process userfaultfd  pfn:1a7d7
>>> [ 1841.494930] page:00000000ec5d2f1e refcount:0 mapcount:0 mapping:0000000000000000 index:0x7fd6181a6 pfn:0x1a7d7
>>> [ 1841.505080] flags: 0xfffffc0080004(uptodate|swapbacked)
>>> [ 1841.510427] raw: 000fffffc0080004 dead000000000100 dead000000000122 0000000000000000
>>> [ 1841.518318] raw: 00000007fd6181a6 0000000000000000 00000000ffffffff 0000000000000000
>>> [ 1841.526207] page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
>>> [ 1841.532775] Modules linked in: loop xt_addrtype br_netfilter xt_CHECKSUM iptable_mangle xt_MASQUERADE iptable_nat nf_nat xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ipt_REJECT nf_reject_ipv4 tun bridge stp llc overlay ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter dm_mirror dm_region_hash dm_log dm_mod ipmi_ssif intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel glue_helper crypto_simd cryptd pcspkr i2c_i801 joydev i2c_smbus mei_me mei ipmi_si ipmi_devintf ipmi_msghandler ip_tables ext4 mbcache jbd2 crc32c_intel drm_vram_helper drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops drm_ttm_helper ttm drm ahci libahci libata virtio_net net_failover failover
>>> [ 1841.603813] CPU: 0 PID: 26221 Comm: userfaultfd Kdump: loaded Tainted: G S  B   W         5.9.0-rc5-00156-g325d0eab4f31 #88
>>> [ 1841.615080] Hardware name: Alibaba X-Dragon CN 01/20G4B, BIOS 1ALSP017 04/09/2019
>>> [ 1841.622701] Call Trace:
>>> [ 1841.625280]  dump_stack+0x8d/0xc0
>>> [ 1841.628726]  bad_page.cold.130+0x63/0x93
>>> [ 1841.632776]  free_pcp_prepare+0x20b/0x250
>>> [ 1841.636908]  free_unref_page+0x18/0x90
>>> [ 1841.640780]  wp_page_copy+0x2cd/0x5d0
>>> [ 1841.644569]  __handle_mm_fault+0x791/0x7a0
>>> [ 1841.648790]  ? handle_mm_fault+0x4b/0x3f0
>>> [ 1841.652925]  handle_mm_fault+0x16f/0x3f0
>>> [ 1841.656968]  exc_page_fault+0x3cb/0x6a0
>>> [ 1841.660920]  ? asm_exc_page_fault+0x8/0x30
>>> [ 1841.665131]  asm_exc_page_fault+0x1e/0x30
>>> [ 1841.669259] RIP: 0033:0x7fd625da6d5d
>>> [ 1841.672957] Code: 00 00 89 77 10 89 f2 49 8d 70 16 4c 89 c7 81 e2 80 00 00 00 e9 04 6c 00 00 0f 1f 40 00 81 e6 80 00 00 00 bf 01 00 00 00 31 c0 <f0> 41 0f b1 38 0f 85 24 01 00 00 64 8b 04 25 d0 02 00 00 41 89 40
>>> [ 1841.691889] RSP: 002b:00007fd6147b2e58 EFLAGS: 00010246
>>> [ 1841.697239] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000000027da
>>> [ 1841.704497] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000001
>>> [ 1841.711759] RBP: 00007fd6147b2f10 R08: 00007fd6181a6000 R09: 00007fd6147b2eb0
>>> [ 1841.719028] R10: 000000000000000f R11: 0000000000000206 R12: 0000000000000000
>>> [ 1841.726286] R13: 0000000001001000 R14: 0000000000000000 R15: 00007fd6147b3700
>>>
>>
