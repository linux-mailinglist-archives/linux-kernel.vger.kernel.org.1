Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43323296899
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 04:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374745AbgJWCtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 22:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S374715AbgJWCtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 22:49:12 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB74C0613CE;
        Thu, 22 Oct 2020 19:49:11 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x7so106468wrl.3;
        Thu, 22 Oct 2020 19:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oe3+yIOTAgR0wwkfdH91CMvGJPetlip83+UuJt6zEjk=;
        b=W6KCC99dX0bkA1SF942UIAIRhzAYQXVu2Z2ikv0T1+m2cbwFXuEPdTc/O19BU1uvnh
         0w6rBG8HsjblEz3EnSiHNO9z4OshTQ0sVE7ARBxjaNXAK0Yma7ja0wmxd1pYq/80JXnq
         xgEU2l4HYJU4iuHuEG7hBbZIkxb6ozD8lbUUgJGyXYa3jTfN/ZBH+gWDquhjDj60Zj++
         dxpW/wivfV0xBbqIsR4GWxa9qZGkDr+o2Kf3tf7OMtTo3GFTm2Cevl71wiI5hY/K5cpq
         eG6wPXU3/RJT32nf7eal4wpjr1H4VMcfPC1Lr/W6CMT/MERn9X6JJll8wcVxUpEpe/mp
         8Ikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oe3+yIOTAgR0wwkfdH91CMvGJPetlip83+UuJt6zEjk=;
        b=EtxEgde894N5KPxfHg2RD4FPDJOsGevkgcEHXrDLJLTy5SOGoAgHwVUCkTWfIvHNCV
         5gZhdo1QslDg23sfTtFuy+20a2BIPCrT6rTqDRMlcQcAiHtdXvVDjGvgMs1Utuqjf4mR
         jUSwJHwUAbPxpXLuhKwgs8XcScZgJ1PZegCvKQPm084d0V3EuCBcqh4uGgiNs9p9oKC/
         KAfITWiKuqeWhzR0Y3pT3pEiRh6N5Sq5RTlstuntEzz/2gPr7P0P8AImHAFmC84XlCsj
         ntRpBBHbjxFEpgvfdpMvItmlpoUwOjQ27FyNRJ/CinUvTQmieqd8CjXu057PM0aQAODM
         9TvQ==
X-Gm-Message-State: AOAM532c0nN2CVO50TcEVRzGUeMWKcD78EWvUxB0yV3K+LZWXw1JwG05
        q7dFXvj7KXyLs52nyPdZTnxwnifb2lrSE8iRAaYAiagI4DQ=
X-Google-Smtp-Source: ABdhPJxKx3y6QQkWhhNCboj5fz99NjWnsAPEgm2w2dVemlLEf+mKz58e1zyPMYDbgTcWtR1HJnqf/A4VX2mEfD4dEn0=
X-Received: by 2002:adf:a345:: with SMTP id d5mr178051wrb.55.1603421350396;
 Thu, 22 Oct 2020 19:49:10 -0700 (PDT)
MIME-Version: 1.0
References: <20201009064547.62047-1-sivanichkin@yandex-team.ru> <6A368965-ACB4-47CD-902C-0B910F6BEEE9@yandex-team.ru>
In-Reply-To: <6A368965-ACB4-47CD-902C-0B910F6BEEE9@yandex-team.ru>
From:   Namhyung Kim <namhyung@gmail.com>
Date:   Fri, 23 Oct 2020 11:48:59 +0900
Message-ID: <CAM9d7cg3gNSA+yXqzUfJW-5M7D=aq43RUuo_Cg+f=xADk9h8VQ@mail.gmail.com>
Subject: Re: [PATCH] perf trace: Segfault when trying to trace events by cgroup
To:     Stanislav Ivanichkin <sivanichkin@yandex-team.ru>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Oct 20, 2020 at 5:48 AM Stanislav Ivanichkin
<sivanichkin@yandex-team.ru> wrote:
>
> Hi,
>
> +linux-perf-users@
>
> Gentle ping for this patch
>
> Many Thanks
>
> --
> Stanislav Ivanichkin
>
> > On 9 Oct 2020, at 09:45, Stanislav Ivanichkin <sivanichkin@yandex-team.ru> wrote:
> >
> > # ./perf trace -e sched:sched_switch -G test -a sleep 1
> > perf: Segmentation fault
> > Obtained 11 stack frames.
> > ./perf(sighandler_dump_stack+0x43) [0x55cfdc636db3]
> > /lib/x86_64-linux-gnu/libc.so.6(+0x3efcf) [0x7fd23eecafcf]
> > ./perf(parse_cgroups+0x36) [0x55cfdc673f36]
> > ./perf(+0x3186ed) [0x55cfdc70d6ed]
> > ./perf(parse_options_subcommand+0x629) [0x55cfdc70e999]
> > ./perf(cmd_trace+0x9c2) [0x55cfdc5ad6d2]
> > ./perf(+0x1e8ae0) [0x55cfdc5ddae0]
> > ./perf(+0x1e8ded) [0x55cfdc5ddded]
> > ./perf(main+0x370) [0x55cfdc556f00]
> > /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xe6) [0x7fd23eeadb96]
> > ./perf(_start+0x29) [0x55cfdc557389]
> > Segmentation fault
> >
> > It happens because "struct trace" in option->value is passed to
> > parse_cgroups function instead of "struct evlist".
> >
> > Signed-off-by: Stanislav Ivanichkin <sivanichkin@yandex-team.ru>
> > Reviewed-by: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>

It seems we should add this too:
Fixes: 9ea42ba4411ac ("perf trace: Support setting cgroups as targets")

> > ---
> > tools/perf/builtin-trace.c | 9 ++++++---
> > 1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index bea461b6f937..cbc4de6840db 100644
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> > @@ -4651,9 +4651,12 @@ static int trace__parse_cgroups(const struct option *opt, const char *str, int u
> > {
> >       struct trace *trace = opt->value;
> >
> > -     if (!list_empty(&trace->evlist->core.entries))
> > -             return parse_cgroups(opt, str, unset);
> > -
> > +     if (!list_empty(&trace->evlist->core.entries)) {
> > +             struct option o = OPT_CALLBACK('G', "cgroup", &trace->evlist,
> > +                     "name", "monitor event in cgroup name only",
> > +                     parse_cgroups);

Just make it simple and clear what parse_cgroups() expects:

        struct option o = {
                .value = &trace->evlist,
        };

Or else, we can change parse_cgroups() to take evlist directly.
But it needs to change other callsites too.

Either is fine to me.

Thanks
Namhyung

> > +             return parse_cgroups(&o, str, unset);
> > +     }
> >       trace->cgroup = evlist__findnew_cgroup(trace->evlist, str);
> >
> >       return 0;
> > --
> > 2.17.1
> >
>
