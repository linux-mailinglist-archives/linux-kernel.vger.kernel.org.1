Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E239274C62
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 00:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgIVWpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 18:45:47 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46521 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgIVWpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 18:45:46 -0400
Received: by mail-wr1-f68.google.com with SMTP id o5so18791734wrn.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 15:45:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rczru/nc19Jyd38Z4CrOwJnvqgVbZmKCBdrj8hAjm8Q=;
        b=m8lfWDfiegtB7lxlguTj3f2XCTnXMgkjq+V2lfXcBalVHqBTdEUGV0d+aMrhDochY6
         Y4mzXR+DPp9oeWVYkK08BIY1vS5hc1wqGcV4T+tVVtSVYGttFsYFfcdhs0mzFG1r7w7j
         dHzQbZOUYSJg4xJhO3UdzNHXllTBvwm+BONMaiCHHAihZ2Ck9y+z/uFMtEV58m6Hz8c6
         YRVwunUwsWNdRS++l6Vqtr8IQWdf1UkR3gDJzbopZU9MbOJynHzCDwPCzdj05QSMBnJI
         p2swEKq7dBYrtibsm8voXuJ50RwdImGdHbBWSSB1S/lWjR4gp8vX7gNFRVrhD9A7jIaK
         9Hmg==
X-Gm-Message-State: AOAM533p/0/YZ7bfaduZ+TOzg9XmC/H+n0MB4dlf3DCA2eLYqL1fWa/C
        3UPC4bnUlOuzfdziqX6c+3TNgno0Cfm1lQMmGJo=
X-Google-Smtp-Source: ABdhPJyxRCU4hyky0y31hjaVohnvuUvmzFjZYVCYydERggfMozmByLiMjw9tveOw5uIMbywWYFpt5ejrdyHZlKUBBB4=
X-Received: by 2002:adf:8b48:: with SMTP id v8mr7746445wra.21.1600814744871;
 Tue, 22 Sep 2020 15:45:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200909055849.469612-1-namhyung@kernel.org> <20200909055849.469612-3-namhyung@kernel.org>
 <CAP-5=fVT1SMB2G91SS28UVwXggZmYAGaqOPp2ozPoA=Yf0P3Ww@mail.gmail.com>
In-Reply-To: <CAP-5=fVT1SMB2G91SS28UVwXggZmYAGaqOPp2ozPoA=Yf0P3Ww@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 23 Sep 2020 07:45:34 +0900
Message-ID: <CAM9d7cgBduHhqqS6eOJUuvxMvTpp4aN+OoN5cfwxAFAcQ_uEoQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] perf list: Add 'pfm' to list libpfm4 events
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Ian,

On Wed, Sep 23, 2020 at 5:50 AM Ian Rogers <irogers@google.com> wrote:
>
> On Tue, Sep 8, 2020 at 10:59 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Print libpfm4 events with 'perf list pfm' command like others.
> > When libpfm4 support is not enabled, it'd print nothing.
> > Also it support glob pattern matching for event name.
> >
> >   $ perf list pfm
> >
> >   List of pre-defined events (to be used in --pfm-events):
> >
> >   ix86arch:
> >     UNHALTED_CORE_CYCLES
> >       [count core clock cycles whenever the clock signal ...
> >     INSTRUCTION_RETIRED
> >       [count the number of instructions at retirement. ...
> >     ...
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> >
> > diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
> > index 10ab5e40a34f..167868053fe0 100644
> > --- a/tools/perf/builtin-list.c
> > +++ b/tools/perf/builtin-list.c
> > @@ -14,6 +14,7 @@
> >  #include "util/pmu.h"
> >  #include "util/debug.h"
> >  #include "util/metricgroup.h"
> > +#include "util/pfm.h"
> >  #include <subcmd/pager.h>
> >  #include <subcmd/parse-options.h>
> >  #include <stdio.h>
> > @@ -42,7 +43,7 @@ int cmd_list(int argc, const char **argv)
> >                 OPT_END()
> >         };
> >         const char * const list_usage[] = {
> > -               "perf list [<options>] [hw|sw|cache|tracepoint|pmu|sdt|metric|metricgroup|event_glob]",
> > +               "perf list [<options>] [hw|sw|cache|tracepoint|pmu|sdt|metric|metricgroup|pfm|event_glob]",
>
> Should this be "#ifdef HAVE_LIBPFM" to avoid advertising pfm events
> when support isn't compiled in?

I thought about that too, but it's a keyword and current code
already handles it to print nothing, so I think it's ok to have.

Thanks
Namhyung
