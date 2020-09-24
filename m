Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 760AC277421
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 16:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbgIXOgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 10:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbgIXOgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 10:36:31 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DE6C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 07:36:31 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id w7so2028946pfi.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 07:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/t8PieN/eFPss7Qpw0jjxSzLNSWlXorRRsXxHO8bkrw=;
        b=B5rOfAQGAlGeVxwr/0IYp/Z9JGcqYTy72x+HQEwDfYQWEybUAgy5tukLTTH7WtxQan
         OPiu/ZlDVa62RVJi7WPmsJS8RzFHcrH4wV0cS4nDJFxT/OlTuw8/01/Bo1anPFZgbtcu
         dPXqMy8YcQPK7f3t+qx9DbRlekyLuKIuyHfPFACkrrmfop/W9vQsPuj0LwRySTR/++Bq
         J8LNbND9KcnKgBpxRVGT2uXTkHp1mpnEzgPFo6/FtFqpWiehDdtcBY2w0utkHgAm+Kwf
         KY4goQvP9EEJ11U3AkUcPUNmQDEIN9JpFbD83oPLXkgJyoTx9wZ+xHJCx9j4zLHMgKQu
         pPgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=/t8PieN/eFPss7Qpw0jjxSzLNSWlXorRRsXxHO8bkrw=;
        b=r/xpMGcUQNxmcDF8GnPJDlJbRyjxUQDuxxQTQKftZtgowa++z7WxRZiXVT4zGM4q6X
         GoGF1SztlHqni9yV6cManSksT8G50CyO031WEJRU4Wty0b1m1vSJc8SCqaolbum9Q94F
         AxUoPOnn7ajFr1f6I8gi/aULRfTB/a6pQeo3tvIs3Dg3qMpLRh5PobvjjY58Oui8sJQv
         ca8KWPOY6CpImYn695dh9Thv43fx8Z/4dqvMdZul82CjnPzedzuTPTwph7N3NIIRsa6A
         KzGMhqZ+FBB1GhV9oBfEU9yr58qDNdGgD1mW4OPL9dew4v1VesgWf4uZqmr2GR5DYsUf
         YSwA==
X-Gm-Message-State: AOAM530UxQBenjvm5FkKfIUMQ34dKEFo7ssGAoMlUvUWEEZOZ7hZCYd1
        tq1GbNFeHVgRczPVXoS7sEM=
X-Google-Smtp-Source: ABdhPJy9e27mTknYv36d4JU7GC59hiPiimY7cgOXFCU24o+AeS3RgImChNT3If7MjETsBzgL9tuwBg==
X-Received: by 2002:a62:7fcf:0:b029:151:15e0:ab82 with SMTP id a198-20020a627fcf0000b029015115e0ab82mr4825933pfd.80.1600958190712;
        Thu, 24 Sep 2020 07:36:30 -0700 (PDT)
Received: from google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id y1sm3341813pgy.0.2020.09.24.07.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 07:36:29 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
Date:   Thu, 24 Sep 2020 23:36:23 +0900
From:   Namhyung Kim <namhyung@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <andi@firstfloor.org>,
        Li Bin <huawei.libin@huawei.com>, Wei Li <liwei391@huawei.com>,
        Ingo Molnar <mingo@redhat.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] perf stat: Fix segfault when counting armv8_pmu
 events
Message-ID: <20200924143623.GA357648@google.com>
References: <20200922031346.15051-1-liwei391@huawei.com>
 <20200922031346.15051-2-liwei391@huawei.com>
 <20200923054426.GG2893484@krava>
 <CAM9d7cjLKosv97fEUCATVTr0mkZL_W5oDzBSxde70RhOeZ=6fg@mail.gmail.com>
 <20200923140747.GN2893484@krava>
 <CAM9d7cgT4qLH0mPM1nTRa-FYwjMOc4LOCUD_X0r21hdUUVLpRA@mail.gmail.com>
 <20200923201900.GQ2893484@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200923201900.GQ2893484@krava>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 10:19:00PM +0200, Jiri Olsa wrote:
> On Wed, Sep 23, 2020 at 11:15:06PM +0900, Namhyung Kim wrote:
> > I think the problem is that armv8_pmu has a cpumask,
> > and the user requested per-task events.
> > 
> > The code tried to open the event with a dummy cpu map
> > since it's not a cpu event, but the pmu has cpu map and
> > it's passed to evsel.  So there's confusion somewhere
> > whether it should use evsel->cpus or a dummy map.
> 
> you're right, I have following cpus file in pmu:
> 
>   # cat /sys/devices/armv8_pmuv3_0/cpus 
>   0-3
> 
> covering all the cpus.. and once you have cpumask/cpus file,
> you're system wide by default in current code, but we should
> not crash ;-)
> 
> I tried to cover this case in patch below and I probably broke
> some other use cases, but perhaps we could allow to open counters
> per cpus for given workload
> 
> I'll try to look at this more tomorrow

I'm thinking about a different approach, we can ignore cpu map
for the ARM cpu PMU and use the dummy, not tested ;-)

Thanks
Namhyung


diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index 2208444ecb44..cfcdbd7be066 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -45,6 +45,9 @@ static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
        if (!evsel->own_cpus || evlist->has_user_cpus) {
                perf_cpu_map__put(evsel->cpus);
                evsel->cpus = perf_cpu_map__get(evlist->cpus);
+       } else if (!evsel->system_wide && perf_cpu_map__empty(evlist->cpus)) {
+               perf_cpu_map__put(evsel->cpus);
+               evsel->cpus = perf_cpu_map__get(evlist->cpus);
        } else if (evsel->cpus != evsel->own_cpus) {
                perf_cpu_map__put(evsel->cpus);
                evsel->cpus = perf_cpu_map__get(evsel->own_cpus);
