Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 289632AD802
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 14:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730903AbgKJNta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 08:49:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729898AbgKJNt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 08:49:29 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8947C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 05:49:28 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id y16so14731821ljk.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 05:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/akY3fmzxlOQpb/xXNZ2EfrP9sBdfmmjYx8WXHIVrzE=;
        b=IVdx9gGkEwEsPe2TYccQ9CvLGJHuSy4OVQdNLkn+7t4D+hdmJnB8FF48GrGL2k+LwD
         pbDuWWQ7NAueMf4JNwGM0iPc7tiwTJaPlvQ++mfWGNY6ydIFlb+TdtPs/kY4FU04KzjQ
         Um86cqk0FExodWng8NYcLU6F/ZUbKdpUHlA86+IGsYeNb9LFO4PSOM9CEkBQwOkeIdDr
         rFPW/rQfnjXipOIAMopajI37B10slFGF7i7CBhzC4BNdU1kjsixxVQaDonnHnustcC8M
         jnW8Lx1dGSMCXtLwvxaOwC4Fqs0yKlLgHYGzzoaexPRsAT3hvK+8TKCP2PnKMuVTnOQt
         oPPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/akY3fmzxlOQpb/xXNZ2EfrP9sBdfmmjYx8WXHIVrzE=;
        b=IcihgHHoET6UsG38imrXVTNpJPd0Bj4qqrTx5KdG/Uwno3sTgbc83Ez15eB4W85e8E
         7ceKjOpFLfX1diCazoPIJFdvfquOSZm1g/mblTZHPnAgN+lsyn7HAhMMaY3qTBX3YOeb
         ff2axb3njWKOl4trLTXLS51smGJe0h6OxxQtrjoA4TXjdBiJHnXw4ck5DSH11qcNYkT+
         LkK70IFzxQNVQqvYyFdYRLtlen0+KhGrA/v5dXAA4Q9bhnUjlR303CRtWle5tEa1zERF
         KgWKD5C9wz/lLHZx/kE+XeKyfrvgsU0eQtYl2ZzAVZP2BdZuDSPZZ3P0A7DfLtX96Mql
         KqSw==
X-Gm-Message-State: AOAM533A+s8tqMNMnvbu4taipEiQUQfaXNxeCNZS3M/9KwnGY0IEEzLv
        Ip0X8MNtW+0TBjIgks9GcIV80TCkOS397HcVBj1sLA==
X-Google-Smtp-Source: ABdhPJzjZYrZYBKq0usq65yI11ZmwCqnjW++Ov5otvw7PaTILCooF14qyb1xLx1xuYXOeHIvD/XmQaIrAwrQzr/2Bf4=
X-Received: by 2002:a2e:7803:: with SMTP id t3mr7800194ljc.156.1605016167130;
 Tue, 10 Nov 2020 05:49:27 -0800 (PST)
MIME-Version: 1.0
References: <20201110134101.434928-1-arch0.zheng@gmail.com>
In-Reply-To: <20201110134101.434928-1-arch0.zheng@gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 10 Nov 2020 14:49:15 +0100
Message-ID: <CAKfTPtD_SKKWTr=Q7Y83XQ_BG7ptSDgB1=jOsfcczXULhae5sQ@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Remove the redundant critical section
To:     Qi Zheng <arch0.zheng@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Nov 2020 at 14:41, Qi Zheng <arch0.zheng@gmail.com> wrote:
>
> Now there is nothing in the critical section, so remove it.

https://lkml.org/lkml/2020/10/30/689

>
> Signed-off-by: Qi Zheng <arch0.zheng@gmail.com>
> ---
>  kernel/sched/fair.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 52cacfc62922..06c4f3430e95 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5114,9 +5114,6 @@ static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
>                 return;
>
>         distribute_cfs_runtime(cfs_b);
> -
> -       raw_spin_lock_irqsave(&cfs_b->lock, flags);
> -       raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
>  }
>
>  /*
> --
> 2.25.1
>
