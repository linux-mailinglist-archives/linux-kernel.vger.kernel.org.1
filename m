Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDED32761E5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 22:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgIWUTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 16:19:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22071 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726498AbgIWUTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 16:19:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600892352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DHTSvTADLG6e+v7rV8YcXc8m4s3QJCzEI+irlAKTENE=;
        b=cRryKQFOFkw/XUUhvTZK5ljdVTRoiRk7cvsqu1/RPUkpofIqf+LTBGd39CHVYBZ07vs3Xu
        WB6Ne4qeXuOwk/+dVhzadjXJBo4aySATDxaq9Pl7AkRhcW+31FD/fy2kH53xFhD16zPYiA
        40YwnV6cfkmOMNMDdD/qAyKGazG5rAI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-538-HFmRnXl8No-YwcZFXE-1Mw-1; Wed, 23 Sep 2020 16:19:08 -0400
X-MC-Unique: HFmRnXl8No-YwcZFXE-1Mw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A0F061007B1D;
        Wed, 23 Sep 2020 20:19:06 +0000 (UTC)
Received: from krava (ovpn-112-117.ams2.redhat.com [10.36.112.117])
        by smtp.corp.redhat.com (Postfix) with SMTP id 8A79960BF1;
        Wed, 23 Sep 2020 20:19:01 +0000 (UTC)
Date:   Wed, 23 Sep 2020 22:19:00 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Wei Li <liwei391@huawei.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Andi Kleen <andi@firstfloor.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Li Bin <huawei.libin@huawei.com>
Subject: Re: [PATCH 1/2] perf stat: Fix segfault when counting armv8_pmu
 events
Message-ID: <20200923201900.GQ2893484@krava>
References: <20200922031346.15051-1-liwei391@huawei.com>
 <20200922031346.15051-2-liwei391@huawei.com>
 <20200923054426.GG2893484@krava>
 <CAM9d7cjLKosv97fEUCATVTr0mkZL_W5oDzBSxde70RhOeZ=6fg@mail.gmail.com>
 <20200923140747.GN2893484@krava>
 <CAM9d7cgT4qLH0mPM1nTRa-FYwjMOc4LOCUD_X0r21hdUUVLpRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cgT4qLH0mPM1nTRa-FYwjMOc4LOCUD_X0r21hdUUVLpRA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 11:15:06PM +0900, Namhyung Kim wrote:
> On Wed, Sep 23, 2020 at 11:08 PM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Wed, Sep 23, 2020 at 10:49:52PM +0900, Namhyung Kim wrote:
> > > On Wed, Sep 23, 2020 at 2:44 PM Jiri Olsa <jolsa@redhat.com> wrote:
> > > >
> > > > On Tue, Sep 22, 2020 at 11:13:45AM +0800, Wei Li wrote:
> > > > > When executing perf stat with armv8_pmu events with a workload, it will
> > > > > report a segfault as result.
> > > >
> > > > please share the perf stat command line you see that segfault for
> > >
> > > It seems the description in the patch 0/2 already has it:
> > >
> > >   [root@localhost hulk]# tools/perf/perf stat  -e
> > > armv8_pmuv3_0/ll_cache_rd/,armv8_pmuv3_0/ll_cache_miss_rd/ ls >
> > > /dev/null
> > >   Segmentation fault
> >
> > yea I found it, but can't reproduce it.. I see the issue from
> > patch 2, but not sure what's the problem so far
> 
> I think the problem is that armv8_pmu has a cpumask,
> and the user requested per-task events.
> 
> The code tried to open the event with a dummy cpu map
> since it's not a cpu event, but the pmu has cpu map and
> it's passed to evsel.  So there's confusion somewhere
> whether it should use evsel->cpus or a dummy map.

you're right, I have following cpus file in pmu:

  # cat /sys/devices/armv8_pmuv3_0/cpus 
  0-3

covering all the cpus.. and once you have cpumask/cpus file,
you're system wide by default in current code, but we should
not crash ;-)

I tried to cover this case in patch below and I probably broke
some other use cases, but perhaps we could allow to open counters
per cpus for given workload

I'll try to look at this more tomorrow

jirka


---
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 7f8d756d9408..0c7f16a673c2 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -379,12 +379,7 @@ static int read_affinity_counters(struct timespec *rs)
 	if (affinity__setup(&affinity) < 0)
 		return -1;
 
-	ncpus = perf_cpu_map__nr(evsel_list->core.all_cpus);
-	if (!target__has_cpu(&target) || target__has_per_thread(&target))
-		ncpus = 1;
 	evlist__for_each_cpu(evsel_list, i, cpu) {
-		if (i >= ncpus)
-			break;
 		affinity__set(&affinity, cpu);
 
 		evlist__for_each_entry(evsel_list, counter) {
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index fd865002cbbd..ef525eb2f619 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1861,6 +1861,16 @@ void evsel__close(struct evsel *evsel)
 	perf_evsel__free_id(&evsel->core);
 }
 
+int evsel__open_threads_per_cpu(struct evsel *evsel, struct perf_thread_map *threads,
+				struct perf_cpu_map *cpus, int cpu)
+{
+	if (cpu == -1)
+		return evsel__open_cpu(evsel, cpus, threads, 0,
+					cpus ? cpus->nr : 1);
+
+	return evsel__open_cpu(evsel, cpus, threads, cpu, cpu + 1);
+}
+
 int evsel__open_per_cpu(struct evsel *evsel, struct perf_cpu_map *cpus, int cpu)
 {
 	if (cpu == -1)
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 35e3f6d66085..1d055699bd1f 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -231,6 +231,8 @@ int evsel__enable(struct evsel *evsel);
 int evsel__disable(struct evsel *evsel);
 int evsel__disable_cpu(struct evsel *evsel, int cpu);
 
+int evsel__open_threads_per_cpu(struct evsel *evsel, struct perf_thread_map *threads,
+				struct perf_cpu_map *cpus, int cpu);
 int evsel__open_per_cpu(struct evsel *evsel, struct perf_cpu_map *cpus, int cpu);
 int evsel__open_per_thread(struct evsel *evsel, struct perf_thread_map *threads);
 int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index cdb154381a87..2b17f1315cfb 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -560,6 +560,11 @@ int create_perf_stat_counter(struct evsel *evsel,
 			attr->enable_on_exec = 1;
 	}
 
+	if (evsel->core.own_cpus && evsel->core.threads) {
+		return evsel__open_threads_per_cpu(evsel, evsel->core.threads,
+						   evsel__cpus(evsel), cpu);
+	}
+
 	if (target__has_cpu(target) && !target__has_per_thread(target))
 		return evsel__open_per_cpu(evsel, evsel__cpus(evsel), cpu);
 

