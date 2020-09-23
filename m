Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDD162763AD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 00:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgIWWQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 18:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgIWWQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 18:16:33 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80325C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 15:16:33 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id m6so1677435wrn.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 15:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7ADJqoF6wWW6Oms9AAY55bfxRkoRCueqtCCQVjzSVhk=;
        b=REK8iHVZGyiQbSYIqyUWWDDzzuBdLV4aNiwWid3MpkfhdGiicmAbvzd4oEJ1+bHR2d
         QaC/PaX5jfxhdg/vlfu9zUDiMWG6Qtx4NryLmZLiP7zyQN+MU71M+LdrPincXHYxoT7e
         w+DGqrwhfkmUdnebeBNuKyLaiCcO4ugPcJGG9lp+pECv2Lh/J6cNPqLa74MJE5LKMJrJ
         BitLR0Ybjq48bnBf9mlhRabkUPY7pQe7rzUHMK72hGxyhJJOaOlHPuQ6EvocQQccRzym
         bJ+RolhFds1WBUHgwXYHXI9HrIScOspNlnhvNSxPrZj1WL6Xpq/z45eIcKhUOwxU6CI1
         KcBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7ADJqoF6wWW6Oms9AAY55bfxRkoRCueqtCCQVjzSVhk=;
        b=cQ/PAPC4fUPSUsEzstTeRF2Bwi3MFcSMKXQkQFiarYgsx232BjAJpbsz9NwE3mfxcd
         iM8BR2UvrdacubwrLl0fmkFa/ZHVsKiXMLa1MviV2DH/4ePES4/kLyzwNa6earqV5W8P
         CZbMZD58LvkNhrWyysz4xTWDuuwCanrpyRUn2TT5Tsi/h3HlcdFMEdDNnsGKJSA7pLQ3
         BKMSxUpwQAs+EdQAG+T6pSBNingZ/2CfLxPR2Ve92zgOcm9DpfknobBdCQokMhRFkHZp
         8cryRiP9+kI03BDAksSR1mOFMZEV9oKGTniEgDsFcuCts3rEfIWiQHV64pA0GjmuuIdl
         IRYA==
X-Gm-Message-State: AOAM533h6TW0gVP9htrIlALfWR0wXLOQWDkG7LkEqFbG7bP9u2kTKcIg
        Oup6/ueO358tYv3T+X95vHjGjFtkpYTw7AJNziG17w==
X-Google-Smtp-Source: ABdhPJziqtbR7QcGm4vtpcBM6YlRNyymin5Qx9NvRlKXbjVL1MfGA3AueNYlSU9h3AxtFawLPYvjcGEsBKXz77Ly+rg=
X-Received: by 2002:adf:f5c1:: with SMTP id k1mr1869716wrp.271.1600899391953;
 Wed, 23 Sep 2020 15:16:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200923080537.155264-1-namhyung@kernel.org> <20200923080537.155264-6-namhyung@kernel.org>
In-Reply-To: <20200923080537.155264-6-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 23 Sep 2020 15:16:20 -0700
Message-ID: <CAP-5=fUpDcrAXmC1_-NxiCORh50Cv1ryvUFAHF_F0=Jp0qxSCQ@mail.gmail.com>
Subject: Re: [PATCH 5/7] perf inject: Add --buildid-all option
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 1:06 AM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Like perf record, we can even more speedup build-id processing by just
> using all DSOs.  Then we don't need to look at all the sample events
> anymore.  The following patch will update perf bench to show the
> result of the --buildid-all option too.
>
> Original-patch-by: Stephane Eranian <eranian@google.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/Documentation/perf-inject.txt |   6 +-
>  tools/perf/builtin-inject.c              | 112 ++++++++++++++++++++++-
>  2 files changed, 112 insertions(+), 6 deletions(-)
>
> diff --git a/tools/perf/Documentation/perf-inject.txt b/tools/perf/Documentation/perf-inject.txt
> index 70969ea73e01..a8eccff21281 100644
> --- a/tools/perf/Documentation/perf-inject.txt
> +++ b/tools/perf/Documentation/perf-inject.txt
> @@ -24,8 +24,12 @@ information could make use of this facility.
>  OPTIONS
>  -------
>  -b::
> ---build-ids=::
> +--build-ids::
>          Inject build-ids into the output stream
> +
> +--buildid-all:
> +       Inject build-ids of all DSOs into the output stream
> +
>  -v::
>  --verbose::
>         Be more verbose.
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index d0aa365e7294..500428aaa576 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -10,6 +10,7 @@
>
>  #include "util/color.h"
>  #include "util/dso.h"
> +#include "util/vdso.h"
>  #include "util/evlist.h"
>  #include "util/evsel.h"
>  #include "util/map.h"
> @@ -36,6 +37,7 @@ struct perf_inject {
>         struct perf_tool        tool;
>         struct perf_session     *session;
>         bool                    build_ids;
> +       bool                    build_id_all;
>         bool                    sched_stat;
>         bool                    have_auxtrace;
>         bool                    strip;
> @@ -55,6 +57,9 @@ struct event_entry {
>         union perf_event event[];
>  };
>
> +static int dso__inject_build_id(struct dso *dso, struct perf_tool *tool,
> +                               struct machine *machine, u8 cpumode);
> +
>  static int output_bytes(struct perf_inject *inject, void *buf, size_t sz)
>  {
>         ssize_t size;
> @@ -318,6 +323,68 @@ static int perf_event__jit_repipe_mmap(struct perf_tool *tool,
>  }
>  #endif
>
> +static struct dso *findnew_dso(int pid, int tid, const char *filename,
> +                              struct dso_id *id, struct machine *machine)
> +{
> +       struct thread *thread;
> +       struct nsinfo *nsi = NULL;
> +       struct nsinfo *nnsi;
> +       struct dso *dso;
> +       bool vdso;
> +
> +       thread = machine__findnew_thread(machine, pid, tid);
> +       if (thread == NULL) {
> +               pr_err("cannot find or create a task %d/%d.\n", tid, pid);
> +               return NULL;
> +       }
> +
> +       vdso = is_vdso_map(filename);
> +       nsi = nsinfo__get(thread->nsinfo);
> +
> +       if (vdso) {
> +               /* The vdso maps are always on the host and not the
> +                * container.  Ensure that we don't use setns to look
> +                * them up.
> +                */
> +               nnsi = nsinfo__copy(nsi);
> +               if (nnsi) {
> +                       nsinfo__put(nsi);
> +                       nnsi->need_setns = false;
> +                       nsi = nnsi;
> +               }
> +               dso = machine__findnew_vdso(machine, thread);
> +       } else {
> +               dso = machine__findnew_dso_id(machine, filename, id);
> +       }
> +
> +       if (dso)
> +               dso->nsinfo = nsi;
> +       else
> +               nsinfo__put(nsi);
> +
> +       thread__put(thread);
> +       return dso;
> +}
> +
> +static int perf_event__repipe_buildid_mmap(struct perf_tool *tool,
> +                                          union perf_event *event,
> +                                          struct perf_sample *sample,
> +                                          struct machine *machine)
> +{
> +       struct dso *dso;
> +
> +       dso = findnew_dso(event->mmap.pid, event->mmap.tid,
> +                         event->mmap.filename, NULL, machine);
> +
> +       if (dso && !dso->hit) {
> +               dso->hit = 1;
> +               dso__inject_build_id(dso, tool, machine, sample->cpumode);
> +               dso__put(dso);
> +       }
> +
> +       return perf_event__repipe(tool, event, sample, machine);
> +}
> +
>  static int perf_event__repipe_mmap2(struct perf_tool *tool,
>                                    union perf_event *event,
>                                    struct perf_sample *sample,
> @@ -356,6 +423,33 @@ static int perf_event__jit_repipe_mmap2(struct perf_tool *tool,
>  }
>  #endif
>
> +static int perf_event__repipe_buildid_mmap2(struct perf_tool *tool,
> +                                           union perf_event *event,
> +                                           struct perf_sample *sample,
> +                                           struct machine *machine)
> +{
> +       struct dso_id dso_id = {
> +               .maj = event->mmap2.maj,
> +               .min = event->mmap2.min,
> +               .ino = event->mmap2.ino,
> +               .ino_generation = event->mmap2.ino_generation,
> +       };
> +       struct dso *dso;
> +
> +       dso = findnew_dso(event->mmap2.pid, event->mmap2.tid,
> +                         event->mmap2.filename, &dso_id, machine);
> +
> +       if (dso && !dso->hit) {
> +               dso->hit = 1;
> +               dso__inject_build_id(dso, tool, machine, sample->cpumode);
> +               dso__put(dso);
> +       }
> +
> +       perf_event__repipe(tool, event, sample, machine);
> +
> +       return 0;
> +}
> +
>  static int perf_event__repipe_fork(struct perf_tool *tool,
>                                    union perf_event *event,
>                                    struct perf_sample *sample,
> @@ -613,7 +707,7 @@ static int __cmd_inject(struct perf_inject *inject)
>         signal(SIGINT, sig_handler);
>
>         if (inject->build_ids || inject->sched_stat ||
> -           inject->itrace_synth_opts.set) {
> +           inject->itrace_synth_opts.set || inject->build_id_all) {
>                 inject->tool.mmap         = perf_event__repipe_mmap;
>                 inject->tool.mmap2        = perf_event__repipe_mmap2;
>                 inject->tool.fork         = perf_event__repipe_fork;
> @@ -622,7 +716,10 @@ static int __cmd_inject(struct perf_inject *inject)
>
>         output_data_offset = session->header.data_offset;
>
> -       if (inject->build_ids) {
> +       if (inject->build_id_all) {
> +               inject->tool.mmap         = perf_event__repipe_buildid_mmap;
> +               inject->tool.mmap2        = perf_event__repipe_buildid_mmap2;
> +       } else if (inject->build_ids) {
>                 inject->tool.sample = perf_event__inject_buildid;
>         } else if (inject->sched_stat) {
>                 struct evsel *evsel;
> @@ -766,6 +863,8 @@ int cmd_inject(int argc, const char **argv)
>         struct option options[] = {
>                 OPT_BOOLEAN('b', "build-ids", &inject.build_ids,
>                             "Inject build-ids into the output stream"),
> +               OPT_BOOLEAN(0, "buildid-all", &inject.build_id_all,
> +                           "Inject build-ids of all DSOs into the output stream"),
>                 OPT_STRING('i', "input", &inject.input_name, "file",
>                            "input file name"),
>                 OPT_STRING('o', "output", &inject.output.path, "file",
> @@ -814,8 +913,6 @@ int cmd_inject(int argc, const char **argv)
>                 return -1;
>         }
>
> -       inject.tool.ordered_events = inject.sched_stat;
> -
>         data.path = inject.input_name;
>         inject.session = perf_session__new(&data, true, &inject.tool);
>         if (IS_ERR(inject.session))
> @@ -824,7 +921,7 @@ int cmd_inject(int argc, const char **argv)
>         if (zstd_init(&(inject.session->zstd_data), 0) < 0)
>                 pr_warning("Decompression initialization failed.\n");
>
> -       if (inject.build_ids) {
> +       if (inject.build_ids && !inject.build_id_all) {
>                 /*
>                  * to make sure the mmap records are ordered correctly
>                  * and so that the correct especially due to jitted code
> @@ -834,6 +931,11 @@ int cmd_inject(int argc, const char **argv)
>                 inject.tool.ordered_events = true;
>                 inject.tool.ordering_requires_timestamps = true;
>         }
> +
> +       if (inject.sched_stat) {
> +               inject.tool.ordered_events = true;
> +       }
> +
>  #ifdef HAVE_JITDUMP
>         if (inject.jit_mode) {
>                 inject.tool.mmap2          = perf_event__jit_repipe_mmap2;
> --
> 2.28.0.681.g6f77f65b4e-goog
>
