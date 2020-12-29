Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD0EE2E6E65
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 06:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgL2Fy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 00:54:29 -0500
Received: from mail-qt1-f174.google.com ([209.85.160.174]:36099 "EHLO
        mail-qt1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbgL2Fy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 00:54:28 -0500
Received: by mail-qt1-f174.google.com with SMTP id z20so8367858qtq.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 21:54:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gPNfML2ks2KPHAzz+TPLrKUVoqsU6o/9WIH8efYkIsY=;
        b=U52nAg3+/RL25mHXu1NgbT0ig+v6Hpsx4ITDG8c+ll5oWVE33se39nOP+mu/EsnpQP
         IF0aBwnL6uF6grIp4HJW8XxqmrLjmdTcFXKuPt/HeLhvrWv0ynQbTE6EYkV3LnR4vubn
         GVEH6YAw60BwmoJyXm+/d4fl4Mv4pbhVoHUJWyP66XcIylTNUCl/YB9rIZEafirzPdLT
         OINyuG4kzFRCpFT1P/QafhT7C0vQcSPxgaYCwfqVok/jmeb3XmamJ6GU+x4ixcqHPfMw
         W+OYkMRbX1pUP+4GhM4uCrY94ejw/HGicIVQRwy+jhPy7BnLZa4+XzwV4sreiQAbBjt6
         Hknw==
X-Gm-Message-State: AOAM5323Oo1+RqSPSh1/gIGQ37GkqyvIA5XG53M1wQNhYD3x+Ws0m/6c
        sOUqMygg5cl8HLB1h6RpMkOkM7NLW8v0KWvheHQ=
X-Google-Smtp-Source: ABdhPJxziGr0Gy0rSHzv0CRlVa9EDYV1bacoCFtdkD+lg44fmnfyJCY5UlZgEdI5b/yOKuD9P8gpMue5AjZRb3D8sF4=
X-Received: by 2002:ac8:5806:: with SMTP id g6mr47211020qtg.292.1609221227277;
 Mon, 28 Dec 2020 21:53:47 -0800 (PST)
MIME-Version: 1.0
References: <20201225222109.364465-1-jolsa@kernel.org>
In-Reply-To: <20201225222109.364465-1-jolsa@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 29 Dec 2020 14:53:36 +0900
Message-ID: <CAM9d7ciF+_s+MqNou4szVSStBObtB87UznMMG8SsZkuRyR1dNg@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Detect when pipe is passed as perf data
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexei Budankov <abudankov@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 26, 2020 at 7:21 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Currently we allow pipe input/output only through '-' string
> being passed to '-o' or '-i' options, like:
>
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
>  tools/perf/util/data.c | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)
>
> diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
> index f29af4fc3d09..767b6c903cf5 100644
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
> +                                   O_RDONLY : O_WRONLY|O_CREAT|O_TRUNC;

I don't think we need O_CREAT here (maybe O_TRUNC as well).

Thanks,
Namhyung


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
