Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3A0B2DF11C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 19:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbgLSSwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 13:52:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbgLSSwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 13:52:36 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A36FC0617B0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Dec 2020 10:51:47 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id x16so7972565ejj.7
        for <linux-kernel@vger.kernel.org>; Sat, 19 Dec 2020 10:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UuVtne6NRlRRiqgkJFG1qI8yzmJK7lesysymWow9tUE=;
        b=ZIHZIizsWl7FWuk08wzYrWqKL/gYMOpSQwl/x8+Ax3oAncOGoSb0+gGDkaUa8Yvp5a
         vL5rqi032JLDE2X8luW21yGXkQgAN4IaHj337mHfiTKD19Fxdn0gUBsFXn5PmFEz3Ht9
         zsxrPh5nopKNbwZJylzV/gdsb8J2ubf4iQjDTwTMKeE7q0qtpSU4iCoVKxEVv/jlckf0
         TH37OhLcBRKMfviDNCJuuBKow3fz9uDaYmgUEaDLatO8hxMnIL7DFecQPiLNYVAoDDWX
         Ut0N5qudTrVFc5Fyzqz/3U9U8z7W37VXLbaT2OQwELR8Tu2ium7xfissjw1D0CdeXjps
         E5Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UuVtne6NRlRRiqgkJFG1qI8yzmJK7lesysymWow9tUE=;
        b=BuGRX+ZMRlrMHqn4lKkEXjCszSJwWQBSYnOQMs/5J4DWrKYbtby4uW+shsGoHAl3Xj
         uL0IHYRZf255ZBmq4jx6RuWcdDv6cqg07pFJSynhmXroawloBNlJJPnoTwnauR4YIQQJ
         3g+viTDZyjGg8QP1FOLW7E/kc6IDOL4fTEimVo24maA+19IEEifJqDNZ4yzweeeVcQ8f
         8E30Ja9eDl9YJj3YU5VahGeeG0v51U6y1FM0/lMvNbqKd/q9gSDsx9pQYY1vp5vCLtul
         KO5xwNCDSUxmC2OrMH+shfZhM25AIUwof9jB1QHqTn2VAkegNYI32yCzIqUycc02BCE6
         Isfg==
X-Gm-Message-State: AOAM531YSuvhBXfW0zCnqGkpXcsqGqaVAE4pTXp2omU8Cn0d7Wf9dChM
        apuUdiCWZjhX1WYPSShiidtmMMMWMRb+3vJjpA7BHQ==
X-Google-Smtp-Source: ABdhPJyklYvoyp5qYAskHotyTgQPw1Kw3ogQgcAvsnO/OPzqFxttZ/Ugp+RxJpMODkeylM7ffPKH6i8tNj9MHPX57F0=
X-Received: by 2002:a17:906:edb2:: with SMTP id sa18mr8981648ejb.264.1608403905093;
 Sat, 19 Dec 2020 10:51:45 -0800 (PST)
MIME-Version: 1.0
References: <160834570161.1791850.14911670304441510419.stgit@dwillia2-desk3.amr.corp.intel.com>
 <a51de4b3-521a-1455-1236-02d813842c8c@huawei.com>
In-Reply-To: <a51de4b3-521a-1455-1236-02d813842c8c@huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 19 Dec 2020 10:51:34 -0800
Message-ID: <CAPcyv4htMXC6CP2riTu-mnK2M71B+NPN6K3VeHX-VvA=9da9MQ@mail.gmail.com>
Subject: Re: [PATCH] device-dax: Fix range release
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Jane Chu <jane.chu@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 18, 2020 at 11:46 PM Leizhen (ThunderTown)
<thunder.leizhen@huawei.com> wrote:
>
>
>
> On 2020/12/19 10:41, Dan Williams wrote:
> > There are multiple locations that open-code the release of the last
> > range in a device-dax instance. Consolidate this into a new
> > dev_dax_trim_range() helper.
> >
> > This also addresses a kmemleak report:
> >
> > # cat /sys/kernel/debug/kmemleak
> > [..]
> > unreferenced object 0xffff976bd46f6240 (size 64):
> >    comm "ndctl", pid 23556, jiffies 4299514316 (age 5406.733s)
> >    hex dump (first 32 bytes):
> >      00 00 00 00 00 00 00 00 00 00 20 c3 37 00 00 00  .......... .7...
> >      ff ff ff 7f 38 00 00 00 00 00 00 00 00 00 00 00  ....8...........
> >    backtrace:
> >      [<00000000064003cf>] __kmalloc_track_caller+0x136/0x379
> >      [<00000000d85e3c52>] krealloc+0x67/0x92
> >      [<00000000d7d3ba8a>] __alloc_dev_dax_range+0x73/0x25c
> >      [<0000000027d58626>] devm_create_dev_dax+0x27d/0x416
> >      [<00000000434abd43>] __dax_pmem_probe+0x1c9/0x1000 [dax_pmem_core]
> >      [<0000000083726c1c>] dax_pmem_probe+0x10/0x1f [dax_pmem]
> >      [<00000000b5f2319c>] nvdimm_bus_probe+0x9d/0x340 [libnvdimm]
> >      [<00000000c055e544>] really_probe+0x230/0x48d
> >      [<000000006cabd38e>] driver_probe_device+0x122/0x13b
> >      [<0000000029c7b95a>] device_driver_attach+0x5b/0x60
> >      [<0000000053e5659b>] bind_store+0xb7/0xc3
> >      [<00000000d3bdaadc>] drv_attr_store+0x27/0x31
> >      [<00000000949069c5>] sysfs_kf_write+0x4a/0x57
> >      [<000000004a8b5adf>] kernfs_fop_write+0x150/0x1e5
> >      [<00000000bded60f0>] __vfs_write+0x1b/0x34
> >      [<00000000b92900f0>] vfs_write+0xd8/0x1d1
> >
> > Reported-by: Jane Chu <jane.chu@oracle.com>
> > Cc: Zhen Lei <thunder.leizhen@huawei.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/dax/bus.c |   44 +++++++++++++++++++++-----------------------
> >  1 file changed, 21 insertions(+), 23 deletions(-)
> >
> > diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> > index 9761cb40d4bb..720cd140209f 100644
> > --- a/drivers/dax/bus.c
> > +++ b/drivers/dax/bus.c
> > @@ -367,19 +367,28 @@ void kill_dev_dax(struct dev_dax *dev_dax)
> >  }
> >  EXPORT_SYMBOL_GPL(kill_dev_dax);
> >
> > -static void free_dev_dax_ranges(struct dev_dax *dev_dax)
> > +static void trim_dev_dax_range(struct dev_dax *dev_dax)
> >  {
> > +     int i = dev_dax->nr_range - 1;
> > +     struct range *range = &dev_dax->ranges[i].range;
> >       struct dax_region *dax_region = dev_dax->region;
> > -     int i;
> >
> >       device_lock_assert(dax_region->dev);
> > -     for (i = 0; i < dev_dax->nr_range; i++) {
> > -             struct range *range = &dev_dax->ranges[i].range;
> > -
> > -             __release_region(&dax_region->res, range->start,
> > -                             range_len(range));
> > +     dev_dbg(&dev_dax->dev, "delete range[%d]: %#llx:%#llx\n", i,
> > +             (unsigned long long)range->start,
> > +             (unsigned long long)range->end);
> > +
> > +     __release_region(&dax_region->res, range->start, range_len(range));
> > +     if (--dev_dax->nr_range == 0) {
> > +             kfree(dev_dax->ranges);
> > +             dev_dax->ranges = NULL;
> >       }
> > -     dev_dax->nr_range = 0;
> > +}
> > +
> > +static void free_dev_dax_ranges(struct dev_dax *dev_dax)
> > +{
> > +     while (dev_dax->nr_range)
> It's better to use READ_ONCE to get the value of dev_dax->nr_range,
> to prevent compiler optimization.

...only in the case where the compiler might try to turn this into an
infinite loop, but I don't think that can happen here outside of a
compiler bug. Usually READ_ONCE() is contending with SMP effects that
the compiler can't see.
