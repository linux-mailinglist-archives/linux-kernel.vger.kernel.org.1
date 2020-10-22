Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFD7B295747
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 06:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgJVE32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 00:29:28 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39579 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbgJVE32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 00:29:28 -0400
Received: by mail-wr1-f65.google.com with SMTP id y12so373599wrp.6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 21:29:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B1PZk4YnT70XXAQb4BzoHUsE1zNWJHqDXo+bTI3+Xr0=;
        b=HQnEW8LnaMsIYR4ITVjGe1iN/sg9F1cH4LZX2QtpYirrR1cY2Xj/zgvO/PSQ5zy2/O
         9TbN+uwxpMJPunW4Jx1X/KmA/k0c7maFBNJmaEJuR0MohMxoE4YC+bSBiG0gCSw3ohG9
         H6eKad0g1QefML3i0K4R475PnQ1Kp8hm9QPA3PnsgzDCVjgdYLxJEzHEay/Z2b7d9LkI
         sKSGyXphSByFY3M3bFElYcfINz9DzDAPPYyK3TOZT23UDJuhM7+uZGIbvLS12h3s+bnM
         6+CpvoSP3oRJJ/PuE3IIgITzpvOW6bunsGbDLhn6NifImX63965JMU/hJwUmYD11lY7Z
         DrDA==
X-Gm-Message-State: AOAM533bNv//XoZsWMOmpObaOzul6hFM2OITroIcnBnNIx2xfXZUGFRQ
        phxTvwmep+COmDdqU70FDj3f1uAQgYh7ViqukaI=
X-Google-Smtp-Source: ABdhPJwRz6wqQkqvX+KdpPjaI7CBbUEhyVImFHQysFVK8wlyvIRDl6XXIWQZmiZcwWMTMbNGD7aqPVII1bKJ0D15ZL0=
X-Received: by 2002:adf:a345:: with SMTP id d5mr550947wrb.55.1603340963832;
 Wed, 21 Oct 2020 21:29:23 -0700 (PDT)
MIME-Version: 1.0
References: <1ec29ed6-0047-d22f-630b-a7f5ccee96b4@linux.intel.com> <51b4b576-628f-3bbd-da0c-5aab262dae4a@linux.intel.com>
In-Reply-To: <51b4b576-628f-3bbd-da0c-5aab262dae4a@linux.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 22 Oct 2020 13:29:12 +0900
Message-ID: <CAM9d7cjf4516tB=LD7zzGkzTtj3mop=ESn65jcp-Bv0=JVrWDw@mail.gmail.com>
Subject: Re: [PATCH v2 02/15] perf report: output trace file name in raw trace dump
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 12:57 AM Alexey Budankov
<alexey.budankov@linux.intel.com> wrote:
>
>
> Print path and name of a trace file into raw dump (-D)
> <file_offset>@<path/file>. Print offset of PERF_RECORD_COMPRESSED
> record instead of zero for decompressed records:
>   0x2226a@perf.data [0x30]: event: 9
> or
>   0x15cc36@perf.data/data.7 [0x30]: event: 9
>
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks
Namhyung

> ---
>  tools/perf/builtin-inject.c |  3 +-
>  tools/perf/util/session.c   | 75 ++++++++++++++++++++++---------------
>  tools/perf/util/tool.h      |  3 +-
>  3 files changed, 48 insertions(+), 33 deletions(-)
>
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index 452a75fe68e5..037f8a98220c 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -106,7 +106,8 @@ static int perf_event__repipe_op2_synth(struct perf_session *session,
>
>  static int perf_event__repipe_op4_synth(struct perf_session *session,
>                                         union perf_event *event,
> -                                       u64 data __maybe_unused)
> +                                       u64 data __maybe_unused,
> +                                       const char *str __maybe_unused)
>  {
>         return perf_event__repipe_synth(session->tool, event);
>  }
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 4478ddae485b..6f09d506b2f6 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -36,7 +36,8 @@
>
>  #ifdef HAVE_ZSTD_SUPPORT
>  static int perf_session__process_compressed_event(struct perf_session *session,
> -                                                 union perf_event *event, u64 file_offset)
> +                                                 union perf_event *event, u64 file_offset,
> +                                                 const char *file_path)
>  {
>         void *src;
>         size_t decomp_size, src_size;
> @@ -58,6 +59,7 @@ static int perf_session__process_compressed_event(struct perf_session *session,
>         }
>
>         decomp->file_pos = file_offset;
> +       decomp->file_path = file_path;
>         decomp->mmap_len = mmap_len;
>         decomp->head = 0;
>
> @@ -98,7 +100,8 @@ static int perf_session__process_compressed_event(struct perf_session *session,
>  static int perf_session__deliver_event(struct perf_session *session,
>                                        union perf_event *event,
>                                        struct perf_tool *tool,
> -                                      u64 file_offset);
> +                                      u64 file_offset,
> +                                      const char *file_path);
>
>  static int perf_session__open(struct perf_session *session)
>  {
> @@ -180,7 +183,8 @@ static int ordered_events__deliver_event(struct ordered_events *oe,
>                                                     ordered_events);
>
>         return perf_session__deliver_event(session, event->event,
> -                                          session->tool, event->file_offset);
> +                                          session->tool, event->file_offset,
> +                                          event->file_path);
>  }
>
>  struct perf_session *perf_session__new(struct perf_data *data,
> @@ -452,7 +456,8 @@ static int process_stat_round_stub(struct perf_session *perf_session __maybe_unu
>
>  static int perf_session__process_compressed_event_stub(struct perf_session *session __maybe_unused,
>                                                        union perf_event *event __maybe_unused,
> -                                                      u64 file_offset __maybe_unused)
> +                                                      u64 file_offset __maybe_unused,
> +                                                      const char *file_path __maybe_unused)
>  {
>         dump_printf(": unhandled!\n");
>         return 0;
> @@ -1227,13 +1232,14 @@ static void sample_read__printf(struct perf_sample *sample, u64 read_format)
>  }
>
>  static void dump_event(struct evlist *evlist, union perf_event *event,
> -                      u64 file_offset, struct perf_sample *sample)
> +                      u64 file_offset, struct perf_sample *sample,
> +                      const char *file_path)
>  {
>         if (!dump_trace)
>                 return;
>
> -       printf("\n%#" PRIx64 " [%#x]: event: %d\n",
> -              file_offset, event->header.size, event->header.type);
> +       printf("\n%#" PRIx64 "@%s [%#x]: event: %d\n",
> +              file_offset, file_path, event->header.size, event->header.type);
>
>         trace_event(event);
>         if (event->header.type == PERF_RECORD_SAMPLE && evlist->trace_event_sample_raw)
> @@ -1424,12 +1430,13 @@ static int machines__deliver_event(struct machines *machines,
>                                    struct evlist *evlist,
>                                    union perf_event *event,
>                                    struct perf_sample *sample,
> -                                  struct perf_tool *tool, u64 file_offset)
> +                                  struct perf_tool *tool, u64 file_offset,
> +                                  const char *file_path)
>  {
>         struct evsel *evsel;
>         struct machine *machine;
>
> -       dump_event(evlist, event, file_offset, sample);
> +       dump_event(evlist, event, file_offset, sample, file_path);
>
>         evsel = perf_evlist__id2evsel(evlist, sample->id);
>
> @@ -1506,7 +1513,8 @@ static int machines__deliver_event(struct machines *machines,
>  static int perf_session__deliver_event(struct perf_session *session,
>                                        union perf_event *event,
>                                        struct perf_tool *tool,
> -                                      u64 file_offset)
> +                                      u64 file_offset,
> +                                      const char *file_path)
>  {
>         struct perf_sample sample;
>         int ret;
> @@ -1524,7 +1532,7 @@ static int perf_session__deliver_event(struct perf_session *session,
>                 return 0;
>
>         ret = machines__deliver_event(&session->machines, session->evlist,
> -                                     event, &sample, tool, file_offset);
> +                                     event, &sample, tool, file_offset, file_path);
>
>         if (dump_trace && sample.aux_sample.size)
>                 auxtrace__dump_auxtrace_sample(session, &sample);
> @@ -1534,7 +1542,8 @@ static int perf_session__deliver_event(struct perf_session *session,
>
>  static s64 perf_session__process_user_event(struct perf_session *session,
>                                             union perf_event *event,
> -                                           u64 file_offset)
> +                                           u64 file_offset,
> +                                           const char *file_path)
>  {
>         struct ordered_events *oe = &session->ordered_events;
>         struct perf_tool *tool = session->tool;
> @@ -1544,7 +1553,7 @@ static s64 perf_session__process_user_event(struct perf_session *session,
>
>         if (event->header.type != PERF_RECORD_COMPRESSED ||
>             tool->compressed == perf_session__process_compressed_event_stub)
> -               dump_event(session->evlist, event, file_offset, &sample);
> +               dump_event(session->evlist, event, file_offset, &sample, file_path);
>
>         /* These events are processed right away */
>         switch (event->header.type) {
> @@ -1603,9 +1612,9 @@ static s64 perf_session__process_user_event(struct perf_session *session,
>         case PERF_RECORD_HEADER_FEATURE:
>                 return tool->feature(session, event);
>         case PERF_RECORD_COMPRESSED:
> -               err = tool->compressed(session, event, file_offset);
> +               err = tool->compressed(session, event, file_offset, file_path);
>                 if (err)
> -                       dump_event(session->evlist, event, file_offset, &sample);
> +                       dump_event(session->evlist, event, file_offset, &sample, file_path);
>                 return err;
>         default:
>                 return -EINVAL;
> @@ -1622,9 +1631,9 @@ int perf_session__deliver_synth_event(struct perf_session *session,
>         events_stats__inc(&evlist->stats, event->header.type);
>
>         if (event->header.type >= PERF_RECORD_USER_TYPE_START)
> -               return perf_session__process_user_event(session, event, 0);
> +               return perf_session__process_user_event(session, event, 0, NULL);
>
> -       return machines__deliver_event(&session->machines, evlist, event, sample, tool, 0);
> +       return machines__deliver_event(&session->machines, evlist, event, sample, tool, 0, NULL);
>  }
>
>  static void event_swap(union perf_event *event, bool sample_id_all)
> @@ -1720,7 +1729,8 @@ int perf_session__peek_events(struct perf_session *session, u64 offset,
>  }
>
>  static s64 perf_session__process_event(struct perf_session *session,
> -                                      union perf_event *event, u64 file_offset)
> +                                      union perf_event *event, u64 file_offset,
> +                                      const char *file_path)
>  {
>         struct evlist *evlist = session->evlist;
>         struct perf_tool *tool = session->tool;
> @@ -1735,7 +1745,7 @@ static s64 perf_session__process_event(struct perf_session *session,
>         events_stats__inc(&evlist->stats, event->header.type);
>
>         if (event->header.type >= PERF_RECORD_USER_TYPE_START)
> -               return perf_session__process_user_event(session, event, file_offset);
> +               return perf_session__process_user_event(session, event, file_offset, file_path);
>
>         if (tool->ordered_events) {
>                 u64 timestamp = -1ULL;
> @@ -1749,7 +1759,7 @@ static s64 perf_session__process_event(struct perf_session *session,
>                         return ret;
>         }
>
> -       return perf_session__deliver_event(session, event, tool, file_offset);
> +       return perf_session__deliver_event(session, event, tool, file_offset, file_path);
>  }
>
>  void perf_event_header__bswap(struct perf_event_header *hdr)
> @@ -1987,7 +1997,8 @@ static int __perf_session__process_pipe_events(struct perf_session *session)
>                 }
>         }
>
> -       if ((skip = perf_session__process_event(session, event, head)) < 0) {
> +       skip = perf_session__process_event(session, event, head, "pipe");
> +       if (skip < 0) {
>                 pr_err("%#" PRIx64 " [%#x]: failed to process type: %d\n",
>                        head, event->header.size, event->header.type);
>                 err = -EINVAL;
> @@ -2068,7 +2079,7 @@ fetch_decomp_event(u64 head, size_t mmap_size, char *buf, bool needs_swap)
>  static int __perf_session__process_decomp_events(struct perf_session *session)
>  {
>         s64 skip;
> -       u64 size, file_pos = 0;
> +       u64 size;
>         struct decomp *decomp = session->decomp_last;
>
>         if (!decomp)
> @@ -2082,9 +2093,9 @@ static int __perf_session__process_decomp_events(struct perf_session *session)
>                         break;
>
>                 size = event->header.size;
> -
> -               if (size < sizeof(struct perf_event_header) ||
> -                   (skip = perf_session__process_event(session, event, file_pos)) < 0) {
> +               skip = perf_session__process_event(session, event, decomp->file_pos,
> +                                                  decomp->file_path);
> +               if (size < sizeof(struct perf_event_header) || skip < 0) {
>                         pr_err("%#" PRIx64 " [%#x]: failed to process type: %d\n",
>                                 decomp->file_pos + decomp->head, event->header.size, event->header.type);
>                         return -EINVAL;
> @@ -2115,7 +2126,8 @@ struct reader;
>
>  typedef s64 (*reader_cb_t)(struct perf_session *session,
>                            union perf_event *event,
> -                          u64 file_offset);
> +                          u64 file_offset,
> +                          const char *file_path);
>
>  struct reader {
>         int              fd;
> @@ -2198,9 +2210,9 @@ reader__process_events(struct reader *rd, struct perf_session *session,
>         skip = -EINVAL;
>
>         if (size < sizeof(struct perf_event_header) ||
> -           (skip = rd->process(session, event, file_pos)) < 0) {
> -               pr_err("%#" PRIx64 " [%#x]: failed to process type: %d [%s]\n",
> -                      file_offset + head, event->header.size,
> +           (skip = rd->process(session, event, file_pos, rd->path)) < 0) {
> +               pr_err("%#" PRIx64 " [%s] [%#x]: failed to process type: %d [%s]\n",
> +                      file_offset + head, rd->path, event->header.size,
>                        event->header.type, strerror(-skip));
>                 err = skip;
>                 goto out;
> @@ -2230,9 +2242,10 @@ reader__process_events(struct reader *rd, struct perf_session *session,
>
>  static s64 process_simple(struct perf_session *session,
>                           union perf_event *event,
> -                         u64 file_offset)
> +                         u64 file_offset,
> +                         const char *file_path)
>  {
> -       return perf_session__process_event(session, event, file_offset);
> +       return perf_session__process_event(session, event, file_offset, file_path);
>  }
>
>  static int __perf_session__process_events(struct perf_session *session)
> diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
> index bbbc0dcd461f..c966531d3eca 100644
> --- a/tools/perf/util/tool.h
> +++ b/tools/perf/util/tool.h
> @@ -28,7 +28,8 @@ typedef int (*event_attr_op)(struct perf_tool *tool,
>
>  typedef int (*event_op2)(struct perf_session *session, union perf_event *event);
>  typedef s64 (*event_op3)(struct perf_session *session, union perf_event *event);
> -typedef int (*event_op4)(struct perf_session *session, union perf_event *event, u64 data);
> +typedef int (*event_op4)(struct perf_session *session, union perf_event *event, u64 data,
> +                        const char *str);
>
>  typedef int (*event_oe)(struct perf_tool *tool, union perf_event *event,
>                         struct ordered_events *oe);
> --
> 2.24.1
>
