Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC612E6F8B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 10:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbgL2JrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 04:47:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25245 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725979AbgL2JrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 04:47:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609235133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EHujqTQJeLBNhAhHdnbewrD1ZbbPgrDviwX6XQxpul4=;
        b=cAvpnnVFyxhPONgr9HXeBl92D5i/T6uJDy3vjeT1LGql9dtLqI94Q5JIfOuYcsRg/ngn50
        075h8F9DGFuDByVI4OuU8727NdGbDqkP3lRXF/JGLTaZhpi3Q23qCrm2HT8HA5E3zSXhDt
        r6lkHO/LQPBCB6+n7G5r3vZ36wPzjk8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-aOlPMDqmPdKEWY3mWbYCxA-1; Tue, 29 Dec 2020 04:45:31 -0500
X-MC-Unique: aOlPMDqmPdKEWY3mWbYCxA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 450F4107ACE4;
        Tue, 29 Dec 2020 09:45:29 +0000 (UTC)
Received: from krava (unknown [10.40.192.119])
        by smtp.corp.redhat.com (Postfix) with SMTP id E9AA57216E;
        Tue, 29 Dec 2020 09:45:25 +0000 (UTC)
Date:   Tue, 29 Dec 2020 10:45:24 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexei Budankov <abudankov@huawei.com>
Subject: Re: [PATCH] perf tools: Detect when pipe is passed as perf data
Message-ID: <20201229094524.GG450923@krava>
References: <20201225222109.364465-1-jolsa@kernel.org>
 <CAM9d7ciF+_s+MqNou4szVSStBObtB87UznMMG8SsZkuRyR1dNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7ciF+_s+MqNou4szVSStBObtB87UznMMG8SsZkuRyR1dNg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 29, 2020 at 02:53:36PM +0900, Namhyung Kim wrote:
> On Sat, Dec 26, 2020 at 7:21 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Currently we allow pipe input/output only through '-' string
> > being passed to '-o' or '-i' options, like:
> >
> >   # mkfifo perf.pipe
> >   # perf record --no-buffering -e 'sched:sched_switch' -o - > perf.pipe &
> >   [1] 354406
> >   # cat perf.pipe | ./perf --no-pager script -i - | head -3
> >             perf 354406 [000] 168190.164921: sched:sched_switch: perf:354406..
> >      migration/0    12 [000] 168190.164928: sched:sched_switch: migration/0:..
> >             perf 354406 [001] 168190.164981: sched:sched_switch: perf:354406..
> >   ...
> >
> > This patch detects if given path is pipe and set the perf data
> > object accordingly, so it's possible now to do above with:
> >
> >   # mkfifo perf.pipe
> >   # perf record --no-buffering -e 'sched:sched_switch' -o perf.pipe &
> >   [1] 360188
> >   # perf --no-pager script -i ./perf.pipe | head -3
> >             perf 354442 [000] 168275.464895: sched:sched_switch: perf:354442..
> >      migration/0    12 [000] 168275.464902: sched:sched_switch: migration/0:..
> >             perf 354442 [001] 168275.464953: sched:sched_switch: perf:354442..
> >
> > It's of course possible to combine any of above ways.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/perf/util/data.c | 27 +++++++++++++++++++++------
> >  1 file changed, 21 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
> > index f29af4fc3d09..767b6c903cf5 100644
> > --- a/tools/perf/util/data.c
> > +++ b/tools/perf/util/data.c
> > @@ -159,7 +159,7 @@ int perf_data__update_dir(struct perf_data *data)
> >         return 0;
> >  }
> >
> > -static bool check_pipe(struct perf_data *data)
> > +static int check_pipe(struct perf_data *data)
> >  {
> >         struct stat st;
> >         bool is_pipe = false;
> > @@ -172,6 +172,15 @@ static bool check_pipe(struct perf_data *data)
> >         } else {
> >                 if (!strcmp(data->path, "-"))
> >                         is_pipe = true;
> > +               else if (!stat(data->path, &st) && S_ISFIFO(st.st_mode)) {
> > +                       int flags = perf_data__is_read(data) ?
> > +                                   O_RDONLY : O_WRONLY|O_CREAT|O_TRUNC;
> 
> I don't think we need O_CREAT here (maybe O_TRUNC as well).

I copied that from bash opening write end like:
  openat(AT_FDCWD, "perf.pipe", O_WRONLY|O_CREAT|O_TRUNC, 0666 <detached ...>

however I can't see any check on kernel side for that,
so it can removed.. I'll send new version

thanks,
jirka

