Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0012F2BAB27
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 14:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgKTNcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 08:32:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbgKTNco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 08:32:44 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76335C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 05:32:44 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id r17so10048859ljg.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 05:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rkBwPCRy+fYCiET35Xw1czk/fPbP21kh2s/p3jdHihw=;
        b=Ktpb8TKdDPxW/PfYzp2UAo+7rqk4NjKTLjAWC3KWxvQOspDXNwd9PtQ8ge5eYdjgaw
         VI0ymAY4+R/Vjhp6qN0vBM7uFAaQfMlLwrqVcNnS+pa9ivv/cBDXVTxSzfgUDns5oVpc
         8LOLq+TjIjY2ethjJL88AvWoOM037u3Kjbw1XJiUbnQpEY0V3gT7fa15CUM5GLOUbStM
         hMpIF7AMidxCZKCx1WbCa+Ed7iIMvKzJV9KomlMs6QMJ/mSJn3dxx/sjSTx9WqIdGti2
         zEGTF2rik/khJSLMM2I64ZgqjovYVwq7ZAm/qN0G9jPrgiEKKEUR4rIXKcu71ZaYFwvF
         n9kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rkBwPCRy+fYCiET35Xw1czk/fPbP21kh2s/p3jdHihw=;
        b=SRtoof8oz6pUO2lSQensru8u0oEBapJydBbJCyqhL4CHKWklEanzE+4LAykYi5bVnA
         RxjxTuc+4Ns1NIsQ9876kedYKKDjPLEWQdMCerCVpWkv1tYQ7MwBKSovF50XTyiqjrb1
         olUaBvqx7PHNXPIutESh4PBcbED1YH+x537DFh0ynCvYYH4LwRCNNNUTdZkclFY1YLLN
         Ql5H37JJMcHytu+0Ha1t+ngeBiIn2nJFkMrVdJc62wbEUCtxpYsdV9ubvoTdE39S3ENl
         7YJUvDbdCaTb9iZwlbfQGcBq1CWGn0f94RIKlSi7H7agR62QSg0p+VRPBQWd/TB+U7rm
         g3Og==
X-Gm-Message-State: AOAM531HmjOdC/j9FJOFGuwf/HIU4VN3D1vT32J/+NMgnYctpLzDAH3V
        qIv6CqA0YxS0kPbWthfun+iTOVwiX5E6EbcqJPH6Kg==
X-Google-Smtp-Source: ABdhPJwtRgtX/cppp9nnkixiI+q2nhYET9gaAq/jCze+fTtj42InDuwii3wNe7EERUPGZY0wZXZVyF2UKK0GQtNQ0Qs=
X-Received: by 2002:a2e:8050:: with SMTP id p16mr8596856ljg.69.1605879162916;
 Fri, 20 Nov 2020 05:32:42 -0800 (PST)
MIME-Version: 1.0
References: <20201120090630.3286-1-mgorman@techsingularity.net> <20201120090630.3286-3-mgorman@techsingularity.net>
In-Reply-To: <20201120090630.3286-3-mgorman@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 20 Nov 2020 14:32:31 +0100
Message-ID: <CAKfTPtDynYOR138kw7=KUU8ATw0u8_o7X_+ekWdTm1wNMdef4g@mail.gmail.com>
Subject: Re: [PATCH 2/4] sched: Avoid unnecessary calculation of load
 imbalance at clone time
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Nov 2020 at 10:06, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> In find_idlest_group(), the load imbalance is only relevant when the group
> is either overloaded or fully busy but it is calculated unconditionally.
> This patch moves the imbalance calculation to the context it is required.
> Technically, it is a micro-optimisation but really the benefit is avoiding
> confusing one type of imbalance with another depending on the group_type
> in the next patch.
>
> No functional change.
>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/fair.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 5fbed29e4001..9aded12aaa90 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8777,9 +8777,6 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
>                         .group_type = group_overloaded,
>         };
>
> -       imbalance = scale_load_down(NICE_0_LOAD) *
> -                               (sd->imbalance_pct-100) / 100;
> -
>         do {
>                 int local_group;
>
> @@ -8833,6 +8830,11 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
>         switch (local_sgs.group_type) {
>         case group_overloaded:
>         case group_fully_busy:
> +
> +               /* Calculate allowed imbalance based on load */
> +               imbalance = scale_load_down(NICE_0_LOAD) *
> +                               (sd->imbalance_pct-100) / 100;
> +
>                 /*
>                  * When comparing groups across NUMA domains, it's possible for
>                  * the local domain to be very lightly loaded relative to the
> --
> 2.26.2
>
