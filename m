Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40C48276900
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 08:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgIXGf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 02:35:58 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39956 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbgIXGf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 02:35:58 -0400
Received: by mail-wm1-f65.google.com with SMTP id k18so2327242wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 23:35:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yCHx2VeiLB6IqECj2sShNwXspdbG/zsdAAkzf8bNteo=;
        b=loUlysEMWnP+8CUYd2caiPG4AUdXbAqHB7tpiGrPfUstL5k41D4ON2nWs1hxAm9GNN
         IGBl3mfTpK6FzjHza3jflT05oXNsczU9XC0D9Mbr4fOVwr7yMsDWjsHI/GdNInswk3kU
         xWTeX9AZ7KMWjNH+9AfBHrbzhYCcj7njTEsg005xefMBSzrloqeeQ72xx/VI2rWVBLkD
         lWdG+SaYaphOlUOIKYxNt/g0pEjC+ISpldBi4SQCn6KuGMW8fI6UIJXtHubQs8DUGRKe
         N7qOuKieU/yTzz7ve8N6XS9hucxahM7/KhCrlaAwYDt6aQgJoLk95YZ+81Ab+U7EmasT
         mENw==
X-Gm-Message-State: AOAM532fPKL3QlTPw+DISlJfd4J7nr6JD1w8xrq1Bo2Q8M2gUpxVkM4n
        iN1KS49GY9qC5FrE2VDzbdJcKqIhulLbGC3mCrU=
X-Google-Smtp-Source: ABdhPJwY70LS8kbrizfaIFnA3Qs6RW+P0Zgt7DLooRB4qyFdwEK/3cMRIvLlFSUoLhfuVlXnTSsPvaQg7Zy0F7beSQ8=
X-Received: by 2002:a1c:1f08:: with SMTP id f8mr3006434wmf.168.1600929355822;
 Wed, 23 Sep 2020 23:35:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200923015945.47535-1-namhyung@kernel.org> <20200923015945.47535-6-namhyung@kernel.org>
 <CAP-5=fWzg9_wL7naAsyMOj5Z89S+jx6RzKnAf8g84ZWhcsOawA@mail.gmail.com>
In-Reply-To: <CAP-5=fWzg9_wL7naAsyMOj5Z89S+jx6RzKnAf8g84ZWhcsOawA@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 24 Sep 2020 15:35:44 +0900
Message-ID: <CAM9d7cgdBxW4xG3M3ifPOFWBt0y3nSJiopeFd6AcUvec_o=1tQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] perf test: Add expand cgroup event test
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 7:36 AM Ian Rogers <irogers@google.com> wrote:
>
> On Tue, Sep 22, 2020 at 7:00 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > It'll expand given events for cgroups A, B and C.
> >
> >   $ ./perf test -v expansion
> >   69: Event expansion for cgroups                      :
> >   --- start ---
> >   test child forked, pid 983140
> >   metric expr 1 / IPC for CPI
> >   metric expr instructions / cycles for IPC
> >   found event instructions
> >   found event cycles
> >   adding {instructions,cycles}:W
> >   copying metric event for cgroup 'A': instructions (idx=0)
> >   copying metric event for cgroup 'B': instructions (idx=0)
> >   copying metric event for cgroup 'C': instructions (idx=0)
> >   test child finished with 0
> >   ---- end ----
> >   Event expansion for cgroups: Ok
> >
> > Cc: John Garry <john.garry@huawei.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
[SNIP]
> Should this be #ifdef HAVE_LIBPFM ?

Do you mean the below function?
Actually I thought about it and ended up not using it.
Please see below..

>
> > +static int expand_libpfm_events(void)
> > +{
> > +       int ret;
> > +       struct evlist *evlist;
> > +       struct rblist metric_events;
> > +       const char event_str[] = "UNHALTED_CORE_CYCLES";
> > +       struct option opt = {
> > +               .value = &evlist,
> > +       };
> > +
> > +       symbol_conf.event_group = true;
> > +
> > +       evlist = evlist__new();
> > +       TEST_ASSERT_VAL("failed to get evlist", evlist);
> > +
> > +       ret = parse_libpfm_events_option(&opt, event_str, 0);
> > +       if (ret < 0) {
> > +               pr_debug("failed to parse libpfm event '%s', err %d\n",
> > +                        event_str, ret);
> > +               goto out;
> > +       }
> > +       if (perf_evlist__empty(evlist)) {
> > +               pr_debug("libpfm was not enabled\n");
> > +               goto out;
> > +       }

That's handled here.  The parse_libpfm_events_option()
will return 0 if HAVE_LIBPFM is not defined so evlist will be empty.

Thanks
Namhyung

> > +
> > +       rblist__init(&metric_events);
> > +       ret = test_expand_events(evlist, &metric_events);
> > +out:
> > +       evlist__delete(evlist);
> > +       return ret;
> > +}
> > +
