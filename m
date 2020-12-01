Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B91C2CAA4B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 18:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731180AbgLARzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 12:55:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729012AbgLARzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 12:55:44 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D704C0613D4
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 09:55:04 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id d5so1797900qtn.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 09:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DOUwT3UAOJA6CtrY6vxG1S8xIIJcL67U3H+UINCfS3o=;
        b=GFj7Nn3Miplu2HFczY3h32MbCeCcGjJ2PFugvSk60q2ZiFNBsjnja0r//K2eYjnCCJ
         aXysr9LgvScmMU4qapKlpHjn7867COFoP7nmMMZ2H6N9GhWU3Cor/MsZL0HSgbz5OY/G
         KYGJ6/YEB4bD888cywgCwjZuyX2gQ//63N3Ec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DOUwT3UAOJA6CtrY6vxG1S8xIIJcL67U3H+UINCfS3o=;
        b=XnE/rhNVtSK6MmJ6iL2roGRnk+l0E8LzgW+CI5mGC39CrWE2sOnjg9KMGe0BccI0D+
         a3nnU8Syqy4B+PmNwrFvztsRPnOznS/nCixASPQA3JOUwjQ7V0tX1H0YYBuChZ5PwbtZ
         UDB/Pe/dHwPNMGJpxnrOsv1P1Yx4O7Bhh5w5ms+ZjFWBvVvshXPh0HeHl9y1zP54oXgq
         Q5XlmRb8gi2wCHrqld16z3H7ynVuEMakBAWINpsc1f/KOsFw4h02s4ec6eO+XKF6XkGx
         glbEB+JnK0lr08yEYEjN4f6s9Xy86+EutqVKF3jl1IOQBRYO10tA9djgKhwChO8yaI8P
         tX9Q==
X-Gm-Message-State: AOAM532fWdwxxWcIBtRuEWkQMBxciBvl2rR3O+9vU/HAkI58nglce5gI
        lAmNowDP4tHkdQ0B5s5fnv1fag==
X-Google-Smtp-Source: ABdhPJwdcmgGamcCK+646uTSvUVYLoPCYtKjqg9FbpwuJxZgetrOHunpv/lKuyF0ChuRi2rqWkqOMw==
X-Received: by 2002:ac8:5ccc:: with SMTP id s12mr4102530qta.364.1606845303692;
        Tue, 01 Dec 2020 09:55:03 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id y1sm340894qky.63.2020.12.01.09.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 09:55:02 -0800 (PST)
Date:   Tue, 1 Dec 2020 12:55:02 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        torvalds@linux-foundation.org, fweisbec@gmail.com,
        keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        pjt@google.com, rostedt@goodmis.org, derkling@google.com,
        benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>, jsbarnes@google.com,
        chris.hyser@oracle.com, Ben Segall <bsegall@google.com>,
        Josh Don <joshdon@google.com>, Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Tim Chen <tim.c.chen@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH -tip 18/32] kernel/entry: Add support for core-wide
 protection of kernel-mode
Message-ID: <20201201175502.GB201514@google.com>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-19-joel@joelfernandes.org>
 <20201125093700.GP2414@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201125093700.GP2414@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 10:37:00AM +0100, Peter Zijlstra wrote:
> On Tue, Nov 17, 2020 at 06:19:48PM -0500, Joel Fernandes (Google) wrote:
> > Core-scheduling prevents hyperthreads in usermode from attacking each
> > other, but it does not do anything about one of the hyperthreads
> > entering the kernel for any reason. This leaves the door open for MDS
> > and L1TF attacks with concurrent execution sequences between
> > hyperthreads.
> > 
> > This patch therefore adds support for protecting all syscall and IRQ
> > kernel mode entries. Care is taken to track the outermost usermode exit
> > and entry using per-cpu counters. In cases where one of the hyperthreads
> > enter the kernel, no additional IPIs are sent. Further, IPIs are avoided
> > when not needed - example: idle and non-cookie HTs do not need to be
> > forced into kernel mode.
> > 
> > More information about attacks:
> > For MDS, it is possible for syscalls, IRQ and softirq handlers to leak
> > data to either host or guest attackers. For L1TF, it is possible to leak
> > to guest attackers. There is no possible mitigation involving flushing
> > of buffers to avoid this since the execution of attacker and victims
> > happen concurrently on 2 or more HTs.
> 
> >  .../admin-guide/kernel-parameters.txt         |  11 +
> >  include/linux/entry-common.h                  |  12 +-
> >  include/linux/sched.h                         |  12 +
> >  kernel/entry/common.c                         |  28 +-
> >  kernel/sched/core.c                           | 241 ++++++++++++++++++
> >  kernel/sched/sched.h                          |   3 +
> >  6 files changed, 304 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index bd1a5b87a5e2..b185c6ed4aba 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -4678,6 +4678,17 @@
> >  
> >  	sbni=		[NET] Granch SBNI12 leased line adapter
> >  
> > +	sched_core_protect_kernel=
> > +			[SCHED_CORE] Pause SMT siblings of a core running in
> > +			user mode, if at least one of the siblings of the core
> > +			is running in kernel mode. This is to guarantee that
> > +			kernel data is not leaked to tasks which are not trusted
> > +			by the kernel. A value of 0 disables protection, 1
> > +			enables protection. The default is 1. Note that protection
> > +			depends on the arch defining the _TIF_UNSAFE_RET flag.
> > +			Further, for protecting VMEXIT, arch needs to call
> > +			KVM entry/exit hooks.
> > +
> >  	sched_debug	[KNL] Enables verbose scheduler debug messages.
> >  
> >  	schedstats=	[KNL,X86] Enable or disable scheduled statistics.
> 
> So I don't like the parameter name, it's too long. Also I don't like it
> because its a boolean.

Maybe ht_protect= then?

> You're adding syscall,irq,kvm under a single knob where they're all due
> to different flavours of broken. Different hardware might want/need
> different combinations.

Ok, I can try to make it ht_protect=irq,syscall,kvm etc. And conditionally
enable the protection. Does that work for you?
> 
> Hardware without MDS but with L1TF wouldn't need the syscall hook, but
> you're not givng a choice here. And this is generic code, you can't
> assume stuff like this.

Got it.

thanks,

 - Joel

