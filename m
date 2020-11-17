Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD91A2B5A4B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 08:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbgKQH3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 02:29:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42134 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725446AbgKQH3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 02:29:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605598169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EABzoGRjpJYeGdKKriHs4uvE7ly/wFJZHFUgnwTxp9U=;
        b=IupYNcRN5Vnbvx6NZ/0IXSXETqJRZaOyqwEM1t2LwEmefQZHvac2zyNCKz/Qus1iw9NLaH
        AJEYJSfN3nZu8lxjMtrAHshhFK9aFs6HS8/hhLiUgj48bWlMZEdV9pIqvOuoOaqoM5vMjC
        pskcnhcOjmyZBIubs03+eRwOucdL/v4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-pMSSs4ZDPN2JT148keEYYA-1; Tue, 17 Nov 2020 02:29:28 -0500
X-MC-Unique: pMSSs4ZDPN2JT148keEYYA-1
Received: by mail-wr1-f70.google.com with SMTP id l5so12574653wrn.18
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 23:29:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EABzoGRjpJYeGdKKriHs4uvE7ly/wFJZHFUgnwTxp9U=;
        b=mFWCN/No5007+cQlPGs7D0elzvWXJGn0zFwgdAaAwDIcd6WSGNKAU3zs3eZ+f05Dfo
         zH/gFk7YMDbc7N4vnXUDtgUC4t4y9aeLmYkfTkFy3gwIVfA+bawGuHmHpTbexpltHqZI
         Q5n/HqIXCUBmZ442hcpfHRzNW8HaJOmlGan0giIGa/V5E8Kbke8geA/ZGYadoJ0PTFn0
         4Mn6XO8zUB29d+169vRr2qnuO+l7CbX7ktCZArKy2gFIF6KRmR2QdfZ7H/J3dPz3IZH2
         opd24w1SX2BKAzE+ptFMMl0ZuL9Cyg5zef9PVfYzAolngr118UpCeJv/eBzcc9tPFmt4
         71Jg==
X-Gm-Message-State: AOAM532SYrDFNxTuG24JnSJXc7+u/qjYixXiVsB2KkkunNSKbPQyBjKh
        1tAUBX0BN1RugOeslckvVvdwYRKGWAeoXnimpjciGMWPFK50GlYDjm4OxrMy/BWYo8imoIi4vVS
        D+pyXjAePh9+afxsZV4ekGAyV
X-Received: by 2002:a1c:ddd7:: with SMTP id u206mr2737309wmg.27.1605598167003;
        Mon, 16 Nov 2020 23:29:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxBK3KpOBBcDUjUwFWT6r9TbIfXVgncVq8eMg7jXz+o4SbbJMMLnCfyajsdMIU4TnoIgLF3rQ==
X-Received: by 2002:a1c:ddd7:: with SMTP id u206mr2737290wmg.27.1605598166761;
        Mon, 16 Nov 2020 23:29:26 -0800 (PST)
Received: from x1.bristot.me (host-95-246-207-183.retail.telecomitalia.it. [95.246.207.183])
        by smtp.gmail.com with ESMTPSA id c5sm16582876wrb.64.2020.11.16.23.29.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2020 23:29:26 -0800 (PST)
Subject: Re: [PATCH v2] sched/deadline: Fix priority inheritance with multiple
 scheduling classes
To:     Juri Lelli <juri.lelli@redhat.com>, peterz@infradead.org,
        mingo@redhat.com, glenn@aurora.tech
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        tglx@linutronix.de, luca.abeni@santannapisa.it,
        tommaso.cucinotta@santannapisa.it, valentin.schneider@arm.com
References: <20201117061432.517340-1-juri.lelli@redhat.com>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <546acb52-9766-0947-abc1-5071891a8caf@redhat.com>
Date:   Tue, 17 Nov 2020 08:29:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201117061432.517340-1-juri.lelli@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/17/20 7:14 AM, Juri Lelli wrote:
> Glenn reported that "an application [he developed produces] a BUG in
> deadline.c when a SCHED_DEADLINE task contends with CFS tasks on nested
> PTHREAD_PRIO_INHERIT mutexes.  I believe the bug is triggered when a CFS
> task that was boosted by a SCHED_DEADLINE task boosts another CFS task
> (nested priority inheritance).
> 
>  ------------[ cut here ]------------
>  kernel BUG at kernel/sched/deadline.c:1462!
>  invalid opcode: 0000 [#1] PREEMPT SMP
>  CPU: 12 PID: 19171 Comm: dl_boost_bug Tainted: ...
>  Hardware name: ...
>  RIP: 0010:enqueue_task_dl+0x335/0x910
>  Code: ...
>  RSP: 0018:ffffc9000c2bbc68 EFLAGS: 00010002
>  RAX: 0000000000000009 RBX: ffff888c0af94c00 RCX: ffffffff81e12500
>  RDX: 000000000000002e RSI: ffff888c0af94c00 RDI: ffff888c10b22600
>  RBP: ffffc9000c2bbd08 R08: 0000000000000009 R09: 0000000000000078
>  R10: ffffffff81e12440 R11: ffffffff81e1236c R12: ffff888bc8932600
>  R13: ffff888c0af94eb8 R14: ffff888c10b22600 R15: ffff888bc8932600
>  FS:  00007fa58ac55700(0000) GS:ffff888c10b00000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 00007fa58b523230 CR3: 0000000bf44ab003 CR4: 00000000007606e0
>  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>  PKRU: 55555554
>  Call Trace:
>   ? intel_pstate_update_util_hwp+0x13/0x170
>   rt_mutex_setprio+0x1cc/0x4b0
>   task_blocks_on_rt_mutex+0x225/0x260
>   rt_spin_lock_slowlock_locked+0xab/0x2d0
>   rt_spin_lock_slowlock+0x50/0x80
>   hrtimer_grab_expiry_lock+0x20/0x30
>   hrtimer_cancel+0x13/0x30
>   do_nanosleep+0xa0/0x150
>   hrtimer_nanosleep+0xe1/0x230
>   ? __hrtimer_init_sleeper+0x60/0x60
>   __x64_sys_nanosleep+0x8d/0xa0
>   do_syscall_64+0x4a/0x100
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
>  RIP: 0033:0x7fa58b52330d
>  ...
>  ---[ end trace 0000000000000002 ]—
> 
> He also provided a simple reproducer creating the situation below:
> 
>  So the execution order of locking steps are the following
>  (N1 and N2 are non-deadline tasks. D1 is a deadline task. M1 and M2
>  are mutexes that are enabled * with priority inheritance.)
> 
>  Time moves forward as this timeline goes down:
> 
>  N1              N2               D1
>  |               |                |
>  |               |                |
>  Lock(M1)        |                |
>  |               |                |
>  |             Lock(M2)           |
>  |               |                |
>  |               |              Lock(M2)
>  |               |                |
>  |             Lock(M1)           |
>  |             (!!bug triggered!) |
> 
> Daniel reported a similar situation as well, by just letting ksoftirqd
> run with DEADLINE (and eventually block on a mutex).
> 
> Problem is that boosted entities (Priority Inheritance) use static
> DEADLINE parameters of the top priority waiter. However, there might be
> cases where top waiter could be a non-DEADLINE entity that is currently
> boosted by a DEADLINE entity from a different lock chain (i.e., nested
> priority chains involving entities of non-DEADLINE classes). In this
> case, top waiter static DEADLINE parameters could be null (initialized
> to 0 at fork()) and replenish_dl_entity() would hit a BUG().
> 
> Fix this by keeping track of the original donor and using its parameters
> when a task is boosted.
> 
> Reported-by: Glenn Elliott <glenn@aurora.tech>
> Reported-by: Daniel Bristot de Oliveira <bristot@redhat.com>
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>

Tested-by: Daniel Bristot de Oliveira <bristot@redhat.com>

Thanks!
-- Daniel

