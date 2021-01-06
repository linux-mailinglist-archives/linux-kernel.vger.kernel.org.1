Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 624582EB7AE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 02:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbhAFBec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 20:34:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbhAFBec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 20:34:32 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E63EC061574
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 17:33:51 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id q75so1274769wme.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 17:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=26LBeucSF5uhRNrksZAanCW/ezUZIUm3TZlLXiklCzQ=;
        b=D35uthKmIt+hWBJA0RNpWyZSVptnaRRgXGf8onTupDPuTSXGRsvPDYlJjJYKLksH3T
         Tplv3ygwmWSd4dZTDr4ydYvHOlHYdJvoRA92QXat46bWeWO1e2jrAyeJuBV1rDjupBTr
         IXe3B3UrApwFuxch8WiAW9Ry9FgP2PDXqb7NMwxHlnT3B0f1JK69ZKD/9vHDGyTU0ZJ5
         nJ+bY1OpD5xrcT9NUzUqaGbjs/DUoIwYzWXxU4JkrhmVT1MvB201OnJc/2H7G2Hs2sDg
         2bdDxbLZPq814Y/lqdzaRNsTuJE9vTkEoICxaCmnNY9q2wNWQ2Z4Qk1qhsSr+3i9tq/c
         v3Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=26LBeucSF5uhRNrksZAanCW/ezUZIUm3TZlLXiklCzQ=;
        b=MgOwHw/C9lPAWjaAmdbrfh1ELMHzHAtXpn8et99BLsLXRi0Psgi36AUOfIE4eV8yD1
         vmu/UGnRC1QadIA6/t12faOKiJ9lEc5DI5F7tSnHeUWpq3EJVgKCIOmW5N/Vq7cMNZh4
         FKkYECSz2/uIwNveSM+qvpUHUNsPxexXfCnoXaddM+rw83ORQeMcAnXPPmq5dHf/66A3
         B6Zdh1ru4HsGNR1FVqw7qxpMQVG6YGBBHlpR/Ze3sGMBIOHbZb2GQ8O3xOmi83RDHcgB
         jlYsj95PW0/fttDN8cmR5/ROk7mjmQcC8D7BGlZNOpc+KnuKeIrSJ4ciJrdf2OtrYQWP
         g+BQ==
X-Gm-Message-State: AOAM533EkS+wGMAVYGPqklo+gxZ2fDgQQS0jfHMDewi17u/922TmrSA5
        jwf/ZcS0jY6nR7N21CmNp26SyPokMtI8eBAGyMXk0g==
X-Google-Smtp-Source: ABdhPJz5Pd4SkgPagnHsnTajsCSbHO6mxfAmTiMYy9BkRCyLqAP3b65PqC0xzWFAHbU4zGAP61r2IUT1ZQXHZbQaLu8=
X-Received: by 2002:a1c:e902:: with SMTP id q2mr1437356wmc.143.1609896829631;
 Tue, 05 Jan 2021 17:33:49 -0800 (PST)
MIME-Version: 1.0
References: <20201230110935.582332-1-jolsa@kernel.org>
In-Reply-To: <20201230110935.582332-1-jolsa@kernel.org>
From:   Stephane Eranian <eranian@google.com>
Date:   Tue, 5 Jan 2021 17:33:38 -0800
Message-ID: <CABPqkBTQfFWvEba-=T6ms=GTsjrZUosRQyZZK-EMZ2c_2NQvAA@mail.gmail.com>
Subject: Re: [PATCHv2] perf tools: Detect when pipe is passed as perf data
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Alexei Budankov <abudankov@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Dec 30, 2020 at 3:09 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Currently we allow pipe input/output only through '-' string
> being passed to '-o' or '-i' options, like:
>
It seems to me it would be useful to auto-detect that the perf.data
file is in pipe vs. file mode format.
Your patch detects the type of the file which is something different
from the format of its content.
Thanks.

>   # mkfifo perf.pipe
>   # perf record --no-buffering -e 'sched:sched_switch' -o - > perf.pipe &
>   [1] 354406
>   # cat perf.pipe | ./perf --no-pager script -i - | head -3
>             perf 354406 [000] 168190.164921: sched:sched_switch: perf:354406..
>      migration/0    12 [000] 168190.164928: sched:sched_switch: migration/0:..
>             perf 354406 [001] 168190.164981: sched:sched_switch: perf:354406..
>   ...
>
> This patch detects if given path is pipe and set the perf data
> object accordingly, so it's possible now to do above with:
>
>   # mkfifo perf.pipe
>   # perf record --no-buffering -e 'sched:sched_switch' -o perf.pipe &
>   [1] 360188
>   # perf --no-pager script -i ./perf.pipe | head -3
>             perf 354442 [000] 168275.464895: sched:sched_switch: perf:354442..
>      migration/0    12 [000] 168275.464902: sched:sched_switch: migration/0:..
>             perf 354442 [001] 168275.464953: sched:sched_switch: perf:354442..
>
> It's of course possible to combine any of above ways.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
> v2:
>   - removed O_CREAT|O_TRUNC flags from pipe's write end
>
>  tools/perf/util/data.c | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)
>
> diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
> index f29af4fc3d09..4dfa9e0f2fec 100644
> --- a/tools/perf/util/data.c
> +++ b/tools/perf/util/data.c
> @@ -159,7 +159,7 @@ int perf_data__update_dir(struct perf_data *data)
>         return 0;
>  }
>
> -static bool check_pipe(struct perf_data *data)
> +static int check_pipe(struct perf_data *data)
>  {
>         struct stat st;
>         bool is_pipe = false;
> @@ -172,6 +172,15 @@ static bool check_pipe(struct perf_data *data)
>         } else {
>                 if (!strcmp(data->path, "-"))
>                         is_pipe = true;
> +               else if (!stat(data->path, &st) && S_ISFIFO(st.st_mode)) {
> +                       int flags = perf_data__is_read(data) ?
> +                                   O_RDONLY : O_WRONLY;
> +
> +                       fd = open(data->path, flags);
> +                       if (fd < 0)
> +                               return -EINVAL;
> +                       is_pipe = true;
> +               }
>         }
>
>         if (is_pipe) {
> @@ -190,7 +199,8 @@ static bool check_pipe(struct perf_data *data)
>                 }
>         }
>
> -       return data->is_pipe = is_pipe;
> +       data->is_pipe = is_pipe;
> +       return 0;
>  }
>
>  static int check_backup(struct perf_data *data)
> @@ -344,8 +354,11 @@ static int open_dir(struct perf_data *data)
>
>  int perf_data__open(struct perf_data *data)
>  {
> -       if (check_pipe(data))
> -               return 0;
> +       int err;
> +
> +       err = check_pipe(data);
> +       if (err || data->is_pipe)
> +               return err;
>
>         /* currently it allows stdio for pipe only */
>         data->use_stdio = false;
> @@ -410,8 +423,10 @@ int perf_data__switch(struct perf_data *data,
>  {
>         int ret;
>
> -       if (check_pipe(data))
> -               return -EINVAL;
> +       ret = check_pipe(data);
> +       if (ret || data->is_pipe)
> +               return ret;
> +
>         if (perf_data__is_read(data))
>                 return -EINVAL;
>
> --
> 2.26.2
>
