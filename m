Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24083299147
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 16:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1784281AbgJZPkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 11:40:55 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35605 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1784274AbgJZPky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 11:40:54 -0400
Received: by mail-wr1-f67.google.com with SMTP id n15so13177768wrq.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 08:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y8KnB6WQ6hnwXYvVwKUwP7/9fw5cwUH/Ducej8yDecI=;
        b=hx/9mALBPLHrmx+V9KVUGZuTU552IL81yLtuZLv9sSXLFZqLZQOw/dCDP4uToCR+gp
         pzIMoJRYa904I9opdv3PA8bQ4x7pbUyCLA1JW32PiNhsctGx9Est1XDuMLgvRJzpa8Ni
         0ZGLYyRBnlm5f5uj/eCh1aKu0xUyKbAVhDADaZzDJ9nj4rE9/SI9/HS8O9rgK4IeRETc
         X9StrO3z2IMv8kN+0qWgM8qd6US4D0I/3aoPD72cjez6ofBu02brfKQb41x/XqC57OtN
         YhxMGzx1rC/kc16XivYMxGGkTJtMwxTUzjeQZeBQqaJ6TUtBTzadm36KI6Jn97GQYRKL
         nN+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y8KnB6WQ6hnwXYvVwKUwP7/9fw5cwUH/Ducej8yDecI=;
        b=pfXxD2HiYvPxiWipf1qRX806a9EOTW8kgyn9Gs0n0ZuEY6r221gVsvO2y9Ge8gkrBo
         CPinQb9dk7IaWglzAtK4zY4rx2caYyLA2PyYH4saCkk4k1bTuUHu4czjv4O0TJ3pIfZz
         PZoxrtQidg1SyLwsvsWr3z57z/FDugVGIS3P1G9IMmKfY8UrofMdTqR0PWD4GusIv2oK
         YbbRRuSc9D0hk59dWmKJXQIHaOlU7wRAAGRtd/2LZxvYRwIQJNWKCUq9jEuFUxsLvjMH
         LOzuo0JjybWXvAjoXSWuHzfZRom5O2eFox7cZnF6ayJcxcemdRnymDQ7GrpGG0UbS+5S
         B00Q==
X-Gm-Message-State: AOAM530xDZdyCXE2M00GhOW9eqRncYVlQgWKkoTAdOzPg4VWbBIt5jbk
        83Vi7msh9pIPNURxpZu9KajOZWd92BKMsd4JAGhIWg==
X-Google-Smtp-Source: ABdhPJzHop1BRomp4oOm+x1BEG1zBGs0Rws3clbK5s/p75nXNyPrU/FcUBFnlcNyShtGn6cdR9YnyE433LTBIytXfV4=
X-Received: by 2002:adf:b641:: with SMTP id i1mr17840787wre.376.1603726851498;
 Mon, 26 Oct 2020 08:40:51 -0700 (PDT)
MIME-Version: 1.0
References: <20201024025918.453431-1-namhyung@kernel.org>
In-Reply-To: <20201024025918.453431-1-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 26 Oct 2020 08:40:39 -0700
Message-ID: <CAP-5=fVOJ=7RwJmDX7r-k_YUhNAznHF0xkorLT_TrSa_arifGQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf test: Use generic event for expand_libpfm_events()
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 23, 2020 at 7:59 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> I found that the UNHALTED_CORE_CYCLES event is only available in the
> Intel machines and it makes other vendors/archs fail on the test.  As
> libpfm4 can parse the generic events like cycles, let's use them.
>
> Fixes: 40b74c30ffb9 ("perf test: Add expand cgroup event test")
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/expand-cgroup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/expand-cgroup.c b/tools/perf/tests/expand-cgroup.c
> index d5771e4d094f..4c59f3ae438f 100644
> --- a/tools/perf/tests/expand-cgroup.c
> +++ b/tools/perf/tests/expand-cgroup.c
> @@ -145,7 +145,7 @@ static int expand_libpfm_events(void)
>         int ret;
>         struct evlist *evlist;
>         struct rblist metric_events;
> -       const char event_str[] = "UNHALTED_CORE_CYCLES";
> +       const char event_str[] = "CYCLES";
>         struct option opt = {
>                 .value = &evlist,
>         };
> --
> 2.29.0.rc1.297.gfa9743e501-goog
>
