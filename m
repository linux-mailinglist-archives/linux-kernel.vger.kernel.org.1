Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A929290ACB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 19:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391441AbgJPReI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 13:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390235AbgJPReI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 13:34:08 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCBDC061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 10:34:08 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id p16so3546548ilq.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 10:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QQNx5lbWWREoG92H9GWCHwFrOsjOJReO5JJROvxhPeA=;
        b=MyFCI1d57eYhGAHzNbPzG0+gwYQAPxbalJwgjSW3Xqd7s2+P4uhkgk30gxqP/ihsvQ
         KF7AvZIciGhSezS3QwLEja/cPTQDqJafJnNdZxZlCIf0vTsPdXD9Q9cshuO9TkutzWfQ
         ZAoP/KiSOVuFakNyI8LvzZLyuakFqxRi4ZzsqUJu7Pe8KdVeoKHeIyH+k4OWEFxozyCa
         5+TFuqYQOhZzIHK05h9JUTmtHxl9ACg1oGGohQgBDKcXuqyQD19KN3haqgRW3myQ+ppE
         ofO4JeH99ih+xoeSNvSPp//8olyMBOwbZlIdCeKkgxReTNifQzN5QHAqumDS43rAchzN
         zmGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QQNx5lbWWREoG92H9GWCHwFrOsjOJReO5JJROvxhPeA=;
        b=jAW7TPxHZvU41xJvTVmmxYSIHkAsQOHzh0GqwwYjnZ6CMPEmeujQr3MI4iGoHZLdEo
         vpfVTMsiT2y+l7H/tzEbGamuI955tebqSktfEDnXO9vgFZ/J9+3CO3Xn+6/2S0HDZoWK
         f+YVCJywbG6F0JDoi+Qk4yvIgZkH9i5ptkx1z7a3FfODdBgDOe369KABTylc2s3QO5D9
         B3cUc30xmNjagJnMK61qwGX2D2uajOzKSPNo6OotJbMWqkXt1QrYtcZze85znR/t4VDD
         oEOZPWjR3x30ZkbVKtzWOTLYAI1WLofgO72zc+zj1puxwUfyXVySycPCxMeuq/bTGBGn
         o6gg==
X-Gm-Message-State: AOAM5317KSwcBbAtCFoSwic75WN5aBDTSzBoSuH5mjACXyP0QitApUXB
        k43q8qJHr0rWywzQi5b7hyNAjbbErTlbo2l7kjo=
X-Google-Smtp-Source: ABdhPJzqEi6vOzU0lH2knDMwvo/xl3sQVDyGD5lN09LWg2IW8Wn0f7e5enis3EJ0LeWdcqTHvb9n++TPoRvcM1csb1A=
X-Received: by 2002:a92:600e:: with SMTP id u14mr3557017ilb.303.1602869647783;
 Fri, 16 Oct 2020 10:34:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200923123916.1115962-1-jbrunet@baylibre.com>
 <20201015134628.GA11989@arm.com> <1jlfg7k2ux.fsf@starbuckisacylon.baylibre.com>
 <CABb+yY1-MBac0e6xQwWkHRo3bqJNMWb4xQzdaGdrYT=n5zRvtw@mail.gmail.com>
 <20201016085217.GA12323@arm.com> <1jk0vqk0ju.fsf@starbuckisacylon.baylibre.com>
In-Reply-To: <1jk0vqk0ju.fsf@starbuckisacylon.baylibre.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Fri, 16 Oct 2020 12:33:57 -0500
Message-ID: <CABb+yY0pDxQ7B+NPsEz325-_X2nSJngnfER7uOLVyoBLoH37cA@mail.gmail.com>
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

On Fri, Oct 16, 2020 at 4:00 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
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
If we are running in the callback path, hrtimer_try_to_cancel will
return -1, in which case we could skip hrtimer_start.
Anyways, I think simply checking for hrtimer_active should effect the same.
I have submitted a patch, of course not tested.

Thanks
