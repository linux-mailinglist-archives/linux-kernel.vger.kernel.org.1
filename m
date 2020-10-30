Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 423152A0107
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 10:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbgJ3JRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 05:17:43 -0400
Received: from wildebeest.demon.nl ([212.238.236.112]:55904 "EHLO
        gnu.wildebeest.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgJ3JRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 05:17:43 -0400
Received: from librem (deer0x15.wildebeest.org [172.31.17.151])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by gnu.wildebeest.org (Postfix) with ESMTPSA id C4BF330278CD;
        Fri, 30 Oct 2020 10:17:40 +0100 (CET)
Received: by librem (Postfix, from userid 1000)
        id B0FE9C379B; Fri, 30 Oct 2020 10:16:49 +0100 (CET)
Date:   Fri, 30 Oct 2020 10:16:49 +0100
From:   Mark Wielaard <mark@klomp.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20201030091649.GB3100@wildebeest.org>
References: <20201006131703.GR2628@hirez.programming.kicks-ass.net>
 <CABPqkBSkdqXjm6QuF9j6AO8MUnt1yZ_cA2PV=Qo8e4wKmK_6Ug@mail.gmail.com>
 <20201008070231.GS2628@hirez.programming.kicks-ass.net>
 <50338de81b34031db8637337f08b89b588476211.camel@klomp.org>
 <CAM9d7chX+VxN+6T0y=CWfiMPWY6em3grGJL+oYnX99aOfFO2fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7chX+VxN+6T0y=CWfiMPWY6em3grGJL+oYnX99aOfFO2fg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Flag: NO
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.0
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on gnu.wildebeest.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Namhyung,

On Fri, Oct 30, 2020 at 02:26:19PM +0900, Namhyung Kim wrote:
> On Thu, Oct 8, 2020 at 6:38 PM Mark Wielaard <mark@klomp.org> wrote:
> > GCC using -fvar-tracking and -fvar-tracking-assignments is pretty good
> > at keeping track of where variables are held (in memory or registers)
> > when in the program, even through various optimizations.
> >
> > -fvar-tracking-assignments is the default with -g -O2.
> > Except for the upstream linux kernel code. Most distros enable it
> > again, but you do want to enable it by hand when building from the
> > upstream linux git repo.
> 
> Please correct me if I'm wrong.  This seems to track local variables.
> But I'm not sure it's enough for this purpose as we want to know
> types of any memory references (not directly from a variable).
> 
> Let's say we have a variable like below:
> 
>   struct xxx a;
> 
>   a.b->c->d++;
> 
> And we have a sample where 'd' is updated, then how can we know
> it's from the variable 'a'?  Maybe we don't need to know it, but we
> should know it accesses the 'd' field in the struct 'c'.
> 
> Probably we can analyze the asm code and figure out it's from 'a'
> and accessing 'd' at the moment.  I'm curious if there's a way in
> the DWARF to help this kind of work.

DWARF does have that information, but it stores it in a way that is
kind of opposite to how you want to access it. Given a variable and an
address, you can easily get the location where that variable is
stored. But if you want to map back from a given (memory) location and
address to the variable, that is more work.

In theory what you could do is make a list of global variables from
the top-level DWARF CUs. Then take the debug aranges to map from the
program address to the DWARF CU that covers that address. Then for
that CU you would walk the CU DIE tree while keeping track of all
variables in scope till you find the function covering that
address. Then for each global variable and all variables in scope you
get the DWARF location description at the given address (for global
ones that is most likely always a static address, but for local ones
it depends on where exactly in the program you take the sample). That
plus the type information for each variable should then make it
possible to see which variable covers the given memory location.

But that is a lot of work to do for each sample.

Cheers,

Mark
