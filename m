Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15018294802
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 08:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440688AbgJUGFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 02:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407628AbgJUGFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 02:05:32 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276DEC0613CE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 23:05:32 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id ce10so1375146ejc.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 23:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ewZb9HYIkgoQO541ugqRFHeNMawALiE6XHrLu8EQl1Q=;
        b=ymF6klY/aBZ1rvxcY+z8rTwmv3hq7BpB+QlZVvSE/HIOSqMaPrPbvo3NVXmwqgbFLE
         Q033i3CWInTZwE+pgIJZTaNFrI1YaZoUuDtLaAHvpzVM/0NUpVgPerBImGRrwMYynagn
         kuKcXc8HjiQEVPAdkVKQ48PqRFGXgWWst4hUem8jMTN89mmhlYxNFRepWbp4JqJB2QLT
         VO6wCsxoNDEkwhEhCwjTvCwP6A6y38U8KJxbXUDvut4O7x32675nAKa3n4/golZuc89s
         8s8nudwaliqAsv2mhiF7fCtNo8ZWPEg4Z7RVwNyq5WsQmURJ3TqIZdYEDq79QoLH6whg
         WmYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ewZb9HYIkgoQO541ugqRFHeNMawALiE6XHrLu8EQl1Q=;
        b=AkdLCL6BFzKDQzQCzD8erIwEk1TNMV9qiFBHPBObuGH4okq2Vi9vV1wctxlwdyupSl
         oRX7JSKu3KUWEIW1+iD4/MJ32UJHAVFQNgYf2Gv8eoso9GY9nEhtgl4VzNbS/+RU0skA
         oYSSfzQoZYJxT/ezT72No10GQB/nCbWgTE9zg1aYMwT0Zu9NRC5CCzykbYn/YZMimlQY
         ItxiPp3XKgnsw07afESTjwxjwmBrU2nr+sSUceVNNNfZQn0zYfvoKejAfyNu0tAjjDkN
         3SiEtVVlRxMHOUT80k5xghhwTEjMzlbItrFapu7ZyeE2uYf84apqCf2lUxT4CTI+jgz8
         Lzpw==
X-Gm-Message-State: AOAM531W5EP/HV/AcGlsWmm6qDTDHt8mZZUFBWdMRCDostOLzLlzECql
        c4qSLmktTpuw+Ay2YM0Fan5mC5d+vY2En/jD
X-Google-Smtp-Source: ABdhPJzzP5olYBChwqIMGphUWGO54VYagJk/uXocf3MDqTbwFFl560l3T37K1SY/MVN30BMj/9k1+A==
X-Received: by 2002:a17:906:e88:: with SMTP id p8mr39582ejf.466.1603260328607;
        Tue, 20 Oct 2020 23:05:28 -0700 (PDT)
Received: from [192.168.0.13] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id j24sm1341806edq.29.2020.10.20.23.05.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Oct 2020 23:05:28 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: block, bfq: lockdep circular locking dependency gripe
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <e312d95f-f37a-106d-97a2-9d8d4cc28c9d@kernel.dk>
Date:   Wed, 21 Oct 2020 08:05:26 +0200
Cc:     Mike Galbraith <efault@gmx.de>, LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5CF89C35-09E2-4BF4-877D-7D82F33D6356@linaro.org>
References: <b3ce89d21d37a1ae2234d1942c6408cbce8d4f50.camel@gmx.de>
 <0B8A6A8E-453E-4E6E-886A-310A84B96FF5@linaro.org>
 <e312d95f-f37a-106d-97a2-9d8d4cc28c9d@kernel.dk>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Il giorno 20 ott 2020, alle ore 18:54, Jens Axboe <axboe@kernel.dk> ha =
scritto:
>=20
> On 10/20/20 1:15 AM, Paolo Valente wrote:
>>> Il giorno 20 ott 2020, alle ore 08:15, Mike Galbraith =
<efault@gmx.de> ha scritto:
>>>=20
>>> [ 1917.361401] =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>>> [ 1917.361406] WARNING: possible circular locking dependency =
detected
>>> [ 1917.361413] 5.9.0.g7cf726a-master #2 Tainted: G S          E
>>> [ 1917.361417] =
------------------------------------------------------
>>> [ 1917.361422] kworker/u16:35/15995 is trying to acquire lock:
>>> [ 1917.361428] ffff89232237f7e0 (&ioc->lock){..-.}-{2:2}, at: =
put_io_context+0x30/0x90
>>> [ 1917.361440]
>>>              but task is already holding lock:
>>> [ 1917.361445] ffff892244d2cc08 (&bfqd->lock){-.-.}-{2:2}, at: =
bfq_insert_requests+0x89/0x680
>>> [ 1917.361456]
>>>              which lock already depends on the new lock.
>>>=20
>>> [ 1917.361463]
>>>              the existing dependency chain (in reverse order) is:
>>> [ 1917.361469]
>>>              -> #1 (&bfqd->lock){-.-.}-{2:2}:
>>> [ 1917.361479]        _raw_spin_lock_irqsave+0x3d/0x50
>>> [ 1917.361484]        bfq_exit_icq_bfqq+0x48/0x3f0
>>> [ 1917.361489]        bfq_exit_icq+0x13/0x20
>>> [ 1917.361494]        put_io_context_active+0x55/0x80
>>> [ 1917.361499]        do_exit+0x72c/0xca0
>>> [ 1917.361504]        do_group_exit+0x47/0xb0
>>> [ 1917.361508]        __x64_sys_exit_group+0x14/0x20
>>> [ 1917.361513]        do_syscall_64+0x33/0x40
>>> [ 1917.361518]        entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>> [ 1917.361523]
>>>              -> #0 (&ioc->lock){..-.}-{2:2}:
>>> [ 1917.361532]        __lock_acquire+0x149d/0x1a70
>>> [ 1917.361537]        lock_acquire+0x1a7/0x3b0
>>> [ 1917.361542]        _raw_spin_lock_irqsave+0x3d/0x50
>>> [ 1917.361547]        put_io_context+0x30/0x90
>>> [ 1917.361552]        blk_mq_free_request+0x4f/0x140
>>> [ 1917.361557]        blk_attempt_req_merge+0x19/0x30
>>> [ 1917.361563]        elv_attempt_insert_merge+0x4f/0x90
>>> [ 1917.361568]        blk_mq_sched_try_insert_merge+0x28/0x40
>>> [ 1917.361574]        bfq_insert_requests+0x94/0x680
>>> [ 1917.361579]        blk_mq_sched_insert_requests+0xd1/0x2a0
>>> [ 1917.361584]        blk_mq_flush_plug_list+0x12d/0x240
>>> [ 1917.361589]        blk_flush_plug_list+0xb4/0xd0
>>> [ 1917.361594]        io_schedule_prepare+0x3c/0x40
>>> [ 1917.361599]        io_schedule+0xb/0x40
>>> [ 1917.361604]        blk_mq_get_tag+0x13a/0x250
>>> [ 1917.361608]        __blk_mq_alloc_request+0x5c/0x130
>>> [ 1917.361613]        blk_mq_submit_bio+0xf3/0x770
>>> [ 1917.361618]        submit_bio_noacct+0x41e/0x4b0
>>> [ 1917.361622]        submit_bio+0x33/0x160
>>> [ 1917.361644]        ext4_io_submit+0x49/0x60 [ext4]
>>> [ 1917.361661]        ext4_writepages+0x683/0x1070 [ext4]
>>> [ 1917.361667]        do_writepages+0x3c/0xe0
>>> [ 1917.361672]        __writeback_single_inode+0x62/0x630
>>> [ 1917.361677]        writeback_sb_inodes+0x218/0x4d0
>>> [ 1917.361681]        __writeback_inodes_wb+0x5f/0xc0
>>> [ 1917.361686]        wb_writeback+0x283/0x490
>>> [ 1917.361691]        wb_workfn+0x29a/0x670
>>> [ 1917.361696]        process_one_work+0x283/0x620
>>> [ 1917.361701]        worker_thread+0x39/0x3f0
>>> [ 1917.361706]        kthread+0x152/0x170
>>> [ 1917.361711]        ret_from_fork+0x1f/0x30
>>> [ 1917.361715]
>>>              other info that might help us debug this:
>>>=20
>>> [ 1917.361722]  Possible unsafe locking scenario:
>>>=20
>>> [ 1917.361728]        CPU0                    CPU1
>>> [ 1917.361731]        ----                    ----
>>> [ 1917.361736]   lock(&bfqd->lock);
>>> [ 1917.361740]                                lock(&ioc->lock);
>>> [ 1917.361746]                                lock(&bfqd->lock);
>>> [ 1917.361752]   lock(&ioc->lock);
>>> [ 1917.361757]
>>>               *** DEADLOCK ***
>>>=20
>>> [ 1917.361763] 5 locks held by kworker/u16:35/15995:
>>> [ 1917.361767]  #0: ffff892240c9bd38 =
((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work+0x1fa/0x620
>>> [ 1917.361778]  #1: ffff94569342fe78 =
((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: =
process_one_work+0x1fa/0x620
>>> [ 1917.361789]  #2: ffff8921424ae0e0 =
(&type->s_umount_key#39){++++}-{3:3}, at: trylock_super+0x16/0x50
>>> [ 1917.361800]  #3: ffff8921424aaa40 =
(&sbi->s_writepages_rwsem){.+.+}-{0:0}, at: do_writepages+0x3c/0xe0
>>> [ 1917.361811]  #4: ffff892244d2cc08 (&bfqd->lock){-.-.}-{2:2}, at: =
bfq_insert_requests+0x89/0x680
>>> [ 1917.361821]
>>>              stack backtrace:
>>> [ 1917.361827] CPU: 6 PID: 15995 Comm: kworker/u16:35 Kdump: loaded =
Tainted: G S          E     5.9.0.g7cf726a-master #2
>>> [ 1917.361833] Hardware name: MEDION MS-7848/MS-7848, BIOS =
M7848W08.20C 09/23/2013
>>> [ 1917.361840] Workqueue: writeback wb_workfn (flush-8:32)
>>> [ 1917.361846] Call Trace:
>>> [ 1917.361854]  dump_stack+0x77/0x97
>>> [ 1917.361860]  check_noncircular+0xe7/0x100
>>> [ 1917.361866]  ? __lock_acquire+0x2ce/0x1a70
>>> [ 1917.361872]  ? __lock_acquire+0x149d/0x1a70
>>> [ 1917.361877]  __lock_acquire+0x149d/0x1a70
>>> [ 1917.361884]  lock_acquire+0x1a7/0x3b0
>>> [ 1917.361889]  ? put_io_context+0x30/0x90
>>> [ 1917.361894]  ? bfq_put_queue+0xcf/0x480
>>> [ 1917.361901]  _raw_spin_lock_irqsave+0x3d/0x50
>>> [ 1917.361906]  ? put_io_context+0x30/0x90
>>> [ 1917.361911]  put_io_context+0x30/0x90
>>> [ 1917.361916]  blk_mq_free_request+0x4f/0x140
>>> [ 1917.361921]  blk_attempt_req_merge+0x19/0x30
>>> [ 1917.361926]  elv_attempt_insert_merge+0x4f/0x90
>>> [ 1917.361932]  blk_mq_sched_try_insert_merge+0x28/0x40
>>> [ 1917.361937]  bfq_insert_requests+0x94/0x680
>>> [ 1917.361944]  blk_mq_sched_insert_requests+0xd1/0x2a0
>>> [ 1917.361950]  blk_mq_flush_plug_list+0x12d/0x240
>>> [ 1917.361956]  blk_flush_plug_list+0xb4/0xd0
>>> [ 1917.361962]  io_schedule_prepare+0x3c/0x40
>>> [ 1917.361967]  io_schedule+0xb/0x40
>>> [ 1917.361972]  blk_mq_get_tag+0x13a/0x250
>>> [ 1917.361978]  ? wait_woken+0xa0/0xa0
>>> [ 1917.361984]  __blk_mq_alloc_request+0x5c/0x130
>>> [ 1917.361989]  blk_mq_submit_bio+0xf3/0x770
>>> [ 1917.361996]  submit_bio_noacct+0x41e/0x4b0
>>> [ 1917.362002]  ? submit_bio+0x33/0x160
>>> [ 1917.362007]  submit_bio+0x33/0x160
>>> [ 1917.362028]  ext4_io_submit+0x49/0x60 [ext4]
>>> [ 1917.362045]  ext4_writepages+0x683/0x1070 [ext4]
>>> [ 1917.362056]  ? do_writepages+0x3c/0xe0
>>> [ 1917.362060]  do_writepages+0x3c/0xe0
>>> [ 1917.362067]  ? __writeback_single_inode+0x62/0x630
>>> [ 1917.362072]  __writeback_single_inode+0x62/0x630
>>> [ 1917.362078]  writeback_sb_inodes+0x218/0x4d0
>>> [ 1917.362087]  __writeback_inodes_wb+0x5f/0xc0
>>> [ 1917.362093]  wb_writeback+0x283/0x490
>>> [ 1917.362100]  ? wb_workfn+0x29a/0x670
>>> [ 1917.362104]  wb_workfn+0x29a/0x670
>>> [ 1917.362112]  ? process_one_work+0x283/0x620
>>> [ 1917.362117]  ? process_one_work+0x251/0x620
>>> [ 1917.362121]  process_one_work+0x283/0x620
>>> [ 1917.362128]  worker_thread+0x39/0x3f0
>>> [ 1917.362133]  ? process_one_work+0x620/0x620
>>> [ 1917.362138]  kthread+0x152/0x170
>>> [ 1917.362142]  ? kthread_park+0x90/0x90
>>> [ 1917.362148]  ret_from_fork+0x1f/0x30
>>=20
>> Hi,
>> that's apparently hard to solve inside bfq. The the ioc of the task =
is
>> being exited while the task is still inside the code for having an =
I/O
>> request served. Is still normal?
>=20
> (please don't top post...)
>=20
> First of all, never assume you have to work around what appears to be
> core issues in BFQ. That doesn't mean the problem is unsolvable, just
> that it might need solving outside of BFQ.
>=20

One of us is not seeing the core problem here; and for sure it's me. =
Upstream of the circular dependency addressed by your patch attempt, the =
problem I see is that the icq can be destroyed while other icq-based =
code is being executed.

In the exact case reported in this thread, it happens that we are in the =
middle of an insert_request. So, we may get to, e.g., this instruction =
in the middle of bfq_init_rq()

bic =3D icq_to_bic(rq->elv.icq);

but the icq in rq->elv.icq is already a pending pointer.

What am I missing?

Thanks,
Paolo

