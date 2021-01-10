Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3FD2F0620
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 10:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbhAJJJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 04:09:52 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:43088 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726398AbhAJJJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 04:09:51 -0500
Received: by mail-il1-f199.google.com with SMTP id o77so10083491ilb.10
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 01:09:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=fkJSIuFYeFa0Ztae+QHxCODB8dGO1qk9OvKO2QvKzjE=;
        b=WE2zSMYYwHT0/m/guIvdvxx9ijE0W0LJfv8lMNVBmTf5NrXAUhb9gkmn0spItDSh1U
         WhH0j3Ah8s3niEUIPU7uBfQULP5DgknV6L9rzSLNN511s5ugeoxa7MdLZhYvDTtmmQhZ
         HLdUCO98dxMu7otCkLgkyxLzl/an1va3r37eVfIntIz3Bv+hhhhzNmblkYjWOmh9yZEC
         CBpl7iBIluNXC8NOVWYx0YazQgN8RsQhNxJI4nlBOuQ+FwZL2/V1X7UFWLaHUKDH+2k5
         7ZPf8HlBgRJqjsMtli3fFqUgvAFqOKo2FRRKIbsUwtm6Z/2wxRonGW4omAOHoIp7kubI
         ydiA==
X-Gm-Message-State: AOAM53208QAXDJvftqBGRvuF/mpznXYXcxIJF2HwVTJ77KpyyGZ4p8ik
        AV8Fhq1rO4hqxG9kADwW3LDvBXzMjs0cdzTxj5/qWeohycjy
X-Google-Smtp-Source: ABdhPJzbFmajWu5FCXq4JsdlbhQfmDehOX7vvU72XKCfLEuwLkCgwXVk8BnKMTi3cRe2pjsH7oXAApcI0TBLcwGyonkyVMnHb5Yj
MIME-Version: 1.0
X-Received: by 2002:a6b:7f0b:: with SMTP id l11mr11228696ioq.34.1610269749258;
 Sun, 10 Jan 2021 01:09:09 -0800 (PST)
Date:   Sun, 10 Jan 2021 01:09:09 -0800
In-Reply-To: <20210110085436.3616-1-minhquangbui99@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000065b02205b8882492@google.com>
Subject: Re: memory leak in mcba_usb_probe
From:   syzbot <syzbot+57281c762a3922e14dfe@syzkaller.appspotmail.com>
To:     a.darwish@linutronix.de, bigeasy@linutronix.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, minhquangbui99@gmail.com,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
memory leak in rxrpc_lookup_local

BUG: memory leak
unreferenced object 0xffff888118b2f300 (size 256):
  comm "syz-executor.5", pid 8860, jiffies 4294944050 (age 373.640s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 0a 00 00 00 00 80 c3 18 81 88 ff ff  ................
  backtrace:
    [<00000000799c996d>] kmalloc include/linux/slab.h:552 [inline]
    [<00000000799c996d>] kzalloc include/linux/slab.h:682 [inline]
    [<00000000799c996d>] rxrpc_alloc_local net/rxrpc/local_object.c:79 [inline]
    [<00000000799c996d>] rxrpc_lookup_local+0x1c1/0x760 net/rxrpc/local_object.c:244
    [<00000000a9547b72>] rxrpc_bind+0x174/0x240 net/rxrpc/af_rxrpc.c:149
    [<00000000c8d0f9b2>] afs_open_socket+0xdb/0x200 fs/afs/rxrpc.c:64
    [<0000000029791b25>] afs_net_init+0x2b4/0x340 fs/afs/main.c:126
    [<000000005937929d>] ops_init+0x4e/0x190 net/core/net_namespace.c:152
    [<0000000064e0e1db>] setup_net+0xde/0x2d0 net/core/net_namespace.c:342
    [<00000000ca4d5a61>] copy_net_ns+0x19f/0x3e0 net/core/net_namespace.c:483
    [<0000000029feabb4>] create_new_namespaces+0x199/0x4f0 kernel/nsproxy.c:110
    [<000000005ce44751>] unshare_nsproxy_namespaces+0x9b/0x120 kernel/nsproxy.c:226
    [<000000003c257699>] ksys_unshare+0x2fe/0x5c0 kernel/fork.c:2957
    [<000000001788a4be>] __do_sys_unshare kernel/fork.c:3025 [inline]
    [<000000001788a4be>] __se_sys_unshare kernel/fork.c:3023 [inline]
    [<000000001788a4be>] __x64_sys_unshare+0x12/0x20 kernel/fork.c:3023
    [<00000000db77e81f>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<0000000052c5dd81>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888118afb200 (size 256):
  comm "syz-executor.0", pid 8858, jiffies 4294944054 (age 373.600s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 0a 00 00 00 00 00 92 18 81 88 ff ff  ................
  backtrace:
    [<00000000799c996d>] kmalloc include/linux/slab.h:552 [inline]
    [<00000000799c996d>] kzalloc include/linux/slab.h:682 [inline]
    [<00000000799c996d>] rxrpc_alloc_local net/rxrpc/local_object.c:79 [inline]
    [<00000000799c996d>] rxrpc_lookup_local+0x1c1/0x760 net/rxrpc/local_object.c:244
    [<00000000a9547b72>] rxrpc_bind+0x174/0x240 net/rxrpc/af_rxrpc.c:149
    [<00000000c8d0f9b2>] afs_open_socket+0xdb/0x200 fs/afs/rxrpc.c:64
    [<0000000029791b25>] afs_net_init+0x2b4/0x340 fs/afs/main.c:126
    [<000000005937929d>] ops_init+0x4e/0x190 net/core/net_namespace.c:152
    [<0000000064e0e1db>] setup_net+0xde/0x2d0 net/core/net_namespace.c:342
    [<00000000ca4d5a61>] copy_net_ns+0x19f/0x3e0 net/core/net_namespace.c:483
    [<0000000029feabb4>] create_new_namespaces+0x199/0x4f0 kernel/nsproxy.c:110
    [<000000005ce44751>] unshare_nsproxy_namespaces+0x9b/0x120 kernel/nsproxy.c:226
    [<000000003c257699>] ksys_unshare+0x2fe/0x5c0 kernel/fork.c:2957
    [<000000001788a4be>] __do_sys_unshare kernel/fork.c:3025 [inline]
    [<000000001788a4be>] __se_sys_unshare kernel/fork.c:3023 [inline]
    [<000000001788a4be>] __x64_sys_unshare+0x12/0x20 kernel/fork.c:3023
    [<00000000db77e81f>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<0000000052c5dd81>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff8881189f4800 (size 256):
  comm "syz-executor.6", pid 8856, jiffies 4294944054 (age 373.600s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 0a 00 00 00 00 c0 56 18 81 88 ff ff  ..........V.....
  backtrace:
    [<00000000799c996d>] kmalloc include/linux/slab.h:552 [inline]
    [<00000000799c996d>] kzalloc include/linux/slab.h:682 [inline]
    [<00000000799c996d>] rxrpc_alloc_local net/rxrpc/local_object.c:79 [inline]
    [<00000000799c996d>] rxrpc_lookup_local+0x1c1/0x760 net/rxrpc/local_object.c:244
    [<00000000a9547b72>] rxrpc_bind+0x174/0x240 net/rxrpc/af_rxrpc.c:149
    [<00000000c8d0f9b2>] afs_open_socket+0xdb/0x200 fs/afs/rxrpc.c:64
    [<0000000029791b25>] afs_net_init+0x2b4/0x340 fs/afs/main.c:126
    [<000000005937929d>] ops_init+0x4e/0x190 net/core/net_namespace.c:152
    [<0000000064e0e1db>] setup_net+0xde/0x2d0 net/core/net_namespace.c:342
    [<00000000ca4d5a61>] copy_net_ns+0x19f/0x3e0 net/core/net_namespace.c:483
    [<0000000029feabb4>] create_new_namespaces+0x199/0x4f0 kernel/nsproxy.c:110
    [<000000005ce44751>] unshare_nsproxy_namespaces+0x9b/0x120 kernel/nsproxy.c:226
    [<000000003c257699>] ksys_unshare+0x2fe/0x5c0 kernel/fork.c:2957
    [<000000001788a4be>] __do_sys_unshare kernel/fork.c:3025 [inline]
    [<000000001788a4be>] __se_sys_unshare kernel/fork.c:3023 [inline]
    [<000000001788a4be>] __x64_sys_unshare+0x12/0x20 kernel/fork.c:3023
    [<00000000db77e81f>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<0000000052c5dd81>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888118c34100 (size 256):
  comm "syz-executor.2", pid 8861, jiffies 4294944055 (age 373.590s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 0a 00 00 00 00 40 56 18 81 88 ff ff  .........@V.....
  backtrace:
    [<00000000799c996d>] kmalloc include/linux/slab.h:552 [inline]
    [<00000000799c996d>] kzalloc include/linux/slab.h:682 [inline]
    [<00000000799c996d>] rxrpc_alloc_local net/rxrpc/local_object.c:79 [inline]
    [<00000000799c996d>] rxrpc_lookup_local+0x1c1/0x760 net/rxrpc/local_object.c:244
    [<00000000a9547b72>] rxrpc_bind+0x174/0x240 net/rxrpc/af_rxrpc.c:149
    [<00000000c8d0f9b2>] afs_open_socket+0xdb/0x200 fs/afs/rxrpc.c:64
    [<0000000029791b25>] afs_net_init+0x2b4/0x340 fs/afs/main.c:126
    [<000000005937929d>] ops_init+0x4e/0x190 net/core/net_namespace.c:152
    [<0000000064e0e1db>] setup_net+0xde/0x2d0 net/core/net_namespace.c:342
    [<00000000ca4d5a61>] copy_net_ns+0x19f/0x3e0 net/core/net_namespace.c:483
    [<0000000029feabb4>] create_new_namespaces+0x199/0x4f0 kernel/nsproxy.c:110
    [<000000005ce44751>] unshare_nsproxy_namespaces+0x9b/0x120 kernel/nsproxy.c:226
    [<000000003c257699>] ksys_unshare+0x2fe/0x5c0 kernel/fork.c:2957
    [<000000001788a4be>] __do_sys_unshare kernel/fork.c:3025 [inline]
    [<000000001788a4be>] __se_sys_unshare kernel/fork.c:3023 [inline]
    [<000000001788a4be>] __x64_sys_unshare+0x12/0x20 kernel/fork.c:3023
    [<00000000db77e81f>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<0000000052c5dd81>] entry_SYSCALL_64_after_hwframe+0x44/0xa9



Tested on:

commit:         080e743d can: mcba_usb: Fix memory leak when cancelling urb
git tree:       https://github.com/minhbq-99/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1322c7a8d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=67a7baec24faba80
dashboard link: https://syzkaller.appspot.com/bug?extid=57281c762a3922e14dfe
compiler:       gcc (GCC) 10.1.0-syz 20200507

