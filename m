Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D29652FFDD9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 09:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbhAVIEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 03:04:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbhAVIEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 03:04:30 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8572CC0613D6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 00:03:39 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id o13so6332352lfr.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 00:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4ekB2r4XI7F6IjNfkYPWwLdcwzJaJYtXqKRX3CXrIFc=;
        b=msKCzptkpliqAUQNglv+FxAEmT+FBmbcFa1TAi8A7yGnYd0WGDHwTPW0gxum7uImGR
         EJPcI5oBsbcLdUnySJxo/PbT6ouPs/NatUaY4LyQofnMBtyhgz4PTonG3TTbV9UKESqC
         LfDzGKeS8Zfq8WUX8QEBV1jtSX2p5UKJBQMiUwLK9eLitSvJzSqVS5KwYYoZdJwILEgc
         xa1Yh6huODhcnrjwoyopccvYJFg7mXT+UldmwldBVmEp2JNtop1KPAhpyGmSxZxeVu0n
         I1BpG54+oJLYPmK45s+ewvJE3cvb+Yds1EbkoCcvJHuPyF4S9tpvTd9r009NmkWqevP6
         QXWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4ekB2r4XI7F6IjNfkYPWwLdcwzJaJYtXqKRX3CXrIFc=;
        b=gAYVO0FnMqPag6SBKUYAj5QbfHmBILHHIH3wnZM4ne26IpuG6j0f6+kflr0hSrItrz
         /jjv/l05AM+6J4OSrnzjnAamgTgJyC0NOk/PfBlHq326Zk8KMLTVNYeLhkqFIds3i2qM
         Vbvx6rhcxCQiUo7SHFrRmmbTvzp09I0stZwXh86L4nKALVQ0sAZUdm2YtOsKEl4H2E4/
         tHcqd0Z1mNffU+55siIjgzaTmokunK7V6khMfOOoDoN5uG3VdCPNIz/muaXRRxlHGE52
         4FAzEbAtyOd50Ita1XSu+gDydHSgIa4SJLs76dpiBoVQsehBzk0ezOStLynMbDGT8N9l
         B58g==
X-Gm-Message-State: AOAM5310kSCmNnGrBsAwUVnPhmSNKtVQ6Py2VF6fOke6sImXIUhfm5GK
        ANYjCqttyu4coHbKeWKMYlFdop9Lp0DiJJ/4bN+ArQ==
X-Google-Smtp-Source: ABdhPJy1fa8Cp2v2km0uUyHu5rkh42Fpk4e+LXdlQ9AE10uJ56hrIP4W0bXjoDvSopn0+E/yHVIS2HhC7Podz7eyNWM=
X-Received: by 2002:a19:810:: with SMTP id 16mr1683935lfi.233.1611302617988;
 Fri, 22 Jan 2021 00:03:37 -0800 (PST)
MIME-Version: 1.0
References: <20201118082759.1413056-1-bharata@linux.ibm.com>
 <CAKfTPtA_JgMf_+zdFbcb_V9rM7JBWNPjAz9irgwFj7Rou=xzZg@mail.gmail.com>
 <20210121053003.GB2587010@in.ibm.com> <alpine.DEB.2.22.394.2101210959060.100764@www.lameter.com>
 <d7fb9425-9a62-c7b8-604d-5828d7e6b1da@suse.cz>
In-Reply-To: <d7fb9425-9a62-c7b8-604d-5828d7e6b1da@suse.cz>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 22 Jan 2021 09:03:26 +0100
Message-ID: <CAKfTPtDy3Ynk2nGCTWiXjz9-4vuSHB3pGuafoTUBPFNO1ac3PA@mail.gmail.com>
Subject: Re: [RFC PATCH v0] mm/slub: Let number of online CPUs determine the
 slub page order
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Christoph Lameter <cl@linux.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, guro@fb.com,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        aneesh.kumar@linux.ibm.com, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jan 2021 at 19:19, Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 1/21/21 11:01 AM, Christoph Lameter wrote:
> > On Thu, 21 Jan 2021, Bharata B Rao wrote:
> >
> >> > The problem is that calculate_order() is called a number of times
> >> > before secondaries CPUs are booted and it returns 1 instead of 224.
> >> > This makes the use of num_online_cpus() irrelevant for those cases
> >> >
> >> > After adding in my command line "slub_min_objects=36" which equals to
> >> > 4 * (fls(num_online_cpus()) + 1) with a correct num_online_cpus == 224
> >> > , the regression diseapears:
> >> >
> >> > 9 iterations of hackbench -l 16000 -g 16: 3.201sec (+/- 0.90%)
>
> I'm surprised that hackbench is that sensitive to slab performance, anyway. It's
> supposed to be a scheduler benchmark? What exactly is going on?
>

From hackbench description:
Hackbench is both a benchmark and a stress test for the Linux kernel
scheduler. It's  main
       job  is  to  create a specified number of pairs of schedulable
entities (either threads or
       traditional processes) which communicate via either sockets or
pipes and time how long  it
       takes for each pair to send data back and forth.

> >> Should we have switched to num_present_cpus() rather than
> >> num_online_cpus()? If so, the below patch should address the
> >> above problem.
> >
> > There is certainly an initcall after secondaries are booted where we could
> > redo the calculate_order?
>
> We could do it even in hotplug handler. But in practice that means making sure
> it's safe, i.e. all users of oo_order/oo_objects must handle the value changing.
>
> Consider e.g. init_cache_random_seq() which uses oo_objects(s->oo) to allocate
> s->random_seq when cache s is created. Then shuffle_freelist() will use the
> current value of oo_objects(s->oo) to index s->random_seq, for a newly allocated
> slab - what if the page order has increased meanwhile due to secondary booting
> or hotplug? Array overflow. That's why I just made the former sysfs handler for
> changing order read-only.
>
> Things would be easier if we could trust *on all arches* either
>
> - num_present_cpus() to count what the hardware really physically has during
> boot, even if not yet onlined, at the time we init slab. This would still not
> handle later hotplug (probably mostly in a VM scenario, not that somebody would
> bring bunch of actual new cpu boards to a running bare metal system?).
>
> - num_possible_cpus()/nr_cpu_ids not to be excessive (broken BIOS?) on systems
> where it's not really possible to plug more CPU's. In a VM scenario we could
> still have an opposite problem, where theoretically "anything is possible" but
> the virtual cpus are never added later.

On all the system that I have tested num_possible_cpus()/nr_cpu_ids
were correctly initialized

large arm64 acpi system
small arm64 DT based system
VM on x86 system

>
> We could also start questioning the very assumption that number of cpus should
> affect slab page size in the first place. Should it? After all, each CPU will
> have one or more slab pages privately cached, as we discuss in the other
> thread... So why make the slab pages also larger?
>
> > Or the num_online_cpus needs to be up to date earlier. Why does this issue
> > not occur on x86? Does x86 have an up to date num_online_cpus earlier?
> >
> >
>
