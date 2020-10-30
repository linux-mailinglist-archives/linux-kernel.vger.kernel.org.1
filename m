Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C57BD29FD58
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 06:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725801AbgJ3Fen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 01:34:43 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35403 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbgJ3Fen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 01:34:43 -0400
Received: by mail-wr1-f65.google.com with SMTP id n15so5133003wrq.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 22:34:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=00j5sThSxa2QFPve9dm5iDHeaZfdFyNOce+8qoAaNjU=;
        b=TO/jqCwHkTJg37GUnr0OARUUQ1qk16EjEKg7EnAK9jB1tmc4n+qDMGKtY32bXsV0Gl
         7Ze53wdzAXhcGS5ezHk0R7WEJlRBd5/BxlC1/bFwHIKD+mUk5EsRQ5tS2m8H2hUxkH0d
         hLOt6nO3tslu9NmfeJWLZFjhLj1qgvFsYg3jFY45lQ1wzUJU1Bd/quaWLzAUXqGatQQx
         3H4gyJR9XCU3xUTRw/Ls5b84KuaCT+5GV6eRJUAc01PY0dEmZcr3MNjljE6Fsayup1Tg
         4LhMiyMWNtSHVo6yXtq0CShC5hV/XmwjWFlUQ6knq+B95t8iNX5eWimY0Ozmk0oJ1s2X
         nKPA==
X-Gm-Message-State: AOAM532vasmJCVHyTogfsxwlsTWFmpzuQ/d8tQ5cAkeGspFu6FrikkPs
        bdjsibPGgZhHlRWU7GhQ14pp2b6dUWMnAFZKYiIUE28j
X-Google-Smtp-Source: ABdhPJwD4tM9kS9G8VC+oLt88vgwI9LGt5LEuCU81Nuhb5lTznRWegjdfsxjHtiEzejRgKiNCcwz4KBdXUkixc9TzPA=
X-Received: by 2002:adf:a345:: with SMTP id d5mr816246wrb.55.1604036081336;
 Thu, 29 Oct 2020 22:34:41 -0700 (PDT)
MIME-Version: 1.0
References: <20201028085632.825804-1-namhyung@kernel.org> <20201029115743.GF3027684@krava>
In-Reply-To: <20201029115743.GF3027684@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 30 Oct 2020 14:34:30 +0900
Message-ID: <CAM9d7chTCOXWJnOmGZFTaMBCfi=nziZRGCKCiXRcjWGjZNWcng@mail.gmail.com>
Subject: Re: [PATCH] perf data: Allow to use stdio functions for pipe mode
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On Thu, Oct 29, 2020 at 8:57 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Wed, Oct 28, 2020 at 05:56:32PM +0900, Namhyung Kim wrote:
> > When perf data is in a pipe, it reads each event separately using
> > read(2) syscall.  This is a huge performance bottleneck when
> > processing large data like in perf inject.  Also perf inject needs to
> > use write(2) syscall for the output.
> >
> > So convert it to use buffer I/O functions in stdio library for pipe
> > data.  This makes inject-build-id bench time drops from 20ms to 8ms.
> >
> >   $ perf bench internals inject-build-id
> >   # Running 'internals/inject-build-id' benchmark:
> >     Average build-id injection took: 8.074 msec (+- 0.013 msec)
> >     Average time per event: 0.792 usec (+- 0.001 usec)
> >     Average memory usage: 8328 KB (+- 0 KB)
> >     Average build-id-all injection took: 5.490 msec (+- 0.008 msec)
> >     Average time per event: 0.538 usec (+- 0.001 usec)
> >     Average memory usage: 7563 KB (+- 0 KB)
> >
> > This patch enables it just for perf inject when used with pipe (it's a
> > default behavior).  Maybe we could do it for perf record and/or report
> > later..
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/builtin-inject.c |  2 ++
> >  tools/perf/util/data.c      | 36 +++++++++++++++++++++++++++++++++---
> >  tools/perf/util/data.h      | 11 ++++++++++-
> >  tools/perf/util/header.c    |  8 ++++----
> >  tools/perf/util/session.c   |  7 ++++---
> >  5 files changed, 53 insertions(+), 11 deletions(-)
> >
> > diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> > index 452a75fe68e5..14d6c88fed76 100644
> > --- a/tools/perf/builtin-inject.c
> > +++ b/tools/perf/builtin-inject.c
> > @@ -853,10 +853,12 @@ int cmd_inject(int argc, const char **argv)
> >               .output = {
> >                       .path = "-",
> >                       .mode = PERF_DATA_MODE_WRITE,
> > +                     .use_stdio = true,
> >               },
> >       };
> >       struct perf_data data = {
> >               .mode = PERF_DATA_MODE_READ,
> > +             .use_stdio = true,
> >       };
> >       int ret;
> >
> > diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
> > index c47aa34fdc0a..47b5a4b50ca5 100644
> > --- a/tools/perf/util/data.c
> > +++ b/tools/perf/util/data.c
> > @@ -174,8 +174,16 @@ static bool check_pipe(struct perf_data *data)
> >                       is_pipe = true;
> >       }
> >
> > -     if (is_pipe)
> > -             data->file.fd = fd;
> > +     if (is_pipe) {
> > +             if (data->use_stdio) {
> > +                     const char *mode;
> > +
> > +                     mode = perf_data__is_read(data) ? "r" : "w";
> > +                     data->file.fptr = fdopen(fd, mode);
>
> I guess fdopen should never fail right? but I think we should
> add BUG_ON(data->file.fptr == NULL) or something

The man page says it may fail when mode is invalid or malloc
failed internally.  Will add the check.

>
> other than this the change looks good, I can see the speedup
> in bench as well

Thanks!
Namhyung
