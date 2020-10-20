Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD657290D98
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 00:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389981AbgJPWMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 18:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389902AbgJPWL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 18:11:59 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D36DC061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 15:11:59 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id a3so5383576ejy.11
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 15:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x/1gvPq9ABO+DLME7JqBB+oA4SLyXFjfXGkzpl3gc3c=;
        b=pcZSwZipujNJCrfM4BfqKwSqTOO1tlVYDfGgPLS5HMjSaaFti2Es6Ws8L0Vp4BR0qh
         V71HRk4m6HBbQwP316nTLWmc9NtPWjJoKiZpDvVhYVTbaYa/iDspy0qQC3pPHUUbAxEP
         zx3rQt9TI6QwN7gwLb0sg0V8vWNYZRCctVPbbEN7+CaURNJuIJN6h3o7SOdhd6XWdAop
         RRqvh6nC7BWdaTGvYZdPr7glVwHYKPJHm19PsrI3BQgLw3/cc2+Y+AP+97Z/dyQ/9T2R
         wAMzEqSRy9Wjy5kcby+9zvQUhPtHVm/pArQ2K+jUYkJk0ofEaV3TM5Zw1LOaKF/TNQie
         BoNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x/1gvPq9ABO+DLME7JqBB+oA4SLyXFjfXGkzpl3gc3c=;
        b=IyMQjkw0J+bN+aDqaorB07AkBsO/ab5MZD5kqTToyBtsKV45i+CK3CdYptHcvK2M2Q
         984oZc9wam804/G9rbRRuOtUpJGnj/uMqGGZEECXrE6LIWjEwap+pudVti5oPDxIe7RD
         ijbirAszjgVRJrMlJhFBjZi3rBtaSnKZ3y6w8m1gsD26M9N+TBnA0TeJiYx52DTNXvqq
         8qzTzeIh+sk25JRi3N3YKanq1FGRN03YUf0hxS7XyED6VW4r/dNQqG/GMV8pPSbYhiuj
         MzbeKgTyUPtMXeShzS/O/zrKX32CNHWzijJXmC56j19ErJwAUVWzrN5lgZUhN1reF/x5
         F7pw==
X-Gm-Message-State: AOAM531c2j+FDsN3JttJv3t3h7wBEHpOjPQNECJtGaLgePy5SS1ZI3NA
        rOpjneU/ArwUzjT5MdCPXYwfPdo4SBixYLcB4AR2bQ==
X-Google-Smtp-Source: ABdhPJxsSOm3B4N0u0qHPPJOfUxJ1kby8jXT5wG1X7DBdcrTYVmjnEFqodQltQhk0823yfa2RC70ioRF0pDuj3vqDrA=
X-Received: by 2002:a17:906:b88f:: with SMTP id hb15mr5934428ejb.45.1602886318070;
 Fri, 16 Oct 2020 15:11:58 -0700 (PDT)
MIME-Version: 1.0
References: <20201012162736.65241-1-nmeeramohide@micron.com>
 <20201015080254.GA31136@infradead.org> <SN6PR08MB420880574E0705BBC80EC1A3B3030@SN6PR08MB4208.namprd08.prod.outlook.com>
In-Reply-To: <SN6PR08MB420880574E0705BBC80EC1A3B3030@SN6PR08MB4208.namprd08.prod.outlook.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 16 Oct 2020 15:11:48 -0700
Message-ID: <CAPcyv4j7a0gq++rL--2W33fL4+S0asYjYkvfBfs+hY+3J=c_GA@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v2 00/22] add Object Storage Media Pool (mpool)
To:     "Nabeel Meeramohideen Mohamed (nmeeramohide)" 
        <nmeeramohide@micron.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "Steve Moyer (smoyer)" <smoyer@micron.com>,
        "Greg Becker (gbecker)" <gbecker@micron.com>,
        "Pierre Labat (plabat)" <plabat@micron.com>,
        "John Groves (jgroves)" <jgroves@micron.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 2:59 PM Nabeel Meeramohideen Mohamed
(nmeeramohide) <nmeeramohide@micron.com> wrote:
>
> On Thursday, October 15, 2020 2:03 AM, Christoph Hellwig <hch@infradead.org> wrote:
> > I don't think this belongs into the kernel.  It is a classic case for
> > infrastructure that should be built in userspace.  If anything is
> > missing to implement it in userspace with equivalent performance we
> > need to improve out interfaces, although io_uring should cover pretty
> > much everything you need.
>
> Hi Christoph,
>
> We previously considered moving the mpool object store code to user-space.
> However, by implementing mpool as a device driver, we get several benefits
> in terms of scalability, performance, and functionality. In doing so, we relied
> only on standard interfaces and did not make any changes to the kernel.
>
> (1)  mpool's "mcache map" facility allows us to memory-map (and later unmap)
> a collection of logically related objects with a single system call. The objects in
> such a collection are created at different times, physically disparate, and may
> even reside on different media class volumes.
>
> For our HSE storage engine application, there are commonly 10's to 100's of
> objects in a given mcache map, and 75,000 total objects mapped at a given time.
>
> Compared to memory-mapping objects individually, the mcache map facility
> scales well because it requires only a single system call and single vm_area_struct
> to memory-map a complete collection of objects.

Why can't that be a batch of mmap calls on io_uring?

> (2) The mcache map reaper mechanism proactively evicts object data from the page
> cache based on object-level metrics. This provides significant performance benefit
> for many workloads.
>
> For example, we ran YCSB workloads B (95/5 read/write mix)  and C (100% read)
> against our HSE storage engine using the mpool driver in a 5.9 kernel.
> For each workload, we ran with the reaper turned-on and turned-off.
>
> For workload B, the reaper increased throughput 1.77x, while reducing 99.99% tail
> latency for reads by 39% and updates by 99%. For workload C, the reaper increased
> throughput by 1.84x, while reducing the 99.99% read tail latency by 63%. These
> improvements are even more dramatic with earlier kernels.

What metrics proved useful and can the vanilla page cache / page
reclaim mechanism be augmented with those metrics?

>
> (3) The mcache map facility can memory-map objects on NVMe ZNS drives that were
> created using the Zone Append command. This patch set does not support ZNS, but
> that work is in progress and we will be demonstrating our HSE storage engine
> running on mpool with ZNS drives at FMS 2020.
>
> (4) mpool's immutable object model allows the driver to support concurrent reading
> of object data directly and memory-mapped without a performance penalty to verify
> coherence. This allows background operations, such as LSM-tree compaction, to
> operate efficiently and without polluting the page cache.
>

How is this different than existing background operations / defrag
that filesystems perform today? Where are the opportunities to improve
those operations?

> (5) Representing an mpool as a /dev/mpool/<mpool-name> device file provides a
> convenient mechanism for controlling access to and managing the multiple storage
> volumes, and in the future pmem devices, that may comprise an logical mpool.

Christoph and I have talked about replacing the pmem driver's
dependence on device-mapper for pooling. What extensions would be
needed for the existing driver arch?
