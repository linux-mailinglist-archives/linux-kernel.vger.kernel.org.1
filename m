Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5EF227591C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 15:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgIWNuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 09:50:06 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51140 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbgIWNuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 09:50:05 -0400
Received: by mail-wm1-f65.google.com with SMTP id e17so120142wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 06:50:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/j8gE98Lnx80ytn5eWpBHMVhOo7wOL6OTe60FsoJGZ8=;
        b=bAh7zi4LvmxJQz0aU/b/IMpTEFaVb3zxx9LMXM/BS5I65CcW6QiFsdlZo5iR9Z0qE3
         nmskrG823vsMI3gD2xvEE247at3hfvGLm3n/SDETJ+niGAGVO++SD2FWovJDAUAx4BZF
         M3wc1XlsGV+g1fxZT2uxCAwLr+mHTgOBDW0u02TTP7E/x0i2qlkZ+zRiKmr4eV0UkBBb
         uFBuV62NxhpcBjV44snDQBbixhQ62z77w/yBrSQeecQL/kCMgFjki0xOpF4g+7qHNaXx
         MHKgRJX7o6WASYXIC/0/Tg539sLXFfr98OQfFBwoCjpQnfnHPhvWq7Np8BsK/du29oqv
         sBhw==
X-Gm-Message-State: AOAM530V1p8PDXVdayOu5BXfc+G6TZuLLrGx+8O3RdMU8x6CYL2ts798
        5h8OE/3nEwD/4PfeAGOEqqOqMZap8uzuIGJ4pDY=
X-Google-Smtp-Source: ABdhPJz5H5bwW3C7+pb6qcmjrh5dnDmWi67THx2mSecqmY9wWp0dzJL4G+l1uqs/xfjZ2wfxEZE+IZTSdZPLvgaCHGc=
X-Received: by 2002:a1c:7215:: with SMTP id n21mr7023115wmc.154.1600869003674;
 Wed, 23 Sep 2020 06:50:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200922031346.15051-1-liwei391@huawei.com> <20200922031346.15051-2-liwei391@huawei.com>
 <20200923054426.GG2893484@krava>
In-Reply-To: <20200923054426.GG2893484@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 23 Sep 2020 22:49:52 +0900
Message-ID: <CAM9d7cjLKosv97fEUCATVTr0mkZL_W5oDzBSxde70RhOeZ=6fg@mail.gmail.com>
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

On Wed, Sep 23, 2020 at 2:44 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Tue, Sep 22, 2020 at 11:13:45AM +0800, Wei Li wrote:
> > When executing perf stat with armv8_pmu events with a workload, it will
> > report a segfault as result.
>
> please share the perf stat command line you see that segfault for

It seems the description in the patch 0/2 already has it:

  [root@localhost hulk]# tools/perf/perf stat  -e
armv8_pmuv3_0/ll_cache_rd/,armv8_pmuv3_0/ll_cache_miss_rd/ ls >
/dev/null
  Segmentation fault

Thanks
Namhyun


>
> thanks,
> jirka
>
> >
> > (gdb) bt
> > #0  0x0000000000603fc8 in perf_evsel__close_fd_cpu (evsel=<optimized out>,
> >     cpu=<optimized out>) at evsel.c:122
> > #1  perf_evsel__close_cpu (evsel=evsel@entry=0x716e950, cpu=7) at evsel.c:156
> > #2  0x00000000004d4718 in evlist__close (evlist=0x70a7cb0) at util/evlist.c:1242
> > #3  0x0000000000453404 in __run_perf_stat (argc=3, argc@entry=1, argv=0x30,
> >     argv@entry=0xfffffaea2f90, run_idx=119, run_idx@entry=1701998435)
> >     at builtin-stat.c:929
> > #4  0x0000000000455058 in run_perf_stat (run_idx=1701998435, argv=0xfffffaea2f90,
> >     argc=1) at builtin-stat.c:947
> > #5  cmd_stat (argc=1, argv=0xfffffaea2f90) at builtin-stat.c:2357
> > #6  0x00000000004bb888 in run_builtin (p=p@entry=0x9764b8 <commands+288>,
> >     argc=argc@entry=4, argv=argv@entry=0xfffffaea2f90) at perf.c:312
> > #7  0x00000000004bbb54 in handle_internal_command (argc=argc@entry=4,
> >     argv=argv@entry=0xfffffaea2f90) at perf.c:364
> > #8  0x0000000000435378 in run_argv (argcp=<synthetic pointer>,
> >     argv=<synthetic pointer>) at perf.c:408
> > #9  main (argc=4, argv=0xfffffaea2f90) at perf.c:538
> >
> > After debugging, i found the root reason is that the xyarray fd is created
> > by evsel__open_per_thread() ignoring the cpu passed in
> > create_perf_stat_counter(), while the evsel' cpumap is assigned as the
> > corresponding PMU's cpumap in __add_event(). Thus, the xyarray fd is created
> > with ncpus of dummy cpumap and an out of bounds 'cpu' index will be used in
> > perf_evsel__close_fd_cpu().
> >
> > To address this, add a flag to mark this situation and avoid using the
> > affinity technique when closing/enabling/disabling events.
> >
> > Fixes: 7736627b865d ("perf stat: Use affinity for closing file descriptors")
> > Fixes: 704e2f5b700d ("perf stat: Use affinity for enabling/disabling events")
> > Signed-off-by: Wei Li <liwei391@huawei.com>
> > ---
