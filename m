Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F279628142B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 15:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387909AbgJBNiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 09:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbgJBNiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 09:38:08 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB26C0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 06:38:06 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id o5so1854466wrn.13
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 06:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YJFzi1imHWgaNxc/w+Kbvg3nRk1FgdMd7PjWOqbxCvc=;
        b=Ba4Q6eJ1JvgRRNOSq8LlcMqD7L+ig3PtzfYsSGKaQy8LIqTZ3xYwILj+q452kXQSmC
         xWhWNVNPPdMHUOGToueLk8sru7LmeOlsAN/HGm5iI1LUyqNzVRDlggebqhM9C5Le3j5z
         BqXGwNS1o3+aYKT1NaX+rK1RpNa+BgzLxscp7VcJA4cFA/lPpqd2A5FD/609gqc8AFLX
         V5aGmqwJSpKeF7dqdMjqm63eZTQZCd20Rh1mQtMU2Xw/bDCmR6eo0NRC8m60fJi9VxXD
         wTfW5+0ExyPaAJyO1S9E+4dBRquXgrmp7MRNLE/5WrV5lZ7l5FDg3c48OHTunSsamEBq
         7gbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YJFzi1imHWgaNxc/w+Kbvg3nRk1FgdMd7PjWOqbxCvc=;
        b=ZdsK2o6CbtVshhnm+kKi5f3wzFawK31Sn3mh5v4TuZVohF5wSXi0IxzN/t6bOC2F/I
         YAIDvVCYq8UJX8Dqa0Dmb/7CbvKwqcn0ruFa1XV0aK14fUp1R+tmCMXd3cx2q4ss2stB
         1Iy0fugpeGSCpxsc9W0Ek5amPQIb30Th4QrqJHOaL9TrId3GZHYGB2LPsRVYtbyrOUSx
         u6uhWRKyfIevXtUB5ApmZFsX5tsSVq9di4l1dq5vsa2G3CBVLmCdDnce84CoT3k0lrpK
         t45gepv1jtEfWCqLVKVU/dQ/5JsFdC9nHsCIA4TfzUp4tXLhswy07eAHj/GwIsbK4fgZ
         vR6Q==
X-Gm-Message-State: AOAM5325lJ6gwYbKPd/88rh6wtMrsAljnkS1gZ9FK5VV18n1TRZXBUB3
        9e5ZYr4v49Dj18D0mO+VjTT48A==
X-Google-Smtp-Source: ABdhPJyt0UeyiyNMCO010vul311QiXH8k0VELrwneA8coU2xF0rSI+hbP8k7mZi6R1I15xWlANMEJA==
X-Received: by 2002:a5d:6547:: with SMTP id z7mr3175355wrv.322.1601645884963;
        Fri, 02 Oct 2020 06:38:04 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:7220:84ff:fe09:7d5c])
        by smtp.gmail.com with ESMTPSA id m11sm1891978wmf.10.2020.10.02.06.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 06:38:04 -0700 (PDT)
Date:   Fri, 2 Oct 2020 14:38:02 +0100
From:   Alessio Balsini <balsini@android.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Alessio Balsini <balsini@android.com>,
        Akilesh Kailash <akailash@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Antonio SJ Musumeci <trapexit@spawn.link>,
        David Anderson <dvander@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Stefano Duo <stefanoduo@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        kernel-team <kernel-team@android.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V9 0/4] fuse: Add support for passthrough read/write
Message-ID: <20201002133802.GA3595556@google.com>
References: <20200924131318.2654747-1-balsini@android.com>
 <CAJfpeguFZwkZh0wkPjOLpXODdp_9jELKUrwBgEhDVF4+T8FgTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpeguFZwkZh0wkPjOLpXODdp_9jELKUrwBgEhDVF4+T8FgTw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 05:33:30PM +0200, Miklos Szeredi wrote:
> On Thu, Sep 24, 2020 at 3:13 PM Alessio Balsini <balsini@android.com> wrote:
> 
> > The first benchmarks were done by running FIO (fio-3.21) with:
> > - bs=4Ki;
> > - file size: 50Gi;
> > - ioengine: sync;
> > - fsync_on_close: true.
> > The target file has been chosen large enough to avoid it to be entirely
> > loaded into the page cache.
> > Results are presented in the following table:
> >
> > +-----------+--------+-------------+--------+
> > | Bandwidth |  FUSE  |     FUSE    |  Bind  |
> > |  (KiB/s)  |        | passthrough |  mount |
> > +-----------+--------+-------------+--------+
> > | read      | 468897 |      502085 | 516830 |
> > +-----------+--------+-------------+--------+
> > | randread  |  15773 |       26632 |  21386 |
> 
> 
> Have you looked into why passthrough is faster than native?
> 
> Thanks,
> Miklos


Hi Miklos,

Thank you for bringing this to my attention, I probably missed it because
focusing on the comparison between FUSE and FUSE passthrough.

I jumped back to benchmarkings right after you sent this email.

At a first glance I though I made a stupid copy-paste mistake, but looking
at a bunch of partial results I'm collecting, I realized that the Vi550 S3
SSD I'm using has sometimes unstable performance, especially when dealing
with random offsets. I also realized that SSD performance might change
depending on previous operations.
To solve these issues, each test is now being run 10 times, and at
post-processing time I'm thinking of getting the median to remove possible
outliers.

I also noticed that the performance noise increases after a few minutes the
SSD is busy. This made me think of some kind of SSD thermal throttling I
totally overlooked.
This might be reason why passthrough is performing better than native in
the numbers you highlighted.
Unfortunately the SMART registers of my SSD always reports 33 Celsius
degrees regardless the workload, so to solve this I'm now applying a 5
minutes cooldown between each run.

This time I'm also removing fsync_on_close and reducing the file size to 25
GiB to improve caching and limit the interaction with the SSD during
writes. Still for caching reasons I am also separating the creation of the
fio target file from the actual execution of the benchmark by first running
fio with create_only=1. Before triggering fio, in the above benchmark I was
just sync-ing and dropping the pagecache, I now also drop slab objects,
including inodes and dentries:

  echo 3 > /proc/sys/vm/drop_caches

that I suspect wouldn't make any difference, but wouldn't harm as well.

Please let me know if you have any suggestion on how to improve my
benchmarks, or if you recommend tools other than fio (that I actually
really like) to make comparisons.

Thanks,
Alessio
