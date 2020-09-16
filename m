Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D537F26BBA0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 06:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgIPEz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 00:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbgIPEzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 00:55:23 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BEEC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 21:55:22 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id v123so6916611qkd.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 21:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tPHd4pdGXjsQOHAETQ6Xbv099uq9TN20sjm5ojVFh/U=;
        b=Bpxqol9+GpfW2RNYhG2r7k+wDV6Gwp4UaOZlFz7j/L8ig0Ok0UX5a3nGiasEfKyHI9
         Y7wL5CRCckbJKgousmhGnL1fe44JIgwdau/G5wgvc66rz4U61waUwkVcCZtkhAKzeFJr
         HNjBbMA2aA3NKd4T665eJ9BDE/aMUma6X6xl4aT0EyOqPDqUY1XTyceC5jAj5HFCh7Ht
         ZxJcwv2wBDE+Tt5slxAUHZ/td1d+etV14tzWRxb8NcvlzUHkw7le8/Rnwx+SiIXBFfFe
         l9RM/dC4fXREeakU7d1Gvb/CFW63npVi4jq5oe9l+NPq+bvudFsRvHF9fB6Ooex4pbv3
         rdaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tPHd4pdGXjsQOHAETQ6Xbv099uq9TN20sjm5ojVFh/U=;
        b=mM4AWqdQkkmcqHtH0hHNDpD0NdR6mbI77ooRHmrEXh1kaNORnicV0ruBGQzPs07T/8
         8akwVfZH3TsNmn/Jen+trNdw3HFGpQH0xstmOFqh/5CyvXOE1smLF06SeqR8OKObrL4h
         y11yQkrQwrqkT7+tywlrGQp+en41WoQ2iilKW7fNJEymEodxTg3dO2yxpn0xSbauUstN
         qAoN+AERtyhTQhFpjrYK6Cxk1LC+wH0DVmkZESpsXgq/gAuGqPnbr13Eb2AJy4jGcKiT
         28JV+gA4DU5YbPX4OJcbgT2Hyqer2Q0Pk4R1qA2F5M/hUploaoPFkF7OG7S+6LBDW/pw
         V7vg==
X-Gm-Message-State: AOAM5311c9MlVhNJkqPkH1roE8f5kl8bijHj1VCo+rNCZKpTqBKPSh2a
        9lNhug4qcD/ShRbSszQz+/lOm+P99MMzUffYTUMFa8B6y0jRAA==
X-Google-Smtp-Source: ABdhPJz/mRP2nZ/dBHANgxTq2gzIzIjlPzsD/OqRvQCN2EH8hbXWqR16FKFcO5iC6QSOIhT2o6ZKR/DFeSuPuEdxQoU=
X-Received: by 2002:a37:54a:: with SMTP id 71mr18965698qkf.407.1600232121286;
 Tue, 15 Sep 2020 21:55:21 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000059b6d40594d0f776@google.com> <a8a0dbe1-80de-4438-9443-6e25de63910fn@googlegroups.com>
In-Reply-To: <a8a0dbe1-80de-4438-9443-6e25de63910fn@googlegroups.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 16 Sep 2020 06:55:09 +0200
Message-ID: <CACT4Y+bvwOZCF_--T=_Vxk1YCqGxMGEyrs3tRSyGNw1ENMJb1g@mail.gmail.com>
Subject: Re: WARNING in batadv_iv_send_outstanding_bat_ogm_packet
To:     Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 8:34 PM Anant Thazhemadam
<anant.thazhemadam@gmail.com> wrote:
> On Monday, October 14, 2019 at 2:25:08 AM UTC+5:30 syzbot wrote:
>>
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit: da940012 Merge tag 'char-misc-5.4-rc3' of git://git.kernel..
>> git tree: upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=13ffd808e00000
>> kernel config: https://syzkaller.appspot.com/x/.config?x=2d2fd92a28d3e50
>> dashboard link: https://syzkaller.appspot.com/bug?extid=c0b807de416427ff3dd1
>> compiler: clang version 9.0.0 (/home/glider/llvm/clang
>> 80fee25776c2fb61e74c1ecb1a523375c2500b69)
>> syz repro: https://syzkaller.appspot.com/x/repro.syz?x=141ffd77600000
>> C reproducer: https://syzkaller.appspot.com/x/repro.c?x=11edd580e00000
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+c0b807...@syzkaller.appspotmail.com
>>
>> ------------[ cut here ]------------
>> WARNING: CPU: 1 PID: 30 at net/batman-adv/bat_iv_ogm.c:382
>> batadv_iv_ogm_emit net/batman-adv/bat_iv_ogm.c:382 [inline]
>> WARNING: CPU: 1 PID: 30 at net/batman-adv/bat_iv_ogm.c:382
>> batadv_iv_send_outstanding_bat_ogm_packet+0x6b4/0x770
>> net/batman-adv/bat_iv_ogm.c:1663
>> Kernel panic - not syncing: panic_on_warn set ...
>> CPU: 1 PID: 30 Comm: kworker/u4:2 Not tainted 5.4.0-rc2+ #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>> Google 01/01/2011
>> Workqueue: bat_events batadv_iv_send_outstanding_bat_ogm_packet
>> Call Trace:
>> __dump_stack lib/dump_stack.c:77 [inline]
>> dump_stack+0x1d8/0x2f8 lib/dump_stack.c:113
>> panic+0x264/0x7a9 kernel/panic.c:221
>> __warn+0x20e/0x210 kernel/panic.c:582
>> report_bug+0x1b6/0x2f0 lib/bug.c:195
>> fixup_bug arch/x86/kernel/traps.c:179 [inline]
>> do_error_trap+0xd7/0x440 arch/x86/kernel/traps.c:272
>> do_invalid_op+0x36/0x40 arch/x86/kernel/traps.c:291
>> invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1028
>> RIP: 0010:batadv_iv_ogm_emit net/batman-adv/bat_iv_ogm.c:382 [inline]
>> RIP: 0010:batadv_iv_send_outstanding_bat_ogm_packet+0x6b4/0x770
>> net/batman-adv/bat_iv_ogm.c:1663
>> Code: 66 05 00 eb 05 e8 9c 48 23 fa 48 83 c4 68 5b 41 5c 41 5d 41 5e 41 5f
>> 5d c3 e8 88 48 23 fa 0f 0b e9 34 ff ff ff e8 7c 48 23 fa <0f> 0b e9 28 ff
>> ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c c1 f9 ff
>> RSP: 0018:ffff8880a9abfc48 EFLAGS: 00010293
>> RAX: ffffffff874fe8a4 RBX: ffff888094160870 RCX: ffff8880a9ab2080
>> RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
>> RBP: ffff8880a9abfcd8 R08: ffffffff874fe28e R09: ffffed10123e6969
>> R10: ffffed10123e6969 R11: 0000000000000000 R12: ffff888091f34000
>> R13: dffffc0000000000 R14: ffff8880a80c5000 R15: ffff8880a4481400
>> process_one_work+0x7ef/0x10e0 kernel/workqueue.c:2269
>> worker_thread+0xc01/0x1630 kernel/workqueue.c:2415
>> kthread+0x332/0x350 kernel/kthread.c:255
>> ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
>> Kernel Offset: disabled
>> Rebooting in 86400 seconds..
>>
>>
>> ---
>> This bug is generated by a bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for more information about syzbot.
>> syzbot engineers can be reached at syzk...@googlegroups.com.
>>
>> syzbot will keep track of this bug report. See:
>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>> syzbot can test patches for this bug, for details see:
>> https://goo.gl/tpsmEJ#testing-patches
>
>
> For this bug, syzbot does not seem to be able to build the kernel anymore.
> Can bugs like these be considered and closed as invalid?
>
> Thanks,
> Anant

Hi Anant,

+syzkaler, lkml (nobody is generally reading syzkaller-bugs).

What do you mean by "not able to build a kernel for this bug"?
Building a kernel is not related to a particular bug. It's the same
for all bugs...
