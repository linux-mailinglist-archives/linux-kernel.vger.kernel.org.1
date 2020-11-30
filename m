Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED5C2C8523
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 14:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgK3N2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 08:28:54 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43035 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbgK3N2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 08:28:52 -0500
Received: by mail-lf1-f67.google.com with SMTP id q13so20934280lfr.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 05:28:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j0csbFIzozsMnyhn50xKomuHlY6U5Dl2TnqHby25wl8=;
        b=s3haJ1dcUFSnRO/V3eIwHk+4DPB4RZKDzkHzXQSqsHHTW2qGTjwZFqMVOJpQBdt+h+
         a8wzJQp6Fm6yIehwjJ0Tt/ioz3STplvpwcXn97CvcWJsI6uy9tgYVTQ8Ab9tgLEWoeI6
         v80acGt4YF/9SttY9uioC1r2ynjmxWfsQIQ3YNRlaveXydrFhjHuKbvq8iFyYK6WM8uS
         SxrrEDeFBH51Af4+AgFxbRxTDB9WXkAyl+NtMG5sB5n5LC/Qy693DbvQUrdLNdnNyuyQ
         3GjExZDbB5Zfe/UDvJfNW2mcdK0dgL9017IZHZUhXK5iDb07uOe0qal9T4ygaTjNxZlc
         stWA==
X-Gm-Message-State: AOAM5320Ez6xzJEZ1aUaJ6gueI+EiskheH1Sr1VdB4RIwc4utajXC6Iv
        h/iqHgPHAxygWyqT0wvNApIb0ht/3I5dT2hF6BI5xgWh
X-Google-Smtp-Source: ABdhPJwSthxjntNA4zeX3jjire6zyg+pfcWKFjJAuvlIKhLVTLiRkhbQewoRYd6dVnpqND5NVr7E9Q0hHL8//+xwv/A=
X-Received: by 2002:a05:6512:3587:: with SMTP id m7mr9341012lfr.149.1606742890659;
 Mon, 30 Nov 2020 05:28:10 -0800 (PST)
MIME-Version: 1.0
References: <20201127054356.405481-1-namhyung@kernel.org> <20201127154557.GB2729821@krava>
 <20201127173021.GN70905@kernel.org>
In-Reply-To: <20201127173021.GN70905@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 30 Nov 2020 22:27:59 +0900
Message-ID: <CAM9d7chmmB9=2-npHr8WnyA6jHqxQ+rf3jix+cHoa2C+3C9YJQ@mail.gmail.com>
Subject: Re: [PATCH] perf record: Synthesize cgroup events only if needed
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
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

Hi Arnaldo,

On Sat, Nov 28, 2020 at 2:30 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Fri, Nov 27, 2020 at 04:45:57PM +0100, Jiri Olsa escreveu:
> > On Fri, Nov 27, 2020 at 02:43:56PM +0900, Namhyung Kim wrote:
> > > It didn't check the tool->cgroup_events bit which is set when
> > > the --all-cgroups option is given.  Without it, samples will not have
> > > cgroup info so no reason to synthesize.
> > >
> > > We can check the PERF_RECORD_CGROUP records after running perf record
> > > *WITHOUT* the --all-cgroups option:
> > >
> > > Before:
> > >   $ perf report -D | grep CGROUP
> > >   0 0 0x8430 [0x38]: PERF_RECORD_CGROUP cgroup: 1 /
> > >           CGROUP events:          1
> > >           CGROUP events:          0
> > >           CGROUP events:          0
> > >
> > > After:
> > >   $ perf report -D | grep CGROUP
> > >           CGROUP events:          0
> > >           CGROUP events:          0
> > >           CGROUP events:          0
> > >
> > > Fixes: 8fb4b67939e16 ("perf record: Add --all-cgroups option")
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > ---
> > >  tools/perf/util/synthetic-events.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> > > index 8a23391558cf..d9c624377da7 100644
> > > --- a/tools/perf/util/synthetic-events.c
> > > +++ b/tools/perf/util/synthetic-events.c
> > > @@ -563,6 +563,9 @@ int perf_event__synthesize_cgroups(struct perf_tool *tool,
> > >     char cgrp_root[PATH_MAX];
> > >     size_t mount_len;  /* length of mount point in the path */
> > >
> > > +   if (!tool || !tool->cgroup_events)
> > > +           return 0;
> >
> > can !tool actually happen here? or it's just being extra cautious
> >
> > Acked-by: Jiri Olsa <jolsa@redhat.com>
>
> Thanks, tested with/without --all-cgroups and applied.

Thanks for doing that!

Namhyung
