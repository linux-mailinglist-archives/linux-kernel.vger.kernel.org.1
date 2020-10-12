Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E13A828BBCB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 17:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389951AbgJLPZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 11:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388984AbgJLPZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 11:25:55 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31F9C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 08:25:55 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id k18so17930010wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 08:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G69ZOwrsKDHtALWZjgUfsAIOZm17V1h5+bQWRxK2NWI=;
        b=IBwlntvC8tY5ggsFp1IOeHilYmNcubAg5nfs2zeRAZyzUYS6nApviX6H2c2qMH8mMN
         WHbKiZoDiO8NaCrj3TN/aTbkjVXu28/FdJhKhIwKH46i7GT1jFRyTNCAy9KqjKelv0Tt
         wY2d2W0MzyMSb/BJyu7t4J/tHK3M/qBnxARXL6//HvVAFt6Ds0RUl/Tw83yE9M5ICQ1C
         ezmKUQ+NO0gL72Hr/7jwwYqPS8BbbCY+l42RUM9tVQTTVnhKwV+uoyzANk0gMxfNGY6A
         egmxv9N21I8rR6xj3RYsJAkg+8G2+n6cyqphC3x7F0YM7K0JYHpa+tGiG6jkc0uGCHi1
         3snw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G69ZOwrsKDHtALWZjgUfsAIOZm17V1h5+bQWRxK2NWI=;
        b=IOpokJmEqSNJlGegpZiMnYVtCT5zPg61tIDq+fZ/S7wEJMUN1xatQuoPUaq1ComWER
         FBvm+ro+3k67ciirQflfFIjh5Jcx+Hwm8crqYT/OUhLc1qLQ742dTXBsC0FHMEKvf2wX
         TCRH1E4ZPfaw8j7dLHRYfniASMLcWHPlS6qlnispXazDsRwBDnmoTbChyGujneib6oW8
         SCpPo4OLbTiFPK2xMw6JoHUzUR69m79B+FDivFtqu0/p3Ltuc78z2FmcSwe0Ph5fQ2+L
         0tFNSYa1tf2i8p492m0a/Ji2xnJ4hA2IvtKL2cN/wV52RkpAp3wDbh6T/jb1aIUnfoxe
         Ko6Q==
X-Gm-Message-State: AOAM531iDyTTnue1iCvcKS43JHAQBrrGRjQJufj/6KKKLuN7m4SYIhoV
        eq/0ptWnayBnreOTUV97sMeZv1edINwuJZJIziEVQw==
X-Google-Smtp-Source: ABdhPJxtOS7xBvNeZnoaZvXZ7gGGF3/c0oMoUTzpSX5HgkLwJQo2/8PrUMb6zCsGp9cikcJETsczhJMu+boWg12LZLo=
X-Received: by 2002:a7b:cb4a:: with SMTP id v10mr11046020wmj.87.1602516354154;
 Mon, 12 Oct 2020 08:25:54 -0700 (PDT)
MIME-Version: 1.0
References: <20201011121022.22409-1-leo.yan@linaro.org> <20201012091348.GC1099489@krava>
In-Reply-To: <20201012091348.GC1099489@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 12 Oct 2020 08:25:42 -0700
Message-ID: <CAP-5=fWDwtL39EY0ucxeWk4kAuJYe=ZMCU9Z9Y-bVws+uBZ62g@mail.gmail.com>
Subject: Re: [PATCH] perf c2c: Update usage for showing memory events
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 2:13 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Sun, Oct 11, 2020 at 08:10:22PM +0800, Leo Yan wrote:
> > Since commit b027cc6fdf1b ("perf c2c: Fix 'perf c2c record -e list' to
> > show the default events used"), "perf c2c" tool can show the memory
> > events properly, it's no reason to still suggest user to use the
> > command "perf mem record -e list" for showing events.
> >
> > This patch updates the usage for showing memory events with command
> > "perf c2c record -e list".
> >
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
>
> Acked-by: Jiri Olsa <jolsa@redhat.com>
>
> thanks,
> jirka

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> > ---
> >  tools/perf/builtin-c2c.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> > index 5938b100eaf4..57bb6cce43e3 100644
> > --- a/tools/perf/builtin-c2c.c
> > +++ b/tools/perf/builtin-c2c.c
> > @@ -2916,7 +2916,7 @@ static int perf_c2c__record(int argc, const char **argv)
> >       bool event_set = false;
> >       struct option options[] = {
> >       OPT_CALLBACK('e', "event", &event_set, "event",
> > -                  "event selector. Use 'perf mem record -e list' to list available events",
> > +                  "event selector. Use 'perf c2c record -e list' to list available events",
> >                    parse_record_events),
> >       OPT_BOOLEAN('u', "all-user", &all_user, "collect only user level data"),
> >       OPT_BOOLEAN('k', "all-kernel", &all_kernel, "collect only kernel level data"),
> > --
> > 2.17.1
> >
>
