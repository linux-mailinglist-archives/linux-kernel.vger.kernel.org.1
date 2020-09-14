Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4C362684DC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 08:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbgINGbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 02:31:09 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44610 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbgINGbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 02:31:06 -0400
Received: by mail-wr1-f66.google.com with SMTP id s12so17297654wrw.11
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 23:31:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hl8hTr4cbxm9Qx8HdIMf4rTLZh56bTncsMLVlRaBM0M=;
        b=U2JylFc/qbDETSc/Gn39LFem0D59h1GOormD/xV01f9N7yBm1BHRQRte0RrlOOFr9a
         E/hwDKQp6RaXwx9Oji9DJtPcnSSk7an7GyVB8mvfXM8epSOctITPGboHOh3uxRyfhywL
         DzApe5sMZAlPawXyiAYvbnIZiBfdCSwrG0R0FjnwjZX8q1YNqBpCLBIJMUz3yW6gVmxu
         VCpYmLYQ9RvDDd4R2SShwYPv7wdoeVhUdZRQ5TD/GtSZtzocKYjE8PcfWZxBokYoWibb
         9oMGgbFqprY2Y5QssmI4WwAd/sWOXCggPr8j3noqSUJvTiM/G1WtV7m7C/k9TGSIxmwT
         GhGQ==
X-Gm-Message-State: AOAM532TqRJ/q598P280auiNb9cGgk9qKOfEYX3eskEtUvMEX7hKmz3o
        WtHmz5AjmlFR02Dnam0lM/Hczg1LthGs/EA+OqFAKdzLqF8=
X-Google-Smtp-Source: ABdhPJyWumlfmsIA9ArzNwL6HHaJHiCpsVPkutojGzRa5zdjLVMvcbEYdaAh1y1uZYN1rYDrTs9IgRWv9etGj4RLn7A=
X-Received: by 2002:adf:a418:: with SMTP id d24mr6319402wra.80.1600065064551;
 Sun, 13 Sep 2020 23:31:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200913210313.1985612-1-jolsa@kernel.org> <20200913210313.1985612-15-jolsa@kernel.org>
In-Reply-To: <20200913210313.1985612-15-jolsa@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 14 Sep 2020 15:30:53 +0900
Message-ID: <CAM9d7ciCCHRW2zs8LNCSsCBSgsLgK-CkyAzQjqXxFj+Y5Ss2-A@mail.gmail.com>
Subject: Re: [PATCH 14/26] perf tools: Add mmap3 events to --show-mmap-events option
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 6:04 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Displaying mmap3 events for --show-mmap-events option,
> the build id is displayed within <> braces:
>
>   $ perf script --show-mmap-events
>   kill 12148 13893.519014: PERF_RECORD_MMAP3 12148/12148: <43938d0803c5e3130ea679cd569aaf44b98d9ae8> [0x560e7d7f..
>   kill 12148 13893.519420: PERF_RECORD_MMAP3 12148/12148: <1805c738c8f3ec0f47b7ea09080c28f34d18a82b> [0x7f9e7dfc..
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/builtin-script.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index d839983cfb88..9c09581d5cb0 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -2342,6 +2342,38 @@ static int process_mmap2_event(struct perf_tool *tool,
>                            event->mmap2.tid);
>  }
>
> +static int process_mmap3_event(struct perf_tool *tool,
> +                             union perf_event *event,
> +                             struct perf_sample *sample,
> +                             struct machine *machine)
> +{
> +       struct thread *thread;
> +       struct perf_script *script = container_of(tool, struct perf_script, tool);
> +       struct perf_session *session = script->session;
> +       struct evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
> +
> +       if (perf_event__process_mmap3(tool, event, sample, machine) < 0)
> +               return -1;
> +
> +       thread = machine__findnew_thread(machine, event->mmap3.pid, event->mmap3.tid);
> +       if (thread == NULL) {
> +               pr_debug("problem processing MMAP2 event, skipping it.\n");

MMAP3 ?

Thanks
Namhyung


> +               return -1;
> +       }
> +
> +       if (!evsel->core.attr.sample_id_all) {
> +               sample->cpu = 0;
> +               sample->time = 0;
> +               sample->tid = event->mmap3.tid;
> +               sample->pid = event->mmap3.pid;
> +       }
> +       perf_sample__fprintf_start(script, sample, thread, evsel,
> +                                  PERF_RECORD_MMAP3, stdout);
> +       perf_event__fprintf(event, machine, stdout);
> +       thread__put(thread);
> +       return 0;
> +}
> +
>  static int process_switch_event(struct perf_tool *tool,
>                                 union perf_event *event,
>                                 struct perf_sample *sample,
> @@ -2498,6 +2530,7 @@ static int __cmd_script(struct perf_script *script)
>         if (script->show_mmap_events) {
>                 script->tool.mmap = process_mmap_event;
>                 script->tool.mmap2 = process_mmap2_event;
> +               script->tool.mmap3 = process_mmap3_event;
>         }
>         if (script->show_switch_events || (scripting_ops && scripting_ops->process_switch))
>                 script->tool.context_switch = process_switch_event;
> --
> 2.26.2
>
