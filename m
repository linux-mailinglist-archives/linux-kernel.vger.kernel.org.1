Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFFDC2A2612
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 09:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbgKBI1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 03:27:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:55440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727818AbgKBI1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 03:27:18 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0B2820870;
        Mon,  2 Nov 2020 08:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604305637;
        bh=lqYbON1vxsRfY4R67Xq90gA7gsE9U+SW8Z7PruxEeEU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dp/+doFtJQZPniV6ihabEJMRr21tCNGRnPIG2fmFVsL16OPCCbV/T5P6EA0xs6EOy
         4rS0daV2sY/Pf8CYdcbKagmJg578r2SoE77fpQ9TFPJFruYxUa2jOfyLWqqzB8rA9u
         QGcYOPzTlbjv9UkmKl57ZB3sfFJywg65cn2e2ksE=
Date:   Mon, 2 Nov 2020 17:27:12 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mark Wielaard <mark@klomp.org>, Namhyung Kim <namhyung@kernel.org>,
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
Message-Id: <20201102172712.0c9859124835089d80dc2348@kernel.org>
In-Reply-To: <20201030101004.GB2628@hirez.programming.kicks-ass.net>
References: <20201006131703.GR2628@hirez.programming.kicks-ass.net>
        <CABPqkBSkdqXjm6QuF9j6AO8MUnt1yZ_cA2PV=Qo8e4wKmK_6Ug@mail.gmail.com>
        <20201008070231.GS2628@hirez.programming.kicks-ass.net>
        <50338de81b34031db8637337f08b89b588476211.camel@klomp.org>
        <CAM9d7chX+VxN+6T0y=CWfiMPWY6em3grGJL+oYnX99aOfFO2fg@mail.gmail.com>
        <20201030091649.GB3100@wildebeest.org>
        <20201030101004.GB2628@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 30 Oct 2020 11:10:04 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, Oct 30, 2020 at 10:16:49AM +0100, Mark Wielaard wrote:
> > Hi Namhyung,
> > 
> > On Fri, Oct 30, 2020 at 02:26:19PM +0900, Namhyung Kim wrote:
> > > On Thu, Oct 8, 2020 at 6:38 PM Mark Wielaard <mark@klomp.org> wrote:
> > > > GCC using -fvar-tracking and -fvar-tracking-assignments is pretty good
> > > > at keeping track of where variables are held (in memory or registers)
> > > > when in the program, even through various optimizations.
> > > >
> > > > -fvar-tracking-assignments is the default with -g -O2.
> > > > Except for the upstream linux kernel code. Most distros enable it
> > > > again, but you do want to enable it by hand when building from the
> > > > upstream linux git repo.
> > > 
> > > Please correct me if I'm wrong.  This seems to track local variables.
> > > But I'm not sure it's enough for this purpose as we want to know
> > > types of any memory references (not directly from a variable).
> > > 
> > > Let's say we have a variable like below:
> > > 
> > >   struct xxx a;
> > > 
> > >   a.b->c->d++;
> > > 
> > > And we have a sample where 'd' is updated, then how can we know
> > > it's from the variable 'a'?  Maybe we don't need to know it, but we
> > > should know it accesses the 'd' field in the struct 'c'.
> > > 
> > > Probably we can analyze the asm code and figure out it's from 'a'
> > > and accessing 'd' at the moment.  I'm curious if there's a way in
> > > the DWARF to help this kind of work.
> > 
> > DWARF does have that information, but it stores it in a way that is
> > kind of opposite to how you want to access it. Given a variable and an
> > address, you can easily get the location where that variable is
> > stored. But if you want to map back from a given (memory) location and
> > address to the variable, that is more work.
> 
> The principal idea in this thread doesn't care about the address of the
> variables. The idea was to get the data type and member information from
> the instruction.
> 
> So in the above example: a.b->c->d++; what we'll end up with is
> something like:
> 
> 	inc	8(%rax)
> 
> Where %rax contains c, and the offset of d in c is 8.

For this simple case, it is possible.

This offset information is stored in the DWARF as a data-structure type
information. (perf-probe uses it to find how to get the given local var's
fields)

So if we do this off-line, I think it is possible if it is recorded with
instruction-pointers. For each place, we can do

 - decode instruction and get the access address. 
 - get var assignment of %rax at that IP.
 - get type information of var and find the field from offset.

However, the problem is that if the DWARF has only assignment of "a",
we need to decode the function body. (and usually this happens)

func() {
 struct xxx a;
 ...
 a.b->c->d++;
}

In this case, only "a" is the local variable. So DWARF records assignment of
"a", not "b" nor "c" (since those are not a name of variables, just a name
of fields). GCC may generate something like

 mov	16(%rsp),%rdx	// rdx = a.b
 mov	8(%rdx),%rax		// rax = b->c
 inc	8(%rax)		// c->d++

GCC only knows "a" is 0(%rsp), there is no other "assignments". Thus we need
to backtrace the %rax from the hit ip address until known assignment register
appears.

Note that if there is a loop, we have to trace it back too, but it's more hard,

func() {
 struct yyy a;
 int i;
 ...
 for (i = 0; i < 100; i++)
   a.b->c[i]++;
}

In this case, GCC will optimize "i" out and make an end-address.
(This is what GCC -O2 generated)

0000000000001190 <func>:
{
    1190:       f3 0f 1e fa             endbr64 
        struct yyy a = *_a;
    1194:       48 8b 57 10             mov    0x10(%rdi),%rdx
        for (i = 0; i < 100; i++)
    1198:       48 8d 42 08             lea    0x8(%rdx),%rax
    119c:       48 81 c2 98 01 00 00    add    $0x198,%rdx
    11a3:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
                a.b->c[i]++;
    11a8:       83 00 01                addl   $0x1,(%rax)
        for (i = 0; i < 100; i++)
    11ab:       48 83 c0 04             add    $0x4,%rax
    11af:       48 39 d0                cmp    %rdx,%rax
    11b2:       75 f4                   jne    11a8 <func+0x18>
}
    11b4:       c3                      retq   

If we ignore the array support, this can be simplified as

    1194:       48 8b 57 10             mov    0x10(%rdi),%rdx
    1198:       48 8d 42 08             lea    0x8(%rdx),%rax
    11a8:       83 00 01                addl   $0x1,(%rax)

and maybe able to decode it.

Thank you,

> So what we want to (easily) find for that instruction is c::d.
> 
> So given any instruction with a memop (either load or store) we want to
> find: type::member.
> 
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
