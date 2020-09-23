Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30F8C2759A7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 16:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgIWOPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 10:15:24 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51021 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIWOPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 10:15:20 -0400
Received: by mail-wm1-f67.google.com with SMTP id e17so208268wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 07:15:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g1cxuReaAgVqr4A+WOonKaUioyziBa2g1hewHvpcxLk=;
        b=SHWj34h9g3CF9CdR79WkjfeDQ4Iwx/QAOQa2VbK4w5wpawNM3Re3UCxTNM8y3EYTH/
         JknkUkEJ96arpDvLN9wvvjsS2PbQsy9iLiaR3j5sGHRB73/9/vu/BP3pfJ5Nsq7L3cIC
         nUPZeoKvAECGS67JekVsxo/uvmwVSvhy1p4GE9YZbBv+2y9aYO/VJ6YxgZXUlafTkVQl
         fn8UvNF5csp9xlmS06mZU0tYrVQpB1zEALgokR88lC3plbvRW1AThLtmgmtmUZnOG6S1
         gC0/uSgjWwrT5uD2tiNOdEXb+HCsEkst1akjZXHSpNBwvsoK+P24qGWJA9pVsY3A0VKP
         mpdQ==
X-Gm-Message-State: AOAM530ZutMPMC+rbRsXJ2FtIIgLkh1d48hjq7HFAu5dVW3HFOFr1d5z
        Trdt6Qh4DcOfXd9tFnaiZK/Sk39Twu6JejKFIvA=
X-Google-Smtp-Source: ABdhPJzcSqnvkWXYITymboubIN/JRvpKUyfAcGCMHXjD2BwYMJRrBIx1IL6ujrb+484it8R+WGzny3Zn4sz3QHR9oLk=
X-Received: by 2002:a1c:6341:: with SMTP id x62mr6776560wmb.70.1600870517981;
 Wed, 23 Sep 2020 07:15:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200922031346.15051-1-liwei391@huawei.com> <20200922031346.15051-2-liwei391@huawei.com>
 <20200923054426.GG2893484@krava> <CAM9d7cjLKosv97fEUCATVTr0mkZL_W5oDzBSxde70RhOeZ=6fg@mail.gmail.com>
 <20200923140747.GN2893484@krava>
In-Reply-To: <20200923140747.GN2893484@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 23 Sep 2020 23:15:06 +0900
Message-ID: <CAM9d7cgT4qLH0mPM1nTRa-FYwjMOc4LOCUD_X0r21hdUUVLpRA@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf stat: Fix segfault when counting armv8_pmu events
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Wei Li <liwei391@huawei.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Li Bin <huawei.libin@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 11:08 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Wed, Sep 23, 2020 at 10:49:52PM +0900, Namhyung Kim wrote:
> > On Wed, Sep 23, 2020 at 2:44 PM Jiri Olsa <jolsa@redhat.com> wrote:
> > >
> > > On Tue, Sep 22, 2020 at 11:13:45AM +0800, Wei Li wrote:
> > > > When executing perf stat with armv8_pmu events with a workload, it will
> > > > report a segfault as result.
> > >
> > > please share the perf stat command line you see that segfault for
> >
> > It seems the description in the patch 0/2 already has it:
> >
> >   [root@localhost hulk]# tools/perf/perf stat  -e
> > armv8_pmuv3_0/ll_cache_rd/,armv8_pmuv3_0/ll_cache_miss_rd/ ls >
> > /dev/null
> >   Segmentation fault
>
> yea I found it, but can't reproduce it.. I see the issue from
> patch 2, but not sure what's the problem so far

I think the problem is that armv8_pmu has a cpumask,
and the user requested per-task events.

The code tried to open the event with a dummy cpu map
since it's not a cpu event, but the pmu has cpu map and
it's passed to evsel.  So there's confusion somewhere
whether it should use evsel->cpus or a dummy map.

Thanks
Namhyung
