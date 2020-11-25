Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2379C2C40E8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 14:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbgKYNJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 08:09:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgKYNJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 08:09:03 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559A0C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 05:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3UsZHGub472MXItXO7Rnu1/ZePEG3Um5xNT6gh2zwx4=; b=uW7q9B/Y5J7xMAZC0RL4nsh5XP
        MzwhgAJNSTIePeDwjG1wKcXDNtcQ+b77vUOZxGZRT5ZSyJkIOEXhZied4EJmsXRl3fyJVxuUvRPr7
        1nNAK+WjO/JcxQi7KJD+wOF1om/oltuiEAsly4oD4ddqU4tcZcanvnrF1FGlPoIbeRMPhC0bXhmPE
        C48w9bveShZkFa3bHqow+EBVB4fYpfZ4vke9HemfmktjvEbwozO0VKPD6AKo767B0dCwP1unXj7Vm
        UgY8ZN/e5tIrl3mjJjHYSzjuTkUSnMBCbls52FUt4gI9jacUVDcaH+e4GI25s8NMnVUYULhtyGEs+
        OxsREe3A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khuWp-00061w-He; Wed, 25 Nov 2020 13:08:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1CAA930280E;
        Wed, 25 Nov 2020 14:08:09 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EBF3F20D6FE65; Wed, 25 Nov 2020 14:08:08 +0100 (CET)
Date:   Wed, 25 Nov 2020 14:08:08 +0100
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
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
Subject: Re: [PATCH -tip 23/32] sched: Add a per-thread core scheduling
 interface
Message-ID: <20201125130808.GY2414@hirez.programming.kicks-ass.net>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-24-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117232003.3580179-24-joel@joelfernandes.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 06:19:53PM -0500, Joel Fernandes (Google) wrote:
> +/* Called from prctl interface: PR_SCHED_CORE_SHARE */
> +int sched_core_share_pid(pid_t pid)
> +{
> +	struct task_struct *task;
> +	int err;
> +
> +	if (pid == 0) { /* Recent current task's cookie. */
> +		/* Resetting a cookie requires privileges. */
> +		if (current->core_task_cookie)
> +			if (!capable(CAP_SYS_ADMIN))
> +				return -EPERM;

Coding-Style fail.

Also, why?!? I realize it is true for your case, because hardware fail.
But in general this just isn't true. This wants to be some configurable
policy.
