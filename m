Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA5A1CF171
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 11:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729314AbgELJVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 05:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729193AbgELJVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 05:21:08 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29E7C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 02:21:08 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id i15so14393457wrx.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 02:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WSJ+GxsTuzqD8+IxmpWAkgNXtGw85Gobj3y/xeLlGVs=;
        b=c/o7xP451p05+fbz2TZLhRj4Tx9fMnzXC7w9k+1fmEi2v4E6edj5mks2yFuwCAvnPp
         TyWPeDv3I+NJk6fDLPEzr5a0Usrj1uDa9QV8rwbM0oMgtWc47RbytX55Vzw5l3YqwsLM
         a4eICQXcaTVh8j9/OsIM2SPdyoZY/NloXhg0BvPe9X+La/wKffYh1XYR5/6f82jU90R2
         /TD4bIb/voRBppIOHLNonM7o2IMRruu5UxC1AfSA+dKrszymKCPgTbzxB/TkRyJpaGLF
         ywZ7hwkK1iBicuimPtD4sQsOFhKY2kI1FMvpET9K4CMjloQ7YWjCE86Sd62GJF3UMgo/
         Zpfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WSJ+GxsTuzqD8+IxmpWAkgNXtGw85Gobj3y/xeLlGVs=;
        b=gyMGYxPIDi1hNE0lT/+qHfcew2nLeW6kbDWya15xBki/paScKl1rY9wIxrO8QCqEcq
         NP0gQ37bgKJP+OboIG4v5WYuSjLHOCVHatVV2O9gf8dPfyLfzLoQ0bUELSjRHzOzMGO6
         9trmZELFA8OVi4Z7hlq576G0VRF3qGWjKEW4vV8ql74D52XDK6DCzlwUDX/7Nl2oMzgf
         Xo7Ud/aKTC4R8g5GMrTchuqyrFiDij2rZaWoCIZTJLni6Aj+ReRYpGRuWJEYju6Oarkl
         C6C95tpctceJqqR1pWpupsXTHQfO1kLAUFdhaOVGD4MeqhzJYbGXNdHh3gyWEdYh0VUS
         iGeQ==
X-Gm-Message-State: AGi0Pua1DtQLDThm5m+efi75qk7iuerx/U8dALUzeNjE7wYcc+ylGv1a
        sZZ/G8zt0CUx9L7WsAgUMK4ldw==
X-Google-Smtp-Source: APiQypJzs8nFdQli4YVacxVDlFi3KZMkRuI5sjbQ+3MXmbG/9a6/E+gFH+A9GVHHr5dUP9sAv5OAfQ==
X-Received: by 2002:a5d:444c:: with SMTP id x12mr20172504wrr.406.1589275266995;
        Tue, 12 May 2020 02:21:06 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id 128sm24726511wme.39.2020.05.12.02.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 02:21:06 -0700 (PDT)
Date:   Tue, 12 May 2020 10:21:02 +0100
From:   Quentin Perret <qperret@google.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Todd Kjos <tkjos@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>
Subject: Re: [PATCH 00/14] Modularize schedutil
Message-ID: <20200512092102.GA16151@google.com>
References: <20200507181012.29791-1-qperret@google.com>
 <20200508081128.GM5298@hirez.programming.kicks-ass.net>
 <20200508103721.GA3860390@kroah.com>
 <20200508111612.GA252673@google.com>
 <20200508113141.GB5298@hirez.programming.kicks-ass.net>
 <20200508130507.GA10541@google.com>
 <CAJZ5v0iaa_VCtN608QKTYZ-A6QG_7bwxihxSgoEGv1LcSK-ksA@mail.gmail.com>
 <20200511090049.GA229633@google.com>
 <CAJZ5v0jKMgFsR0dXDt4si5hT9QF2evaoMS-13y-Qde8UpcaARg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jKMgFsR0dXDt4si5hT9QF2evaoMS-13y-Qde8UpcaARg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On Monday 11 May 2020 at 17:26:26 (+0200), Rafael J. Wysocki wrote:
> On Mon, May 11, 2020 at 11:00 AM Quentin Perret <qperret@google.com> wrote:
> > The base idea is, anything that we know from experience is used by
> > everybody can be built in, anything else will need investigation. And as
> > you've understood, schedutil falls in that second category.
> 
> The fact that the vendor sets up a different governor by default
> doesn't mean that there should be no way to switch over to schedutil
> IMO.

Well, there will always be the option to load the schedutil module ;-)

<snip>
> > the reason that dependency was added originally was
> >    because sugov was the only place where util clamps where taken into
> >    accounts. But that is no longer true -- we check them in the capacity
> >    aware wake-up path as well, which is entirely independent from the
> >    currently running governor;
> 
> But this is done under the assumption that the governor will also take
> the clamps into account, isn't it?

Even if that was correct, it's not clear a compile-time dependency makes
that assumption true, right?

For governors and the like, if the option is =n, then you can hard-rely
on it not being used. But if it is =y, you cannot assume anything
what-so-ever. EAS does a run-time check for that exact reason -- a
sole Kconfig dependency typically doesn't work for that.

> Otherwise you can see your "low util" tasks running at high
> frequencies and "high util" ones running slowly.  Surely, that's not
> desirable?
> 
> IIUC, the task placement needs to be consistent with the governor's
> decisions for things to work as expected.

Sure, but, say, the 'performance' governor could give you some of that
too. That is, you could use uclamp.min on some tasks to ensure they are
biased to bigger CPUs, and just stick the frequency to max. I wouldn't
be surprised to see setups like that on non-battery-powered devices for
instance. And yes, there are non-battery-powered devices that use big
little out there (TVs and such, often because the only SOCs matching
their requirements are mobile SOCs).

> >  - because of the above, it is (now) largely useless: a compile time
> >    dependency doesn't guarantee we are actually running with schedutil
> >    at all;
> >  - it is artificial: there are no actual compilation dependencies
> >    between sugov and uclamp, everything will compile just fine without
> >    that 'depends on';
> 
> That actually is the case, but it doesn't mean that there is no
> dependency in there.

Sure, and the dependency did make sense when uclamp was first introduced.
At the time, the clamp values where used _only_ in schedutil. So, it
was fair to say "if schedutil is =n, there is no way the clamps will ever
be useful to anything else, so the uclamp code can be safely compiled
out". That is no longer true, and if you want to make uclamp work only
with schedutil (which I would advise against for the above reason), then
a Kconfig dependency doesn't seem to be the right tool for that anyway.

> > Or maybe you were thinking of something else?
> >
> > > > That of course is only true if we can
> > > > agree on a reasonable set of exported symbols, so I'll give others some
> > > > time to complain and see if I can post a v2 addressing these issues!
> > >
> > > This isn't just about exported symbols, it is about what is regarded
> > > as essential and what isn't.
> >
> > Right, the exported symbols are, IMO, quite interesting because they
> > show how 'core' the governor is. But what exactly do you mean by
> > 'essential' here? Essential in what sense?
> 
> IMO the question is how much value there is in making it possible to
> avoid loading a particular piece of kernel code into memory.
> 
> You've demonstrated that it can be done with schedutil, but does that
> matter that it needs to be done?
> 
> I thought that the original idea was to make it closely integrated
> with the scheduler, so it could access the scheduler's data structures
> (that we specifically didn't want to expose to the *other* governors)
> and so as to avoid forgetting about any dependencies when making
> changes to either the scheduler or schedutil.  Allowing it to be build
> as a module would make make us have to worry about those things again,
> so is it really worth it?

Right, so, if there is a strong technical reason to keep schedutil a
bool option (such as accessing data structures we really don't want to
export), then sure, I'll have no choice but to accept it. Now, assuming
that I fix the usage of 'runqueues', is there anything in particular
that you think is wrong in the series?

Note that if one day keeping schedutil modular becomes a blocker for a
new feature, then we'll have the option to make it bool again. But is
there something like that already?

Thanks,
Quentin
