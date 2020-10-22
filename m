Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 826E229574E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 06:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439721AbgJVEbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 00:31:48 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40354 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410586AbgJVEbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 00:31:48 -0400
Received: by mail-wm1-f66.google.com with SMTP id k18so380358wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 21:31:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e61/sww1BbU0XGp0m2ACPU3LrREd2j+JS14GN95hVVU=;
        b=GHEsWGYKGtSEps6zI6E/SOK0isS7Ea4gh2eJvXTZWPdl23zbuHGms3gXE6OHJU7JkX
         uMWslJNXZjid67q/+giylHr9SyGgnSYScNAlXcjoqSgBYZwjIPMnLhw6VY5dTt1M6+xA
         YBtGfLayFhZkhGB18Q3SpaifotXfJR5TvM5RPCa+xYAfkAdrmZEJoAtXo/Po/+t8muMG
         hrKLZ5p4i5wipdczfkUMUIpRBpMO836lO5dol2g25H/ymsFujeuZdX2FtClEksEfq61K
         NFeZYI9QZbwJuT+FwhlgQDJYESUr7CRLkyPZIeid6ZymwUAPQAySwNb/YtEyD5KwUvgA
         cCjw==
X-Gm-Message-State: AOAM532szZfJXTi36l9CKSdPeiLa+huE97WdR087dOhRcxIRWYF/bzQu
        PW1GBdl7F3ozMtXrogSSAaNkyJ2yWkzuVhH6WWQ=
X-Google-Smtp-Source: ABdhPJwYyD6HVo4wjUnfvcJBNxuGWx+fHG1+1EmlaYTsK3VTu8sNka+bzGJNoerdy1dXCRfBySMYiaXi9ayt79hAztE=
X-Received: by 2002:a1c:7c09:: with SMTP id x9mr608711wmc.181.1603341106156;
 Wed, 21 Oct 2020 21:31:46 -0700 (PDT)
MIME-Version: 1.0
References: <1ec29ed6-0047-d22f-630b-a7f5ccee96b4@linux.intel.com> <635d39aa-5ce8-2c0b-9b12-952b95ed22da@linux.intel.com>
In-Reply-To: <635d39aa-5ce8-2c0b-9b12-952b95ed22da@linux.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 22 Oct 2020 13:31:35 +0900
Message-ID: <CAM9d7cgqJtWf0EWaFbi4tyHiAPdsB-brL7sz3GWix+_OFn2ZjQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/15] perf session: move reader object definition to
 header file
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

On Thu, Oct 22, 2020 at 12:59 AM Alexey Budankov
<alexey.budankov@linux.intel.com> wrote:
>
>
> Move definition of reader to session header file to be shared
> among different source files. Introduce reference to active
> reader object from session object.
>
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks
Namhyung

> ---
>  tools/perf/util/session.c | 27 ---------------------------
>  tools/perf/util/session.h | 25 +++++++++++++++++++++++++
>  2 files changed, 25 insertions(+), 27 deletions(-)
>
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 6f09d506b2f6..911b2dbcd0ac 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -2110,33 +2110,6 @@ static int __perf_session__process_decomp_events(struct perf_session *session)
>         return 0;
>  }
>
> -/*
> - * On 64bit we can mmap the data file in one go. No need for tiny mmap
> - * slices. On 32bit we use 32MB.
> - */
> -#if BITS_PER_LONG == 64
> -#define MMAP_SIZE ULLONG_MAX
> -#define NUM_MMAPS 1
> -#else
> -#define MMAP_SIZE (32 * 1024 * 1024ULL)
> -#define NUM_MMAPS 128
> -#endif
> -
> -struct reader;
> -
> -typedef s64 (*reader_cb_t)(struct perf_session *session,
> -                          union perf_event *event,
> -                          u64 file_offset,
> -                          const char *file_path);
> -
> -struct reader {
> -       int              fd;
> -       const char       *path;
> -       u64              data_size;
> -       u64              data_offset;
> -       reader_cb_t      process;
> -};
> -
>  static int
>  reader__process_events(struct reader *rd, struct perf_session *session,
>                        struct ui_progress *prog)
> diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
> index 378ffc3e2809..abdb8518a81f 100644
> --- a/tools/perf/util/session.h
> +++ b/tools/perf/util/session.h
> @@ -20,6 +20,30 @@ struct thread;
>  struct auxtrace;
>  struct itrace_synth_opts;
>
> +/*
> + * On 64bit we can mmap the data file in one go. No need for tiny mmap
> + * slices. On 32bit we use 32MB.
> + */
> +#if BITS_PER_LONG == 64
> +#define MMAP_SIZE ULLONG_MAX
> +#define NUM_MMAPS 1
> +#else
> +#define MMAP_SIZE (32 * 1024 * 1024ULL)
> +#define NUM_MMAPS 128
> +#endif
> +
> +typedef s64 (*reader_cb_t)(struct perf_session *session,
> +                          union perf_event *event,
> +                          u64 file_offset, const char *file_path);
> +
> +struct reader {
> +       int              fd;
> +       const char       *path;
> +       u64              data_size;
> +       u64              data_offset;
> +       reader_cb_t      process;
> +};
> +
>  struct perf_session {
>         struct perf_header      header;
>         struct machines         machines;
> @@ -41,6 +65,7 @@ struct perf_session {
>         struct zstd_data        zstd_data;
>         struct decomp           *decomp;
>         struct decomp           *decomp_last;
> +       struct reader           *reader;
>  };
>
>  struct decomp {
> --
> 2.24.1
>
