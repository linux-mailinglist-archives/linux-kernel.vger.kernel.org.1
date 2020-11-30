Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC7B22C851C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 14:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgK3N1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 08:27:52 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39793 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbgK3N1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 08:27:51 -0500
Received: by mail-lf1-f67.google.com with SMTP id j205so21601585lfj.6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 05:27:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1XGgCXSLaLf6vBGHZaxG3cMHUJleWNY0e8CzFxGWDyY=;
        b=ZZoJJNDDBWBS1O28Z8ls61qFY9TQIqOUrnPKxE73BI+QZ3L6TXcY6pTc01ogngwkW8
         o5MIPFJaYV3IBm1vdUXwrgdIJeGZVh+W0fAGMiERfUVzXMHk4IOBlDbcUvF7N+unTMPG
         HfGLgkQWxghK9Nyppau3oRDn2poPja6FTY9We1Q+peew3h9tIFMyAd7K6PB8/1cMedgc
         Jt1iCWnAn1HATyvBlSaOgdW4lqSsNQqzePjDs1clTDreU8KadOPhNwKLcH/Q9DORrkjg
         QYP7OOnxJnEi8iTKdgo/WYBnnGF3g7vecQBautDEkpOejObEyRS5GVQnCd+UMbsDG+Q0
         tBQw==
X-Gm-Message-State: AOAM531ER9Zz0U0lsh7P87zTRsmGfIKy8vlod4b6ymNiudwBfws1p5tP
        aJ3xSm4hxRi3A65YRmb9KhNIcPTR0B+lZqpPxZGFjNSQ
X-Google-Smtp-Source: ABdhPJzoHqxmiRWlqULZ9XGCjS8mjvqDzomj2a9Nu9rPeHQuhl/U1Q6lIH3c1RxuR3CIfze3XBA2AxsBN4LG3X0/QDc=
X-Received: by 2002:a19:38e:: with SMTP id 136mr2972932lfd.593.1606742829525;
 Mon, 30 Nov 2020 05:27:09 -0800 (PST)
MIME-Version: 1.0
References: <20201127054356.405481-1-namhyung@kernel.org> <20201127154557.GB2729821@krava>
In-Reply-To: <20201127154557.GB2729821@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 30 Nov 2020 22:26:58 +0900
Message-ID: <CAM9d7cgBbSEy9r+Kh5-06bTii5GED81gdtYiJ7AOkQKo9NbVhw@mail.gmail.com>
Subject: Re: [PATCH] perf record: Synthesize cgroup events only if needed
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
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

On Sat, Nov 28, 2020 at 12:46 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Fri, Nov 27, 2020 at 02:43:56PM +0900, Namhyung Kim wrote:
> > It didn't check the tool->cgroup_events bit which is set when
> > the --all-cgroups option is given.  Without it, samples will not have
> > cgroup info so no reason to synthesize.
> >
> > We can check the PERF_RECORD_CGROUP records after running perf record
> > *WITHOUT* the --all-cgroups option:
> >
> > Before:
> >   $ perf report -D | grep CGROUP
> >   0 0 0x8430 [0x38]: PERF_RECORD_CGROUP cgroup: 1 /
> >           CGROUP events:          1
> >           CGROUP events:          0
> >           CGROUP events:          0
> >
> > After:
> >   $ perf report -D | grep CGROUP
> >           CGROUP events:          0
> >           CGROUP events:          0
> >           CGROUP events:          0
> >
> > Fixes: 8fb4b67939e16 ("perf record: Add --all-cgroups option")
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/synthetic-events.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> > index 8a23391558cf..d9c624377da7 100644
> > --- a/tools/perf/util/synthetic-events.c
> > +++ b/tools/perf/util/synthetic-events.c
> > @@ -563,6 +563,9 @@ int perf_event__synthesize_cgroups(struct perf_tool *tool,
> >       char cgrp_root[PATH_MAX];
> >       size_t mount_len;  /* length of mount point in the path */
> >
> > +     if (!tool || !tool->cgroup_events)
> > +             return 0;
>
> can !tool actually happen here? or it's just being extra cautious

Actually I just copied the namespace code. :).
It's only called from perf record and top, and neither of them pass NULL.

>
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks,
Namhyung
