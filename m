Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE4EB294B79
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 12:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439052AbgJUKvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 06:51:13 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38280 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439039AbgJUKvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 06:51:13 -0400
Received: by mail-wm1-f65.google.com with SMTP id b127so1603465wmb.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 03:51:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PqFvCGU23iOTh/yBXkLIt0ccOeDmnu1NCfHunqJygNg=;
        b=B+iZLcKv24lrAvgNmf7GCutuA0vw6Y9b3zIorTochjgohW4k90PM4Ve1rIB6Vjix4L
         EioH0SImKmlOmV1OzuUnMWXehVx84QX6i0ndTH1GgtP9ljVmzpxV0gm51bwIkMBoGT5b
         mA3fkLb7iSRe4RSUmqI8kSJlDfhJ3mWRTej0TotVh8bcvJDUi7195/n8Vu7wmlhwNK98
         dSEasdJ803e4Rzs8ZqrF9ulSULnQ2+3t4p33Vz0+Zr9g+U0BOzFr8b2K9vd5lqp86AfN
         hRDRrC5HS5QJKzIdKE2x6LhkJkvtG+o53SgMThfFoITb8FsFBuJfMayB6BRo2ILiyByU
         xjRw==
X-Gm-Message-State: AOAM531B5cjoq2LEgcQ+lMXEQaAl83Ss+nSptDMOIZTM2YCEsXHpg4Z8
        G2H9Exba4TMEPwGqnaA3GtzfH7qqtXH76F8pn4s=
X-Google-Smtp-Source: ABdhPJy/NU27eYs3btzW8/3QqsE/seCuUieRCi/YAkBIHa03STxPMM1g9uhxO4e/EdBVuZCfKfCmpufeMaXphqKD8wk=
X-Received: by 2002:a1c:7e82:: with SMTP id z124mr2876159wmc.8.1603277471120;
 Wed, 21 Oct 2020 03:51:11 -0700 (PDT)
MIME-Version: 1.0
References: <810f3a69-0004-9dff-a911-b7ff97220ae0@linux.intel.com>
 <0652b8dd-e753-7c10-27e9-af9524e7ccc5@linux.intel.com> <CAM9d7cgrXsiPWuAYjg1og0N=03-mfx075-n7KUrvYyAMLZ8_7A@mail.gmail.com>
 <81ffefab-ac4e-c51c-809a-b9ba96d6d867@linux.intel.com> <CAM9d7cggG7yL3iaH_9-ibBgw4k+NLSU14uQSJHuaskLnv2sD_A@mail.gmail.com>
 <0dd08c91-f48d-28db-92ed-a2b014bdcb05@linux.intel.com>
In-Reply-To: <0dd08c91-f48d-28db-92ed-a2b014bdcb05@linux.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 21 Oct 2020 19:51:00 +0900
Message-ID: <CAM9d7cjc5yMSCsHCOEa6UGrkpBUK3eBq2n5bNXTJExkKZ5aavA@mail.gmail.com>
Subject: Re: [PATCH v1 08/15] perf record: write trace data into mmap trace files
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 7:25 PM Alexey Budankov
<alexey.budankov@linux.intel.com> wrote:
>
>
> On 21.10.2020 10:34, Namhyung Kim wrote:
> > On Wed, Oct 14, 2020 at 9:09 PM Alexey Budankov
> > <alexey.budankov@linux.intel.com> wrote:
> >>
> >> Hi,
> >>
> >> On 14.10.2020 13:52, Namhyung Kim wrote:
> >>> Hi,
> >>>
> >>> On Mon, Oct 12, 2020 at 6:01 PM Alexey Budankov
> >>> <alexey.budankov@linux.intel.com> wrote:
> >>>>
> >>>>
> >>>> Write trace data into per mmap trace files located
> >>>> at data directory. Streaming thread adjusts its affinity
> >>>> according to mask of the buffer being processed.
> >>>>
> >>>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> >>>> ---
> >>> [SNIP]
> >>>> @@ -1184,8 +1203,12 @@ static int record__mmap_read_evlist(struct record *rec, struct evlist *evlist,
> >>>>         /*
> >>>>          * Mark the round finished in case we wrote
> >>>>          * at least one event.
> >>>> +        *
> >>>> +        * No need for round events in directory mode,
> >>>> +        * because per-cpu maps and files have data
> >>>> +        * sorted by kernel.
> >>>>          */
> >>>> -       if (bytes_written != rec->bytes_written)
> >>>> +       if (!record__threads_enabled(rec) && bytes_written != rec->bytes_written)
> >>>>                 rc = record__write(rec, NULL, &finished_round_event, sizeof(finished_round_event));
> >>>
> >>> This means it needs to keep all events in the ordered events queue
> >>> when perf report processes the data, right?
> >>
> >> Looks so.
> >
> > Maybe it's not related to this directly. But we need to think about
> > how to make perf report faster and more efficient as well.
>
> Makes sense. Agreed.
>
> >
> > In my previous attempt, I separated samples from other events
> > to be in different mmaps so they were saved to different files
> > (or in a separate part of the data file).
> >
> > And perf report processes the meta events (FORK/MMAP/...)
> > first to construct the system image and then processes samples
> > with multi-threads.
>
> Looks like separation to global, per-process events and per-thread
> ones. Alternative algorithm could possibly be multi-passing of trace
> data. First pass is to capture global events and build process state
> overtime progress picture. Second pass is to capture and map per-thread
> samples and/or other events into process state according to samples
> and events time.

Yep, it seems basically the same approach.  But it'd be better if
we could do it in a single pass (with some modification in the data
collection).

Thanks
Namhyung
