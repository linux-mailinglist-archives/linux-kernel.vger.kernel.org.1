Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2739B29A3DE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 06:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505749AbgJ0FKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 01:10:55 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36606 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505741AbgJ0FKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 01:10:55 -0400
Received: by mail-wr1-f67.google.com with SMTP id x7so410305wrl.3;
        Mon, 26 Oct 2020 22:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ngPKTvR1IpSlXKqEEPPICpOA1ws2tSXxni49kU0D+Mk=;
        b=eZuYmrB1kcNwArGQsuuXGjT3KdyjReayS4/LwD2Mb+Pk7R8lq+9g3y8EqkiKMqGcZh
         O0DloQFiv+i5+AJMlLkH8iXF4a5cWhXO+EYmoxAQgqUUVFQq+mjNEr1M8toatk+lEuji
         Lv0kGbqMdoV+891IB9tdhnfn6XUwiD19EHeF20tx97uuzBMo0Dn8BywydaXvWLrufX9c
         wPZ6BbWW9Leiq18xpchJx0DHNN20GtMoig6dQOvIpt16tPKmmxvh5rbHhNUgWXWvHdZM
         v7U2s1GbUM0ZClb+sWJBmsYu0FB+kTj2ingvTUwdr3239WRpt77ef23ajwOhgQCQpPbH
         gGRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ngPKTvR1IpSlXKqEEPPICpOA1ws2tSXxni49kU0D+Mk=;
        b=aM0Jo7bs8SXmbOQqZ6eQYbHQmfKs1CGqi3uln9uFoNxZP+YaxkS7Y/bhujbTH6h88P
         igy++Vi3v5+jml7ZLD5JCg7uVhOygPF4RLmyW3q1WCRBcAhQEYz53CJI36rCrTqk9ws9
         A9lVni/fHv9Z0XB1jOedCGzicui8mPZLbO5/xnz0ErE94JFnScc750Xavkbgt7wwhRJn
         3vKn0vGJOjAjvmkSlet3G0wTrP54wVAwg6rtmw7kPp8mAVorfXgQM0eqzfNr3QSbhK0c
         clG81VrstjQusqF/7AQCTqxoRkaSoy+P++PXiVygLLfThragUzbRavOiE1CwET5ppk89
         eorw==
X-Gm-Message-State: AOAM530IBszTXNnpDacQL1RYBfAl1fageujDxx52Wx2enV9UU4d5vBfS
        77GD9/jH8RxXIeOpX5swgaev3GvaJsa2+Bof2ks=
X-Google-Smtp-Source: ABdhPJxT5qPAIbm1qgXtPVPheNjTZKKkLv40FWzMiN3kp3/undmUD9x/+kVvcAWGPzLq3EQYRUf/rQj857xhMZaqLNE=
X-Received: by 2002:adf:a345:: with SMTP id d5mr562792wrb.55.1603775452893;
 Mon, 26 Oct 2020 22:10:52 -0700 (PDT)
MIME-Version: 1.0
References: <20201026132034.80464-1-sivanichkin@yandex-team.ru>
In-Reply-To: <20201026132034.80464-1-sivanichkin@yandex-team.ru>
From:   Namhyung Kim <namhyung@gmail.com>
Date:   Tue, 27 Oct 2020 14:10:42 +0900
Message-ID: <CAM9d7chkb_ramqnS_0LSbtY-gya3XAyHao2+bNjE=T3YJDTptg@mail.gmail.com>
Subject: Re: [PATCH v2] perf trace: Segfault when trying to trace events by cgroup
To:     Stanislav Ivanichkin <sivanichkin@yandex-team.ru>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Oct 26, 2020 at 10:21 PM Stanislav Ivanichkin
<sivanichkin@yandex-team.ru> wrote:
>
>   v2:
>     - struct declaration fixed (Namhyung Kim)
>
> Fixes: 9ea42ba4411ac ("perf trace: Support setting cgroups as targets")
> Signed-off-by: Stanislav Ivanichkin <sivanichkin@yandex-team.ru>

Looks ok but you'd better add the commit description in v1.

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks
Namhyung

> ---
>  tools/perf/builtin-trace.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 44a75f234db1..de80534473af 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -4639,9 +4639,9 @@ static int trace__parse_events_option(const struct option *opt, const char *str,
>         err = 0;
>
>         if (lists[0]) {
> -               struct option o = OPT_CALLBACK('e', "event", &trace->evlist, "event",
> -                                              "event selector. use 'perf list' to list available events",
> -                                              parse_events_option);
> +               struct option o = {
> +                       .value = &trace->evlist,
> +               };
>                 err = parse_events_option(&o, lists[0], 0);
>         }
>  out:
> @@ -4655,9 +4655,12 @@ static int trace__parse_cgroups(const struct option *opt, const char *str, int u
>  {
>         struct trace *trace = opt->value;
>
> -       if (!list_empty(&trace->evlist->core.entries))
> -               return parse_cgroups(opt, str, unset);
> -
> +       if (!list_empty(&trace->evlist->core.entries)) {
> +               struct option o = {
> +                       .value = &trace->evlist,
> +               };
> +               return parse_cgroups(&o, str, unset);
> +       }
>         trace->cgroup = evlist__findnew_cgroup(trace->evlist, str);
>
>         return 0;
> --
> 2.17.1
>
