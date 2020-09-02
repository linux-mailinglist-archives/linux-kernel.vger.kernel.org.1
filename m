Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10C2E25B081
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 17:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgIBP7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 11:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbgIBP7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:59:33 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06831C061245
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 08:59:33 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id z46so1731541uac.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 08:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fSVTGChONR42B9tckVRMTcJUXLI684oSkll8jndZM5g=;
        b=mfvdRHZOALR5zjzvD5e3TBVZy2DnHr7r9yWpIixO35qNoqAYhvUTt3RZH6kWCJ+E/Z
         UG4UuICCKIdcrC7GCuXY1pn6T8/oUBlGAxUQlkMG0s7EhK967+j0g6eDKTiaLY/x0WHO
         NejvBnwPcLn1B60Yl3Cs6PcbByoY3u3eY5GYz7xkA2SLtJEYK67i7hDbQx423+ez5fA1
         8Fam1zozYHtcmoiVCnhhV+/HkYHVV1zoxNvTzI41vuy7pOV9zKchtaKTDVnz7eUO1ip0
         p9/wVUlbQNu+4PIJcuJmdOiWWCiGOshC4pigJGdOld2a/8DaRepLrnerBAPf8BtRcGBj
         8EIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fSVTGChONR42B9tckVRMTcJUXLI684oSkll8jndZM5g=;
        b=g1WeQQPBkiQjiORnI7nbbLIOP9eSFBlZngC4GWxLP5LffhLkiNBkpi2Dce5gINJRVj
         vDyUB1AnSmO/Wr0DMiQukj44nj+2roKAqo2m5fhSVEjX3baCAisMM6Lju7wa0LNf1ms3
         tU2qYbogppC2hFpAT1kqFX+V8tRoGtdBAMkr93ntacAG0s2gteIjZ+Sb79qMm3lbT7W4
         ZlH39/RUAJ3h4O4Qgg6hgHYMLFP/C+d/nm940rkgL+4vHaW6Ed+OdPdw2YzCtYl8pGVt
         Zph3TwE7MQKlJkC/Zbkk+bmYRHBT7/qDg46VNGXJO62UWqSFyrrfGbu3gh0Lw0BtqQbf
         Sdew==
X-Gm-Message-State: AOAM533InxeAN6jkjHV5bDg+mBq6yTd8BNQ1YC5wWpwXnM6oySZmIgtW
        2zwYifmBX1bXwOyRJKpVLfvfmPI/b7qED7KR0XiXKw==
X-Google-Smtp-Source: ABdhPJwqUlTtC+lVo+5XX9eb9FGE+8fkPT51Z05tLTdsd7VJj6u/GOU747Va6WqvAJl+GIm84nJ+dv3rnXOEOFe9+8s=
X-Received: by 2002:a9f:2722:: with SMTP id a31mr5858584uaa.100.1599062371534;
 Wed, 02 Sep 2020 08:59:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAPDyKFq7KWo=4VmPhgrt7vEEQ_P6NdVgQp+MO_1cg1dtoVR_Fw@mail.gmail.com>
 <CAPDyKFrTERjpLrPOFtkqLyNsk2T_58Ye2FQ1mPf-0u78aWW=Xw@mail.gmail.com>
 <20200901104206.GU1362448@hirez.programming.kicks-ass.net>
 <CAPDyKFo0VkW-cgRSkvPQ0whpuJCo4OKcL1nmH7nz1tDEChOtVg@mail.gmail.com>
 <CAPDyKFrv+DTF8=twZZk_tenB-sLg6H-CFn9HVDVA5S2kK2=U5Q@mail.gmail.com>
 <20200901154417.GD20303@codeaurora.org> <20200901155014.GF2674@hirez.programming.kicks-ass.net>
 <20200901161340.GC29330@paulmck-ThinkPad-P72> <20200901174216.GJ29142@worktop.programming.kicks-ass.net>
 <CAPDyKFqPh7bg16AsitGv2QQHgwOPnWx9DiPPCMuD1EGA5TFFdg@mail.gmail.com> <20200902121355.GE1362448@hirez.programming.kicks-ass.net>
In-Reply-To: <20200902121355.GE1362448@hirez.programming.kicks-ass.net>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 2 Sep 2020 17:58:55 +0200
Message-ID: <CAPDyKFrGj+8hOXi7sWxWNv2QP0=mx9pFKLG0JM-L5VNKUPDgeA@mail.gmail.com>
Subject: Re: WARNING: suspicious RCU usage - sdhci-pltfm: SDHCI platform and
 OF driver helper
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Saravana Kannan <saravanak@google.com>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        lkft-triage@lists.linaro.org, rcu@vger.kernel.org,
        Linux PM <linux-pm@vger.kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        madhuparnabhowmik10@gmail.com,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Sep 2020 at 14:14, <peterz@infradead.org> wrote:
>
> On Wed, Sep 02, 2020 at 09:03:37AM +0200, Ulf Hansson wrote:
> > Lots of cpuidle drivers are using CPU_PM notifiers (grep for
> > cpu_pm_enter and you will see) from their idlestates ->enter()
> > callbacks. And for those we are already calling
> > rcu_irq_enter_irqson|off() in cpu_pm_notify() when firing them.
>
> Yeah, that particular trainwreck is on my todo list already ... then
> again, that list is forever overflowing.
>
> I'm thinking cpu_pm_unregister_notifier() is not a common thing? The few
> I looked at seem to suggest 'never' is a good approximation.

The trend is that drivers are turning into regular modules that may
also need to manage "->remove()", which may mean unregistering the
notifier. Of course, I don't know for sure whether that becomes a
problem, but it seems quite limiting.

>
> It would be fairly trivial to replace the atomic_notifier usage with a
> raw_notifier a lock and either stop-machine or IPIs. Better still would
> be if we can get rid of it entirely, but I can't tell in a hurry if that
> is possible.

Okay, let's see.

In any case, I was thinking that the patch with CPU idle flag, for
letting CPU idle drivers deal with RCU, that you proposed, seems like
a good first step.

At least it should enable us to solve the problem for runtime PM in
psci_enter_domain_idle_state(). Let me update the patch and send it
out, then we can continue the discussion over there.

Kind regards
Uffe
