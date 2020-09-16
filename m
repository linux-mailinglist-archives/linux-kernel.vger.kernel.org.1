Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8858926BBF2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 07:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbgIPFnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 01:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgIPFnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 01:43:21 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9996C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 22:43:20 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id jw11so965882pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 22:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Qrq3sWEJgoeWzhxV9j06LwtU7QYCo+thwWi88qL3VUg=;
        b=fkcHvmrop4VahHNbAfKqUN9Z/xnGxShl3cVT2cp7BchjyYuKrTxQhmozhdhOt9+HYy
         XOlsmy/Dw9CsyTkM4O4wZI95ngjedk5Oa7YUAmjl9Z1DnL/a90UYT6pC61ajUuZqbSh7
         eWjqs1cBJo35Sc4E9NgZpBvJjNVRVIFIS7YGW126knVlIP1JRzdb5LDmgF2setaPgYlT
         UqdmBeky+98yaxUJx40dnkyrFks8kaySDmUER2CGfzlvhE5Cb5vT7Qc3DgZB6huGA3h0
         BTICEaoQoiyTkGWQyxr6uc2f0+FTS+hOD+XBZ/ZGyVptfLZsCIoFxCOqBa889EHlMgtK
         ShMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Qrq3sWEJgoeWzhxV9j06LwtU7QYCo+thwWi88qL3VUg=;
        b=eBR3abtJrl5RyCxRGh4h9k98iJmPPJ3UvCiOz8plnawJNtF7vA/CcKD5B1H1ZNiKoG
         jJ+PMnjr9ra330iwYGgO9xTyNLi1VKxIqQWpgenV9otzDEMDKam2doJ3gdbOU+6h9kSl
         8SUg2Eimt6wfTwUZvyVkPuucfabBOFNgQlb2+2+E0VflvGb17YjVihqZTZ3Ort90Biks
         dTyviaj2AWZC3Bww4+yhTy+rw1orjAYASPOxhNvknmLrMQq2xU0uY3098SZQqcocAWk4
         JvMzc/GlicW2/qf+h+6SEBaVcKtHtMPhDRe+AQjXgtl9gJ7zVjXZGNcX16HRuPyfDIzI
         c9uA==
X-Gm-Message-State: AOAM532qJYY9QsRjayS4ODyZ+QZlQhZG6ym2NKGhYONPXok0my2TUZvI
        l0QFLWrnibQkQ4BHGEXeFPSN5jYtqJNdrVf03hI=
X-Google-Smtp-Source: ABdhPJwPu84gHpjM2+ASPRJQcFspw7h0IDA+efa12CJ5xa+/3bZ76n2Rm8o5+n35JBe7GRUOKSG7pQ==
X-Received: by 2002:a17:90a:cb93:: with SMTP id a19mr430370pju.207.1600234999844;
        Tue, 15 Sep 2020 22:43:19 -0700 (PDT)
Received: from [192.168.0.104] ([49.207.198.18])
        by smtp.gmail.com with ESMTPSA id i62sm15140419pfe.140.2020.09.15.22.43.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2020 22:43:19 -0700 (PDT)
Subject: Re: WARNING in batadv_iv_send_outstanding_bat_ogm_packet
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <00000000000059b6d40594d0f776@google.com>
 <a8a0dbe1-80de-4438-9443-6e25de63910fn@googlegroups.com>
 <CACT4Y+bvwOZCF_--T=_Vxk1YCqGxMGEyrs3tRSyGNw1ENMJb1g@mail.gmail.com>
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
Message-ID: <7cff3e3e-4003-a2bc-9917-a006e76854c8@gmail.com>
Date:   Wed, 16 Sep 2020 11:13:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+bvwOZCF_--T=_Vxk1YCqGxMGEyrs3tRSyGNw1ENMJb1g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 16/09/20 10:25 am, Dmitry Vyukov wrote:
> On Tue, Sep 15, 2020 at 8:34 PM Anant Thazhemadam
> <anant.thazhemadam@gmail.com> wrote:
>> On Monday, October 14, 2019 at 2:25:08 AM UTC+5:30 syzbot wrote:
>>> Hello,
>>>
>>> syzbot found the following crash on:
>>>
>>> HEAD commit: da940012 Merge tag 'char-misc-5.4-rc3' of git://git.kernel..
>>> git tree: upstream
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=13ffd808e00000
>>> kernel config: https://syzkaller.appspot.com/x/.config?x=2d2fd92a28d3e50
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=c0b807de416427ff3dd1
>>> compiler: clang version 9.0.0 (/home/glider/llvm/clang
>>> 80fee25776c2fb61e74c1ecb1a523375c2500b69)
>>> syz repro: https://syzkaller.appspot.com/x/repro.syz?x=141ffd77600000
>>> C reproducer: https://syzkaller.appspot.com/x/repro.c?x=11edd580e00000
>>>
>>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>>> Reported-by: syzbot+c0b807...@syzkaller.appspotmail.com
>>>
>>> ------------[ cut here ]------------
>>> WARNING: CPU: 1 PID: 30 at net/batman-adv/bat_iv_ogm.c:382
>>> batadv_iv_ogm_emit net/batman-adv/bat_iv_ogm.c:382 [inline]
>>> WARNING: CPU: 1 PID: 30 at net/batman-adv/bat_iv_ogm.c:382
>>> batadv_iv_send_outstanding_bat_ogm_packet+0x6b4/0x770
>>> net/batman-adv/bat_iv_ogm.c:1663
>>> Kernel panic - not syncing: panic_on_warn set ...
>>> CPU: 1 PID: 30 Comm: kworker/u4:2 Not tainted 5.4.0-rc2+ #0
>>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>>> Google 01/01/2011
>>> Workqueue: bat_events batadv_iv_send_outstanding_bat_ogm_packet
>>> Call Trace:
>>> __dump_stack lib/dump_stack.c:77 [inline]
>>> dump_stack+0x1d8/0x2f8 lib/dump_stack.c:113
>>> panic+0x264/0x7a9 kernel/panic.c:221
>>> __warn+0x20e/0x210 kernel/panic.c:582
>>> report_bug+0x1b6/0x2f0 lib/bug.c:195
>>> fixup_bug arch/x86/kernel/traps.c:179 [inline]
>>> do_error_trap+0xd7/0x440 arch/x86/kernel/traps.c:272
>>> do_invalid_op+0x36/0x40 arch/x86/kernel/traps.c:291
>>> invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1028
>>> RIP: 0010:batadv_iv_ogm_emit net/batman-adv/bat_iv_ogm.c:382 [inline]
>>> RIP: 0010:batadv_iv_send_outstanding_bat_ogm_packet+0x6b4/0x770
>>> net/batman-adv/bat_iv_ogm.c:1663
>>> Code: 66 05 00 eb 05 e8 9c 48 23 fa 48 83 c4 68 5b 41 5c 41 5d 41 5e 41 5f
>>> 5d c3 e8 88 48 23 fa 0f 0b e9 34 ff ff ff e8 7c 48 23 fa <0f> 0b e9 28 ff
>>> ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c c1 f9 ff
>>> RSP: 0018:ffff8880a9abfc48 EFLAGS: 00010293
>>> RAX: ffffffff874fe8a4 RBX: ffff888094160870 RCX: ffff8880a9ab2080
>>> RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
>>> RBP: ffff8880a9abfcd8 R08: ffffffff874fe28e R09: ffffed10123e6969
>>> R10: ffffed10123e6969 R11: 0000000000000000 R12: ffff888091f34000
>>> R13: dffffc0000000000 R14: ffff8880a80c5000 R15: ffff8880a4481400
>>> process_one_work+0x7ef/0x10e0 kernel/workqueue.c:2269
>>> worker_thread+0xc01/0x1630 kernel/workqueue.c:2415
>>> kthread+0x332/0x350 kernel/kthread.c:255
>>> ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
>>> Kernel Offset: disabled
>>> Rebooting in 86400 seconds..
>>>
>>>
>>> ---
>>> This bug is generated by a bot. It may contain errors.
>>> See https://goo.gl/tpsmEJ for more information about syzbot.
>>> syzbot engineers can be reached at syzk...@googlegroups.com.
>>>
>>> syzbot will keep track of this bug report. See:
>>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>>> syzbot can test patches for this bug, for details see:
>>> https://goo.gl/tpsmEJ#testing-patches
>>
>> For this bug, syzbot does not seem to be able to build the kernel anymore.
>> Can bugs like these be considered and closed as invalid?
>>
>> Thanks,
>> Anant
> Hi Anant,
>
> +syzkaler, lkml (nobody is generally reading syzkaller-bugs).
>
> What do you mean by "not able to build a kernel for this bug"?
> Building a kernel is not related to a particular bug. It's the same
> for all bugs...

Hi,

I thought this might be a query that's better suited for the syzkaller groups,
and hence posted it on there.

I wanted to check if this bug was still present and relevant, so I tried to check
by sending a syz test request for the upstream kernel (the dashboard shows
that the error was found in the upstream kernel).

However, I was notified later that the build/boot had failed.
Feel free to correct me if I'm wrong, but I doubt that the reason build/boot
had failed, was because of the bug itself (the error report is visible on the
bug's dashboard page itself).

I wanted to know what was the typical protocol in cases like this. Would this be
a valid reason enough to close the bug as invalid? Or is there something else
that can be done, to indicate that the upstream kernel doesn't even build/boot
for this bug to be tested anymore?
If nothing else, how else can I try and get syzbot to test if this bug still exists or
not?

Thanks,
Anant

