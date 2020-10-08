Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFD8286EEE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 09:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbgJHHCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 03:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbgJHHCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 03:02:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48006C061755;
        Thu,  8 Oct 2020 00:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=T7xaDhKhGvUG7dKA/3AqR+s1D2J/aJXSAO3UwYVQGuo=; b=qGhI+jPwX/1Phk/0NJuzpVAcAP
        ZYIZX9wgd9VrHuiMcK6ffr6VpXwfF1G8howCufvW94p4M+4F6voZa0tQWpq+KQbTVRTL6Z4F7lnRH
        z/rwsl6TuAhotq2vCy5czBL/pFsIQB6AP1r08CPBfgYjKVgTFNmwrxQd6LrPnyoVrRfObOqub9z6n
        CUJESnagmG2YXcfc5dm4fguJzimghZtm9a8/dQVxb/n/XHteo3U2vAK+2NBJd4bxD4Gkki5G1yYQ1
        juT8rgh553M9ArZ5gtPOUMys+eCqTHUDOKYk+655h3bXHvQBnYHIyarBOeK1qOgj4yW1kkXER4h9X
        yqVRc7LQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQPwh-0000yE-Ip; Thu, 08 Oct 2020 07:02:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5E27B300B22;
        Thu,  8 Oct 2020 09:02:31 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0A60C203A8F65; Thu,  8 Oct 2020 09:02:31 +0200 (CEST)
Date:   Thu, 8 Oct 2020 09:02:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     linux-toolchains@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        "Phillips, Kim" <kim.phillips@amd.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andi Kleen <andi@firstfloor.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: Additional debug info to aid cacheline analysis
Message-ID: <20201008070231.GS2628@hirez.programming.kicks-ass.net>
References: <20201006131703.GR2628@hirez.programming.kicks-ass.net>
 <CABPqkBSkdqXjm6QuF9j6AO8MUnt1yZ_cA2PV=Qo8e4wKmK_6Ug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBSkdqXjm6QuF9j6AO8MUnt1yZ_cA2PV=Qo8e4wKmK_6Ug@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


My appologies for adding a typo to the linux-kernel address, corrected
now.

On Wed, Oct 07, 2020 at 10:58:00PM -0700, Stephane Eranian wrote:
> Hi Peter,
> 
> On Tue, Oct 6, 2020 at 6:17 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Hi all,
> >
> > I've been trying to float this idea for a fair number of years, and I
> > think at least Stephane has been talking to tools people about it, but
> > I'm not sure what, if anything, ever happened with it, so let me post it
> > here :-)
> >
> >
> Thanks for bringing this back. This is a pet project of mine and I
> have been looking at it for the last 4 years intermittently now.
> Simply never got a chance to complete because preempted by other
> higher priority projects. I have developed an internal
> proof-of-concept  prototype using one of the 3 approaches I know.  My
> goal was to demonstrate that PMU statistical sampling of loads/stores
> and with data addresses would work as well as instrumentation. This is
> slightly different from hit/miss in the analysis but the process is
> the same.
> 
> As you point out, the difficulty is not so much in collecting the
> sample but rather in symbolizing data addresses from the heap.

Right, that's non-trivial, although for static and per-cpu objects it
should be rather straight forward,  heap objects are going to be a pain.
You'd basically have to also log the alloc/free of every object along
with the data type used for it, which is not something we have readily
abailable at the allocator.

> Intel PEBS, IBM Marked Events work well to collect the data. AMD IBS
> works though you get a lot of irrelevant samples due to lack of
> hardware filtering. ARM SPE would work too.  Overall, all the major
> architectures will provide the sampling support needed.

That's for the data address, or also the eventing IP?

> Some time ago, I had my intern pursue the other 2 approaches for
> symbolization. The one I see as most promising is by using the DWARF
> information (no BPF needed). The good news is that I believe we do not
> need more information than what is already there. We just need the
> compiler to generate valid DWARF at most optimization levels, which I
> believe is not the case for LLVM based compilers but maybe okay for
> GCC.

Right, I think GCC improved a lot on this front over the past few years.
Also added Andi and Masami, who have worked on this or related topics.

> Once we have the DWARF logic in place then it is easier to improve
> perf report/annotate do to hit/miss or hot/cold, read/write analysis
> on each data type and fields within.
> 
> Once we have the code for perf, we are planning to contribute it upstream.
> 
> In the meantime, we need to lean on the compiler teams to ensure no
> data type information is lost with high optimizations levels.  My
> understanding from talking with some compiler folks is that this is
> not a trivial fix.

As you might have noticed, I send this to the linux-toolchains list.
While you lean on your copmiler folks, try and get them subscribed to
this list. It is meant to discuss toolchain issues as related to Linux.
Both GCC/binutils and LLVM should be represented here.

