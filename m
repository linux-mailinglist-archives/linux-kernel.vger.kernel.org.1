Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2CA222538C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jul 2020 20:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgGSSmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jul 2020 14:42:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:50244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbgGSSmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 14:42:13 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-111-31.bvtn.or.frontiernet.net [50.39.111.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 443C1208DB;
        Sun, 19 Jul 2020 18:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595184133;
        bh=8Jhex8q677bAeQY5l1CdHaRAfACyJJQuxKDmrWhsjaI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=kQFGfsk55Rjwx7U+98D9FPL+JWQo4LM6PaZM9mDKZjlCGvzfNJaqB4k9js/nKVISu
         Gi4BUS78knKjkztq3L/i7H9wzhC7VWmEtySmkAdQ8s+MyveAehFYxHnOHXCtHXBC3A
         XxcChNjM1QIME/OVwGIfN4x/bcxPAjJFzM45ZZAA=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 243613522C28; Sun, 19 Jul 2020 11:42:13 -0700 (PDT)
Date:   Sun, 19 Jul 2020 11:42:13 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Suraj Upadhyay <usuraj35@gmail.com>
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, madhuparnabhowmik10@gmail.com,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rculist: Silence unused-value warning.
Message-ID: <20200719184213.GJ9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200719105037.GA21010@blackclown>
 <20200719160747.GE9247@paulmck-ThinkPad-P72>
 <CAGbbQbG5ZLRhc+nxLqM35K3_cbXKw3AM1hXPm0fkyBEfRRhAnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGbbQbG5ZLRhc+nxLqM35K3_cbXKw3AM1hXPm0fkyBEfRRhAnA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 19, 2020 at 10:53:05PM +0530, Suraj Upadhyay wrote:
> On Sun 19 Jul, 2020, 21:37 Paul E. McKenney, <paulmck@kernel.org> wrote:
> 
> > On Sun, Jul 19, 2020 at 04:20:37PM +0530, Suraj Upadhyay wrote:
> > > The macro __list_check_srcu is used as a statement inside a for loop.
> > >
> > > __list_check_srcu becomes "true" when CONFIG_PROVE_RCU_LIST is not
> > defined.
> > > This results in compiler warning about an unused value ("true").
> > >
> > > Silence the compiler warning about the unused value "true"
> > > by replacing it with an empty expression.
> > >
> > > Signed-off-by: Suraj Upadhyay <usuraj35@gmail.com>
> >
> > Like this, you mean, give or take whitespace?  ;-)
> >
> > https://lore.kernel.org/lkml/20200718001259.GY9247@paulmck-ThinkPad-P72/
> >
> > May I add your Tested-by?
> >
> >                                                         Thanx, Paul
> >
> 
> Yeah sure.

Thank you, I have applied it and it will be public on my next rebase.
And thank you for your testing efforts!

							Thanx, Paul

> Thanks,
> 
> Suraj Upadhyay.
> 
> > ---
> > >  include/linux/rculist.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/include/linux/rculist.h b/include/linux/rculist.h
> > > index de9385b9158e..8b8e0584c473 100644
> > > --- a/include/linux/rculist.h
> > > +++ b/include/linux/rculist.h
> > > @@ -73,7 +73,7 @@ static inline void INIT_LIST_HEAD_RCU(struct list_head
> > *list)
> > >  #define __list_check_rcu(dummy, cond, extra...)
> >       \
> > >       ({ check_arg_count_one(extra); })
> > >
> > > -#define __list_check_srcu(cond) true
> > > +#define __list_check_srcu(cond) ({})
> > >  #endif
> > >
> > >  /*
> > > --
> > > 2.17.1
> > >
> >
> >
> >
