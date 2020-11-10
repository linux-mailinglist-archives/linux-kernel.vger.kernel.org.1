Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA9C82ACE7C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 05:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731337AbgKJET5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 9 Nov 2020 23:19:57 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:45450 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729243AbgKJET4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 23:19:56 -0500
Received: from mail-ot1-f69.google.com ([209.85.210.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <dongdong.tao@canonical.com>)
        id 1kcL8K-0003sY-KQ
        for linux-kernel@vger.kernel.org; Tue, 10 Nov 2020 04:19:52 +0000
Received: by mail-ot1-f69.google.com with SMTP id n18so3247735otf.22
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 20:19:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3O0fsbplcNRfg6gC4UDarZpSeKDJJuwkAJ1YwLA6VKs=;
        b=gI+M73mRfHLKaHJF94Cyxv0T6G9GSa1pUTOBrsSFa0MFlD84D91slgyYcGbnbTYYtt
         g0xZsYJxBU0SDh5tDZ3JlAzmNFpSnetvhQ6SV1flPvWIUu4dAd49KPPnJobi6EX5rSg+
         7NoHknNGIZPdOUVIjr8MvHwXGnieKeQKrspcG/MohcqqGBq2AAe+oEUFXVh+uWXMUe9r
         Noil3fsOCZtb72Q8fImAwaJia2imURGkErEPHs1bOLP7NX4Um9qaWwEBEVcBKIxr+cvh
         kyvkUbBUV9fgM1lnx6blcgoz7I6Veg4UnUjX/FyNVRG+z/9w0keO1CTUXP0et13CxGrT
         P27A==
X-Gm-Message-State: AOAM532ptAowli6nlnK2IHCUPDBCTg9SCx+Zv/7vJJ0bNMa7q54axVtx
        Yy+3J2yAzLlSY73JJeBjgdSm1f+Q/vECHY2jq5cfWHqhX1B4jTj5U2k8FOFqrYMXEUX2FgjRapK
        IeTLraFUdQZoV2W7LzFtK9osqaaDZI6/4gYXFnuch3RfD+9r3tOZVgeWQyA==
X-Received: by 2002:aca:410a:: with SMTP id o10mr1749277oia.72.1604981991221;
        Mon, 09 Nov 2020 20:19:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxuf3NGoKbmc/t6gVyzCTo7ULFd5ZZ2HSAcKXFJsXno/bfnWTHgRFdRUtEQio1MPMQDFuIbqcoAD5UdVPyl/m8=
X-Received: by 2002:aca:410a:: with SMTP id o10mr1749264oia.72.1604981990923;
 Mon, 09 Nov 2020 20:19:50 -0800 (PST)
MIME-Version: 1.0
References: <20201103124235.14440-1-tdd21151186@gmail.com> <8e043313-003b-41be-cbd0-ebcc247dcba2@suse.de>
In-Reply-To: <8e043313-003b-41be-cbd0-ebcc247dcba2@suse.de>
From:   Dongdong Tao <dongdong.tao@canonical.com>
Date:   Tue, 10 Nov 2020 12:19:39 +0800
Message-ID: <CAJS8hVKNeua4iaRu7nwbdRhQVA5nbjLJSrCewLYbhJ4XBiGg5Q@mail.gmail.com>
Subject: Re: [PATCH] bcache: consider the fragmentation when update the
 writeback rate
To:     Coly Li <colyli@suse.de>
Cc:     Dongdong Tao <tdd21151186@gmail.com>,
        "open list:BCACHE (BLOCK LAYER CACHE)" <linux-bcache@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Kent Overstreet <kent.overstreet@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Sorry again for the SPAM detection]

Thank you the reply Coly!

I agree that this patch is not a final solution for fixing the
fragmentation issue, but more like a workaround to alleviate this
problem.
So, part of my intention is to look for how upstream would like to fix
this issue.

I've looked into the code of moving_gc part, as well as did some
debug/test, unfortunately, I think it's not the solution for this
issue also.
Because movnig_gc will not just move the dirty cache, but also the
clean cache, so seems the purpose of moving_gc
is trying to move the data (dirty and clean) from those relatively
empty buckets to some new buckets, so that to reclaim the original
buckets.
For this purpose, I guess moving gc was more useful at the time when
we usually don't have large nvme devices.

Let's get back to the problem I have, the problem that I'm trying to
fix is that you might have lots of buckets (Say 70 percent) that are
all being fully consumed,
while those buckets only contain very few dirty data (Say 10 percent
), since gc can't reclaim a bucket which contains any dirty data, so
the worst situation
is that the cache_availability_percent can drop under 30 percent which
will make all the write op can't perform in a writeback mode, thus
kill the performance of writes.

So, unlike the moving_gc, I only want to move dirty data around (as
you've suggested :)), but I don't think it's a good idea to change the
behavior of moving_gc.
My current idea is to implement a compaction thread that triggers the
dirty data compaction only under some certain circumstances (like when
the fragmentaion and dirty buckets are both high), and this thread can
be turned on/off based on an extra option, so that people can keep the
original behavior if they want.

This is a rough idea now, could you please let me know if the above
thought makes sense to you or any other suggestions will be
appreciated!
I also understand the hardest part is making sure the general bcache
performance and functionality still look sane,
so it might require much more time to do it and it's more likely a
feature atm.

How to reproduce and observe this issue:
This issue is very easy to repreduce by running below fio command
against a writeback mode bcache deivce:

fio --name=random-writers --filename=/dev/bcache0 --ioengine=libaio
--iodepth=4 --rw=randrw --rate_iops=95,5 --bs=4k --direct=1
--numjobs=4

Note that the key option to reproduce this issue here is
"rate_iops=95,5", so that you will have 95 percent read and only 5
percent write, this is to make sure
one bucket only contains very few dirty data.
Also, it's faster to reproduce this with a small cache device, I use
1GB cache, but it's same for bigger cache device, just a matter of
time.

We can observe this issue by monitoring bcache stats "data_dirty" and
"cache_available_percent", after the cache_available_percent dropped
to 30 percent,
we can observe the write performance is hugely degraded by below
bpftrace script:
---
#!/usr/bin/env bpftrace

#include <linux/bio.h>

kprobe:cached_dev_make_request
{
   @start[arg1] = nsecs;
}

kprobe:bio_endio /@start[arg0]/
{
 if(((struct bio *)arg0)->bi_opf & 1) {
    @write = hist(nsecs - @start[arg0]); delete(@start[arg0]);
 }
 else {
    @read = hist(nsecs - @start[arg0]); delete(@start[arg0]);
 }
}
---

To run this script：
Save above bpftrace file to bcache_io_lat.bt, then run it with chmod
+x bcache_io_lat.bt & ./bcache_io_lat.bt

By the way, we mainly hit this issue on ceph, the fio reproducer is
just an easy way to reproduce it.

Regards,
Dongdong


On Fri, Nov 6, 2020 at 12:32 AM Coly Li <colyli@suse.de> wrote:
>
> On 2020/11/3 20:42, Dongdong Tao wrote:
> > From: dongdong tao <dongdong.tao@canonical.com>
> >
> > Current way to calculate the writeback rate only considered the
> > dirty sectors, this usually works fine when the fragmentation
> > is not high, but it will give us unreasonable small rate when
> > we are under a situation that very few dirty sectors consumed
> > a lot dirty buckets. In some case, the dirty bucekts can reached
> > to CUTOFF_WRITEBACK_SYNC while the dirty data(sectors) noteven
> > reached the writeback_percent, the writeback rate will still
> > be the minimum value (4k), thus it will cause all the writes to be
> > stucked in a non-writeback mode because of the slow writeback.
> >
> > This patch will try to accelerate the writeback rate when the
> > fragmentation is high. It calculate the propotional_scaled value
> > based on below:
> > (dirty_sectors / writeback_rate_p_term_inverse) * fragment
> > As we can see, the higher fragmentation will result a larger
> > proportional_scaled value, thus cause a larger writeback rate.
> > The fragment value is calculated based on below:
> > (dirty_buckets *  bucket_size) / dirty_sectors
> > If you think about it, the value of fragment will be always
> > inside [1, bucket_size].
> >
> > This patch only considers the fragmentation when the number of
> > dirty_buckets reached to a dirty threshold(configurable by
> > writeback_fragment_percent, default is 50), so bcache will
> > remain the original behaviour before the dirty buckets reached
> > the threshold.
> >
> > Signed-off-by: dongdong tao <dongdong.tao@canonical.com>
>
> Hi Dongdong,
>
> Change the writeback rate does not effect the real throughput indeed,
> your change is just increasing the upper limit hint of the writeback
> throughput, the bottle neck is spinning drive for random I/O.
>
> A good direction should be the moving gc. If the moving gc may work
> faster, the situation you mentioned above could be relaxed a lot.
>
> I will NACK this patch unless you may have a observable and reproducible
> performance number.
>
> Thanks.
>
> Coly Li
>
>
> > ---
> >  drivers/md/bcache/bcache.h    |  1 +
> >  drivers/md/bcache/sysfs.c     |  6 ++++++
> >  drivers/md/bcache/writeback.c | 21 +++++++++++++++++++++
> >  3 files changed, 28 insertions(+)
> >
> > diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
> > index 1d57f48307e6..87632f7032b6 100644
> > --- a/drivers/md/bcache/bcache.h
> > +++ b/drivers/md/bcache/bcache.h
> > @@ -374,6 +374,7 @@ struct cached_dev {
> >       unsigned int            writeback_metadata:1;
> >       unsigned int            writeback_running:1;
> >       unsigned char           writeback_percent;
> > +     unsigned char           writeback_fragment_percent;
> >       unsigned int            writeback_delay;
> >
> >       uint64_t                writeback_rate_target;
> > diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
> > index 554e3afc9b68..69499113aef8 100644
> > --- a/drivers/md/bcache/sysfs.c
> > +++ b/drivers/md/bcache/sysfs.c
> > @@ -115,6 +115,7 @@ rw_attribute(stop_when_cache_set_failed);
> >  rw_attribute(writeback_metadata);
> >  rw_attribute(writeback_running);
> >  rw_attribute(writeback_percent);
> > +rw_attribute(writeback_fragment_percent);
> >  rw_attribute(writeback_delay);
> >  rw_attribute(writeback_rate);
> >
> > @@ -197,6 +198,7 @@ SHOW(__bch_cached_dev)
> >       var_printf(writeback_running,   "%i");
> >       var_print(writeback_delay);
> >       var_print(writeback_percent);
> > +     var_print(writeback_fragment_percent);
> >       sysfs_hprint(writeback_rate,
> >                    wb ? atomic_long_read(&dc->writeback_rate.rate) << 9 : 0);
> >       sysfs_printf(io_errors,         "%i", atomic_read(&dc->io_errors));
> > @@ -308,6 +310,9 @@ STORE(__cached_dev)
> >       sysfs_strtoul_clamp(writeback_percent, dc->writeback_percent,
> >                           0, bch_cutoff_writeback);
> >
> > +     sysfs_strtoul_clamp(writeback_fragment_percent, dc->writeback_fragment_percent,
> > +                         0, bch_cutoff_writeback_sync);
> > +
> >       if (attr == &sysfs_writeback_rate) {
> >               ssize_t ret;
> >               long int v = atomic_long_read(&dc->writeback_rate.rate);
> > @@ -498,6 +503,7 @@ static struct attribute *bch_cached_dev_files[] = {
> >       &sysfs_writeback_running,
> >       &sysfs_writeback_delay,
> >       &sysfs_writeback_percent,
> > +     &sysfs_writeback_fragment_percent,
> >       &sysfs_writeback_rate,
> >       &sysfs_writeback_rate_update_seconds,
> >       &sysfs_writeback_rate_i_term_inverse,
> > diff --git a/drivers/md/bcache/writeback.c b/drivers/md/bcache/writeback.c
> > index 3c74996978da..34babc89fdf3 100644
> > --- a/drivers/md/bcache/writeback.c
> > +++ b/drivers/md/bcache/writeback.c
> > @@ -88,6 +88,26 @@ static void __update_writeback_rate(struct cached_dev *dc)
> >       int64_t integral_scaled;
> >       uint32_t new_rate;
> >
> > +     /*
> > +      * We need to consider the number of dirty buckets as well
> > +      * when calculating the proportional_scaled, Otherwise we might
> > +      * have an unreasonable small writeback rate at a highly fragmented situation
> > +      * when very few dirty sectors consumed a lot dirty buckets, the
> > +      * worst case is when dirty_data reached writeback_percent and
> > +      * dirty buckets reached to cutoff_writeback_sync, but the rate
> > +      * still will be at the minimum value, which will cause the write
> > +      * stuck at a non-writeback mode.
> > +      */
> > +     struct cache_set *c = dc->disk.c;
> > +
> > +     if (c->gc_stats.in_use > dc->writeback_fragment_percent && dirty > 0) {
> > +             int64_t dirty_buckets = (c->gc_stats.in_use * c->nbuckets) / 100;
> > +             int64_t fragment = (dirty_buckets *  c->cache->sb.bucket_size) / dirty;
> > +
> > +             proportional_scaled =
> > +             div_s64(dirty, dc->writeback_rate_p_term_inverse) * (fragment);
> > +     }
> > +
> >       if ((error < 0 && dc->writeback_rate_integral > 0) ||
> >           (error > 0 && time_before64(local_clock(),
> >                        dc->writeback_rate.next + NSEC_PER_MSEC))) {
> > @@ -969,6 +989,7 @@ void bch_cached_dev_writeback_init(struct cached_dev *dc)
> >       dc->writeback_metadata          = true;
> >       dc->writeback_running           = false;
> >       dc->writeback_percent           = 10;
> > +     dc->writeback_fragment_percent  = 50;
> >       dc->writeback_delay             = 30;
> >       atomic_long_set(&dc->writeback_rate.rate, 1024);
> >       dc->writeback_rate_minimum      = 8;
> >
>
