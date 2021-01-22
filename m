Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD9DF3003F2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 14:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbhAVNRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 08:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbhAVNRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 08:17:05 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4542C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 05:16:24 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id f2so1255586ljp.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 05:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1v2FAdAIM+FduQLY9fgZwr7tF6/Isi2KlND7ig2PLqM=;
        b=w65sROKBqsor9zfqRpfltZ34/wM853Cw2NXBuRcrS5fYxv/d2nceN68WoCJYvFVGoh
         krEbKtoXibVHrjj1toHnXg9oBfFeOT2V8UTDDtG84gaRlJk0VPT2XhXzHi9HKL9/Byn3
         zTOV+lhC4xDAgmZQZczTdURgv4OnednJAug7hzkH63lMFprGrvad1FHUV1DO3N5/Y2ut
         R1ilFeGGEuJQE251rWv1/Q1ukRwGMg1UadZSwxTDfmYucOZbuoaRajZ5K3+DU/FFOcoq
         H+UMa41hui9M/D7u6I+yXBmO/oY31aSQyWQTRSCxtj38sDe3NqP5W6HHGOTpzA0TdSsM
         xNxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1v2FAdAIM+FduQLY9fgZwr7tF6/Isi2KlND7ig2PLqM=;
        b=CiGudiPJvpHP91n936BjwxvcyQoDN7dArAscKy8pqaivkA1vL4pfx7Rq5rp2FDl/3Z
         +bwGC5gLWLfZTuG028xJ6aD7EY4Yjq+fQcNlMRluKt8FKwlBB+VDpEnmvzPSdITv9K8V
         0uRKnOCfK2aFNhGaSmIczhUJcyqBUB9NKtn5okJOicJwEIQmmUajoxhG35biqtNII2Dj
         ZS1KX9KCwDHJIUPiSXgFT5JuAVY8PYhrOyKKUenLzpE+6kVblbnSzMVzsur1miR7lnz1
         t5xDGt8O8bBeCwOWp9bPWvXSgMWYKXpn4QdmUx0B6b6a7xgW1NmXwOuKzw6LauL6LwPb
         lozA==
X-Gm-Message-State: AOAM532XUmZ9B3YiidWV0tzFvEd6QuHvdYp5k4lPcwHr7sJFsv5482P7
        Yusu6MjmJIk30ccLTuKTiIl5Wsj8WP2WQtYB7k7KxsV8twRmXQ==
X-Google-Smtp-Source: ABdhPJxjtYcNvePVfz3PyQvJmmzO6M4fKzwNdZqKua6XH8jtTIXlHJqEXPINzkevucgcTd+1sQSvY97jqlAeG8Lnsx4=
X-Received: by 2002:a2e:b6cc:: with SMTP id m12mr837848ljo.401.1611321383077;
 Fri, 22 Jan 2021 05:16:23 -0800 (PST)
MIME-Version: 1.0
References: <20201118082759.1413056-1-bharata@linux.ibm.com>
 <CAKfTPtA_JgMf_+zdFbcb_V9rM7JBWNPjAz9irgwFj7Rou=xzZg@mail.gmail.com>
 <20210121053003.GB2587010@in.ibm.com> <alpine.DEB.2.22.394.2101210959060.100764@www.lameter.com>
 <d7fb9425-9a62-c7b8-604d-5828d7e6b1da@suse.cz> <CAKfTPtDy3Ynk2nGCTWiXjz9-4vuSHB3pGuafoTUBPFNO1ac3PA@mail.gmail.com>
 <786571e7-b9a2-4cdb-06d5-aa4a4b439b7e@suse.cz>
In-Reply-To: <786571e7-b9a2-4cdb-06d5-aa4a4b439b7e@suse.cz>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 22 Jan 2021 14:16:11 +0100
Message-ID: <CAKfTPtAEFSHBR3_oK6PpH-GWhtZBV9unyBh=n5DVT36eHvo6Dg@mail.gmail.com>
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

On Fri, 22 Jan 2021 at 13:03, Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 1/22/21 9:03 AM, Vincent Guittot wrote:
> > On Thu, 21 Jan 2021 at 19:19, Vlastimil Babka <vbabka@suse.cz> wrote:
> >>
> >> On 1/21/21 11:01 AM, Christoph Lameter wrote:
> >> > On Thu, 21 Jan 2021, Bharata B Rao wrote:
> >> >
> >> >> > The problem is that calculate_order() is called a number of times
> >> >> > before secondaries CPUs are booted and it returns 1 instead of 224.
> >> >> > This makes the use of num_online_cpus() irrelevant for those cases
> >> >> >
> >> >> > After adding in my command line "slub_min_objects=36" which equals to
> >> >> > 4 * (fls(num_online_cpus()) + 1) with a correct num_online_cpus == 224
> >> >> > , the regression diseapears:
> >> >> >
> >> >> > 9 iterations of hackbench -l 16000 -g 16: 3.201sec (+/- 0.90%)
> >>
> >> I'm surprised that hackbench is that sensitive to slab performance, anyway. It's
> >> supposed to be a scheduler benchmark? What exactly is going on?
> >>
> >
> > From hackbench description:
> > Hackbench is both a benchmark and a stress test for the Linux kernel
> > scheduler. It's  main
> >        job  is  to  create a specified number of pairs of schedulable
> > entities (either threads or
> >        traditional processes) which communicate via either sockets or
> > pipes and time how long  it
> >        takes for each pair to send data back and forth.
>
> Yep, so I wonder which slab entities this is stressing that much.
>
> >> Things would be easier if we could trust *on all arches* either
> >>
> >> - num_present_cpus() to count what the hardware really physically has during
> >> boot, even if not yet onlined, at the time we init slab. This would still not
> >> handle later hotplug (probably mostly in a VM scenario, not that somebody would
> >> bring bunch of actual new cpu boards to a running bare metal system?).
> >>
> >> - num_possible_cpus()/nr_cpu_ids not to be excessive (broken BIOS?) on systems
> >> where it's not really possible to plug more CPU's. In a VM scenario we could
> >> still have an opposite problem, where theoretically "anything is possible" but
> >> the virtual cpus are never added later.
> >
> > On all the system that I have tested num_possible_cpus()/nr_cpu_ids
> > were correctly initialized
> >
> > large arm64 acpi system
> > small arm64 DT based system
> > VM on x86 system
>
> So it's just powerpc that has this issue with too large nr_cpu_ids? Is it caused
> by bios or the hypervisor? How does num_present_cpus() look there?

num_present_cpus() starts to 1 until secondary cpus boot in the arm64 case

>
> What about heuristic:
> - num_online_cpus() > 1 - we trust that and use it
> - otherwise nr_cpu_ids
> Would that work? Too arbitrary?
>
>
> >> We could also start questioning the very assumption that number of cpus should
> >> affect slab page size in the first place. Should it? After all, each CPU will
> >> have one or more slab pages privately cached, as we discuss in the other
> >> thread... So why make the slab pages also larger?
> >>
> >> > Or the num_online_cpus needs to be up to date earlier. Why does this issue
> >> > not occur on x86? Does x86 have an up to date num_online_cpus earlier?
> >> >
> >> >
> >>
> >
>
