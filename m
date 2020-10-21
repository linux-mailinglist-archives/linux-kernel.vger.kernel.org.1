Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A15295013
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 17:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502634AbgJUPjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 11:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502625AbgJUPjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 11:39:41 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AAFEC0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 08:39:40 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id c77so2648674wmd.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 08:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=hs8nJf7xZPZcGtHExZQ/8uZwCW3qRZMhekqizyB6Wcs=;
        b=j2HEJdMXwbfykm7SUpfWt7Kz0H94yHGae9RWCWBs/5NSK85itizUymyVgu9pEdteMg
         EPfPiTWLnJJovsJ2QSNveFfGk+h6vOtZ4oQ/H+W7mX2KYS7sJ07bt6W/5+yrDmmDD7Fd
         mpnuH5LLbeROYFLbApZIzpwbFXrvqg36diF6RLozsp08ZUTHqznYR3GjgI1z69X9QU4K
         hI5im7uog1p0DlMggKzIpaVgPRkJvFKWcVh1Ck0smBV4D3rAN61HndvzpyvWLz4pKJhY
         /bywWmhtCHEteJvSBktAaQWBxo4uk3yVBXOeXIpZKHciRPIxci59HxauqvnIyIeOx3+m
         Wwdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=hs8nJf7xZPZcGtHExZQ/8uZwCW3qRZMhekqizyB6Wcs=;
        b=O/5YakUbFXFhNXlfkNENFfiqn8yZnnF0KCyJfb8YERTNhrZoa9F777LGVklcWdVti1
         kzR7s1T1QJE1TZeGnnj3jSTO86YthGt8ErSWly6CMgpPljYK5iA19PiETTHwDJfPa+Zl
         qURZDTEAQNp4lEmFphRKCrIHbgoXHQIsorGyMKOSoLAAApo1nyhun2EF7Nj4aYjt5LMF
         /j42p41K1OPhYbLZK85nX72SgD4FFugaCIc0odSrJLPIN7l9Jr87U+Y4SNsQ5woNU8Rk
         8vfNL+cjqDug881Y0H6gP1/ECV/wkHoIWTU0ZPl6icHjpc6PWiywTFjQiM0EbQDkRSeU
         BOaA==
X-Gm-Message-State: AOAM532O9wk4xEFt4o4t1O5yuOsP34x0bC5fsagpPsI2Ywsoqezv2+kB
        MdIQ4lUQxoxKKKvl/h1Ou9we9A==
X-Google-Smtp-Source: ABdhPJxx4ETVxfl6OZ8dOUDPTrrXH30LPu2WPZIfvVMjiz/3DyWzAUhl5j8X6f9kMrhP9WisAtpnqg==
X-Received: by 2002:a1c:b707:: with SMTP id h7mr4421395wmf.105.1603294779073;
        Wed, 21 Oct 2020 08:39:39 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:7220:84ff:fe09:7d5c])
        by smtp.gmail.com with ESMTPSA id u2sm4160478wme.1.2020.10.21.08.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 08:39:38 -0700 (PDT)
Date:   Wed, 21 Oct 2020 16:39:36 +0100
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
Message-ID: <20201021153936.GA24818@google.com>
References: <20200924131318.2654747-1-balsini@android.com>
 <CAJfpeguFZwkZh0wkPjOLpXODdp_9jELKUrwBgEhDVF4+T8FgTw@mail.gmail.com>
 <20201002133802.GA3595556@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201002133802.GA3595556@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miklos, all,
 
After being stuck with some strange and hard to reproduce results from my SSD,
I finally decided to overcome the biggest chunk of inconsistencies by
forgetting about the SSD and switching to a RAM block device to host my lower
file system.
Getting rid of the discrete storage device removes a huge component of
slowness, highlighting the performance difference of the software parts (and
probably goodness of CPU cache and its coherence/invalidation mechanisms).
 
More specifically, out of my system's 32 GiB of RAM, I reserved 24 for
/dev/ram0, which has been formatted as ext4.
That file system has been completely filled and then cleaned up before running
the benchmarks to make sure all the memory addresses were marked as used and
removed from the page cache.
 
As for the last time, I've been using a slightly modified libfuse
passthrough_hp.cc example, that simply enables the passthrough mode at every
open/create operation:

  git@github.com:balsini/libfuse fuse-passthrough-stable-v.3.9.4
 
The following tests were ran using fio-3.23 with the following configuration:
- bs=4Ki
- size=20Gi
- ioengine=sync
- fsync_on_close=1
- randseed=0
- create_only=0 (set to 1 during a first dry run to create the test file)

As for the tool configuration, the following benchmarks would perform a single
open operation each, focusing on just the read/write perfromance.

The file size of 20 GiB has been chosen to not completely fit the page cache.
 
As mentioned in my previous email, all the caches were dropped before running
every benchmark with
 
  echo 3 > /proc/sys/vm/drop_caches
 
All the benchmarks were run 10 times, with 1 minute cool down between each run.
 
Here the updated results for this patch set:
 
+-----------+-------------+-------------+-------------+
|           |             | FUSE        |             |
| MiB/s     | FUSE        | passthrough | native      |
+-----------+-------------+-------------+-------------+
| read      | 1341(±4.2%) | 1485(±1.1%) |  1634(±.5%) |
+-----------+-------------+-------------+-------------+
| write     |   49(±2.1%) | 1304(±2.6%) | 1363(±3.0%) |
+-----------+-------------+-------------+-------------+
| randread  |   43(±1.3%) | 643(±11.1%) |  715(±1.1%) |
+-----------+-------------+-------------+-------------+
| randwrite |  27(±39.9%) |  763(±1.1%) |  790(±1.0%) |
+-----------+-------------+-------------+-------------+
 
This table shows that FUSE, except for the sequential reads, is left behind
FUSE passthrough and native performance. The extremely good FUSE performance
for sequential reads is the result of a great read-ahead mechanism, that has
been easy to prove by showing that performance dropped after setting
read_ahead_kb to 0.
Except for FUSE randwrite and passthrough randread with respectively ~40% and
~11% standard deviations, all the other results are relatively stable.
Nevertheless, these two standard deviation exceptions are not sufficient to
invalidate the results, that are still showing clear performance benefits.
I'm also kind of happy to see that passthrough, that for each read/write
operation traverses the VFS layer twice, now maintains consistent slightly
lower performance than native.
 
I wanted to make sure the results were consistent before jumping back to your
feedback on the series.
 
Thanks,
Alessio
