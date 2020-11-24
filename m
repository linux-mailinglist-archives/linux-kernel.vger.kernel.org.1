Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 946CF2C29D4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 15:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389134AbgKXOiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 09:38:11 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:13343 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388014AbgKXOiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 09:38:11 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UGQV.7L_1606228678;
Received: from IT-FVFX43SYHV2H.lan(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UGQV.7L_1606228678)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 24 Nov 2020 22:37:59 +0800
Subject: Re: INFO: task can't die in shrink_inactive_list (2)
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+e5a33e700b1dd0da20a2@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>, peterz@infradead.org
References: <0000000000000340a105b49441d3@google.com>
 <20201123195452.8ecd01b1fc2ce287dfd6a0d5@linux-foundation.org>
 <97ca8171-c3eb-6462-fcb6-fee53287868a@linux.alibaba.com>
Message-ID: <d129dcc0-8cb5-7b2b-baf3-301c6169a0c5@linux.alibaba.com>
Date:   Tue, 24 Nov 2020 22:35:59 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <97ca8171-c3eb-6462-fcb6-fee53287868a@linux.alibaba.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2020/11/24 ÏÂÎç8:00, Alex Shi Ð´µÀ:
>>> syzbot found the following issue on:
>>>
>>> HEAD commit:    03430750 Add linux-next specific files for 20201116
>>> git tree:       linux-next
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=13f80e5e500000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=a1c4c3f27041fdb8
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=e5a33e700b1dd0da20a2
>>> compiler:       gcc (GCC) 10.1.0-syz 20200507
>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12f7bc5a500000
>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10934cf2500000
> CC Peter Zijlstra.
> 
> I found next-20200821 had a very very similar ops as this.
> https://groups.google.com/g/syzkaller-upstream-moderation/c/S0pyqK1dZv8/m/dxMoEhGdAQAJ
> So does this means the bug exist for long time from 5.9-rc1?
> 
> The reproducer works randomly on a cpu=2, mem=1600M x86 vm. It could cause hung again
> on both kernel, but both with different kernel stack.
> 
> Maybe is system just too busy? I will try more older kernel with the reproducer.

5.8 kernel sometime also failed on this test on my 2 cpus vm guest with 2g memory:
Any comments for this issue?

Thanks
Alex

[ 5875.750929][  T946] INFO: task repro:31866 blocked for more than 143 seconds.
[ 5875.751618][  T946]       Not tainted 5.8.0 #6
[ 5875.752046][  T946] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables th.
[ 5875.752845][  T946] repro           D12088 31866      1 0x80004086
[ 5875.753436][  T946] Call Trace:
[ 5875.753747][  T946]  __schedule+0x394/0x950
[ 5875.774033][  T946]  ? __mutex_lock+0x46f/0x9c0
[ 5875.774481][  T946]  ? blkdev_put+0x18/0x120
[ 5875.774894][  T946]  schedule+0x37/0xe0
[ 5875.775260][  T946]  schedule_preempt_disabled+0xf/0x20
[ 5875.775753][  T946]  __mutex_lock+0x474/0x9c0
[ 5875.776174][  T946]  ? lock_acquire+0xa7/0x390
[ 5875.776602][  T946]  ? locks_remove_file+0x1e7/0x2d0
[ 5875.777079][  T946]  ? blkdev_put+0x18/0x120
[ 5875.777485][  T946]  blkdev_put+0x18/0x120
[ 5875.777880][  T946]  blkdev_close+0x1f/0x30
[ 5875.778281][  T946]  __fput+0xf0/0x260
[ 5875.778639][  T946]  task_work_run+0x68/0xb0
[ 5875.779054][  T946]  do_exit+0x3df/0xce0
[ 5875.779430][  T946]  ? get_signal+0x11d/0xca0
[ 5875.779846][  T946]  do_group_exit+0x42/0xb0
[ 5875.780261][  T946]  get_signal+0x16a/0xca0
[ 5875.780662][  T946]  ? handle_mm_fault+0xc8f/0x19c0
[ 5875.781134][  T946]  do_signal+0x2b/0x8e0
[ 5875.781521][  T946]  ? trace_hardirqs_off+0xe/0xf0
[ 5875.781989][  T946]  __prepare_exit_to_usermode+0xef/0x1f0
[ 5875.782512][  T946]  ? asm_exc_page_fault+0x8/0x30
[ 5875.782979][  T946]  prepare_exit_to_usermode+0x5/0x30
[ 5875.783461][  T946]  asm_exc_page_fault+0x1e/0x30
[ 5875.783909][  T946] RIP: 0033:0x428dd7
[ 5875.794899][  T946] Code: Bad RIP value.
[ 5875.795290][  T946] RSP: 002b:00007f37c99e0d78 EFLAGS: 00010202
[ 5875.795858][  T946] RAX: 0000000020000080 RBX: 0000000000000000 RCX: 0000000076656f
[ 5875.796588][  T946] RDX: 000000000000000c RSI: 00000000004b2370 RDI: 00000000200000
[ 5875.797326][  T946] RBP: 00007f37c99e0da0 R08: 00007f37c99e1700 R09: 00007f37c99e10
[ 5875.798063][  T946] R10: 00007f37c99e19d0 R11: 0000000000000202 R12: 00000000000000
[ 5875.798802][  T946] R13: 0000000000021000 R14: 0000000000000000 R15: 00007f37c99e10
