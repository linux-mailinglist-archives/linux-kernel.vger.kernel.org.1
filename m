Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8622C40DF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 14:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729617AbgKYNEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 08:04:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729309AbgKYNEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 08:04:30 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE33AC0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 05:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ChnPSnYSrpAjn5eTsO0Dj+lGuaPW578KWibnvzMSe1s=; b=Y6M+MFFBNdQVG+SaBH+zvFK7yT
        cx9WLVC+PvDZNVj7/xYuMaPImYxELOZp9nWHbG5C5COTigQSXSNTgpH3pkQzJHr0RB1izGsuk25R4
        THCA1GMBTjjZ/SJu1G8rmAp4p2QnChJhikMX4KwYVu29QePA1eNe7ICqRdAGrsvvvWZUOivr/92tM
        8g98wJO6m9uRaL6m2wbczzgu/iSGj1ysJ+Xu/3SgjM3TyFGJpCkmM2LcGRAgDQvqz4Xg3sBKdR8LD
        LuNA4YsFeO2D2Q/DxCi4tfarongVszLj9HvCYJU3FCdHkSJPlJP0dGv86fpooOa8S0oa/Xl1QtxT7
        0xdWYZBQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khuSE-0005Lk-Jb; Wed, 25 Nov 2020 13:03:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A89643012DF;
        Wed, 25 Nov 2020 14:03:22 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9135920D6FE65; Wed, 25 Nov 2020 14:03:22 +0100 (CET)
Date:   Wed, 25 Nov 2020 14:03:22 +0100
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
Message-ID: <20201125130322.GW2414@hirez.programming.kicks-ass.net>
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

See below, but afaict this should be refcount_inc().

> +}

> +	/*
> +	 * 		t1		joining		t2
> +	 * CASE 1:
> +	 * before	0				0
> +	 * after	new cookie			new cookie
> +	 *
> +	 * CASE 2:
> +	 * before	X (non-zero)			0
> +	 * after	0				0
> +	 *
> +	 * CASE 3:
> +	 * before	0				X (non-zero)
> +	 * after	X				X
> +	 *
> +	 * CASE 4:
> +	 * before	Y (non-zero)			X (non-zero)
> +	 * after	X				X
> +	 */
> +	if (!t1->core_task_cookie && !t2->core_task_cookie) {
> +		/* CASE 1. */
> +		cookie = sched_core_alloc_task_cookie();
> +		if (!cookie)
> +			goto out_unlock;
> +
> +		/* Add another reference for the other task. */
> +		if (!sched_core_get_task_cookie(cookie)) {

afaict this should be refcount_inc(), as this can never fail and if it
does, it's an error.

> +			ret = -EINVAL;
> +			goto out_unlock;
> +		}
> +
> +		wr.tasks[0] = t1;
> +		wr.tasks[1] = t2;
> +		wr.cookies[0] = wr.cookies[1] = cookie;
> +
> +	} else if (t1->core_task_cookie && !t2->core_task_cookie) {
> +		/* CASE 2. */
> +		sched_core_put_task_cookie(t1->core_task_cookie);
> +		sched_core_put_after_stopper = true;
> +
> +		wr.tasks[0] = t1; /* Reset cookie for t1. */
> +
> +	} else if (!t1->core_task_cookie && t2->core_task_cookie) {
> +		/* CASE 3. */
> +		if (!sched_core_get_task_cookie(t2->core_task_cookie)) {

afaict this can never fail either, because you're calling in here with a
reference on t2

> +			ret = -EINVAL;
> +			goto out_unlock;
> +		}
> +
> +		wr.tasks[0] = t1;
> +		wr.cookies[0] = t2->core_task_cookie;
> +
> +	} else {
> +		/* CASE 4. */
> +		if (!sched_core_get_task_cookie(t2->core_task_cookie)) {

Same.

> +			ret = -EINVAL;
> +			goto out_unlock;
> +		}
> +		sched_core_put_task_cookie(t1->core_task_cookie);
> +		sched_core_put_after_stopper = true;
> +
> +		wr.tasks[0] = t1;
> +		wr.cookies[0] = t2->core_task_cookie;
> +	}
