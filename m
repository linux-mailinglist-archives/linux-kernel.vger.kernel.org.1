Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 974B12A815E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 15:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730814AbgKEOtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 09:49:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730871AbgKEOtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 09:49:22 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BDBC0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 06:49:21 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id a65so1331844qkg.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 06:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mBwzMjDkfddA3GG6Qd4/im/kzhg/3gl/2vjmX28S6D0=;
        b=Rqgw01k0N8Miti1WyIH/0v3+iJXf6kmv2E2nZMHr2U5Iz/AyW23fuPu+418AIuQycY
         TPINfyr4iEO5T0l5UTJmer/FiQeOmmOW5YIyDY9Wa0YCm0bdNRZ4kVD6fca57B3yqvJF
         3t7QX/TLP5+ZAZYkLfpqyeEgkruP9PDipZe7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mBwzMjDkfddA3GG6Qd4/im/kzhg/3gl/2vjmX28S6D0=;
        b=tU+qEHZRlTlTNSNU1HyTmVwAb4biPIYeqFa8jKGc/BaSob2g5TVmzcOqEP8wAV1iwR
         5sE+rgMYaUYJmdeULs7IrNRdYPR3YvvmdcM9ZXyONuE1KBAjsDqc8mfP3G35jazJWDqx
         1lf46E2bnBZSvZ3px1BW4jC8aAzGgkQ9rkwl6ocv7VxkfKN2oH5SY46Op4aehHaH1sMI
         KU/kaVD9hmqPMW+bYvjgUljCTgvAvwWkJOJ36FOe+Crlog2if/aC7DLNAI/eW9KTay17
         irFMcGsP3ZKa5hKWxkDFolsS9nhcc5/HXnNV0wV3g9PeDrgIN2amzfcZZgVtAh821KP5
         8Cag==
X-Gm-Message-State: AOAM5326bK1MD+XTiM/mkW8IzfpjrPPoP9yRFIORFym7Zm6Nu6M7Hdpr
        Jh5slGN8BsJEIytQLxxCtJPLEA==
X-Google-Smtp-Source: ABdhPJxbmwZEA/xty9tySEvKtA7peYSj29LgJD/B97v84+S1AziNeBMmeO+S51wes8RfyA7ET7ozfQ==
X-Received: by 2002:a05:620a:79a:: with SMTP id 26mr2296473qka.331.1604587760332;
        Thu, 05 Nov 2020 06:49:20 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id s43sm1026874qte.52.2020.11.05.06.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 06:49:19 -0800 (PST)
Date:   Thu, 5 Nov 2020 09:49:19 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     chris hyser <chris.hyser@oracle.com>
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
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
Subject: Re: [PATCH v8 -tip 17/26] sched: Split the cookie and setup per-task
 cookie on fork
Message-ID: <20201105144919.GA2656962@google.com>
References: <20201020014336.2076526-1-joel@joelfernandes.org>
 <20201020014336.2076526-18-joel@joelfernandes.org>
 <e296ed5a-d473-de1e-d2ab-af37e5db856a@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e296ed5a-d473-de1e-d2ab-af37e5db856a@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 05:30:24PM -0500, chris hyser wrote:
[..]
> +		wr.cookies[0] = cookie;
> > +	} else
> > +	/*
> > +	 * 		t1		joining		t2
> > +	 * CASE 1:
> > +	 * before	0				0
> > +	 * after	new cookie			new cookie
> > +	 *
> > +	 * CASE 2:
> > +	 * before	X (non-zero)			0
> > +	 * after	0				0
> > +	 *
> > +	 * CASE 3:
> > +	 * before	0				X (non-zero)
> > +	 * after	X				X
> > +	 *
> > +	 * CASE 4:
> > +	 * before	Y (non-zero)			X (non-zero)
> > +	 * after	X				X
> > +	 */
> > +	if (!t1->core_task_cookie && !t2->core_task_cookie) {
> > +		/* CASE 1. */
> > +		cookie = sched_core_alloc_task_cookie();
> > +		if (!cookie)
> > +			goto out_unlock;
> > +
> > +		/* Add another reference for the other task. */
> > +		if (!sched_core_get_task_cookie(cookie)) {
> > +			return -EINVAL;
> 
> should be:              ret = -EINVAL;

Fixed now, thanks.

thanks,

 - Joel


> 
> > +			goto out_unlock;
> > +		}
> > +
> > +		wr.tasks[0] = t1;
> > +		wr.tasks[1] = t2;
> > +		wr.cookies[0] = wr.cookies[1] = cookie;
> > +
> > +	} else if (t1->core_task_cookie && !t2->core_task_cookie) {
> > +		/* CASE 2. */
> > +		sched_core_put_task_cookie(t1->core_task_cookie);
> > +		sched_core_put_after_stopper = true;
> > +
> > +		wr.tasks[0] = t1; /* Reset cookie for t1. */
> > +
> > +	} else if (!t1->core_task_cookie && t2->core_task_cookie) {
> > +		/* CASE 3. */
> > +		if (!sched_core_get_task_cookie(t2->core_task_cookie)) {
> > +			ret = -EINVAL;
> > +			goto out_unlock;
> > +		}
> > +
> > +		wr.tasks[0] = t1;
> > +		wr.cookies[0] = t2->core_task_cookie;
> > +
> > +	} else {
> > +		/* CASE 4. */
> > +		if (!sched_core_get_task_cookie(t2->core_task_cookie)) {
> > +			ret = -EINVAL;
> > +			goto out_unlock;
> > +		}
> > +		sched_core_put_task_cookie(t1->core_task_cookie);
> > +		sched_core_put_after_stopper = true;
> > +
> > +		wr.tasks[0] = t1;
> > +		wr.cookies[0] = t2->core_task_cookie;
> > +	}
> > +
> > +	stop_machine(sched_core_task_join_stopper, (void *)&wr, NULL);
> > +
> > +	if (sched_core_put_after_stopper)
> > +		sched_core_put();
> > +
> > +	ret = 0;
> > +out_unlock:
> > +	mutex_unlock(&sched_core_mutex);
> > +	return ret;
> > +}
> > +
> > +/* CGroup interface */
> >   static u64 cpu_core_tag_read_u64(struct cgroup_subsys_state *css, struct cftype *cft)
> >   {
> >   	struct task_group *tg = css_tg(css);
> > @@ -9207,18 +9435,9 @@ static int __sched_write_tag(void *data)
> >   	 * when we set cgroup tag to 0 when the loop is done below.
> >   	 */
> >   	while ((p = css_task_iter_next(&it))) {
> > -		p->core_cookie = !!val ? (unsigned long)tg : 0UL;
> > -
> > -		if (sched_core_enqueued(p)) {
> > -			sched_core_dequeue(task_rq(p), p);
> > -			if (!p->core_cookie)
> > -				continue;
> > -		}
> > -
> > -		if (sched_core_enabled(task_rq(p)) &&
> > -		    p->core_cookie && task_on_rq_queued(p))
> > -			sched_core_enqueue(task_rq(p), p);
> > +		unsigned long cookie = !!val ? (unsigned long)tg : 0UL;
> > +		sched_core_tag_requeue(p, cookie, true /* group */);
> >   	}
> >   	css_task_iter_end(&it);
> > diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> > index c8fee8d9dfd4..88bf45267672 100644
> > --- a/kernel/sched/debug.c
> > +++ b/kernel/sched/debug.c
> > @@ -1024,6 +1024,10 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
> >   		__PS("clock-delta", t1-t0);
> >   	}
> > +#ifdef CONFIG_SCHED_CORE
> > +	__PS("core_cookie", p->core_cookie);
> > +#endif
> > +
> >   	sched_show_numa(p, m);
> >   }
> > 
> 
> -chrish
