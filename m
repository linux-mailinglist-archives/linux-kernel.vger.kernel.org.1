Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEEB2269327
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 19:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbgINR0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 13:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgINR0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 13:26:20 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986A1C06178A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 10:26:19 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id p81so435992ybc.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 10:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UIU9oMc65saObwq2q+UiBoPQdcBlmWwHVP6YFgX+xa0=;
        b=Lp04X6lkrD52gRgTzMZDAd0OTiIut43jJeGBcn+wIToqHj1pYxKupbVF88+BE8JHb8
         5B+AY0PJYA4P/t4kz/ykrHqpbC9X0++44H4uqzGYUa2FCJaADSrF2wdDaXaxjhZnhQ9u
         IoDB5of9YnBETmYAbHZ1NrsJ9D//I6BUMBtFptUprnT7VyU6wZixg/TapPMC4kj4iILQ
         t4Y+ybe6asDu+Cyy/75nz6R3PG8wIBrxQ6tVayN2feOT12fRtYmZLFl7wudUegJD7m85
         YZHYDNjJc15yf71/qFn9ORHukOYg983cKJk8er3Nz1+INTJ3kfLJymcRIOa4r06OMMwt
         zpkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UIU9oMc65saObwq2q+UiBoPQdcBlmWwHVP6YFgX+xa0=;
        b=g54auYN/gmDPwPRUp2NXxq942WbtDsQMPwdakwBi0GDMytLU65npGNkvA/XYaArJFE
         oVLGtsYvJQAM2lH9SfyUMXVqTjVOfDMq/vBPpDh4dluT+V5G4AxeHgTdkqNCKtbMVkbj
         tHtlK44N49sl6x7n90TO2MzHzzsGaMvndChBln4fXe2fmePsHGgb1DocRdKPBs+N2ufK
         7wFu8k6FCEqC+gLROzBdgE/CptOXKB0sHJgJzlu2xCLJscowGz1KdJOs+73K9eVFEMty
         sYB6Ll6sWI6xF4EJbf9YY2g/uwMPoCQ/tAaa5BuodY83G2OdUlsQr2VV9W587xoeISOJ
         5PKA==
X-Gm-Message-State: AOAM533KGduQyTpQIDSX7zfZQlepU6rk1Dwax1waHN3fHN2a8yywFQvV
        Maem14sQDv4lC4yqzBEBg8ZQMiEo1tVMMpHeDaFfsw==
X-Google-Smtp-Source: ABdhPJwFSRVFc01jHfrImNWDj1oWxKHLzhfeRM0ByYqL42AL5GBZlcSu924Ec3IVpxi2K34WmIAXgaiROPSR6/X4d7k=
X-Received: by 2002:a25:ab8e:: with SMTP id v14mr3446450ybi.465.1600104377350;
 Mon, 14 Sep 2020 10:26:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200913210313.1985612-1-jolsa@kernel.org> <20200913210313.1985612-3-jolsa@kernel.org>
 <CABPqkBTk+SwTAxXDa6HL8TqvEmUunfMZxpAtx6CebNbd+3hEHw@mail.gmail.com> <20200914090811.GM1362448@hirez.programming.kicks-ass.net>
In-Reply-To: <20200914090811.GM1362448@hirez.programming.kicks-ass.net>
From:   Stephane Eranian <eranian@google.com>
Date:   Mon, 14 Sep 2020 10:26:05 -0700
Message-ID: <CABPqkBSKpZFbYWrQueS9cFDkGJPb3NdA1HTPh0+XN_+qvLpdLw@mail.gmail.com>
Subject: Re: [PATCH 02/26] perf: Introduce mmap3 version of mmap event
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 2:08 AM <peterz@infradead.org> wrote:
>
> On Sun, Sep 13, 2020 at 11:41:00PM -0700, Stephane Eranian wrote:
> > On Sun, Sep 13, 2020 at 2:03 PM Jiri Olsa <jolsa@kernel.org> wrote:
> > what happens if I set mmap3 and mmap2?
> >
> > I think using mmap3 for every mmap may be overkill as you add useless
> > 20 bytes to an mmap record.
> > I am not sure if your code handles the case where mmap3 is not needed
> > because there is no buildid, e.g, anonymous memory.
> > It seems to me you've written the patch in such a way that if the user
> > tool supports mmap3, then it supersedes mmap2, and thus
> > you need all the fields of mmap2. But if could be more interesting to
> > return either MMAP2 or MMAP3 depending on tool support
> > and type of mmap, that would certainly save 20 bytes on any anon mmap.
> > But maybe that logic is already in your patch and I missed it.
>
> That, and what if you don't want any of that buildid nonsense at all? I
> always kill that because it makes perf pointlessly slow and has
> absolutely no upsides for me.
>
I have seen situations where the perf tool takes a visibly significant
amount of time (many seconds) to inject the buildids at the end of the
collection
of perf record (same if using perf inject -b). That is because it
needs to go through all the records in the perf.data to find MMAP
records and then read
the buildids from the filesystem. This has caused some problems in our
environment. Having the kernel add the buildid to *relevant* mmaps
would avoid
a lot of that penalty, by avoiding having to parse the perf.data file
and leveraging the fact that the buildid may be in memory already.
Although my concern on
this has to do with large pages and the impact they have on alignment
of sections in memory.  I think Ian can comment better on this.

I think this patch series is useful if it can demonstrate a speedup
during recording (perf record or perf record | perf inject -b). But it
needs to be
optimized to minimize the volume of useless info returned. And Jiri
needs to decide if MMAP3 is a replacement of MMAP2, or a different
kind of record
targeted at ELF images only in which case some of the fields may be
removed. My tendency would be to go for the latter.
