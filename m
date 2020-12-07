Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 648552D1907
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 20:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgLGTDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 14:03:51 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:40915 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbgLGTDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 14:03:50 -0500
Received: by mail-io1-f71.google.com with SMTP id l18so1896475iok.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 11:03:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=N2ERZ1UGrqBbG2LNwsnvqgzU4lrPzddqBhtlT5u6o4c=;
        b=bBNj8wvgzuavxHg0VR6+z8Pb29d9q+/63xONIE66QIJbn9s8rh+wDPDKNMo4nhHVo4
         CMeRZwxvGJGdA+005m9dpQK+XZ5sOLZ4Qzv2osK0WubVccqQbME7v1DWeWWot39rO4bx
         Z+37zfJWaul6gGMUqbE/YqHPT9v5LGU5vcT3dmxswx3MldQlbkNdeKbs48wzbxaUNdQb
         P2JdH4wRJ9ixBjBI1faAlOa63nv51qcDMQDS6FG74dm0ZxB+5GEUWRfDCJRIWTuk1ikk
         KyLfBxqyzNLHDSzVQGHzQvg75Za6NusyUo5EgCtJThlgvNDoS5E7+q3YpW9Czf2DH1ud
         r5Uw==
X-Gm-Message-State: AOAM532gtb1HLdRFhUTRlfl5i8RrnRVhDmdhSqttPevYSr8r5YjoYHBp
        wzAdEgdFR/0uxGNDTJQJPd3tn1c2ehGaeCJUw8Jtt2IQGEhq
X-Google-Smtp-Source: ABdhPJw7YOdq8lgSgbJ3bDFjv4+haySHrVK1SQYGVhpsM8+2A5+uCbauNk7zVbZQlBAVQkFs0SUcK1s5BEqVvZ8DZOu4ypPF2GIv
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:ca5:: with SMTP id 5mr23602963ilg.40.1607367789375;
 Mon, 07 Dec 2020 11:03:09 -0800 (PST)
Date:   Mon, 07 Dec 2020 11:03:09 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001bf87305b5e47a9d@google.com>
Subject: UBSAN: array-index-out-of-bounds in dquot_resume
From:   syzbot <syzbot+2643e825238d7aabb37f@syzkaller.appspotmail.com>
To:     hch@infradead.org, jack@suse.com, jack@suse.cz,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    b3298500 Merge tag 'for-5.10/dm-fixes' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1429c99b500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c3904d1cc0af152
dashboard link: https://syzkaller.appspot.com/bug?extid=2643e825238d7aabb37f
compiler:       clang version 11.0.0 (https://github.com/llvm/llvm-project.git ca2dcbd030eadbf0aa9b660efe864ff08af6e18b)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10391d45500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16eab99b500000

The issue was bisected to:

commit ae45f07d47cc30e9170488a4e5fe91ba4fe5ed4e
Author: Jan Kara <jack@suse.cz>
Date:   Fri Nov 1 16:51:05 2019 +0000

    quota: Simplify dquot_resume()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14d95975500000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16d95975500000
console output: https://syzkaller.appspot.com/x/log.txt?x=12d95975500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2643e825238d7aabb37f@syzkaller.appspotmail.com
Fixes: ae45f07d47cc ("quota: Simplify dquot_resume()")

EXT4-fs (loop0): warning: mounting fs with errors, running e2fsck is recommended
================================================================================
UBSAN: array-index-out-of-bounds in fs/quota/dquot.c:2169:24
index -1 is out of range for type 'struct inode *[3]'
CPU: 0 PID: 8448 Comm: syz-executor007 Not tainted 5.10.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x137/0x1be lib/dump_stack.c:118
 ubsan_epilogue lib/ubsan.c:148 [inline]
 __ubsan_handle_out_of_bounds+0xdb/0x130 lib/ubsan.c:356
 vfs_cleanup_quota_inode fs/quota/dquot.c:2169 [inline]
 dquot_resume+0x3f1/0x440 fs/quota/dquot.c:2458
 ext4_remount+0x2455/0x3230 fs/ext4/super.c:6018
 reconfigure_super+0x3b4/0x7b0 fs/super.c:957
 do_remount fs/namespace.c:2612 [inline]
 path_mount+0x1a1f/0x2a20 fs/namespace.c:3197
 do_mount fs/namespace.c:3218 [inline]
 __do_sys_mount fs/namespace.c:3426 [inline]
 __se_sys_mount+0x28c/0x320 fs/namespace.c:3403
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x44c99a
Code: b8 08 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 dd ab fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 ba ab fb ff c3 66 0f 1f 84 00 00 00 00 00
RSP: 002b:00007fa03c8b9ba8 EFLAGS: 00000297 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00000000ffffffff RCX: 000000000044c99a
RDX: 0000000020000540 RSI: 0000000020000580 RDI: 0000000000000000
RBP: 00007fa03c8ba6d0 R08: 00007fa03c8b9c40 R09: 0000000000240038
R10: 0000000000240038 R11: 0000000000000297 R12: 00000000ffffffff
R13: 0000000000000000 R14: 0000000000000000 R15: 00007fa03c8b9c40
================================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
