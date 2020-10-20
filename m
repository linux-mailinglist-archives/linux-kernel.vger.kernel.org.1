Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D24B2940DB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 18:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394960AbgJTQyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 12:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388972AbgJTQyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 12:54:17 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DD6C0613CE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 09:54:16 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id q1so3227671ilt.6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 09:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ky2VCuLOUNvEEhUdBS+EGM/Yh64zG1RvA7OaiwGOwr4=;
        b=1av1GJMJWRc77rFB4hX8ZlvJ0/RAV20mGW/jaq2L0pxrkz97Z8D8WeyahtzfU7PZXd
         6AhXv9AiUeSuRM2ASSuQjY3CbMCv2W/dUtmgYNELjnoqE4UfrNd0howWqKlu9iJ6z2BO
         VY5Cj4uMBg7Xu8O+LITnHuuu7hmW11S3+noUailzH8flyo/AY8JMeN+B78Xs/I1iSDyK
         hPm1hDh63zOhfVzyNWmIXGrqZAXCdVVDFPY9RbWZubwWWC9o8HZxXRMXh6UqURlca5Je
         BfFlXcHXUvPg7AKyrfS3Kohmglg5fUBj60yzt8QjWErYnqP8OWdw2JGhDpbkYtbXzeJK
         AbVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ky2VCuLOUNvEEhUdBS+EGM/Yh64zG1RvA7OaiwGOwr4=;
        b=r/ZE7/Sr+y11GEimDUHxVOwYLD/xISUvR3I8nh9HKpxKZ+3MkyarAdCxP0B8uPtz4l
         xpEp/lJBIelvW2clPe4KXhmujTg1qt1xP9JM7gt3jwR8ia+g8gFWsBrtU2wjWCOayeyK
         SJXvktf4fboh1s9pOySCrD+xaiBGC61kwyC577HhfzlRhbeGKP1ggBFJ1z3K/jXpNUhB
         Gl51S5UpEooqPZ7o/vVtFKSm9qgukQSPRtVrRciM8e4NDVml+TRR60CZj5OQElBhX/G9
         cIYah4qe5WwjfdWvGUA5gX8/KFe+u/PK9WbswqYceMENwzoFpSFvOZzeI38riKw0xTeb
         IaUA==
X-Gm-Message-State: AOAM532BzDrrQ5MREo5SM5/OQSDGTI7VxUuiJi8m3732lkVHKUggzywW
        0QPOGyKYSMAn6FlnREdsE587rLQW+htRkg==
X-Google-Smtp-Source: ABdhPJz84comMvWR52PqtMtiu/I2yLsS0jUtXqSBGNQbl92bR3NISU9BeNU2FNW+BjZpTYAUBY7XVQ==
X-Received: by 2002:a92:290b:: with SMTP id l11mr2900784ilg.46.1603212855636;
        Tue, 20 Oct 2020 09:54:15 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id l6sm2102862ilq.61.2020.10.20.09.54.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2020 09:54:15 -0700 (PDT)
Subject: Re: block, bfq: lockdep circular locking dependency gripe
To:     Paolo Valente <paolo.valente@linaro.org>,
        Mike Galbraith <efault@gmx.de>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <b3ce89d21d37a1ae2234d1942c6408cbce8d4f50.camel@gmx.de>
 <0B8A6A8E-453E-4E6E-886A-310A84B96FF5@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e312d95f-f37a-106d-97a2-9d8d4cc28c9d@kernel.dk>
Date:   Tue, 20 Oct 2020 10:54:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0B8A6A8E-453E-4E6E-886A-310A84B96FF5@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/20 1:15 AM, Paolo Valente wrote:
>> Il giorno 20 ott 2020, alle ore 08:15, Mike Galbraith <efault@gmx.de> ha scritto:
>>
>> [ 1917.361401] ======================================================
>> [ 1917.361406] WARNING: possible circular locking dependency detected
>> [ 1917.361413] 5.9.0.g7cf726a-master #2 Tainted: G S          E
>> [ 1917.361417] ------------------------------------------------------
>> [ 1917.361422] kworker/u16:35/15995 is trying to acquire lock:
>> [ 1917.361428] ffff89232237f7e0 (&ioc->lock){..-.}-{2:2}, at: put_io_context+0x30/0x90
>> [ 1917.361440]
>>               but task is already holding lock:
>> [ 1917.361445] ffff892244d2cc08 (&bfqd->lock){-.-.}-{2:2}, at: bfq_insert_requests+0x89/0x680
>> [ 1917.361456]
>>               which lock already depends on the new lock.
>>
>> [ 1917.361463]
>>               the existing dependency chain (in reverse order) is:
>> [ 1917.361469]
>>               -> #1 (&bfqd->lock){-.-.}-{2:2}:
>> [ 1917.361479]        _raw_spin_lock_irqsave+0x3d/0x50
>> [ 1917.361484]        bfq_exit_icq_bfqq+0x48/0x3f0
>> [ 1917.361489]        bfq_exit_icq+0x13/0x20
>> [ 1917.361494]        put_io_context_active+0x55/0x80
>> [ 1917.361499]        do_exit+0x72c/0xca0
>> [ 1917.361504]        do_group_exit+0x47/0xb0
>> [ 1917.361508]        __x64_sys_exit_group+0x14/0x20
>> [ 1917.361513]        do_syscall_64+0x33/0x40
>> [ 1917.361518]        entry_SYSCALL_64_after_hwframe+0x44/0xa9
>> [ 1917.361523]
>>               -> #0 (&ioc->lock){..-.}-{2:2}:
>> [ 1917.361532]        __lock_acquire+0x149d/0x1a70
>> [ 1917.361537]        lock_acquire+0x1a7/0x3b0
>> [ 1917.361542]        _raw_spin_lock_irqsave+0x3d/0x50
>> [ 1917.361547]        put_io_context+0x30/0x90
>> [ 1917.361552]        blk_mq_free_request+0x4f/0x140
>> [ 1917.361557]        blk_attempt_req_merge+0x19/0x30
>> [ 1917.361563]        elv_attempt_insert_merge+0x4f/0x90
>> [ 1917.361568]        blk_mq_sched_try_insert_merge+0x28/0x40
>> [ 1917.361574]        bfq_insert_requests+0x94/0x680
>> [ 1917.361579]        blk_mq_sched_insert_requests+0xd1/0x2a0
>> [ 1917.361584]        blk_mq_flush_plug_list+0x12d/0x240
>> [ 1917.361589]        blk_flush_plug_list+0xb4/0xd0
>> [ 1917.361594]        io_schedule_prepare+0x3c/0x40
>> [ 1917.361599]        io_schedule+0xb/0x40
>> [ 1917.361604]        blk_mq_get_tag+0x13a/0x250
>> [ 1917.361608]        __blk_mq_alloc_request+0x5c/0x130
>> [ 1917.361613]        blk_mq_submit_bio+0xf3/0x770
>> [ 1917.361618]        submit_bio_noacct+0x41e/0x4b0
>> [ 1917.361622]        submit_bio+0x33/0x160
>> [ 1917.361644]        ext4_io_submit+0x49/0x60 [ext4]
>> [ 1917.361661]        ext4_writepages+0x683/0x1070 [ext4]
>> [ 1917.361667]        do_writepages+0x3c/0xe0
>> [ 1917.361672]        __writeback_single_inode+0x62/0x630
>> [ 1917.361677]        writeback_sb_inodes+0x218/0x4d0
>> [ 1917.361681]        __writeback_inodes_wb+0x5f/0xc0
>> [ 1917.361686]        wb_writeback+0x283/0x490
>> [ 1917.361691]        wb_workfn+0x29a/0x670
>> [ 1917.361696]        process_one_work+0x283/0x620
>> [ 1917.361701]        worker_thread+0x39/0x3f0
>> [ 1917.361706]        kthread+0x152/0x170
>> [ 1917.361711]        ret_from_fork+0x1f/0x30
>> [ 1917.361715]
>>               other info that might help us debug this:
>>
>> [ 1917.361722]  Possible unsafe locking scenario:
>>
>> [ 1917.361728]        CPU0                    CPU1
>> [ 1917.361731]        ----                    ----
>> [ 1917.361736]   lock(&bfqd->lock);
>> [ 1917.361740]                                lock(&ioc->lock);
>> [ 1917.361746]                                lock(&bfqd->lock);
>> [ 1917.361752]   lock(&ioc->lock);
>> [ 1917.361757]
>>                *** DEADLOCK ***
>>
>> [ 1917.361763] 5 locks held by kworker/u16:35/15995:
>> [ 1917.361767]  #0: ffff892240c9bd38 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work+0x1fa/0x620
>> [ 1917.361778]  #1: ffff94569342fe78 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work+0x1fa/0x620
>> [ 1917.361789]  #2: ffff8921424ae0e0 (&type->s_umount_key#39){++++}-{3:3}, at: trylock_super+0x16/0x50
>> [ 1917.361800]  #3: ffff8921424aaa40 (&sbi->s_writepages_rwsem){.+.+}-{0:0}, at: do_writepages+0x3c/0xe0
>> [ 1917.361811]  #4: ffff892244d2cc08 (&bfqd->lock){-.-.}-{2:2}, at: bfq_insert_requests+0x89/0x680
>> [ 1917.361821]
>>               stack backtrace:
>> [ 1917.361827] CPU: 6 PID: 15995 Comm: kworker/u16:35 Kdump: loaded Tainted: G S          E     5.9.0.g7cf726a-master #2
>> [ 1917.361833] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/23/2013
>> [ 1917.361840] Workqueue: writeback wb_workfn (flush-8:32)
>> [ 1917.361846] Call Trace:
>> [ 1917.361854]  dump_stack+0x77/0x97
>> [ 1917.361860]  check_noncircular+0xe7/0x100
>> [ 1917.361866]  ? __lock_acquire+0x2ce/0x1a70
>> [ 1917.361872]  ? __lock_acquire+0x149d/0x1a70
>> [ 1917.361877]  __lock_acquire+0x149d/0x1a70
>> [ 1917.361884]  lock_acquire+0x1a7/0x3b0
>> [ 1917.361889]  ? put_io_context+0x30/0x90
>> [ 1917.361894]  ? bfq_put_queue+0xcf/0x480
>> [ 1917.361901]  _raw_spin_lock_irqsave+0x3d/0x50
>> [ 1917.361906]  ? put_io_context+0x30/0x90
>> [ 1917.361911]  put_io_context+0x30/0x90
>> [ 1917.361916]  blk_mq_free_request+0x4f/0x140
>> [ 1917.361921]  blk_attempt_req_merge+0x19/0x30
>> [ 1917.361926]  elv_attempt_insert_merge+0x4f/0x90
>> [ 1917.361932]  blk_mq_sched_try_insert_merge+0x28/0x40
>> [ 1917.361937]  bfq_insert_requests+0x94/0x680
>> [ 1917.361944]  blk_mq_sched_insert_requests+0xd1/0x2a0
>> [ 1917.361950]  blk_mq_flush_plug_list+0x12d/0x240
>> [ 1917.361956]  blk_flush_plug_list+0xb4/0xd0
>> [ 1917.361962]  io_schedule_prepare+0x3c/0x40
>> [ 1917.361967]  io_schedule+0xb/0x40
>> [ 1917.361972]  blk_mq_get_tag+0x13a/0x250
>> [ 1917.361978]  ? wait_woken+0xa0/0xa0
>> [ 1917.361984]  __blk_mq_alloc_request+0x5c/0x130
>> [ 1917.361989]  blk_mq_submit_bio+0xf3/0x770
>> [ 1917.361996]  submit_bio_noacct+0x41e/0x4b0
>> [ 1917.362002]  ? submit_bio+0x33/0x160
>> [ 1917.362007]  submit_bio+0x33/0x160
>> [ 1917.362028]  ext4_io_submit+0x49/0x60 [ext4]
>> [ 1917.362045]  ext4_writepages+0x683/0x1070 [ext4]
>> [ 1917.362056]  ? do_writepages+0x3c/0xe0
>> [ 1917.362060]  do_writepages+0x3c/0xe0
>> [ 1917.362067]  ? __writeback_single_inode+0x62/0x630
>> [ 1917.362072]  __writeback_single_inode+0x62/0x630
>> [ 1917.362078]  writeback_sb_inodes+0x218/0x4d0
>> [ 1917.362087]  __writeback_inodes_wb+0x5f/0xc0
>> [ 1917.362093]  wb_writeback+0x283/0x490
>> [ 1917.362100]  ? wb_workfn+0x29a/0x670
>> [ 1917.362104]  wb_workfn+0x29a/0x670
>> [ 1917.362112]  ? process_one_work+0x283/0x620
>> [ 1917.362117]  ? process_one_work+0x251/0x620
>> [ 1917.362121]  process_one_work+0x283/0x620
>> [ 1917.362128]  worker_thread+0x39/0x3f0
>> [ 1917.362133]  ? process_one_work+0x620/0x620
>> [ 1917.362138]  kthread+0x152/0x170
>> [ 1917.362142]  ? kthread_park+0x90/0x90
>> [ 1917.362148]  ret_from_fork+0x1f/0x30
>
> Hi,
> that's apparently hard to solve inside bfq. The the ioc of the task is
> being exited while the task is still inside the code for having an I/O
> request served. Is still normal?

(please don't top post...)

First of all, never assume you have to work around what appears to be
core issues in BFQ. That doesn't mean the problem is unsolvable, just
that it might need solving outside of BFQ.

For this particular one, not sure how we could solve it in the core,
though. BFQ's normal locking dependency is bfqd -> ioc, but for exiting
ioc, it's naturally the other way around.

Below is a bit of a hack for this - use trylock, and if we fail, then
just punt it to an async helper instead. Not meant to be a final patch,
but mainly to spark inspiration on how this could be fixed.


diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 9e81d1052091..d67499d871af 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -4936,22 +4936,51 @@ static void bfq_exit_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 	bfq_release_process_ref(bfqd, bfqq);
 }
 
-static void bfq_exit_icq_bfqq(struct bfq_io_cq *bic, bool is_sync)
+static void __bfq_exit_icq_bfqq(struct bfq_io_cq *bic, struct bfq_data *bfqd,
+				struct bfq_queue *bfqq, bool is_sync)
 {
-	struct bfq_queue *bfqq = bic_to_bfqq(bic, is_sync);
-	struct bfq_data *bfqd;
+	bfqq->bic = NULL;
+	bfq_exit_bfqq(bfqd, bfqq);
+	bic_set_bfqq(bic, NULL, is_sync);
+}
 
-	if (bfqq)
-		bfqd = bfqq->bfqd; /* NULL if scheduler already exited */
+static bool bfq_exit_icq_bfqq(struct bfq_io_cq *bic, bool is_sync)
+{
+	struct bfq_queue *bfqq;
+	struct bfq_data *bfqd;
+	unsigned long flags;
 
-	if (bfqq && bfqd) {
-		unsigned long flags;
+	bfqq = bic_to_bfqq(bic, is_sync);
+	if (!bfqq || !bfqq->bfqd)
+		return true;
 
-		spin_lock_irqsave(&bfqd->lock, flags);
-		bfqq->bic = NULL;
-		bfq_exit_bfqq(bfqd, bfqq);
-		bic_set_bfqq(bic, NULL, is_sync);
+	bfqd = bfqq->bfqd;
+	if (spin_trylock_irqsave(&bfqd->lock, flags)) {
+		__bfq_exit_icq_bfqq(bic, bfqd, bfqq, is_sync);
 		spin_unlock_irqrestore(&bfqd->lock, flags);
+		return true;
+	}
+
+	return false;
+}
+
+static void bfq_exit_work(struct work_struct *work)
+{
+	struct bfq_io_cq *bic = container_of(work, struct bfq_io_cq, work);
+	bool is_sync = true;
+	int i;
+
+	for (i = 0; i < 2; i++) {
+		struct bfq_queue *bfqq = bic_to_bfqq(bic, is_sync);
+
+		if (bfqq && bfqq->bfqd) {
+			struct bfq_data *bfqd = bfqq->bfqd;
+
+			spin_lock_irq(&bfqd->lock);
+			__bfq_exit_icq_bfqq(bic, bfqd, bfqq, is_sync);
+			spin_unlock_irq(&bfqd->lock);
+		}
+		is_sync = !!is_sync;
 	}
 }
 
@@ -4959,8 +4988,11 @@ static void bfq_exit_icq(struct io_cq *icq)
 {
 	struct bfq_io_cq *bic = icq_to_bic(icq);
 
-	bfq_exit_icq_bfqq(bic, true);
-	bfq_exit_icq_bfqq(bic, false);
+	if (bfq_exit_icq_bfqq(bic, true) && bfq_exit_icq_bfqq(bic, false))
+		return;
+
+	INIT_WORK(&bic->work, bfq_exit_work);
+	schedule_work(&bic->work);
 }
 
 /*
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 703895224562..94d6827bbb65 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -435,6 +435,11 @@ struct bfq_io_cq {
 	unsigned long saved_wr_start_at_switch_to_srt;
 	unsigned int saved_wr_cur_max_time;
 	struct bfq_ttime saved_ttime;
+
+	/*
+	 * Exit work, to avoid lock dependency ordering issues
+	 */
+	struct work_struct work;
 };
 
 /**

-- 
Jens Axboe

