Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 430972695EB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 21:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbgINT4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 15:56:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55639 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725961AbgINT4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 15:56:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600113380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oj64U75YwzOzBWW1vmtAEB8kLkj0GhlaalWDVZN2Rao=;
        b=PBA0EzpQjLaljzq9p2waNjpJV24Be0n+an+nYt9NabF332a45Pd6Fp8kNDinKP4b85YQ18
        nIGuV0fkDHSc5VQVzXVXoa0DkM3scqiIPFKbaakhJ1y1zLpIZwbGVvPf/HW1r+929wxQ3j
        CvgWi8EwwmTAmrHv2vIVh1aw53ZZp6Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-NiFzDCDJNxWiA0qeqPDEMQ-1; Mon, 14 Sep 2020 15:56:16 -0400
X-MC-Unique: NiFzDCDJNxWiA0qeqPDEMQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE6341084C8B;
        Mon, 14 Sep 2020 19:56:14 +0000 (UTC)
Received: from krava (unknown [10.40.192.180])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3108A5DAA6;
        Mon, 14 Sep 2020 19:56:05 +0000 (UTC)
Date:   Mon, 14 Sep 2020 21:56:04 +0200
From:   Jiri Olsa <jolsa@redhat.com>
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
        Ian Rogers <irogers@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 02/26] perf: Introduce mmap3 version of mmap event
Message-ID: <20200914195604.GR1714160@krava>
References: <20200913210313.1985612-1-jolsa@kernel.org>
 <20200913210313.1985612-3-jolsa@kernel.org>
 <CABPqkBTk+SwTAxXDa6HL8TqvEmUunfMZxpAtx6CebNbd+3hEHw@mail.gmail.com>
 <20200914090811.GM1362448@hirez.programming.kicks-ass.net>
 <CABPqkBSKpZFbYWrQueS9cFDkGJPb3NdA1HTPh0+XN_+qvLpdLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBSKpZFbYWrQueS9cFDkGJPb3NdA1HTPh0+XN_+qvLpdLw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 10:26:05AM -0700, Stephane Eranian wrote:
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
> 
> I think this patch series is useful if it can demonstrate a speedup
> during recording (perf record or perf record | perf inject -b). But it

I haven't meassured, but I assume skipping of perf.data search
at the end of the record will make up for reading buildid for
each mmap event.. migt be tricky in mmap events heavy workloads

> needs to be
> optimized to minimize the volume of useless info returned. And Jiri
> needs to decide if MMAP3 is a replacement of MMAP2, or a different
> kind of record
> targeted at ELF images only in which case some of the fields may be
> removed. My tendency would be to go for the latter.

yes, I like the latter as well, let's see

thanks,
jirka

