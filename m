Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64BA52F4A58
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 12:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbhAMLf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 06:35:57 -0500
Received: from mga04.intel.com ([192.55.52.120]:43729 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728274AbhAMLf4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 06:35:56 -0500
IronPort-SDR: wtFywkyUjjqMCSTt8/24phYjx5jSD/y+LtxjO+nA9aDM96Zsa4wnx5kbt0wJlBGgNUH3kxFt9d
 iGI89sBRBZLg==
X-IronPort-AV: E=McAfee;i="6000,8403,9862"; a="175608088"
X-IronPort-AV: E=Sophos;i="5.79,344,1602572400"; 
   d="scan'208";a="175608088"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2021 03:34:36 -0800
IronPort-SDR: /sHnJN/zdu87uC3zDWps7CYlNUotmSus/7ZxXrHWHhZT3aa8xztFly91zLe6wpjh7q4D0cU4BG
 4rUkNVVPe2tw==
X-IronPort-AV: E=Sophos;i="5.79,344,1602572400"; 
   d="scan'208";a="381810003"
Received: from aantonov-mobl.ccr.corp.intel.com (HELO [10.249.225.249]) ([10.249.225.249])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2021 03:34:33 -0800
Subject: Re: [PATCH v2 3/6] perf stat: Basic support for iiostat in perf
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <20201223130320.3930-1-alexander.antonov@linux.intel.com>
 <20201223130320.3930-4-alexander.antonov@linux.intel.com>
 <CAM9d7ciA3MzvzobN=_NEChKwet+RzHUu3gf+KTzdXcvTmiChLw@mail.gmail.com>
From:   Alexander Antonov <alexander.antonov@linux.intel.com>
Message-ID: <64c262e4-fc97-c200-6983-81d966e922e0@linux.intel.com>
Date:   Wed, 13 Jan 2021 14:34:30 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAM9d7ciA3MzvzobN=_NEChKwet+RzHUu3gf+KTzdXcvTmiChLw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/6/2021 11:56 AM, Namhyung Kim wrote:
> On Wed, Dec 23, 2020 at 10:03 PM Alexander Antonov
> <alexander.antonov@linux.intel.com> wrote:
>> Add basic flow for a new iiostat mode in perf. Mode is intended to
>> provide four I/O performance metrics per each IIO stack: Inbound Read,
>> Inbound Write, Outbound Read, Outbound Write.
> It seems like a generic analysis and other archs can extend it later..
> Then we can make it a bit more general.. at least, names? :)
I'm not sure that I fully understand you. Do you mean to rename metrics?
The mode is intended to provide PCIe metrics which are appliable for 
other archs
as well.
Actually, I suppose we can rename 'iiostat' to 'pciestat' or something 
like this
to make it a bit more general because the name 'IIO' (Integrated I/O 
stack) is
Intel specific and it can be named in different way on other platforms. 
In this
case the code has to be updated in the same way as well.
>
>> The actual code to compute the metrics and attribute it to
>> evsel::perf_device is in follow-on patches.
>>
>> Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
>> ---
>>   tools/perf/builtin-stat.c      | 33 ++++++++++++++++++++++++++++-
>>   tools/perf/util/iiostat.h      | 33 +++++++++++++++++++++++++++++
>>   tools/perf/util/stat-display.c | 38 +++++++++++++++++++++++++++++++++-
>>   tools/perf/util/stat-shadow.c  | 11 +++++++++-
>>   tools/perf/util/stat.h         |  1 +
>>   5 files changed, 113 insertions(+), 3 deletions(-)
>>   create mode 100644 tools/perf/util/iiostat.h
>>
>> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
>> index 72f9d0aa3f96..14c3da136927 100644
>> --- a/tools/perf/builtin-stat.c
>> +++ b/tools/perf/builtin-stat.c
>> @@ -67,6 +67,7 @@
>>   #include "util/top.h"
>>   #include "util/affinity.h"
>>   #include "util/pfm.h"
>> +#include "util/iiostat.h"
>>   #include "asm/bug.h"
>>
>>   #include <linux/time64.h>
>> @@ -198,7 +199,8 @@ static struct perf_stat_config stat_config = {
>>          .walltime_nsecs_stats   = &walltime_nsecs_stats,
>>          .big_num                = true,
>>          .ctl_fd                 = -1,
>> -       .ctl_fd_ack             = -1
>> +       .ctl_fd_ack             = -1,
>> +       .iiostat_run            = false,
>>   };
>>
>>   static bool cpus_map_matched(struct evsel *a, struct evsel *b)
>> @@ -1073,6 +1075,14 @@ static int parse_stat_cgroups(const struct option *opt,
>>          return parse_cgroups(opt, str, unset);
>>   }
>>
>> +__weak int iiostat_parse(const struct option *opt __maybe_unused,
>> +                        const char *str __maybe_unused,
>> +                        int unset __maybe_unused)
>> +{
>> +       pr_err("iiostat mode is not supported\n");
>> +       return -1;
>> +}
>> +
>>   static struct option stat_options[] = {
>>          OPT_BOOLEAN('T', "transaction", &transaction_run,
>>                      "hardware transaction statistics"),
>> @@ -1185,6 +1195,8 @@ static struct option stat_options[] = {
>>                       "\t\t\t  Optionally send control command completion ('ack\\n') to ack-fd descriptor.\n"
>>                       "\t\t\t  Alternatively, ctl-fifo / ack-fifo will be opened and used as ctl-fd / ack-fd.",
>>                        parse_control_option),
>> +       OPT_CALLBACK_OPTARG(0, "iiostat", &evsel_list, &stat_config, "root port",
>> +                           "measure PCIe metrics per IIO stack", iiostat_parse),
>>          OPT_END()
>>   };
>>
>> @@ -1509,6 +1521,12 @@ static int perf_stat_init_aggr_mode_file(struct perf_stat *st)
>>          return 0;
>>   }
>>
>> +__weak int iiostat_show_root_ports(struct evlist *evlist __maybe_unused,
>> +                                  struct perf_stat_config *config __maybe_unused)
>> +{
>> +       return 0;
>> +}
> I think it's too specific, maybe iiostat_prepare() ?
What do you think about iiostat_show_root_ports() -> iiostat_show()?
>
>> +
>>   /*
>>    * Add default attributes, if there were no attributes specified or
>>    * if -d/--detailed, -d -d or -d -d -d is used:
>> @@ -2054,6 +2072,10 @@ static void setup_system_wide(int forks)
>>          }
>>   }
>>
>> +__weak void iiostat_delete_root_ports(struct evlist *evlist __maybe_unused)
>> +{
>> +}
> Same here..
I suggest to rename iiostat_delete_root_ports() -> iiostat_release().
What do you think?
>
>> +
>>   int cmd_stat(int argc, const char **argv)
>>   {
>>          const char * const stat_usage[] = {
>> @@ -2230,6 +2252,12 @@ int cmd_stat(int argc, const char **argv)
>>                  goto out;
>>          }
>>
>> +       if (stat_config.iiostat_run) {
>> +               status = iiostat_show_root_ports(evsel_list, &stat_config);
>> +               if (status || !stat_config.iiostat_run)
>> +                       goto out;
>> +       }
>> +
>>          if (add_default_attributes())
>>                  goto out;
>>
>> @@ -2406,6 +2434,9 @@ int cmd_stat(int argc, const char **argv)
>>          perf_stat__exit_aggr_mode();
>>          perf_evlist__free_stats(evsel_list);
>>   out:
>> +       if (stat_config.iiostat_run)
>> +               iiostat_delete_root_ports(evsel_list);
>> +
>>          zfree(&stat_config.walltime_run);
>>
>>          if (smi_cost && smi_reset)
>> diff --git a/tools/perf/util/iiostat.h b/tools/perf/util/iiostat.h
>> new file mode 100644
>> index 000000000000..8d4226df9975
>> --- /dev/null
>> +++ b/tools/perf/util/iiostat.h
>> @@ -0,0 +1,33 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * perf iiostat
>> + *
>> + * Copyright (C) 2020, Intel Corporation
>> + *
>> + * Authors: Alexander Antonov <alexander.antonov@linux.intel.com>
>> + */
>> +
>> +#ifndef _IIOSTAT_H
>> +#define _IIOSTAT_H
>> +
>> +#include <subcmd/parse-options.h>
>> +#include "util/stat.h"
>> +#include "util/parse-events.h"
>> +#include "util/evlist.h"
>> +
>> +struct option;
>> +struct perf_stat_config;
>> +struct evlist;
>> +struct timespec;
>> +
>> +int iiostat_parse(const struct option *opt, const char *str,
>> +                 int unset __maybe_unused);
>> +void iiostat_prefix(struct perf_stat_config *config, struct evlist *evlist,
>> +                   char *prefix, struct timespec *ts);
>> +void iiostat_print_metric(struct perf_stat_config *config, struct evsel *evsel,
>> +                         struct perf_stat_output_ctx *out);
>> +int iiostat_show_root_ports(struct evlist *evlist,
>> +                           struct perf_stat_config *config);
>> +void iiostat_delete_root_ports(struct evlist *evlist);
>> +
>> +#endif /* _IIOSTAT_H */
>> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
>> index 3bfcdb80443a..9eb8484e8b90 100644
>> --- a/tools/perf/util/stat-display.c
>> +++ b/tools/perf/util/stat-display.c
>> @@ -17,6 +17,7 @@
>>   #include "cgroup.h"
>>   #include <api/fs/fs.h>
>>   #include "util.h"
>> +#include "iiostat.h"
>>
>>   #define CNTR_NOT_SUPPORTED     "<not supported>"
>>   #define CNTR_NOT_COUNTED       "<not counted>"
>> @@ -310,6 +311,12 @@ static void print_metric_header(struct perf_stat_config *config,
>>          struct outstate *os = ctx;
>>          char tbuf[1024];
>>
>> +       /* In case of iiostat, print metric header for first perf_device only */
>> +       if (os->evsel->perf_device && os->evsel->evlist->selected->perf_device &&
>> +           config->iiostat_run &&
> When is the perf_device set?  Is it possible to be NULL in the iiostat mode?
>
> Thanks,
> Namhyung
>
The perf_device field is initialized inside iiostat.c::iiostat_event_group()
and it cannot be NULL.
The idea is to attribute events to PCIe ports through perf_device field.

Thanks,
Alexander
>> +           os->evsel->perf_device != os->evsel->evlist->selected->perf_device)
>> +               return;
>> +
>>          if (!valid_only_metric(unit))
>>                  return;
>>          unit = fixunit(tbuf, os->evsel, unit);
