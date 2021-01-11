Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5961A2F10B1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 11:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729595AbhAKK6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 05:58:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56242 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729372AbhAKK6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 05:58:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610362609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e+Vq/8bmKni7bGYalB55TS1xHbS37RSImPWuJfrT6hY=;
        b=Ok+WBJXqvVPY6NCW71SUuwgNsGv9UB5h8d/94a28qOa6UrmZKWcpmDdiAlNRqtkvITsk8k
        Tyb/iCd24oKjotplk0h6saoCa5udG/isz3eYt4yUaOodHp8vbNebqc35/XXKEZTxgU2FT2
        Q2g6qrNcBD+mnrWmkHAp1YylKwxJx2g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-97Y9n1KrO7iVSz3KMHdvBg-1; Mon, 11 Jan 2021 05:56:45 -0500
X-MC-Unique: 97Y9n1KrO7iVSz3KMHdvBg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 68DC88049C2;
        Mon, 11 Jan 2021 10:56:43 +0000 (UTC)
Received: from krava (unknown [10.40.192.185])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0D07F19746;
        Mon, 11 Jan 2021 10:56:39 +0000 (UTC)
Date:   Mon, 11 Jan 2021 11:56:38 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Stephane Eranian <eranian@google.com>
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
Subject: Re: [PATCHv2] perf tools: Detect when pipe is passed as perf data
Message-ID: <20210111105638.GA1210240@krava>
References: <20201230110935.582332-1-jolsa@kernel.org>
 <CABPqkBTQfFWvEba-=T6ms=GTsjrZUosRQyZZK-EMZ2c_2NQvAA@mail.gmail.com>
 <20210106094934.GA972880@krava>
 <CABPqkBRx4JYG-g-HTw8-TCu0kv0GJ73_AX_APNp_3RW+HAAb2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBRx4JYG-g-HTw8-TCu0kv0GJ73_AX_APNp_3RW+HAAb2w@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 10, 2021 at 11:13:18PM -0800, Stephane Eranian wrote:
> On Wed, Jan 6, 2021 at 1:49 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Tue, Jan 05, 2021 at 05:33:38PM -0800, Stephane Eranian wrote:
> > > Hi,
> > >
> > > On Wed, Dec 30, 2020 at 3:09 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > > >
> > > > Currently we allow pipe input/output only through '-' string
> > > > being passed to '-o' or '-i' options, like:
> > > >
> > > It seems to me it would be useful to auto-detect that the perf.data
> > > file is in pipe vs. file mode format.
> > > Your patch detects the type of the file which is something different
> > > from the format of its content.
> >
> > hi,
> > it goes together with the format, once the output file
> > is pipe, the format is pipe as well
> >
> What I was saying is if I do:
> $ perf record -o - -a sleep 10 > perf.data
> $ perf report -i perf.data
> it should autodetect it is a pipe mode file.
> Does it do that today?

yes, your record stores pipe mode data to perf.data file,
and report detects pipe mode data even in normal file,
so we're fine here

jirka

> 
> > jirka
> >
> > > Thanks.
> > >
> > > >   # mkfifo perf.pipe
> > > >   # perf record --no-buffering -e 'sched:sched_switch' -o - > perf.pipe &
> > > >   [1] 354406
> > > >   # cat perf.pipe | ./perf --no-pager script -i - | head -3
> > > >             perf 354406 [000] 168190.164921: sched:sched_switch: perf:354406..
> > > >      migration/0    12 [000] 168190.164928: sched:sched_switch: migration/0:..
> > > >             perf 354406 [001] 168190.164981: sched:sched_switch: perf:354406..
> > > >   ...
> > > >
> > > > This patch detects if given path is pipe and set the perf data
> > > > object accordingly, so it's possible now to do above with:
> > > >
> > > >   # mkfifo perf.pipe
> > > >   # perf record --no-buffering -e 'sched:sched_switch' -o perf.pipe &
> > > >   [1] 360188
> > > >   # perf --no-pager script -i ./perf.pipe | head -3
> > > >             perf 354442 [000] 168275.464895: sched:sched_switch: perf:354442..
> > > >      migration/0    12 [000] 168275.464902: sched:sched_switch: migration/0:..
> > > >             perf 354442 [001] 168275.464953: sched:sched_switch: perf:354442..
> > > >
> > > > It's of course possible to combine any of above ways.
> > > >
> > > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > > ---
> > > > v2:
> > > >   - removed O_CREAT|O_TRUNC flags from pipe's write end
> > > >
> > > >  tools/perf/util/data.c | 27 +++++++++++++++++++++------
> > > >  1 file changed, 21 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
> > > > index f29af4fc3d09..4dfa9e0f2fec 100644
> > > > --- a/tools/perf/util/data.c
> > > > +++ b/tools/perf/util/data.c
> > > > @@ -159,7 +159,7 @@ int perf_data__update_dir(struct perf_data *data)
> > > >         return 0;
> > > >  }
> > > >
> > > > -static bool check_pipe(struct perf_data *data)
> > > > +static int check_pipe(struct perf_data *data)
> > > >  {
> > > >         struct stat st;
> > > >         bool is_pipe = false;
> > > > @@ -172,6 +172,15 @@ static bool check_pipe(struct perf_data *data)
> > > >         } else {
> > > >                 if (!strcmp(data->path, "-"))
> > > >                         is_pipe = true;
> > > > +               else if (!stat(data->path, &st) && S_ISFIFO(st.st_mode)) {
> > > > +                       int flags = perf_data__is_read(data) ?
> > > > +                                   O_RDONLY : O_WRONLY;
> > > > +
> > > > +                       fd = open(data->path, flags);
> > > > +                       if (fd < 0)
> > > > +                               return -EINVAL;
> > > > +                       is_pipe = true;
> > > > +               }
> > > >         }
> > > >
> > > >         if (is_pipe) {
> > > > @@ -190,7 +199,8 @@ static bool check_pipe(struct perf_data *data)
> > > >                 }
> > > >         }
> > > >
> > > > -       return data->is_pipe = is_pipe;
> > > > +       data->is_pipe = is_pipe;
> > > > +       return 0;
> > > >  }
> > > >
> > > >  static int check_backup(struct perf_data *data)
> > > > @@ -344,8 +354,11 @@ static int open_dir(struct perf_data *data)
> > > >
> > > >  int perf_data__open(struct perf_data *data)
> > > >  {
> > > > -       if (check_pipe(data))
> > > > -               return 0;
> > > > +       int err;
> > > > +
> > > > +       err = check_pipe(data);
> > > > +       if (err || data->is_pipe)
> > > > +               return err;
> > > >
> > > >         /* currently it allows stdio for pipe only */
> > > >         data->use_stdio = false;
> > > > @@ -410,8 +423,10 @@ int perf_data__switch(struct perf_data *data,
> > > >  {
> > > >         int ret;
> > > >
> > > > -       if (check_pipe(data))
> > > > -               return -EINVAL;
> > > > +       ret = check_pipe(data);
> > > > +       if (ret || data->is_pipe)
> > > > +               return ret;
> > > > +
> > > >         if (perf_data__is_read(data))
> > > >                 return -EINVAL;
> > > >
> > > > --
> > > > 2.26.2
> > > >
> > >
> >
> 

