Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6340E24BCB8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Aug 2020 14:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729673AbgHTMvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Aug 2020 08:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728981AbgHTMvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 08:51:19 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED19C061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 05:51:19 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id j22so877563lfm.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 05:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jbR4Pr9PsKUZJNbETq29ZnQQtrCssVvEEQi3ARZG9nQ=;
        b=NSQ0BROBMUCayc3T1MEpDkx4BHFB0Fa2GAnXsMWQfpc9Mxm8RXXYi5lIXrgPw4T8gp
         RrcHrHqBxLMy+phmJVsyJet4JVoixJY1EjWaOcUoJvARS+Kogk3jxHOvaOiTFiBv3ON2
         bYGM6rcx03city4YXeyfQ/Exg15Ql39gfEj/ZVmi7IgGGQahzsKTrbDi5x4T57w0PULJ
         ImKs6d/eNQvxJatm0TZRsDK7swAfzws9tQp49r7cjdcJqKeVXudGfcWJKNPJE04EuSDR
         jrUdNU0I6aCSVwBAtlNxgXAcPQN8HKPWpaKgNeHj0JneqqX0ENOv2kTcp+zf8bHyK1UC
         pdbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jbR4Pr9PsKUZJNbETq29ZnQQtrCssVvEEQi3ARZG9nQ=;
        b=HiLXEMQNUYFwapVkgijfkDyrywfUFrXHjhdx+xWCvpD2dsm/dN0D/sUa8NPN0TCR9I
         IPSFl2/WMKC2MLcLwH9g7Cv5ojbNcDJXaMG3RMMe8FD9/+YswvLeiL4n8db9Ml132LiO
         Wcl+Bhy+6MXtnxXXsgA8xMvMw2rG6V17CAeGSlsdclRU1gfMoeBYABcHThIAGWEkHXUM
         U6fYEXWD3GEngHxIe+kZD93Sp8eO0U+HGRBdXcJPp2nbMqDjIK1j9n8X/Tr/gtLX1e3k
         2kQ7DnNJlynNxCoxuKIOwPkho5HJe7ULVO6sDK75nrDJ2efcDsPDanjk6hGfGBv5C5V/
         kaPA==
X-Gm-Message-State: AOAM531iLxxKN+NuQ0Jr4CfvtcFxXpP8bSW+VDzTPrTAwFsZ88VJu9b3
        3gGATHgL/wJ1gIo5XbO4ll//wcM12O/UmJEg2K6a3g==
X-Google-Smtp-Source: ABdhPJyEfF3Cf/9HBpWEcyPwTPo5dMAoeC6NBCQNEMnYl5vYAY5FrV4DpuBgxEshfquiH7b1BGXzndIiHYrezc8JbBQ=
X-Received: by 2002:ac2:42cd:: with SMTP id n13mr500476lfl.190.1597927877625;
 Thu, 20 Aug 2020 05:51:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200820120025.74460-1-benbjiang@tencent.com>
In-Reply-To: <20200820120025.74460-1-benbjiang@tencent.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 20 Aug 2020 14:51:06 +0200
Message-ID: <CAKfTPtABCbEuYf3uup5ZODyPXpUqBjgM8A5gBQqM0cQGxWk5zw@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: avoid vruntime compensation for SCHED_IDLE task
To:     Jiang Biao <benbjiang@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiang Biao <benbjiang@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Aug 2020 at 14:00, Jiang Biao <benbjiang@gmail.com> wrote:
>
> From: Jiang Biao <benbjiang@tencent.com>
>
> Vruntime compensation has been down in place_entity() to
> boot the waking procedure for fair tasks. There is no need to

s/boot/boost/ ?

> do that for SCHED_IDLE task actually.
>
> Not compensating vruntime for SCHED_IDLE task could make
> SCHED_IDLE task more harmless for normal tasks.
>
> Signed-off-by: Jiang Biao <benbjiang@tencent.com>
> ---
>  kernel/sched/fair.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 1a68a0536add..adff77676a0a 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4115,7 +4115,7 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
>                 vruntime += sched_vslice(cfs_rq, se);
>
>         /* sleeps up to a single latency don't count. */
> -       if (!initial) {
> +       if (!initial && likely(!task_has_idle_policy(task_of(se)))) {

What if se is not a task ?

>                 unsigned long thresh = sysctl_sched_latency;
>
>                 /*
> --
> 2.21.0
>
