Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 272392CCB64
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 02:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387404AbgLCBEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 20:04:51 -0500
Received: from mail-lf1-f44.google.com ([209.85.167.44]:36282 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgLCBEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 20:04:51 -0500
Received: by mail-lf1-f44.google.com with SMTP id v14so273061lfo.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 17:04:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FqBDFILtKC1/XhSHgxkhsjETw7FLnQmSQ+/jvyeh0Wg=;
        b=XdkMLUil0v5UTEWEv5xIPl35soqTEjjbATxpaSjLk1uaiZTjdmsE+WVLc6Z+oQ2oWG
         nxXcrxCaniW4F8YMcg6ZjRvebyMZu/OZY1moNy267+CV/B4lMSUC94eE0zk4xUtetVMA
         DE8c11gos/59x8gtKU0VZgcbkVFQqUzASHV1tDlxWLMiTGpZDLS8RtCfaT4IFoo3lhtr
         7K/hq0Oeu8kpXGMieXTo6UHKi7i8J+9qRWNQjxrirPlxWAJnqW4PbOYEGS3OsJIw+V8G
         Ieim7SaoYaJvU86QdZEH/AoEbL+7P5S8PgXqXCJsfZOCJPfZeeHuvICs9qfxO0cf9SGp
         nBgA==
X-Gm-Message-State: AOAM532lVXRJxUjB+035YlN5x45Kyid3hytYHSfHvjiFBfM7hiXY19UW
        Cl2yOv2jyfiF+nDH2sidiRHotLKUjfVfRPuu5eU=
X-Google-Smtp-Source: ABdhPJyadI0Hcq7K79+8DyPpK4TsBJgvKFjUWqW1e7aMukHByOk4AU4OmQC5T9n0r4AoJ5tpfUhKZtLALk/0P48nWYc=
X-Received: by 2002:a19:38e:: with SMTP id 136mr287491lfd.593.1606957443379;
 Wed, 02 Dec 2020 17:04:03 -0800 (PST)
MIME-Version: 1.0
References: <20201202150205.35750-1-namhyung@kernel.org> <20201202192828.GG1363814@tassilo.jf.intel.com>
 <CABPqkBR5nCfn756Wb8xQEb9Xse+UQPAbGy969cP4sxO78-Nq4g@mail.gmail.com>
 <20201202224239.GJ1363814@tassilo.jf.intel.com> <CABPqkBRsS2+gT-792uYq+U84LJepDjY=wwiLku6mtVhgd8mEEA@mail.gmail.com>
In-Reply-To: <CABPqkBRsS2+gT-792uYq+U84LJepDjY=wwiLku6mtVhgd8mEEA@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 3 Dec 2020 10:03:52 +0900
Message-ID: <CAM9d7cjrPfn2icWYpi=ZHC90SR8JcV5coTJV-xAAM3r3Yfpd8Q@mail.gmail.com>
Subject: Re: [RFC 1/2] perf core: Add PERF_COUNT_SW_CGROUP_SWITCHES event
To:     Stephane Eranian <eranian@google.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephane and Andi,

On Thu, Dec 3, 2020 at 8:40 AM Stephane Eranian <eranian@google.com> wrote:
>
> On Wed, Dec 2, 2020 at 2:42 PM Andi Kleen <ak@linux.intel.com> wrote:
> >
> > On Wed, Dec 02, 2020 at 11:47:25AM -0800, Stephane Eranian wrote:
> > > On Wed, Dec 2, 2020 at 11:28 AM Andi Kleen <ak@linux.intel.com> wrote:
> > > >
> > > > > +     prev_cgrp = task_css_check(prev, perf_event_cgrp_id, 1)->cgroup;
> > > > > +     next_cgrp = task_css_check(next, perf_event_cgrp_id, 1)->cgroup;
> > > > > +
> > > > > +     if (prev_cgrp != next_cgrp)
> > > > > +             perf_sw_event_sched(PERF_COUNT_SW_CGROUP_SWITCHES, 1, 0);
> > > >
> > > > Seems to be the perf cgroup only, not all cgroups.
> > > > That's a big difference and needs to be documented properly.
> > > >
> > > We care about the all-cgroup case.
> >
> > Then it's not correct I think. You need a different hook point.
> >
> I realize that ;-(

If we want to count any cgroup changes, I think we can compare
task->cgroups (css_set) here instead.

Thanks,
Namyung
