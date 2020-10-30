Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B33E2A0274
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 11:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgJ3KKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 06:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgJ3KKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 06:10:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBA7C0613CF;
        Fri, 30 Oct 2020 03:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=u7YtPu1a20CnPHKzQzS9jt9YAYOEyPc1Wfcc8V34Xok=; b=fVtxGVHLRaB/i9LkESEDWY4fpY
        i1nZDijtIzs41S7n2+bLrB1hRAtmpSLn55vJmu3SVqpsd/cccJGwSqAMDzFIn6Cd65G4QVAiZMkhw
        oOC+dvwW+up7FAVrEgw+uu7d93QJDK6PzTBYn3DekeUNXXD2rooW09tj9dSBlsski5m2hjjh21wjd
        V0MfX3DJcVT+NHG4uwVzlLiaLsBsTP/zsTzvYyhS4/wWNEf3+gij5dQ2JKukorVbT5GdYMr8+Z2pG
        Fk09Ew+jE6c1rsXU2eVd9BsphbsVJseRUBAZyWw32IIUkNr+2uDujapgkD3FBUNVPDO+swYk3pToJ
        KvHniNtQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYRMF-0008Dy-CF; Fri, 30 Oct 2020 10:10:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E2E79307197;
        Fri, 30 Oct 2020 11:10:04 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D01612BEF0521; Fri, 30 Oct 2020 11:10:04 +0100 (CET)
Date:   Fri, 30 Oct 2020 11:10:04 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mark Wielaard <mark@klomp.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        linux-toolchains@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Ian Rogers <irogers@google.com>,
        "Phillips, Kim" <kim.phillips@amd.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andi Kleen <andi@firstfloor.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: Additional debug info to aid cacheline analysis
Message-ID: <20201030101004.GB2628@hirez.programming.kicks-ass.net>
References: <20201006131703.GR2628@hirez.programming.kicks-ass.net>
 <CABPqkBSkdqXjm6QuF9j6AO8MUnt1yZ_cA2PV=Qo8e4wKmK_6Ug@mail.gmail.com>
 <20201008070231.GS2628@hirez.programming.kicks-ass.net>
 <50338de81b34031db8637337f08b89b588476211.camel@klomp.org>
 <CAM9d7chX+VxN+6T0y=CWfiMPWY6em3grGJL+oYnX99aOfFO2fg@mail.gmail.com>
 <20201030091649.GB3100@wildebeest.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201030091649.GB3100@wildebeest.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 10:16:49AM +0100, Mark Wielaard wrote:
> Hi Namhyung,
> 
> On Fri, Oct 30, 2020 at 02:26:19PM +0900, Namhyung Kim wrote:
> > On Thu, Oct 8, 2020 at 6:38 PM Mark Wielaard <mark@klomp.org> wrote:
> > > GCC using -fvar-tracking and -fvar-tracking-assignments is pretty good
> > > at keeping track of where variables are held (in memory or registers)
> > > when in the program, even through various optimizations.
> > >
> > > -fvar-tracking-assignments is the default with -g -O2.
> > > Except for the upstream linux kernel code. Most distros enable it
> > > again, but you do want to enable it by hand when building from the
> > > upstream linux git repo.
> > 
> > Please correct me if I'm wrong.  This seems to track local variables.
> > But I'm not sure it's enough for this purpose as we want to know
> > types of any memory references (not directly from a variable).
> > 
> > Let's say we have a variable like below:
> > 
> >   struct xxx a;
> > 
> >   a.b->c->d++;
> > 
> > And we have a sample where 'd' is updated, then how can we know
> > it's from the variable 'a'?  Maybe we don't need to know it, but we
> > should know it accesses the 'd' field in the struct 'c'.
> > 
> > Probably we can analyze the asm code and figure out it's from 'a'
> > and accessing 'd' at the moment.  I'm curious if there's a way in
> > the DWARF to help this kind of work.
> 
> DWARF does have that information, but it stores it in a way that is
> kind of opposite to how you want to access it. Given a variable and an
> address, you can easily get the location where that variable is
> stored. But if you want to map back from a given (memory) location and
> address to the variable, that is more work.

The principal idea in this thread doesn't care about the address of the
variables. The idea was to get the data type and member information from
the instruction.

So in the above example: a.b->c->d++; what we'll end up with is
something like:

	inc	8(%rax)

Where %rax contains c, and the offset of d in c is 8.

So what we want to (easily) find for that instruction is c::d.

So given any instruction with a memop (either load or store) we want to
find: type::member.


