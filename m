Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94CE6268513
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 08:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgINGmj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 14 Sep 2020 02:42:39 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3097 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726033AbgINGmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 02:42:38 -0400
Received: from dggeme701-chm.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id AAD4F3BF067353C133EB;
        Mon, 14 Sep 2020 14:42:35 +0800 (CST)
Received: from dggeme753-chm.china.huawei.com (10.3.19.99) by
 dggeme701-chm.china.huawei.com (10.1.199.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Mon, 14 Sep 2020 14:42:35 +0800
Received: from dggeme753-chm.china.huawei.com ([10.7.64.70]) by
 dggeme753-chm.china.huawei.com ([10.7.64.70]) with mapi id 15.01.1913.007;
 Mon, 14 Sep 2020 14:42:35 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     syzbot <syzbot+c5d5a51dcbb558ca0cb5@syzkaller.appspotmail.com>
CC:     Hillf Danton <hdanton@sina.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Subject: Re: general protection fault in unlink_file_vma
Thread-Topic: general protection fault in unlink_file_vma
Thread-Index: AdaKYYsoZHV5jjgSQ2GCPR6aoXlAWw==
Date:   Mon, 14 Sep 2020 06:42:35 +0000
Message-ID: <c18bd0f194854077bbab3c50bab98c92@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.176.109]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, 08 Sep 2020 17:19:17 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    59126901 Merge tag 'perf-tools-fixes-for-v5.9-2020-09-03' ..
> git tree:       upstream
> console output: 
> https://syzkaller.appspot.com/x/log.txt?x=1166cb5d900000
> kernel config:  
> https://syzkaller.appspot.com/x/.config?x=3c5f6ce8d5b68299
> dashboard link: https://syzkaller.appspot.com/bug?extid=c5d5a51dcbb558ca0cb5
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11901e95900000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15f56195900000
> 
> Bisection is inconclusive: the issue happens on the oldest tested release.
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1205faed900000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=1105faed900000
> console output: 
> https://syzkaller.appspot.com/x/log.txt?x=1605faed900000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+c5d5a51dcbb558ca0cb5@syzkaller.appspotmail.com
> 
> general protection fault, probably for non-canonical address 
> 0xe00eeaee0000003b: 0000 [#1] PREEMPT SMP KASAN
> KASAN: maybe wild-memory-access in range 
> [0x00777770000001d8-0x00777770000001df]
> CPU: 1 PID: 10488 Comm: syz-executor721 Not tainted 
> 5.9.0-rc3-syzkaller #0 Hardware name: Google Google Compute 
> Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:unlink_file_vma+0x57/0xb0 mm/mmap.c:164
> Code: 4c 8b a5 a0 00 00 00 4d 85 e4 74 4e e8 92 d7 cd ff 49 8d bc 24 
> d8 01 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 
> 02 00 75 3d 4d 8b b4 24 d8 01 00 00 4d 8d 6e 78 4c 89 ef e8
> RSP: 0018:ffffc9000ac0f9b0 EFLAGS: 00010202
> RAX: dffffc0000000000 RBX: ffff88800010ceb0 RCX: ffffffff81592421
> RDX: 000eeeee0000003b RSI: ffffffff81a6736e RDI: 00777770000001d8
> RBP: ffff88800010ceb0 R08: 0000000000000001 R09: ffff88801291a50f
> R10: ffffed10025234a1 R11: 0000000000000001 R12: 0077777000000000
> R13: 00007f1eea0da000 R14: 00007f1eea0d9000 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffff8880ae700000(0000) 
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f1eea11a9d0 CR3: 000000000007e000 CR4: 00000000001506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400 Call 
> Trace:
>  free_pgtables+0x1b3/0x2f0 mm/memory.c:415
>  exit_mmap+0x2c0/0x530 mm/mmap.c:3184
>  __mmput+0x122/0x470 kernel/fork.c:1076
>  mmput+0x53/0x60 kernel/fork.c:1097
>  exit_mm kernel/exit.c:483 [inline]
>  do_exit+0xa8b/0x29f0 kernel/exit.c:793
>  do_group_exit+0x125/0x310 kernel/exit.c:903
>  get_signal+0x428/0x1f00 kernel/signal.c:2757
>  arch_do_signal+0x82/0x2520 arch/x86/kernel/signal.c:811  
> exit_to_user_mode_loop kernel/entry/common.c:136 [inline]
>  exit_to_user_mode_prepare+0x1ae/0x200 kernel/entry/common.c:167
>  syscall_exit_to_user_mode+0x7e/0x2e0 kernel/entry/common.c:242
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9

#syz test: https://github.com/Linmiaohe/linux/ 796cd8f497d5b62b00667229375326381c32bdb3

