Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0661826A25B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 11:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgIOJgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 05:36:13 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:55107 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgIOJgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 05:36:09 -0400
Received: by mail-io1-f69.google.com with SMTP id q6so1732709iod.21
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 02:36:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=UcoXJ3DWpxuxQFqTRdNdlGwpRE+88WY3RzezobyEb4w=;
        b=UdaS+6U/iGC04od1jSZOa4E0M0PJTQkLfTawGoju0E/HsfJSQKrqkKgY5aXVxSFZGI
         9oQ2AYeaU5QmxGEUx61qNW1A8n8rSCtltIxOBeMUFQ9So4u6819LMns47DVdbYf+MkUO
         BCznFxmA+pRY/6EyxUPww//R0AWylMoeiYjJ/5GL8Zn82KakxB8Dnn93HnjhDVLZKtA0
         BfVj619sCdiAcJeOujH/uFXwmM3qEFh3B6vJPc5Y9ccpJ/cQvGy3jHIq4kEcUjCqAXGM
         Ri9kMpEXifzlVw3+zciVo5NmN/OE2yt0fO7jDIDPD4n/HKSTdLpvn80VHhlANqXkFb0a
         Hqgw==
X-Gm-Message-State: AOAM532OptAW8SJSSBSOyAblLnVQ1G2NcQrhRnNmQ9mDtPW4ikcLPGfX
        6anpZjYqCxsmTN9kYjhv8pXf95gl93Ap6WAtidjaYtcQm1+Z
X-Google-Smtp-Source: ABdhPJwZnkEcLy8h8u0SX4E5QCPA5MN3NTubf7r0fjA2ZMbOzsXpDEn33AmtqsuPHvyVOm7JCbmZ1uqAcWu92ldr1l8H3iiGaSPN
MIME-Version: 1.0
X-Received: by 2002:a6b:244:: with SMTP id 65mr14205002ioc.7.1600162568887;
 Tue, 15 Sep 2020 02:36:08 -0700 (PDT)
Date:   Tue, 15 Sep 2020 02:36:08 -0700
In-Reply-To: <c18bd0f194854077bbab3c50bab98c92@huawei.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000080680205af56e162@google.com>
Subject: Re: general protection fault in unlink_file_vma
From:   syzbot <syzbot+c5d5a51dcbb558ca0cb5@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, hdanton@sina.com, linmiaohe@huawei.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel panic: corrupted stack end in sys_nanosleep

Kernel panic - not syncing: corrupted stack end detected inside scheduler
CPU: 0 PID: 13791 Comm: syz-executor.4 Not tainted 5.9.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x198/0x1fd lib/dump_stack.c:118
 panic+0x347/0x7c0 kernel/panic.c:231
 schedule_debug kernel/sched/core.c:4278 [inline]
 __schedule+0x221e/0x2230 kernel/sched/core.c:4422
 schedule+0xd0/0x2a0 kernel/sched/core.c:4602
 freezable_schedule include/linux/freezer.h:172 [inline]
 do_nanosleep+0x222/0x650 kernel/time/hrtimer.c:1883
 hrtimer_nanosleep+0x1f9/0x430 kernel/time/hrtimer.c:1936
 __do_sys_nanosleep kernel/time/hrtimer.c:1970 [inline]
 __se_sys_nanosleep kernel/time/hrtimer.c:1957 [inline]
 __x64_sys_nanosleep+0x1dc/0x260 kernel/time/hrtimer.c:1957
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45ba81
Code: 75 14 b8 23 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 84 cf fb ff c3 48 83 ec 08 e8 ea 46 00 00 48 89 04 24 b8 23 00 00 00 0f 05 <48> 8b 3c 24 48 89 c2 e8 33 47 00 00 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007ffca6cb6d70 EFLAGS: 00000293 ORIG_RAX: 0000000000000023
RAX: ffffffffffffffda RBX: 000000000002f226 RCX: 000000000045ba81
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007ffca6cb6d80
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
R10: 00007ffca6cb6e80 R11: 0000000000000293 R12: 000000000118cf40
R13: 000000000118d940 R14: ffffffffffffffff R15: 000000000118cfec
Kernel Offset: disabled
Rebooting in 86400 seconds..


Tested on:

commit:         796cd8f4 fix gpf
git tree:       https://github.com/Linmiaohe/linux/
console output: https://syzkaller.appspot.com/x/log.txt?x=12b5d501900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f82e58a6661a5ac4
dashboard link: https://syzkaller.appspot.com/bug?extid=c5d5a51dcbb558ca0cb5
compiler:       gcc (GCC) 10.1.0-syz 20200507

