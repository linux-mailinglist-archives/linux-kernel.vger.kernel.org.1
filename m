Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1123122548F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jul 2020 00:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgGSWfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jul 2020 18:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgGSWfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 18:35:01 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1845C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 15:35:00 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 22so20519088wmg.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 15:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FvG5reSg9l5TH3VxmyNLzPs9V51oowG1ILpSonp6Wuc=;
        b=hmQRpfGhT4g6DyQGsFoQajY/vzYf6RKQrdBPuO9FIqTdOKauhSU6f4jHSKK2yintMf
         smkkdJCjcJBOCWx/+k7lrJd7+gnpnkXjFxZXgX5yMRrYF/O4mBo9Sw9tZCvJoEBsohNz
         excaibX1qmF6QsbEPdTj99swAic2anaKMsVKCvw7eKTlyoOMcKsVGxvKxmRoQEUacBIk
         CMgsDyxx8Nqh+lnvmtaMqBmqFt+qbiXN4KQCSobKy2yQWZngPiP+4zA3Yjm45DA2YrFD
         LagSmh1Ac8zh96S0dlybtD38LAhlHQOXA+MU5Wof9rhzy7apJma3ZXKK9ut7i7uvoAA7
         1gZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FvG5reSg9l5TH3VxmyNLzPs9V51oowG1ILpSonp6Wuc=;
        b=c+/HiEogScJw0qMz2Eq6m6tGfGBmGg/rieCu3DGjJqp9vth6+DGY4GBXXGocCFg2lP
         YrefK9Rlrin3S1nVoNeAk8MPlVDH/wkRAQGikjgPguPhKXaNfwCdnQ0jOJ8hZ6tMXlie
         lWw9bXZKzzo9xBl0TRVt1Bmd0IgblnrJ8JYCxZG9A5VgGCT7OiEH3et6JpudGwLAzgVu
         aHb19ex58T7DGoLtmpVrI68h44TiqAArrnkWvQhYSiL8fwfqjAFujFbrCt6l2CfH8qxN
         TU+1MfpTBTK6gg6pasERAy8wko4Yt86mcHOx3QgjWipIkvZh34Pse7azNSVgKh3UiARh
         31GQ==
X-Gm-Message-State: AOAM533NhXoeYuXP750VHt2/vglUx0WnhAHsCcrGfZkjDtR7sOEJFPZN
        AbemnLU7s2u/5oaCaNTjUY/3Cd4PYhBS9aTjiJznAg==
X-Google-Smtp-Source: ABdhPJwPU4y8lJRUrG9bY10VTyCWfWENlzhxdx/RRIraGi6wnPTgEefniollgYoeS3dEhvjYHWikzf8x/ro3BowiHZE=
X-Received: by 2002:a1c:398b:: with SMTP id g133mr18309800wma.76.1595198099383;
 Sun, 19 Jul 2020 15:34:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200719181320.785305-1-jolsa@kernel.org> <20200719181320.785305-13-jolsa@kernel.org>
In-Reply-To: <20200719181320.785305-13-jolsa@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Sun, 19 Jul 2020 15:34:48 -0700
Message-ID: <CAP-5=fXsspq4xBehRZOBrFAEHAnE1tPnH9FybooiCcTxynh6wg@mail.gmail.com>
Subject: Re: [PATCH 12/19] perf metric: Add events for the current list
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A. Clarke" <pc@us.ibm.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 19, 2020 at 11:14 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> There's no need to iterate the whole list of groups,
> when adding new events. The currently created groups
> are the ones we want to add.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/metricgroup.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index bb5757b9419d..332414d93f7a 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -813,6 +813,7 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
>  {
>         struct pmu_event *pe;
>         struct egroup *eg;
> +       LIST_HEAD(list);
>         int i, ret;
>         bool has_match = false;
>
> @@ -820,7 +821,7 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
>                 has_match = true;
>                 eg = NULL;
>
> -               ret = add_metric(group_list, pe, metric_no_group, &eg);
> +               ret = add_metric(&list, pe, metric_no_group, &eg);
>                 if (ret)
>                         return ret;
>
> @@ -829,7 +830,7 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
>                  * included in the expression.
>                  */
>                 ret = resolve_metric(eg, metric_no_group,
> -                                    group_list, map);
> +                                    &list, map);
>                 if (ret)
>                         return ret;
>         }
> @@ -838,7 +839,7 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
>         if (!has_match)
>                 return -EINVAL;
>
> -       list_for_each_entry(eg, group_list, nd) {
> +       list_for_each_entry(eg, &list, nd) {
>                 if (events->len > 0)
>                         strbuf_addf(events, ",");
>
> @@ -850,6 +851,8 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
>                                                            &eg->pctx);
>                 }
>         }
> +
> +       list_splice(&list, group_list);
>         return 0;
>  }
>
> --
> 2.25.4
>
