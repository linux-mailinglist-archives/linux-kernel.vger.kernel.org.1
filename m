Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91E4A2762D1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 23:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgIWVEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 17:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgIWVEr (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 17:04:47 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18380C0613CE
        for <Linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 14:04:47 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id s12so1449094wrw.11
        for <Linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 14:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q0PBQMEeikvtPelLpBMu99TBOXtVwC3O79Qtto9qPfc=;
        b=TNbH/NiKtwCo9x9ajK1iKGxrkpP4s41c3S1vGi/dNwueExWgNemJFQYb+xEjRXUzmq
         SGoEK8kAzP0uk/kUcSBxha7HvrJyGNN3DCjZ27qgNj8MoQPyrElAqMP2hsAbYBmipV2z
         SQZGh0yqmNrUOjY8xKuX8PjuXBi/eF1jPiH39iQ+rzRZI3lDqKk/5jjW4CsC8BXpKt6J
         42ZDZY84nHiPGGq7baJdUQxoMl6oC2ilJkOQVeiuJuWHu6Izc38S+LrbO0szMQ4iaFEt
         yokqPpZm6g9YBzRPLE6H6HVxejTsudvl3xzobCI43IH+GZWf4tIdONVq55AwxgLeEBXZ
         hTQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q0PBQMEeikvtPelLpBMu99TBOXtVwC3O79Qtto9qPfc=;
        b=r1y7CtFI3BZ98nG6Bgnwp8QwAkMPOA6Q96iBAMYmxAjioyrylt6hcl4JNuS4FlgRPz
         aZwTdLKkWx4N2bgXstvCJazyJWSzLtBoy8wJzYZ2440qW4Zt8MAxzuwljSePLhmruSLE
         7KKEYcoCr2i2TkErgpbyAsyasC0PQK95AFjbJu4D3ySTDOHr40+bbKh8RoBkcjvd8hNh
         czHpijkkthfcMUxgjZmroKkejHFoBBs4xHmoJVUO+Pchmi1JycGinK68m+esiYKvESCX
         hEIZPwwhUPph31xbh1pwVLWBMilGaEKIvEjRmlkz0XEpfahsMtxDsc2fhvhFDNA5FSEO
         5fVw==
X-Gm-Message-State: AOAM532JI7BAtDrFE4XnAUGeSptBI9vzzh3sAQGmQcrm5Wt0H1p2B/Jw
        1Y2Fm6wv4cBPZr3d9KaLN3c4hW7fvQOKeKSUMvIzWA==
X-Google-Smtp-Source: ABdhPJzjHoZqx4H3eGQxV8dMD8Jw2+hxZ1Mg5VpU5ZqOx0hIouq3BmG80m+QGdXMqPRPxbERi3FquhgX2j4ZG2DdgJw=
X-Received: by 2002:a5d:458a:: with SMTP id p10mr1509241wrq.282.1600895085502;
 Wed, 23 Sep 2020 14:04:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200922031918.3723-1-yao.jin@linux.intel.com>
 <20200922031918.3723-2-yao.jin@linux.intel.com> <20200922194232.GA2505291@kernel.org>
 <4db737f2-0705-5183-6971-9031acfd123b@linux.intel.com>
In-Reply-To: <4db737f2-0705-5183-6971-9031acfd123b@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 23 Sep 2020 14:04:33 -0700
Message-ID: <CAP-5=fWyfSwoySO5PB4Da_fgownR46+QeivNnCOe=3qxJZASWA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] perf vendor events: Update CascadelakeX events to v1.08
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <Linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>, kan.liang@intel.com,
        "Jin, Yao" <yao.jin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 6:25 PM Jin, Yao <yao.jin@linux.intel.com> wrote:
>
> Hi Arnaldo,
>
> On 9/23/2020 3:42 AM, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Sep 22, 2020 at 11:19:17AM +0800, Jin Yao escreveu:
> >> - Update CascadelakeX events to v1.08.
> >> - Update CascadelakeX JSON metrics from TMAM 4.0.
> >>
> >> Other fixes:
> >> - Add NO_NMI_WATCHDOG metric constraint to Backend_Bound
> >> - Change 'MB/sec' to 'MB' in UNC_M_PMM_BANDWIDTH.
> >
> >
> > [acme@five perf]$ am /wb/1.patch
> > Applying: perf vendor events: Update CascadelakeX events to v1.08
> > error: patch fragment without header at line 283: @@ -213,14 +220,14 @@
> > Patch failed at 0001 perf vendor events: Update CascadelakeX events to v1.08
> > hint: Use 'git am --show-current-patch=diff' to see the failed patch
> > When you have resolved this problem, run "git am --continue".
> > If you prefer to skip this patch, run "git am --skip" instead.
> > To restore the original branch and stop patching, run "git am --abort".
> > [acme@five perf]$ git am --abort
> > [acme@five perf]$ set -o vi
> > [acme@five perf]$ patch -p1 < /wb/1.patch
> > patching file tools/perf/pmu-events/arch/x86/cascadelakex/cache.json
> > patching file tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
> > Hunk #7 FAILED at 87.
> > 1 out of 7 hunks FAILED -- saving rejects to file tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json.rej
> > patching file tools/perf/pmu-events/arch/x86/cascadelakex/frontend.json
> > patching file tools/perf/pmu-events/arch/x86/cascadelakex/memory.json
> > patching file tools/perf/pmu-events/arch/x86/cascadelakex/other.json
> > patching file tools/perf/pmu-events/arch/x86/cascadelakex/pipeline.json
> > patching file tools/perf/pmu-events/arch/x86/cascadelakex/uncore-memory.json
> > patching file tools/perf/pmu-events/arch/x86/cascadelakex/uncore-other.json
> > [acme@five perf]$
> >
> > [acme@five perf]$ head tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json.rej
> > --- tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
> > +++ tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
> > @@ -87,86 +70,110 @@
> >           "MetricName": "CLKS"
> >       },
> >       {
> > -        "BriefDescription": "Total issue-pipeline slots (per-Physical Core)",
> > +        "BriefDescription": "Total issue-pipeline slots (per-Physical Core till ICL; per-Logical Processor ICL onward)",
> >           "MetricExpr": "4 * cycles",
> >           "MetricGroup": "TopDownL1",
> > [acme@five perf]$ wc -l tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json.rej
> > 133 tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json.rej
> > [acme@five perf]$
> >
> >
> >
> > Can you please check?
> >
> > - Arnaldo
> >
>
> I applied the patch on latest perf/core, it seemed OK.
>
> # git log --oneline
> 4cbdb1c21926 (HEAD -> perf/core) perf vendor events: Update CascadelakeX events to v1.08
> b1f815c479c1 (tag: perf-tools-tests-v5.10-2020-09-10, origin/perf/core) perf vendor events power9:
> Add hv_24x7 core level metric events
> f5a489dc8189 perf metricgroup: Pass pmu_event structure as a parameter for arch_get_runtimeparam()
> 560ccbc4a52c perf jevents: Add support for parsing perchip/percore events ...
>
> I strongly suspect that part of patch content is truncated by mail system.
>
> Let me resend the patch as attachment. Sorry about that!
>
> Thanks
> Jin Yao

I tested the 2 attached patches both with tip.git/master and acme's
perf/core branches. They applied and passed my testing and manual
inspection.

Acked-by: Ian Rogers <irogers@google.com>

Thanks!
Ian
