Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86B3B279009
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 20:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729627AbgIYSFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 14:05:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:56932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbgIYSFb (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 14:05:31 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF76720878;
        Fri, 25 Sep 2020 18:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601057130;
        bh=AJ8iMHWxIBWBhlee4eDxoEUbf+emEiFCjxQRudZZgrM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DQwISomXjlSsneUnFKv4idX1YISuBNVwtYVSAhN7jFPnNNZvHfSoYeHIIrrWUFXv7
         HGA8qI6lpJWqJk/dT6UhG1hFFyMbUQ79TaiNaFVe/24wTs/70wM7w2VxP+izWTrhb+
         uiM4RggSdENpiwx5TeyU+xiDKGQ7V5KY73ZOAJN8=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 97419400E9; Fri, 25 Sep 2020 15:05:27 -0300 (-03)
Date:   Fri, 25 Sep 2020 15:05:27 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Jin, Yao" <yao.jin@linux.intel.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>,
        Kan Liang <kan.liang@intel.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v2 1/2] perf vendor events: Update CascadelakeX events to
 v1.08
Message-ID: <20200925180527.GA2883319@kernel.org>
References: <20200922031918.3723-1-yao.jin@linux.intel.com>
 <20200922031918.3723-2-yao.jin@linux.intel.com>
 <20200922194232.GA2505291@kernel.org>
 <4db737f2-0705-5183-6971-9031acfd123b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4db737f2-0705-5183-6971-9031acfd123b@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Sep 23, 2020 at 09:25:06AM +0800, Jin, Yao escreveu:
> On 9/23/2020 3:42 AM, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Sep 22, 2020 at 11:19:17AM +0800, Jin Yao escreveu:
> > > - Update CascadelakeX events to v1.08.
> > > - Update CascadelakeX JSON metrics from TMAM 4.0.

> > > Other fixes:
> > > - Add NO_NMI_WATCHDOG metric constraint to Backend_Bound
> > > - Change 'MB/sec' to 'MB' in UNC_M_PMM_BANDWIDTH.

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

> > Can you please check?

> I applied the patch on latest perf/core, it seemed OK.

> # git log --oneline
> 4cbdb1c21926 (HEAD -> perf/core) perf vendor events: Update CascadelakeX events to v1.08
> b1f815c479c1 (tag: perf-tools-tests-v5.10-2020-09-10, origin/perf/core) perf vendor events power9:
> Add hv_24x7 core level metric events
> f5a489dc8189 perf metricgroup: Pass pmu_event structure as a parameter for
> arch_get_runtimeparam() 560ccbc4a52c perf jevents: Add support for parsing
> perchip/percore events ...
 
> I strongly suspect that part of patch content is truncated by mail system.
 
> Let me resend the patch as attachment. Sorry about that!

Thanks, it now works, but then... You forgot to add the Cc: entries for
all the people in your actual e-mail Cc: list, and also the
Reviewed-by: from Andy, I had to do it all manually, so when I applied
your attachments with 'git am' I needed to go on and manually collect
all the Cc, Reviewed-by and Acked-by tags.

This complicates things, slows me down, doesn't scale. While I do all
this manual stuff normally, I don't think this can continue, and its not
something specific to you, submitters have to pay attention to these
details. Or tools.

Things like b4 help with this and probably have to take into account
attachments as well, that is why I'm adding Konstantin to the Cc: list
of this message.

Konstantin, is this case covered? I.e. patches that get botched and then
require attachments to be sent to then gets processed?

Thanks, applied.

- Arnaldo
