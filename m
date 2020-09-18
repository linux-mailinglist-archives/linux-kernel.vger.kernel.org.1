Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9650B26FB15
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 13:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgIRLCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 07:02:18 -0400
Received: from mail-il1-f205.google.com ([209.85.166.205]:39405 "EHLO
        mail-il1-f205.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgIRLCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 07:02:17 -0400
Received: by mail-il1-f205.google.com with SMTP id r10so2971721ilq.6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 04:02:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=cXtmY7DQlFAjiAHw3xmLYk/Qmq082l9EzeQBjNuXHj8=;
        b=rM1ywZ32iTV0LCju80qbAJ5ZvBo1z+j60kUXVTA9D6y3Q/DGP7AHCCrpSx9Gqk+3vh
         ZY1fWuXuAAdEgz9qAuz5kS1usXBErBG+DPgEAwSfLSe35AIsLHqLrWdaUxN5nc2exO7O
         sw0u+BADFEi51WBhF1kBxvcJFSUF+AT6xZbw6qhMx0uE7bs0RddlABsE3h2dU8RwqE3K
         Y5mE/5nqncdBBBgZMQe9sXzO+7mnwGvnXF+jBpOAtkzdhmrNUrMQhd3SbQzeCYy2ujpK
         UCv9sbrwo/F1O5IlGPgsJUHwX9zFMNkci5j5G3PaLQpJ9iiKqZVmCN87lYXmreG9oVLn
         Kccw==
X-Gm-Message-State: AOAM530sdBiVL980zjeOUFCs5gzlub6qYJtzaZEkIQFGVjKIDKwu36UX
        6hBZ6ry2K3QCaps8dl2dr352nzyQ1t/KlgbOgeFJDDMOLF7X
X-Google-Smtp-Source: ABdhPJySzQ1XevJHGwRWh+BkPg/NRFTg2oR90MwfsnBKvb1hXCv6nKWbyG0m0xDjQ+O6gjx2CpaOAbmM6j/Ejdx2ZPSj+OIB2eRO
MIME-Version: 1.0
X-Received: by 2002:a92:105:: with SMTP id 5mr27207909ilb.36.1600426936689;
 Fri, 18 Sep 2020 04:02:16 -0700 (PDT)
Date:   Fri, 18 Sep 2020 04:02:16 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000cea4605af946f8c@google.com>
Subject: KASAN: null-ptr-deref Read in PageHuge
From:   syzbot <syzbot+3a21fd5ecfc677248e77@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mike.kravetz@oracle.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    6b02addb Add linux-next specific files for 20200915
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17a7441d900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7086d0e9e44d4a14
dashboard link: https://syzkaller.appspot.com/bug?extid=3a21fd5ecfc677248e77
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=141489f1900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1694fd55900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3a21fd5ecfc677248e77@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_read include/linux/instrumented.h:71 [inline]
BUG: KASAN: null-ptr-deref in test_bit include/asm-generic/bitops/instrumented-non-atomic.h:134 [inline]
BUG: KASAN: null-ptr-deref in PageCompound include/linux/page-flags.h:196 [inline]
BUG: KASAN: null-ptr-deref in PageHuge+0x19/0x170 mm/hugetlb.c:1551
Read of size 8 at addr 0000000000000000 by task syz-executor410/6864

CPU: 1 PID: 6864 Comm: syz-executor410 Not tainted 5.9.0-rc5-next-20200915-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x198/0x1fb lib/dump_stack.c:118
 __kasan_report mm/kasan/report.c:549 [inline]
 kasan_report.cold+0x5/0x37 mm/kasan/report.c:562
 check_memory_region_inline mm/kasan/generic.c:186 [inline]
 check_memory_region+0x13d/0x180 mm/kasan/generic.c:192
 instrument_atomic_read include/linux/instrumented.h:71 [inline]
 test_bit include/asm-generic/bitops/instrumented-non-atomic.h:134 [inline]
 PageCompound include/linux/page-flags.h:196 [inline]
 PageHuge+0x19/0x170 mm/hugetlb.c:1551
 find_subpage include/linux/pagemap.h:410 [inline]
 find_get_incore_page+0x165/0x2e0 mm/swap_state.c:435
 mincore_page+0x1e/0x310 mm/mincore.c:62
 __mincore_unmapped_range+0x171/0x2c0 mm/mincore.c:82
 mincore_pte_range+0x69f/0x980 mm/mincore.c:125
 walk_pmd_range mm/pagewalk.c:89 [inline]
 walk_pud_range mm/pagewalk.c:160 [inline]
 walk_p4d_range mm/pagewalk.c:193 [inline]
 walk_pgd_range mm/pagewalk.c:229 [inline]
 __walk_page_range+0xeed/0x22c0 mm/pagewalk.c:331
 walk_page_range+0x20d/0x400 mm/pagewalk.c:427
 do_mincore mm/mincore.c:199 [inline]
 __do_sys_mincore+0x279/0x7a0 mm/mincore.c:264
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x440329
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffe6fca7ae8 EFLAGS: 00000246 ORIG_RAX: 000000000000001b
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440329
RDX: 0000000000000000 RSI: 0000000000004000 RDI: 0000000020001000
RBP: 00000000006ca018 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000003 R11: 0000000000000246 R12: 0000000000401b30
R13: 0000000000401bc0 R14: 0000000000000000 R15: 0000000000000000
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
