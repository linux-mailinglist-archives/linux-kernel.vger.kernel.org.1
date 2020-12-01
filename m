Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE502CAFEE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 23:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgLAW1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 17:27:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbgLAW1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 17:27:24 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D968C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 14:26:44 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id n14so3306298iom.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 14:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yg1PBFAH7R8nhFIJALPS4XmQibaYJrnoJQF408tUMDA=;
        b=bsGiy1HR3+Cxm8lBK31r7oEQP0m1c0Ma3OpzswYpGk3+tFQs4wGb8cf3neY2mp9O6d
         Crq3ybmaAbaEmyCBarNbvrNpuKfWH8etXbVBz7MftMvvfY2NisM4fbL9SyLcTBFuDLzO
         BLiiUm4uOzmQiCGLghht8dGqN2XZqLYpSC23U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yg1PBFAH7R8nhFIJALPS4XmQibaYJrnoJQF408tUMDA=;
        b=Gvmj0cutgONqdr8/qSQ5AHAYkhki2dfmQWWziciAuM9sjRkzmUZQHUSy6piVPTGGxA
         +UomjISF+iXP2XPR8VC2I2WpPICeXomoJ2BrykDqVen0tBhp1R8J/OViiH9H3z2cCy+p
         bPrgOcRR2x6B9U4esi7GFI0RC45RZ8Tu7iQRm0ghcK4j7qE4QtOSK6fibWI4d0DRICoO
         Zgyqe8PfKuAIGo8rFDkMZV6cmITC1ie4mO3CjY0AwAsw86rbqp4HWmWzs1vqfFa4pELV
         +8zFa58yRNie2G04b+SIxUx2Vah/6DNAFFjmN0BkqOrL7q2oNW9z9MA0PvBB+pVjzkbO
         v5tw==
X-Gm-Message-State: AOAM53251o2TxApJKA9+9mQVPVLOducuOvSKFfZzau3bV98AQN34UPKD
        GYHze9DVuvgj9ns0A/6JK3uQsyLI8iYSKhE7M3+dlQ==
X-Google-Smtp-Source: ABdhPJycNkLjLW4kRIFpMcM/uwSfyR5b3PLP69lASe5zPz04yje2d6Oy3wrvmb/2iC6f1bemfox4IFqUmUw1I2CV+F8=
X-Received: by 2002:a02:a417:: with SMTP id c23mr4669812jal.42.1606861603454;
 Tue, 01 Dec 2020 14:26:43 -0800 (PST)
MIME-Version: 1.0
References: <20201118161541.3844924-1-joel@joelfernandes.org>
 <20201118201335.GR1437@paulmck-ThinkPad-P72> <20201119035222.GA18458@paulmck-ThinkPad-P72>
 <20201119035613.GA18816@paulmck-ThinkPad-P72> <20201119183252.GA812262@google.com>
 <20201119192241.GZ1437@paulmck-ThinkPad-P72> <CAEXW_YSRQ+r_CjFOOEZ38BBRpkhjs5UbpfhGCzA8=XywEU0u8Q@mail.gmail.com>
 <20201119201615.GA1437@paulmck-ThinkPad-P72> <20201119204221.GB812262@google.com>
In-Reply-To: <20201119204221.GB812262@google.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 1 Dec 2020 17:26:32 -0500
Message-ID: <CAEXW_YSHVzzm=fLtamB=K5tjiwUNrYK76MxqfW2w0MJKO5LsTw@mail.gmail.com>
Subject: Re: [PATCH v2] rcu/segcblist: Add debug checks for segment lengths
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu <rcu@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 3:42 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Thu, Nov 19, 2020 at 12:16:15PM -0800, Paul E. McKenney wrote:
> > On Thu, Nov 19, 2020 at 02:44:35PM -0500, Joel Fernandes wrote:
> > > On Thu, Nov 19, 2020 at 2:22 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > > > > > On Wed, Nov 18, 2020 at 11:15:41AM -0500, Joel Fernandes (Google) wrote:
> > > > > > > > > After rcu_do_batch(), add a check for whether the seglen counts went to
> > > > > > > > > zero if the list was indeed empty.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > > > > >
> > > > > > > > Queued for testing and further review, thank you!
> > > > > > >
> > > > > > > FYI, the second of the two checks triggered in all four one-hour runs of
> > > > > > > TREE01, all four one-hour runs of TREE04, and one of the four one-hour
> > > > > > > runs of TREE07.  This one:
> > > > > > >
> > > > > > > WARN_ON_ONCE(count != 0 && rcu_segcblist_n_segment_cbs(&rdp->cblist) == 0);
> > > > > > >
> > > > > > > That is, there are callbacks in the list, but the sum of the segment
> > > > > > > counts is nevertheless zero.  The ->nocb_lock is held.
> > > > > > >
> > > > > > > Thoughts?
> > > > > >
> > > > > > FWIW, TREE01 reproduces it very quickly compared to the other two
> > > > > > scenarios, on all four run, within five minutes.
> > > > >
> > > > > So far for TREE01, I traced it down to an rcu_barrier happening so it could
> > > > > be related to some interaction with rcu_barrier() (Just a guess).
> > > >
> > > > Well, rcu_barrier() and srcu_barrier() are the only users of
> > > > rcu_segcblist_entrain(), if that helps.  Your modification to that
> > > > function looks plausible to me, but the system's opinion always overrules
> > > > mine.  ;-)
> > >
> > > Right. Does anything the bypass code standout? That happens during
> > > rcu_barrier() as well, and it messes with the lengths.
> >
> > In theory, rcu_barrier_func() flushes the bypass before doing the
> > entrain, and does the rcu_segcblist_entrain() afterwards.
> >
> > Ah, and that is the issue.  If ->cblist is empty and ->nocb_bypass
> > is not, then ->cblist length will be nonzero, and none of the
> > segments will be nonzero.
> >
> > So you need something like this for that second WARN, correct?
> >
> >       WARN_ON_ONCE(!rcu_segcblist_empty(&rdp->cblist) &&
> >                    rcu_segcblist_n_segment_cbs(&rdp->cblist) == 0);

Just started to look into it again. If the &rdp->cblist is empty, that
means the bypass list could not have been used (Since per comments on
rcu_nocb_try_bypass() , the bypass list is in use only when the cblist
is non-empty). So the cblist was non empty, then the segment counts
should not sum to 0.  So I don't think that explains it. Anyway, I
will try the new version of your warning in case there is something
about bypass lists that I'm missing.
