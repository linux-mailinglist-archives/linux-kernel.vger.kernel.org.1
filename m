Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 195142843D1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 03:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgJFB2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 21:28:50 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35600 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgJFB2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 21:28:50 -0400
Received: by mail-wm1-f66.google.com with SMTP id q5so598324wmq.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 18:28:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cHIC6bb+RGTNW7u5kPtxCqB0KdiUWVA0gVkxLqHj3nE=;
        b=Kp9qwLwLpnEQxgZB8dIgRn77acSM5FtvPMhFocboUKfwYze4XZrvsT8gs1+mIRC7x7
         SweN6LUX9VMCAHMgil62Cd4xcwEOkEwoMxdvWUt0aDNfITwN5VlI695Vrkp0LeBfNiBe
         8+9hdOpTI0qZ+rVDuToiNoaFnvc3Tkg59qItLzRectuA/kY4/l4KrYJRcKoAMvUg4Qag
         SO+NUE7zYgYbjO9tFr7UHpZGgPDaKcgEwT3Nb92K41v7+NMzc9aDCR7/bO6ZxmFiYDL4
         v9HwWqQf0GnmB+8QCLMDaWp5oz+Ni77ANq1TtAXfVumqvrITJrvjvV4cTuF/f0jOA0Ji
         mULQ==
X-Gm-Message-State: AOAM531bXfiwjyv8cee7vLOrwRDUAFkvZwFj4SRF0CucVwaLtaTnXr/p
        gUuyRNjMaeKgoDwWubd6zcqhbOjb2mrrNfyjy0E=
X-Google-Smtp-Source: ABdhPJxCTGqyrV9ebhnToeUAMNbo6NX8dQ8ksUxCnwgdVMjVMr0fObRaSWP6mw5rL7fgEl5p+JZZ3G3GV/vTYJrFDTY=
X-Received: by 2002:a1c:e283:: with SMTP id z125mr2104665wmg.154.1601947726517;
 Mon, 05 Oct 2020 18:28:46 -0700 (PDT)
MIME-Version: 1.0
References: <20201002130317.1356440-1-namhyung@kernel.org> <20201004195239.GA217601@krava>
In-Reply-To: <20201004195239.GA217601@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 6 Oct 2020 10:28:35 +0900
Message-ID: <CAM9d7cgsxkefHAgyMf-GoP4-OdSsaRmhSGLwPMoYn=-c9YXxDw@mail.gmail.com>
Subject: Re: [PATCH] perf inject: Flush ordered events on FINISHED_ROUND
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>,
        Al Grant <al.grant@foss.arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On Mon, Oct 5, 2020 at 4:52 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Fri, Oct 02, 2020 at 10:03:17PM +0900, Namhyung Kim wrote:
> > Currently perf inject just repipes the event without any flush.  It
> > makes an issue that it changes the order of events processed.
> >
> > Normally we want to process events in time order, but events are
> > recorded from several cpus and they weren't sorted with each other.
> > So we put them into the ordered event queue, sorted by time, and flush
> > them when we see a next FINISHED_ROUND event.
> >
> > But this is for events from kernel, user space events (like the
> > FINISHED_ROUND) are processed without queueing.  So during the perf
> > inject, it writes all the FINISHED_ROUND events directly while
> > SAMPLE (and other) events are kept in the queue.  This makes the user
> > space events are put before any kernel events.
> >
> > You can see that with the following command:
> >
> >   $ perf record -a -o- sleep 1 | perf inject -b | perf script -i- --show-round-events
> >   PERF_RECORD_FINISHED_ROUND
> >   PERF_RECORD_FINISHED_ROUND
> >   PERF_RECORD_FINISHED_ROUND
> >   ...
> >
> > Omitting perf inject, you can see the events are placed in the middle
> > of the data.
> >
> > You might argue that the whole point of the FINISHED_ROUND event is to
> > sort (kernel) events.  And after perf inject, all events are written
> > in a proper time order so we don't care about the FINISHED_ROUND event
> > anymore.
> >
> > But the problem is we don't know whether the input data is sorted or
> > not (maybe we can add a feature bit for this?) so it should use an
> > ordered event queue when processing the input like in perf report.
>
> I like the idea of storing the information that the data is sorted,
> and when it's there, let's not use ordered_oevets

Thanks for your input.  Yeah, I think it's better not to use it if possible.

>
> >
> > Remember all the FINISHED_ROUND events now come before other events so
> > the tool cannot know when it can flush the data so everything will be
> > queued until it meets the end of the input.  Actually it's same for
> > perf inject itself as it doesn't flush the queue.
> >
> > Below measures time and memory usage during the perf inject and
> > report using ~190MB data file.
> >
> > Before:
> >   perf inject:  11.09 s,  382148 KB
> >   perf report:   8.05 s,  397440 KB
> >
> > After:
> >   perf inject:  16.24 s,   83376 KB
> >   perf report:   7.96 s,  216184 KB
> >
> > As you can see, it used 2x memory of the input size.  I guess it's
> > because it needs to keep the copy for the whole input.  But I don't
> > understand why processing time of perf inject increased..
>
> would be good to find out first

Will do!

Thanks
Namhyung
