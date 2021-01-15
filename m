Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2BD82F7F46
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 16:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732627AbhAOPRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 10:17:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:42030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726849AbhAOPRJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 10:17:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E6B1223884;
        Fri, 15 Jan 2021 15:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610723789;
        bh=H/e/KKTE+srWdTPVgF44EaHDnUGnWYaqJasgmyGLOKI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vFc2LuA4V74rwad12/XoPP1tq7P/1wQGs1O4QCPJKxtI6Q3bCBD6Z5MGJxdWMWnr5
         1ZeieZmXhsj+w2vru2KCZQBnP7CYItoxJyqKAJnR7ryaRORyq8JnrtGKrwW7paztoJ
         GHEonSt6G0cOapxx7h0D4eKgbCq0uOdEU7WD2uY2Hm1M02/4kaOUsdqm3Jjsr9fmv6
         s0AYKRDKuw7+E/xQ540WOPfmDFubBnfJ6WEI4lhIKbR3+4z+oh7KVUVorTBAhITKyY
         8GJtjFvYW5H6K7ChJmh5rhdfMmY4ngi/0C1CkZprgwfu5BKGQBDbIu2YUQ2b4E68Jy
         x98H/yp796bJA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D43A040522; Fri, 15 Jan 2021 12:17:01 -0300 (-03)
Date:   Fri, 15 Jan 2021 12:17:01 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Leo Yan <leo.yan@linaro.org>,
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
Message-ID: <20210115151701.GA412118@kernel.org>
References: <20201213133850.10070-1-leo.yan@linaro.org>
 <20210103225219.GA850408@krava>
 <20210104020930.GA4897@leoy-ThinkPad-X240s>
 <20210104093540.GA872376@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210104093540.GA872376@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jan 04, 2021 at 10:35:40AM +0100, Jiri Olsa escreveu:
> On Mon, Jan 04, 2021 at 10:09:38AM +0800, Leo Yan wrote:
> 
> SNIP
> 
> > > > Leo Yan (11):
> > > >   perf c2c: Add dimensions for total load hit
> > > >   perf c2c: Add dimensions for load hit
> > > >   perf c2c: Add dimensions for load miss
> > > >   perf c2c: Rename for shared cache line stats
> > > >   perf c2c: Refactor hist entry validation
> > > >   perf c2c: Refactor display filter macro
> > > >   perf c2c: Refactor node display macro
> > > >   perf c2c: Refactor node header
> > > >   perf c2c: Add local variables for output metrics
> > > >   perf c2c: Sort on all cache hit for load operations
> > > >   perf c2c: Update documentation for display option 'all'
> > > > 
> > > >  tools/perf/Documentation/perf-c2c.txt |  21 +-
> > > >  tools/perf/builtin-c2c.c              | 548 ++++++++++++++++++++++----
> > > >  2 files changed, 487 insertions(+), 82 deletions(-)
> > > 
> > > Joe might want to test it first, but it looks all good to me:
> > > 
> > > Acked-by: Jiri Olsa <jolsa@redhat.com>
> > 
> > Thanks for the review, Jiri.
> > 
> > Note, after testing with Arm SPE, we found the store operations don't
> > contain the information for L1 cache hit or miss, this leads to there
> > have no statistics for "st_l1hit" and "st_l1miss"; finally the single
> > cache line view only can show the load samples and fails to show store
> > opreations due to the empty statistics for "st_l1hit" and "st_l1miss".
> > 
> > This is related the hardware issue, after some discussion internally,
> > so far cannot find a easy way to set memory flag for L1 cache hit or
> > miss for store operations (more specific, set flags PERF_MEM_LVL_HIT or
> > PERF_MEM_LVL_MISS for store's L1 cache accessing).
> > 
> > Given it is uncertain for this issue, please hold on for this patch
> > series and I will resend if have any conclusion.
> > 
> > And really sorry I notify this too late.
> 
> no problem, I think we can take some of the refactoring patches anyway

Agreed, in fact I already processed this series in my local branch and
I'm test building everything now.

- Arnaldo
