Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2452906A4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 15:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408428AbgJPNwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 09:52:33 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38283 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408355AbgJPNwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 09:52:33 -0400
Received: by mail-lf1-f67.google.com with SMTP id c141so3021950lfg.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 06:52:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3tLxs3Ec/9QewzF9/5OsF1Lu3L5UygZwfvUIskQ2kBw=;
        b=gEbG16nOq+6ioLNz/T0tfe7PorlOcfikWHOhxlvot/949k9fUJsBqe7BXX0G0IUunv
         VcsQwJ8bAmkPBABlfhvnmg/FxTD+AM+drm8Cdy4K43ZDiehFfOfK6dObyiWM8uGKCAWv
         BvnFv/8e+WLigFEewzRjhANvmv9iV9cLcm6LDV/q3pcvFa4G2+L4zS4PddDvOYk0PZDt
         i9ZubNjOP1R0+VAwmakgLjyK51p/a1rsqt0UwfG+vcHPdFoSkXT4ULKtbVu5JmzD5cjF
         FG5cdNeMf/gCXKd7ogWn6D1gIEJqU+zluoPjNYiSLNKPwxhFLtbAlsuVHpa1rZMPFbQv
         qk+g==
X-Gm-Message-State: AOAM5324do9RJwphnl4mTGih35MhwLYueqy8ZNWIY4iSZRGyeAC3BMVy
        lq7MugIbpXik6pWu+JdJSsZMbAotMdWGcjUIBF0=
X-Google-Smtp-Source: ABdhPJzVoTKCIBlULvlI8sRT2QNkbWiIHdeolA+3CxYx+ze+DF/frgS0t1N3TZyOWIOv7YmTV1h25wewkycLChctw8Y=
X-Received: by 2002:a05:6512:3137:: with SMTP id p23mr1479500lfd.316.1602856350629;
 Fri, 16 Oct 2020 06:52:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200923123916.1115962-1-jbrunet@baylibre.com>
 <20201015134628.GA11989@arm.com> <1jlfg7k2ux.fsf@starbuckisacylon.baylibre.com>
 <CABb+yY1-MBac0e6xQwWkHRo3bqJNMWb4xQzdaGdrYT=n5zRvtw@mail.gmail.com>
 <20201016085217.GA12323@arm.com> <1jk0vqk0ju.fsf@starbuckisacylon.baylibre.com>
In-Reply-To: <1jk0vqk0ju.fsf@starbuckisacylon.baylibre.com>
From:   Sudeep Holla <sudeep.holla@arm.com>
Date:   Fri, 16 Oct 2020 14:52:18 +0100
Message-ID: <CAPKp9uaqeShkedY1aJpgAhe3NWeHdKOdNQv8W_OwKj+nFMjaDg@mail.gmail.com>
Subject: Re: [PATCH] mailbox: cancel timer before starting it
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     Ionela Voinescu <ionela.voinescu@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Da Xue <da@libre.computer>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 1:15 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
>
> On Fri 16 Oct 2020 at 10:52, Ionela Voinescu <ionela.voinescu@arm.com> wrote:
>
> > On Thursday 15 Oct 2020 at 13:45:54 (-0500), Jassi Brar wrote:
> > [..]
> >> > >> --- a/drivers/mailbox/mailbox.c
> >> > >> +++ b/drivers/mailbox/mailbox.c
> >> > >> @@ -82,9 +82,13 @@ static void msg_submit(struct mbox_chan *chan)
> >> > >>  exit:
> >> > >>      spin_unlock_irqrestore(&chan->lock, flags);
> >> > >>
> >> > >> -    if (!err && (chan->txdone_method & TXDONE_BY_POLL))
> >> > >> -            /* kick start the timer immediately to avoid delays */
> >> > >> +    if (!err && (chan->txdone_method & TXDONE_BY_POLL)) {
> >> > >> +            /* Disable the timer if already active ... */
> >> > >> +            hrtimer_cancel(&chan->mbox->poll_hrt);
> >> > >> +
> >> > >> +            /* ... and kick start it immediately to avoid delays */
> >> > >>              hrtimer_start(&chan->mbox->poll_hrt, 0, HRTIMER_MODE_REL);
> >> > >> +    }
> >> > >>  }
> >> > >>
> >> > >>  static void tx_tick(struct mbox_chan *chan, int r)
> >> > >
> >> > > I've tracked a regression back to this commit. Details to reproduce:
> >> >
> >> > Hi Ionela,
> >> >
> >> > I don't have access to your platform and I don't get what is going on
> >> > from the log below.
> >> >
> >> > Could you please give us a bit more details about what is going on ?
> >> >
> >> > All this patch does is add hrtimer_cancel().
> >> > * It is needed if the timer had already been started, which is
> >> >   appropriate AFAIU
> >> > * It is a NO-OP is the timer is not active.
> >> >
> >> Can you please try using hrtimer_try_to_cancel() instead ?
> >>
> >
> > Yes, using hrtimer_try_to_cancel() instead works for me. But doesn't
> > this limit how effective this change is? AFAIU, this will possibly only
> > reduce the chances for the race condition, but not solve it.
> >
>
> It is also my understanding, hrtimer_try_to_cancel() would remove a
> timer which as not already started but would return withtout doing
> anything if the callback is already running ... which is the original
> problem
>


There seem to be some races. It always hangs in the hrtimer_cancel.
Logging some extra messages makes it progress for a while and finally
get stuck in the loop. I wonder if there is a race between cancel
and handler execution.

-- 
Regards,
Sudeep
