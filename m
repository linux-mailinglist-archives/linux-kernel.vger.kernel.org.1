Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 617332C66F7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 14:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730349AbgK0Nfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 08:35:52 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46781 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729459AbgK0Nfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 08:35:51 -0500
Received: by mail-lf1-f67.google.com with SMTP id t6so7033964lfl.13
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 05:35:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A8JKseBMEed0QAYBBfbhHXgWJpCjK52H/aVYJDNExeE=;
        b=QhBkWFKTIhDnZiYNw4cZgGNhxHx9pONparlcfCbSz4girzdI00rvOBc73QcGEKYYbc
         xjXgkpNp6xwnOBC+ByLELDn2E4Z7rZrtmvvo3NU9ruO/9OSpVUT3rABAVDOaeO7FAVaS
         xSToT14PZwRCwyC7Cgz/Bhh9S5g2cNF4Ai4v+3n/5B6x4QDWGvGvxSnS1M7osbmBbnU9
         PA4855KBDA74bPBnUszxIwZshFRH4vy2hLyT1s4AIJVnmrL4wAk+SqxpMD9SFfSnt+zU
         XQmJN/vEsVBZKxRKnqNhe3lVpvOFpkmV/vZ1/W238wUvZEJTheqxRQlBWB2rGRhLoF+2
         SugA==
X-Gm-Message-State: AOAM5301sfLij9z58wrQ37itLietqu/FMRQmjJoCyWAu81md+/xinune
        dlpTSQgsxzjMFn6TSxSxAGBbT+1uivshXkp61M0=
X-Google-Smtp-Source: ABdhPJx/1m256HBdsP7KopnxpyHsVh6ktHlUWwemDonLGwdmQ+N+PsNjWNY98kie0UlCeYUDRzNCc2KeR5anHci5X7U=
X-Received: by 2002:a19:4154:: with SMTP id o81mr3231634lfa.540.1606484149033;
 Fri, 27 Nov 2020 05:35:49 -0800 (PST)
MIME-Version: 1.0
References: <20201124103652.438-1-thunder.leizhen@huawei.com>
In-Reply-To: <20201124103652.438-1-thunder.leizhen@huawei.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 27 Nov 2020 22:35:37 +0900
Message-ID: <CAM9d7cgKDMCst2jEmHMHT7MC0DaTg1naNTt3cZnRepiNkmF-VA@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf diff: fix error return value in __cmd_diff()
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Nov 24, 2020 at 7:37 PM Zhen Lei <thunder.leizhen@huawei.com> wrote:
>
> An appropriate return value should be set on the failed path.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/builtin-diff.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
> index 584e2e1a3793..cefc71506409 100644
> --- a/tools/perf/builtin-diff.c
> +++ b/tools/perf/builtin-diff.c
> @@ -1222,8 +1222,10 @@ static int __cmd_diff(void)
>                 if (compute == COMPUTE_STREAM) {
>                         d->evlist_streams = evlist__create_streams(
>                                                 d->session->evlist, 5);
> -                       if (!d->evlist_streams)
> +                       if (!d->evlist_streams) {
> +                               ret = -ENOMEM;
>                                 goto out_delete;
> +                       }
>                 }
>         }
>
> --
> 2.26.0.106.g9fadedd
>
>
