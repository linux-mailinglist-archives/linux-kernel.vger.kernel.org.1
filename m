Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F81429FA38
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 02:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbgJ3BEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 21:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgJ3BEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 21:04:30 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0997AC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 18:04:30 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id w23so1450042wmi.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 18:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aMJdFe+wda9LSdQ71wLePMVbISAEiJjY2ccTxaYLRj4=;
        b=GJJUtSj1ioJwZ93mp19aKD/oROzE8p6INODifkCAgqulw+gbmc+bJxueniSgyGUplM
         w8dgmilCCldY/Xp2r0oFcZgtL2rDn2FtQYXus4BYKQPvqDc+GI48z/3ixIa6s/4ROm4N
         0wJR9boE4hVnXmwvTsioiz0u9SSsl3GRxeT2sfXMY8xSYW8RxZHeddE8+dBTrzMsUiXy
         8d9dzCq3XbsnBmwh9fQmxIdvbewxkxDICkOGUsJP1M+k1bhecbmHvQaZAd+gsRXeHbxx
         NFzUuD8rOdCS3aYZffHh1ngaAHtTYL9E7W0GN5Y3x3pLfL/kkQDEc9m/f9dPKMLxwFHY
         v70Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aMJdFe+wda9LSdQ71wLePMVbISAEiJjY2ccTxaYLRj4=;
        b=hIOxlmWlPOIgRF1c7AAb+FBamaWk7Qqz2mjssPrPe0pG09Uv0YYc8jnKMbjvK4S0fT
         6HAei9fGDk0mNhxN/NDN31dNOcEZ1BeVu8LaobDnDW/ouRXfNSMTChYvm7tV26UveY7g
         7EI3c3Oep5B6CozD6APBhgSaCXvsB/lsqul+abWCL1DlbOgdQN2Ud8tbXr2ju5fJra6+
         4lTSaKjOecggXTX8KBuojzYg+EvheITptFcHrMgUD9Iuua3tdZxzEYNEM3dLZRx2muvo
         Q626ncmzKDCkd9h+2Jv6Y+U69LrxDZPEDEGOrVq6AcxiBAoyv4ptjnB8y4FlUp3bPrNn
         nnWg==
X-Gm-Message-State: AOAM530tQtetRP5GD1yoYzXDS/cFtOthigDZngjmMBnDhjuaSWufY3jL
        7d9GYswPSzEx0IXgMOtsVx1yu2oummrscykF9B4nbg==
X-Google-Smtp-Source: ABdhPJwyTYwbAQ3IMxsQX4vYbseQhlN6Hzn1t7JeLGE4Q6a9b6jXCp41x6DLiEG5+YGcbF1DeWjzqbBG+cG27Y4G3J8=
X-Received: by 2002:a7b:c181:: with SMTP id y1mr2046323wmi.58.1604019868502;
 Thu, 29 Oct 2020 18:04:28 -0700 (PDT)
MIME-Version: 1.0
References: <20201028063813.8562-1-leo.yan@linaro.org> <20201028063813.8562-5-leo.yan@linaro.org>
In-Reply-To: <20201028063813.8562-5-leo.yan@linaro.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 29 Oct 2020 18:04:17 -0700
Message-ID: <CAP-5=fUiBTyW15BqcApL_Tm72Cnyoti=aXkEzj-Z5ZnAaCLwQQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/9] perf mem: Only initialize memory event for recording
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Kemeng Shi <shikemeng@huawei.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Al Grant <Al.Grant@arm.com>, James Clark <james.clark@arm.com>,
        Wei Li <liwei391@huawei.com>,
        =?UTF-8?Q?Andr=C3=A9_Przywara?= <andre.przywara@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 11:38 PM Leo Yan <leo.yan@linaro.org> wrote:
>
> It's needless to initialize memory events for reporting, this patch
> moves memory event initialization for only recording.  Furthermore,
> the change allows to parse perf data on cross platforms, e.g. perf
> tool can report result properly even the machine doesn't support
> the memory events.
>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-mem.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
> index 31144f586e77..f3dc2d2b879c 100644
> --- a/tools/perf/builtin-mem.c
> +++ b/tools/perf/builtin-mem.c
> @@ -78,6 +78,11 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
>         OPT_END()
>         };
>
> +       if (perf_mem_events__init()) {
> +               pr_err("failed: memory events not supported\n");
> +               return -1;
> +       }
> +
>         argc = parse_options(argc, argv, options, record_mem_usage,
>                              PARSE_OPT_KEEP_UNKNOWN);
>
> @@ -436,11 +441,6 @@ int cmd_mem(int argc, const char **argv)
>                 NULL
>         };
>
> -       if (perf_mem_events__init()) {
> -               pr_err("failed: memory events not supported\n");
> -               return -1;
> -       }
> -
>         argc = parse_options_subcommand(argc, argv, mem_options, mem_subcommands,
>                                         mem_usage, PARSE_OPT_KEEP_UNKNOWN);
>
> --
> 2.17.1
>
