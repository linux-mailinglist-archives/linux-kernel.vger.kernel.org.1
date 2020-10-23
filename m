Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C15F29683D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 03:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374228AbgJWBCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 21:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S374221AbgJWBCp (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 21:02:45 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEF3C0613CE
        for <Linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 18:02:45 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id y12so5947490wrp.6
        for <Linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 18:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PeIkXK9B1GsAnFw5j39YSRAnSJLkSrJNmAO/G3HgJms=;
        b=tbfdzTiQ6tIEXeqLHbf3o1YyIofphsp3/bg1sfA3jzLQ5qFTGielnOyRoNFmzhmtiH
         3tQAtTQojkSJJMcBqyFOtTu7nvK7w63zS9Fg+L3KbmCfHl3EzmcVEpj5GU+EuJUX5AlV
         GF84bVih1ow9O6jK7Ca5Az7u4ZrHhe9F5WcgvwgFq1AE7DTOCfPmZjiku4eW/q9E+d0M
         yA3Cw0t0fJouLkBsLdEzb4AHzXo4DUjIr4JCm2o33SaQbYnxt9/EO/mO7ucrIeUjeb7z
         /EtWYw+GHDJ9NeJv9k/FFU3l1nRnL3FImUxV/kxM/lK+BHXi7gvqZrXivqbaILPHx/v8
         DJNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PeIkXK9B1GsAnFw5j39YSRAnSJLkSrJNmAO/G3HgJms=;
        b=T16rcPv61qots4u5zitCA15UYmMTarmGnQXFSkxcmpTS+JQKW79PXNxfWXd711mHMN
         3nFR066buGUMJFsJFqlDVNI78avTGdd6wsBIK8Ka62ck5ZH9OxEy0m3A26bZCdSj5ZRa
         Z7FAGODtQcxdVM//kpXctRf4f1wmDXrmMTp/AiZbz5800bXS8kaYqi7aEhi6NST+/6HZ
         kZYu/XO+mtZ0UoKZuX+6tsbAlIGrLHlVN0AaHqb3hWGWK7Xh78oucgf7D/7xtDuRi61v
         qKiKtjjVt/8h4XBwS1w6qFA7gKpaNzMMpcuCyXd68L/gNpQxl6L2FQNzTjkaCSsU6bBN
         gIkw==
X-Gm-Message-State: AOAM533uHoixux+wq6N9obOQQPXBfUlkW8JjdrHXtBmzYOqDI2EQlyGq
        H44WhndbyI5E5vshnnfJsYPHhsIrO2QZcZ+9JMsqqQ==
X-Google-Smtp-Source: ABdhPJzirUFhlwzW44Sjw6Z+3BuTdLcQtjKzd+8PSpOEXl6S5XEDxGKoGZ/fle3nqhloxR07ORGb3fuTbZmf3vl1g58=
X-Received: by 2002:adf:b19c:: with SMTP id q28mr5066460wra.119.1603414963474;
 Thu, 22 Oct 2020 18:02:43 -0700 (PDT)
MIME-Version: 1.0
References: <20201023005334.7869-1-yao.jin@linux.intel.com>
In-Reply-To: <20201023005334.7869-1-yao.jin@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 22 Oct 2020 18:02:31 -0700
Message-ID: <CAP-5=fWtQB2emBg804LgwqztXF-W-+-9Z-s48VOGD+dpBDX4hQ@mail.gmail.com>
Subject: Re: [PATCH] perf vendor events: Fix DRAM_BW_Use 0 issue for CLX/SKX
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <Linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@intel.com>, "Jin, Yao" <yao.jin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 5:54 PM Jin Yao <yao.jin@linux.intel.com> wrote:
>
> Ian reports an issue that the metric DRAM_BW_Use often remains 0.
>
> The metric expression for DRAM_BW_Use on CLX/SKX:
>
> "( 64 * ( uncore_imc@cas_count_read@ + uncore_imc@cas_count_write@ ) / 1000000000 ) / duration_time"
>
> The counts of uncore_imc/cas_count_read/ and uncore_imc/cas_count_write/
> are scaled up by 64, that is to turn a count of cache lines into bytes,
> the count is then divided by 1000000000 to give GB.
>
> However, the counts of uncore_imc/cas_count_read/ and
> uncore_imc/cas_count_write/ have been scaled yet.
>
> The scale values are from sysfs, such as
> /sys/devices/uncore_imc_0/events/cas_count_read.scale.
> It's 6.103515625e-5 (64 / 1024.0 / 1024.0).
>
> So if we use original metric expression, the result is not correct.
>
> But the difficulty is, for SKL client, the counts are not scaled.
>
> The metric expression for DRAM_BW_Use on SKL:
>
> "64 * ( arb@event\\=0x81\\,umask\\=0x1@ + arb@event\\=0x84\\,umask\\=0x1@ ) / 1000000 / duration_time / 1000"
>
> root@kbl-ppc:~# perf stat -M DRAM_BW_Use -a -- sleep 1
>
>  Performance counter stats for 'system wide':
>
>                190      arb/event=0x84,umask=0x1/ #     1.86 DRAM_BW_Use
>         29,093,178      arb/event=0x81,umask=0x1/
>      1,000,703,287 ns   duration_time
>
>        1.000703287 seconds time elapsed
>
> The result is expected.
>
> So the easy way is just change the metric expression for CLX/SKX.
> This patch changes the metric expression to:
>
> "( ( ( uncore_imc@cas_count_read@ + uncore_imc@cas_count_write@ ) * 1048576 ) / 1000000000 ) / duration_time"
>
> 1048576 = 1024 * 1024.
>
> Before (tested on CLX):
>
> root@lkp-csl-2sp5 ~# perf stat -M DRAM_BW_Use -a -- sleep 1
>
>  Performance counter stats for 'system wide':
>
>             765.35 MiB  uncore_imc/cas_count_read/ #     0.00 DRAM_BW_Use
>               5.42 MiB  uncore_imc/cas_count_write/
>         1001515088 ns   duration_time
>
>        1.001515088 seconds time elapsed
>
> After:
>
> root@lkp-csl-2sp5 ~# perf stat -M DRAM_BW_Use -a -- sleep 1
>
>  Performance counter stats for 'system wide':
>
>             767.95 MiB  uncore_imc/cas_count_read/ #     0.80 DRAM_BW_Use

Nit, using ScaleUnit would allow this to be 0.80GB/s.

>               5.02 MiB  uncore_imc/cas_count_write/
>         1001900010 ns   duration_time
>
>        1.001900010 seconds time elapsed
>
> Fixes: 038d3b53c284 ("perf vendor events intel: Update CascadelakeX events to v1.08")
> Fixes: b5ff7f2799a4 ("perf vendor events: Update SkylakeX events to v1.21")
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json | 2 +-
>  tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json b/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
> index de3193552277..00f4fcffa815 100644
> --- a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
> @@ -329,7 +329,7 @@
>      },
>      {
>          "BriefDescription": "Average external Memory Bandwidth Use for reads and writes [GB / sec]",
> -        "MetricExpr": "( 64 * ( uncore_imc@cas_count_read@ + uncore_imc@cas_count_write@ ) / 1000000000 ) / duration_time",
> +        "MetricExpr": "( ( ( uncore_imc@cas_count_read@ + uncore_imc@cas_count_write@ ) * 1048576 ) / 1000000000 ) / duration_time",
>          "MetricGroup": "Memory_BW;SoC",
>          "MetricName": "DRAM_BW_Use"
>      },
> diff --git a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json b/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
> index f31794d3b926..0dd8b13b5cfb 100644
> --- a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
> @@ -323,7 +323,7 @@
>      },
>      {
>          "BriefDescription": "Average external Memory Bandwidth Use for reads and writes [GB / sec]",
> -        "MetricExpr": "( 64 * ( uncore_imc@cas_count_read@ + uncore_imc@cas_count_write@ ) / 1000000000 ) / duration_time",
> +        "MetricExpr": "( ( ( uncore_imc@cas_count_read@ + uncore_imc@cas_count_write@ ) * 1048576 ) / 1000000000 ) / duration_time",
>          "MetricGroup": "Memory_BW;SoC",
>          "MetricName": "DRAM_BW_Use"
>      },
> --
> 2.17.1
>
