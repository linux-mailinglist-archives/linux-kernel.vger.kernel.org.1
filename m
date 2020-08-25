Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB1C025121D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Aug 2020 08:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbgHYGhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 02:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729068AbgHYGhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 02:37:33 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0995C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 23:37:32 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id j21so815272oii.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 23:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0d0Anc1XlMz+zpMek67nwSvikP6pkgQmKbLI0Ck2oAM=;
        b=NDlbceHBONvyCLLkia1Z8aH4agCZ01UngrV0cslSC+9CHfi6fBNWHHJUootlPMMsdh
         wkX63RemGeJMg+vPcxpb+erAd5OHyCigDLcZKxT4EoelVTAX9lW4QPuu6bnRVK9JOwQJ
         7i6wp4dWMRsiX34qBV34oU1uJ2XxIkh/pDVe3XegjezjVfHwDs6Vu1mW7vnahIXBrLQZ
         Eqp0fIb+xajsNygrwxd6Y7GEFI7kUq+GpyMYtWV0KQtTLjeYFgnNHMJN31KMGi77Km+T
         4mPHyhof1GQjFlsUfUNc05SmJ/sph3hkfjqYg+2Piuntcb5efvDF/dqxZUgpxh5KZf5m
         igjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0d0Anc1XlMz+zpMek67nwSvikP6pkgQmKbLI0Ck2oAM=;
        b=YphGH+vjRHUGmXQl4T68pAM2KonqZ7vbFJby/g04gtCK/ogrBYyBgie4gwGk43whbQ
         GRzaXgr12lwITj9WHVF+BX5XvSfG4QadMT1u/hhG86U5Pj/iwcQwRs6jtah5+776lF6O
         8nGqnYm/aeQoqdKoULtgcsyxYQ7Uudh5hL+XsE9pUWj0Zi0dbfsi+NSplULNnNUI3hoc
         RopDig/CrvJJk2gFR61lfJgSgQu5gPFP2SiyqV7L5GC380bV3SXjboWgvGIeGKkHoHhU
         bP4rW8Yj8FEAkLG8G1vOowmegnf0NCBgHqO/Jyl2ZnuyhlXRhEAJ7aNt9qrqLj7e/l09
         48yg==
X-Gm-Message-State: AOAM533v+WlQZNT5BfkBePbs0+XNzBqbNrg2eADCuKDnyZihPKnMfKRr
        VcZ4Vu1/EFMh5DYFQ24NxRIUigfCTiayiNt7YKM=
X-Google-Smtp-Source: ABdhPJz7c9aF+8Y5tdKUSSKzv5l/3+ps2MqPJHtRg7YUkOtBZuPCNTjIwqSO9ctkcV5wYNlfATbCQtcCZI3Xu43VFc0=
X-Received: by 2002:a05:6808:9a1:: with SMTP id e1mr210610oig.150.1598337452192;
 Mon, 24 Aug 2020 23:37:32 -0700 (PDT)
MIME-Version: 1.0
References: <1598272219-43040-1-git-send-email-xlpang@linux.alibaba.com>
In-Reply-To: <1598272219-43040-1-git-send-email-xlpang@linux.alibaba.com>
From:   Jiang Biao <benbjiang@gmail.com>
Date:   Tue, 25 Aug 2020 14:37:21 +0800
Message-ID: <CAPJCdBnTm0=Nazi2w9a6mBcKNv=_66UwvMfTNg6vLNKqW6qfwQ@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Fix wrong cpu selecting from isolated domain
To:     Xunlei Pang <xlpang@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Wetp Zhang <wetp.zy@linux.alibaba.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Aug 2020 at 20:31, Xunlei Pang <xlpang@linux.alibaba.com> wrote:
>
> We've met problems that occasionally tasks with full cpumask
> (e.g. by putting it into a cpuset or setting to full affinity)
> were migrated to our isolated cpus in production environment.
>
> After some analysis, we found that it is due to the current
> select_idle_smt() not considering the sched_domain mask.
>
> Fix it by checking the valid domain mask in select_idle_smt().
>
> Fixes: 10e2f1acd010 ("sched/core: Rewrite and improve select_idle_siblings())
> Reported-by: Wetp Zhang <wetp.zy@linux.alibaba.com>
> Signed-off-by: Xunlei Pang <xlpang@linux.alibaba.com>
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
Maybe the following change could be better, :)
for_each_cpu_and(cpu, cpu_smt_mask(target), sched_domain_span(sd))
keep a similar style with select_idle_core/cpu, and could reduce loops.

Just an option.
Reviewed-by: Jiang Biao <benbjiang@tencent.com>
