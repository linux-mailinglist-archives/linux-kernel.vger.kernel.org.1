Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E84F303EEF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 14:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404774AbhAZNk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 08:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391883AbhAZNjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 08:39:08 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5FB3C0611C2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 05:38:27 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id t8so12237655ljk.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 05:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oZ1J3xOVFtmJXTfZDgdAErA6KmvVsDRz9fNO4jgxHtI=;
        b=SMgFuNiKEiPhgaDPUI1/GdrArkuGqBjLB3McvDo7jbt34eJ2jgnjX6f9mSvR28tX6E
         S3n2pwarMwadMM76RXTY7ocxNTiwpwU+6q90aq30CIKjLApsgEURWwrHy39IMez6H+0t
         8YsGmK3jPcbZbzVR5hcoqYvngNAyZTiNRI0T6nWv1kqYd0yr4l2JVIjvL2h7nq6P2WHG
         ak371TlfXR3u3bVbzRGSsYrgkqdz5YahDQzHUSd9R7N9p2sAAuxeEt6Z5D8GuH4jwi61
         a4VhTxiXpiFaM9QNf3I0Uo5zp1UEBkIz0NW0JMu68F9Qw03rlXsDHjsmMYDioG8qjSAm
         c8ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oZ1J3xOVFtmJXTfZDgdAErA6KmvVsDRz9fNO4jgxHtI=;
        b=FXwmFSUiYNXuWWwssYG24rBq39UBQ11Rh0Aa6y/R4lmZqjUjZxkBStlV86M+qGzQv1
         vfSPgFkaCHts8GORXasRz2SJQxNenzioRTOwsrhavHtSTswRlXYQteW4PudLM3ZbzXI+
         UvfMx6Ko92A2WvEMTzYy2V1y9l46MmhlSxNdlhROYummaM1umxUAQ+eic7Vo89silwc7
         eJk+rRdVl8qUDXt4y4WrQo7/vixxFlCcLrSBjjnEKfRwoBDEO1zmccaX2EyQZW2F1Dcm
         663XmbeMIXJvuA9/Bx+CyDeV8UGLmtWez1vFmQIHQSByxDSXJJL8vL8asd50lOyvQlYa
         6vQA==
X-Gm-Message-State: AOAM531cQPgkqSPb0JQMZF+KHZmOZUuky4PoiUVsmZ4bmr2gGSRTPOWS
        WT335oMcacpoz0eMXGxf5TYgEGO/iWNmNt+2+jFKCg==
X-Google-Smtp-Source: ABdhPJwBzZJw5LXtXQwYj+NiFhtZ3u2pojQ4UVxtFwwJkpquZoeXf8pRlfAY2qhHOM3HnqUJjHZI3HjQdaPTmeame2Y=
X-Received: by 2002:a2e:5408:: with SMTP id i8mr2910097ljb.221.1611668306093;
 Tue, 26 Jan 2021 05:38:26 -0800 (PST)
MIME-Version: 1.0
References: <20201118082759.1413056-1-bharata@linux.ibm.com>
 <CAKfTPtA_JgMf_+zdFbcb_V9rM7JBWNPjAz9irgwFj7Rou=xzZg@mail.gmail.com>
 <20210121053003.GB2587010@in.ibm.com> <alpine.DEB.2.22.394.2101210959060.100764@www.lameter.com>
 <d7fb9425-9a62-c7b8-604d-5828d7e6b1da@suse.cz> <20210126085243.GE827@dhcp22.suse.cz>
In-Reply-To: <20210126085243.GE827@dhcp22.suse.cz>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 26 Jan 2021 14:38:14 +0100
Message-ID: <CAKfTPtAhqiHtPMUTZv8Bs3Cg5=HXLmrda=j4_HFrF=7ztYZLGA@mail.gmail.com>
Subject: Re: [RFC PATCH v0] mm/slub: Let number of online CPUs determine the
 slub page order
To:     Michal Hocko <mhocko@suse.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, guro@fb.com,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        aneesh.kumar@linux.ibm.com, Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jan 2021 at 09:52, Michal Hocko <mhocko@suse.com> wrote:
>
> On Thu 21-01-21 19:19:21, Vlastimil Babka wrote:
> [...]
> > We could also start questioning the very assumption that number of cpus should
> > affect slab page size in the first place. Should it? After all, each CPU will
> > have one or more slab pages privately cached, as we discuss in the other
> > thread... So why make the slab pages also larger?
>
> I do agree. What is the acutal justification for this scaling?
>         /*
>          * Attempt to find best configuration for a slab. This
>          * works by first attempting to generate a layout with
>          * the best configuration and backing off gradually.
>          *
>          * First we increase the acceptable waste in a slab. Then
>          * we reduce the minimum objects required in a slab.
>          */
>
> doesn't speak about CPUs.  9b2cd506e5f2 ("slub: Calculate min_objects
> based on number of processors.") does talk about hackbench "This has
> been shown to address the performance issues in hackbench on 16p etc."
> but it doesn't give any more details to tell actually _why_ that works.
>
> This thread shows that this is still somehow related to performance but
> the real reason is not clear. I believe we should be focusing on the
> actual reasons for the performance impact than playing with some fancy
> math and tuning for a benchmark on a particular machine which doesn't
> work for others due to subtle initialization timing issues.
>
> Fundamentally why should higher number of CPUs imply the size of slab in
> the first place?

A 1st answer is that the activity and the number of threads involved
scales with the number of CPUs. Regarding the hackbench benchmark as
an example, the number of group/threads raise to a higher level on the
server than on the small system which doesn't seem unreasonable.

On 8 CPUs, I run hackbench with up to 16 groups which means 16*40
threads. But I raise up to 256 groups, which means 256*40 threads, on
the 224 CPUs system. In fact, hackbench -g 1 (with 1 group) doesn't
regress on the 224 CPUs  system.  The next test with 4 groups starts
to regress by -7%. But the next one: hackbench -g 16 regresses by 187%
(duration is almost 3 times longer). It seems reasonable to assume
that the number of running threads and resources scale with the number
of CPUs because we want to run more stuff.


> --
> Michal Hocko
> SUSE Labs
