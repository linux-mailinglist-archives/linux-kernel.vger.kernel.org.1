Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E91D241F3E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Aug 2020 19:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbgHKRa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Aug 2020 13:30:27 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:42231 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729150AbgHKRaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 13:30:25 -0400
Received: by mail-il1-f199.google.com with SMTP id z1so1584618ilz.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 10:30:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=wYPqHOKiPEiq4c/9oNHWGAHHdoSgKuM8jKVa9B1NydQ=;
        b=fDz5yMScCkHqY9y0wBwjYdn7QacYejSDCD4yM7OhKzIM+vhik1CX/CRE5z6HEIinft
         brhGG0I6WOGmQx3zGz2AUxqmN+IPnZKMuLPg3wJyslvsjnAVTlCW4BB0q+0M20O3wvra
         L6t+PLxID0Wb02/5VqtXAoNxD/juR4hlCdAMwem5wckiUZBWU5VqLlWpFJNYjBQq1HOx
         WwRhe6QaRFSfsTgzenxCYgdqRvxTvQlt8mkzvDmBe5AfhkwvZKNJ3kQKdVshtQQqCPie
         qlIrON6rt/MJSLZ8QOmSMvrDPHHS+DIDDyPu0yBext9j6DeuHJxsyJ0ETm20LVrcLfhi
         e5/Q==
X-Gm-Message-State: AOAM532v5ANgcG9c3CoAAdoEHA1q8L2cGqdXtjUHPjCDENb1g0jzkUKj
        yLHT1oz9w6XszQ5B/e0NrTe3FsVj/PmIZGNs4gN73NO3dCvr
X-Google-Smtp-Source: ABdhPJzuvdFF/eryapjz18jWZQjX+uUKxP9iCExAkSrA73P+bYbzt9f9bRI9OkHK+KAxko2TkHzilohTdt46KpJnzPRoeZ3heg2X
MIME-Version: 1.0
X-Received: by 2002:a02:6d5d:: with SMTP id e29mr26421416jaf.139.1597167024410;
 Tue, 11 Aug 2020 10:30:24 -0700 (PDT)
Date:   Tue, 11 Aug 2020 10:30:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000023195505ac9d6d26@google.com>
Subject: KASAN: wild-memory-access Read in do_ebt_set_ctl
From:   syzbot <syzbot+64d60892aaa4d4c34812@syzkaller.appspotmail.com>
To:     bridge@lists.linux-foundation.org, coreteam@netfilter.org,
        davem@davemloft.net, fw@strlen.de, kadlec@netfilter.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        nikolay@cumulusnetworks.com, pablo@netfilter.org,
        roopa@cumulusnetworks.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    86cfccb6 Merge tag 'dlm-5.9' of git://git.kernel.org/pub/s..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1419de8a900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bcf489e08c9b8c5e
dashboard link: https://syzkaller.appspot.com/bug?extid=64d60892aaa4d4c34812
compiler:       gcc (GCC) 10.1.0-syz 20200507
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+64d60892aaa4d4c34812@syzkaller.appspotmail.com

BUG: KASAN: wild-memory-access in memcpy include/linux/string.h:406 [inline]
BUG: KASAN: wild-memory-access in copy_from_sockptr_offset include/linux/sockptr.h:71 [inline]
BUG: KASAN: wild-memory-access in copy_from_sockptr include/linux/sockptr.h:77 [inline]
BUG: KASAN: wild-memory-access in compat_update_counters net/bridge/netfilter/ebtables.c:2222 [inline]
BUG: KASAN: wild-memory-access in do_ebt_set_ctl+0x2c0/0x53b net/bridge/netfilter/ebtables.c:2389
Read of size 80 at addr 00000000ffffffff by task syz-executor.3/9621

CPU: 1 PID: 9621 Comm: syz-executor.3 Not tainted 5.8.0-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 __kasan_report mm/kasan/report.c:517 [inline]
 kasan_report.cold+0x5/0x37 mm/kasan/report.c:530
 check_memory_region_inline mm/kasan/generic.c:186 [inline]
 check_memory_region+0x13d/0x180 mm/kasan/generic.c:192
 memcpy+0x20/0x60 mm/kasan/common.c:105
 memcpy include/linux/string.h:406 [inline]
 copy_from_sockptr_offset include/linux/sockptr.h:71 [inline]
 copy_from_sockptr include/linux/sockptr.h:77 [inline]
 compat_update_counters net/bridge/netfilter/ebtables.c:2222 [inline]
 do_ebt_set_ctl+0x2c0/0x53b net/bridge/netfilter/ebtables.c:2389
 nf_setsockopt+0x6f/0xc0 net/netfilter/nf_sockopt.c:101
 ip_setsockopt+0x54d/0x3c10 net/ipv4/ip_sockglue.c:1436
 raw_setsockopt+0x205/0x250 net/ipv4/raw.c:856
 __sys_setsockopt+0x2ad/0x6d0 net/socket.c:2138
 __do_sys_setsockopt net/socket.c:2149 [inline]
 __se_sys_setsockopt net/socket.c:2146 [inline]
 __ia32_sys_setsockopt+0xb9/0x150 net/socket.c:2146
 do_syscall_32_irqs_on arch/x86/entry/common.c:84 [inline]
 __do_fast_syscall_32+0x57/0x80 arch/x86/entry/common.c:126
 do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:149
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf7f19569
Code: c4 01 10 03 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000f55130bc EFLAGS: 00000296 ORIG_RAX: 000000000000016e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000000000
RDX: 0000000000000081 RSI: 00000000ffffffff RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
