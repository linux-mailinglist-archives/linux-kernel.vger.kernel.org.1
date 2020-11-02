Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 955A42A2A1D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 12:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbgKBLyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 06:54:24 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:44865 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728716AbgKBLyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 06:54:19 -0500
Received: by mail-il1-f197.google.com with SMTP id s70so6347957ili.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 03:54:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Sqg30VMwJSZq5RzUJ0TKC6IYhWARWZMMQaebzmFa2Bs=;
        b=e2A3E868lTseep2rsgFD+UPvEp/ez12IWfsDwVwQX5RHxgMlH3lTFZJAp07g9TxBp/
         +qtlZABjOzjwwYm5ZQQn8SR2d+6xSPedfW1r7GV84zXMZneMMAdhtVToDseAifJhHteG
         j6fKIn6V2eaXCkdFAdKn5kusY6kcEHgQ76FzFcIVb8vElgpgvQLFke0Jm6kbFtQo4sZP
         zppvBzkhxHALaX/kMDVuYas1hgsct9RQjVjvscJ5pyi3G/ntuLrqWGOcqK0xUtH7wOu3
         TIltpLnBdGFPVUt63K1eTP18cScIv+d70Dx9XK07q0ZG8VK0t5wW/Ytdcjp/Ja52uFfK
         wTOQ==
X-Gm-Message-State: AOAM532xVCFdWTHeGoZISYgI6RJrljKIYPUUc7StPTv4uPRvZbi7nMcb
        KI/nqSUPnYEIN0THV6bKWco6MIWQHcTIM75ha63PyYP/4xvX
X-Google-Smtp-Source: ABdhPJzeAjcJdN0YGKzTLSqfQrOARKnqcntkz+9kHIx7O7P/lTjX7+lWTsd7tuJKF/DOg2/FJXdyMafZt4L+yNRUHK0I8dVFfFet
MIME-Version: 1.0
X-Received: by 2002:a02:a808:: with SMTP id f8mr2628773jaj.84.1604318059055;
 Mon, 02 Nov 2020 03:54:19 -0800 (PST)
Date:   Mon, 02 Nov 2020 03:54:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000004500b05b31e68ce@google.com>
Subject: KASAN: vmalloc-out-of-bounds Read in bpf_trace_run3
From:   syzbot <syzbot+d29e58bb557324e55e5e@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, andrii@kernel.org, ast@kernel.org,
        bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        hawk@kernel.org, john.fastabend@gmail.com, kafai@fb.com,
        kpsingh@chromium.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, mingo@elte.hu, mingo@redhat.com,
        mmullins@fb.com, netdev@vger.kernel.org, peterz@infradead.org,
        rostedt@goodmis.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    080b6f40 bpf: Don't rely on GCC __attribute__((optimize)) ..
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=1089d37c500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=58a4ca757d776bfe
dashboard link: https://syzkaller.appspot.com/bug?extid=d29e58bb557324e55e5e
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10f4b032500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1371a47c500000

The issue was bisected to:

commit 9df1c28bb75217b244257152ab7d788bb2a386d0
Author: Matt Mullins <mmullins@fb.com>
Date:   Fri Apr 26 18:49:47 2019 +0000

    bpf: add writable context for raw tracepoints

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12b6c4da500000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11b6c4da500000
console output: https://syzkaller.appspot.com/x/log.txt?x=16b6c4da500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d29e58bb557324e55e5e@syzkaller.appspotmail.com
Fixes: 9df1c28bb752 ("bpf: add writable context for raw tracepoints")

==================================================================
BUG: KASAN: vmalloc-out-of-bounds in __bpf_trace_run kernel/trace/bpf_trace.c:2045 [inline]
BUG: KASAN: vmalloc-out-of-bounds in bpf_trace_run3+0x3e0/0x3f0 kernel/trace/bpf_trace.c:2083
Read of size 8 at addr ffffc90000e6c030 by task kworker/0:3/3754

CPU: 0 PID: 3754 Comm: kworker/0:3 Not tainted 5.9.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue:  0x0 (events)
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0x5/0x4c8 mm/kasan/report.c:385
 __kasan_report mm/kasan/report.c:545 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:562
 __bpf_trace_run kernel/trace/bpf_trace.c:2045 [inline]
 bpf_trace_run3+0x3e0/0x3f0 kernel/trace/bpf_trace.c:2083
 __bpf_trace_sched_switch+0xdc/0x120 include/trace/events/sched.h:138
 __traceiter_sched_switch+0x64/0xb0 include/trace/events/sched.h:138
 trace_sched_switch include/trace/events/sched.h:138 [inline]
 __schedule+0xeb8/0x2130 kernel/sched/core.c:4520
 schedule+0xcf/0x270 kernel/sched/core.c:4601
 worker_thread+0x14c/0x1120 kernel/workqueue.c:2439
 kthread+0x3af/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296


Memory state around the buggy address:
 ffffc90000e6bf00: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc90000e6bf80: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
>ffffc90000e6c000: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
                                     ^
 ffffc90000e6c080: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc90000e6c100: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
