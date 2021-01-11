Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6673B2F0D20
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 08:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbhAKHOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 02:14:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727654AbhAKHOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 02:14:11 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34B6C061786
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 23:13:30 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id c5so15197362wrp.6
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 23:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NMQ9TUu6Ott6YwCLtNgucA5FwlrxogqgMWzOWnJT+xM=;
        b=sUbHV5ASpUVYEGnWDShpKVEozpCPQjFFfbNKninbSb7iV5GykAvSpByPf+vpSSNpZ9
         RpBVeJoAgM+PKLYR+rW80M6GVF7WXRAxflFCp9q9p+KNtbjZr+SYRGgmGvOkuHPyq6mm
         j3AsCtKRMctBId41qzCUdt8a70OneTJGsh8fnw+ElAr/wW0ym7ZgXP3QmgsZ61GY2P5e
         6ncj0LirbjEI3mzIBWqp+YDvC2rTypU9pLVWZQoAaZI53J1+ZOOBR8cuIK8Jb4NISVEZ
         MgY98xJ6gfmuF8AYNSnK3b4GWyu9HUclN2/ixw9EJfpGZIaDYLZ6ehqPj6FB4/T9Hhho
         TgUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NMQ9TUu6Ott6YwCLtNgucA5FwlrxogqgMWzOWnJT+xM=;
        b=rrqOoaaxnqRKp7wWYfJtiG6SfMqr2EQaFglIj372YE1EqsnSKQmmtPpfyW77+eC8gl
         ttDBrVlNucRKqa2IJerw7KNjSa6HpBUwjw9IdFozrJBkBP4+MfjIf495jcPCUPHzEZMR
         KXlEwBf0r3WDD7UOYJEyGcbhtEWO5weLuPqBuIYe6bbBcwznzo0WQYK4OEeHHl9LBhSe
         J12tO1U784EalZEEQfnrhg3amiHU7kcPOCtV79gHX1PCAkwWVCCQ4fKqHYBrGDcVKOkz
         t/kI5tQuuXewHAbHENIy8F6s1t7lxsFQDtxLahq8OtuO+DOcLPKr6fviJNyHRV34RYJ+
         /Fjw==
X-Gm-Message-State: AOAM532c7dnSu1D9y+weuzXPaxWeoZ7jgHD1XpjZj1qBPSfL+meXtLOn
        4Zo5BZ3aasvlppDF23rv+1byUglnUIQP/4an2DdpTQ==
X-Google-Smtp-Source: ABdhPJxGu+yYcuU9/fwwkLOI/feSWM43lO4/xUHtUP4dy+fkT6AsrxkwU3r0Uj2g6e8zaaSdngFH++Hmul3aC5GJE6s=
X-Received: by 2002:adf:d20b:: with SMTP id j11mr14425486wrh.318.1610349209440;
 Sun, 10 Jan 2021 23:13:29 -0800 (PST)
MIME-Version: 1.0
References: <20201230110935.582332-1-jolsa@kernel.org> <CABPqkBTQfFWvEba-=T6ms=GTsjrZUosRQyZZK-EMZ2c_2NQvAA@mail.gmail.com>
 <20210106094934.GA972880@krava>
In-Reply-To: <20210106094934.GA972880@krava>
From:   Stephane Eranian <eranian@google.com>
Date:   Sun, 10 Jan 2021 23:13:18 -0800
Message-ID: <CABPqkBRx4JYG-g-HTw8-TCu0kv0GJ73_AX_APNp_3RW+HAAb2w@mail.gmail.com>
Subject: Re: [PATCHv2] perf tools: Detect when pipe is passed as perf data
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Alexei Budankov <abudankov@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 6, 2021 at 1:49 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Tue, Jan 05, 2021 at 05:33:38PM -0800, Stephane Eranian wrote:
> > Hi,
> >
> > On Wed, Dec 30, 2020 at 3:09 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > >
> > > Currently we allow pipe input/output only through '-' string
> > > being passed to '-o' or '-i' options, like:
> > >
> > It seems to me it would be useful to auto-detect that the perf.data
> > file is in pipe vs. file mode format.
> > Your patch detects the type of the file which is something different
> > from the format of its content.
>
> hi,
> it goes together with the format, once the output file
> is pipe, the format is pipe as well
>
What I was saying is if I do:
$ perf record -o - -a sleep 10 > perf.data
$ perf report -i perf.data
it should autodetect it is a pipe mode file.
Does it do that today?

> jirka
>
> > Thanks.
> >
> > >   # mkfifo perf.pipe
> > >   # perf record --no-buffering -e 'sched:sched_switch' -o - > perf.pipe &
> > >   [1] 354406
> > >   # cat perf.pipe | ./perf --no-pager script -i - | head -3
> > >             perf 354406 [000] 168190.164921: sched:sched_switch: perf:354406..
> > >      migration/0    12 [000] 168190.164928: sched:sched_switch: migration/0:..
> > >             perf 354406 [001] 168190.164981: sched:sched_switch: perf:354406..
> > >   ...
> > >
> > > This patch detects if given path is pipe and set the perf data
> > > object accordingly, so it's possible now to do above with:
> > >
> > >   # mkfifo perf.pipe
> > >   # perf record --no-buffering -e 'sched:sched_switch' -o perf.pipe &
> > >   [1] 360188
> > >   # perf --no-pager script -i ./perf.pipe | head -3
> > >             perf 354442 [000] 168275.464895: sched:sched_switch: perf:354442..
> > >      migration/0    12 [000] 168275.464902: sched:sched_switch: migration/0:..
> > >             perf 354442 [001] 168275.464953: sched:sched_switch: perf:354442..
> > >
> > > It's of course possible to combine any of above ways.
> > >
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > > v2:
> > >   - removed O_CREAT|O_TRUNC flags from pipe's write end
> > >
> > >  tools/perf/util/data.c | 27 +++++++++++++++++++++------
> > >  1 file changed, 21 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
> > > index f29af4fc3d09..4dfa9e0f2fec 100644
> > > --- a/tools/perf/util/data.c
> > > +++ b/tools/perf/util/data.c
> > > @@ -159,7 +159,7 @@ int perf_data__update_dir(struct perf_data *data)
> > >         return 0;
> > >  }
> > >
> > > -static bool check_pipe(struct perf_data *data)
> > > +static int check_pipe(struct perf_data *data)
> > >  {
> > >         struct stat st;
> > >         bool is_pipe = false;
> > > @@ -172,6 +172,15 @@ static bool check_pipe(struct perf_data *data)
> > >         } else {
> > >                 if (!strcmp(data->path, "-"))
> > >                         is_pipe = true;
> > > +               else if (!stat(data->path, &st) && S_ISFIFO(st.st_mode)) {
> > > +                       int flags = perf_data__is_read(data) ?
> > > +                                   O_RDONLY : O_WRONLY;
> > > +
> > > +                       fd = open(data->path, flags);
> > > +                       if (fd < 0)
> > > +                               return -EINVAL;
> > > +                       is_pipe = true;
> > > +               }
> > >         }
> > >
> > >         if (is_pipe) {
> > > @@ -190,7 +199,8 @@ static bool check_pipe(struct perf_data *data)
> > >                 }
> > >         }
> > >
> > > -       return data->is_pipe = is_pipe;
> > > +       data->is_pipe = is_pipe;
> > > +       return 0;
> > >  }
> > >
> > >  static int check_backup(struct perf_data *data)
> > > @@ -344,8 +354,11 @@ static int open_dir(struct perf_data *data)
> > >
> > >  int perf_data__open(struct perf_data *data)
> > >  {
> > > -       if (check_pipe(data))
> > > -               return 0;
> > > +       int err;
> > > +
> > > +       err = check_pipe(data);
> > > +       if (err || data->is_pipe)
> > > +               return err;
> > >
> > >         /* currently it allows stdio for pipe only */
> > >         data->use_stdio = false;
> > > @@ -410,8 +423,10 @@ int perf_data__switch(struct perf_data *data,
> > >  {
> > >         int ret;
> > >
> > > -       if (check_pipe(data))
> > > -               return -EINVAL;
> > > +       ret = check_pipe(data);
> > > +       if (ret || data->is_pipe)
> > > +               return ret;
> > > +
> > >         if (perf_data__is_read(data))
> > >                 return -EINVAL;
> > >
> > > --
> > > 2.26.2
> > >
> >
>
