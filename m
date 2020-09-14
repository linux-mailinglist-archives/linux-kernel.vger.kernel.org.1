Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 680AD26910F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 18:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgINQGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 12:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgINQEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 12:04:04 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3DEC061788
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 09:03:38 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id z19so14031944lfr.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 09:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IV/LGfYBD2Y8emqFam5XyX3wpoNSeeY/CKtIn8gQg6I=;
        b=UfoqPWpkcfltK4Qgb4pE5DCSyHsfqGzEJkWK/hRJRcK+CkuOMABdsALEdi18ZzSabw
         U1tTkHjtehSsRpB+fQXpvDsUuY6EhYWl+H7FhEqHg5P0qKYdefzShPtxPN52WSJMb/Tb
         VDNhLX/ZeYsItUjVyLgyDIGKx6kMyyl+Jzew/lTARt1KyVx7+PoguMFqhRPm6Ead2XeN
         etprwLuPm6zpWx3DouO3T+PW31f509E023CS/6NedKGSfQ6qK2rqmgWdtMl5yHY4lG59
         tBBsgarndPizkIbXOCloHf/6ChULFsIkyPXVHoF0U+VGNViv4ft2qhrvpwULlptTYccA
         HdJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IV/LGfYBD2Y8emqFam5XyX3wpoNSeeY/CKtIn8gQg6I=;
        b=Wz/segoeKupbfInJkr5KO3yMct8cZxIVpT5+xOyKN1+kLv8HViP2KRX2CD0/sAhRvE
         zqUBfHf926t2V8vBmWXMvjP8KPYMxivlKh6JziTy2KZiPOP+TDRaGE6MbDAo6lRfMWTX
         wLQBVi2MNGQiJ1Bq4/03yozEgn4H8iyRIiDusSUgqRTy9Q26Pr04cbKq1KqKc3bB0EYf
         f0jVssQEeK3780HX6Lz5TYd2QCwhGFPEhwVTkZZXGfVCdAy4roABsv+wZL1VesQxJ8T6
         RUzLzkgV3VueYyR9JAyt5MU5mijdgSZ4Xuz4U59GwrfLidwZ47HXZvKhxdE59XbnZ+3v
         TZ8Q==
X-Gm-Message-State: AOAM531ZNc83FFmdVW3RuxSF840PCKI+QvhGC1eqNjVyFGgiozfVmuxR
        gPQ5NUFS85OMRIjYa3krvLHr+uduJie/xidgFm26XA==
X-Google-Smtp-Source: ABdhPJw57Db/MGCZ6wTHAbCnr9PzbJr9Bn/oR1+stOVy2ZcF0xLKtL3zRw0bsuiboO+cgQhUVzbqaCuv9JXnGosoz0Q=
X-Received: by 2002:ac2:43c2:: with SMTP id u2mr4453170lfl.573.1600099416756;
 Mon, 14 Sep 2020 09:03:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200914100340.17608-1-vincent.guittot@linaro.org>
 <20200914114202.GQ1362448@hirez.programming.kicks-ass.net> <20200914125309.GA4008@lorien.usersys.redhat.com>
In-Reply-To: <20200914125309.GA4008@lorien.usersys.redhat.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 14 Sep 2020 18:03:23 +0200
Message-ID: <CAKfTPtAbR62JTHteLrSSkpqX9QuTuzTjGSYDqcZsmqv0_t_4BA@mail.gmail.com>
Subject: Re: [PATCH 0/4] sched/fair: Improve fairness between cfs tasks
To:     Phil Auld <pauld@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Sep 2020 at 14:53, Phil Auld <pauld@redhat.com> wrote:
>
> On Mon, Sep 14, 2020 at 01:42:02PM +0200 peterz@infradead.org wrote:
> > On Mon, Sep 14, 2020 at 12:03:36PM +0200, Vincent Guittot wrote:
> > > Vincent Guittot (4):
> > >   sched/fair: relax constraint on task's load during load balance
> > >   sched/fair: reduce minimal imbalance threshold
> > >   sched/fair: minimize concurrent LBs between domain level
> > >   sched/fair: reduce busy load balance interval
> >
> > I see nothing objectionable there, a little more testing can't hurt, but
> > I'm tempted to apply them.
> >
> > Phil, Mel, any chance you can run them through your respective setups?
> >
>
> Yep. I'll try to get something started today, results in a few days.

Thanks Phil

>
> These look pretty inocuous. It'll be interesting to see the effect is.
>
>
> Cheers,
> Phil
> --
>
