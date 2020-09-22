Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB91927474E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 19:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgIVRO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 13:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgIVRO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 13:14:59 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA27C061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 10:14:59 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id p9so23980367ejf.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 10:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FCB8/UUy9VS3y1rHu2BlRYxDE5tqX0eaDh3WAOiXdLk=;
        b=RlvfFkqqbFrqJgVzZEGyTFbmaB64Xz+XbrLGjbboccH85DNkNlNw/wrqYtwA2lCxy9
         ooFteMZaC+YR+ENIIzfQNy63SYiyE0t6jdLghHyA393mHithCOKYl7Q1sY3pSOy8C93a
         nCxP+XvLjfQsLpkm10MPCGNSIJdsaIPPV96tQEDRdByC4/Igm5AcAI1G8YhXIwqts5cE
         liQWcqX/tZxRLQcL5NDnidz/uhUaEh55Nu9BW7MDI0Wbqb8QlUlIuJgfiVVA+E0Gy5Gb
         5jXeyi3E3gijGmltiZwcjzAatDneTJMhwghEqCM6o6C5owngo7RJqGDaewd0AWh2zk7v
         ASSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FCB8/UUy9VS3y1rHu2BlRYxDE5tqX0eaDh3WAOiXdLk=;
        b=IE7ma6o2caEDcz7yOmV49s0TTnMl7xVnkMDvjZR0ZhyozpjiwqcznyydlYG+kDSvAp
         L6N9e/mEuPYAVTz7wxRgRECANg8ge1vBgCXyM65JuhFOFn3pxiWUWYgKi+LJJMGHYwJp
         mFSykMfUgGJhDMmrUE9p4zlvWq+neKbVZunEQg1WkbLWyw/HrWsmkOT9GDV/l4/v6tFM
         G1FaBT0rJRwteV4CNVBgb8qTD+CFTkImdhD/t9fKWYhyObs71HzIvpnYaSQRzbyxyrQ8
         I1nQ8vWSO+2wprbseC/B3CZATvbDaFB2Vz/D699vZIogh6h2I2r6ZodhGq7m5MSvgaX5
         +l/Q==
X-Gm-Message-State: AOAM533hXqfJi0eyyc+G6GrgGrz+H5RY1gqUsa/3XUdMtPeJEB3BPkLQ
        zM9AEu8zN99GBBZ+VQg8EJdsF++MK/GZ93NE0jDqwEu3+UJb4A==
X-Google-Smtp-Source: ABdhPJxF3iSxEfTk+J1A+p64JVFefof3UfEUiDV8QrtOWH5uIhHYCelg5zQ1n4Y7md9joh2sCEBc5nXNbqWK7mZbw4g=
X-Received: by 2002:a17:906:cc99:: with SMTP id oq25mr6221710ejb.292.1600794897483;
 Tue, 22 Sep 2020 10:14:57 -0700 (PDT)
MIME-Version: 1.0
References: <b776ab46817e3db5d8ef79175fa0d71073c051c7.1600697903.git.bristot@redhat.com>
In-Reply-To: <b776ab46817e3db5d8ef79175fa0d71073c051c7.1600697903.git.bristot@redhat.com>
From:   Wei Wang <wvw@google.com>
Date:   Tue, 22 Sep 2020 10:14:46 -0700
Message-ID: <CAGXk5yp4ubupTKDg1s+ZbK3cj_aKh9pQJzshWoZ3CvqnQLJX=A@mail.gmail.com>
Subject: Re: [PATCH] sched/rt: Disable RT_RUNTIME_SHARE by default
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "J . Avila" <elavila@google.com>, Todd Kjos <tkjos@google.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 7:40 AM Daniel Bristot de Oliveira
<bristot@redhat.com> wrote:
>
> The RT_RUNTIME_SHARE sched feature enables the sharing of rt_runtime
> between CPUs, allowing a CPU to run a real-time task up to 100% of the
> time while leaving more space for non-real-time tasks to run on the CPU
> that lend rt_runtime.
>
> The problem is that a CPU can easily borrow enough rt_runtime to allow
> a spinning rt-task to run forever, starving per-cpu tasks like kworkers,
> which are non-real-time by design.
>
> This patch disables RT_RUNTIME_SHARE by default, avoiding this problem.
> The feature will still be present for users that want to enable it,
> though.
>
> Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-kernel@vger.kernel.org
> ---
>  kernel/sched/features.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/sched/features.h b/kernel/sched/features.h
> index 7481cd96f391..68d369cba9e4 100644
> --- a/kernel/sched/features.h
> +++ b/kernel/sched/features.h
> @@ -77,7 +77,7 @@ SCHED_FEAT(WARN_DOUBLE_CLOCK, false)
>  SCHED_FEAT(RT_PUSH_IPI, true)
>  #endif
>
> -SCHED_FEAT(RT_RUNTIME_SHARE, true)
> +SCHED_FEAT(RT_RUNTIME_SHARE, false)
>  SCHED_FEAT(LB_MIN, false)
>  SCHED_FEAT(ATTACH_AGE_LOAD, true)
>
> --
> 2.26.2
>

Tested on an Android device and can no longer see long running RT
tasks (yes, Android have those for reasons).
