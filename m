Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6C082EC09E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 16:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbhAFPqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 10:46:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbhAFPqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 10:46:33 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A2EC06134C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 07:45:52 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id x20so7417231lfe.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 07:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9FLdjT3qpvgs+ARQgDcCR59/xZGNey7AbW0WtCFjj5M=;
        b=ObrmMR3xSJOLxQI2zkDI/seXDUFv7mKldN0Bx+lyeaezeDzJvkWtegrcItOvT+NieP
         WYM/EuddizUFJL1tvPU+50qFC52uhhWyrEpjgfKAjq6vsQ21q0poOamLfj9Wo7I2Qt72
         DcdoXmtEZX1HKYOWtzuzrXDBC3kY0A4MEXfLbLBwYhpNb0f768wpYnFgQKh1FaI6FcyP
         2lgYxZBxOAwHAIqbmhaUeP5Jy++yCE9q4PhVof5XgMVHgOJ/aEe2u+CPh7Rp25KH2uF0
         dFhOFfLIKUWQWFBTFNGaZh2fGoVuPtUARutmMm2Z7Qp1mYXl1C11SvARw+hYG6STlR4l
         PK/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9FLdjT3qpvgs+ARQgDcCR59/xZGNey7AbW0WtCFjj5M=;
        b=AGk7Uv9kuWMS4pd1zghijn7ypj/AG2vlBz6pKgOHKWQ7Z4hb/1cXn14rk1pZNUtseT
         orLMTAQG8j6dOuT2q5F4+tnJFbAuARkKRGwUpZY5Ve4I7cobORN4Zizm/FlrNrJNiNp/
         lD6ShsIZF8lQErEZZDyGKbQNxLvnpLpHU4Hw8mJgMNMuyNrAXBB/3wlqWdaXGhw4qEoC
         TC6VjoXpYKSkkbMQeT3xcuVHsCVEEr7GGXg6OR5zn/pwDNAgVIQ6MC8yBDUTEvyz2RIS
         XvZ9LYeuFapm+iNBkJOJiAq7bcvA4KOt51yqj2v68Xvjm7EIFhMRTxdiD7GpsTyPfIl/
         ToyA==
X-Gm-Message-State: AOAM530X8y00M+aI/LgkzL5jmvGeHDqN+Sndz0ClhXLEr5Skpzm04Ra6
        e0VMDeX8seKWcArPw4SU45nltCnMs+CwIWK4P9UfcA==
X-Google-Smtp-Source: ABdhPJx7fj09yrfG6xdeQ3fTny0Lx0V6kd+1bTIz+wkkbU668wA9q9qvM/NNif736oxVUr+zExFNlOEtscWcB3CSDc8=
X-Received: by 2002:a05:651c:20b:: with SMTP id y11mr2132317ljn.176.1609947951068;
 Wed, 06 Jan 2021 07:45:51 -0800 (PST)
MIME-Version: 1.0
References: <20210106133419.2971-1-vincent.guittot@linaro.org>
 <20210106133419.2971-3-vincent.guittot@linaro.org> <X/XSH7Qv58pSpi95@hirez.programming.kicks-ass.net>
 <CAKfTPtB+Nrk6ST9c-OacdW3zh07VC6M8GqvgNXzQ=KqucBrqQQ@mail.gmail.com> <X/XYHxPtGFhJe+bu@hirez.programming.kicks-ass.net>
In-Reply-To: <X/XYHxPtGFhJe+bu@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 6 Jan 2021 16:45:39 +0100
Message-ID: <CAKfTPtDuTcP0MnW2YVDWy88ms=aWPbk1-0vFqdkvRU4PVi9qBA@mail.gmail.com>
Subject: Re: [PATCH 2/3] sched/fair: don't set LBF_ALL_PINNED unnecessarily
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jan 2021 at 16:32, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Jan 06, 2021 at 04:20:55PM +0100, Vincent Guittot wrote:
>
> > This case here is :
> > we have 2 tasks TA and TB on the rq.
> > The waiting one TB can't migrate for a reason other than the pinned case.
> > We decide to start the active migration on the running  TA task but TA
> > is pinned.
> > In this case we are not in the all pinned case.
>
> But then can_migrate_task(TB) should clear ALL_PINNED, no?

Yes but current code sets ALL_PINNED when the active migration failed
because the running task is pinned whatever there is not pinned
waiting tasks that has not been selected
