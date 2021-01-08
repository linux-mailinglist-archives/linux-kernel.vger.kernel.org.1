Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7D792EF494
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 16:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbhAHPLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 10:11:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbhAHPLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 10:11:43 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7722C0612FD
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 07:11:03 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id r9so9866431otk.11
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 07:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kKMJnT0tRZy9fkXepjpNOwR4Nx6ZJJQ6iyD5ZlamySg=;
        b=FAVTgcguj+VWss+5c2BNMfNJjCvcQaMxRodk+IwlI7HwUnSkgrAbv9fyvA5xbG+MW8
         35cwTL+P+7g0vLBcM6m4yZY+P+x6oMipBsCNzWSzjTBdC6oWKylyaBwO3NKZ9ztG6Jl7
         7xfNYmNX4tNDGmD5FuG8/tLTLM6ljg0KoQx8s+vxtVsmvngFk1XfiUVEbTtkVcJll6Gb
         1G05PezA2OOw0Txi96mKkQ//Nn7Z16pPCM20GTX+BJyIm3I5WEAMJ89a3Ve5FmkfKVux
         5hyXEd9HgsdiLgsAW/fzXtK25SRQ/FYnzKqvkOug6CkNfN71lVRMuizfKKaW0Suwme3C
         p26g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kKMJnT0tRZy9fkXepjpNOwR4Nx6ZJJQ6iyD5ZlamySg=;
        b=RVHEENiyVyXsJLjKWPCbHf0/AFfUnbJMF7Mi6bRdLJ/I7/cw+X/nHT+bYYVv7ilbrZ
         x/7sIW9tNznnVhdf4HL0PLgvs0Ol4mK1t7UX4g7ZB9J+9/ciZw03FeEH16eRpx7ME8rh
         woFeeqIvvMMpENHSCRF7i8Z6B3h6JKNlYHnuvrWQTBkpr/9lqlJ0fjDgmopZe1AnDrzS
         jx5AmMLN6Yuh+5WZgbQBKyubs1Wk5h4rUkMjwcZfGPfg8/+PiHmBbKEh8dO35E1r7tjW
         6jf2J4ATPN6VOLC6BA7tPMVuR1bKngKRtN6sESJTNlTNS3O/mrCFmjaYB5zR5K8RRTpY
         G+ZA==
X-Gm-Message-State: AOAM531/7F+06XF7XT5URmXvBTFVo9PCiqs3VnQdntu2iD50qqPX9ooJ
        Jx0fspVnl+gO2Z8p3sqDihlcvFkWm0jBYS5heMmt1g==
X-Google-Smtp-Source: ABdhPJzf1KZ6dyU920Ap+6HubY3YF/FtIpKYDI/jDkEAIMOOeOL1Pd6trwFqAMZcd1DmG/DRgEegJyyVafZURF9WqIw=
X-Received: by 2002:a05:6830:84:: with SMTP id a4mr2927959oto.261.1610118662924;
 Fri, 08 Jan 2021 07:11:02 -0800 (PST)
MIME-Version: 1.0
References: <20201214164822.402812729@infradead.org> <20201214170017.877557652@infradead.org>
 <c4e31235-e1fb-52ac-99a8-ae943ee0de54@linux.intel.com> <20201215075911.GA3040@hirez.programming.kicks-ass.net>
 <20210108102738.GB3592@techsingularity.net> <CAKfTPtD5R1S=rwp9C-jyMg8bAB-37FCe3qrqad9KEeyR7mOmkw@mail.gmail.com>
 <20210108144058.GD3592@techsingularity.net>
In-Reply-To: <20210108144058.GD3592@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 8 Jan 2021 16:10:51 +0100
Message-ID: <CAKfTPtCGCmCv0yXSUmYUh6=8uzd0n9xFPqC0cW4sm-FqDvjvCQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/5] sched/fair: Fix select_idle_cpu()s cost accounting
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Jiang Biao <benbjiang@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Jan 2021 at 15:41, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Fri, Jan 08, 2021 at 02:41:19PM +0100, Vincent Guittot wrote:
> > > 1. avg_scan_cost is now based on the average scan cost of a rq but
> > >    avg_idle is still scaled to the domain size. This is a bit problematic
> > >    because it's comparing scan cost of a single rq with the estimated
> > >    average idle time of a domain. As a result, the scan depth can be much
> > >    larger than it was before the patch and led to some regressions.
> >
> > Point 1 makes sense to me too
> >
> > >
> > > 2. Accounting for the scan cost of success makes sense but there is a
> > >    big difference between a scan that finds an idle CPU and one that fails.
> > >    For failures, the scan cost is wasted CPU time where as a success
> > >    means that an uncontested CPU is used. This can cause a search to be
> > >    truncated earlier than it should be when the domain is lightly loaded.
> >
> > But I'm not sure to catch your problem with point 2.
> > track the average cost to scan one rq so looping all rqs are only few
> > should not impact (much) the avg_scan_cost
> >
> > Trying to bias the avg_scan_cost with:  loops <<= 2;
> > will just make avg_scan_cost lost any kind of meaning because it
> > doesn't reflect the avg cost of scanning a rq anymore
> >
>
> Before the series, the avg_scan_cost also did not represent the cost of
> scanning a RQ before either. Treating scan failures and successes equally

I agree that the previous avg_scan_cost was not representing a RQ
because it was the avg cost of scanning the full domain. And we were
comparing it with the average idle time (weighted by few factors).
And this cost was impacted by the fact that the scan can return early
because it found a cpu. This has advantage and drawback but at least
stays coherent in what we are comparing

Peter's patch wants to move on per rq avg scan cost. And what you're
proposing is to add a magic heuristic to bias the per rq which at the
end makes this value just an opaque metric.

If we really want to keep the impact of early return than IMO we
should stay on a full domain scan level instead of a per rq.

Also, there is another problem (that I'm investigating)  which is that
this_rq()->avg_idle is stalled when your cpu is busy. Which means that
this avg_idle can just be a very old and meaningless value. I think
that we should decay it periodically to reflect there is less and less
idle time (in fact no more)  on this busy CPU that never goes to idle.
If a cpu was idle for a long period but then a long running task
starts, the avg_idle will stay stalled to the large value which is
becoming less and less relevant.
At the opposite, a cpu with a short running/idle period task will have
a lower avg_idle whereas it is more often idle.

Another thing that worries me, is that we use the avg_idle of the
local cpu, which is obviously not idle otherwise it would have been
selected, to decide how much time we should spend on looking for
another idle CPU. I'm not sure that's the right metrics to use
especially with a possibly stalled value.


> can problems with the depth of the scan conducted. Previously the "cost"
> of a successful scan was 0 so successful scans allowed deeper scans in
> the near future. This partially illustrates the problem.
>
>                           5.11.0-rc2             5.11.0-rc2             5.11.0-rc2
>                        baseline-v2r1          acctscan-v2r1           altscan-v2r8
> Hmean     1        429.47 (   0.00%)      420.90 *  -2.00%*      414.27 *  -3.54%*
> Hmean     2        709.39 (   0.00%)      796.05 *  12.22%*      791.98 *  11.64%*
> Hmean     4       1449.19 (   0.00%)     1445.14 (  -0.28%)     1319.09 *  -8.98%*
> Hmean     8       2765.65 (   0.00%)     2750.07 *  -0.56%*     2756.17 *  -0.34%*
> Hmean     16      5158.47 (   0.00%)     5056.59 *  -1.97%*     5030.67 *  -2.48%*
> Hmean     32      8969.96 (   0.00%)     8796.96 *  -1.93%*     8768.34 *  -2.25%*
> Hmean     64     11210.05 (   0.00%)     9910.39 * -11.59%*    11073.42 *  -1.22%*
> Hmean     128    17978.21 (   0.00%)    17031.41 *  -5.27%*    17037.76 *  -5.23%*
> Hmean     256    16143.32 (   0.00%)    15636.59 *  -3.14%*    15761.12 *  -2.37%*
> Hmean     320    16388.59 (   0.00%)    15591.78 *  -4.86%*    15588.85 *  -4.88%*
>
> Note the impact of Peters patch (accescan-v2r1) for 64 threads. The
> machine is 2-socket (40 cores, 80 threads) so 64 is the load is
> balancing between two domains (load balancing vs wakeup migrations).
> altscan is my suggested patch on top and with Peter's patch, there is a
> 11.59% regression that is negligible with my patch on top.
>
> The impact is machine-specific or specific to the CPU generation. Here
> is just comparing just the suggested alteration on a slightly older
> generation.
>
>                           5.11.0-rc2             5.11.0-rc2
>                        acctscan-v2r1           altscan-v2r8
> Hmean     1        155.44 (   0.00%)      183.32 *  17.94%*
> Hmean     2        445.46 (   0.00%)      548.51 *  23.13%*
> Hmean     4       1080.25 (   0.00%)     1112.49 *   2.98%*
> Hmean     8       2253.48 (   0.00%)     2457.46 *   9.05%*
> Hmean     16      3996.73 (   0.00%)     4244.59 *   6.20%*
> Hmean     32      5318.93 (   0.00%)     5798.17 *   9.01%*
> Hmean     64      9301.55 (   0.00%)     9563.24 *   2.81%*
> Hmean     128     8560.89 (   0.00%)     8873.72 *   3.65%*
> Hmean     192     8526.92 (   0.00%)     8843.43 *   3.71%*
>
> And another 2-socket machine on a newer generation.
>
> Hmean     1        551.16 (   0.00%)      503.75 *  -8.60%*
> Hmean     2       1074.19 (   0.00%)     1078.08 *   0.36%*
> Hmean     4       2024.72 (   0.00%)     2049.29 *   1.21%*
> Hmean     8       3762.49 (   0.00%)     4002.24 *   6.37%*
> Hmean     16      6589.98 (   0.00%)     6688.21 *   1.49%*
> Hmean     32     10080.23 (   0.00%)    10270.34 *   1.89%*
> Hmean     64     11349.16 (   0.00%)    12452.68 *   9.72%*
> Hmean     128    21670.93 (   0.00%)    21823.70 *   0.70%*
> Hmean     256    20605.62 (   0.00%)    20615.01 *   0.05%*
> Hmean     320    20974.29 (   0.00%)    20565.11 *  -1.95%*
>
> For hackbench with processes communicating via pipes on the first
> machine
>
>                           5.11.0-rc2             5.11.0-rc2
>                        acctscan-v2r1           altscan-v2r8
> Amean     1        0.3927 (   0.00%)      0.3943 (  -0.42%)
> Amean     4        0.9247 (   0.00%)      0.9267 (  -0.22%)
> Amean     7        1.4587 (   0.00%)      1.5147 *  -3.84%*
> Amean     12       2.3637 (   0.00%)      2.4507 *  -3.68%*
> Amean     21       4.0700 (   0.00%)      4.1757 *  -2.60%*
> Amean     30       5.6573 (   0.00%)      5.7390 *  -1.44%*
> Amean     48       8.9037 (   0.00%)      8.8053 *   1.10%*
> Amean     79      14.9190 (   0.00%)     14.4360 *   3.24%*
> Amean     110     22.5703 (   0.00%)     21.9210 (   2.88%)
> Amean     141     29.2400 (   0.00%)     28.0110 *   4.20%*
> Amean     172     36.3720 (   0.00%)     34.7963 (   4.33%)
> Amean     203     43.5783 (   0.00%)     42.5537 *   2.35%*
> Amean     234     50.3653 (   0.00%)     47.3463 *   5.99%*
> Amean     265     57.6153 (   0.00%)     55.6247 *   3.46%*
> Amean     296     62.7370 (   0.00%)     62.0720 (   1.06%)
>
> Adjusting the scan cost for successes is neither a universal win or
> failure but it's closer to historical behaviour and the strict
> accounting does hit corner cases.  If a deep scan is finding an idle CPU,
> it makes some sense to continue scanning deeply by adjusting the weight
> instead of prematurely failing.
>
> The testing of the full series previously showed that some loads never
> recovered from side-effects of the first patch and the last patch in the
> series introduced new problems of its own. Hence, I would like to limit
> the negative impact of the first patch and, if necessary, cut the last
> patch altogether.
>
> --
> Mel Gorman
> SUSE Labs
