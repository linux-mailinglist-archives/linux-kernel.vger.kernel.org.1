Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24D4A290464
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 13:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407001AbgJPLwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 07:52:16 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36458 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406914AbgJPLwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 07:52:16 -0400
Received: by mail-lj1-f194.google.com with SMTP id f29so2104422ljo.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 04:52:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IvK7Gltvc5Jq16cJfQWOx4Z/DyTlXOz5LMLBN4FX8rA=;
        b=Wiyi7p7eiadH06dGKbkE6CnxQbH00SR3qhUNx2WcFzdxDA4oUaK/bSaKG/BQBqpMKG
         sVv6C5B0mMe1wrFddmROdCjmSeq6z35D2NwVW7YNRFd1qREG3uD/+dg/dtyCTQV8414d
         4yoP79jtF9lhTLFhmR6DBTEmU6rg9FsKzLNC3m8D2XUkeCu4PnEFmEdz+dWhuJ0qVcJ8
         xBD8wnABREyPcDqTsBl+R9spVl+VT3evbcgxtxK7w6llQmA3Cr51+HWr7G89vQQDn/qE
         Iinyo4Qwl5Z7PpMvvVi4do8WJmBVVCzQlrTLumWmwyEs2cU/S9VLakR0xnQ1vSOBhtz9
         cZRw==
X-Gm-Message-State: AOAM530LKu4MkAADGBgmSD/FMWTSFX1C8buh3zj1QoammOIFWLEDVHrC
        HxwQNEwN64qEGqX+3anFyJvVVftvIxGZPkgv/HI=
X-Google-Smtp-Source: ABdhPJyfiL2CwCpCnq/Nyp/ytKswfb/qspg1rklEfWYG1m+icPopCJZgdchtKOXnRjx3CG96vDWQhNz4JlW9SBJfwhQ=
X-Received: by 2002:a2e:7815:: with SMTP id t21mr1232909ljc.217.1602849134167;
 Fri, 16 Oct 2020 04:52:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200923123916.1115962-1-jbrunet@baylibre.com>
 <20201015134628.GA11989@arm.com> <1jlfg7k2ux.fsf@starbuckisacylon.baylibre.com>
 <CABb+yY1-MBac0e6xQwWkHRo3bqJNMWb4xQzdaGdrYT=n5zRvtw@mail.gmail.com> <20201016085217.GA12323@arm.com>
In-Reply-To: <20201016085217.GA12323@arm.com>
From:   Sudeep Holla <sudeep.holla@arm.com>
Date:   Fri, 16 Oct 2020 12:52:02 +0100
Message-ID: <CAPKp9uZu0MggcMGyxK__UeGRONo3VHHWrqKwjOtZt-pguS=6JA@mail.gmail.com>
Subject: Re: [PATCH] mailbox: cancel timer before starting it
To:     Ionela Voinescu <ionela.voinescu@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Da Xue <da@libre.computer>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 12:32 PM Ionela Voinescu
<ionela.voinescu@arm.com> wrote:
>
> On Thursday 15 Oct 2020 at 13:45:54 (-0500), Jassi Brar wrote:
> [..]
> > > >> --- a/drivers/mailbox/mailbox.c
> > > >> +++ b/drivers/mailbox/mailbox.c
> > > >> @@ -82,9 +82,13 @@ static void msg_submit(struct mbox_chan *chan)
> > > >>  exit:
> > > >>      spin_unlock_irqrestore(&chan->lock, flags);
> > > >>
> > > >> -    if (!err && (chan->txdone_method & TXDONE_BY_POLL))
> > > >> -            /* kick start the timer immediately to avoid delays */
> > > >> +    if (!err && (chan->txdone_method & TXDONE_BY_POLL)) {
> > > >> +            /* Disable the timer if already active ... */
> > > >> +            hrtimer_cancel(&chan->mbox->poll_hrt);
> > > >> +
> > > >> +            /* ... and kick start it immediately to avoid delays */
> > > >>              hrtimer_start(&chan->mbox->poll_hrt, 0, HRTIMER_MODE_REL);
> > > >> +    }
> > > >>  }
> > > >>
> > > >>  static void tx_tick(struct mbox_chan *chan, int r)
> > > >
> > > > I've tracked a regression back to this commit. Details to reproduce:
> > >
> > > Hi Ionela,
> > >
> > > I don't have access to your platform and I don't get what is going on
> > > from the log below.
> > >
> > > Could you please give us a bit more details about what is going on ?
> > >
> > > All this patch does is add hrtimer_cancel().
> > > * It is needed if the timer had already been started, which is
> > >   appropriate AFAIU
> > > * It is a NO-OP is the timer is not active.
> > >
> > Can you please try using hrtimer_try_to_cancel() instead ?
> >
>
> Yes, using hrtimer_try_to_cancel() instead works for me. But doesn't
> this limit how effective this change is? AFAIU, this will possibly only
> reduce the chances for the race condition, but not solve it.
>

Indeed, I tried the same and got a lot of -ETIME failures. hrtimer_cancel
uses hrtimer_try_to_cancel in loop until it succeeds so that the following
hrtimer_start can be done w/o any pending timers.

-- 
Regards,
Sudeep
