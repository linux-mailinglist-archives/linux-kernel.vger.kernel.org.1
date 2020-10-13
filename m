Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0D5028D6FC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 01:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388921AbgJMXWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 19:22:11 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:45778 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388809AbgJMXWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 19:22:11 -0400
Received: by mail-il1-f200.google.com with SMTP id b4so1075287ilf.12
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 16:22:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=CLuWVMOjTHLbVNABKCSg2IFm2uuzV5Q3xX78MVcxpa4=;
        b=c8Fvf3GXfxpbDNWKb1b4pEn+VD0paYEM54zugrBIhls3PRkAFHnn+1c5v2HZSXlZ3O
         WW6wL9htgYMD+bK9pwUXM+jOrTbeVKFlpTjF6Qo/2YOvl/INX+mLjzKilWKyriFHSjOb
         c5j5zfqEmBphoY8oo1nSTaqSrAKO8Uw4x1rSeUGeQKw9B/+agHPBxpiDvBAeTnX1lRns
         uR2cwEsPO2QS/54WiPCsYUYW1M4WMRkx9Nd1G5w51ahnvY8wUUTnk1Z1ylvs416d1kNr
         myQO3+CsGmrDj/YyN52iQocLL2MV42tj/O1pEvPIZWGz8Ssww0NaOJfh7jEDMqEAtvp6
         LfEg==
X-Gm-Message-State: AOAM5330DQUzMbFCKIbvimslfnJDP9WHP2Fs0KHu3XJ+ZDYmhT7zXzTW
        xtzTUHH6pPW6Af+6Ubpmmb3c28ssAoNI3YLqgM/QNreNN9Gc
X-Google-Smtp-Source: ABdhPJytMsqmWbNomF8life4uIsoh57pgRfO8LWK7P/0il52Zr6aq3csqgwDl0EGu6aQpKwHDoshMH+2UFz2BT0T3chWMPkfCFqf
MIME-Version: 1.0
X-Received: by 2002:a5d:9842:: with SMTP id p2mr850448ios.113.1602631330275;
 Tue, 13 Oct 2020 16:22:10 -0700 (PDT)
Date:   Tue, 13 Oct 2020 16:22:10 -0700
In-Reply-To: <157941.1602619974@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000025a54905b195af3d@google.com>
Subject: Re: KASAN: use-after-free Read in fscache_alloc_cookie
From:   syzbot <syzbot+2d0585e5efcd43d113c2@syzkaller.appspotmail.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING: proc registration bug in afs_manage_cell_work

------------[ cut here ]------------
proc_dir_entry 'afs/^]$[+%]0${' already registered
WARNING: CPU: 0 PID: 8309 at fs/proc/generic.c:371 proc_register+0x34c/0x700 fs/proc/generic.c:371
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 8309 Comm: kworker/0:4 Not tainted 5.9.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: afs afs_manage_cell_work
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x198/0x1fd lib/dump_stack.c:118
 panic+0x382/0x7fb kernel/panic.c:231
 __warn.cold+0x20/0x4b kernel/panic.c:600
 report_bug+0x1bd/0x210 lib/bug.c:198
 handle_bug+0x38/0x90 arch/x86/kernel/traps.c:234
 exc_invalid_op+0x14/0x40 arch/x86/kernel/traps.c:254
 asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:536
RIP: 0010:proc_register+0x34c/0x700 fs/proc/generic.c:371
Code: df 48 89 f9 48 c1 e9 03 80 3c 01 00 0f 85 5d 03 00 00 48 8b 44 24 28 48 c7 c7 a0 62 9a 88 48 8b b0 d8 00 00 00 e8 46 03 5d ff <0f> 0b 48 c7 c7 e0 f6 1e 8a e8 36 df 3d 06 48 8b 4c 24 38 48 b8 00
RSP: 0018:ffffc90009dffac8 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff8880923a4480 RSI: ffffffff815f5a55 RDI: fffff520013bff4b
RBP: ffff888088829b88 R08: 0000000000000001 R09: ffff8880ae4318e7
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8880904699d8
R13: ffff8880931d3340 R14: dffffc0000000000 R15: 000000000000000a
 proc_mkdir_data+0x140/0x1a0 fs/proc/generic.c:487
 proc_net_mkdir include/linux/proc_fs.h:201 [inline]
 afs_proc_cell_setup+0xb2/0x1f0 fs/afs/proc.c:619
 afs_activate_cell fs/afs/cell.c:684 [inline]
 afs_manage_cell fs/afs/cell.c:768 [inline]
 afs_manage_cell_work+0x5b7/0x11c0 fs/afs/cell.c:832
 process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x3b5/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
Kernel Offset: disabled
Rebooting in 86400 seconds..


Tested on:

commit:         f8eb8d1c afs: Add tracing for cell refcount and active use..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1414b0d8500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=302928762dfb5528
dashboard link: https://syzkaller.appspot.com/bug?extid=2d0585e5efcd43d113c2
compiler:       gcc (GCC) 10.1.0-syz 20200507

