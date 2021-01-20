Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61F3D2FCE2E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 11:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732458AbhATKSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 05:18:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728497AbhATJ7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 04:59:05 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101CAC061575
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 01:58:24 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id b10so25330902ljp.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 01:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Ks05RV0kp0b9hT1xvCInTbszJMafyzVO7leIaHZgTY=;
        b=SRGevzCPKX7q+ZV+YgzH00AxKP2cCDwZPbQEvkroR8nkAVlh/BQd4LYJakt+98vbM6
         0/mYwrk2YFfSMV60kE//BjKVJvpLdBrECVajs0zKQDqf54T9YV6oxkc71bDuT5ujxAa7
         CDIrA57o+61faxxv6Cl82RaLjjtLfb456E5ZbYKHu8DGW6jPXADR+LaQsv36hNbyhoLA
         1dT0fzJaI735UPAfzMgQCy+hrHy35mJvOP0i2xPH8l3fcmXgyAtXYm+eoM9K6cOFhUSp
         /83EscX/2Trzm709qV5pjgE4I1cLQdZSKIca/5DIb7SizwFbzn8NxypGsHnZI8r2AnyY
         gvjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Ks05RV0kp0b9hT1xvCInTbszJMafyzVO7leIaHZgTY=;
        b=uctEjvzQnmZ2FjjmsXMAyeWWGYqwQRsfkq1jw4F3n6arUw/+iHS/jA4fWOctowT15Y
         TuglURthYTqHFX1ZXrvfzaW51ywb+fbPn+0FAsov348m3A2bDlm0sSjjehoxLmRc0xaG
         yp/EAeWCwdk2fpPjIH3mrHNNsKS1B4oiksYqKdnCZSKnNsTFWkRYMhdKHZotJ0Avz/SZ
         M9gCQ5Eud4N230cOd7IW7ErXr2/YhCDVxsa4K1rlFPRNDV5iHyYjKFfJvYAiYejsHbN2
         99epCCouL/IrV+wASB3+C9Tv9D9db0730pY1Sc9YC3adTTQtTYrKjdDSAI8T0RlBCvkn
         vlYA==
X-Gm-Message-State: AOAM533QDrsqdEhEB0Xm/mXGxhQUphHsLhZTDkFWHJzXE3Ft2RvCgnV3
        hvn5ROEsPvGSXcHYBopJXxuc/8Mr16pBHzBzt0zO9w==
X-Google-Smtp-Source: ABdhPJyQ5YUDHjsNdBmrsRph6GmXV0rIXShYkbFBNvjEXMVWW+IzCi/yLtMyXPqhpRMFYfZef8ZnfJ3nrne0UC+ExUo=
X-Received: by 2002:a2e:7605:: with SMTP id r5mr210042ljc.299.1611136702434;
 Wed, 20 Jan 2021 01:58:22 -0800 (PST)
MIME-Version: 1.0
References: <20210119112211.3196-1-mgorman@techsingularity.net>
 <20210119112211.3196-6-mgorman@techsingularity.net> <20210120083018.GA14462@in.ibm.com>
 <20210120091235.GT3592@techsingularity.net> <CAKfTPtBYuxKywCPeEd=vYCu31Ni0=uXoJa4v3ZV_T9J0TsVyhg@mail.gmail.com>
 <20210120095420.GU3592@techsingularity.net>
In-Reply-To: <20210120095420.GU3592@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 20 Jan 2021 10:58:10 +0100
Message-ID: <CAKfTPtBP_Q_5-3_Upv2geuU-qNQ-2i8E71-pC+eZWJSN6qNyXg@mail.gmail.com>
Subject: Re: [PATCH 5/5] sched/fair: Merge select_idle_core/cpu()
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Li Aubrey <aubrey.li@linux.intel.com>,
        Qais Yousef <qais.yousef@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jan 2021 at 10:54, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Wed, Jan 20, 2021 at 10:21:47AM +0100, Vincent Guittot wrote:
> > On Wed, 20 Jan 2021 at 10:12, Mel Gorman <mgorman@techsingularity.net> wrote:
> > >
> > > On Wed, Jan 20, 2021 at 02:00:18PM +0530, Gautham R Shenoy wrote:
> > > > > @@ -6157,18 +6169,31 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
> > > > >     }
> > > > >
> > > > >     for_each_cpu_wrap(cpu, cpus, target) {
> > > > > -           if (!--nr)
> > > > > -                   return -1;
> > > > > -           if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
> > > > > -                   break;
> > > > > +           if (smt) {
> > > > > +                   i = select_idle_core(p, cpu, cpus, &idle_cpu);
> > > > > +                   if ((unsigned int)i < nr_cpumask_bits)
> > > > > +                           return i;
> > > > > +
> > > > > +           } else {
> > > > > +                   if (!--nr)
> > > > > +                           return -1;
> > > > > +                   i = __select_idle_cpu(cpu);
> > > > > +                   if ((unsigned int)i < nr_cpumask_bits) {
> > > > > +                           idle_cpu = i;
> > > > > +                           break;
> > > > > +                   }
> > > > > +           }
> > > > >     }
> > > > >
> > > > > -   if (sched_feat(SIS_PROP)) {
> > > > > +   if (smt)
> > > > > +           set_idle_cores(this, false);
> > > >
> > > > Shouldn't we set_idle_cores(false) only if this was the last idle
> > > > core in the LLC ?
> > > >
> > >
> > > That would involve rechecking the cpumask bits that have not been
> > > scanned to see if any of them are an idle core. As the existance of idle
> > > cores can change very rapidly, it's not worth the cost.
> >
> > But don't we reach this point only if we scanned all CPUs and didn't
> > find an idle core ?
>
> Yes, but my understanding of Gauthams suggestion was to check if an
> idle core found was the last idle core available and set has_idle_cores

ok get it now

> to false in that case. I think this would be relatively expensive and
> possibly futile as returning the last idle core for this wakeup does not
> mean there will be no idle core on the next wakeup as other cores may go
> idle between wakeups.

I agree, this doesn't worth the added complexity

>
> --
> Mel Gorman
> SUSE Labs
