Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07D442C254E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 13:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387436AbgKXMFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 07:05:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387427AbgKXMFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 07:05:41 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B84C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 04:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZPMTeBL5uTPVvPaAezchwqaTM/QZ2Ryp2lohK82OuMI=; b=w7oCaXHR+Ufy/R8pc+rYvAhXbc
        +HsTYgezirfDh+0OT9Rs/uAP1YFHMudci1ntBR/7b+gmgqhSg6h4VUuYFXXos3lQiz1FiucSvUVKk
        VQE+HcoQkFX7/Srf8Ei+UNqOUD0KXU02GPP2khoPbfUSEukZTir5/7i3r2bGO56+4S9sgeljW3xM3
        ll/ls4gVCV4KHJ2Kw7DXYrZ1muDqz5k7xg+aGb1EnjN3MRhaYnlyL+B5252FkcuGYwkBrth+Qu5vQ
        0o02NWbOZpJQRy8DYmi5JiXqhdmYY2qw+6A6UddDVSiM6dx1A26fDqgTUrscGeJNgc7gzulK90k4l
        OCSvFnEQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khX3r-0006xj-EO; Tue, 24 Nov 2020 12:04:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 98AE83062EA;
        Tue, 24 Nov 2020 13:04:38 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7CF40200DB085; Tue, 24 Nov 2020 13:04:38 +0100 (CET)
Date:   Tue, 24 Nov 2020 13:04:38 +0100
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
Subject: Re: [PATCH -tip 12/32] sched: Simplify the core pick loop for
 optimized case
Message-ID: <20201124120438.GY3021@hirez.programming.kicks-ass.net>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-13-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117232003.3580179-13-joel@joelfernandes.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 06:19:42PM -0500, Joel Fernandes (Google) wrote:
> +	/*
> +	 * Optimize for common case where this CPU has no cookies
> +	 * and there are no cookied tasks running on siblings.
> +	 */
> +	if (!need_sync) {
> +		for_each_class(class) {
> +			next = class->pick_task(rq);
> +			if (next)
> +				break;
> +		}
> +
> +		if (!next->core_cookie) {
> +			rq->core_pick = NULL;
> +			goto done;
> +		}
>  		need_sync = true;
>  	}

This isn't what I send you here:

  https://lkml.kernel.org/r/20201026093131.GF2628@hirez.programming.kicks-ass.net

Specifically, you've lost the whole cfs-cgroup optimization.

What was wrong/not working with the below?

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5225,8 +5227,6 @@ pick_next_task(struct rq *rq, struct tas
 		return next;
 	}
 
-	put_prev_task_balance(rq, prev, rf);
-
 	smt_mask = cpu_smt_mask(cpu);
 	need_sync = !!rq->core->core_cookie;
 
@@ -5255,17 +5255,14 @@ pick_next_task(struct rq *rq, struct tas
 	 * and there are no cookied tasks running on siblings.
 	 */
 	if (!need_sync) {
-		for_each_class(class) {
-			next = class->pick_task(rq);
-			if (next)
-				break;
-		}
-
+		next = __pick_next_task(rq, prev, rf);
 		if (!next->core_cookie) {
 			rq->core_pick = NULL;
-			goto done;
+			return next;
 		}
-		need_sync = true;
+		put_prev_task(next);
+	} else {
+		put_prev_task_balance(rq, prev, rf);
 	}
 
 	for_each_cpu(i, smt_mask) {
