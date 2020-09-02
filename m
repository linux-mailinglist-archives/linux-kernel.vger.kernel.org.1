Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEA1E25B0B6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 18:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbgIBQHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 12:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbgIBQHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 12:07:42 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A14C061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 09:07:42 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id j188so38947vsd.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 09:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sjV9Jb8EPkuY+LUkD8oQXrSyG4zZSwVPneOyWtPHv1Y=;
        b=AGlSn8KNdoY1ggi8QhNqyiqUGMvBUhOwy832NYNWdSKgrH1FW6FMAvFtsyfEoh1N94
         C/VkOtij1OeWyh4fAycHoRGF7V6tKnxu+t7oddOwHYicPsK7WoKZDVbsCazpWVhNArnX
         eLxzWcYFZT6MCOq7DpCoRJM4y9Y6kiW/0w2T3qQ8QxpAo6U2Q9oXnNhyQro1hmx89XNK
         2vjVGmo5a/K+LOF1pv7/UABCuKFJk2PC9K3SvqNJqrYAHU8fD2AM215WT2bVZ1ieTteB
         9iGL2Vapvx0VDl9PuSOoB/oWSmq5AwobXDeow538ctLBXc/Fk8kxVnytgxbnAnJG+6vV
         RzyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sjV9Jb8EPkuY+LUkD8oQXrSyG4zZSwVPneOyWtPHv1Y=;
        b=Cl07hRKpNmnc0A3RhT1pAxSJJWh2ubBrR+u00RY4Pj+iXA/OJsM0aHgXCE4r5rzZFL
         JsYSpHHDWdftBShjIKQ64ZzB6GRGeabQpyfu0X5uoN4tLuNFWig2rYNNQhLnlYiK8OzZ
         xponn9ar42PirwRqlokExScqbz7VNqqKtzDh13hMKudZ9DRT7FLfjA0P2OQViQaaWhRY
         SF07a91fhEbw5pYAtXQUrD4OvZyJv4Z4c2kt4CpsYL7UiezID+6syJ8EmltKd6oUVELm
         HDGxN2Xn8lcnOxUxgGa542NeRqmQSw5Thj5TVzBdCqyKc54NmvTb5BUZRbPBdH25qT1m
         7jaA==
X-Gm-Message-State: AOAM531qbRADFOkSj3cDecOcwc/g7Bs+kIRTKozLLeNlolrafIcJtDRD
        AAx/GbMTfuPEc7FbnakvSsVoNmPON+m/mIHfXgC7Gw==
X-Google-Smtp-Source: ABdhPJy3G2uK8eBUBRQTkok/IvBwsXbzoK5iYOysUYXi+23NQGr/PHw9BnkDjjPcjFwd+TyxVliznfFAxwwe8KbXWLE=
X-Received: by 2002:a67:7c4e:: with SMTP id x75mr5782487vsc.60.1599062861296;
 Wed, 02 Sep 2020 09:07:41 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYuiJwN1ad955Xw4ShamX2=373r+56KsbpeverEs+i_NAg@mail.gmail.com>
 <20200831194402.GD2855@paulmck-ThinkPad-P72> <CAPDyKFq7KWo=4VmPhgrt7vEEQ_P6NdVgQp+MO_1cg1dtoVR_Fw@mail.gmail.com>
 <20200901150047.GB29330@paulmck-ThinkPad-P72> <CAPDyKFptZK-OqnAuJYGnpfPbZ1qw-iSd4t5SuE7SmWic=ms48Q@mail.gmail.com>
 <20200902135202.GG29330@paulmck-ThinkPad-P72>
In-Reply-To: <20200902135202.GG29330@paulmck-ThinkPad-P72>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 2 Sep 2020 18:07:05 +0200
Message-ID: <CAPDyKFqAAjCDSSJ56V+cdy6t0F01sXj_AkNxdXRtAKegf8DDsQ@mail.gmail.com>
Subject: Re: WARNING: suspicious RCU usage - sdhci-pltfm: SDHCI platform and
 OF driver helper
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Saravana Kannan <saravanak@google.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
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
        peterz@infrdead.org, Lina Iyer <ilina@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Sep 2020 at 15:52, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Wed, Sep 02, 2020 at 08:49:11AM +0200, Ulf Hansson wrote:
> > On Tue, 1 Sep 2020 at 17:00, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> [ . . . ]
>
> > > Here is the list, though it is early in the morning here:
> > >
> > > 1.      RCU_NONIDLE().
> > >
> > > 2.      Peter's patch, if it turns out to hoist your code out of what
> > >         RCU considers to be the idle loop.
> > >
> > > 3.      If the problem is trace events, use the _rcuidle() variant of the
> > >         trace event.  Instead of trace_blah(), use trace_blah_rcuidle().
> > >
> > > 4.      Switch from RCU (as in rcu_read_lock()) to SRCU (as in
> > >         srcu_read_lock()).
> > >
> > > 5.      Take Peter's patch a step further, moving the rcu_idle_enter()
> > >         and rcu_idle_exit() calls as needed.  But please keep in mind
> > >         that these two functions require that irqs be disabled by their
> > >         callers.
> > >
> > > 6.      If RCU_NONIDLE() in inconvenient due to early exits and such,
> > >         you could use the rcu_irq_enter_irqson() and rcu_irq_exit_irqson()
> > >         functions that it calls.
> > >
> > > Do any of those help?
> >
> > Yes, they will, in one way or the other. Thanks for providing me with
> > all the available options.
> >
> > BTW, I still don't get what good rcu_idle_enter|exit() does, but I am
> > assuming those need to be called at some point before the CPU goes to
> > sleep.
>
> These functions allow RCU to leave idle CPUs undisturbed.  If they
> were not invoked, RCU would periodically IPI idle CPUs to verify that
> there were no RCU readers running on them.  This would be quite bad for
> battery lifetime, among other things.  So the call to rcu_idle_enter()
> tells RCU that it may safely completely ignore this CPU until its next
> call to rcu_idle_exit().

Alright, thanks for explaining this, much appreciated.

So in one way, we would also like to call rcu_idle_enter(), as soon as
we know there is no need for the RCU to be active. To prevent
unnecessary IPIs I mean. :-)

Kind regards
Uffe
