Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 360E6275967
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 16:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgIWOIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 10:08:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50263 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726130AbgIWOIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 10:08:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600870079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=it2WE8HSky4eTkM1IOAj4PM/27T11fCRsFPmvTOl5jQ=;
        b=iTTroEISRTrnGDcVG5DbPjbES88pDUh3ByET0Opgk8mEXPiq4xRqqKtKNM4RuLOAblORYY
        NWaIppAWC8vA3iifAdpS14AfEy2qO3V0rpSWLe9Yki7csSmqXGMs6Uj3L8XvFyDtzh8aTr
        L0Tw5smCBtLdIGwiG22DkjdIIQP9qIU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-547-yEBWGn5SPUSTUFLSvc4jVw-1; Wed, 23 Sep 2020 10:07:55 -0400
X-MC-Unique: yEBWGn5SPUSTUFLSvc4jVw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76B131007B04;
        Wed, 23 Sep 2020 14:07:53 +0000 (UTC)
Received: from krava (unknown [10.40.192.120])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1E72419C4F;
        Wed, 23 Sep 2020 14:07:48 +0000 (UTC)
Date:   Wed, 23 Sep 2020 16:07:47 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
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
Subject: Re: [PATCH 1/2] perf stat: Fix segfault when counting armv8_pmu
 events
Message-ID: <20200923140747.GN2893484@krava>
References: <20200922031346.15051-1-liwei391@huawei.com>
 <20200922031346.15051-2-liwei391@huawei.com>
 <20200923054426.GG2893484@krava>
 <CAM9d7cjLKosv97fEUCATVTr0mkZL_W5oDzBSxde70RhOeZ=6fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cjLKosv97fEUCATVTr0mkZL_W5oDzBSxde70RhOeZ=6fg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 10:49:52PM +0900, Namhyung Kim wrote:
> On Wed, Sep 23, 2020 at 2:44 PM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Tue, Sep 22, 2020 at 11:13:45AM +0800, Wei Li wrote:
> > > When executing perf stat with armv8_pmu events with a workload, it will
> > > report a segfault as result.
> >
> > please share the perf stat command line you see that segfault for
> 
> It seems the description in the patch 0/2 already has it:
> 
>   [root@localhost hulk]# tools/perf/perf stat  -e
> armv8_pmuv3_0/ll_cache_rd/,armv8_pmuv3_0/ll_cache_miss_rd/ ls >
> /dev/null
>   Segmentation fault

yea I found it, but can't reproduce it.. I see the issue from
patch 2, but not sure what's the problem so far

jirka

> 
> Thanks
> Namhyun
> 
> 
> >
> > thanks,
> > jirka
> >
> > >
> > > (gdb) bt
> > > #0  0x0000000000603fc8 in perf_evsel__close_fd_cpu (evsel=<optimized out>,
> > >     cpu=<optimized out>) at evsel.c:122
> > > #1  perf_evsel__close_cpu (evsel=evsel@entry=0x716e950, cpu=7) at evsel.c:156
> > > #2  0x00000000004d4718 in evlist__close (evlist=0x70a7cb0) at util/evlist.c:1242
> > > #3  0x0000000000453404 in __run_perf_stat (argc=3, argc@entry=1, argv=0x30,
> > >     argv@entry=0xfffffaea2f90, run_idx=119, run_idx@entry=1701998435)
> > >     at builtin-stat.c:929
> > > #4  0x0000000000455058 in run_perf_stat (run_idx=1701998435, argv=0xfffffaea2f90,
> > >     argc=1) at builtin-stat.c:947
> > > #5  cmd_stat (argc=1, argv=0xfffffaea2f90) at builtin-stat.c:2357
> > > #6  0x00000000004bb888 in run_builtin (p=p@entry=0x9764b8 <commands+288>,
> > >     argc=argc@entry=4, argv=argv@entry=0xfffffaea2f90) at perf.c:312
> > > #7  0x00000000004bbb54 in handle_internal_command (argc=argc@entry=4,
> > >     argv=argv@entry=0xfffffaea2f90) at perf.c:364
> > > #8  0x0000000000435378 in run_argv (argcp=<synthetic pointer>,
> > >     argv=<synthetic pointer>) at perf.c:408
> > > #9  main (argc=4, argv=0xfffffaea2f90) at perf.c:538
> > >
> > > After debugging, i found the root reason is that the xyarray fd is created
> > > by evsel__open_per_thread() ignoring the cpu passed in
> > > create_perf_stat_counter(), while the evsel' cpumap is assigned as the
> > > corresponding PMU's cpumap in __add_event(). Thus, the xyarray fd is created
> > > with ncpus of dummy cpumap and an out of bounds 'cpu' index will be used in
> > > perf_evsel__close_fd_cpu().
> > >
> > > To address this, add a flag to mark this situation and avoid using the
> > > affinity technique when closing/enabling/disabling events.
> > >
> > > Fixes: 7736627b865d ("perf stat: Use affinity for closing file descriptors")
> > > Fixes: 704e2f5b700d ("perf stat: Use affinity for enabling/disabling events")
> > > Signed-off-by: Wei Li <liwei391@huawei.com>
> > > ---
> 

