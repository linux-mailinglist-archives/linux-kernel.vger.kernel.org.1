Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 810912C6EB7
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 04:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730487AbgK1DxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 22:53:02 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:46395 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729604AbgK1Drf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 22:47:35 -0500
Received: by mail-il1-f198.google.com with SMTP id q5so5166213ilc.13
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 19:47:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=/zKWIW/BGl+uP9uZHMF0DxwCcRQMsXce4lHe+wGoD1E=;
        b=kdN7NyeDEphjqlhEkxx9za3+LsG9WayDv3TamkfiFF5YFVXNLOiGGkQyICnrHsR6LH
         0kr4u+nATFRlIP44uRh0X/88r8MkVPPa7YHw6B3vK1ZQUxOYF0CvX/3VRgbZRl9GDKQ/
         pebcvHLHAxc/YNpox2Y8gCszLu530JO+JCvJso7vouzV6QX5K+pCorgMoi7xaKnro3Ac
         LQarzNFTTUW1KaDcCddLP2Gzfz7GYtSrsVzmQ+TzTkDUvAnpDpNaCSJ0Kn4OvFtqqN3h
         os2HxOusirVX8QZvhRYttsSrluj4DH2RZsk3d1uvK4qKCcyPKkXavYUXsXQj+8S4Sny4
         IBmA==
X-Gm-Message-State: AOAM530K663iAbWe/VRsmz669QVuTYKYH1QRIbngTtLNY5/ouk0Q0dY9
        E40o1YdSzsMFoui6191oqtUIxFJi1YFRltlmwocVWhRqqx/N
X-Google-Smtp-Source: ABdhPJxKkDxzQmAMpUsJUp7TUtejlU2hrwuD/QS8APAIsKk+Bx85FOTqzjG1ov+w6kwNW3Tq2I6JI6FIQEMzi4TWaheCVRoJ9a/3
MIME-Version: 1.0
X-Received: by 2002:a02:2246:: with SMTP id o67mr10650480jao.52.1606535235649;
 Fri, 27 Nov 2020 19:47:15 -0800 (PST)
Date:   Fri, 27 Nov 2020 19:47:15 -0800
In-Reply-To: <000000000000ca5cfb05ade37394@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000a440b05b522a284@google.com>
Subject: Re: memory leak in prepare_creds
From:   syzbot <syzbot+71c4697e27c99fddcf17@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, bernd.edlinger@hotmail.de,
        chris@chrisdown.name, dhowells@redhat.com, ebiederm@xmission.com,
        guro@fb.com, keescook@chromium.org, linux-kernel@vger.kernel.org,
        mhocko@suse.com, shakeelb@google.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    99c710c4 Merge tag 'platform-drivers-x86-v5.10-2' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12a77ddd500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c7a27a77f20fbc95
dashboard link: https://syzkaller.appspot.com/bug?extid=71c4697e27c99fddcf17
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12d6161d500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16f15e65500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+71c4697e27c99fddcf17@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff888101401300 (size 168):
  comm "syz-executor355", pid 8461, jiffies 4294953658 (age 32.400s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000caa0de2b>] prepare_creds+0x25/0x390 kernel/cred.c:258
    [<000000001821b99d>] copy_creds+0x3a/0x230 kernel/cred.c:358
    [<0000000022c32914>] copy_process+0x661/0x24d0 kernel/fork.c:1971
    [<00000000d3adca2d>] kernel_clone+0xf3/0x670 kernel/fork.c:2456
    [<00000000d11b7286>] __do_sys_clone+0x76/0xa0 kernel/fork.c:2573
    [<000000008280baad>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<00000000685d8cf0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88810b0a6f20 (size 32):
  comm "syz-executor355", pid 8461, jiffies 4294953658 (age 32.400s)
  hex dump (first 32 bytes):
    b0 6e 93 00 81 88 ff ff 00 00 00 00 00 00 00 00  .n..............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000007d750ba1>] kmalloc include/linux/slab.h:557 [inline]
    [<000000007d750ba1>] kzalloc include/linux/slab.h:664 [inline]
    [<000000007d750ba1>] lsm_cred_alloc security/security.c:533 [inline]
    [<000000007d750ba1>] security_prepare_creds+0xa5/0xd0 security/security.c:1632
    [<00000000ba63fcc7>] prepare_creds+0x277/0x390 kernel/cred.c:285
    [<000000001821b99d>] copy_creds+0x3a/0x230 kernel/cred.c:358
    [<0000000022c32914>] copy_process+0x661/0x24d0 kernel/fork.c:1971
    [<00000000d3adca2d>] kernel_clone+0xf3/0x670 kernel/fork.c:2456
    [<00000000d11b7286>] __do_sys_clone+0x76/0xa0 kernel/fork.c:2573
    [<000000008280baad>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<00000000685d8cf0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888101ea2200 (size 256):
  comm "syz-executor355", pid 8470, jiffies 4294953658 (age 32.400s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    20 59 03 01 81 88 ff ff 80 87 a8 10 81 88 ff ff   Y..............
  backtrace:
    [<000000002e0a7c5f>] kmem_cache_zalloc include/linux/slab.h:654 [inline]
    [<000000002e0a7c5f>] __alloc_file+0x1f/0x130 fs/file_table.c:101
    [<000000001a55b73a>] alloc_empty_file+0x69/0x120 fs/file_table.c:151
    [<00000000fb22349e>] alloc_file+0x33/0x1b0 fs/file_table.c:193
    [<000000006e1465bb>] alloc_file_pseudo+0xb2/0x140 fs/file_table.c:233
    [<000000007118092a>] anon_inode_getfile fs/anon_inodes.c:91 [inline]
    [<000000007118092a>] anon_inode_getfile+0xaa/0x120 fs/anon_inodes.c:74
    [<000000002ae99012>] io_uring_get_fd fs/io_uring.c:9198 [inline]
    [<000000002ae99012>] io_uring_create fs/io_uring.c:9377 [inline]
    [<000000002ae99012>] io_uring_setup+0x1125/0x1630 fs/io_uring.c:9411
    [<000000008280baad>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<00000000685d8cf0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9


