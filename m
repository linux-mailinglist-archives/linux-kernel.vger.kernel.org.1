Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C722A3804
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 01:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbgKCAu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 19:50:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbgKCAu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 19:50:28 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EE7C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 16:50:28 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id d1so6441201qvl.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 16:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UEFx1qspk0YkZ7u1+c/tOT45Hza5hRrQ383XvCpgJQs=;
        b=kfZj/XcoUrqkDCQ6NcQRmZnxdJ+IIOkxOpWFDDk8Cd1LUGeWIlp+AgYb0SFcMvK9DR
         Dwf361ZrIDHjT8+Bsr+IZoqkYdzSJQCUX1mGyxqqMcJV3oPKTbMs8Fw1NRiLpT4QKs73
         FIzx6BsYM+LaVSXH9o/DBsfktt9QoG89iZaps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UEFx1qspk0YkZ7u1+c/tOT45Hza5hRrQ383XvCpgJQs=;
        b=RPqLJFNMEqqPffpBRFPIpPnyhYLN80iccuCNhLZJLlj3rmdhfN2zPXY4PzQTIhjVtO
         17STIqtUpkVEnqbR/m1GK6A/zEoHLV9FkZXdzpwypGLZQrJQbdZDVKX+kIJjYynP2LsS
         UcZxOIuUxJAbzoaL4gnv8q07lCBoc6iacg3cmRP7wVj65V2ebOBjSUWqfxnY83Cra0Jc
         txIRYU5J0eqG0Ld5tPZvEZmyguRzancTkOE51OrrcS6I/ambN7jevwmWMe9ItLHSc6+b
         VXweH/7wIm2hWwiObQEchHP+/0jDxorW5+c5G2gGNNzr6YKswauxVC3e9lAIwiE9bLTQ
         2hqQ==
X-Gm-Message-State: AOAM5328XsfaDelQAWDqKl4VI+Le73pxsGIVyqPhAX78627BpogrTkxS
        7L85WmEwUBGlO7ybD2plhBudfw==
X-Google-Smtp-Source: ABdhPJycoRBX/AdfS6aDq+XwnMvLmWJNuQ4rFIA+Zgoo4530WDavBpBs/dRCFnbzSaVoV+wVJPkHsw==
X-Received: by 2002:a05:6214:d4d:: with SMTP id 13mr11767494qvr.4.1604364627869;
        Mon, 02 Nov 2020 16:50:27 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id w5sm5550491qkj.102.2020.11.02.16.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 16:50:27 -0800 (PST)
Date:   Mon, 2 Nov 2020 19:50:26 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
        chris.hyser@oracle.com, Tim Chen <tim.c.chen@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v8 -tip 13/26] kernel/entry: Add support for core-wide
 protection of kernel-mode
Message-ID: <20201103005026.GD595952@google.com>
References: <20201020014336.2076526-1-joel@joelfernandes.org>
 <20201020014336.2076526-14-joel@joelfernandes.org>
 <5e6b425b-a158-67c0-872c-e55d3f747430@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e6b425b-a158-67c0-872c-e55d3f747430@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 01:48:12PM +0800, Li, Aubrey wrote:
> On 2020/10/20 9:43, Joel Fernandes (Google) wrote:
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
> > 
> > Cc: Julien Desfossez <jdesfossez@digitalocean.com>
> > Cc: Tim Chen <tim.c.chen@linux.intel.com>
> > Cc: Aaron Lu <aaron.lwe@gmail.com>
> > Cc: Aubrey Li <aubrey.li@linux.intel.com>
> > Cc: Tim Chen <tim.c.chen@intel.com>
> > Cc: Paul E. McKenney <paulmck@kernel.org>
> > Co-developed-by: Vineeth Pillai <viremana@linux.microsoft.com>
> > Tested-by: Julien Desfossez <jdesfossez@digitalocean.com>
> > Signed-off-by: Vineeth Pillai <viremana@linux.microsoft.com>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  .../admin-guide/kernel-parameters.txt         |   7 +
> >  include/linux/entry-common.h                  |   2 +-
> >  include/linux/sched.h                         |  12 +
> >  kernel/entry/common.c                         |  25 +-
> >  kernel/sched/core.c                           | 229 ++++++++++++++++++
> >  kernel/sched/sched.h                          |   3 +
> >  6 files changed, 275 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 3236427e2215..48567110f709 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -4678,6 +4678,13 @@
> >  
> >  	sbni=		[NET] Granch SBNI12 leased line adapter
> >  
> > +	sched_core_protect_kernel=
> > +			[SCHED_CORE] Pause SMT siblings of a core running in
> > +			user mode, if at least one of the siblings of the core
> > +			is running in kernel mode. This is to guarantee that
> > +			kernel data is not leaked to tasks which are not trusted
> > +			by the kernel.
> > +
> >  	sched_debug	[KNL] Enables verbose scheduler debug messages.
> >  
> >  	schedstats=	[KNL,X86] Enable or disable scheduled statistics.
> > diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
> > index 474f29638d2c..260216de357b 100644
> > --- a/include/linux/entry-common.h
> > +++ b/include/linux/entry-common.h
> > @@ -69,7 +69,7 @@
> >  
> >  #define EXIT_TO_USER_MODE_WORK						\
> >  	(_TIF_SIGPENDING | _TIF_NOTIFY_RESUME | _TIF_UPROBE |		\
> > -	 _TIF_NEED_RESCHED | _TIF_PATCH_PENDING |			\
> > +	 _TIF_NEED_RESCHED | _TIF_PATCH_PENDING | _TIF_UNSAFE_RET |	\
> >  	 ARCH_EXIT_TO_USER_MODE_WORK)
> >  
> >  /**
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index d38e904dd603..fe6f225bfbf9 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -2071,4 +2071,16 @@ int sched_trace_rq_nr_running(struct rq *rq);
> >  
> >  const struct cpumask *sched_trace_rd_span(struct root_domain *rd);
> >  
> > +#ifdef CONFIG_SCHED_CORE
> > +void sched_core_unsafe_enter(void);
> > +void sched_core_unsafe_exit(void);
> > +bool sched_core_wait_till_safe(unsigned long ti_check);
> > +bool sched_core_kernel_protected(void);
> > +#else
> > +#define sched_core_unsafe_enter(ignore) do { } while (0)
> > +#define sched_core_unsafe_exit(ignore) do { } while (0)
> > +#define sched_core_wait_till_safe(ignore) do { } while (0)
> > +#define sched_core_kernel_protected(ignore) do { } while (0)
> > +#endif
> > +
> >  #endif
> > diff --git a/kernel/entry/common.c b/kernel/entry/common.c
> > index 0a1e20f8d4e8..c8dc6b1b1f40 100644
> > --- a/kernel/entry/common.c
> > +++ b/kernel/entry/common.c
> > @@ -137,6 +137,26 @@ static __always_inline void exit_to_user_mode(void)
> >  /* Workaround to allow gradual conversion of architecture code */
> >  void __weak arch_do_signal(struct pt_regs *regs) { }
> >  
> > +unsigned long exit_to_user_get_work(void)
> > +{
> > +	unsigned long ti_work = READ_ONCE(current_thread_info()->flags);
> > +
> > +	if (IS_ENABLED(CONFIG_SCHED_CORE) && !sched_core_kernel_protected())
> > +		return ti_work;
> > +
> > +#ifdef CONFIG_SCHED_CORE
> > +	ti_work &= EXIT_TO_USER_MODE_WORK;
> > +	if ((ti_work & _TIF_UNSAFE_RET) == ti_work) {
> 
> Though _TIF_UNSAFE_RET is not x86 specific, but I only saw the definition in x86.
> I'm not sure if other SMT capable architectures are happy with this?

Sorry for late reply.

Yes, arch has to define it if they want kernel protection. There's no way
around it.

But I need to stub _TIF_UNSAFE_RET to 0 if it is not defined, like the other
TIF flags do. I'll make changes as below.

thanks!

 - Joel

---8<-----------------------

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 34dbbb764d6c..a338d5d64c3d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4684,7 +4684,8 @@
 			is running in kernel mode. This is to guarantee that
 			kernel data is not leaked to tasks which are not trusted
 			by the kernel. A value of 0 disables protection, 1
-			enables protection. The default is 1.
+			enables protection. The default is 1. Note that protection
+			depends on the arch defining the _TIF_UNSAFE_RET flag.
 
 	sched_debug	[KNL] Enables verbose scheduler debug messages.
 
diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 879562d920f2..4475d545f9a0 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -33,6 +33,10 @@
 # define _TIF_PATCH_PENDING		(0)
 #endif
 
+#ifndef _TIF_UNSAFE_RET
+# define _TIF_UNSAFE_RET		(0)
+#endif
+
 #ifndef _TIF_UPROBE
 # define _TIF_UPROBE			(0)
 #endif
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index a8e1974e5008..a18ed60cedea 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -28,7 +28,8 @@ static __always_inline void enter_from_user_mode(struct pt_regs *regs)
 
 	instrumentation_begin();
 	trace_hardirqs_off_finish();
-	sched_core_unsafe_enter();
+	if (_TIF_UNSAFE_RET) /* Kernel protection depends on arch defining the flag. */
+		sched_core_unsafe_enter();
 	instrumentation_end();
 }
 
@@ -142,7 +143,8 @@ unsigned long exit_to_user_get_work(void)
 {
 	unsigned long ti_work = READ_ONCE(current_thread_info()->flags);
 
-	if (IS_ENABLED(CONFIG_SCHED_CORE) && !sched_core_kernel_protected())
+	if ((IS_ENABLED(CONFIG_SCHED_CORE) && !sched_core_kernel_protected())
+	    || !_TIF_UNSAFE_RET)
 		return ti_work;
 
 #ifdef CONFIG_SCHED_CORE
-- 
2.29.1.341.ge80a0c044ae-goog


