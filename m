Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A39729FD30
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 06:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725823AbgJ3F0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 01:26:33 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:40496 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgJ3F0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 01:26:33 -0400
Received: by mail-wm1-f52.google.com with SMTP id k18so1797474wmj.5;
        Thu, 29 Oct 2020 22:26:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q8cfJHzGpbY9F0GkWPXtJI8dzSVuahW/++/+8hRP0Qc=;
        b=SToyTWgASSiOKFaMN97lbrUe1sWD6XyyY6E4qrrwieJT4a7f2C161UWBM/rvDuP8O6
         LaO1/nLi3FuK3Y6b4sNhGNGoj8gWxZWX/vSaWlUm8Z4ir564x41WYyT0ahZylHrxWLsP
         l5YETWJw9flO8Aefi+MJRw/QcovNHrEtukTYVXpBMoKYpYEklDub9wlPlNZI9lfxA6K+
         KKUoAjv+HkqjUPMFWQ27S+f2o0C9zYCZE4Wr31PGRfd7OMxpfCWP640y8ubrXDD4TjKq
         dJJfgmk9JD+IQdIJ5tDjIrD5Wx33TYL7AzwTIQBWsZpgD8PWnU8Y93Mf6fgj3s2S2ird
         kp2g==
X-Gm-Message-State: AOAM530dO5G3WyLmL3C86DFkvGk+l36I37Z7wIK7U/9kV83F+vVErq9S
        DxTdCUXceh3zejbMISTMNEsV/6tPlqOUfELIM18=
X-Google-Smtp-Source: ABdhPJx7FlJm2gnoR7L0qBWM3hH9SCa9vwOEnWLbgx/nE85ccJ830/Sn7Q7uvvuQc7e3psu+x+fJ7B4oTx/P7tmAaJs=
X-Received: by 2002:a7b:cb46:: with SMTP id v6mr564893wmj.146.1604035591169;
 Thu, 29 Oct 2020 22:26:31 -0700 (PDT)
MIME-Version: 1.0
References: <20201006131703.GR2628@hirez.programming.kicks-ass.net>
 <CABPqkBSkdqXjm6QuF9j6AO8MUnt1yZ_cA2PV=Qo8e4wKmK_6Ug@mail.gmail.com>
 <20201008070231.GS2628@hirez.programming.kicks-ass.net> <50338de81b34031db8637337f08b89b588476211.camel@klomp.org>
In-Reply-To: <50338de81b34031db8637337f08b89b588476211.camel@klomp.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 30 Oct 2020 14:26:19 +0900
Message-ID: <CAM9d7chX+VxN+6T0y=CWfiMPWY6em3grGJL+oYnX99aOfFO2fg@mail.gmail.com>
Subject: Re: Additional debug info to aid cacheline analysis
To:     Mark Wielaard <mark@klomp.org>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Oct 8, 2020 at 6:38 PM Mark Wielaard <mark@klomp.org> wrote:
>
> Hi,
>
> On Thu, 2020-10-08 at 09:02 +0200, Peter Zijlstra wrote:
> > Some time ago, I had my intern pursue the other 2 approaches for
> > > symbolization. The one I see as most promising is by using the DWARF
> > > information (no BPF needed). The good news is that I believe we do not
> > > need more information than what is already there. We just need the
> > > compiler to generate valid DWARF at most optimization levels, which I
> > > believe is not the case for LLVM based compilers but maybe okay for
> > > GCC.
> >
> > Right, I think GCC improved a lot on this front over the past few years.
> > Also added Andi and Masami, who have worked on this or related topics.
>
> For GCC Alexandre Oliva did a really thorough write up of all the
> various optimization and their effect on debugging/DWARF:
> https://www.fsfla.org/~lxoliva/writeups/gOlogy/gOlogy.html

Thanks for the link.  Looks very nice.

>
> GCC using -fvar-tracking and -fvar-tracking-assignments is pretty good
> at keeping track of where variables are held (in memory or registers)
> when in the program, even through various optimizations.
>
> -fvar-tracking-assignments is the default with -g -O2.
> Except for the upstream linux kernel code. Most distros enable it
> again, but you do want to enable it by hand when building from the
> upstream linux git repo.

Please correct me if I'm wrong.  This seems to track local variables.
But I'm not sure it's enough for this purpose as we want to know
types of any memory references (not directly from a variable).

Let's say we have a variable like below:

  struct xxx a;

  a.b->c->d++;

And we have a sample where 'd' is updated, then how can we know
it's from the variable 'a'?  Maybe we don't need to know it, but we
should know it accesses the 'd' field in the struct 'c'.

Probably we can analyze the asm code and figure out it's from 'a'
and accessing 'd' at the moment.  I'm curious if there's a way in
the DWARF to help this kind of work.

Thanks
Namhyung
