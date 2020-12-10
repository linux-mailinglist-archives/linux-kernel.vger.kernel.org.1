Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6F62D5445
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 08:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387721AbgLJG6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 01:58:52 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:54596 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387698AbgLJG6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 01:58:51 -0500
Received: by mail-il1-f197.google.com with SMTP id z8so3515604ilq.21
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 22:58:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=aaJCcC8Sm2rMoASehVPhtArVK1xTKmJbN46GqeFlACc=;
        b=IUeEtZIBov2xsnKS+n2d/iYvSH6PkIc+eTYd+WvG+8ZTRDNQTLrmAnvyLaYgp0J8oa
         Y0f8WiaU0yHJ98X/tobqxDyrd7DY2vLGbOQ2OOyg40MC25cTX0iI8SUElacc3YeQszi9
         jFEJUQzrMb6BdhuM66m2W1DYb+8a7R44ZC10RoBU8Q91aCQ8nztabJ85rkw+T32whqhH
         vWotEm42IccYHXuxL0K7e7vYGd2+mUjyvJ9ANC6R+mzjOe2xQBatAddFKLXrTkO1/rnl
         VCXoG2MWaSm3Zbt4rMNPzqTOXOWEqJGtIx7v7GDd/oVaWp4upJEoiRp5jA+YWwsQTTHZ
         4xjA==
X-Gm-Message-State: AOAM532mxDolHSrD1Qc3JzuK0UCZeEC4EVmyL4xxkgkY0lHlRu26wPUg
        0U/5ZXlimXI57ygo8n85ri4WcES0H97UaLpYonLtDBM/afLv
X-Google-Smtp-Source: ABdhPJyE32kAOjZX/8Ff5hJ1mHIx2zLec/RC3L+2S9Yo8qudw63GLqTcPzi8XX5qHvpZAu0ZDHsstR0eSihZyA5LziDZhlx75opp
MIME-Version: 1.0
X-Received: by 2002:a6b:c3c5:: with SMTP id t188mr7341300iof.209.1607583490465;
 Wed, 09 Dec 2020 22:58:10 -0800 (PST)
Date:   Wed, 09 Dec 2020 22:58:10 -0800
In-Reply-To: <000000000000911d3905b459824c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e56a2605b616b2d9@google.com>
Subject: Re: memory leak in bpf
From:   syzbot <syzbot+f3694595248708227d35@syzkaller.appspotmail.com>
To:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, john.fastabend@gmail.com, kafai@fb.com,
        kpsingh@chromium.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    a68a0262 mm/madvise: remove racy mm ownership check
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11facf17500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4305fa9ea70c7a9f
dashboard link: https://syzkaller.appspot.com/bug?extid=f3694595248708227d35
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=159a9613500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11bf7123500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f3694595248708227d35@syzkaller.appspotmail.com

Debian GNU/Linux 9 syzkaller ttyS0
Warning: Permanently added '10.128.0.9' (ECDSA) to the list of known hosts.
executing program
executing program
executing program
BUG: memory leak
unreferenced object 0xffff88810efccc80 (size 64):
  comm "syz-executor334", pid 8460, jiffies 4294945724 (age 13.850s)
  hex dump (first 32 bytes):
    c0 cb 14 04 00 ea ff ff c0 c2 11 04 00 ea ff ff  ................
    c0 56 3f 04 00 ea ff ff 40 18 38 04 00 ea ff ff  .V?.....@.8.....
  backtrace:
    [<0000000036ae98a7>] kmalloc_node include/linux/slab.h:575 [inline]
    [<0000000036ae98a7>] bpf_ringbuf_area_alloc kernel/bpf/ringbuf.c:94 [inline]
    [<0000000036ae98a7>] bpf_ringbuf_alloc kernel/bpf/ringbuf.c:135 [inline]
    [<0000000036ae98a7>] ringbuf_map_alloc kernel/bpf/ringbuf.c:183 [inline]
    [<0000000036ae98a7>] ringbuf_map_alloc+0x1be/0x410 kernel/bpf/ringbuf.c:150
    [<00000000d2cb93ae>] find_and_alloc_map kernel/bpf/syscall.c:122 [inline]
    [<00000000d2cb93ae>] map_create kernel/bpf/syscall.c:825 [inline]
    [<00000000d2cb93ae>] __do_sys_bpf+0x7d0/0x30a0 kernel/bpf/syscall.c:4381
    [<000000008feaf393>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<00000000e1f53cfd>] entry_SYSCALL_64_after_hwframe+0x44/0xa9


