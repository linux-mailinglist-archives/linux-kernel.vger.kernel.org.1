Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8C42C2DBB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 18:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390245AbgKXREd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 12:04:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389441AbgKXREc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 12:04:32 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6996C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 09:04:32 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id d9so21258059qke.8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 09:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=obEVozB81UHSovvaumjhiS8dmk+xqmutoJGiIGq4SQk=;
        b=rKuQjuBAA7wOYVE9gEFcVvly6MXntSepdtbUkQ+a5zIvyu0Qw8omlELYND7Q68rR9+
         lB/IPkQqlmrb/5XK7lhOoe8JJ4YUjWRrwsuI6oSvLKSckNSNfaweU0XhLt54saiCaqER
         jEFVO0QeBy1b86ZQ1jtMWHPCkMEN1o6nRWs08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=obEVozB81UHSovvaumjhiS8dmk+xqmutoJGiIGq4SQk=;
        b=WGbmc3TvVSBpgIhMIY0KjObzgs7B7xcbUZFOt5aRcpvQIP/7H51fN3VbOPg9lvcDPE
         cZyHpacH+vQsrw0j1aI77Mbpn++YYE2DdMbMvfV2IdreHj9NFhlGLXnxV17VAtrOQM6+
         AeSzrP6oO7/RsW0NyTUtfQx6ZSW4ip7ZghY8AUs4kbo/xxfkWgrEEsHhUdThXKhjYuKg
         v4g3InNyZ91t5BdDlhvXThl/uYjhNEuY1Ok0jnYUY1k8+DGa7NvoycxpApPp/lMlIuLc
         /v+uJbcYilgtD3+DjakLbKy++WyKQeu3djiTLFlWMX8gn/nX5RgUVEf8akQ6yj3FLZuO
         u+BQ==
X-Gm-Message-State: AOAM533aWU8lxE7H+zw8DU31iaG7WwLzZBanTZXMC+EVkwEdsEWBRlUJ
        2CEEQYOF53OrZRbyA7j3EbJ2+A==
X-Google-Smtp-Source: ABdhPJy0JSCacsG8pFPvcmkdn0FbyaHt4agex/8k5MhnWuAqqlqE+GmmiE4+dtAx4mZkG6GcWHG7tw==
X-Received: by 2002:a37:4893:: with SMTP id v141mr5560211qka.361.1606237471779;
        Tue, 24 Nov 2020 09:04:31 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id p62sm653316qkf.50.2020.11.24.09.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 09:04:30 -0800 (PST)
Date:   Tue, 24 Nov 2020 12:04:30 -0500
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
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
Subject: Re: [PATCH -tip 12/32] sched: Simplify the core pick loop for
 optimized case
Message-ID: <20201124170430.GC1021337@google.com>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-13-joel@joelfernandes.org>
 <20201124120438.GY3021@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124120438.GY3021@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Tue, Nov 24, 2020 at 01:04:38PM +0100, Peter Zijlstra wrote:
> On Tue, Nov 17, 2020 at 06:19:42PM -0500, Joel Fernandes (Google) wrote:
> > +	/*
> > +	 * Optimize for common case where this CPU has no cookies
> > +	 * and there are no cookied tasks running on siblings.
> > +	 */
> > +	if (!need_sync) {
> > +		for_each_class(class) {
> > +			next = class->pick_task(rq);
> > +			if (next)
> > +				break;
> > +		}
> > +
> > +		if (!next->core_cookie) {
> > +			rq->core_pick = NULL;
> > +			goto done;
> > +		}
> >  		need_sync = true;
> >  	}
> 
> This isn't what I send you here:
> 
>   https://lkml.kernel.org/r/20201026093131.GF2628@hirez.programming.kicks-ass.net

I had replied to it here with concerns about the effects of newly idle
balancing not being reverseable, it was only a theoretical concern:
http://lore.kernel.org/r/20201105185019.GA2771003@google.com

Also I was trying to keep the logic the same as v8 for unconstrained pick
(calling pick_task), considering that has been tested quite a bit.

> Specifically, you've lost the whole cfs-cgroup optimization.

Are you referring to this optimization in pick_next_task_fair() ?

/*
 * Since we haven't yet done put_prev_entity and if the
 * selected task
 * is a different task than we started out with, try
 * and touch the
 * least amount of cfs_rqs.
 */

You are right, we wouldn't get that with just calling pick_task_fair(). We
did not have this in v8 series either though.

Also, if the task is a cookied task, then I think you are doing more work
with your patch due to the extra put_prev_task().

> What was wrong/not working with the below?

Other than the new idle balancing, IIRC it was also causing instability.
Maybe we can considering this optimization in the future if that's Ok with
you?

thanks,

 - Joel

> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5225,8 +5227,6 @@ pick_next_task(struct rq *rq, struct tas
>  		return next;
>  	}
>  
> -	put_prev_task_balance(rq, prev, rf);
> -
>  	smt_mask = cpu_smt_mask(cpu);
>  	need_sync = !!rq->core->core_cookie;
>  
> @@ -5255,17 +5255,14 @@ pick_next_task(struct rq *rq, struct tas
>  	 * and there are no cookied tasks running on siblings.
>  	 */
>  	if (!need_sync) {
> -		for_each_class(class) {
> -			next = class->pick_task(rq);
> -			if (next)
> -				break;
> -		}
> -
> +		next = __pick_next_task(rq, prev, rf);
>  		if (!next->core_cookie) {
>  			rq->core_pick = NULL;
> -			goto done;
> +			return next;
>  		}
> -		need_sync = true;
> +		put_prev_task(next);
> +	} else {
> +		put_prev_task_balance(rq, prev, rf);
>  	}
>  
>  	for_each_cpu(i, smt_mask) {
