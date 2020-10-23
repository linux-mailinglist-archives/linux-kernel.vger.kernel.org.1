Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF03296D16
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 12:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S462541AbgJWKy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 06:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S375722AbgJWKy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 06:54:57 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD08C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 03:54:55 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id l18so951953pgg.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 03:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rq8SD2nOs+mpGfCg9fmURj/887r5YEwCC5NsLKmvNs0=;
        b=K422mEHRp2c7O2z4ARx3bZpVQCQ4cs8VqtVWOWE9dVpPAv7gdE0XpTNQ1nUNuKzM1F
         Z7zjwndzCYekp0Q+7bBapBI9h84fiBH3E4O3SxLGRIYBT6mqldA4GcH2JlGBMkGzz4aw
         aT2y0TkR9ruL6zbVd+wfrSlrPPRA/le5F4ysLhZxmPIwC/V5xJzv9wq3knNW6xCUTEMe
         naE2QvwlR7gw+IQgHob6adxUyY21JlVpbT9s8TkJsK/F0exiS93Mxzj0OHGYFM0ynP5C
         g00mFZH/PeTKYV25BYkGrniBgLIPOfQL3EmaSsBC2jtYftyDkIG/w9XnGEnS40AARiYO
         O+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rq8SD2nOs+mpGfCg9fmURj/887r5YEwCC5NsLKmvNs0=;
        b=oOV7AeQsvPwVWGZC33/gw8vcHaRt3kM4pWLRLFARzoCaRcFuitnX8FGcQclnfafmD3
         58AY3nyhBOrqgcELsDt9OGKj81AR24NiX2Q2KztISdmLxgIpOFMIAtxz49VuAmu17V82
         iG07OXnrycrGn2bJXViYaovM0mr/t/XpIPt5+1c21tUpiZ6p7Muo9TFTuPq/q65an4MV
         cKIGzTSYHJBGwz3A3hR5sfdkQ62mt83esDiTTG8+D0a+rVCNtxNLsRVaTxEJqyFIUc7l
         N7sRe0WUMhcCeKK3l6yTxuQZTOmfdLJTmObxKQTYjKyYUWVu+nKyq8VPXb/c3pKP92n2
         HCMA==
X-Gm-Message-State: AOAM531EPzuFoqgvlxW1EjWRo4bsMlMIAj7xyKpkHJf6u4mugUVs3Kje
        aox6lrFsz1Ti4mys1tmQ9VJo0w==
X-Google-Smtp-Source: ABdhPJwH3Fvnd8EAmIOD4KepLfyuCFw2nqFMxKtbxHQ+ay0fRdcVtMdDvsXe7Nu0VUR2hNofjmqlGw==
X-Received: by 2002:a05:6a00:845:b029:155:dcd2:7322 with SMTP id q5-20020a056a000845b0290155dcd27322mr1493189pfk.49.1603450495152;
        Fri, 23 Oct 2020 03:54:55 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id s8sm1847655pjn.46.2020.10.23.03.54.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Oct 2020 03:54:54 -0700 (PDT)
Date:   Fri, 23 Oct 2020 16:24:52 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, Quentin Perret <qperret@google.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH V2 1/2] sched/core: Rename and move schedutil_cpu_util()
 to core.c
Message-ID: <20201023105452.aivb5o6dws76evc3@vireshk-i7>
References: <cover.1603448113.git.viresh.kumar@linaro.org>
 <80c66f55ac7f04b3ecd4ebf12d69d86c89480fa7.1603448113.git.viresh.kumar@linaro.org>
 <20201023103407.GK2594@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201023103407.GK2594@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-10-20, 12:34, Peter Zijlstra wrote:
> On Fri, Oct 23, 2020 at 03:50:20PM +0530, Viresh Kumar wrote:
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index d2003a7d5ab5..369ff54d11d4 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -5117,6 +5117,119 @@ struct task_struct *idle_task(int cpu)
> >  	return cpu_rq(cpu)->idle;
> >  }
> >  
> > +/*
> > + * This function computes an effective utilization for the given CPU, to be
> > + * used for frequency selection given the linear relation: f = u * f_max.
> > + *
> > + * The scheduler tracks the following metrics:
> > + *
> > + *   cpu_util_{cfs,rt,dl,irq}()
> > + *   cpu_bw_dl()
> > + *
> > + * Where the cfs,rt and dl util numbers are tracked with the same metric and
> > + * synchronized windows and are thus directly comparable.
> > + *
> > + * The cfs,rt,dl utilization are the running times measured with rq->clock_task
> > + * which excludes things like IRQ and steal-time. These latter are then accrued
> > + * in the irq utilization.
> > + *
> > + * The DL bandwidth number otoh is not a measured metric but a value computed
> > + * based on the task model parameters and gives the minimal utilization
> > + * required to meet deadlines.
> > + */
> > +unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
> > +				 unsigned long max, enum cpu_util_type type,
> > +				 struct task_struct *p)
> > +{
> 	...
> > +}
> > +
> > +unsigned long sched_cpu_util(int cpu, enum cpu_util_type type,
> > +			     unsigned long max)
> > +{
> > +	return effective_cpu_util(cpu, cpu_util_cfs(cpu_rq(cpu)), max, type,
> > +				  NULL);
> > +}
> 
> Shouldn't all that be: #ifdef CONFIG_SMP ?

I didn't realize that these matrices are only available in case of SMP
and that's why schedutil isn't available for !SMP. I wonder what we
should be doing in cpufreq_cooling now ? Make it depend on SMP ? Or
calculate load the traditional way (the stuff I just removed) for !SMP
case ?

:)

-- 
viresh
