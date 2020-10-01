Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21A1827FA0D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 09:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731443AbgJAHR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 03:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgJAHR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 03:17:57 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6316C0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 00:17:56 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id x69so5282427lff.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 00:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3a093mPLZMLxYyJzXYAdUThLjs9nDEPaRY1HYNU1+A8=;
        b=phLR2D7CIuwvfBdghXXEUpr407xElTXrTDs2NErBJJ3Hp4IIqhS43vO9WMmQ+YHKjV
         zuvzvkwd8kpxVAtzGR85PbLYtoNVBFOOu4w+24eGTQG+PHfPdI2bNkPx1oyHihf+idr7
         yp9F7VfRN2oJ04fEB6IWHUYGS0bSM+wqG5RNcspEjlOq9W+buV2zkHTXzDOko+Tto1jH
         5sSqHwbjKMZbZRFVQVNwDTuZ+VHP4RYa5fLfStVK0xPZbB8ptS0xvZop+ABB522Ql3ZQ
         DHvl5vL3844FufgDd0+XOvb6ysV5VviMShTsgfpk15pWEYzWSBhJJWoL2bRIKPIWiUG5
         faJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3a093mPLZMLxYyJzXYAdUThLjs9nDEPaRY1HYNU1+A8=;
        b=gx1ya9FVK5SBVGJD93WArtVqOgBg8XEt7cUhqe8yJWAbpqqL3Cj2pcmVxyqFS4Ionj
         xhUDMT7DOjSqkkoExsGj487rToB3P/sJgOrD5k+4T2j/wWeyMvS+3VUSMueY3dhxWENA
         WAfdpzaf7Q+0wYVtgDMt3u63wHGmVCSt9TVKBksxfeNs/5dNFrd7AXs7tPkw62qM1D0X
         iynNPfkCyXFLkDjlWUzJ5fUWc0ffNN6HGj+FCPJnDkd9E0o5twIDtDXhpWPAkQ89yGf2
         1R2OKjG2BGb+HzMjhRW3T+EDd2vGSgEZJhEy0VHunt8hvaCt7GI34lJOKSlS6Oy7kFCb
         M7mQ==
X-Gm-Message-State: AOAM531RMrrlfWR6CD3IoXxm2WD1IpqGd3ADylY0Kc4pmMt61oUt6GMh
        ndp0SsoHilwywG7AVvkQ8CMm8SujS/NH3c0Dg8nRvg==
X-Google-Smtp-Source: ABdhPJxP55D2hhWqSR4tCJ07ITlzNDCAZ+lnrwKrTe9ednrN2CUOtNrfTEpWdc0cRTFZa+RQE8MRM/YY+CPChPBADKM=
X-Received: by 2002:ac2:43c2:: with SMTP id u2mr1975724lfl.573.1601536675034;
 Thu, 01 Oct 2020 00:17:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200930173532.1069092-1-posk@google.com>
In-Reply-To: <20200930173532.1069092-1-posk@google.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 1 Oct 2020 09:17:43 +0200
Message-ID: <CAKfTPtBbaw5Ny_qmdhwiQyErfpE+GehY3wTMUxNVtfBjnAVC5w@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: tweak pick_next_entity
To:     Peter Oskolkov <posk@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Oskolkov <posk@posk.io>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Sep 2020 at 19:35, Peter Oskolkov <posk@google.com> wrote:
>
> Currently, pick_next_entity(...) has the following structure
> (simplified):
>
> [...]
> if (last_buddy_ok())
>   result = last_buddy;
> if (next_buddy_ok())
>   result = next_buddy;
> [...]
>
> The intended behavior is to prefer next buddy over last buddy;
> the current code somewhat obfuscates this, and also wastes
> cycles checking the last buddy when eventually the next buddy is
> picked up.
>
> So this patch refactors two 'ifs' above into
>
> [...]
> if (next_buddy_ok())
>     result = next_buddy;
> else if (last_buddy_ok())
>     result = last_buddy;
> [...]
>
> Signed-off-by: Peter Oskolkov <posk@google.com>

Reviewed-by: Vincent Guittot <vincent.guitttot@linaro.org>

> ---
>  kernel/sched/fair.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index fc3410b8b990..cec6cf9b2bb3 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4465,17 +4465,17 @@ pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
>                         se = second;
>         }
>
> -       /*
> -        * Prefer last buddy, try to return the CPU to a preempted task.
> -        */
> -       if (cfs_rq->last && wakeup_preempt_entity(cfs_rq->last, left) < 1)
> -               se = cfs_rq->last;
> -
> -       /*
> -        * Someone really wants this to run. If it's not unfair, run it.
> -        */
> -       if (cfs_rq->next && wakeup_preempt_entity(cfs_rq->next, left) < 1)
> +       if (cfs_rq->next && wakeup_preempt_entity(cfs_rq->next, left) < 1) {
> +               /*
> +                * Someone really wants this to run. If it's not unfair, run it.
> +                */
>                 se = cfs_rq->next;
> +       } else if (cfs_rq->last && wakeup_preempt_entity(cfs_rq->last, left) < 1) {
> +               /*
> +                * Prefer last buddy, try to return the CPU to a preempted task.
> +                */
> +               se = cfs_rq->last;
> +       }
>
>         clear_buddies(cfs_rq, se);
>
> --
> 2.28.0.709.gb0816b6eb0-goog
>
