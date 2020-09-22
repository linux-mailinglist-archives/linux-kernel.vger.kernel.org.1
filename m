Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDF8274A20
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 22:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgIVUaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 16:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgIVUaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 16:30:18 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89062C0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 13:30:17 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id nw23so24674792ejb.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 13:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QgGt03GMUbG4cqcAoBKuhhh4ICPK+b3ZY93NZCOhnJc=;
        b=ZoRfMp/eKIXARa2XkW3UpwazOH/ATAFSfzlgmzXWQIw767GhF2po5vLBXfhGLrMo0y
         b3m5mFnf7nvNb7cBnQ+fISTpGRdCVjQey+TUkT4ZGIDWrkVmXu8sAoSV607TbWlByf2+
         5isz0n9hF3s+Wo+VkkFoldD7suTs/DIMsE/rPboHt06FD9AmZ6gGvz5dy5yIARKRmkNQ
         X+00i6l4sar2GDS/dnuUCVQrXjV7fyGKCqGL5JtH0yQCtlUA8Ln6KFTXsWSIVBlAa32c
         wS1yFzgrsAM/Bch572WFtGCYVSppKN4Th0rlXTuHzAzm/aq1gJElN8kUJ4Iq87rzduHq
         FIcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QgGt03GMUbG4cqcAoBKuhhh4ICPK+b3ZY93NZCOhnJc=;
        b=FkO3kThrneev/MZvbJEhXGuxcV2s2efEPkX3mVfOlOKvheNFvLzJ9G0GAnG49PdBk7
         FmYTNKYpjN74Aezx8OjsIZhFQ8OtGpEiVg5OIY1tvP92P8ciTAG/z2UF8YQLgs302pis
         SBSa/O9j6bG6ZfYXtjSZE9XV2yP00zX5ihiMor8EAiX0vXs5qK8luIe7Gd/F0xfj3BlM
         zkzjTg+RU6D5MErtzcnqf9ZY1jRR3kmrDwMdfyG+iIUY/LB+qf27PQmYyQcbbrup3Hj7
         dJpVYXZXH9hcBxqBwqn+i78ZzeSqANePyBCXUsLw/Toa29Vxtvk8QVO2aPnMf2W/wW0g
         UtVw==
X-Gm-Message-State: AOAM532Kp2a35VENAZ/3VjtokxMyYsDHOsSzLXISQBPaDKx7s9ecEEiT
        PNwwMVsaqdbz503YqUaoMUCthLije08BgGsXElxLXQ==
X-Google-Smtp-Source: ABdhPJxRcphxBvEj3w63KU11IklHQU74ZeD9v+juAKQteu0Wg58apooauheK10N8gUkmhoCVY1ZtI1UGQx5M0Ah0ygk=
X-Received: by 2002:a17:906:c045:: with SMTP id bm5mr6614770ejb.311.1600806615934;
 Tue, 22 Sep 2020 13:30:15 -0700 (PDT)
MIME-Version: 1.0
References: <b776ab46817e3db5d8ef79175fa0d71073c051c7.1600697903.git.bristot@redhat.com>
 <CAGXk5yp4ubupTKDg1s+ZbK3cj_aKh9pQJzshWoZ3CvqnQLJX=A@mail.gmail.com> <64eca989-f2e7-033f-bb49-084f27c7209b@redhat.com>
In-Reply-To: <64eca989-f2e7-033f-bb49-084f27c7209b@redhat.com>
From:   Wei Wang <wvw@google.com>
Date:   Tue, 22 Sep 2020 13:30:04 -0700
Message-ID: <CAGXk5yq_fWJ822m16-XstU41wV2LBiy-KdUU7c9QnPtL2qsdMg@mail.gmail.com>
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

On Tue, Sep 22, 2020 at 12:04 PM Daniel Bristot de Oliveira
<bristot@redhat.com> wrote:
>
> On 9/22/20 7:14 PM, Wei Wang wrote:
> > On Mon, Sep 21, 2020 at 7:40 AM Daniel Bristot de Oliveira
> > <bristot@redhat.com> wrote:
> >>
> >> The RT_RUNTIME_SHARE sched feature enables the sharing of rt_runtime
> >> between CPUs, allowing a CPU to run a real-time task up to 100% of the
> >> time while leaving more space for non-real-time tasks to run on the CPU
> >> that lend rt_runtime.
> >>
> >> The problem is that a CPU can easily borrow enough rt_runtime to allow
> >> a spinning rt-task to run forever, starving per-cpu tasks like kworkers,
> >> which are non-real-time by design.
> >>
> >> This patch disables RT_RUNTIME_SHARE by default, avoiding this problem.
> >> The feature will still be present for users that want to enable it,
> >> though.
> >>
> >> Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
> >> Cc: Ingo Molnar <mingo@redhat.com>
> >> Cc: Peter Zijlstra <peterz@infradead.org>
> >> Cc: Juri Lelli <juri.lelli@redhat.com>
> >> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> >> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> >> Cc: Steven Rostedt <rostedt@goodmis.org>
> >> Cc: Ben Segall <bsegall@google.com>
> >> Cc: Mel Gorman <mgorman@suse.de>
> >> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> >> Cc: Thomas Gleixner <tglx@linutronix.de>
> >> Cc: linux-kernel@vger.kernel.org
> >> ---
> >>  kernel/sched/features.h | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/kernel/sched/features.h b/kernel/sched/features.h
> >> index 7481cd96f391..68d369cba9e4 100644
> >> --- a/kernel/sched/features.h
> >> +++ b/kernel/sched/features.h
> >> @@ -77,7 +77,7 @@ SCHED_FEAT(WARN_DOUBLE_CLOCK, false)
> >>  SCHED_FEAT(RT_PUSH_IPI, true)
> >>  #endif
> >>
> >> -SCHED_FEAT(RT_RUNTIME_SHARE, true)
> >> +SCHED_FEAT(RT_RUNTIME_SHARE, false)
> >>  SCHED_FEAT(LB_MIN, false)
> >>  SCHED_FEAT(ATTACH_AGE_LOAD, true)
> >>
> >> --
> >> 2.26.2
> >>
> >
> > Tested on an Android device and can no longer see long running RT
> > tasks (yes, Android have those for reasons).
> >
>
> So:
>
> Tested-by: Wei Wang <wvw@google.com>
>
> ?

Yup, thanks for pushing this.

>
> Thanks!
> -- Daniel
>
