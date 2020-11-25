Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0F9A2C3C43
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 10:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgKYJiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 04:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbgKYJiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 04:38:03 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87A2C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 01:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NaHFaphjx/izFPgOWBYEKxWLZnpwZ/VDl8dDgyk0gRo=; b=PlVTt2CNgTL1afwnkPpRYAxYdm
        QMtQYk+cLALNCZHKU5bcbRyCpr0Vl4ucxtVD5T8J6uj7XAhqvK8vkIxEQOxvQJtL6ha5ZTgpEt/tZ
        VUKi/rfSL6kaq26ISAGre2eF5PX2KH/SkzRqoSXMsv+EiSuIx8uBG9SC5/cYiVjSv1YQkyHoXTA1x
        OaDmlwe0B0avqr3qsnNROFxKu3lO+PxwZhOEiXWd33r5zWXaKbNtH38ugi8YLheSTiA/zezSyYrnO
        gfCDCbNT0r5BkPbEpVLmy0Fu6hPWbs1UNuBRxVW616ZZAj13U43uI7wmQuCz3ZmjRE0LDN4tKhEH4
        ctDs+62Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khrEV-0004O2-Qu; Wed, 25 Nov 2020 09:37:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 356C03012DF;
        Wed, 25 Nov 2020 10:37:00 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1AD0C200C65A2; Wed, 25 Nov 2020 10:37:00 +0100 (CET)
Date:   Wed, 25 Nov 2020 10:37:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
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
Message-ID: <20201125093700.GP2414@hirez.programming.kicks-ass.net>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-19-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117232003.3580179-19-joel@joelfernandes.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 06:19:48PM -0500, Joel Fernandes (Google) wrote:
> Core-scheduling prevents hyperthreads in usermode from attacking each
> other, but it does not do anything about one of the hyperthreads
> entering the kernel for any reason. This leaves the door open for MDS
> and L1TF attacks with concurrent execution sequences between
> hyperthreads.
> 
> This patch therefore adds support for protecting all syscall and IRQ
> kernel mode entries. Care is taken to track the outermost usermode exit
> and entry using per-cpu counters. In cases where one of the hyperthreads
> enter the kernel, no additional IPIs are sent. Further, IPIs are avoided
> when not needed - example: idle and non-cookie HTs do not need to be
> forced into kernel mode.
> 
> More information about attacks:
> For MDS, it is possible for syscalls, IRQ and softirq handlers to leak
> data to either host or guest attackers. For L1TF, it is possible to leak
> to guest attackers. There is no possible mitigation involving flushing
> of buffers to avoid this since the execution of attacker and victims
> happen concurrently on 2 or more HTs.

>  .../admin-guide/kernel-parameters.txt         |  11 +
>  include/linux/entry-common.h                  |  12 +-
>  include/linux/sched.h                         |  12 +
>  kernel/entry/common.c                         |  28 +-
>  kernel/sched/core.c                           | 241 ++++++++++++++++++
>  kernel/sched/sched.h                          |   3 +
>  6 files changed, 304 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index bd1a5b87a5e2..b185c6ed4aba 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4678,6 +4678,17 @@
>  
>  	sbni=		[NET] Granch SBNI12 leased line adapter
>  
> +	sched_core_protect_kernel=
> +			[SCHED_CORE] Pause SMT siblings of a core running in
> +			user mode, if at least one of the siblings of the core
> +			is running in kernel mode. This is to guarantee that
> +			kernel data is not leaked to tasks which are not trusted
> +			by the kernel. A value of 0 disables protection, 1
> +			enables protection. The default is 1. Note that protection
> +			depends on the arch defining the _TIF_UNSAFE_RET flag.
> +			Further, for protecting VMEXIT, arch needs to call
> +			KVM entry/exit hooks.
> +
>  	sched_debug	[KNL] Enables verbose scheduler debug messages.
>  
>  	schedstats=	[KNL,X86] Enable or disable scheduled statistics.

So I don't like the parameter name, it's too long. Also I don't like it
because its a boolean.

You're adding syscall,irq,kvm under a single knob where they're all due
to different flavours of broken. Different hardware might want/need
different combinations.

Hardware without MDS but with L1TF wouldn't need the syscall hook, but
you're not givng a choice here. And this is generic code, you can't
assume stuff like this.
