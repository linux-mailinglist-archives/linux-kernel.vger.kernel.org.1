Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2F93269A0E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 02:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbgIOADq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 20:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgIOADm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 20:03:42 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A02EC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 17:03:42 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id l15so6889044wmh.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 17:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mDviW9jeDSA5yR4HqgWgtYvMOTzX28ml1rMx9G8r0d4=;
        b=lAqLJfaTGK0xCxaMvadkZ/+PbQeB69nE5weXHYfOxBt0vyojVWqgTyrALcJcsVScEu
         ZW1PEwVC3MnwQFYYBwssvtHWBtgq3+kyIbKVyUDjwF7rO2SHeq3OXglCjITNqQi7nNe9
         awq3Cts9cU7ENgj7+595yvQ/RB6Pp+eE/wnsTgPqXFV0D50japatf23hlZ6pbhYBttyi
         +tk4lw2EnMpymw0Er0hTjrkU7f0+wdgi6rlazxpY4Mc7RnSKNaZM90AoDDSiOqeIGu6p
         eJyzLl0WzkiEfXQfRzFqAe/GiAXxNyT/YAEbs0rsNIqoBLrf03QE4JfQMYjo5FulOwvY
         6ONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mDviW9jeDSA5yR4HqgWgtYvMOTzX28ml1rMx9G8r0d4=;
        b=cPSaNRiKWHZM1X14nHOU1HC26K2iHOlJW+CzLEETdI8kuJRJMyCp0KbZDg9p1/oraz
         JeHESCRV1O4sJgwi3EDebGgQb7qqmSMRPq2Zy0qZoONKvRD6wFbkdhPwOZRNcIQaysbe
         G8jSUfywH/gmnKECgIncV65kt0NM1iYtS0ouurmZ0yCEvTaP3BLuj1JCNXJISwnSEVAD
         85Q5/aOhD0t325MrucQQbntBKPN2pp8SWoiBfcDOC7Ijy1y0Tmtbdg0Uqk9xVhQ7WTUU
         pnlP2ZGpjHQuWP2jralie+RpiquF7S6RepyqU0xHzOHVBF8vK8ZZhrgDkDAfeSz7dL8I
         b8hA==
X-Gm-Message-State: AOAM531VkO6JZN7fv4t5uJCs19Y1TzIAgMvyUZCSvVogWYHCe2W3cS+C
        bqn2ZPpXzC/0QkVh/ugQ3JK9Tnqwic8I8Ih4yyI9lQ==
X-Google-Smtp-Source: ABdhPJxR5i1u89efvYIEt5Dr4ppP3zu1ZQSrKr9RV/ih3A7oMbpNiINOyEC1zrgcvkRpNrzgMhSMow02fyKsQWJPUxk=
X-Received: by 2002:a1c:f402:: with SMTP id z2mr1652654wma.87.1600128220443;
 Mon, 14 Sep 2020 17:03:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200913210313.1985612-1-jolsa@kernel.org> <20200913210313.1985612-3-jolsa@kernel.org>
 <CABPqkBTk+SwTAxXDa6HL8TqvEmUunfMZxpAtx6CebNbd+3hEHw@mail.gmail.com>
 <20200914090811.GM1362448@hirez.programming.kicks-ass.net> <CABPqkBSKpZFbYWrQueS9cFDkGJPb3NdA1HTPh0+XN_+qvLpdLw@mail.gmail.com>
In-Reply-To: <CABPqkBSKpZFbYWrQueS9cFDkGJPb3NdA1HTPh0+XN_+qvLpdLw@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 14 Sep 2020 17:03:25 -0700
Message-ID: <CAP-5=fXrhjv8obOPKpXThsrOKjb5kKFTpoTRO3tDk5MoJyhdjw@mail.gmail.com>
Subject: Re: [PATCH 02/26] perf: Introduce mmap3 version of mmap event
To:     Stephane Eranian <eranian@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 10:26 AM Stephane Eranian <eranian@google.com> wrote:
>
> On Mon, Sep 14, 2020 at 2:08 AM <peterz@infradead.org> wrote:
> >
> > On Sun, Sep 13, 2020 at 11:41:00PM -0700, Stephane Eranian wrote:
> > > On Sun, Sep 13, 2020 at 2:03 PM Jiri Olsa <jolsa@kernel.org> wrote:
> > > what happens if I set mmap3 and mmap2?
> > >
> > > I think using mmap3 for every mmap may be overkill as you add useless
> > > 20 bytes to an mmap record.
> > > I am not sure if your code handles the case where mmap3 is not needed
> > > because there is no buildid, e.g, anonymous memory.
> > > It seems to me you've written the patch in such a way that if the user
> > > tool supports mmap3, then it supersedes mmap2, and thus
> > > you need all the fields of mmap2. But if could be more interesting to
> > > return either MMAP2 or MMAP3 depending on tool support
> > > and type of mmap, that would certainly save 20 bytes on any anon mmap.
> > > But maybe that logic is already in your patch and I missed it.
> >
> > That, and what if you don't want any of that buildid nonsense at all? I
> > always kill that because it makes perf pointlessly slow and has
> > absolutely no upsides for me.
> >
> I have seen situations where the perf tool takes a visibly significant
> amount of time (many seconds) to inject the buildids at the end of the
> collection
> of perf record (same if using perf inject -b). That is because it
> needs to go through all the records in the perf.data to find MMAP
> records and then read
> the buildids from the filesystem. This has caused some problems in our
> environment. Having the kernel add the buildid to *relevant* mmaps
> would avoid
> a lot of that penalty, by avoiding having to parse the perf.data file
> and leveraging the fact that the buildid may be in memory already.
> Although my concern on
> this has to do with large pages and the impact they have on alignment
> of sections in memory.  I think Ian can comment better on this.

I believe this is a problem we have and that is going away. For
context, we map huge pages and move executable code to them, not from
a file, but using anonymous memory or other sources of huge pages. By
definition we will fail to find build ids for such anonymous memory,
but we may also break the non file backed hugepage case if the
alignment is such that the ELF header is on the hugepage and for some
reason not in the page cache. File backed huge pages solve this
problem.

Thanks,
Ian

> I think this patch series is useful if it can demonstrate a speedup
> during recording (perf record or perf record | perf inject -b). But it
> needs to be
> optimized to minimize the volume of useless info returned. And Jiri
> needs to decide if MMAP3 is a replacement of MMAP2, or a different
> kind of record
> targeted at ELF images only in which case some of the fields may be
> removed. My tendency would be to go for the latter.
