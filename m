Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB802E92B2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 10:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbhADJhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 04:37:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41989 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726196AbhADJhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 04:37:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609752950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EXtyco+eWjU47nR0Op2rkNaXPKFVZZ+Ls3Jqh0AGFz4=;
        b=WoYtXkTmX6ody1MEqidM7UL7hPp3+uCDYRw+kOiOkPUraG9HGsrJRsnrPtD+el5ufUsg99
        v98zBUdBSACJCA+No0xmvLXTJ2pT1o2tGk5JjjSD5w8Uhjf2nzMdpAIap+EZ4aWHLiHn9+
        G6G7J5MEutzCpLrOCSy2lAyg6fZRdC8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-2XAFPNLaOiiR6NeE-c08Uw-1; Mon, 04 Jan 2021 04:35:47 -0500
X-MC-Unique: 2XAFPNLaOiiR6NeE-c08Uw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E47B804006;
        Mon,  4 Jan 2021 09:35:45 +0000 (UTC)
Received: from krava (unknown [10.40.192.45])
        by smtp.corp.redhat.com (Postfix) with SMTP id 91D53E145;
        Mon,  4 Jan 2021 09:35:41 +0000 (UTC)
Date:   Mon, 4 Jan 2021 10:35:40 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Joe Mario <jmario@redhat.com>, David Ahern <dsahern@gmail.com>,
        Don Zickus <dzickus@redhat.com>, Al Grant <Al.Grant@arm.com>,
        James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/11] perf c2c: Sort cacheline with all loads
Message-ID: <20210104093540.GA872376@krava>
References: <20201213133850.10070-1-leo.yan@linaro.org>
 <20210103225219.GA850408@krava>
 <20210104020930.GA4897@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210104020930.GA4897@leoy-ThinkPad-X240s>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 04, 2021 at 10:09:38AM +0800, Leo Yan wrote:

SNIP

> > > Leo Yan (11):
> > >   perf c2c: Add dimensions for total load hit
> > >   perf c2c: Add dimensions for load hit
> > >   perf c2c: Add dimensions for load miss
> > >   perf c2c: Rename for shared cache line stats
> > >   perf c2c: Refactor hist entry validation
> > >   perf c2c: Refactor display filter macro
> > >   perf c2c: Refactor node display macro
> > >   perf c2c: Refactor node header
> > >   perf c2c: Add local variables for output metrics
> > >   perf c2c: Sort on all cache hit for load operations
> > >   perf c2c: Update documentation for display option 'all'
> > > 
> > >  tools/perf/Documentation/perf-c2c.txt |  21 +-
> > >  tools/perf/builtin-c2c.c              | 548 ++++++++++++++++++++++----
> > >  2 files changed, 487 insertions(+), 82 deletions(-)
> > 
> > Joe might want to test it first, but it looks all good to me:
> > 
> > Acked-by: Jiri Olsa <jolsa@redhat.com>
> 
> Thanks for the review, Jiri.
> 
> Note, after testing with Arm SPE, we found the store operations don't
> contain the information for L1 cache hit or miss, this leads to there
> have no statistics for "st_l1hit" and "st_l1miss"; finally the single
> cache line view only can show the load samples and fails to show store
> opreations due to the empty statistics for "st_l1hit" and "st_l1miss".
> 
> This is related the hardware issue, after some discussion internally,
> so far cannot find a easy way to set memory flag for L1 cache hit or
> miss for store operations (more specific, set flags PERF_MEM_LVL_HIT or
> PERF_MEM_LVL_MISS for store's L1 cache accessing).
> 
> Given it is uncertain for this issue, please hold on for this patch
> series and I will resend if have any conclusion.
> 
> And really sorry I notify this too late.

no problem, I think we can take some of the refactoring patches anyway

thanks,
jirka

