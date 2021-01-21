Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5432FF2D0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 19:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389186AbhAUSGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 13:06:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389339AbhAUSEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 13:04:41 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935BBC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 10:04:01 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id n11so3543075lji.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 10:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ZaQ9JwnlXJ14EcuibceFnjSmIN2N3K/Ssq5x/m1Zvnw=;
        b=I4m6aRptanmWA6ts5zYmtzpWST16ASQ3LP4pgVf+TRV1MSLc8UYT8K6D3u9chcGKvL
         XnMN4G1lkiS77vzF4L3ir5TeoTar/l08e+uTcqowJZHpBSJsDzLoCiTyCl0rg+BiSPL/
         YWuGDb5OaaHUz4UXwEx0YLW+uZV1lqmsmBkWj1famZnU7iFqAVK5YK3VWb8ZRhYgPECA
         xErXvKrvT+pj6USB1dZVFfSBWlowJLeqhvWFsRAhRS2e7p1uOfiu4nezpVcBdpTHu31c
         HrCHNJ8kQHn/ul7MyKkSm49m6xVNu865FMaMyl70B0UcDPyDfKlqSQNdhZK3Qn44kMdn
         L4Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ZaQ9JwnlXJ14EcuibceFnjSmIN2N3K/Ssq5x/m1Zvnw=;
        b=OED3BswE3D5l5fiCsQUh9VF4HdGy2ife1jK8q/Iy7cUNU9Bf78StjoCO9DBm0HjV26
         2KcSGtfFln+XQ/rpoIQu1dMncDui8TdQTcBdZ0TAAcfYCQyvUdcKu5n1Le8QbDSFvaU1
         6iZ2tXnLX0wNEBz5JGEcojxOt3lx/8iTFbWxuCrOVY4cyfAbt5MWLJE0ihAH0WV6+PAV
         Kd+9zmOF8wjEyMrB196hFRVa5vdsdvhg3Q0YlFKHmL11o2IrooWsW/PF0/KsCvcmc8Tm
         MyhglhAZUL0G9h00JXlac0e1AYx6Y970SWtg3g7vPNWW45QbfoxTEHXoKoUdeZfs4x7S
         nxfA==
X-Gm-Message-State: AOAM532v6tSyAZ/wgqgNDsty7Ou/ZWuEWQe1GYNn/9qcFc9KFv1jSY+D
        qx0WHArztUtk6RBI2y/1h/kCZRcYjhyBxPBv7rVZCORXUVAGjg==
X-Google-Smtp-Source: ABdhPJzYwXi25irKO9Hcu1eorgpWa8+lEUpArQCOuoDCVCNv4x0E7EAscpgzcOWUQtYcT5VxCE88jWYa9TFllIthrtY=
X-Received: by 2002:a05:651c:39c:: with SMTP id e28mr262318ljp.81.1611252239590;
 Thu, 21 Jan 2021 10:03:59 -0800 (PST)
MIME-Version: 1.0
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Thu, 21 Jan 2021 23:03:47 +0500
Message-ID: <CABXGCsMvRzY_JHH4cPtxQ3nsYrsEJFgD0Wh5Aimx+iGB8GnY3g@mail.gmail.com>
Subject: BUG: KASAN: use-after-free in __list_add_valid+0x81/0xa0 (5.11-rc4)
To:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Cc:     keescook@chromium.org, paulmck@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,
I am testing new kernels under high load and KASAN found some troubles:

BUG: KASAN: use-after-free in __list_add_valid+0x81/0xa0
Read of size 8 at addr ffff8881f2cda008 by task ThreadPoolForeg/110220

CPU: 22 PID: 110220 Comm: ThreadPoolForeg Tainted: G        W
--------- ---  5.11.0-0.rc4.20210120git45dfb8a5659a.131.fc34.x86_64 #1
Hardware name: System manufacturer System Product Name/ROG STRIX
X570-I GAMING, BIOS 3402 01/13/2021
Call Trace:
 dump_stack+0xae/0xe5
 print_address_description.constprop.0+0x18/0x160
 ? __list_add_valid+0x81/0xa0
 kasan_report.cold+0x7f/0x10e
 ? lock_contended+0xb10/0xbe0
 ? __list_add_valid+0x81/0xa0
 __list_add_valid+0x81/0xa0
 do_compact_page+0x8bf/0x2720
 ? z3fold_zpool_free+0x92d/0x1150
 ? lock_contended+0xbe0/0xbe0
 zswap_free_entry+0xfa/0x1b0
 zswap_frontswap_invalidate_page+0x14a/0x1a0
 __frontswap_invalidate_page+0x104/0x1c0
 swap_range_free+0x2ad/0x350
 swapcache_free_entries+0x1e1/0x300
 free_swap_slot+0x1d2/0x290
 ? enable_swap_slots_cache+0x90/0x90
 __swap_entry_free+0x109/0x130
 ? __swap_entry_free_locked+0x1a0/0x1a0
 free_swap_and_cache+0xb3/0x100
 ? get_swap_page_of_type+0x160/0x160
 unmap_page_range+0xf3c/0x23e0
 ? lock_downgrade+0x6b0/0x6b0
 ? lru_add_drain_cpu+0x182/0x670
 ? vm_normal_page_pmd+0x350/0x350
 zap_page_range+0x289/0x400
 ? unmap_vmas+0x250/0x250
 ? lock_downgrade+0x6b0/0x6b0
 ? lock_acquire+0x31d/0x7a0
 ? __init_rwsem+0x1a0/0x1a0
 ? find_vma_prev+0x21/0x1d0
 do_madvise.part.0+0x10b6/0x2060
 ? do_wp_page+0x311/0xca0
 ? madvise_cold+0x1c0/0x1c0
 ? do_user_addr_fault+0x432/0x9b0
 ? __x64_sys_madvise+0xd8/0x140
 __x64_sys_madvise+0xd8/0x140
 do_syscall_64+0x33/0x40
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f662cf620cb
Code: c3 66 0f 1f 44 00 00 48 8b 15 a1 7d 0c 00 f7 d8 64 89 02 b8 ff
ff ff ff eb bc 0f 1f 44 00 00 f3 0f 1e fa b8 1c 00 00 00 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 8b 0d 75 7d 0c 00 f7 d8 64 89 01 48
RSP: 002b:00007f66038f4668 EFLAGS: 00000206 ORIG_RAX: 000000000000001c
RAX: ffffffffffffffda RBX: 0000000000000008 RCX: 00007f662cf620cb
RDX: 0000000000000004 RSI: 0000000000008000 RDI: 00003cb26d246000
RBP: 00007f66038f4690 R08: 0000000000000000 R09: aaaaaaaa00000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000008000
R13: 00000003cb26d246 R14: 00003cb26d24e000 R15: 00003cb26d246000

The buggy address belongs to the page:
page:00000000d921a94d refcount:0 mapcount:-128
mapping:0000000000000000 index:0x1 pfn:0x1f2cda
flags: 0x17ffffc0000000()
raw: 0017ffffc0000000 ffffea0007cb3a48 ffffea0007cb3588 0000000000000000
raw: 0000000000000001 0000000000000000 00000000ffffff7f 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8881f2cd9f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff8881f2cd9f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff8881f2cda000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                      ^
 ffff8881f2cda080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff8881f2cda100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================
list_add corruption. next->prev should be prev (ffffe8fffd662670), but
was 0000000000672100. (next=ffff8881f2cda000).
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:23!
invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 22 PID: 107597 Comm: kworker/u64:2 Tainted: G    B   W
--------- ---  5.11.0-0.rc4.20210120git45dfb8a5659a.131.fc34.x86_64 #1

$ /usr/src/kernels/`uname -r`/scripts/faddr2line
/lib/debug/lib/modules/`uname -r`/vmlinux __list_add_valid+0x81
__list_add_valid+0x81/0xa0:
__list_add_valid at lib/list_debug.c:23

$ git checkout 45dfb8a5659a
Previous HEAD position was 19c329f68089 Linux 5.11-rc4
HEAD is now at 45dfb8a5659a Merge tag 'task_work-2021-01-19' of
git://git.kernel.dk/linux-block

$ git blame lib/list_debug.c -L14,33
Blaming lines:  32% (20/62), done.
199a9afc3dbe9 (Dave Jones     2006-09-29 01:59:00 -0700 14) /*
d7c816733d501 (Kees Cook      2016-08-17 14:42:08 -0700 15)  * Check
that the data structures for the list manipulations are reasonably
d7c816733d501 (Kees Cook      2016-08-17 14:42:08 -0700 16)  * valid.
Failures here indicate memory corruption (and possibly an exploit
d7c816733d501 (Kees Cook      2016-08-17 14:42:08 -0700 17)  * attempt).
199a9afc3dbe9 (Dave Jones     2006-09-29 01:59:00 -0700 18)  */
199a9afc3dbe9 (Dave Jones     2006-09-29 01:59:00 -0700 19)
d7c816733d501 (Kees Cook      2016-08-17 14:42:08 -0700 20) bool
__list_add_valid(struct list_head *new, struct list_head *prev,
d7c816733d501 (Kees Cook      2016-08-17 14:42:08 -0700 21)
       struct list_head *next)
199a9afc3dbe9 (Dave Jones     2006-09-29 01:59:00 -0700 22) {
85caa95b9f19b (Kees Cook      2017-02-24 15:00:38 -0800 23)     if
(CHECK_DATA_CORRUPTION(next->prev != prev,
68c1f08203f2b (Matthew Wilcox 2018-04-10 16:33:06 -0700 24)
         "list_add corruption. next->prev should be prev (%px), but
was %px. (next=%px).\n",
85caa95b9f19b (Kees Cook      2017-02-24 15:00:38 -0800 25)
         prev, next->prev, next) ||
85caa95b9f19b (Kees Cook      2017-02-24 15:00:38 -0800 26)
CHECK_DATA_CORRUPTION(prev->next != next,
68c1f08203f2b (Matthew Wilcox 2018-04-10 16:33:06 -0700 27)
         "list_add corruption. prev->next should be next (%px), but
was %px. (prev=%px).\n",
85caa95b9f19b (Kees Cook      2017-02-24 15:00:38 -0800 28)
         next, prev->next, prev) ||
85caa95b9f19b (Kees Cook      2017-02-24 15:00:38 -0800 29)
CHECK_DATA_CORRUPTION(new == prev || new == next,
68c1f08203f2b (Matthew Wilcox 2018-04-10 16:33:06 -0700 30)
         "list_add double add: new=%px, prev=%px, next=%px.\n",
85caa95b9f19b (Kees Cook      2017-02-24 15:00:38 -0800 31)
         new, prev, next))
85caa95b9f19b (Kees Cook      2017-02-24 15:00:38 -0800 32)
 return false;
de54ebbe26bb3 (Kees Cook      2016-08-17 14:42:11 -0700 33)

Full kernel log here: https://pastebin.com/sycghWB5

I added to CC all who was involved in these lines of code.
I hope you help fix this issue.

-- 
Best Regards,
Mike Gavrilov.
