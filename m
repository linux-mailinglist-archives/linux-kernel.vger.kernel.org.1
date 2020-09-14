Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7AE5268B91
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 14:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgINM5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 08:57:44 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35065 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbgINMvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 08:51:20 -0400
Received: by mail-wm1-f65.google.com with SMTP id y15so11150232wmi.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 05:51:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MUsh8LOdnZE8OyA5da0X0Ercql2uQjGXDt9kdnrt4x0=;
        b=mtIW5oycnCrsJAjI12iouRIjgTfLpsBrnQa82Wa3H4lF33XAi4EelQUg+kwxQic6K2
         madWF6iDSAqOtGQihmLzK814jsNPNCMtuC68/ZFksqQMm7FqupZtRCZI9WrStM0VOyCM
         qv56AvPjQrtyNFK75t6RlpApD8Ud3hzkmXBjIg95rjSSKF5rwhLZykVA5Feo5Yns6qof
         wV/hSbqbIl01my73XTQXIlRmh1cQvAYpMBpCWZe3lx/bNkLdTHulDhKrzqPFLud3lZbn
         QAzvsBiY3/JSp0dylUKxucTM+KqJuKRhazYu2RkU8ZRJZye+ve9MOm+Nw+moG0Cq6n9w
         tjTQ==
X-Gm-Message-State: AOAM530FNr0O1032ba3Bt0YWnwQDJ76OezdFMC8LUDHa57naBl0qxNvB
        uaD2aYfZVBcCmY+YCWyapFDS31yxKt4hWud7dseXK2OOF/o=
X-Google-Smtp-Source: ABdhPJyGzjQrcy8sz51vBQYllMlurL+qof28GdM0xsBKCMgdXqRmIXSZNkVtSOMivrSyUavOc983zXlK+EfinriIAQc=
X-Received: by 2002:a1c:7215:: with SMTP id n21mr15756524wmc.154.1600087874114;
 Mon, 14 Sep 2020 05:51:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200911144808.27603-1-kan.liang@linux.intel.com>
In-Reply-To: <20200911144808.27603-1-kan.liang@linux.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 14 Sep 2020 21:51:03 +0900
Message-ID: <CAM9d7cgnMcER9ZgB8jg4bHUuyf7h2HL47HD4=H+O-L165opShg@mail.gmail.com>
Subject: Re: [PATCH V3 0/4] TopDown metrics support for Ice Lake (perf tool)
To:     Kan Liang <kan.liang@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Sep 11, 2020 at 11:51 PM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> Changes since V2:
> - Even topdown_metric_attrs() is failed to be found in the previous
>   platforms, the 'str' variable is still allocated.
>   zfree it before reuse it in Patch 3.
>
> Changes since V1:
> - Fix a grammar error in the printf message in Patch 3
> - Add the "Acked-by" tag from Jirka.
>
>
> The kernel patches have been merged into the tip's perf/core branch.
> The patch set is on top of commit 2cb5383b30d4 ("perf/x86/intel: Support
> per-thread RDPMC TopDown metrics") of the tip's perf/core branch.
>
> The changes for the perf tool include:
> - Extend --topdown option to support per thread TopDown metrics
> - Support sample-read topdown metric group
> - Add a complete document for the TopDown usage.
>
> Ice Lake has support for measuring the level 1 TopDown metrics
> directly in hardware. This is implemented by an additional METRICS
> register, and a new Fixed Counter 3 that measures pipeline SLOTS.
>
> New in Icelake
> - Do not require generic counters. This allows to collect TopDown always
>   in addition to other events.
> - Measuring TopDown per thread/process instead of only per core
>
> For the Ice Lake implementation of performance metrics, the values in
> PERF_METRICS MSR are derived from fixed counter 3. Software should start
> both registers, PERF_METRICS and fixed counter 3, from zero.
> Additionally, software is recommended to periodically clear both
> registers in order to maintain accurate measurements. The latter is
> required for certain scenarios that involve sampling metrics at high
> rates. Software should always write fixed counter 3 before write to
> PERF_METRICS.
>
> IA32_PERF_GLOBAL_STATUS. OVF_PERF_METRICS[48]: If this bit is set,
> it indicates that some PERF_METRICS-related counter has overflowed and
> a PMI is triggered. Software has to synchronize, e.g. re-start,
> PERF_METRICS as well as fixed counter 3. Otherwise, PERF_METRICS may
> return invalid values.
>
> Limitation
> - To get accurate result and avoid reading the METRICS register multiple
>   times, the TopDown metrics events and SLOTS event have to be in the
>   same group.
> - METRICS and SLOTS registers have to be cleared after each read by SW.
>   That is to prevent the lose of precision.
> - Cannot do sampling read SLOTS and TopDown metric events
>
> Please refer SDM Vol3, 18.3.9.3 Performance Metrics for the details of
> TopDown metrics.
>
> Andi Kleen (2):
>   perf stat: Support new per thread TopDown metrics
>   perf, tools: Add documentation for topdown metrics
>
> Kan Liang (2):
>   perf tools: Rename group to topdown
>   perf record: Support sample-read topdown metric group

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks
Namhyung


>
>  tools/perf/Documentation/perf-stat.txt |   7 +-
>  tools/perf/Documentation/topdown.txt   | 256 +++++++++++++++++++++++++
>  tools/perf/arch/x86/util/Build         |   2 +-
>  tools/perf/arch/x86/util/group.c       |  28 ---
>  tools/perf/arch/x86/util/topdown.c     |  63 ++++++
>  tools/perf/builtin-stat.c              |  81 +++-----
>  tools/perf/util/Build                  |   1 +
>  tools/perf/util/group.h                |   8 -
>  tools/perf/util/record.c               |   3 +-
>  tools/perf/util/stat-shadow.c          |  89 +++++++++
>  tools/perf/util/stat.c                 |   4 +
>  tools/perf/util/stat.h                 |   8 +
>  tools/perf/util/topdown.c              |  58 ++++++
>  tools/perf/util/topdown.h              |  12 ++
>  14 files changed, 528 insertions(+), 92 deletions(-)
>  create mode 100644 tools/perf/Documentation/topdown.txt
>  delete mode 100644 tools/perf/arch/x86/util/group.c
>  create mode 100644 tools/perf/arch/x86/util/topdown.c
>  delete mode 100644 tools/perf/util/group.h
>  create mode 100644 tools/perf/util/topdown.c
>  create mode 100644 tools/perf/util/topdown.h
>
> --
> 2.17.1
>
