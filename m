Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5850E29BB8F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 17:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1808725AbgJ0QUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 12:20:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:44866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1808714AbgJ0QUU (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 12:20:20 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E739C21556;
        Tue, 27 Oct 2020 16:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603815620;
        bh=9ubK2jU1YuQzm6hFAuu9SToBCJFIb5sgFqynAqoHh3w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iMDTZxc5yZpyCOmxEonPRTO8fWjFPQe+ghh50hSS0rqd1/PdUKEcDPsmsbAdq9SP/
         9lLMYmqH+NmAg9xVWCJtHmVqiH1qVSQ+btYb2KiHbY/h3K6WSo1Pwd1X5IQ0sD/6GT
         WVfjAg8HsdCi9xkOzL8H/DJ8VD3HXDASfL0pWPYs=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 165B8403C2; Tue, 27 Oct 2020 13:20:18 -0300 (-03)
Date:   Tue, 27 Oct 2020 13:20:18 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <Linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@intel.com>, "Jin, Yao" <yao.jin@intel.com>
Subject: Re: [PATCH] perf vendor events: Fix DRAM_BW_Use 0 issue for CLX/SKX
Message-ID: <20201027162018.GH2479604@kernel.org>
References: <20201023005334.7869-1-yao.jin@linux.intel.com>
 <CAP-5=fWtQB2emBg804LgwqztXF-W-+-9Z-s48VOGD+dpBDX4hQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWtQB2emBg804LgwqztXF-W-+-9Z-s48VOGD+dpBDX4hQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Oct 22, 2020 at 06:02:31PM -0700, Ian Rogers escreveu:
> On Thu, Oct 22, 2020 at 5:54 PM Jin Yao <yao.jin@linux.intel.com> wrote:
> >
> > Ian reports an issue that the metric DRAM_BW_Use often remains 0.
> >
> > The metric expression for DRAM_BW_Use on CLX/SKX:
> >
> > "( 64 * ( uncore_imc@cas_count_read@ + uncore_imc@cas_count_write@ ) / 1000000000 ) / duration_time"
> >
> > The counts of uncore_imc/cas_count_read/ and uncore_imc/cas_count_write/
> > are scaled up by 64, that is to turn a count of cache lines into bytes,
> > the count is then divided by 1000000000 to give GB.
> >
> > However, the counts of uncore_imc/cas_count_read/ and
> > uncore_imc/cas_count_write/ have been scaled yet.
> >
> > The scale values are from sysfs, such as
> > /sys/devices/uncore_imc_0/events/cas_count_read.scale.
> > It's 6.103515625e-5 (64 / 1024.0 / 1024.0).
> >
> > So if we use original metric expression, the result is not correct.
> >
> > But the difficulty is, for SKL client, the counts are not scaled.
> >
> > The metric expression for DRAM_BW_Use on SKL:
> >
> > "64 * ( arb@event\\=0x81\\,umask\\=0x1@ + arb@event\\=0x84\\,umask\\=0x1@ ) / 1000000 / duration_time / 1000"
> >
> > root@kbl-ppc:~# perf stat -M DRAM_BW_Use -a -- sleep 1
> >
> >  Performance counter stats for 'system wide':
> >
> >                190      arb/event=0x84,umask=0x1/ #     1.86 DRAM_BW_Use
> >         29,093,178      arb/event=0x81,umask=0x1/
> >      1,000,703,287 ns   duration_time
> >
> >        1.000703287 seconds time elapsed
> >
> > The result is expected.
> >
> > So the easy way is just change the metric expression for CLX/SKX.
> > This patch changes the metric expression to:
> >
> > "( ( ( uncore_imc@cas_count_read@ + uncore_imc@cas_count_write@ ) * 1048576 ) / 1000000000 ) / duration_time"
> >
> > 1048576 = 1024 * 1024.
> >
> > Before (tested on CLX):
> >
> > root@lkp-csl-2sp5 ~# perf stat -M DRAM_BW_Use -a -- sleep 1
> >
> >  Performance counter stats for 'system wide':
> >
> >             765.35 MiB  uncore_imc/cas_count_read/ #     0.00 DRAM_BW_Use
> >               5.42 MiB  uncore_imc/cas_count_write/
> >         1001515088 ns   duration_time
> >
> >        1.001515088 seconds time elapsed
> >
> > After:
> >
> > root@lkp-csl-2sp5 ~# perf stat -M DRAM_BW_Use -a -- sleep 1
> >
> >  Performance counter stats for 'system wide':
> >
> >             767.95 MiB  uncore_imc/cas_count_read/ #     0.80 DRAM_BW_Use
> 
> Nit, using ScaleUnit would allow this to be 0.80GB/s.
> 
> >               5.02 MiB  uncore_imc/cas_count_write/
> >         1001900010 ns   duration_time
> >
> >        1.001900010 seconds time elapsed
> >
> > Fixes: 038d3b53c284 ("perf vendor events intel: Update CascadelakeX events to v1.08")
> > Fixes: b5ff7f2799a4 ("perf vendor events: Update SkylakeX events to v1.21")
> > Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, applied.

- Arnaldo

 
> Thanks,
> Ian
> 
> > ---
> >  tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json | 2 +-
> >  tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json     | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json b/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
> > index de3193552277..00f4fcffa815 100644
> > --- a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
> > +++ b/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
> > @@ -329,7 +329,7 @@
> >      },
> >      {
> >          "BriefDescription": "Average external Memory Bandwidth Use for reads and writes [GB / sec]",
> > -        "MetricExpr": "( 64 * ( uncore_imc@cas_count_read@ + uncore_imc@cas_count_write@ ) / 1000000000 ) / duration_time",
> > +        "MetricExpr": "( ( ( uncore_imc@cas_count_read@ + uncore_imc@cas_count_write@ ) * 1048576 ) / 1000000000 ) / duration_time",
> >          "MetricGroup": "Memory_BW;SoC",
> >          "MetricName": "DRAM_BW_Use"
> >      },
> > diff --git a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json b/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
> > index f31794d3b926..0dd8b13b5cfb 100644
> > --- a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
> > +++ b/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
> > @@ -323,7 +323,7 @@
> >      },
> >      {
> >          "BriefDescription": "Average external Memory Bandwidth Use for reads and writes [GB / sec]",
> > -        "MetricExpr": "( 64 * ( uncore_imc@cas_count_read@ + uncore_imc@cas_count_write@ ) / 1000000000 ) / duration_time",
> > +        "MetricExpr": "( ( ( uncore_imc@cas_count_read@ + uncore_imc@cas_count_write@ ) * 1048576 ) / 1000000000 ) / duration_time",
> >          "MetricGroup": "Memory_BW;SoC",
> >          "MetricName": "DRAM_BW_Use"
> >      },
> > --
> > 2.17.1
> >

-- 

- Arnaldo
