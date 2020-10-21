Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 885F92948F4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 09:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501902AbgJUHfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 03:35:08 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34903 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441006AbgJUHfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 03:35:08 -0400
Received: by mail-wr1-f65.google.com with SMTP id n15so1854749wrq.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 00:35:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jVONTDolj4MDBS/GViWgsApTFkBxojD1bi5r7Oc5t8Y=;
        b=Wpq730NME9B1iMn+lLn2d8GqCstjIUb+lxLJGyqKiXe8dDqbZo3IMpcy/UZrri2RBl
         WuSlcURqGiWM0br51Hv/7yEC7JbAqBdi6dCthroZag8j6FGtA0du3DUnGJlZlbyJrgOZ
         8h4XemSHWwegYdvIuEPoPELIUzxWgDEa5A/QuBVZRx4+L+0iGylNgacNmQd/njUvxyTn
         TVaic02LIX8X0T6q7vMHFPqaAQyRl3eH+U2lJkpwpgtBJU+ZOXj/4S9IwhCjlBIG/28X
         niT/Uv/lAinb5C1gbjv224FajjunDeOPVae/meVorMCDnSk0Qp5tJ1NMzg/FVMYAq1pk
         pPWw==
X-Gm-Message-State: AOAM532QuAjNiPjpU6fv8R4e33BdCKD0lN8b8OErOU7TbZP3QwjA9qE/
        0bbMjvyauasd8AWSXt/+ZmJ558HcgQNOx43a7Vk=
X-Google-Smtp-Source: ABdhPJym0tQFT9ydIxfvheDs1zM1w74bQ3a4zxoo8fvB+HGLyit7OXDNUjooHSVppR6Kse3j/m5JBcHtwLHsv30w/ko=
X-Received: by 2002:adf:bb43:: with SMTP id x3mr2994127wrg.250.1603265707061;
 Wed, 21 Oct 2020 00:35:07 -0700 (PDT)
MIME-Version: 1.0
References: <810f3a69-0004-9dff-a911-b7ff97220ae0@linux.intel.com>
 <0652b8dd-e753-7c10-27e9-af9524e7ccc5@linux.intel.com> <CAM9d7cgrXsiPWuAYjg1og0N=03-mfx075-n7KUrvYyAMLZ8_7A@mail.gmail.com>
 <81ffefab-ac4e-c51c-809a-b9ba96d6d867@linux.intel.com>
In-Reply-To: <81ffefab-ac4e-c51c-809a-b9ba96d6d867@linux.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 21 Oct 2020 16:34:55 +0900
Message-ID: <CAM9d7cggG7yL3iaH_9-ibBgw4k+NLSU14uQSJHuaskLnv2sD_A@mail.gmail.com>
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

On Wed, Oct 14, 2020 at 9:09 PM Alexey Budankov
<alexey.budankov@linux.intel.com> wrote:
>
> Hi,
>
> On 14.10.2020 13:52, Namhyung Kim wrote:
> > Hi,
> >
> > On Mon, Oct 12, 2020 at 6:01 PM Alexey Budankov
> > <alexey.budankov@linux.intel.com> wrote:
> >>
> >>
> >> Write trace data into per mmap trace files located
> >> at data directory. Streaming thread adjusts its affinity
> >> according to mask of the buffer being processed.
> >>
> >> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> >> ---
> > [SNIP]
> >> @@ -1184,8 +1203,12 @@ static int record__mmap_read_evlist(struct record *rec, struct evlist *evlist,
> >>         /*
> >>          * Mark the round finished in case we wrote
> >>          * at least one event.
> >> +        *
> >> +        * No need for round events in directory mode,
> >> +        * because per-cpu maps and files have data
> >> +        * sorted by kernel.
> >>          */
> >> -       if (bytes_written != rec->bytes_written)
> >> +       if (!record__threads_enabled(rec) && bytes_written != rec->bytes_written)
> >>                 rc = record__write(rec, NULL, &finished_round_event, sizeof(finished_round_event));
> >
> > This means it needs to keep all events in the ordered events queue
> > when perf report processes the data, right?
>
> Looks so.

Maybe it's not related to this directly. But we need to think about
how to make perf report faster and more efficient as well.

In my previous attempt, I separated samples from other events
to be in different mmaps so they were saved to different files
(or in a separate part of the data file).

And perf report processes the meta events (FORK/MMAP/...)
first to construct the system image and then processes samples
with multi-threads.

Once it has the image, it could bypass the ordered events queue
entirely.

Thanks

Namhyung
