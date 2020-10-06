Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 704C3284651
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 08:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgJFGvR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 6 Oct 2020 02:51:17 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3625 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725962AbgJFGvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 02:51:17 -0400
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id A5E697BFA06D529D5A98;
        Tue,  6 Oct 2020 14:51:14 +0800 (CST)
Received: from dggema773-chm.china.huawei.com (10.1.198.217) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Tue, 6 Oct 2020 14:51:14 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggema773-chm.china.huawei.com (10.1.198.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Tue, 6 Oct 2020 14:51:13 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.1913.007;
 Tue, 6 Oct 2020 14:51:14 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        "liwei (GF)" <liwei391@huawei.com>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Andi Kleen" <andi@firstfloor.org>,
        "Libin (Huawei)" <huawei.libin@huawei.com>,
        Ingo Molnar <mingo@redhat.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 1/2] perf stat: Fix segfault when counting armv8_pmu
 events
Thread-Topic: [PATCH 1/2] perf stat: Fix segfault when counting armv8_pmu
 events
Thread-Index: AQHWkI6N3p3Bu2WQrU64XEFw+dtch6l1MfgAgACHoQCAAAUBgIAAAgsAgABlrQCAATKbgIAMNI4AgAaoV1A=
Date:   Tue, 6 Oct 2020 06:51:14 +0000
Message-ID: <94f906e548db4534be577815e7cada01@hisilicon.com>
References: <20200922031346.15051-1-liwei391@huawei.com>
 <20200922031346.15051-2-liwei391@huawei.com> <20200923054426.GG2893484@krava>
 <CAM9d7cjLKosv97fEUCATVTr0mkZL_W5oDzBSxde70RhOeZ=6fg@mail.gmail.com>
 <20200923140747.GN2893484@krava>
 <CAM9d7cgT4qLH0mPM1nTRa-FYwjMOc4LOCUD_X0r21hdUUVLpRA@mail.gmail.com>
 <20200923201900.GQ2893484@krava> <20200924143623.GA357648@google.com>
 <20201002085936.GE3999500@krava>
In-Reply-To: <20201002085936.GE3999500@krava>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.200.32]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Jiri Olsa [mailto:jolsa@redhat.com]
> Sent: Friday, October 2, 2020 10:00 PM
> To: Namhyung Kim <namhyung@kernel.org>; liwei (GF)
> <liwei391@huawei.com>
> Cc: Mark Rutland <mark.rutland@arm.com>; Andi Kleen <ak@linux.intel.com>;
> Alexander Shishkin <alexander.shishkin@linux.intel.com>; Alexey Budankov
> <alexey.budankov@linux.intel.com>; Adrian Hunter
> <adrian.hunter@intel.com>; Arnaldo Carvalho de Melo <acme@kernel.org>;
> linux-kernel <linux-kernel@vger.kernel.org>; Peter Zijlstra
> <peterz@infradead.org>; Andi Kleen <andi@firstfloor.org>; Libin (Huawei)
> <huawei.libin@huawei.com>; Ingo Molnar <mingo@redhat.com>;
> linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH 1/2] perf stat: Fix segfault when counting armv8_pmu
> events
> 
> On Thu, Sep 24, 2020 at 11:36:23PM +0900, Namhyung Kim wrote:
> > On Wed, Sep 23, 2020 at 10:19:00PM +0200, Jiri Olsa wrote:
> > > On Wed, Sep 23, 2020 at 11:15:06PM +0900, Namhyung Kim wrote:
> > > > I think the problem is that armv8_pmu has a cpumask,
> > > > and the user requested per-task events.
> > > >
> > > > The code tried to open the event with a dummy cpu map
> > > > since it's not a cpu event, but the pmu has cpu map and
> > > > it's passed to evsel.  So there's confusion somewhere
> > > > whether it should use evsel->cpus or a dummy map.
> > >
> > > you're right, I have following cpus file in pmu:
> > >
> > >   # cat /sys/devices/armv8_pmuv3_0/cpus
> > >   0-3
> > >
> > > covering all the cpus.. and once you have cpumask/cpus file,
> > > you're system wide by default in current code, but we should
> > > not crash ;-)
> > >
> > > I tried to cover this case in patch below and I probably broke
> > > some other use cases, but perhaps we could allow to open counters
> > > per cpus for given workload
> > >
> > > I'll try to look at this more tomorrow
> >
> > I'm thinking about a different approach, we can ignore cpu map
> > for the ARM cpu PMU and use the dummy, not tested ;-)
> >
> > Thanks
> > Namhyung
> >
> >
> > diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> > index 2208444ecb44..cfcdbd7be066 100644
> > --- a/tools/lib/perf/evlist.c
> > +++ b/tools/lib/perf/evlist.c
> > @@ -45,6 +45,9 @@ static void __perf_evlist__propagate_maps(struct
> perf_evlist *evlist,
> >         if (!evsel->own_cpus || evlist->has_user_cpus) {
> >                 perf_cpu_map__put(evsel->cpus);
> >                 evsel->cpus = perf_cpu_map__get(evlist->cpus);
> > +       } else if (!evsel->system_wide &&
> perf_cpu_map__empty(evlist->cpus)) {
> > +               perf_cpu_map__put(evsel->cpus);
> > +               evsel->cpus = perf_cpu_map__get(evlist->cpus);
> >         } else if (evsel->cpus != evsel->own_cpus) {
> >                 perf_cpu_map__put(evsel->cpus);
> >                 evsel->cpus = perf_cpu_map__get(evsel->own_cpus);
> >
> 
> Wei Li,
> is this fixing your problem?

As I have seen the same crash and suggested another patch:
[PATCH] perf evlist: fix memory corruption for Kernel PMU event
https://lore.kernel.org/lkml/20201001115729.27116-1-song.bao.hua@hisilicon.com/

Also, I have tested Namhyung Kim's patch on ARM64. It does fix the crash for me. So:
Tested-by: Barry Song <song.bao.hua@hisilicon.com>

Please put the below fixes-tag in commit log:
Fixes: 7736627b865d ("perf stat: Use affinity for closing file descriptors")

Thanks
Barry
