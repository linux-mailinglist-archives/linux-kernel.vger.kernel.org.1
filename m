Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C83AD26D300
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 07:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbgIQFX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 01:23:26 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53732 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgIQFXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 01:23:19 -0400
Received: by mail-wm1-f66.google.com with SMTP id x23so651110wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 22:23:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LA/6WNJUJj4/BwlueXf+wc0/D0puEAWQO2AdVn51wXk=;
        b=Hq+XR8pAEagwYVqpnbO6EizvK21W28nE+rc7595x+4igckRxytXcHQSowlfUSBy+Oj
         MnH2rh7C4xQKGEOog5vJ2hXLAQg4TVYxYfNUzZEcCFTiZoq2huaW9atQqjUwQ5jVSLQy
         ++QecEO46QDGcpVauaA0G77jLXYgB0M5JvnXM5HK6/I24plZEy96ZqSzZ0Kq2+Cg6KgU
         rfDDaarqr2fy6I749T9xFsK1pGX/vFRU0XhMp4qnN5VefnCipmKgx0fNpugeV/ixHtkZ
         U0EfxlRXoNZJDYGe5/KhDN83uWRc/A9EgoFrX2b42+Wj8Tk1egkKPB+In0EnNduBShrs
         RNnA==
X-Gm-Message-State: AOAM530E+Tp7IfVnFIM/OHN8pIbcxgxd1YgQK4hz4XiV7xXggOBxdRV2
        NOuMl3PveF9szyRnt8xntgWKSD770OpxGEthSUo=
X-Google-Smtp-Source: ABdhPJz1WcWLgFTSKM1j2p89Kj52DLWJ1V0PAQlHxMu7r0IOZjbwFG32UvH6y96us90HGx0ABbCwaNqrbLbDMOJV3tc=
X-Received: by 2002:a7b:c404:: with SMTP id k4mr7957800wmi.168.1600320198027;
 Wed, 16 Sep 2020 22:23:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200917031414.47498-1-liwei391@huawei.com>
In-Reply-To: <20200917031414.47498-1-liwei391@huawei.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 17 Sep 2020 14:23:07 +0900
Message-ID: <CAM9d7cicKypGwhASKfu8GKE0y4v80o9tEyv7tn1d14J2tOezzw@mail.gmail.com>
Subject: Re: [PATCH] Revert "perf report: Treat an argument as a symbol filter"
To:     Wei Li <liwei391@huawei.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Li Bin <huawei.libin@huawei.com>, guohanjun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 12:15 PM Wei Li <liwei391@huawei.com> wrote:
>
> Since commit 6db6127c4dad ("perf report: Treat an argument as a symbol
> filter"), the only one unrecognized argument for perf-report is treated
> as a symbol filter. This is not described in man page nor help info,
> and the result is really confusing, especially when it's misspecified by
> the user (e.g. missing -i for perf.data).

How about adding documentation then?

Thanks
Namhyung

>
> As we can use "--symbol-filter=" if we really want to filter a symbol,
> it may be better to revert this misfeature.
>
> Signed-off-by: Wei Li <liwei391@huawei.com>
> ---
>  tools/perf/builtin-report.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index 3c74c9c0f3c3..f57ebc1bcd20 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -1317,13 +1317,9 @@ int cmd_report(int argc, const char **argv)
>         argc = parse_options(argc, argv, options, report_usage, 0);
>         if (argc) {
>                 /*
> -                * Special case: if there's an argument left then assume that
> -                * it's a symbol filter:
> +                * Any (unrecognized) arguments left?
>                  */
> -               if (argc > 1)
> -                       usage_with_options(report_usage, options);
> -
> -               report.symbol_filter_str = argv[0];
> +               usage_with_options(report_usage, options);
>         }
>
>         if (annotate_check_args(&report.annotation_opts) < 0)
> --
> 2.17.1
>
