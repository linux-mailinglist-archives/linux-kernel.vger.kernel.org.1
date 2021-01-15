Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35F282F736D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 08:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731065AbhAOHCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 02:02:30 -0500
Received: from mail-qt1-f180.google.com ([209.85.160.180]:33925 "EHLO
        mail-qt1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728269AbhAOHC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 02:02:28 -0500
Received: by mail-qt1-f180.google.com with SMTP id c1so5411258qtc.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 23:02:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8n4V8bmSwG+682vPPQtjmBOx1a9F9WqGNNf7BZzvgf4=;
        b=BS0oyZP9lf9VFhzz7lpoR6Js6NRJDtYVHjPgQ29NcPybmu0RF4HdKqvVKvfU18Fg73
         wkHadSRenrs1/EkDozg3WK7aK8ITDIRVfni00cx8t7QH4w62lb8lnasxCjMdtnkYtVTq
         YrXIUfPXYvOGfCR8tk3ld4sODyzwzHgXo7yxOfq2y2zUC1HpJM7+E4bUlBXyZ6s2huPC
         0EzKcyUJo5fs6lfr0E+x+rVWzZCi+eZMUccdvPp1cxsrjHZtF1bRP6Cr56DBLju2XigT
         zADjHu1mfTWBsfGdAhgQBwXZarg2hIt7LSnekeb7n+rODWFxichYTU7L57alYc4N17v1
         HvOw==
X-Gm-Message-State: AOAM5339WWoWu1h/j0Slb3hN1kteggs+zRSsOoR9g3Fw4FqPSY9VVNkF
        ht4ZUhSxbzugdveCzbtC4ZkPhP0pGicLdvGAC/E=
X-Google-Smtp-Source: ABdhPJyuTBYJnieboGbUtuQmdCc6q3ph//VApOKCFT8lIr1pMGhnGy4EQTvN19SQylCms3Ozfq1s+fTbkWXSK688UyI=
X-Received: by 2002:ac8:4711:: with SMTP id f17mr2198739qtp.256.1610694106820;
 Thu, 14 Jan 2021 23:01:46 -0800 (PST)
MIME-Version: 1.0
References: <20210112061431.1122838-1-namhyung@kernel.org> <20210113111902.GD1331835@krava>
 <CAM9d7cig3+P3Q+gAQNRQJJqB+wcNT+KVjo+9AU92AZ+QvP6ZAg@mail.gmail.com> <20210114132226.GA1409793@krava>
In-Reply-To: <20210114132226.GA1409793@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 15 Jan 2021 16:01:34 +0900
Message-ID: <CAM9d7cgJEdkTRoQr7vP6MktDxemL3dJXjBuO-YtXNtFxjVMx6A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] perf stat: Introduce struct runtime_stat_data
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 10:22 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Thu, Jan 14, 2021 at 12:25:39PM +0900, Namhyung Kim wrote:
> > Hi Jiri,
> >
> > On Wed, Jan 13, 2021 at 8:19 PM Jiri Olsa <jolsa@redhat.com> wrote:
> > >
> > > On Tue, Jan 12, 2021 at 03:14:30PM +0900, Namhyung Kim wrote:
> > > > To pass more info to the saved_value in the runtime_stat, add a new
> > > > struct runtime_stat_data.  Currently it only has 'ctx' field but later
> > > > patch will add more.
> > > >
> > > > Suggested-by: Andi Kleen <ak@linux.intel.com>
> > > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > > ---
> > > >  tools/perf/util/stat-shadow.c | 346 +++++++++++++++++-----------------
> > > >  1 file changed, 173 insertions(+), 173 deletions(-)
> > > >
> > > > diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
> > > > index 901265127e36..a1565b6e38f2 100644
> > > > --- a/tools/perf/util/stat-shadow.c
> > > > +++ b/tools/perf/util/stat-shadow.c
> > > > @@ -114,6 +114,10 @@ static struct saved_value *saved_value_lookup(struct evsel *evsel,
> > > >
> > > >       rblist = &st->value_list;
> > > >
> > > > +     /* don't use context info for clock events */
> > > > +     if (type == STAT_NSECS)
> > > > +             dm.ctx = 0;
> > > > +
> > >
> > > I think this should go to separate patch and be explained,
> > > the change is advertised as adding struct for arguments
> >
> > Actually it was already there and I found it during this work.
> > Basically it passes ctx for lookup but it uses 0 for time.
> > Please see below..
>
> ah nice, did not see that.. could be mentioned in the changelog ;-)

OK, will send v3.

Thanks,
Namhyung
