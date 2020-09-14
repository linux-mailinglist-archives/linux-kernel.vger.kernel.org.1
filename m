Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A262E268448
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 07:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbgINFyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 01:54:33 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35645 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgINFyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 01:54:32 -0400
Received: by mail-wm1-f66.google.com with SMTP id y15so9932601wmi.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 22:54:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yACQAfr4ocDVYmzJdr6OfNTCpHMfbSr+9aGFx2BoBBo=;
        b=bwXma4bMnpKQD+wXhS8i2StV7Ag5fyrPhh87qTvOUTtFtEBog+AvIzmRINXb0A10Ck
         YUd2jPNgrWQ2qLR657x0VH0BLDNWNW3OUAGXpy6YkprAQI7wrEb7lxHjE9nRBiFQt0Zh
         z41iMs2i9TN/2Cekm7/5Ny+o0SpTKqA8xhEyeX0KeQtJAE0s8ZaJsOye82V3ic391jHY
         PRKQ+tC+6TOHF6PqsEnsl+wh2vDIFAwHNd3k4px3Ihe8U34Da3bdMRYTEQvZBZ8hDb2q
         vFsG1inzRIR9V9e3j2dehfGl8lMqPibDOk5yqLYUMPPMS6tNuqRtmgTDQVUL2FRyic9q
         J/7w==
X-Gm-Message-State: AOAM532t+zzYGahCcLF8rdkZV+uNuNAIyAdIY1WSI8MV0YTL9bSkJtTf
        g/UhEqGtB9pEMeKT2iktzXmf88wCIHmC2cz06x0=
X-Google-Smtp-Source: ABdhPJzTy4qqUMt5YRHL6Q51z/tGy1iuVc8Cip0cec8YCplI2nWkcvqBbz3VKBvpM7W0DSmGnXkLCMWbZBEeZs2AooM=
X-Received: by 2002:a1c:6341:: with SMTP id x62mr13308942wmb.70.1600062886905;
 Sun, 13 Sep 2020 22:54:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200913210313.1985612-1-jolsa@kernel.org> <20200913210313.1985612-8-jolsa@kernel.org>
In-Reply-To: <20200913210313.1985612-8-jolsa@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 14 Sep 2020 14:54:36 +0900
Message-ID: <CAM9d7ciXWxDQ0WoOYy-6KpV6scHjtpUiWJ5zSbGcecBbEoO1NA@mail.gmail.com>
Subject: Re: [PATCH 07/26] perf tools: Add check for existing link in buildid dir
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

On Mon, Sep 14, 2020 at 6:05 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> When adding new build id link we fail if the link is already
> there. Adding check for existing link and warn/replace the
> link with new target.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/build-id.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
> index bdee4e08e60d..ecdc167aa1a0 100644
> --- a/tools/perf/util/build-id.c
> +++ b/tools/perf/util/build-id.c
> @@ -751,8 +751,26 @@ int build_id_cache__add_s(const char *sbuild_id, const char *name,
>         tmp = dir_name + strlen(buildid_dir) - 5;
>         memcpy(tmp, "../..", 5);
>
> -       if (symlink(tmp, linkname) == 0)
> +       if (symlink(tmp, linkname) == 0) {
>                 err = 0;
> +       } else if (errno == EEXIST) {
> +               char path[PATH_MAX];
> +
> +               if (readlink(linkname, path, sizeof(path)) == -1) {
> +                       pr_err("Cant read link: %s\n", linkname);

typo

> +                       goto out_free;
> +               }
> +               if (strcmp(tmp, path)) {
> +                       pr_err("Inconsistent .debug record, updating [%s]\n",
> +                               linkname);

But isn't it ok to copy a binary to another location?
There can be multiple binaries with the same build-id..

Thanks
Namhyung


> +
> +                       unlink(linkname);
> +
> +                       if (symlink(tmp, linkname))
> +                               goto out_free;
> +               }
> +               err = 0;
> +       }
>
>         /* Update SDT cache : error is just warned */
>         if (realname &&
> --
> 2.26.2
>
