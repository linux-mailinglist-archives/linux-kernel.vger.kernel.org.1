Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D44B2C3EE2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 12:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgKYLQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 06:16:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgKYLQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 06:16:35 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87EDBC0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 03:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Vmrifzl4A3f/O40RO24t+8RGzkr1gyx9UcKYuOhWMqw=; b=NY//4ROA+aA4lQ1yEmbzIwqumZ
        al27EHrv9pFO8m/tiWtPKw4ZXxB1+nG9pg10on9A6QcwFuKDiUoPkPHbJOSKdWhg/cRmjCgODMWhw
        8y/a6bZUYgEUALBE5NL2RBocD0aL6UMatin6OSXmjMWgmG1Bfkmk3fyK56cB6qZjy9P9Nx9j+QST3
        G2uWFKSscez3KHbzdP7suBuzH3jFLNneXU9Rr6bsCGd5Gr+zLQFpRIYKTHvw+FjijTyFRlLL4rFsE
        WvoNJjpjp/3ix9jEY6xyoXzim3uznoKLjvy1oJXcIyQ/I1hjO5evoJoAVOeU/Ps2w5hX5sS/RaKna
        uORrs24w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khslz-0008Dl-K9; Wed, 25 Nov 2020 11:15:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6B09D300DAE;
        Wed, 25 Nov 2020 12:15:41 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5213F20D6FE74; Wed, 25 Nov 2020 12:15:41 +0100 (CET)
Date:   Wed, 25 Nov 2020 12:15:41 +0100
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
Subject: Re: [PATCH -tip 22/32] sched: Split the cookie and setup per-task
 cookie on fork
Message-ID: <20201125111541.GU2414@hirez.programming.kicks-ass.net>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-23-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117232003.3580179-23-joel@joelfernandes.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 06:19:52PM -0500, Joel Fernandes (Google) wrote:

> +/*
> + * Ensure that the task has been requeued. The stopper ensures that the task cannot
> + * be migrated to a different CPU while its core scheduler queue state is being updated.
> + * It also makes sure to requeue a task if it was running actively on another CPU.
> + */
> +static int sched_core_task_join_stopper(void *data)
> +{
> +	struct sched_core_task_write_tag *tag = (struct sched_core_task_write_tag *)data;
> +	int i;
> +
> +	for (i = 0; i < 2; i++)
> +		sched_core_tag_requeue(tag->tasks[i], tag->cookies[i], false /* !group */);
> +
> +	return 0;
> +}
> +
> +static int sched_core_share_tasks(struct task_struct *t1, struct task_struct *t2)
> +{

> +	stop_machine(sched_core_task_join_stopper, (void *)&wr, NULL);

> +}

This is *REALLY* terrible...
