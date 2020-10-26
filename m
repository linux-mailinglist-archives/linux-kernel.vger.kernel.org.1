Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD6F42994E3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 19:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1789256AbgJZSLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 14:11:43 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33906 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1789243AbgJZSLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 14:11:41 -0400
Received: by mail-pf1-f194.google.com with SMTP id o129so1068291pfb.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 11:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6Bz5GPRbWp3XrXRemXLBijMaIA3X2MxD5TylwfDHBTY=;
        b=gkRVvBvxLp3ugCOVITx2icTmmvG8NzvryLiJrCLGjsquXqgEkRID2YnDxioqUD6dTc
         wfcmR/si/aXZ1a5qB3q5HDPXZQ1h7i5hka2j2c3kuvpBuJTJeUDMphc56ybrFmTmClzW
         WpBTjNERxL/+gHQSIIjMcZeBfW1PE9dojijYlwWOoSkqqOPCgKx9CNfxrUScMAALXG2T
         0PabSqSQx3xC51UGGlel8SqvRW7xaG3EiEJ0NKk9ClsioGv93rCapG4mzH9OyQZbeDYC
         BJnKWKUL+1WkNLi7lPSd14RP4/gYbY75m+1GmK1PIHxGSMpEsqB5my3d6nPezIqtX9V/
         0LNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Bz5GPRbWp3XrXRemXLBijMaIA3X2MxD5TylwfDHBTY=;
        b=W1nAWn1U2VQe2duEmVy5ED2bDu091CEJ87sdjQMNjMjK9FG1udI3bSPPNgTl1qpvJf
         G6fk7WEodnHJFwEIPDkJNSaHkJKblEzwZjFS6oko7CmL7Tbk0kfqlgbfptWj/iQGNFXt
         NmLxgd3/PXWl1mixFkewdEVNJnPYtFELi6zVdLXYk4btZ/d4SuN0QbXex66BUWxVAdNS
         jUYYZLa7Ch+R1gMwVieQYDtxa8l8+fS3C4HU4tJVs/gMEBgGpiXtzv9qJN88c0vxjaRo
         3oIPCdIufEusdl1fOV+1eiU/Idk75Ip3r9J3hthjGm8L4B8mYP9JpCK3OxtP3b6xKvn5
         pX2A==
X-Gm-Message-State: AOAM53017mDbPAXelUzei0e6HbXLOjpkbJV69kKUG1H7hPK5yHG1r5ps
        a/EMxs9HNbfusdXh1RzMyRJO96SOqjyrtIwwD+kDOA==
X-Google-Smtp-Source: ABdhPJykmVCc+IJtph9V8v7BMXExE5cFSooT4S66LbP1texKX4JCFMabEwSI+/TRd2AGr1fEbcJmJ4gXK5Te0fLnwb4=
X-Received: by 2002:a62:1c8f:0:b029:156:6ebd:3361 with SMTP id
 c137-20020a621c8f0000b02901566ebd3361mr14923901pfc.42.1603735898918; Mon, 26
 Oct 2020 11:11:38 -0700 (PDT)
MIME-Version: 1.0
References: <20201021092417.GP11647@shao2-debian> <alpine.DEB.2.23.453.2010231226310.1686635@chino.kir.corp.google.com>
 <CAJHvVcicEcMw=0SL2cF1RR7-E_5RRfXa+PnChob7K7ujL4Y_6w@mail.gmail.com> <cb2f9d93-2d4e-e1ce-6d9a-0ff0e9ce400e@redhat.com>
In-Reply-To: <cb2f9d93-2d4e-e1ce-6d9a-0ff0e9ce400e@redhat.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Mon, 26 Oct 2020 11:11:01 -0700
Message-ID: <CAJHvVcj1NToZO9ZoyWZKWzCe2jMOrLjLAxESiD84Q_V+8er9Ag@mail.gmail.com>
Subject: Re: [mm/page_alloc] 7fef431be9: vm-scalability.throughput 87.8% improvement
To:     David Hildenbrand <david@redhat.com>
Cc:     David Rientjes <rientjes@google.com>,
        kernel test robot <rong.a.chen@intel.com>,
        Kevin Ko <kevko@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@kernel.org>,
        Scott Cheloha <cheloha@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 1:31 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 23.10.20 21:44, Axel Rasmussen wrote:
> > On Fri, Oct 23, 2020 at 12:29 PM David Rientjes <rientjes@google.com> wrote:
> >>
> >> On Wed, 21 Oct 2020, kernel test robot wrote:
> >>
> >>> Greeting,
> >>>
> >>> FYI, we noticed a 87.8% improvement of vm-scalability.throughput due to commit:
> >>>
> >>>
> >>> commit: 7fef431be9c9ac255838a9578331567b9dba4477 ("mm/page_alloc: place pages to tail in __free_pages_core()")
> >>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> >>>
> >>>
> >>> in testcase: vm-scalability
> >>> on test machine: 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory
> >>> with following parameters:
> >>>
> >>>       runtime: 300s
> >>>       size: 512G
> >>>       test: anon-wx-rand-mt
> >>>       cpufreq_governor: performance
> >>>       ucode: 0x5002f01
> >>>
> >>> test-description: The motivation behind this suite is to exercise functions and regions of the mm/ of the Linux kernel which are of interest to us.
> >>> test-url: https://git.kernel.org/cgit/linux/kernel/git/wfg/vm-scalability.git/
> >>>
> >>
> >> I'm curious why we are not able to reproduce this improvement on Skylake
> >> and actually see a slight performance degradation, at least for
> >> 300s_128G_truncate_throughput.
> >>
> >> Axel Rasmussen <axelrasmussen@google.com> can provide more details on our
> >> results.
> >
> > Right, our results show a slight regression on a Skylake machine [1],
> > and a slight performance increase on a Rome machine [2]. For these
> > tests, I used Linus' v5.9 tag as a baseline, and then applied this
> > patchset onto that tag as a test kernel (the patches applied cleanly
> > besides one comment, I didn't have to do any code fixups). This is
> > running the same anon-wx-rand-mt test defined in the upstream
> > lkp-tests job file:
> > https://github.com/intel/lkp-tests/blob/master/jobs/vm-scalability.yaml
>
> Hi,
>
> looking at the yaml, am I right that each test is run after a fresh boot?

Yes-ish. For the results I posted, the larger context would have been
something like:

- Kernel installed, machine freshly rebooted.
- Various machine management daemons start by default, some are
stopped so as not to interfere with the test.
- Some packages are installed on the machine (the thing which
orchestrates the testing in particular).
- The test is run.

So, the machine is somewhat fresh in the sense that it hasn't been
e.g. serving production traffic just before running the test, but it's
also not as clean as it could be. It seems plausible this difference
explains the difference in the results (I'm not too familiar with how
the Intel kernel test robot is implemented).

>
> As I already replied to David, this patch merely changes the initial
> order of the freelists. The general end result is that lower memory
> addresses will be allocated before higher memory addresses will be
> allocated - within a zone, the first time memory is getting allocated.
> Before, it was the other way around. Once a system ran for some time,
> freelists are randomized.
>
> There might be benchmarks/systems where this initial system state might
> now be better suited - or worse. It doesn't really tell you that core-mm
> is behaving better/worse now - it merely means that the initial system
> state under which the benchmark was started affected the benchmark.
>
> Looks like so far there is one benchmark+system where it's really
> beneficial, there is one benchmark+system where it's slightly
> beneficial, and one benchmark+system where there is a slight regression.
>
>
> Something like the following would revert to the previous behavior:
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 23f5066bd4a5..fac82420cc3d 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1553,7 +1553,9 @@ void __free_pages_core(struct page *page, unsigned
> int order)
>          * Bypass PCP and place fresh pages right to the tail, primarily
>          * relevant for memory onlining.
>          */
> -       __free_pages_ok(page, order, FPI_TO_TAIL);
> +       __free_pages_ok(page, order,
> +                       system_state < SYSTEM_RUNNING ? FPI_NONE :
> +                                                       FPI_TO_TAIL);
>  }
>
>  #ifdef CONFIG_NEED_MULTIPLE_NODES
>
>
> (Or better, passing the expected behavior via MEMINIT_EARLY/... to
> __free_pages_core().)
>
>
> But then, I am not convinced we should perform that change: having a
> clean (initial) state might be true for these benchmarks, but it's far
> from reality. The change in numbers doesn't show you that core-mm is
> operating better/worse, just that the baseline for you tests changed due
> to a changed initial system state.

Not to put words in David's mouth :) but at least from my perspective,
our original interest was "wow, an 87% improvement! maybe we should
deploy this patch to production!", and I'm mostly sharing my results
just to say "it actually doesn't seem to be a huge *general*
improvement", rather than to advocate for further changes / fixes.
IIUC the original motivation for this patch was to fix somewhat of an
edge case, not to make a very general improvement, so this seems fine.

>
> Thanks!
>
> --
> Thanks,
>
> David / dhildenb
>
