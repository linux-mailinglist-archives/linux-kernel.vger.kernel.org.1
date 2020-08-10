Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D54F240609
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Aug 2020 14:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgHJMlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Aug 2020 08:41:20 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:37434 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgHJMlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 08:41:19 -0400
Received: by mail-il1-f198.google.com with SMTP id 5so4485769ila.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 05:41:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=8FpRlx12JXZpYMKALW3p4bO1L8myHn0GObzI1j2u9CM=;
        b=XCEB/1WcwJPUrALgqElyvO0VASi4TZrbQ3fTzuxEGOAMTjfsBQo5Mtp9TwWs5akJLm
         i0Ht6Zzbs983ySuGlPYsMthADBmRMPMMZ84tLDeAyYF8iBOgqxLrJiE7dTxYwaHB0bUq
         LDN/zr7Pm5Bttv/Myf9XFhh69Bsq+OgYAG8pnUHqCz243R9GR12y2S4kxGa3S83XsiqS
         J4/wkwMRZa2Ugvu235vCTeMoicAAJx2zgZaV++Nmp0Ixpoy1kVMUn6mM/GdxuaBtbVZ4
         V7Dmn0h/XwwNYc4TornsXHzyMfDGRCwbLK3WllD0hPZ1QQAmyJb5WEVV5t7QGVMnLLea
         amIw==
X-Gm-Message-State: AOAM532z5daBV262bdYr0+h33zmtyLetzh9r90oIjhQOfSiARW+ebOB8
        YPT1Vk9EIQA9olE+enhNE2z9VAjvzbQr61lnzSwRDfukjsva
X-Google-Smtp-Source: ABdhPJxmorMnL/jYRyFRA7cvUD4V+Xve2rdk0BZg2GTdbKiByML7Eh7x1ol9o8uhQcYR1VE6rfsAoQJEfYDNFINMYVzfJr9qGCh8
MIME-Version: 1.0
X-Received: by 2002:a05:6638:22d0:: with SMTP id j16mr19825826jat.97.1597063278271;
 Mon, 10 Aug 2020 05:41:18 -0700 (PDT)
Date:   Mon, 10 Aug 2020 05:41:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000062a49205ac854581@google.com>
Subject: KCSAN: data-race in __xa_clear_mark / xas_find_marked
From:   syzbot <syzbot+0d4522639ba75b02bf19@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    fc80c51f Merge tag 'kbuild-v5.9' of git://git.kernel.org/p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13cb73fa900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=997a92ee4b5588ef
dashboard link: https://syzkaller.appspot.com/bug?extid=0d4522639ba75b02bf19
compiler:       clang version 11.0.0 (https://github.com/llvm/llvm-project.git ca2dcbd030eadbf0aa9b660efe864ff08af6e18b)

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0d4522639ba75b02bf19@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in __xa_clear_mark / xas_find_marked

write to 0xffff8880bace9b30 of 8 bytes by interrupt on cpu 1:
 instrument_write include/linux/instrumented.h:42 [inline]
 __test_and_clear_bit include/asm-generic/bitops/instrumented-non-atomic.h:85 [inline]
 node_clear_mark lib/xarray.c:100 [inline]
 xas_clear_mark lib/xarray.c:908 [inline]
 __xa_clear_mark+0x229/0x350 lib/xarray.c:1726
 test_clear_page_writeback+0x28d/0x480 mm/page-writeback.c:2739
 end_page_writeback+0xa7/0x110 mm/filemap.c:1369
 page_endio+0x1aa/0x1e0 mm/filemap.c:1400
 mpage_end_io+0x186/0x1d0 fs/mpage.c:54
 bio_endio+0x28a/0x370 block/bio.c:1447
 req_bio_endio block/blk-core.c:259 [inline]
 blk_update_request+0x535/0xbd0 block/blk-core.c:1576
 blk_mq_end_request+0x22/0x50 block/blk-mq.c:562
 lo_complete_rq+0xca/0x180 drivers/block/loop.c:500
 blk_done_softirq+0x1a5/0x200 block/blk-mq.c:586
 __do_softirq+0x198/0x360 kernel/softirq.c:298
 run_ksoftirqd+0x2f/0x60 kernel/softirq.c:652
 smpboot_thread_fn+0x347/0x530 kernel/smpboot.c:165
 kthread+0x20d/0x230 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

read to 0xffff8880bace9b30 of 8 bytes by task 12715 on cpu 0:
 xas_find_chunk include/linux/xarray.h:1625 [inline]
 xas_find_marked+0x22f/0x6b0 lib/xarray.c:1198
 find_get_pages_range_tag+0xa3/0x580 mm/filemap.c:1976
 pagevec_lookup_range_tag+0x37/0x50 mm/swap.c:1120
 __filemap_fdatawait_range+0xab/0x1b0 mm/filemap.c:519
 filemap_fdatawait_range mm/filemap.c:554 [inline]
 filemap_write_and_wait_range+0x119/0x2a0 mm/filemap.c:664
 generic_file_read_iter+0x11d/0x3e0 mm/filemap.c:2375
 call_read_iter include/linux/fs.h:1866 [inline]
 generic_file_splice_read+0x22b/0x310 fs/splice.c:312
 do_splice_to fs/splice.c:870 [inline]
 splice_direct_to_actor+0x2a8/0x660 fs/splice.c:950
 do_splice_direct+0xf2/0x170 fs/splice.c:1059
 do_sendfile+0x56a/0xba0 fs/read_write.c:1540
 __do_sys_sendfile64 fs/read_write.c:1595 [inline]
 __se_sys_sendfile64 fs/read_write.c:1587 [inline]
 __x64_sys_sendfile64+0xa9/0x130 fs/read_write.c:1587
 do_syscall_64+0x39/0x80 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 12715 Comm: syz-executor.4 Not tainted 5.8.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
