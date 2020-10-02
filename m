Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3E1E280F5B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 10:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgJBI7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 04:59:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32006 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725993AbgJBI7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 04:59:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601629186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JY/xYOWXgW3YizpSB7JHHJ7rgxiMthV5yILxf4kE9ow=;
        b=coXGkzvIgHi6yYDqTHfVur1uYIXQn1Y7aQ25CzVmm9tHZwTCxaYBcXGV8C6ZcpvNXlj9tT
        visWW6YDc/qq74DKkNb9ulEQjc8XdtqCmhCPrKBcfQxhGq2ITIHaPs3VkFuH/6C+8eZSl8
        hpJdb21Ycd6oaCg+WGXn94JqMRfBy4w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-589-QzRZ7MVOOASGhdKUHg-GdQ-1; Fri, 02 Oct 2020 04:59:43 -0400
X-MC-Unique: QzRZ7MVOOASGhdKUHg-GdQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D66F010BBED0;
        Fri,  2 Oct 2020 08:59:40 +0000 (UTC)
Received: from krava (unknown [10.40.194.184])
        by smtp.corp.redhat.com (Postfix) with SMTP id 31EEA19C71;
        Fri,  2 Oct 2020 08:59:37 +0000 (UTC)
Date:   Fri, 2 Oct 2020 10:59:36 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>, Wei Li <liwei391@huawei.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <andi@firstfloor.org>,
        Li Bin <huawei.libin@huawei.com>,
        Ingo Molnar <mingo@redhat.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] perf stat: Fix segfault when counting armv8_pmu
 events
Message-ID: <20201002085936.GE3999500@krava>
References: <20200922031346.15051-1-liwei391@huawei.com>
 <20200922031346.15051-2-liwei391@huawei.com>
 <20200923054426.GG2893484@krava>
 <CAM9d7cjLKosv97fEUCATVTr0mkZL_W5oDzBSxde70RhOeZ=6fg@mail.gmail.com>
 <20200923140747.GN2893484@krava>
 <CAM9d7cgT4qLH0mPM1nTRa-FYwjMOc4LOCUD_X0r21hdUUVLpRA@mail.gmail.com>
 <20200923201900.GQ2893484@krava>
 <20200924143623.GA357648@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924143623.GA357648@google.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 11:36:23PM +0900, Namhyung Kim wrote:
> On Wed, Sep 23, 2020 at 10:19:00PM +0200, Jiri Olsa wrote:
> > On Wed, Sep 23, 2020 at 11:15:06PM +0900, Namhyung Kim wrote:
> > > I think the problem is that armv8_pmu has a cpumask,
> > > and the user requested per-task events.
> > > 
> > > The code tried to open the event with a dummy cpu map
> > > since it's not a cpu event, but the pmu has cpu map and
> > > it's passed to evsel.  So there's confusion somewhere
> > > whether it should use evsel->cpus or a dummy map.
> > 
> > you're right, I have following cpus file in pmu:
> > 
> >   # cat /sys/devices/armv8_pmuv3_0/cpus 
> >   0-3
> > 
> > covering all the cpus.. and once you have cpumask/cpus file,
> > you're system wide by default in current code, but we should
> > not crash ;-)
> > 
> > I tried to cover this case in patch below and I probably broke
> > some other use cases, but perhaps we could allow to open counters
> > per cpus for given workload
> > 
> > I'll try to look at this more tomorrow
> 
> I'm thinking about a different approach, we can ignore cpu map
> for the ARM cpu PMU and use the dummy, not tested ;-)
> 
> Thanks
> Namhyung
> 
> 
> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> index 2208444ecb44..cfcdbd7be066 100644
> --- a/tools/lib/perf/evlist.c
> +++ b/tools/lib/perf/evlist.c
> @@ -45,6 +45,9 @@ static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
>         if (!evsel->own_cpus || evlist->has_user_cpus) {
>                 perf_cpu_map__put(evsel->cpus);
>                 evsel->cpus = perf_cpu_map__get(evlist->cpus);
> +       } else if (!evsel->system_wide && perf_cpu_map__empty(evlist->cpus)) {
> +               perf_cpu_map__put(evsel->cpus);
> +               evsel->cpus = perf_cpu_map__get(evlist->cpus);
>         } else if (evsel->cpus != evsel->own_cpus) {
>                 perf_cpu_map__put(evsel->cpus);
>                 evsel->cpus = perf_cpu_map__get(evsel->own_cpus);
> 

Wei Li,
is this fixing your problem?

thanks,
jirka

