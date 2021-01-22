Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C10733003D0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 14:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbhAVNI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 08:08:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727928AbhAVNHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 08:07:08 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E90C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 05:06:15 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id m22so7424663lfg.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 05:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hdjcX1r0hcP0ziPjwGYoacie9+kzbK27+8zHrMy8Ek0=;
        b=uy7LbRH2a+1REAcuKTsefeoWzLSAk8lD9cg8t0qFzoBoRZ8P9cscIE2Ez8S826Ssbj
         oMgNkvLij+BJWNVphXcP2grz7sz5MmhvWX8s8QapQ7Zp7THp4qoDs9RX7XZJsf2PcsY4
         uW508nwG14h2e9L+j5tziHYVrWo/G3+6vzgcxNylnWYTLG5kK/XaXj1ogJam7olKIa6w
         hJh/17mcPKTgLSeAog8TjZgFNuH1x1j0SVpt2z5DnL94M6kimZfip4lMPLYWsWKr+ZtP
         OhaJjeHvl0Ka0pUYtjLcUAAZ00B+wAXwK28VR9FJ+prxtNRVwZLA/fbeaJWV4sBp6Jup
         LlNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hdjcX1r0hcP0ziPjwGYoacie9+kzbK27+8zHrMy8Ek0=;
        b=O3663rKm/JtmrvuLOLxi7ku4DKnRbqs7HzEFwg+TTYbN7OLibnQ2gYpV9QBMHs5kiS
         snshUuA+SFDMtqE1Df2Tewvyq/npUAzCEMuLr2K821eNrv/d9Qx7W0QWO75b9x/d0ZFs
         LcjqdVS45kLRcMmowKJqYdb2d/mYQ9UEAD4c4bwRvUP3R6HRoXZ6krmJd3jyIsy7tfMU
         Sx0V84Bezi5MP9wFwa1wQFx+jgmNNQ588vUxTpqOx+BuBU6P4I6PZjz3v6uW7nDuppgt
         krgKVIk6BVm+QwrLn8Fulc35yRTkl9H+CX7FEThjBjd3Unz0gAkq9ULUrM+WuGTlBvBf
         F0nA==
X-Gm-Message-State: AOAM530WTIZ0KGUbR4oCLM2elIxF9e5QIM3Gn5KOYKbSgwIIHr3oM+dq
        M9OGflXGLGjEI2OxdTS6haXcxMXQA7bE4puBLaRWk8cZrpkYdw==
X-Google-Smtp-Source: ABdhPJxdr9C9WIbRzCa7KUwKZRMgZQMYRCaAHXUCYpMxlePER4o0QdbU0TKuP4lquVxmc2VkzNuMH6ETuRC6l6GBGLY=
X-Received: by 2002:a19:197:: with SMTP id 145mr123836lfb.352.1611320774090;
 Fri, 22 Jan 2021 05:06:14 -0800 (PST)
MIME-Version: 1.0
References: <20201118082759.1413056-1-bharata@linux.ibm.com>
 <CAKfTPtA_JgMf_+zdFbcb_V9rM7JBWNPjAz9irgwFj7Rou=xzZg@mail.gmail.com>
 <20210121053003.GB2587010@in.ibm.com> <alpine.DEB.2.22.394.2101210959060.100764@www.lameter.com>
 <d7fb9425-9a62-c7b8-604d-5828d7e6b1da@suse.cz>
In-Reply-To: <d7fb9425-9a62-c7b8-604d-5828d7e6b1da@suse.cz>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 22 Jan 2021 14:05:47 +0100
Message-ID: <CAG48ez0gutKNuRj4E22tkv8mQKo-6TExGMxvpHCtUz8sFonb3A@mail.gmail.com>
Subject: Re: [RFC PATCH v0] mm/slub: Let number of online CPUs determine the
 slub page order
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Christoph Lameter <cl@linux.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        aneesh.kumar@linux.ibm.com, Michal Hocko <mhocko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 7:19 PM Vlastimil Babka <vbabka@suse.cz> wrote:
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

Uuuh, I think powerpc doesn't have cmpxchg_double?

"vgrep cmpxchg_double arch/" just spits out arm64, s390 and x86? And
<https://liblfds.org/mediawiki/index.php?title=Article:CAS_and_LL/SC_Implementation_Details_by_Processor_family>
says under "POWERPC": "no DW LL/SC"

So powerpc is probably hitting the page-bitlock-based implementation
all the time for stuff like __slub_free()? Do you have detailed
profiling results from "perf top" or something like that?

(I actually have some WIP patches and a design document for getting
rid of cmpxchg_double in struct page that I hacked together in the
last couple days; I'm currently in the process of sending them over to
some other folks in the company who hopefully have cycles to
review/polish/benchmark them so that they can be upstreamed, assuming
that those folks think they're important enough. I don't have the
cycles for it...)
