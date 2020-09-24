Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE78276A80
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 09:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbgIXHSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 03:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbgIXHSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 03:18:48 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA4EC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 00:18:48 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id a15so1843173ljk.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 00:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J91V7Hu6MclElF4wO21rc9SuQ4YjAv208AXfqCDB2Qc=;
        b=pu8FlFLUdHmcHc/e+bn+ZlZDlk+q8jcMC6xywF1glqtrXxGp0a0nqSZ62n6SghjBg0
         i8JFmESWLFgpvQQ3Xe/Zp5DbcMvLz8mdiMlDY/EVn6uOH/UlM/itFbN3jKykWsZrYTei
         3MG285lZMVDMFCWqqsB0Vsea7lSe8oJOVPOON0WmjU8cNfZJjqPfFnjmtuJp/L0HStjY
         8r17tM0HJ6STwf8xjW7vg3ZYcvI/yl/M4uZP7oSHBqdL3gEyGaBIOgwSKwn/7FOPT5I5
         tWi/l9gKytNFcNCLWy3sQp2JA5OClnKz08Dpsuc8AQWAedd/F24adT15Fip8/mtvmLOD
         3JBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J91V7Hu6MclElF4wO21rc9SuQ4YjAv208AXfqCDB2Qc=;
        b=Fg9/6gTiu0Dbkd9olGZkED2UFAwWMcs5e3Vu4jKscD+O7mBxH8bfGz0FeKy6TUz59I
         KHZPEC3CXuTiF+ZwzrCiJ2qcMwdXK6JMNaBq4Do6D07r16W7MYSxWs9tPO3nbCM1J+j8
         IYEu7hxn8LDnJD2f34JIvewkb7Q2Wxxl+yDp0F5S6hnQsJfwsjHUkYTZMC09qJD6pFAt
         +a6ArY37pCQ4kyG/e1e8XsjXBvCf4WE6ehpabd+mlBQdkT6Z/wLXe1luXUVr73XsbolT
         mDxX492uWFF1WbuRLGr2meshnUjOty13avagYzsZtAuiczSSgDFo68ZQxynN1UjxXz09
         u8QQ==
X-Gm-Message-State: AOAM533zSuL+b+dxxpFLKne/IJj617iygEB4wIvma6ygXAd9qGm5MquF
        zpGBMS/7P6vlYctYsD1GahNO1MUdz9ob2xohwQOvEg==
X-Google-Smtp-Source: ABdhPJyXxGOyK12xemUt7pV49S+6xzg8PbhkV9FFQwtwo0+iu8pVD3PSPNvg0i/COywGPN8rXnIiY0RhgkTCRN9Z09o=
X-Received: by 2002:a2e:8693:: with SMTP id l19mr1183483lji.25.1600931926699;
 Thu, 24 Sep 2020 00:18:46 -0700 (PDT)
MIME-Version: 1.0
References: <1600930127-76857-1-git-send-email-xlpang@linux.alibaba.com>
In-Reply-To: <1600930127-76857-1-git-send-email-xlpang@linux.alibaba.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 24 Sep 2020 09:18:33 +0200
Message-ID: <CAKfTPtAgzcSZekb1D_Gm55vHpm4-9z5OyUxuoRTzx-_5icf5Ew@mail.gmail.com>
Subject: Re: [PATCH RESEND] sched/fair: Fix wrong cpu selecting from isolated domain
To:     Xunlei Pang <xlpang@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Jiang Biao <benbjiang@tencent.com>,
        Wetp Zhang <wetp.zy@linux.alibaba.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Sep 2020 at 08:48, Xunlei Pang <xlpang@linux.alibaba.com> wrote:
>
> We've met problems that occasionally tasks with full cpumask
> (e.g. by putting it into a cpuset or setting to full affinity)
> were migrated to our isolated cpus in production environment.
>
> After some analysis, we found that it is due to the current
> select_idle_smt() not considering the sched_domain mask.
>
> Steps to reproduce on my 31-CPU hyperthreads machine:
> 1. with boot parameter: "isolcpus=domain,2-31"
>    (thread lists: 0,16 and 1,17)
> 2. cgcreate -g cpu:test; cgexec -g cpu:test "test_threads"
> 3. some threads will be migrated to the isolated cpu16~17.
>
> Fix it by checking the valid domain mask in select_idle_smt().
>
> Fixes: 10e2f1acd010 ("sched/core: Rewrite and improve select_idle_siblings())
> Reported-by: Wetp Zhang <wetp.zy@linux.alibaba.com>
> Reviewed-by: Jiang Biao <benbjiang@tencent.com>
> Signed-off-by: Xunlei Pang <xlpang@linux.alibaba.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/fair.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 1a68a05..fa942c4 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6075,7 +6075,7 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int
>  /*
>   * Scan the local SMT mask for idle CPUs.
>   */
> -static int select_idle_smt(struct task_struct *p, int target)
> +static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
>  {
>         int cpu;
>
> @@ -6083,7 +6083,8 @@ static int select_idle_smt(struct task_struct *p, int target)
>                 return -1;
>
>         for_each_cpu(cpu, cpu_smt_mask(target)) {
> -               if (!cpumask_test_cpu(cpu, p->cpus_ptr))
> +               if (!cpumask_test_cpu(cpu, p->cpus_ptr) ||
> +                   !cpumask_test_cpu(cpu, sched_domain_span(sd)))
>                         continue;
>                 if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
>                         return cpu;
> @@ -6099,7 +6100,7 @@ static inline int select_idle_core(struct task_struct *p, struct sched_domain *s
>         return -1;
>  }
>
> -static inline int select_idle_smt(struct task_struct *p, int target)
> +static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
>  {
>         return -1;
>  }
> @@ -6274,7 +6275,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>         if ((unsigned)i < nr_cpumask_bits)
>                 return i;
>
> -       i = select_idle_smt(p, target);
> +       i = select_idle_smt(p, sd, target);
>         if ((unsigned)i < nr_cpumask_bits)
>                 return i;
>
> --
> 1.8.3.1
>
