Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5D9E2FE5FE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 10:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbhAUJLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 04:11:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728171AbhAUJKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 04:10:39 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCDDC0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 01:09:57 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id e7so1613139ljg.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 01:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PkTzETrZHh1QiUI4cwNdCrjkZdJGNVgSP3XlR2Tk4Eg=;
        b=jmdQc98IfnFlqCzlNBQBjXZTD7Om8oUGjOv9+/bS8iv93ga8svTQj8T+2ch38Svtfa
         Dt662gAqxcClCHzL81RCe53k6c3abXY94XW5Kq8n4VY0cGWk/WYb/DXb4HidQxL7Qmmq
         vlXFcBpikotiVGGOvPX0OvkF0wvscc80ZkeS2a6CGS9j9yDL0UpE66AoynrQkvUQVwVS
         /yzqhpqspV23gxNuio4/OEFpLM+nE4e8Im+6rTZHZrKD9xnOyEF7pWo1DKvdLNPtbS8+
         YNA1UelOWx0YHBK6UZtEPttYro5uHButAI1FvFgHgZRRXyw75xLYmatA9NPMsDB9t4lD
         88EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PkTzETrZHh1QiUI4cwNdCrjkZdJGNVgSP3XlR2Tk4Eg=;
        b=kMB2VcGDjC/LVtFNWAwuY6Xm3ky2MLdDN5lnUMaKJ9E8Zy9Rxl4CPYJZ0ZNmFCo55V
         tcdiN4LJX4VyMZH9GN04P03+yOC0myc9TMZzUzT7c0n+IMOLEmw3u5p6MHmrl09hY/H2
         Dg/Q+ZhObLuHA3XdISjhV6X2su6rTMdA4jhpQTKpeQPd2oxyAcG1uhVqBkgVZOmG141U
         xnV6Xb07mWWeZx/BRwtq9YUmE4FXGo+oksqbYLJY9945hoKZWkmxUZJfFxmMbXVAPCiN
         qg1PuRpAONaPkXVZ+idD8aDO7ANAot56e0E8z61xeF40Sidd9nW34F+abQ4gTkSdeQmo
         JHzg==
X-Gm-Message-State: AOAM530whH3KOGVGZjg8PJ4CZN1NhtowWaEauiPVBP1OUfyVz3tXxYVg
        2wynDSRA7qYOYUPMxEUbIiL2+uCC8jJ+16MtVpE7dEpUbhdUsA==
X-Google-Smtp-Source: ABdhPJx2RcoFSOIwetYQUvc9j8plqUPdAK9mvN1xDNM0cKh3SI4wnYnC1BbJU+JH3rcIQlfNdxIZjCjYssiHQWt1tjI=
X-Received: by 2002:a2e:7613:: with SMTP id r19mr6766385ljc.284.1611220195712;
 Thu, 21 Jan 2021 01:09:55 -0800 (PST)
MIME-Version: 1.0
References: <20201118082759.1413056-1-bharata@linux.ibm.com>
 <CAKfTPtA_JgMf_+zdFbcb_V9rM7JBWNPjAz9irgwFj7Rou=xzZg@mail.gmail.com> <20210121053003.GB2587010@in.ibm.com>
In-Reply-To: <20210121053003.GB2587010@in.ibm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 21 Jan 2021 10:09:44 +0100
Message-ID: <CAKfTPtBb8JV2bhazmONfvMmUjF9Z-vQcHXNXku3_BkmJjXikUA@mail.gmail.com>
Subject: Re: [RFC PATCH v0] mm/slub: Let number of online CPUs determine the
 slub page order
To:     Bharata B Rao <bharata@linux.ibm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, guro@fb.com,
        vbabka@suse.cz, Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        aneesh.kumar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jan 2021 at 06:31, Bharata B Rao <bharata@linux.ibm.com> wrote:
>
> On Wed, Jan 20, 2021 at 06:36:31PM +0100, Vincent Guittot wrote:
> > Hi,
> >
> > On Wed, 18 Nov 2020 at 09:28, Bharata B Rao <bharata@linux.ibm.com> wrote:
> > >
> > > The page order of the slab that gets chosen for a given slab
> > > cache depends on the number of objects that can be fit in the
> > > slab while meeting other requirements. We start with a value
> > > of minimum objects based on nr_cpu_ids that is driven by
> > > possible number of CPUs and hence could be higher than the
> > > actual number of CPUs present in the system. This leads to
> > > calculate_order() chosing a page order that is on the higher
> > > side leading to increased slab memory consumption on systems
> > > that have bigger page sizes.
> > >
> > > Hence rely on the number of online CPUs when determining the
> > > mininum objects, thereby increasing the chances of chosing
> > > a lower conservative page order for the slab.
> > >
> > > Signed-off-by: Bharata B Rao <bharata@linux.ibm.com>
> > > ---
> > > This is a generic change and I am unsure how it would affect
> > > other archs, but as a start, here are some numbers from
> > > PowerPC pseries KVM guest with and without this patch:
> > >
> > > This table shows how this change has affected some of the slab
> > > caches.
> > > ===================================================================
> > >                 Current                         Patched
> > > Cache   <objperslab> <pagesperslab>     <objperslab> <pagesperslab>
> > > ===================================================================
> > > TCPv6           53    2                 26    1
> > > net_namespace   53    4                 26    2
> > > dtl             32    2                 16    1
> > > names_cache     32    2                 16    1
> > > task_struct     53    8                 13    2
> > > thread_stack    32    8                 8     2
> > > pgtable-2^11    16    8                 8     4
> > > pgtable-2^8     32    2                 16    1
> > > kmalloc-32k     16    8                 8     4
> > > kmalloc-16k     32    8                 8     2
> > > kmalloc-8k      32    4                 8     1
> > > kmalloc-4k      32    2                 16    1
> > > ===================================================================
> > >
> > > Slab memory (kB) consumption comparision
> > > ==================================================================
> > >                         Current         Patched
> > > ==================================================================
> > > After-boot              205760          156096
> > > During-hackbench        629145          506752 (Avg of 5 runs)
> > > After-hackbench         474176          331840 (after drop_caches)
> > > ==================================================================
> > >
> > > Hackbench Time (Avg of 5 runs)
> > > (hackbench -s 1024 -l 200 -g 200 -f 25 -P)
> > > ==========================================
> > > Current         Patched
> > > ==========================================
> > > 10.990          11.010
> > > ==========================================
> > >
> > > Measuring the effect due to CPU hotplug
> > > ----------------------------------------
> > > Since the patch doesn't consider all the possible CPUs for page
> > > order calcluation, let's see how affects the case when CPUs are
> > > hotplugged. Here I compare a system that is booted with 64CPUs
> > > with a system that is booted with 16CPUs but hotplugged with
> > > 48CPUs after boot. These numbers are with the patch applied.
> > >
> > > Slab memory (kB) consumption comparision
> > > ===================================================================
> > >                         64bootCPUs      16bootCPUs+48HotPluggedCPUs
> > > ===================================================================
> > > After-boot              390272          159744
> > > After-hotplug           -               251328
> > > During-hackbench        1001267         941926 (Avg of 5 runs)
> > > After-hackbench         913600          827200 (after drop_caches)
> > > ===================================================================
> > >
> > > Hackbench Time (Avg of 5 runs)
> > > (hackbench -s 1024 -l 200 -g 200 -f 25 -P)
> > > ===========================================
> > > 64bootCPUs      16bootCPUs+48HotPluggedCPUs
> > > ===========================================
> > > 12.554          12.589
> > > ===========================================
> > >  mm/slub.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> >
> > I'm facing significant performances regression on a large arm64 server
> > system (224 CPUs). Regressions is also present on small arm64 system
> > (8 CPUs) but in a far smaller order of magnitude
> >
> > On 224 CPUs system : 9 iterations of hackbench -l 16000 -g 16
> > v5.11-rc4 : 9.135sec (+/- 0.45%)
> > v5.11-rc4 + revert this patch: 3.173sec (+/- 0.48%)
> > v5.10: 3.136sec (+/- 0.40%)
> >
> > This is a 191% regression compared to v5.10.
> >
> > The problem is that calculate_order() is called a number of times
> > before secondaries CPUs are booted and it returns 1 instead of 224.
> > This makes the use of num_online_cpus() irrelevant for those cases
> >
> > After adding in my command line "slub_min_objects=36" which equals to
> > 4 * (fls(num_online_cpus()) + 1) with a correct num_online_cpus == 224
> > , the regression diseapears:
> >
> > 9 iterations of hackbench -l 16000 -g 16: 3.201sec (+/- 0.90%)
>
> Should we have switched to num_present_cpus() rather than
> num_online_cpus()? If so, the below patch should address the
> above problem.

The problem is the same with num_present_cpus() which is initialized
at the same time as num_online_cpus.
Only num_possible_cpus() returns a correct value just like nr_cpu_ids.

Both  num_possible_cpus and nr_cpu_ids return the number of CPUs of
the platforms and not the NR_CPUS
num_possible_cpus() = nr_cpu_ids = 224 from the beginning whereas
NR_CPUS=256 on my large system
num_possible_cpus() = nr_cpu_ids = 8 from the beginning whereas
NR_CPUS=256 on my small system


>
> From 252b332ccbee7152da1e18f1fff5b83f8e01b8df Mon Sep 17 00:00:00 2001
> From: Bharata B Rao <bharata@linux.ibm.com>
> Date: Thu, 21 Jan 2021 10:35:08 +0530
> Subject: [PATCH] mm/slub: let number of present CPUs determine the slub
>  page order
>
> Commit 045ab8c9487b ("mm/slub: let number of online CPUs determine
> the slub page order") changed the slub page order to depend on
> num_online_cpus() from nr_cpu_ids. However we find that certain
> caches (kmalloc) are initialized even before the secondary CPUs
> are onlined resulting in lower slub page order and subsequent
> regression.
>
> Switch to num_present_cpus() instead.
>
> Reported-by: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Bharata B Rao <bharata@linux.ibm.com>
> Fixes: 045ab8c9487b ("mm/slub: let number of online CPUs determine the slub page order")
> ---
>  mm/slub.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index d9e4e10683cc..2f3e412c849d 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3433,7 +3433,7 @@ static inline int calculate_order(unsigned int size)
>          */
>         min_objects = slub_min_objects;
>         if (!min_objects)
> -               min_objects = 4 * (fls(num_online_cpus()) + 1);
> +               min_objects = 4 * (fls(num_present_cpus()) + 1);
>         max_objects = order_objects(slub_max_order, size);
>         min_objects = min(min_objects, max_objects);
>
> --
> 2.26.2
>
>
>
