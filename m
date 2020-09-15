Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17BCB269DB9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 07:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbgIOFPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 01:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgIOFP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 01:15:29 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED3CC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 22:15:27 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z4so1833149wrr.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 22:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iR9itKcMJs79Q2oWzWkGeUGaEOEnD9YYCRPWnD87X7M=;
        b=jLhkzP3EuzQA7vsDJ+JKyctmtLYh43QXXIDmjrFhKNXAbWTcpveooeLiVzV67JKaBq
         ZAuDTPOKVjrc+gS+4bIM0oEpBWLg/BxQ21XHZSx2jcQFq/KkJ2ep9WMBEJCINvNr7mkU
         7XOZhjASfEV45szPp+z25HoIVzt/2HUoTxuoxq5DYHGT904SlrMDDSl2Rbw4u1b8njZJ
         i2YXQs+CL8t8FPkTMd5is3AhmEYGfethaseiLjyNhxfoILqlWKMQeDiXQw/UXGLz3sSP
         Y3pkQiJOZhG9U9Y60YUSNm1ttMXnRIMVFOIUUy1SrOOU16OlHC6qMvxPi+TloAtUhmLH
         q9fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iR9itKcMJs79Q2oWzWkGeUGaEOEnD9YYCRPWnD87X7M=;
        b=CEQFvVmDrhuX/BzNgZBN9bE7yQyG/LRyV+hTXq3vE1HctW15QS+P3KJEZ1iY5mWXOL
         ZQrqx9uTjsFu8u81UWEDNwgzy/UnPL4sQCYweOWoS+8MJLcima/MZFafhSlcnAXSBjBp
         da46+agy+m/bSGnlf7HZk7AZiizBxC72DT9nlN1fJNNoJPhXRKMtTJjCGHFHNQRh1+up
         D6600M5MdEYr3lrMa723P/n9EHCF03ZxZtJxzV+h3CQFHjnz5GUcrU9L1hwfayfF8LSx
         6fZ+gZiRHQsYCDQzn4yfDKJ7SjlzUzBU40ahzufjWxHyYqCDh8MwBdMxa3Iv/HQop3n/
         c+4Q==
X-Gm-Message-State: AOAM530TL18cKWty5zJ85G5DUWAHlY+KlRF5JaZkdTEFlcQe9zZ04xDy
        QXd/03ZVQeLWK6FHEVGTMw7HixBo255ABIUCznFyBA==
X-Google-Smtp-Source: ABdhPJyjn9OxxCAgBUQF5UsjcS6sExXAF1MB4/6Ha96nJpDjCQdaTVCL47qsg9DAmndT66Dn7HlKiaVpqux5aVX9NQw=
X-Received: by 2002:a5d:608a:: with SMTP id w10mr18581226wrt.48.1600146926452;
 Mon, 14 Sep 2020 22:15:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200915031819.386559-1-namhyung@kernel.org>
In-Reply-To: <20200915031819.386559-1-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 14 Sep 2020 22:15:11 -0700
Message-ID: <CAP-5=fXejVaQa9qfW66cY77qB962+jbe8tT5bsLoOOcFmODnWQ@mail.gmail.com>
Subject: Re: [PATCHSET v2 00/11] perf tools: Fix various memory leaks
To:     Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 8:18 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hello,
>
> I've found and fixed a bunch of memory leaks during perf pmu and
> metric tests with address sanitizer.  Before this, the tests were
> mostly failed due to the leaks since ASAN makes it return non-zero.
>
> Now I'm seeing no error with ASAN like below:
>
>   $ ./perf test pmu metric
>    9: Parse perf pmu format                                 : Ok
>   10: PMU events                                            :
>   10.1: PMU event table sanity                              : Ok
>   10.2: PMU event map aliases                               : Ok
>   10.3: Parsing of PMU event table metrics                  : Skip (some metrics failed)
>   10.4: Parsing of PMU event table metrics with fake PMUs   : Ok
>   67: Parse and process metrics                             : Ok
>
> The failure in 10.3 seems due to parse errors like below:
>
>   Multiple errors dropping message: unknown term 'filter_opc' for pmu 'uncore_cbox_0'
>   (valid terms: event,edge,inv,umask,cmask,config,config1,config2,name,period,freq,
>                 branch_type,time,call-graph,stack-size,no-inherit,inherit,max-stack,
>                 nr,no-overwrite,overwrite,driver-config,percore,aux-output,aux-sample-size)
>
>
>   Parse event failed metric 'DRAM_Parallel_Reads' id 'arb/event=0x80,umask=0x2,thresh=1/'
>     expr 'arb@event\=0x80\,umask\=0x2@ / arb@event\=0x80\,umask\=0x2\,thresh\=1@'
>   Error string 'unknown term 'thresh' for pmu 'uncore_arb'' help
>     'valid terms: event,edge,inv,umask,cmask,config,config1,config2,name,period,freq,
>                   branch_type,time,call-graph,stack-size,no-inherit,inherit,max-stack,
>                   nr,no-overwrite,overwrite,driver-config,percore,aux-output,aux-sample-size'

The 10.3 failure seems to be a problem in the skl metric DRAM_Parallel_Reads:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json?h=perf/core#n319
arb@event\\=0x80\\,umask\\=0x2@ / arb@event\\=0x80\\,umask\\=0x2\\,thresh\\=1@

The test failure message is:
Parse event failed metric 'DRAM_Parallel_Reads' id
'arb/event=0x80,umask=0x2,thresh=1/' expr
'arb@event\=0x80\,umask\=0x2@ /
arb@event\=0x80\,umask\=0x2\,thresh\=1@'
Error string 'unknown term 'thresh' for pmu 'uncore_arb'' help 'valid
terms: event,edge,inv,umask,cmask,config,config1,config2,name,period,freq,branch_type,time,call-graph,stack-size,no-inherit,inherit,max-stack,nr,no-overwrite,overwrite,driver-config,percore,aux-output,aux-sample-size'

The 01.org version of this from:
https://download.01.org/perfmon/TMA_Metrics.xlsx
is:
UNC_ARB_TRK_OCCUPANCY.DATA_READ / UNC_ARB_TRK_OCCUPANCY.DATA_READ:c1

It seems that :c1 has been translated into thresh=1 but that thresh
doesn't exist as a format option (just "cmask edge event inv umask"
are present). I wonder if Andi or Jin you could look into this broken
metric?

Thanks,
Ian

> * Changes from v1:
>  - Add 'Acked-by: Jiri'
>
>
> The patches are also available at 'perf/metric-fix-v2' branch on
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
>
> Thanks
> Namhyung
>
>
> Namhyung Kim (11):
>   perf metric: Fix some memory leaks
>   perf metric: Fix some memory leaks - part 2
>   perf evlist: Fix cpu/thread map leak
>   perf parse-event: Fix cpu map leaks
>   perf parse-event: Fix memory leak in evsel->unit
>   perf test: Fix memory leaks in parse-metric test
>   perf metric: Release expr_parse_ctx after testing
>   perf metric: Free metric when it failed to resolve
>   perf metric: Do not free metric when failed to resolve
>   perf test: Free aliases for PMU event map aliases test
>   perf test: Free formats for perf pmu parse test
>
>  tools/perf/tests/parse-metric.c | 14 ++++++++-----
>  tools/perf/tests/pmu-events.c   |  5 +++++
>  tools/perf/tests/pmu.c          |  1 +
>  tools/perf/util/evlist.c        | 11 ++++++++---
>  tools/perf/util/metricgroup.c   | 35 +++++++++++++++++++++++----------
>  tools/perf/util/parse-events.c  |  9 +++++++--
>  tools/perf/util/pmu.c           | 13 +++++++++++-
>  tools/perf/util/pmu.h           |  2 ++
>  tools/perf/util/stat-shadow.c   |  8 +++++---
>  9 files changed, 74 insertions(+), 24 deletions(-)
>
> --
> 2.28.0.618.gf4bc123cb7-goog
>
