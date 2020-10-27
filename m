Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78CC029A3A9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 05:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2444589AbgJ0Ent (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 00:43:49 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36275 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2444442AbgJ0Ens (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 00:43:48 -0400
Received: by mail-wr1-f67.google.com with SMTP id x7so369506wrl.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 21:43:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NEeHwxNbIj0xw5OLojL3uq8T/kSReBzeawWQZhpq2Hw=;
        b=sa7x4s9iAqF2PbucKTG1voBIvg0GQT3nyYjvrP4tjb2YBnrJChlbZRSEdEl3DF8ZWf
         dL+f67s5LjPuN4huS0SvFxIvAUX/ly4X4I76T8C71il2DR5N8odi8+1YSweXq6E6IqnJ
         qiGle4fQaVU1UHhciwpNzE9CvwuBlwZiUPnU38WgLHtxDZ4J4o2551Y0Uj5F7243Hm/T
         CaZSoLO5Gdju7rFbM0SBNg0yIFgXyMBfQ2/IG+DLXxsul9ayGOx64PU/kpxLI7dM4KV3
         ji1NvWwK9ssnuJxdXtUtYv8yGcJS8VabE9xjnTznCehCVkprmaKXbaHSthZxXat194rr
         zRyA==
X-Gm-Message-State: AOAM531g7YryswFZSreDFgAZSCdgumX3eSR8EzGDdUCN8pNlJ/4qI6mK
        EGdFW5seSQukqsuyIi8sb59IBrq8zTvj3HCvZSk=
X-Google-Smtp-Source: ABdhPJxnEDhghVrITO/qI1zQX6KB72hSGMzqsu1GvQdVlJAWcHVGgbHcuAQSpBAFQH4wNjtT5R5ePZeM1Mx8YODmGrs=
X-Received: by 2002:a05:6000:12c2:: with SMTP id l2mr451644wrx.76.1603773826967;
 Mon, 26 Oct 2020 21:43:46 -0700 (PDT)
MIME-Version: 1.0
References: <20201026141937.582087-1-namhyung@kernel.org> <20201026152108.GW466880@tassilo.jf.intel.com>
In-Reply-To: <20201026152108.GW466880@tassilo.jf.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 27 Oct 2020 13:43:35 +0900
Message-ID: <CAM9d7cg1xQO_RT7ZhnAx6ahVVPvbyij7A1-0JTs_9YSi7ZOqFw@mail.gmail.com>
Subject: Re: [RFC] perf evlist: Warn if event group has mixed sw/hw events
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

On Tue, Oct 27, 2020 at 12:21 AM Andi Kleen <ak@linux.intel.com> wrote:
>
> On Mon, Oct 26, 2020 at 11:19:37PM +0900, Namhyung Kim wrote:
> > This patch just added a warning before running it.  I'd really want to
> > fix the kernel if possible but don't have a good idea.  Thoughts?
>
> The easiest fix would be some multi threading in perf stat opening, then then
> extra latencies could be mostly hidden. One thread per group would probably
> be overkill, but just a few threads would lower the penalty significantly.

Thanks for the suggestion.  Yeah we could use threads to circumvent
the problem in userspace.  But I think it'd better to solve it in the kernel.

Another problem I see is when there's a concurrent perf event in the
same context.  Since it holds ctx->mutex during the synchronize_rcu
the other event should wait for it too.  It'd be nice if it can release the
ctx->mutex before going to sleep unless we can remove it.

>
> I think that would be better than this patch and it's likely not that much
> more complicated, as this is already a lot of code.
>
> > +{
> > +     const char *known_sw_pmu[] = {
> > +             "software", "tracepoint", "breakpoint", "kprobe", "uprobe", "msr"
>
> That's a non scalable approach. New pmus get added regularly. It would be better to
> indicate this in a generic way from the kernel.

Maybe we can add a new attribute (task_ctx?) for that.

>
> > +                     pr_warning("WARNING: Event group has mixed hw/sw events.\n"
> > +                                "This will slow down the perf_event_open syscall.\n"
> > +                                "Consider putting a hw event as a leader.\n\n");
>
> You really need to tell the user which group, otherwise it is hard to find
> in a large command line.

OK

Thanks
Namhyung
