Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15AB22AFB2B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 23:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgKKWNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 17:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbgKKWNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 17:13:52 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45AC3C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 14:13:52 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id t8so3912881iov.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 14:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RtDOB/p+s0A9X3On9XtG12Mhh6t6BoNFjGVm9BD2G84=;
        b=DGwiFEp+pIXNn2Psux0cyQergQCa3Ej+0EIeCsfCaUUcKKh0pLO3n3bwEZQRQVa6N/
         SQYalo95fKEdUAIr6cCQmUzzydbYaNIgaHC+3sxqAE3sbfXTVrEw2z4ZyTYDKDpzFrit
         IO90mexI8UwPoTszY8AxLnktMQAIEiefIMeaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RtDOB/p+s0A9X3On9XtG12Mhh6t6BoNFjGVm9BD2G84=;
        b=tuh8XE9IPWHkOBjSuevWi2wH3ThC+rHGLgAMp5H/iUqjMaW8XuJjxznIWJIxJ5drEo
         oVxG691RChrRSXsmNv7jPQKjYuurJ0nj2s17QWM3wkzGsYoRIJIiXNqJQmE1214I56Sf
         3ISoXm1RAcMRgepJGM206YFheKo+6Kijk75861JTyU4OuXbHcFc7I4Sx6bbkC6LcgJyV
         HpwZJr1FiA3Uefb48QYeGtTPWmdoxSkEQutM74XlrXCbRpl4OVAnoYCZ2jFoxX6V6yDm
         GRuZa9KZa32ZtmcOJA3h5WjzTtKstmdqh6DrSkKJvlyhnNNagqfBzUq6Yy89U1aSbmkg
         bffg==
X-Gm-Message-State: AOAM533mZOZhqLtewuIff+pQB+xLUaINPLVzrS4Os7X9NBXVcn/by0+i
        GlSNuCyHsCUPrdRs0brJWllZp/FUQ5p0tNLGfxuelA==
X-Google-Smtp-Source: ABdhPJxUqyp5qOncQ2WMxACFxNuF0TUc7yNwEc8RcEuIeuwERSKqWK9yE17YR0p5wPsX22UA8v9b+/J2WAMJcLKQRKw=
X-Received: by 2002:a5e:8f06:: with SMTP id c6mr19923813iok.89.1605132831559;
 Wed, 11 Nov 2020 14:13:51 -0800 (PST)
MIME-Version: 1.0
References: <20201111211011.1381848-1-joel@joelfernandes.org>
 <20201111211011.1381848-2-joel@joelfernandes.org> <CAEXW_YTKTdBC_uD8E90FUNwoUWeyVG5XpFWvu-LO7X_fncnZnw@mail.gmail.com>
 <b1a1e07d-0df2-72c2-c3da-78e42fa355e8@amazon.com>
In-Reply-To: <b1a1e07d-0df2-72c2-c3da-78e42fa355e8@amazon.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 11 Nov 2020 17:13:40 -0500
Message-ID: <CAEXW_YRQ_GDcCxFcLrYjwNTG1nDZwUovczPSyOCvxXHq614DFw@mail.gmail.com>
Subject: Re: [RFC 1/2] x86/bugs: Disable coresched on hardware that does not
 need it
To:     Alexander Graf <graf@amazon.com>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Thomas Glexiner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        konrad.wilk@oracle.com, Dario Faggioli <dfaggioli@suse.com>,
        Paul Turner <pjt@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Patrick Bellasi <derkling@google.com>,
        =?UTF-8?B?YmVuYmppYW5nKOiSi+W9qik=?= <benbjiang@tencent.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Ben Segall <bsegall@google.com>, Josh Don <joshdon@google.com>,
        Hao Luo <haoluo@google.com>,
        "Anand K. Mistry" <amistry@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Mike Rapoport <rppt@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tony Luck <tony.luck@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 5:00 PM Alexander Graf <graf@amazon.com> wrote:
>
>
>
> On 11.11.20 22:14, Joel Fernandes wrote:
> >
> > Sorry, forgot to CC +Tom Lendacky . Please take a look Tom, thanks.
> >
> > On Wed, Nov 11, 2020 at 4:10 PM Joel Fernandes (Google)
> > <joel@joelfernandes.org> wrote:
> >>
> >> Some hardware such as certain AMD variants don't have cross-HT MDS/L1TF
> >> issues. Detect this and don't enable core scheduling as it can
> >> needlessly slow the device done.
> >>
> >> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> >> ---
> >>   arch/x86/kernel/cpu/bugs.c | 8 ++++++++
> >>   kernel/sched/core.c        | 7 +++++++
> >>   kernel/sched/sched.h       | 5 +++++
> >>   3 files changed, 20 insertions(+)
> >>
> >> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> >> index dece79e4d1e9..0e6e61e49b23 100644
> >> --- a/arch/x86/kernel/cpu/bugs.c
> >> +++ b/arch/x86/kernel/cpu/bugs.c
> >> @@ -152,6 +152,14 @@ void __init check_bugs(void)
> >>   #endif
> >>   }
> >>
> >> +/*
> >> + * Do not need core scheduling if CPU does not have MDS/L1TF vulnerability.
> >> + */
> >> +int arch_allow_core_sched(void)
> >> +{
> >> +       return boot_cpu_has_bug(X86_BUG_MDS) || boot_cpu_has_bug(X86_BUG_L1TF);
>
> Can we make this more generic and user settable, similar to the L1 cache
> flushing modes in KVM?
>
> I am not 100% convinced that there are no other thread sibling attacks
> possible without MDS and L1TF. If I'm paranoid, I want to still be able
> to force enable core scheduling.
>
> In addition, we are also using core scheduling as a poor man's mechanism
> to give customers consistent performance for virtual machine thread
> siblings. This is important irrespective of CPU bugs. In such a
> scenario, I want to force enable core scheduling.

Ok,  I can make it new kernel command line option with:
coresched=on
coresched=secure (only if HW has MDS/L1TF)
coresched=off

Does that work for you?  Others, thoughts?

Thanks,
- Joel
