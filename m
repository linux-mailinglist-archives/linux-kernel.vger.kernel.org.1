Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01A9D290031
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 10:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405205AbgJPIwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 04:52:20 -0400
Received: from foss.arm.com ([217.140.110.172]:59538 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404836AbgJPIwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 04:52:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E59ED30E;
        Fri, 16 Oct 2020 01:52:18 -0700 (PDT)
Received: from localhost (unknown [10.1.199.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 866173F719;
        Fri, 16 Oct 2020 01:52:18 -0700 (PDT)
Date:   Fri, 16 Oct 2020 09:52:17 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Da Xue <da@libre.computer>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mailbox: cancel timer before starting it
Message-ID: <20201016085217.GA12323@arm.com>
References: <20200923123916.1115962-1-jbrunet@baylibre.com>
 <20201015134628.GA11989@arm.com>
 <1jlfg7k2ux.fsf@starbuckisacylon.baylibre.com>
 <CABb+yY1-MBac0e6xQwWkHRo3bqJNMWb4xQzdaGdrYT=n5zRvtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABb+yY1-MBac0e6xQwWkHRo3bqJNMWb4xQzdaGdrYT=n5zRvtw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 15 Oct 2020 at 13:45:54 (-0500), Jassi Brar wrote:
[..]
> > >> --- a/drivers/mailbox/mailbox.c
> > >> +++ b/drivers/mailbox/mailbox.c
> > >> @@ -82,9 +82,13 @@ static void msg_submit(struct mbox_chan *chan)
> > >>  exit:
> > >>      spin_unlock_irqrestore(&chan->lock, flags);
> > >>
> > >> -    if (!err && (chan->txdone_method & TXDONE_BY_POLL))
> > >> -            /* kick start the timer immediately to avoid delays */
> > >> +    if (!err && (chan->txdone_method & TXDONE_BY_POLL)) {
> > >> +            /* Disable the timer if already active ... */
> > >> +            hrtimer_cancel(&chan->mbox->poll_hrt);
> > >> +
> > >> +            /* ... and kick start it immediately to avoid delays */
> > >>              hrtimer_start(&chan->mbox->poll_hrt, 0, HRTIMER_MODE_REL);
> > >> +    }
> > >>  }
> > >>
> > >>  static void tx_tick(struct mbox_chan *chan, int r)
> > >
> > > I've tracked a regression back to this commit. Details to reproduce:
> >
> > Hi Ionela,
> >
> > I don't have access to your platform and I don't get what is going on
> > from the log below.
> >
> > Could you please give us a bit more details about what is going on ?
> >
> > All this patch does is add hrtimer_cancel().
> > * It is needed if the timer had already been started, which is
> >   appropriate AFAIU
> > * It is a NO-OP is the timer is not active.
> >
> Can you please try using hrtimer_try_to_cancel() instead ?
> 

Yes, using hrtimer_try_to_cancel() instead works for me. But doesn't
this limit how effective this change is? AFAIU, this will possibly only
reduce the chances for the race condition, but not solve it.

Thanks,
Ionela.

> thanks
