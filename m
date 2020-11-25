Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D414E2C40A4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 13:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbgKYMzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 07:55:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgKYMzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 07:55:55 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12342C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 04:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=18VVEZybOg8OLREr7667XcO7XQNbRsfPgXlmxcjHmRc=; b=QyOK4sZjHZtjFbvfkzrjXSKwom
        KNpOBu42hwbXNqxFWskRas2LF6TPHMscxS+zEar8QpqDeEbz4h3aBBis91csKZAS890maSMIvGjGl
        C72yIs7qGXlj45nu5vVD37YyTyIqFxUKd/pDmgAVe8lhWP6IF10VuT9NVCrrRf79ftd9eGFrgoKaq
        DloyhKOv9dEskowfzYrAXlhQtxk2FHB4Hw4b1pWHKnh62drnYIBWy9gM9UBCb29FDaUFrTJQOsgbi
        IPFqGpgHnZCQj8hBmyQK+o6t/fPQon+1AJ4V+cc4RnAunk4QDhEA6a9SIMUXuRNtY50piExiUtdWm
        KvXxqG4g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khuJv-0004Yu-Uu; Wed, 25 Nov 2020 12:54:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 51427300DAE;
        Wed, 25 Nov 2020 13:54:47 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 27DDB20D6FE65; Wed, 25 Nov 2020 13:54:47 +0100 (CET)
Date:   Wed, 25 Nov 2020 13:54:47 +0100
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
Message-ID: <20201125125447.GV2414@hirez.programming.kicks-ass.net>
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
> +/* Per-task interface */
> +static unsigned long sched_core_alloc_task_cookie(void)
> +{
> +	struct sched_core_cookie *ptr =
> +		kmalloc(sizeof(struct sched_core_cookie), GFP_KERNEL);
> +
> +	if (!ptr)
> +		return 0;
> +	refcount_set(&ptr->refcnt, 1);
> +
> +	/*
> +	 * NOTE: sched_core_put() is not done by put_task_cookie(). Instead, it
> +	 * is done after the stopper runs.
> +	 */
> +	sched_core_get();
> +	return (unsigned long)ptr;
> +}
> +
> +static bool sched_core_get_task_cookie(unsigned long cookie)
> +{
> +	struct sched_core_cookie *ptr = (struct sched_core_cookie *)cookie;
> +
> +	/*
> +	 * NOTE: sched_core_put() is not done by put_task_cookie(). Instead, it
> +	 * is done after the stopper runs.
> +	 */
> +	sched_core_get();
> +	return refcount_inc_not_zero(&ptr->refcnt);
> +}
> +
> +static void sched_core_put_task_cookie(unsigned long cookie)
> +{
> +	struct sched_core_cookie *ptr = (struct sched_core_cookie *)cookie;
> +
> +	if (refcount_dec_and_test(&ptr->refcnt))
> +		kfree(ptr);
> +}

> +	/*
> +	 * NOTE: sched_core_get() is done by sched_core_alloc_task_cookie() or
> +	 *       sched_core_put_task_cookie(). However, sched_core_put() is done
> +	 *       by this function *after* the stopper removes the tasks from the
> +	 *       core queue, and not before. This is just to play it safe.
> +	 */

So for no reason what so ever you've made the code more difficult?
