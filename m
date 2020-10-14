Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39DE728E5C9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 19:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728403AbgJNR47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 13:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgJNR47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 13:56:59 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DA9C061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 10:56:59 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id p15so6083613ejm.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 10:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fobYHYztRcy10+w7hd26W0suLfD59emOzXajN5Y0auM=;
        b=l5qAYFFo156/B4XdJzWOPtqmTKHvR21ZXv4iLyfo+HG40YsXJBPAtguQUVprmKS0Uk
         iAdgDi8lazMkjLTNUrZSekMm2NGvfyI0/DZQynclYFzHJEk3Jl4OyjDMzMqm8ZFc/Y9j
         M9Quvn93u9tKU32SwMwM/CjONBu3UgjSQE2gQ8lSLGhP8iIlMc6RH0rPCcQgVZwSLglS
         sL9EXXdpE9liaE9EuvvVKvoJkCNNmLiSKJ0MkPD81t6/7V6rQPejS/ylpIzX7xw8FDQv
         9UfXp+SvbiPh77GrrJQkMU4Z/dI6T9UMdnrLh+mH70OW0zPvUCqBdrbH934qkWyP/Ffe
         1YzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fobYHYztRcy10+w7hd26W0suLfD59emOzXajN5Y0auM=;
        b=M3QJ/b1+n8sSabmkQksirdqRdn/z2WHWa8W+UV8HNzvkAz2svLvoEkKwWTMDoGxB/O
         WLFyFBkCGmUQx/nZBYiK6KSAOG4CT40VGIed9AzvDo+6WmaDtVWA2pgAINbZnx3jEmzK
         mPnrgTRNm+nhJ7OsXQLL4RJqeq6+zIFXi/ZtqsBUJeZkauVaXTH+sCC/0Y1cZvi2fTZX
         PdKhJc7RL2yTKnBquicTWDyrfqTT289zPt2v8ieDDNnKT15AjtURQ6OLtWr6Twij9tM3
         uObSb/cprLf83k4GvZz5sEcfcKBVTgbGbUfUt7CayKyvtDny4qxcZkmKnCt/Dfv1Zkq1
         rjqQ==
X-Gm-Message-State: AOAM531uyZnTX7mT9F+4LWjZXvbY4RtVFNHWP3eRvxBoC+vBl681J/ZD
        rOASdAnH4uGAwy3DSNwvdegCNjQDcOy0iGDjJxIqPOCq9bCKN7cA
X-Google-Smtp-Source: ABdhPJz57leuWYSHMLWqjo3wmE7CyGtwCqN0+eOMfe66uls8dAySNWCcPupwtppCZV63MUx8CtoBv7g1czawS9miIPg=
X-Received: by 2002:a17:906:400b:: with SMTP id v11mr176114ejj.421.1602698217405;
 Wed, 14 Oct 2020 10:56:57 -0700 (PDT)
MIME-Version: 1.0
References: <c1ea7548-622c-eda7-66f4-e4ae5b6ee8fc@redhat.com> <563d1eef-b780-835a-ebf0-88ae111b20c2@redhat.com>
In-Reply-To: <563d1eef-b780-835a-ebf0-88ae111b20c2@redhat.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Wed, 14 Oct 2020 10:56:46 -0700
Message-ID: <CAHS8izPEHZunoeXYS5ONfRoSRMpC7DQwtpjJ8g4nXiddTfNoaA@mail.gmail.com>
Subject: Re: cgroup and FALLOC_FL_PUNCH_HOLE: WARNING: CPU: 13 PID: 2438 at
 mm/page_counter.c:57 page_counter_uncharge+0x4b/0x5
To:     David Hildenbrand <david@redhat.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Michal Privoznik <mprivozn@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 14, 2020 at 9:15 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 14.10.20 17:22, David Hildenbrand wrote:
> > Hi everybody,
> >
> > Michal Privoznik played with "free page reporting" in QEMU/virtio-balloon
> > with hugetlbfs and reported that this results in [1]
> >
> > 1. WARNING: CPU: 13 PID: 2438 at mm/page_counter.c:57 page_counter_uncharge+0x4b/0x5
> >
> > 2. Any hugetlbfs allocations failing. (I assume because some accounting is wrong)
> >
> >
> > QEMU with free page hinting uses fallocate(FALLOC_FL_PUNCH_HOLE)
> > to discard pages that are reported as free by a VM. The reporting
> > granularity is in pageblock granularity. So when the guest reports
> > 2M chunks, we fallocate(FALLOC_FL_PUNCH_HOLE) one huge page in QEMU.
> >
> > I was also able to reproduce (also with virtio-mem, which similarly
> > uses fallocate(FALLOC_FL_PUNCH_HOLE)) on latest v5.9
> > (and on v5.7.X from F32).
> >
> > Looks like something with fallocate(FALLOC_FL_PUNCH_HOLE) accounting
> > is broken with cgroups. I did *not* try without cgroups yet.
> >
> > Any ideas?

Hi David,

I may be able to dig in and take a look. How do I reproduce this
though? I just fallocate(FALLOC_FL_PUNCH_HOLE) one 2MB page in a
hugetlb region?

>
> Just tried without the hugetlb controller, seems to work just fine.
>
> I'd like to note that
> - The controller was not activated
> - I had to compile the hugetlb controller out to make it work.
>
> --
> Thanks,
>
> David / dhildenb
>
