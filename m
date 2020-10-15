Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 229C628F8D7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 20:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389744AbgJOSqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 14:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731154AbgJOSqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 14:46:06 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFBFC061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 11:46:06 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id k6so6235845ior.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 11:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZT3LqmAePxmQwo7wqrb27mFagmwcwLvOvM1fMDiWxTs=;
        b=RMIoopkIcvzGqc6L40+oYo9n5hIYxDc6F+GydXQbn4Z0OK5OhAT2MGHWtxWkNqACCO
         m93JgoBCCQn7kNDxnOo5X1vxuc2mnXu453S78ISjNTswNMUj/x25S09i39wqbIEkE+Lk
         U2IbhPz0/CllPXiUgcd8NZmtvrkXcicHGs/sMy2zO51LV63Ku2ZQS7loxi7sh0Kbz+6O
         2rOXE7U0MK3kqWOhRwag34LKwoaXFc+vv0TDcHODLV5NfvgHE9mIeVw3gSUjupqWmI9m
         3mNJ23ex6h+rmPFLqbSdic1lrIyOVKrXicrvaOqbPnX1PK1OkQAokqMRu2JjQ8+4b7HC
         KUSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZT3LqmAePxmQwo7wqrb27mFagmwcwLvOvM1fMDiWxTs=;
        b=ppHuG93axsT0178zPcCxC8psm7vZFyLNRBNgexXgF2ivkx7nwgXnCMk5B7g6q2AOse
         QTl0T3RquDlP2u36R93uJFbgP+KmwONFdRD9OvF72asyMg2Jg3CfKfMWdLegc2ZKxru1
         nZqY2y94l6IsEBTvHjUce+bWSsGQ3/GVit1VXFU4GhK7rnQc+w3fktfnXBMqyvQerWol
         L8VOyzt8VXXL+2LITiAnTd8VzBizbXR6gcOpev3KyDIaOSSkFn3oqcFaQO/nkVtyOvSl
         HnezYs/3UW7rTVp9C9DTgnC6FM6OIFk0XuNjr3ny3fjJfyGMmm5Qmo85Dr1XZA4xIRjn
         xeCA==
X-Gm-Message-State: AOAM533cNdTMRX0mxxWK0jVNZomXv2SfvuRrW9P9CMvGrhhPQChLBgea
        bBY2vhxYpr5GZ62COK3kTZKyUSC9gJfa0LK7F+8ZO3+U4V8=
X-Google-Smtp-Source: ABdhPJymwxy9AgECwUqvY6xkuyHZpsnq3Q4PIkSL7QpIXigg6Zbc9Ci/h9U0MEPLbdtPUN5tMljdBKbXYLcxKSPwwUo=
X-Received: by 2002:a5d:9e47:: with SMTP id i7mr4360587ioi.52.1602787565374;
 Thu, 15 Oct 2020 11:46:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200923123916.1115962-1-jbrunet@baylibre.com>
 <20201015134628.GA11989@arm.com> <1jlfg7k2ux.fsf@starbuckisacylon.baylibre.com>
In-Reply-To: <1jlfg7k2ux.fsf@starbuckisacylon.baylibre.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Thu, 15 Oct 2020 13:45:54 -0500
Message-ID: <CABb+yY1-MBac0e6xQwWkHRo3bqJNMWb4xQzdaGdrYT=n5zRvtw@mail.gmail.com>
Subject: Re: [PATCH] mailbox: cancel timer before starting it
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Ionela Voinescu <ionela.voinescu@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Da Xue <da@libre.computer>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 15, 2020 at 8:58 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
>
> On Thu 15 Oct 2020 at 15:46, Ionela Voinescu <ionela.voinescu@arm.com> wrote:
>
> > Hi guys,
> >
> > On Wednesday 23 Sep 2020 at 14:39:16 (+0200), Jerome Brunet wrote:
> >> If the txdone is done by polling, it is possible for msg_submit() to start
> >> the timer while txdone_hrtimer() callback is running. If the timer needs
> >> recheduling, it could already be enqueued by the time hrtimer_forward_now()
> >> is called, leading hrtimer to loudly complain.
> >>
> >> WARNING: CPU: 3 PID: 74 at kernel/time/hrtimer.c:932 hrtimer_forward+0xc4/0x110
> >> CPU: 3 PID: 74 Comm: kworker/u8:1 Not tainted 5.9.0-rc2-00236-gd3520067d01c-dirty #5
> >> Hardware name: Libre Computer AML-S805X-AC (DT)
> >> Workqueue: events_freezable_power_ thermal_zone_device_check
> >> pstate: 20000085 (nzCv daIf -PAN -UAO BTYPE=--)
> >> pc : hrtimer_forward+0xc4/0x110
> >> lr : txdone_hrtimer+0xf8/0x118
> >> [...]
> >>
> >> Canceling the timer before starting it ensure that the timer callback is
> >> not running when the timer is started, solving this race condition.
> >>
> >> Fixes: 0cc67945ea59 ("mailbox: switch to hrtimer for tx_complete polling")
> >> Reported-by: Da Xue <da@libre.computer>
> >> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> >> ---
> >>  drivers/mailbox/mailbox.c | 8 ++++++--
> >>  1 file changed, 6 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
> >> index 0b821a5b2db8..34f9ab01caef 100644
> >> --- a/drivers/mailbox/mailbox.c
> >> +++ b/drivers/mailbox/mailbox.c
> >> @@ -82,9 +82,13 @@ static void msg_submit(struct mbox_chan *chan)
> >>  exit:
> >>      spin_unlock_irqrestore(&chan->lock, flags);
> >>
> >> -    if (!err && (chan->txdone_method & TXDONE_BY_POLL))
> >> -            /* kick start the timer immediately to avoid delays */
> >> +    if (!err && (chan->txdone_method & TXDONE_BY_POLL)) {
> >> +            /* Disable the timer if already active ... */
> >> +            hrtimer_cancel(&chan->mbox->poll_hrt);
> >> +
> >> +            /* ... and kick start it immediately to avoid delays */
> >>              hrtimer_start(&chan->mbox->poll_hrt, 0, HRTIMER_MODE_REL);
> >> +    }
> >>  }
> >>
> >>  static void tx_tick(struct mbox_chan *chan, int r)
> >
> > I've tracked a regression back to this commit. Details to reproduce:
>
> Hi Ionela,
>
> I don't have access to your platform and I don't get what is going on
> from the log below.
>
> Could you please give us a bit more details about what is going on ?
>
> All this patch does is add hrtimer_cancel().
> * It is needed if the timer had already been started, which is
>   appropriate AFAIU
> * It is a NO-OP is the timer is not active.
>
Can you please try using hrtimer_try_to_cancel() instead ?

thanks
