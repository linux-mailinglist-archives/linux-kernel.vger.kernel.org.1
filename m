Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0B0301536
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 13:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbhAWMdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 07:33:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbhAWMdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 07:33:38 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC07C06174A
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jan 2021 04:32:57 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id p13so9689222ljg.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jan 2021 04:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vBh5H4k0XuQ/azVIMGSo5Pzy7Vlv+wGW5XIuI6F93W4=;
        b=JIeQbtniS4OamjqlZHEyWc2Ql0bnYt0EdN1j9AP6ZNkOR8UHet7kfYakxl1YbX5oGG
         j+IyRHOF1LtwaBzsFyIe2uzcj/EalESzjpbpH6S3ccWFNcslSALIBtpuc0qlpaz8iqXr
         vCTA+mCTup4/tFO6gDvy5CgA4gxagk8pzIpkFtuMsXYTjLvt5REgKSNRSAOG3/dnAvDR
         WhiyrVeufDHr2LJUYIQxTij+FCEeVFfvu11JEkg26kJcCJYrg/xYShLgP6aPjtI2FMd2
         1CVXyfmdPfY2ARepnL7hds7I9OtPtOpaWnvKqZXQ4+43umDGda5hTS7jV/AtkQa1fKC2
         Q47Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vBh5H4k0XuQ/azVIMGSo5Pzy7Vlv+wGW5XIuI6F93W4=;
        b=qhWEIx2qvCSEkba6+1gBqKji/QxEm+uReNkDxH1mI7VPlcdCQ5Fjz3OYVD2eIUxlcv
         /mTg6JYr0LTLQXhM1cNAYwW8RmHFMS0axD3+SVUwrOMJuKwEBOaoofm3xWvnxGYO6VBY
         urbrgnreECLv1depfpYv4iR6kHhQbnGyCGkLvY1Vd45IK/cJD7oytZG7Pip7W71Go2M1
         LF4ryC0fb1u15/s7CdwZy7wedhChIm+VD9ssQZCzyBPIVu2/eq+1xzrV1FyvK+hgsO8S
         G+O3gIo0dsh//yeu5tI8i6os15nmcDhRkQD87gqU8neTo1zTzW4C9lI493DYa8u5bTpd
         f0oQ==
X-Gm-Message-State: AOAM530PupB0dbKvNZQ1nU20R9TWYyBDHXjVG72Q+Gzx+Q/dTGML1MNo
        udswTAD4DsYGqujypSzYFTVppFbdvluPmfMPx0CFWw==
X-Google-Smtp-Source: ABdhPJx/WVT0BPklO7v5kinhO4erIH+TfGbHF9u9pC87E9hKIFtk27+LFWAtcbaB7Ci89uAdaBxGM08ENIuJTiDinvQ=
X-Received: by 2002:a2e:9857:: with SMTP id e23mr226983ljj.209.1611405175877;
 Sat, 23 Jan 2021 04:32:55 -0800 (PST)
MIME-Version: 1.0
References: <20201118082759.1413056-1-bharata@linux.ibm.com>
 <CAKfTPtA_JgMf_+zdFbcb_V9rM7JBWNPjAz9irgwFj7Rou=xzZg@mail.gmail.com>
 <20210121053003.GB2587010@in.ibm.com> <alpine.DEB.2.22.394.2101210959060.100764@www.lameter.com>
 <d7fb9425-9a62-c7b8-604d-5828d7e6b1da@suse.cz> <CAKfTPtDy3Ynk2nGCTWiXjz9-4vuSHB3pGuafoTUBPFNO1ac3PA@mail.gmail.com>
 <786571e7-b9a2-4cdb-06d5-aa4a4b439b7e@suse.cz> <20210123051607.GC2587010@in.ibm.com>
In-Reply-To: <20210123051607.GC2587010@in.ibm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Sat, 23 Jan 2021 13:32:44 +0100
Message-ID: <CAKfTPtAjyVmS5VYvU6DBxg4-JEo5bdmWbngf-03YsY18cmWv_g@mail.gmail.com>
Subject: Re: [RFC PATCH v0] mm/slub: Let number of online CPUs determine the
 slub page order
To:     Bharata B Rao <bharata@linux.ibm.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, guro@fb.com,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        aneesh.kumar@linux.ibm.com, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Adding arch arm64 Maintainers

On Sat, 23 Jan 2021 at 06:16, Bharata B Rao <bharata@linux.ibm.com> wrote:
>
> On Fri, Jan 22, 2021 at 01:03:57PM +0100, Vlastimil Babka wrote:
> > On 1/22/21 9:03 AM, Vincent Guittot wrote:
> > > On Thu, 21 Jan 2021 at 19:19, Vlastimil Babka <vbabka@suse.cz> wrote:
> > >>
> > >> On 1/21/21 11:01 AM, Christoph Lameter wrote:
> > >> > On Thu, 21 Jan 2021, Bharata B Rao wrote:
> > >> >
> > >> >> > The problem is that calculate_order() is called a number of times
> > >> >> > before secondaries CPUs are booted and it returns 1 instead of 224.
> > >> >> > This makes the use of num_online_cpus() irrelevant for those cases
> > >> >> >
> > >> >> > After adding in my command line "slub_min_objects=36" which equals to
> > >> >> > 4 * (fls(num_online_cpus()) + 1) with a correct num_online_cpus == 224
> > >> >> > , the regression diseapears:
> > >> >> >
> > >> >> > 9 iterations of hackbench -l 16000 -g 16: 3.201sec (+/- 0.90%)
> > >>
> > >> I'm surprised that hackbench is that sensitive to slab performance, anyway. It's
> > >> supposed to be a scheduler benchmark? What exactly is going on?
> > >>
> > >
> > > From hackbench description:
> > > Hackbench is both a benchmark and a stress test for the Linux kernel
> > > scheduler. It's  main
> > >        job  is  to  create a specified number of pairs of schedulable
> > > entities (either threads or
> > >        traditional processes) which communicate via either sockets or
> > > pipes and time how long  it
> > >        takes for each pair to send data back and forth.
> >
> > Yep, so I wonder which slab entities this is stressing that much.
> >
> > >> Things would be easier if we could trust *on all arches* either
> > >>
> > >> - num_present_cpus() to count what the hardware really physically has during
> > >> boot, even if not yet onlined, at the time we init slab. This would still not
> > >> handle later hotplug (probably mostly in a VM scenario, not that somebody would
> > >> bring bunch of actual new cpu boards to a running bare metal system?).
> > >>
> > >> - num_possible_cpus()/nr_cpu_ids not to be excessive (broken BIOS?) on systems
> > >> where it's not really possible to plug more CPU's. In a VM scenario we could
> > >> still have an opposite problem, where theoretically "anything is possible" but
> > >> the virtual cpus are never added later.
> > >
> > > On all the system that I have tested num_possible_cpus()/nr_cpu_ids
> > > were correctly initialized
> > >
> > > large arm64 acpi system
> > > small arm64 DT based system
> > > VM on x86 system
> >
> > So it's just powerpc that has this issue with too large nr_cpu_ids? Is it caused
> > by bios or the hypervisor? How does num_present_cpus() look there?
>
> PowerPC PowerNV Host: (160 cpus)
> num_online_cpus 1 num_present_cpus 160 num_possible_cpus 160 nr_cpu_ids 160
>
> PowerPC pseries KVM guest: (-smp 16,maxcpus=160)
> num_online_cpus 1 num_present_cpus 16 num_possible_cpus 160 nr_cpu_ids 160
>
> That's what I see on powerpc, hence I thought num_present_cpus() could
> be the correct one to use in slub page order calculation.

num_present_cpus() is set to 1 on arm64 until secondaries cpus boot

arm64 224cpus acpi host:
num_online_cpus 1 num_present_cpus 1 num_possible_cpus 224 nr_cpu_ids 224
arm64 8cpus DT host:
num_online_cpus 1 num_present_cpus 1 num_possible_cpus 8 nr_cpu_ids 8
arm64 8cpus qemu-system-aarch64 (-smp 8,maxcpus=256)
num_online_cpus 1 num_present_cpus 1 num_possible_cpus 8 nr_cpu_ids 8

Then present and online increase to num_possible_cpus once all cpus are booted

>
> >
> > What about heuristic:
> > - num_online_cpus() > 1 - we trust that and use it
> > - otherwise nr_cpu_ids
> > Would that work? Too arbitrary?
>
> Looking at the following snippet from include/linux/cpumask.h, it
> appears that num_present_cpus() should be reasonable compromise
> between online and possible/nr_cpus_ids to use here.
>
> /*
>  * The following particular system cpumasks and operations manage
>  * possible, present, active and online cpus.
>  *
>  *     cpu_possible_mask- has bit 'cpu' set iff cpu is populatable
>  *     cpu_present_mask - has bit 'cpu' set iff cpu is populated
>  *     cpu_online_mask  - has bit 'cpu' set iff cpu available to scheduler
>  *     cpu_active_mask  - has bit 'cpu' set iff cpu available to migration
>  *
>  *  If !CONFIG_HOTPLUG_CPU, present == possible, and active == online.
>  *
>  *  The cpu_possible_mask is fixed at boot time, as the set of CPU id's
>  *  that it is possible might ever be plugged in at anytime during the
>  *  life of that system boot.  The cpu_present_mask is dynamic(*),
>  *  representing which CPUs are currently plugged in.  And
>  *  cpu_online_mask is the dynamic subset of cpu_present_mask,
>  *  indicating those CPUs available for scheduling.
>  *
>  *  If HOTPLUG is enabled, then cpu_possible_mask is forced to have
>  *  all NR_CPUS bits set, otherwise it is just the set of CPUs that
>  *  ACPI reports present at boot.
>  *
>  *  If HOTPLUG is enabled, then cpu_present_mask varies dynamically,
>  *  depending on what ACPI reports as currently plugged in, otherwise
>  *  cpu_present_mask is just a copy of cpu_possible_mask.
>  *
>  *  (*) Well, cpu_present_mask is dynamic in the hotplug case.  If not
>  *      hotplug, it's a copy of cpu_possible_mask, hence fixed at boot.
>  */
>
> So for host systems, present is (usually) equal to possible and for

But "cpu_present_mask varies dynamically,  depending on what ACPI
reports as currently plugged in"

So it should varies when secondaries cpus are booted

> guest systems present should indicate the CPUs found to be present
> at boottime. The intention of my original patch was to use this
> metric in slub page order calculation rather than nr_cpus_ids
> or num_cpus_possible() which could be high on guest systems that
> typically support CPU hotplug.
>
> Regards,
> Bharata.
