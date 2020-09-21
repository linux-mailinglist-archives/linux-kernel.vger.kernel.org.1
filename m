Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51C702718C8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 02:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgIUAN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 20:13:27 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:40910 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgIUAN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 20:13:27 -0400
Received: by mail-io1-f71.google.com with SMTP id f8so8912024iow.7
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 17:13:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=37ewJDovB0qCmsKD2ySkpxiwtS+nZ55VOaalwtNHB44=;
        b=Adwh4vQGVMr98z4KY7tX+r1Z9jipzPTVwQUwIG9Y7+i7BxXZ5ZUehwLUQTJJ3OU0f3
         WogYM4l4UA6WqpKtKrbzla+pdzV6kqtubisJcgZBeXFiFGPiNF6FSugkoJJuONo8pMX+
         EV/4dSU8V6jICbgYa0LUIYZTAuFJ7lHHnM3rIl/WFsCnBuoTN/EjxK/WoGdB8WMo7jga
         I/jgrZEXvMXlGWJMpLuYrQ+dAz1ZJOxuZ7OSaF5S1H+alJh6/2kvuh4zF9ZGNthuy+XQ
         xOuAuzgcGJAYTOET+eyFCHhbV3ucEnaQVj3HynnSFMo01vgIm/I5PTxXhzi9OIk6aT1r
         1zIQ==
X-Gm-Message-State: AOAM533ITYgdTdowScIZ2/nquYGayLMLVbkilak+VexDejZ/aLoXMcq8
        d9Xu3J8jhTkVhlwtNsQew41OqxpDwpE0DxMvSCJyeFxuPX6g
X-Google-Smtp-Source: ABdhPJyFBz7srUkXzTpIB7mBHcbvDgsnZaFutHUWTCgQxWrNwvVJaHw0DWVAJ31PdiTIGI3vfiHDhJBfwLCCLf9N/Inkrn55VoVP
MIME-Version: 1.0
X-Received: by 2002:a92:6e0f:: with SMTP id j15mr38946218ilc.299.1600647206311;
 Sun, 20 Sep 2020 17:13:26 -0700 (PDT)
Date:   Sun, 20 Sep 2020 17:13:26 -0700
In-Reply-To: <00000000000082559e05afc6b97a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000249efd05afc7b8a0@google.com>
Subject: Re: UBSAN: array-index-out-of-bounds in arch_uprobe_analyze_insn
From:   syzbot <syzbot+9b64b619f10f19d19a7c@syzkaller.appspotmail.com>
To:     bp@alien8.de, gustavoars@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        wang.yi59@zte.com.cn, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    325d0eab Merge branch 'akpm' (patches from Andrew)
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14e69c03900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b12e84189082991c
dashboard link: https://syzkaller.appspot.com/bug?extid=9b64b619f10f19d19a7c
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1573a8ad900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=164ee6c5900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9b64b619f10f19d19a7c@syzkaller.appspotmail.com

================================================================================
UBSAN: array-index-out-of-bounds in arch/x86/kernel/uprobes.c:263:56
index 4 is out of range for type 'insn_byte_t [4]'
CPU: 0 PID: 6870 Comm: syz-executor876 Not tainted 5.9.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x198/0x1fd lib/dump_stack.c:118
 ubsan_epilogue+0xb/0x5a lib/ubsan.c:148
 __ubsan_handle_out_of_bounds.cold+0x62/0x6c lib/ubsan.c:356
 is_prefix_bad arch/x86/kernel/uprobes.c:263 [inline]
 uprobe_init_insn arch/x86/kernel/uprobes.c:286 [inline]
 arch_uprobe_analyze_insn+0x8f4/0xa40 arch/x86/kernel/uprobes.c:856
 prepare_uprobe kernel/events/uprobes.c:860 [inline]
 install_breakpoint.isra.0+0x6c4/0x7c0 kernel/events/uprobes.c:903
 uprobe_mmap+0x5ec/0x1080 kernel/events/uprobes.c:1394
 mmap_region+0x5cf/0x1780 mm/mmap.c:1839
 do_mmap+0xcf9/0x11d0 mm/mmap.c:1545
 vm_mmap_pgoff+0x195/0x200 mm/util.c:506
 ksys_mmap_pgoff+0x444/0x580 mm/mmap.c:1596
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x440379
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffc6ed13058 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440379
RDX: 0000000000000000 RSI: 0000000000003000 RDI: 0000000020007000
RBP: 00000000006ca018 R08: 0000000000000003 R09: 0000000000000000
R10: 0000000000000412 R11: 0000000000000246 R12: 0000000000401b80
R13: 0000000000401c10 R14: 0000000000000000 R15: 0000000000000000
================================================================================

