Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08CD32F596C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 04:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbhANDfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 22:35:11 -0500
Received: from mail-lf1-f51.google.com ([209.85.167.51]:34009 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727237AbhANDfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 22:35:09 -0500
Received: by mail-lf1-f51.google.com with SMTP id o19so6064558lfo.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 19:34:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D83BGbxgFubbKe3Aqospb2UHroayuOX+w4noaosgfp4=;
        b=Y/ZCemCeQ+OiOuopO2iI0Mobv4rXk1VjKmSAtLGqc5L3zVTVlUG4W4dyqpcJWoIQzc
         8Ny0fPPlVcJvEjyoM0UilSErQbAcqP5HQXkkYOeKwgI1cBBUkZGVa5aHSWFPCKrfGKi9
         vzJbNQuFM5H5GsY8P4/znkc85+37Ae88/HNLyCz9xwT4LcI4xLMnNy4yzHngwnCTRGKb
         EteTp1jvEylj58PYPlWaSjHdS/wCiV2y7TcHAU6GMX+4OUURYB0lGC5ZZSkVMGnYKe5Y
         DnIoqBzgKlXZxRFnydHOCvkaAA2bq7ggLovQWC+3rbq3R2Mjo9XBG72jgox1E0kOBpLb
         xPRA==
X-Gm-Message-State: AOAM533H90EhKhmKMG1Se+qQQOLUbbg48D3s7U5ffS/AroqTgD+gNGAF
        lPz1DDW/SS4Y/51cohDXbtEycT41IwH1iXdGj1Q=
X-Google-Smtp-Source: ABdhPJxf0SFujfVonr/m95nQzsixQR1Rccgpk5ZEXAFpEY+K8Q9H/+TF1jUjlxn5DYa2oX35BFzJrCUeJAYpss4gSa8=
X-Received: by 2002:a05:6512:a8b:: with SMTP id m11mr600137lfu.112.1610595260062;
 Wed, 13 Jan 2021 19:34:20 -0800 (PST)
MIME-Version: 1.0
References: <20201223130320.3930-1-alexander.antonov@linux.intel.com>
 <20201223130320.3930-4-alexander.antonov@linux.intel.com> <CAM9d7ciA3MzvzobN=_NEChKwet+RzHUu3gf+KTzdXcvTmiChLw@mail.gmail.com>
 <64c262e4-fc97-c200-6983-81d966e922e0@linux.intel.com>
In-Reply-To: <64c262e4-fc97-c200-6983-81d966e922e0@linux.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 14 Jan 2021 12:34:08 +0900
Message-ID: <CAM9d7ci5qSnm1V4VCpdZn+b5uPajs27uAV+J-+W2QHPCbCohTQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] perf stat: Basic support for iiostat in perf
To:     Alexander Antonov <alexander.antonov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Jan 13, 2021 at 8:34 PM Alexander Antonov
<alexander.antonov@linux.intel.com> wrote:
>
>
> On 1/6/2021 11:56 AM, Namhyung Kim wrote:
> > On Wed, Dec 23, 2020 at 10:03 PM Alexander Antonov
> > <alexander.antonov@linux.intel.com> wrote:
> >> Add basic flow for a new iiostat mode in perf. Mode is intended to
> >> provide four I/O performance metrics per each IIO stack: Inbound Read,
> >> Inbound Write, Outbound Read, Outbound Write.
> > It seems like a generic analysis and other archs can extend it later..
> > Then we can make it a bit more general.. at least, names? :)
> I'm not sure that I fully understand you. Do you mean to rename metrics?
> The mode is intended to provide PCIe metrics which are appliable for
> other archs
> as well.
> Actually, I suppose we can rename 'iiostat' to 'pciestat' or something
> like this
> to make it a bit more general because the name 'IIO' (Integrated I/O
> stack) is
> Intel specific and it can be named in different way on other platforms.
> In this
> case the code has to be updated in the same way as well.

Maybe just 'iostat' ?

> >
> >> The actual code to compute the metrics and attribute it to
> >> evsel::perf_device is in follow-on patches.
> >>
> >> Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
> >> ---
> >>   tools/perf/builtin-stat.c      | 33 ++++++++++++++++++++++++++++-
> >>   tools/perf/util/iiostat.h      | 33 +++++++++++++++++++++++++++++
> >>   tools/perf/util/stat-display.c | 38 +++++++++++++++++++++++++++++++++-
> >>   tools/perf/util/stat-shadow.c  | 11 +++++++++-
> >>   tools/perf/util/stat.h         |  1 +
> >>   5 files changed, 113 insertions(+), 3 deletions(-)
> >>   create mode 100644 tools/perf/util/iiostat.h
> >>
> >> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> >> index 72f9d0aa3f96..14c3da136927 100644
> >> --- a/tools/perf/builtin-stat.c
> >> +++ b/tools/perf/builtin-stat.c
> >> @@ -67,6 +67,7 @@
> >>   #include "util/top.h"
> >>   #include "util/affinity.h"
> >>   #include "util/pfm.h"
> >> +#include "util/iiostat.h"
> >>   #include "asm/bug.h"
> >>
> >>   #include <linux/time64.h>
> >> @@ -198,7 +199,8 @@ static struct perf_stat_config stat_config = {
> >>          .walltime_nsecs_stats   = &walltime_nsecs_stats,
> >>          .big_num                = true,
> >>          .ctl_fd                 = -1,
> >> -       .ctl_fd_ack             = -1
> >> +       .ctl_fd_ack             = -1,
> >> +       .iiostat_run            = false,
> >>   };
> >>
> >>   static bool cpus_map_matched(struct evsel *a, struct evsel *b)
> >> @@ -1073,6 +1075,14 @@ static int parse_stat_cgroups(const struct option *opt,
> >>          return parse_cgroups(opt, str, unset);
> >>   }
> >>
> >> +__weak int iiostat_parse(const struct option *opt __maybe_unused,
> >> +                        const char *str __maybe_unused,
> >> +                        int unset __maybe_unused)
> >> +{
> >> +       pr_err("iiostat mode is not supported\n");
> >> +       return -1;
> >> +}
> >> +
> >>   static struct option stat_options[] = {
> >>          OPT_BOOLEAN('T', "transaction", &transaction_run,
> >>                      "hardware transaction statistics"),
> >> @@ -1185,6 +1195,8 @@ static struct option stat_options[] = {
> >>                       "\t\t\t  Optionally send control command completion ('ack\\n') to ack-fd descriptor.\n"
> >>                       "\t\t\t  Alternatively, ctl-fifo / ack-fifo will be opened and used as ctl-fd / ack-fd.",
> >>                        parse_control_option),
> >> +       OPT_CALLBACK_OPTARG(0, "iiostat", &evsel_list, &stat_config, "root port",
> >> +                           "measure PCIe metrics per IIO stack", iiostat_parse),
> >>          OPT_END()
> >>   };
> >>
> >> @@ -1509,6 +1521,12 @@ static int perf_stat_init_aggr_mode_file(struct perf_stat *st)
> >>          return 0;
> >>   }
> >>
> >> +__weak int iiostat_show_root_ports(struct evlist *evlist __maybe_unused,
> >> +                                  struct perf_stat_config *config __maybe_unused)
> >> +{
> >> +       return 0;
> >> +}
> > I think it's too specific, maybe iiostat_prepare() ?
> What do you think about iiostat_show_root_ports() -> iiostat_show()?

I'm ok with it, I thought it needs some initialization work there.

> >
> >> +
> >>   /*
> >>    * Add default attributes, if there were no attributes specified or
> >>    * if -d/--detailed, -d -d or -d -d -d is used:
> >> @@ -2054,6 +2072,10 @@ static void setup_system_wide(int forks)
> >>          }
> >>   }
> >>
> >> +__weak void iiostat_delete_root_ports(struct evlist *evlist __maybe_unused)
> >> +{
> >> +}
> > Same here..
> I suggest to rename iiostat_delete_root_ports() -> iiostat_release().
> What do you think?

Looks good.

> >
> >> +
> >>   int cmd_stat(int argc, const char **argv)
> >>   {
> >>          const char * const stat_usage[] = {
> >> @@ -2230,6 +2252,12 @@ int cmd_stat(int argc, const char **argv)
> >>                  goto out;
> >>          }
> >>
> >> +       if (stat_config.iiostat_run) {
> >> +               status = iiostat_show_root_ports(evsel_list, &stat_config);
> >> +               if (status || !stat_config.iiostat_run)
> >> +                       goto out;
> >> +       }
> >> +
> >>          if (add_default_attributes())
> >>                  goto out;
> >>

[SNIP]
> >> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> >> index 3bfcdb80443a..9eb8484e8b90 100644
> >> --- a/tools/perf/util/stat-display.c
> >> +++ b/tools/perf/util/stat-display.c
> >> @@ -17,6 +17,7 @@
> >>   #include "cgroup.h"
> >>   #include <api/fs/fs.h>
> >>   #include "util.h"
> >> +#include "iiostat.h"
> >>
> >>   #define CNTR_NOT_SUPPORTED     "<not supported>"
> >>   #define CNTR_NOT_COUNTED       "<not counted>"
> >> @@ -310,6 +311,12 @@ static void print_metric_header(struct perf_stat_config *config,
> >>          struct outstate *os = ctx;
> >>          char tbuf[1024];
> >>
> >> +       /* In case of iiostat, print metric header for first perf_device only */
> >> +       if (os->evsel->perf_device && os->evsel->evlist->selected->perf_device &&
> >> +           config->iiostat_run &&
> > When is the perf_device set?  Is it possible to be NULL in the iiostat mode?
> >
> The perf_device field is initialized inside iiostat.c::iiostat_event_group()
> and it cannot be NULL.
> The idea is to attribute events to PCIe ports through perf_device field.
>

If it's guaranteed non-NULL, we can check config->iiostat_run only and make
the condition simpler.

Thanks,
Namhyung



> >> +           os->evsel->perf_device != os->evsel->evlist->selected->perf_device)
> >> +               return;
> >> +
> >>          if (!valid_only_metric(unit))
> >>                  return;
> >>          unit = fixunit(tbuf, os->evsel, unit);
