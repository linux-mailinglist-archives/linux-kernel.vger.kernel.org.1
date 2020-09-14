Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C11822684D5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 08:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbgINGZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 02:25:53 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36280 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbgINGZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 02:25:53 -0400
Received: by mail-wr1-f66.google.com with SMTP id z1so17312826wrt.3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 23:25:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w4YrKCb/S3dilvuEzkM/D0tKbwmjr/FYtuihp4D7ajc=;
        b=OeYl9xXel8DSOgVPtLNnV5kAhggq+tuVOmqsy94KJBqkbB3xvMrKvNx5jksLaO0Mwc
         FUXjSxr45nkPL52pCfjNPumaGbdqqjqEdXQNemXzkphuXyzycHNi0vuWEIgSH3GLDJ/d
         tg+Ii/wJg4qsfLD6SxG5M+h3tpsCN5504Q6IXeDLbyrmnuqwPyc+lf870r1ROAfWFn3M
         Mn5hjYOXnagnQuRufgwnahbwtTxJzS+YFpysaf1XL7gNNq+S8GfCn/iyjUPar+7Zr1Fc
         /ryENI6WE+Sc4IHAuw2/J+MuiPQcx0res3/RdtboBOtKtr0FZHVysCyX4d2uefvqZImR
         rznw==
X-Gm-Message-State: AOAM531xmlksiwZxOYs7fHzLjKzncWesQPV3DwCuEgDGE572XeZ7G/b4
        PT/oRPRs0MvRJBTvxeQsn8w8O5aYMtOdfqB41Tk=
X-Google-Smtp-Source: ABdhPJzPUg7P3mbyP7iMK6nGH/mBxa8S7+E/MjUeV7OtX2CMuZYzrrWJO1OwnJaMHP4eI39gDoAh3MRttyJtcjPgEDE=
X-Received: by 2002:adf:e481:: with SMTP id i1mr14069408wrm.391.1600064750965;
 Sun, 13 Sep 2020 23:25:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200913210313.1985612-1-jolsa@kernel.org> <20200913210313.1985612-10-jolsa@kernel.org>
In-Reply-To: <20200913210313.1985612-10-jolsa@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 14 Sep 2020 15:25:39 +0900
Message-ID: <CAM9d7ch7TqHr8dwCQ3_OZjpvp4yv+u=ipdDJR=AcCdUb2zSw2Q@mail.gmail.com>
Subject: Re: [PATCH 09/26] perf tools: Try load vmlinux from buildid database
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
> Currently we don't check on kernel's vmlinux the same way as
> we do for normal binaries, but we either look for kallsyms
> file in build id database or check on known vmlinux locations
> (plus some other optional paths).
>
> This patch adds the check for standard build id binary location,
> so we are ready once we start to store it there from debuginfod
> in following changes.

But dso__load_vmlinux_path() already has the logic.
Also you should check symbol_conf.ignore_vmlinux_buildid.

Thanks
Namhyung


>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/build-id.c | 13 ++++++++++---
>  tools/perf/util/build-id.h |  2 ++
>  tools/perf/util/symbol.c   | 14 ++++++++++++++
>  3 files changed, 26 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
> index ecdc167aa1a0..6165f9d1d941 100644
> --- a/tools/perf/util/build-id.c
> +++ b/tools/perf/util/build-id.c
> @@ -259,10 +259,9 @@ static const char *build_id_cache__basename(bool is_kallsyms, bool is_vdso,
>             "debug" : "elf"));
>  }
>
> -char *dso__build_id_filename(const struct dso *dso, char *bf, size_t size,
> -                            bool is_debug)
> +char *__dso__build_id_filename(const struct dso *dso, char *bf, size_t size,
> +                              bool is_debug, bool is_kallsyms)
>  {
> -       bool is_kallsyms = dso__is_kallsyms((struct dso *)dso);
>         bool is_vdso = dso__is_vdso((struct dso *)dso);
>         char sbuild_id[SBUILD_ID_SIZE];
>         char *linkname;
> @@ -291,6 +290,14 @@ char *dso__build_id_filename(const struct dso *dso, char *bf, size_t size,
>         return bf;
>  }
>
> +char *dso__build_id_filename(const struct dso *dso, char *bf, size_t size,
> +                            bool is_debug)
> +{
> +       bool is_kallsyms = dso__is_kallsyms((struct dso *)dso);
> +
> +       return __dso__build_id_filename(dso, bf, size, is_debug, is_kallsyms);
> +}
> +
>  #define dsos__for_each_with_build_id(pos, head)        \
>         list_for_each_entry(pos, head, node)    \
>                 if (!pos->has_build_id)         \
> diff --git a/tools/perf/util/build-id.h b/tools/perf/util/build-id.h
> index 1ceede45c231..2cf87b7304e2 100644
> --- a/tools/perf/util/build-id.h
> +++ b/tools/perf/util/build-id.h
> @@ -23,6 +23,8 @@ char *build_id_cache__kallsyms_path(const char *sbuild_id, char *bf,
>
>  char *dso__build_id_filename(const struct dso *dso, char *bf, size_t size,
>                              bool is_debug);
> +char *__dso__build_id_filename(const struct dso *dso, char *bf, size_t size,
> +                              bool is_debug, bool is_kallsyms);
>
>  int build_id__mark_dso_hit(struct perf_tool *tool, union perf_event *event,
>                            struct perf_sample *sample, struct evsel *evsel,
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 5ddf76fb691c..7e1aac4931e1 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -2183,6 +2183,8 @@ static int dso__load_kernel_sym(struct dso *dso, struct map *map)
>         int err;
>         const char *kallsyms_filename = NULL;
>         char *kallsyms_allocated_filename = NULL;
> +       char *filename;
> +
>         /*
>          * Step 1: if the user specified a kallsyms or vmlinux filename, use
>          * it and only it, reporting errors to the user if it cannot be used.
> @@ -2207,6 +2209,18 @@ static int dso__load_kernel_sym(struct dso *dso, struct map *map)
>                 return dso__load_vmlinux(dso, map, symbol_conf.vmlinux_name, false);
>         }
>
> +       /*
> +        * Before checking on common vmlinux locations, check if it's
> +        * stored as standard build id binary under .debug tree.
> +        */
> +       filename = __dso__build_id_filename(dso, NULL, 0, false, false);
> +       if (filename != NULL) {
> +               err = dso__load_vmlinux(dso, map, filename, true);
> +               if (err > 0)
> +                       return err;
> +               free(filename);
> +       }
> +
>         if (!symbol_conf.ignore_vmlinux && vmlinux_path != NULL) {
>                 err = dso__load_vmlinux_path(dso, map);
>                 if (err > 0)
> --
> 2.26.2
>
