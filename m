Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEEB290C44
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 21:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436533AbgJPT1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 15:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410753AbgJPT1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 15:27:55 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96724C061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 12:27:54 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id t18so3859445ilo.12
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 12:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1DJnrCVnvy4PoMtVGFycjUVirWQQwi3AYGu5HmZZQwQ=;
        b=X9rp63JScAmPAW+kyhIqursnDhfJTrj0ZGbEnAzBHYg+kq0WkEUosaRnDPVOyc4rPm
         aly52LA2VUl/vVmAsXzsxWDfNFoAY/NvEwJZdD7AgzlR0BZ8Nv+AY0REwg9IpNTZB1J+
         AI8XkXWArpm8XI9ZHfcPNFZPqJIP+w4jsFPOLJDmTuqLdD+7Gv485x9kgOvx2B84bQSJ
         vLy9dWeKBnMNZqk1QWVgAUbHrmwDn2WO89Hr5jE0jwmFQIf5YR02mD7JehIFzoD+ZchC
         tLLrw+YVM8Fj9JQQfG9cKIkkdfnSq06ogxMvn5WzgahHCaRS4+hx9TUyKOCtHEOURRVD
         N6Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1DJnrCVnvy4PoMtVGFycjUVirWQQwi3AYGu5HmZZQwQ=;
        b=oYUIM+TF7BmTTJclr8UI3aKArbozw/t520F/DwjlSXNQdZp8BuJJFHqVkTR17gT81L
         etUZITAYwy+HVC54b7LhQS7u4rmgS3+tXzApVILDmEhm32aGbd6KTHd9aZbj/UKk2uxe
         GALLP2ltJLM7vP9iNtSWbqRkoBD+f+9oI4mQHIxqp4LbYzlo2VEGdrloQ4Nf/U8SXh8C
         /bxKE+yg89xK/W3vA9+00cJOc7xcpIzowQiLt8mMxotZTToxa+5UZykEdStZHwyssOqZ
         0gfepEG+vcEqyoV3iOeeWTx9aFLhmUaVmURVyPwoHgyJfSHE0OMdq/ZNBt2LTiljqrS4
         VOjw==
X-Gm-Message-State: AOAM533uCVHDG4EMevsswt1wr5Rq5m6+HATrwCIVPXmqPXa3sbR04Aeo
        SYpAHs1B8rSrV5f2ChEK3fg3YjUHFNxaa1DVC8A=
X-Google-Smtp-Source: ABdhPJzxFfuKsusi7gNdStcCWsYC45SHHjQhi7PziKAYTfwXYyFewbjE66BYsHom8WYmkbtQdiVJOBCrQU7//fwykx4=
X-Received: by 2002:a92:8910:: with SMTP id n16mr4077254ild.239.1602876473992;
 Fri, 16 Oct 2020 12:27:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200923123916.1115962-1-jbrunet@baylibre.com>
 <20201015134628.GA11989@arm.com> <1jlfg7k2ux.fsf@starbuckisacylon.baylibre.com>
 <CABb+yY1-MBac0e6xQwWkHRo3bqJNMWb4xQzdaGdrYT=n5zRvtw@mail.gmail.com>
 <20201016085217.GA12323@arm.com> <1jk0vqk0ju.fsf@starbuckisacylon.baylibre.com>
 <CABb+yY0pDxQ7B+NPsEz325-_X2nSJngnfER7uOLVyoBLoH37cA@mail.gmail.com> <1jft6ej91c.fsf@starbuckisacylon.baylibre.com>
In-Reply-To: <1jft6ej91c.fsf@starbuckisacylon.baylibre.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Fri, 16 Oct 2020 14:27:43 -0500
Message-ID: <CABb+yY0Ktj9O9YxGDM0q_6MnKPBCopm+RzQa6SM64Pn_60a2pA@mail.gmail.com>
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

On Fri, Oct 16, 2020 at 1:54 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
>
> On Fri 16 Oct 2020 at 19:33, Jassi Brar <jassisinghbrar@gmail.com> wrote:
>
> > On Fri, Oct 16, 2020 at 4:00 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
> >>
> >>
> >> On Fri 16 Oct 2020 at 10:52, Ionela Voinescu <ionela.voinescu@arm.com> wrote:
> >>
> >> > On Thursday 15 Oct 2020 at 13:45:54 (-0500), Jassi Brar wrote:
> >> > [..]
> >> >> > >> --- a/drivers/mailbox/mailbox.c
> >> >> > >> +++ b/drivers/mailbox/mailbox.c
> >> >> > >> @@ -82,9 +82,13 @@ static void msg_submit(struct mbox_chan *chan)
> >> >> > >>  exit:
> >> >> > >>      spin_unlock_irqrestore(&chan->lock, flags);
> >> >> > >>
> >> >> > >> -    if (!err && (chan->txdone_method & TXDONE_BY_POLL))
> >> >> > >> -            /* kick start the timer immediately to avoid delays */
> >> >> > >> +    if (!err && (chan->txdone_method & TXDONE_BY_POLL)) {
> >> >> > >> +            /* Disable the timer if already active ... */
> >> >> > >> +            hrtimer_cancel(&chan->mbox->poll_hrt);
> >> >> > >> +
> >> >> > >> +            /* ... and kick start it immediately to avoid delays */
> >> >> > >>              hrtimer_start(&chan->mbox->poll_hrt, 0, HRTIMER_MODE_REL);
> >> >> > >> +    }
> >> >> > >>  }
> >> >> > >>
> >> >> > >>  static void tx_tick(struct mbox_chan *chan, int r)
> >> >> > >
> >> >> > > I've tracked a regression back to this commit. Details to reproduce:
> >> >> >
> >> >> > Hi Ionela,
> >> >> >
> >> >> > I don't have access to your platform and I don't get what is going on
> >> >> > from the log below.
> >> >> >
> >> >> > Could you please give us a bit more details about what is going on ?
> >> >> >
> >> >> > All this patch does is add hrtimer_cancel().
> >> >> > * It is needed if the timer had already been started, which is
> >> >> >   appropriate AFAIU
> >> >> > * It is a NO-OP is the timer is not active.
> >> >> >
> >> >> Can you please try using hrtimer_try_to_cancel() instead ?
> >> >>
> >> >
> >> > Yes, using hrtimer_try_to_cancel() instead works for me. But doesn't
> >> > this limit how effective this change is? AFAIU, this will possibly only
> >> > reduce the chances for the race condition, but not solve it.
> >> >
> >>
> >> It is also my understanding, hrtimer_try_to_cancel() would remove a
> >> timer which as not already started but would return withtout doing
> >> anything if the callback is already running ... which is the original
> >> problem
> >>
> > If we are running in the callback path, hrtimer_try_to_cancel will
> > return -1, in which case we could skip hrtimer_start.
> > Anyways, I think simply checking for hrtimer_active should effect the same.
> > I have submitted a patch, of course not tested.
>
> Yes it sloves this race but ...
>
Thanks for confirmation.

> If a race is possible between a timer callback rescheduling itself (which
> is not that uncommon) and another thread trying to cancel it
>
In our case, we should not be cancelling+restarting the timer in the
first place, because txdone_hrtimer will take care of it via
hrtimer_forward_now.

>, maybe
> there is something worth fixing in hrtimer ? Also, mailbox calls
> hrtimer_cancel() in unregister ... are we confident this would work ?
>
Yes. After unregister() every channel is supposed to die and so must
its resources.

-jassi
