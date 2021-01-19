Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA9452FC51C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 00:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730657AbhASXuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 18:50:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729420AbhASXuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 18:50:00 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BE9C061757
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 15:49:18 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id u11so23915044ljo.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 15:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kbyjFIHKcbgsTYFdb6AP4DxeAqOmq4qZG5WkX04WIYo=;
        b=QxU+a5XW+d8HEJmA2055l4+5oSUY9kzsMdkhNQwRCaFLQwRZc2PRq1bowj0Pb3K8WL
         kNmhsOe+pryR9JzxN3X4rA30ynbkAkHmo1lkdhrv49sPK5FxJDnYCdee1Zo3zROVneZH
         YWp3X8BEDKHJB4ESLmJjDexDYrO1mBlci4OUopFjhqyXTlmxdS5C6wahAJZ2OIWe95A7
         2qd1ofc08OOcaRJgLOHpsCgoeltY1kqomUvvGFzvO0EVWyLCkgv2O7ccmJAL46MonN0Z
         JTdo2YRpZtVAOti6VNpxcV6zvyisLDNeTBvpBcTAgn4a7AB9O/XhPaKlQMQjB02SEabM
         1cyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kbyjFIHKcbgsTYFdb6AP4DxeAqOmq4qZG5WkX04WIYo=;
        b=aAawcIwiQwpTbb2ZmbYRhKUAiF+CkpIjsS+RwcKzTAoRJr5iPp8F+fUheH7moQbvV/
         Qh/9SLWbyWAVJRCiDZc0nA6FtCGzVweOxU0wG/lS8DLG80J+wcepW/WAzNJ9o6BSkmc0
         DZ5voEWeNsYkxV40zzmqRbsVxegE4Dz/TjQiBptknlPWu67nsOvgXrNrxdRqPaezBszy
         ZQwtnoubQKIAZhBPUGYjR5vHMgEW55DVrMCgvWzf1Lf1Fqv2QueXGK6unmUcdyo98MWx
         Pq8IGsqpKKmbcMcb8xL9olBO7LTDJsrbHJuz5tST1/DnF1K4mcvWQhg54JA9Emt9iOCF
         FjCA==
X-Gm-Message-State: AOAM533vHV3AUkOIJPsmhvQ9XZd8VM0+q6zgblplUFT4yv8k954u/8q7
        3Fr2+B0i6W/cKT/XPK8AVj2W2C1RRdG2chUpWfk=
X-Google-Smtp-Source: ABdhPJzlGi8kYVor35wXjbuTT7Cug7j3DUo+XUJrtyOYk9IjBvAJ41XN7zELpVClhhNpI/KVW0E5KPHCt6lwXtSDWLE=
X-Received: by 2002:a2e:8548:: with SMTP id u8mr2947108ljj.17.1611100156971;
 Tue, 19 Jan 2021 15:49:16 -0800 (PST)
MIME-Version: 1.0
References: <20210119000043.1206345-1-daeho43@gmail.com> <YAcuR5UMsj9MTtvg@google.com>
In-Reply-To: <YAcuR5UMsj9MTtvg@google.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Wed, 20 Jan 2021 08:49:05 +0900
Message-ID: <CACOAw_xB9VTWymmBKyg_x8gRzUw17zk+Ta+uvSnhiC7044TA8w@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v4 1/2] f2fs: introduce checkpoint=merge mount option
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I think you were definitely confused.

There is no change for 2/2. So I didn't send it.

Next time, I am going to send it all, even though some of them don't
have changes.

2021=EB=85=84 1=EC=9B=94 20=EC=9D=BC (=EC=88=98) =EC=98=A4=EC=A0=84 4:08, J=
aegeuk Kim <jaegeuk@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Is there v4 2/2?
>
> On 01/19, Daeho Jeong wrote:
> > From: Daeho Jeong <daehojeong@google.com>
> >
> > We've added a new mount option "checkpoint=3Dmerge", which creates a
> > kernel daemon and makes it to merge concurrent checkpoint requests as
> > much as possible to eliminate redundant checkpoint issues. Plus, we
> > can eliminate the sluggish issue caused by slow checkpoint operation
> > when the checkpoint is done in a process context in a cgroup having
> > low i/o budget and cpu shares. To make this do better, we set the
> > default i/o priority of the kernel daemon to "3", to give one higher
> > priority than other kernel threads. The below verification result
> > explains this.
> > The basic idea has come from https://opensource.samsung.com.
> >
> > [Verification]
> > Android Pixel Device(ARM64, 7GB RAM, 256GB UFS)
> > Create two I/O cgroups (fg w/ weight 100, bg w/ wight 20)
> > Set "strict_guarantees" to "1" in BFQ tunables
> >
> > In "fg" cgroup,
> > - thread A =3D> trigger 1000 checkpoint operations
> >   "for i in `seq 1 1000`; do touch test_dir1/file; fsync test_dir1;
> >    done"
> > - thread B =3D> gererating async. I/O
> >   "fio --rw=3Dwrite --numjobs=3D1 --bs=3D128k --runtime=3D3600 --time_b=
ased=3D1
> >        --filename=3Dtest_img --name=3Dtest"
> >
> > In "bg" cgroup,
> > - thread C =3D> trigger repeated checkpoint operations
> >   "echo $$ > /dev/blkio/bg/tasks; while true; do touch test_dir2/file;
> >    fsync test_dir2; done"
> >
> > We've measured thread A's execution time.
> >
> > [ w/o patch ]
> > Elapsed Time: Avg. 68 seconds
> > [ w/  patch ]
> > Elapsed Time: Avg. 48 seconds
> >
> > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
> > ---
> > v2:
> > - inlined ckpt_req_control into f2fs_sb_info and collected stastics
> >   of checkpoint merge operations
> > v3:
> > - fixed some minor errors and cleaned up f2fs_sync_fs()
> > v4:
> > - added an explanation to raise the default i/o priority of the
> >   checkpoint daemon
> > ---
> >  Documentation/filesystems/f2fs.rst |  10 ++
> >  fs/f2fs/checkpoint.c               | 177 +++++++++++++++++++++++++++++
> >  fs/f2fs/debug.c                    |  12 ++
> >  fs/f2fs/f2fs.h                     |  27 +++++
> >  fs/f2fs/super.c                    |  55 +++++++--
> >  5 files changed, 273 insertions(+), 8 deletions(-)
> >
> > diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesys=
tems/f2fs.rst
> > index dae15c96e659..9624a0be0364 100644
> > --- a/Documentation/filesystems/f2fs.rst
> > +++ b/Documentation/filesystems/f2fs.rst
> > @@ -247,6 +247,16 @@ checkpoint=3D%s[:%u[%]]     Set to "disable" to tu=
rn off checkpointing. Set to "enabl
> >                        hide up to all remaining free space. The actual =
space that
> >                        would be unusable can be viewed at /sys/fs/f2fs/=
<disk>/unusable
> >                        This space is reclaimed once checkpoint=3Denable=
.
> > +                      Here is another option "merge", which creates a =
kernel daemon
> > +                      and makes it to merge concurrent checkpoint requ=
ests as much
> > +                      as possible to eliminate redundant checkpoint is=
sues. Plus,
> > +                      we can eliminate the sluggish issue caused by sl=
ow checkpoint
> > +                      operation when the checkpoint is done in a proce=
ss context in
> > +                      a cgroup having low i/o budget and cpu shares. T=
o make this
> > +                      do better, we set the default i/o priority of th=
e kernel daemon
> > +                      to "3", to give one higher priority than other k=
ernel threads.
> > +                      This is the same way to give a I/O priority to t=
he jbd2
> > +                      journaling thread of ext4 filesystem.
> >  compress_algorithm=3D%s         Control compress algorithm, currently =
f2fs supports "lzo",
> >                        "lz4", "zstd" and "lzo-rle" algorithm.
> >  compress_log_size=3D%u  Support configuring compress cluster size, the=
 size will
> > diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> > index 897edb7c951a..ef6ad3d1957d 100644
> > --- a/fs/f2fs/checkpoint.c
> > +++ b/fs/f2fs/checkpoint.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/f2fs_fs.h>
> >  #include <linux/pagevec.h>
> >  #include <linux/swap.h>
> > +#include <linux/kthread.h>
> >
> >  #include "f2fs.h"
> >  #include "node.h"
> > @@ -20,6 +21,8 @@
> >  #include "trace.h"
> >  #include <trace/events/f2fs.h>
> >
> > +#define DEFAULT_CHECKPOINT_IOPRIO (IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, =
3))
> > +
> >  static struct kmem_cache *ino_entry_slab;
> >  struct kmem_cache *f2fs_inode_entry_slab;
> >
> > @@ -1707,3 +1710,177 @@ void f2fs_destroy_checkpoint_caches(void)
> >       kmem_cache_destroy(ino_entry_slab);
> >       kmem_cache_destroy(f2fs_inode_entry_slab);
> >  }
> > +
> > +static int __write_checkpoint_sync(struct f2fs_sb_info *sbi)
> > +{
> > +     struct cp_control cpc =3D { .reason =3D CP_SYNC, };
> > +     int err;
> > +
> > +     down_write(&sbi->gc_lock);
> > +     err =3D f2fs_write_checkpoint(sbi, &cpc);
> > +     up_write(&sbi->gc_lock);
> > +
> > +     return err;
> > +}
> > +
> > +static void __checkpoint_and_complete_reqs(struct f2fs_sb_info *sbi)
> > +{
> > +     struct ckpt_req_control *cprc =3D &sbi->cprc_info;
> > +     struct ckpt_req *req, *next;
> > +     struct llist_node *dispatch_list;
> > +     u64 sum_diff =3D 0, diff, count =3D 0;
> > +     int ret;
> > +
> > +     dispatch_list =3D llist_del_all(&cprc->issue_list);
> > +     if (!dispatch_list)
> > +             return;
> > +     dispatch_list =3D llist_reverse_order(dispatch_list);
> > +
> > +     ret =3D __write_checkpoint_sync(sbi);
> > +     atomic_inc(&cprc->issued_ckpt);
> > +
> > +     llist_for_each_entry_safe(req, next, dispatch_list, llnode) {
> > +             diff =3D (u64)ktime_ms_delta(ktime_get(), req->queue_time=
);
> > +             req->ret =3D ret;
> > +             complete(&req->wait);
> > +
> > +             sum_diff +=3D diff;
> > +             count++;
> > +     }
> > +     atomic_sub(count, &cprc->queued_ckpt);
> > +     atomic_add(count, &cprc->total_ckpt);
> > +
> > +     spin_lock(&cprc->stat_lock);
> > +     cprc->cur_time =3D (unsigned int)div64_u64(sum_diff, count);
> > +     if (cprc->peak_time < cprc->cur_time)
> > +             cprc->peak_time =3D cprc->cur_time;
> > +     spin_unlock(&cprc->stat_lock);
> > +}
> > +
> > +static int issue_checkpoint_thread(void *data)
> > +{
> > +     struct f2fs_sb_info *sbi =3D data;
> > +     struct ckpt_req_control *cprc =3D &sbi->cprc_info;
> > +     wait_queue_head_t *q =3D &cprc->ckpt_wait_queue;
> > +repeat:
> > +     if (kthread_should_stop())
> > +             return 0;
> > +
> > +     sb_start_intwrite(sbi->sb);
> > +
> > +     if (!llist_empty(&cprc->issue_list))
> > +             __checkpoint_and_complete_reqs(sbi);
> > +
> > +     sb_end_intwrite(sbi->sb);
> > +
> > +     wait_event_interruptible(*q,
> > +             kthread_should_stop() || !llist_empty(&cprc->issue_list))=
;
> > +     goto repeat;
> > +}
> > +
> > +static void flush_remained_ckpt_reqs(struct f2fs_sb_info *sbi,
> > +             struct ckpt_req *wait_req)
> > +{
> > +     struct ckpt_req_control *cprc =3D &sbi->cprc_info;
> > +
> > +     if (!llist_empty(&cprc->issue_list)) {
> > +             __checkpoint_and_complete_reqs(sbi);
> > +     } else {
> > +             /* already dispatched by issue_checkpoint_thread */
> > +             if (wait_req)
> > +                     wait_for_completion(&wait_req->wait);
> > +     }
> > +}
> > +
> > +static void init_ckpt_req(struct ckpt_req *req)
> > +{
> > +     memset(req, 0, sizeof(struct ckpt_req));
> > +
> > +     init_completion(&req->wait);
> > +     req->queue_time =3D ktime_get();
> > +}
> > +
> > +int f2fs_issue_checkpoint(struct f2fs_sb_info *sbi)
> > +{
> > +     struct ckpt_req_control *cprc =3D &sbi->cprc_info;
> > +     struct ckpt_req req;
> > +     struct cp_control cpc;
> > +
> > +     cpc.reason =3D __get_cp_reason(sbi);
> > +     if (!test_opt(sbi, MERGE_CHECKPOINT) || cpc.reason !=3D CP_SYNC) =
{
> > +             int ret;
> > +
> > +             down_write(&sbi->gc_lock);
> > +             ret =3D f2fs_write_checkpoint(sbi, &cpc);
> > +             up_write(&sbi->gc_lock);
> > +
> > +             return ret;
> > +     }
> > +
> > +     if (!cprc->f2fs_issue_ckpt)
> > +             return __write_checkpoint_sync(sbi);
> > +
> > +     init_ckpt_req(&req);
> > +
> > +     llist_add(&req.llnode, &cprc->issue_list);
> > +     atomic_inc(&cprc->queued_ckpt);
> > +
> > +     /* update issue_list before we wake up issue_checkpoint thread */
> > +     smp_mb();
> > +
> > +     if (waitqueue_active(&cprc->ckpt_wait_queue))
> > +             wake_up(&cprc->ckpt_wait_queue);
> > +
> > +     if (cprc->f2fs_issue_ckpt)
> > +             wait_for_completion(&req.wait);
> > +     else
> > +             flush_remained_ckpt_reqs(sbi, &req);
> > +
> > +     return req.ret;
> > +}
> > +
> > +int f2fs_start_ckpt_thread(struct f2fs_sb_info *sbi)
> > +{
> > +     dev_t dev =3D sbi->sb->s_bdev->bd_dev;
> > +     struct ckpt_req_control *cprc =3D &sbi->cprc_info;
> > +
> > +     if (cprc->f2fs_issue_ckpt)
> > +             return 0;
> > +
> > +     cprc->f2fs_issue_ckpt =3D kthread_run(issue_checkpoint_thread, sb=
i,
> > +                     "f2fs_ckpt-%u:%u", MAJOR(dev), MINOR(dev));
> > +     if (IS_ERR(cprc->f2fs_issue_ckpt)) {
> > +             cprc->f2fs_issue_ckpt =3D NULL;
> > +             return PTR_ERR(cprc->f2fs_issue_ckpt);
> > +     }
> > +
> > +     set_task_ioprio(cprc->f2fs_issue_ckpt, DEFAULT_CHECKPOINT_IOPRIO)=
;
> > +
> > +     return 0;
> > +}
> > +
> > +void f2fs_stop_ckpt_thread(struct f2fs_sb_info *sbi)
> > +{
> > +     struct ckpt_req_control *cprc =3D &sbi->cprc_info;
> > +
> > +     if (cprc->f2fs_issue_ckpt) {
> > +             struct task_struct *ckpt_task =3D cprc->f2fs_issue_ckpt;
> > +
> > +             cprc->f2fs_issue_ckpt =3D NULL;
> > +             kthread_stop(ckpt_task);
> > +
> > +             flush_remained_ckpt_reqs(sbi, NULL);
> > +     }
> > +}
> > +
> > +void f2fs_init_ckpt_req_control(struct f2fs_sb_info *sbi)
> > +{
> > +     struct ckpt_req_control *cprc =3D &sbi->cprc_info;
> > +
> > +     atomic_set(&cprc->issued_ckpt, 0);
> > +     atomic_set(&cprc->total_ckpt, 0);
> > +     atomic_set(&cprc->queued_ckpt, 0);
> > +     init_waitqueue_head(&cprc->ckpt_wait_queue);
> > +     init_llist_head(&cprc->issue_list);
> > +     spin_lock_init(&cprc->stat_lock);
> > +}
> > diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
> > index 197c914119da..91855d5721cd 100644
> > --- a/fs/f2fs/debug.c
> > +++ b/fs/f2fs/debug.c
> > @@ -120,6 +120,13 @@ static void update_general_status(struct f2fs_sb_i=
nfo *sbi)
> >                       atomic_read(&SM_I(sbi)->dcc_info->discard_cmd_cnt=
);
> >               si->undiscard_blks =3D SM_I(sbi)->dcc_info->undiscard_blk=
s;
> >       }
> > +     si->nr_issued_ckpt =3D atomic_read(&sbi->cprc_info.issued_ckpt);
> > +     si->nr_total_ckpt =3D atomic_read(&sbi->cprc_info.total_ckpt);
> > +     si->nr_queued_ckpt =3D atomic_read(&sbi->cprc_info.queued_ckpt);
> > +     spin_lock(&sbi->cprc_info.stat_lock);
> > +     si->cur_ckpt_time =3D sbi->cprc_info.cur_time;
> > +     si->peak_ckpt_time =3D sbi->cprc_info.peak_time;
> > +     spin_unlock(&sbi->cprc_info.stat_lock);
> >       si->total_count =3D (int)sbi->user_block_count / sbi->blocks_per_=
seg;
> >       si->rsvd_segs =3D reserved_segments(sbi);
> >       si->overp_segs =3D overprovision_segments(sbi);
> > @@ -417,6 +424,11 @@ static int stat_show(struct seq_file *s, void *v)
> >                               si->meta_count[META_NAT]);
> >               seq_printf(s, "  - ssa blocks : %u\n",
> >                               si->meta_count[META_SSA]);
> > +             seq_printf(s, "CP merge (Queued: %4d, Issued: %4d, Total:=
 %4d, "
> > +                             "Cur time: %4d(ms), Peak time: %4d(ms))\n=
",
> > +                             si->nr_queued_ckpt, si->nr_issued_ckpt,
> > +                             si->nr_total_ckpt, si->cur_ckpt_time,
> > +                             si->peak_ckpt_time);
> >               seq_printf(s, "GC calls: %d (BG: %d)\n",
> >                          si->call_count, si->bg_gc);
> >               seq_printf(s, "  - data segments : %d (%d)\n",
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index bb11759191dc..f2ae075aa723 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -97,6 +97,7 @@ extern const char *f2fs_fault_name[FAULT_MAX];
> >  #define F2FS_MOUNT_DISABLE_CHECKPOINT        0x02000000
> >  #define F2FS_MOUNT_NORECOVERY                0x04000000
> >  #define F2FS_MOUNT_ATGC                      0x08000000
> > +#define F2FS_MOUNT_MERGE_CHECKPOINT  0x10000000
> >
> >  #define F2FS_OPTION(sbi)     ((sbi)->mount_opt)
> >  #define clear_opt(sbi, option)       (F2FS_OPTION(sbi).opt &=3D ~F2FS_=
MOUNT_##option)
> > @@ -266,6 +267,25 @@ struct fsync_node_entry {
> >       unsigned int seq_id;    /* sequence id */
> >  };
> >
> > +struct ckpt_req {
> > +     struct completion wait;         /* completion for checkpoint done=
 */
> > +     struct llist_node llnode;       /* llist_node to be linked in wai=
t queue */
> > +     int ret;                        /* return code of checkpoint */
> > +     ktime_t queue_time;             /* request queued time */
> > +};
> > +
> > +struct ckpt_req_control {
> > +     struct task_struct *f2fs_issue_ckpt;    /* checkpoint task */
> > +     wait_queue_head_t ckpt_wait_queue;      /* waiting queue for wake=
-up */
> > +     atomic_t issued_ckpt;           /* # of actually issued ckpts */
> > +     atomic_t total_ckpt;            /* # of total ckpts */
> > +     atomic_t queued_ckpt;           /* # of queued ckpts */
> > +     struct llist_head issue_list;   /* list for command issue */
> > +     spinlock_t stat_lock;           /* lock for below checkpoint time=
 stats */
> > +     unsigned int cur_time;          /* cur wait time in msec for curr=
ently issued checkpoint */
> > +     unsigned int peak_time;         /* peak wait time in msec until n=
ow */
> > +};
> > +
> >  /* for the bitmap indicate blocks to be discarded */
> >  struct discard_entry {
> >       struct list_head list;  /* list head */
> > @@ -1404,6 +1424,7 @@ struct f2fs_sb_info {
> >       wait_queue_head_t cp_wait;
> >       unsigned long last_time[MAX_TIME];      /* to store time in jiffi=
es */
> >       long interval_time[MAX_TIME];           /* to store thresholds */
> > +     struct ckpt_req_control cprc_info;      /* for checkpoint request=
 control */
> >
> >       struct inode_management im[MAX_INO_ENTRY];      /* manage inode c=
ache */
> >
> > @@ -3418,6 +3439,10 @@ int f2fs_write_checkpoint(struct f2fs_sb_info *s=
bi, struct cp_control *cpc);
> >  void f2fs_init_ino_entry_info(struct f2fs_sb_info *sbi);
> >  int __init f2fs_create_checkpoint_caches(void);
> >  void f2fs_destroy_checkpoint_caches(void);
> > +int f2fs_issue_checkpoint(struct f2fs_sb_info *sbi);
> > +int f2fs_start_ckpt_thread(struct f2fs_sb_info *sbi);
> > +void f2fs_stop_ckpt_thread(struct f2fs_sb_info *sbi);
> > +void f2fs_init_ckpt_req_control(struct f2fs_sb_info *sbi);
> >
> >  /*
> >   * data.c
> > @@ -3530,6 +3555,8 @@ struct f2fs_stat_info {
> >       int nr_discarding, nr_discarded;
> >       int nr_discard_cmd;
> >       unsigned int undiscard_blks;
> > +     int nr_issued_ckpt, nr_total_ckpt, nr_queued_ckpt;
> > +     unsigned int cur_ckpt_time, peak_ckpt_time;
> >       int inline_xattr, inline_inode, inline_dir, append, update, orpha=
ns;
> >       int compr_inode;
> >       unsigned long long compr_blocks;
> > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > index b4a07fe62d1a..4bf5e889f2f8 100644
> > --- a/fs/f2fs/super.c
> > +++ b/fs/f2fs/super.c
> > @@ -143,6 +143,7 @@ enum {
> >       Opt_checkpoint_disable_cap,
> >       Opt_checkpoint_disable_cap_perc,
> >       Opt_checkpoint_enable,
> > +     Opt_checkpoint_merge,
> >       Opt_compress_algorithm,
> >       Opt_compress_log_size,
> >       Opt_compress_extension,
> > @@ -213,6 +214,7 @@ static match_table_t f2fs_tokens =3D {
> >       {Opt_checkpoint_disable_cap, "checkpoint=3Ddisable:%u"},
> >       {Opt_checkpoint_disable_cap_perc, "checkpoint=3Ddisable:%u%%"},
> >       {Opt_checkpoint_enable, "checkpoint=3Denable"},
> > +     {Opt_checkpoint_merge, "checkpoint=3Dmerge"},
> >       {Opt_compress_algorithm, "compress_algorithm=3D%s"},
> >       {Opt_compress_log_size, "compress_log_size=3D%u"},
> >       {Opt_compress_extension, "compress_extension=3D%s"},
> > @@ -872,6 +874,9 @@ static int parse_options(struct super_block *sb, ch=
ar *options, bool is_remount)
> >               case Opt_checkpoint_enable:
> >                       clear_opt(sbi, DISABLE_CHECKPOINT);
> >                       break;
> > +             case Opt_checkpoint_merge:
> > +                     set_opt(sbi, MERGE_CHECKPOINT);
> > +                     break;
> >  #ifdef CONFIG_F2FS_FS_COMPRESSION
> >               case Opt_compress_algorithm:
> >                       if (!f2fs_sb_has_compression(sbi)) {
> > @@ -1040,6 +1045,12 @@ static int parse_options(struct super_block *sb,=
 char *options, bool is_remount)
> >               return -EINVAL;
> >       }
> >
> > +     if (test_opt(sbi, DISABLE_CHECKPOINT) &&
> > +                     test_opt(sbi, MERGE_CHECKPOINT)) {
> > +             f2fs_err(sbi, "checkpoint=3Dmerge cannot be used with che=
ckpoint=3Ddisable\n");
> > +             return -EINVAL;
> > +     }
> > +
> >       /* Not pass down write hints if the number of active logs is less=
er
> >        * than NR_CURSEG_PERSIST_TYPE.
> >        */
> > @@ -1245,6 +1256,12 @@ static void f2fs_put_super(struct super_block *s=
b)
> >       /* prevent remaining shrinker jobs */
> >       mutex_lock(&sbi->umount_mutex);
> >
> > +     /*
> > +      * flush all issued checkpoints and stop checkpoint issue thread.
> > +      * after then, all checkpoints should be done by each process con=
text.
> > +      */
> > +     f2fs_stop_ckpt_thread(sbi);
> > +
> >       /*
> >        * We don't need to do checkpoint when superblock is clean.
> >        * But, the previous checkpoint was not done by umount, it needs =
to do
> > @@ -1343,15 +1360,9 @@ int f2fs_sync_fs(struct super_block *sb, int syn=
c)
> >       if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
> >               return -EAGAIN;
> >
> > -     if (sync) {
> > -             struct cp_control cpc;
> > -
> > -             cpc.reason =3D __get_cp_reason(sbi);
> > +     if (sync)
> > +             err =3D f2fs_issue_checkpoint(sbi);
> >
> > -             down_write(&sbi->gc_lock);
> > -             err =3D f2fs_write_checkpoint(sbi, &cpc);
> > -             up_write(&sbi->gc_lock);
> > -     }
> >       f2fs_trace_ios(NULL, 1);
> >
> >       return err;
> > @@ -1674,6 +1685,8 @@ static int f2fs_show_options(struct seq_file *seq=
, struct dentry *root)
> >       if (test_opt(sbi, DISABLE_CHECKPOINT))
> >               seq_printf(seq, ",checkpoint=3Ddisable:%u",
> >                               F2FS_OPTION(sbi).unusable_cap);
> > +     if (test_opt(sbi, MERGE_CHECKPOINT))
> > +             seq_puts(seq, ",checkpoint=3Dmerge");
> >       if (F2FS_OPTION(sbi).fsync_mode =3D=3D FSYNC_MODE_POSIX)
> >               seq_printf(seq, ",fsync_mode=3D%s", "posix");
> >       else if (F2FS_OPTION(sbi).fsync_mode =3D=3D FSYNC_MODE_STRICT)
> > @@ -1954,6 +1967,18 @@ static int f2fs_remount(struct super_block *sb, =
int *flags, char *data)
> >               }
> >       }
> >
> > +     if (!test_opt(sbi, MERGE_CHECKPOINT)) {
> > +             f2fs_stop_ckpt_thread(sbi);
> > +     } else {
> > +             err =3D f2fs_start_ckpt_thread(sbi);
> > +             if (err) {
> > +                     f2fs_err(sbi,
> > +                         "Failed to start F2FS issue_checkpoint_thread=
 (%d)",
> > +                         err);
> > +                     goto restore_gc;
> > +             }
> > +     }
> > +
> >       /*
> >        * We stop issue flush thread if FS is mounted as RO
> >        * or if flush_merge is not passed in mount option.
> > @@ -3701,6 +3726,18 @@ static int f2fs_fill_super(struct super_block *s=
b, void *data, int silent)
> >
> >       f2fs_init_fsync_node_info(sbi);
> >
> > +     /* setup checkpoint request control and start checkpoint issue th=
read */
> > +     f2fs_init_ckpt_req_control(sbi);
> > +     if (test_opt(sbi, MERGE_CHECKPOINT)) {
> > +             err =3D f2fs_start_ckpt_thread(sbi);
> > +             if (err) {
> > +                     f2fs_err(sbi,
> > +                         "Failed to start F2FS issue_checkpoint_thread=
 (%d)",
> > +                         err);
> > +                     goto stop_ckpt_thread;
> > +             }
> > +     }
> > +
> >       /* setup f2fs internal modules */
> >       err =3D f2fs_build_segment_manager(sbi);
> >       if (err) {
> > @@ -3910,6 +3947,8 @@ static int f2fs_fill_super(struct super_block *sb=
, void *data, int silent)
> >  free_sm:
> >       f2fs_destroy_segment_manager(sbi);
> >       f2fs_destroy_post_read_wq(sbi);
> > +stop_ckpt_thread:
> > +     f2fs_stop_ckpt_thread(sbi);
> >  free_devices:
> >       destroy_device_list(sbi);
> >       kvfree(sbi->ckpt);
> > --
> > 2.30.0.296.g2bfb1c46d8-goog
> >
> >
> >
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
