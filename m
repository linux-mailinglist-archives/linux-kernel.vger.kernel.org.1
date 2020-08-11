Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD0A7241668
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Aug 2020 08:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbgHKGnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Aug 2020 02:43:08 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52362 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbgHKGnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 02:43:07 -0400
Received: by mail-wm1-f65.google.com with SMTP id x5so1587989wmi.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 23:43:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EW9UExPP4cCsEpySaao+QgP8WSaCGYFKB0QeZjeCUF8=;
        b=hBgIcBsX2F6h0kEYYH1Hzw8bz9HVY/YrA39ABWTD5wfJh18fpWSX4xExXxkXBBIBtO
         iLz7z1duvY4ex6e3yjmqptB8p1pFMKqfrvkGnyucXBg3K29HiorV6g/DfSMcWp5ye7lU
         r16XN+92EQV1Oj3xHn6sD/3anjlTikHkI3bAEz/V5F9UyLkSPBa0fxBOPLmGkWzpUyox
         MJWA+pZQUaiBX4hsM6W0UHuT2rWbopsTT6fs9GzwbPkkwo5r7DE92dEAuvKrwzwspD1Z
         woP+3A8zqjw96AeRYZIJ+EpL3mARrXqulz85ZyJAlIy2O0jI63INAwIovGRT1AgOKi76
         3bFA==
X-Gm-Message-State: AOAM532NL9KkNDQnDv44gTI4ZmtZneZCUqLdN8HbZDS9M3B9P8ds43+m
        +rYDSUePT4u7aOzDpk24BMj39W7FRfyyM49uTZk=
X-Google-Smtp-Source: ABdhPJyZZ930hlzVjH7uhOTraqV/zOofnuoiXQ8DbwNHdKh1TaPJL/UPy0Hg/HZwcaTMdr7Semt89ry0FZfNA7a8Pa4=
X-Received: by 2002:a1c:7504:: with SMTP id o4mr1809076wmc.70.1597128185929;
 Mon, 10 Aug 2020 23:43:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200807164937.44921-1-dsahern@kernel.org>
In-Reply-To: <20200807164937.44921-1-dsahern@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 11 Aug 2020 15:42:54 +0900
Message-ID: <CAM9d7chXrXh1QfJfwsEJ_Tk0_EDNL9ajBE8H0QYCSn_yuLhNUA@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf sched timehist: Fix use of CPU list with summary option
To:     David Ahern <dsahern@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 8, 2020 at 1:49 AM David Ahern <dsahern@kernel.org> wrote:
>
> Do not update thread stats or show idle summary unless CPU is in
> the list of interest.
>
> Fixes: c30d630d1bcf ("perf sched timehist: Add support for filtering on CPU")
> Signed-off-by: David Ahern <dsahern@kernel.org>
> ---
>  tools/perf/builtin-sched.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 0c7d599fa555..82ee0dfd1831 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -2575,7 +2575,8 @@ static int timehist_sched_change_event(struct perf_tool *tool,
>         }
>
>         if (!sched->idle_hist || thread->tid == 0) {
> -               timehist_update_runtime_stats(tr, t, tprev);
> +               if (!cpu_list || test_bit(sample->cpu, cpu_bitmap))
> +                       timehist_update_runtime_stats(tr, t, tprev);
>
>                 if (sched->idle_hist) {
>                         struct idle_thread_runtime *itr = (void *)tr;
> @@ -2848,6 +2849,9 @@ static void timehist_print_summary(struct perf_sched *sched,
>
>         printf("\nIdle stats:\n");
>         for (i = 0; i < idle_max_cpu; ++i) {
> +               if (!test_bit(i, cpu_bitmap))

Shouldn't it check cpu_list as well?

Thanks

Namhyung


> +                       continue;
> +
>                 t = idle_threads[i];
>                 if (!t)
>                         continue;
> --
> 2.17.1
>
