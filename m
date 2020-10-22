Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 653AF29574D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 06:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408537AbgJVEbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 00:31:15 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38695 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394994AbgJVEbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 00:31:15 -0400
Received: by mail-wm1-f66.google.com with SMTP id l15so388250wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 21:31:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MXNqjrdYx6upFpGxSfIxLtwcpQgyuN+kuEUfgmX07dM=;
        b=DlfMSFzm80qTuDD5MyZzaGa2quLtvjafGleVRoOoLhKkPhfbEokAfe+XiP7UdYUSLc
         iXr4UtUF2+SCH0+pvgx2OkGpEuO79Lx/G+jaxG0MgQGHUFMSmC9OhDIPIpln2/axHkzO
         mjB+m3kOAaJJiqjZTcLvCi7Aq18yCfd0eZyAjjF/hGMxHmlWguoJmhGFB5aZL0BqmRWr
         rzjobRGs9RToAkry2BOJYtOWZVxLyYxhJzuAE59YU3vwBDAwlm7tKI0xh+VNiOCfOehG
         aPXJCqROuCO5/u5noE4JZXF5p5qDn14+kUsEO6Jt7Z99Y1UIFtosvrlaHuClEinCxf3w
         w45Q==
X-Gm-Message-State: AOAM530GdL5jgjKFDQ13hdgX6d2qjG0X3w2t/OCbLQtCzJN2d+A9GooP
        xerz+EyPl53IW9otZGakW9MJcuHX2/0mRVvcKtg=
X-Google-Smtp-Source: ABdhPJxbz3JZ1vVFP7Z2Kgs9qUTIK/hLYOWtgF4LYIprZQf7CHjc+SanivmwpnjD9EazufchbgP2OFjmAG/DmgslTG0=
X-Received: by 2002:a7b:c7c3:: with SMTP id z3mr574227wmk.43.1603341073283;
 Wed, 21 Oct 2020 21:31:13 -0700 (PDT)
MIME-Version: 1.0
References: <1ec29ed6-0047-d22f-630b-a7f5ccee96b4@linux.intel.com> <dc78ce8b-664c-45b9-ad44-4faaeb5d544f@linux.intel.com>
In-Reply-To: <dc78ce8b-664c-45b9-ad44-4faaeb5d544f@linux.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 22 Oct 2020 13:31:02 +0900
Message-ID: <CAM9d7cg7iU5sY0u0AgWhFddzCMT3vuS-SgDePENP6kQm0w5J6w@mail.gmail.com>
Subject: Re: [PATCH v2 03/15] perf data: open data directory in read access mode
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

On Thu, Oct 22, 2020 at 12:58 AM Alexey Budankov
<alexey.budankov@linux.intel.com> wrote:
>
>
> Open files located at trace data directory in case read access
> mode is requested. File are opened and its fds assigned to
> perf_data dir files especially for loading data directories
> content in perf report mode.
>
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  tools/perf/util/data.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
> index c47aa34fdc0a..6ad61ac6ba67 100644
> --- a/tools/perf/util/data.c
> +++ b/tools/perf/util/data.c
> @@ -321,6 +321,10 @@ static int open_dir(struct perf_data *data)
>                 return -1;
>
>         ret = open_file(data);
> +       if (!ret && perf_data__is_dir(data)) {

I think this __is_dir() check is unnecessary since it's checked
from the caller side already.

Thanks
Namhyung


> +               if (perf_data__is_read(data))
> +                       ret = perf_data__open_dir(data);
> +       }
>
>         /* Cleanup whatever we managed to create so far. */
>         if (ret && perf_data__is_write(data))
> --
> 2.24.1
>
