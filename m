Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2092F73C8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 08:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731761AbhAOHmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 02:42:47 -0500
Received: from mail-lf1-f47.google.com ([209.85.167.47]:37520 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731680AbhAOHmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 02:42:46 -0500
Received: by mail-lf1-f47.google.com with SMTP id o17so11855275lfg.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 23:42:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8ZyPXUtZrapnrCrj2bVO3hup4JHubRCSG70auebSmCw=;
        b=QUdmoK8okRQRsjU/Xne9xzdH8vM/7lLQrkMcWLbGPUNwrCAqPYj93+kBNAaSrYArWr
         lLs74FAa/chmR4hLHPQ/9v4TQr6s1VAgoseLuHUjj8MXyKtW+gzuRAmigjrQhvZSTo5E
         +4qly8l3w3wNhMFLE2agcZOLpMxBKXPFbghhLDAcG0+z4OhUQx+Oq9cSIEPKAe3a4x4M
         4UNZEuqubIWKYAcZ2/lcEyv/FJAmxRSVbGS0ONC4JQhvl3UuxW70w7j+LWf3p0ZSosUf
         oH8133hXZjl7UpOJxHKCmHPK9rh2Hvp9FiZnh0d7qfKB3YoX24kzTm4iim/SFwqlwzzJ
         Kw2g==
X-Gm-Message-State: AOAM533dWjPjvSc0pMXBEfFg5uI2YMDkrGF1SlsguMPT2fFxBhNwNkcZ
        cR8QZ/WmSW4iTXHL5V0h1DwTxlXD3t9vGUlwfj0=
X-Google-Smtp-Source: ABdhPJxCDgobC12hWOfgoVyYqod7nKkDC9FA+O/srpQ2VO6du/T0wKSGJUSnp8P3dFVOVs9WCmDyVvzFSq5UuSdaAMM=
X-Received: by 2002:a19:23cf:: with SMTP id j198mr5062397lfj.509.1610696524402;
 Thu, 14 Jan 2021 23:42:04 -0800 (PST)
MIME-Version: 1.0
References: <20210114212304.4018119-1-irogers@google.com>
In-Reply-To: <20210114212304.4018119-1-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 15 Jan 2021 16:41:52 +0900
Message-ID: <CAM9d7chQstvSQedxMhgVPPC+s+z5+yg+GU2RCmDi9A+Fyo_TyQ@mail.gmail.com>
Subject: Re: [PATCH] libperf tests: Avoid uninitialized variable warning.
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

On Fri, Jan 15, 2021 at 6:23 AM Ian Rogers <irogers@google.com> wrote:
>
> The variable bf is read (for a write call) without being initialized
> triggering a memory sanitizer warning. Use bf in the read and switch the
> write to reading from a string.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/lib/perf/tests/test-evlist.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/lib/perf/tests/test-evlist.c b/tools/lib/perf/tests/test-evlist.c
> index 6d8ebe0c2504..1b225fe34a72 100644
> --- a/tools/lib/perf/tests/test-evlist.c
> +++ b/tools/lib/perf/tests/test-evlist.c
> @@ -208,7 +208,6 @@ static int test_mmap_thread(void)
>         char path[PATH_MAX];
>         int id, err, pid, go_pipe[2];
>         union perf_event *event;
> -       char bf;
>         int count = 0;
>
>         snprintf(path, PATH_MAX, "%s/kernel/debug/tracing/events/syscalls/sys_enter_prctl/id",
> @@ -229,6 +228,7 @@ static int test_mmap_thread(void)
>         pid = fork();
>         if (!pid) {
>                 int i;
> +               char bf;
>
>                 read(go_pipe[0], &bf, 1);
>
> @@ -266,7 +266,7 @@ static int test_mmap_thread(void)
>         perf_evlist__enable(evlist);
>
>         /* kick the child and wait for it to finish */
> -       write(go_pipe[1], &bf, 1);
> +       write(go_pipe[1], "A", 1);
>         waitpid(pid, NULL, 0);
>
>         /*
> --
> 2.30.0.296.g2bfb1c46d8-goog
>
