Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76F79290B9D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 20:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403791AbgJPSqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 14:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392850AbgJPSqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 14:46:00 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7CDC061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 11:46:00 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id k25so5118636ioh.7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 11:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gFYiHCtCMBPTnzOc5FacAZTSSsWRxO+aMV1lhIW9c4A=;
        b=Y+iDyajocIxVP1ldK6z4P5MpjH5KHiGPZqqpmxBm2PZBXtC4O0CDNobydFUS0eSv8c
         DOfn99vT45hHin3T346vSjjuIgRI4XAIpkP8O5QUODbnsrB3EXDYQChHWCOUxNFnBWf2
         m9JHwYqJT9tpFqUwRmUHmmvhdl6a3DP8DPyPMXy/G9L6wYsE1geCM7VvFF2UgJ5x7hlv
         tdH5OuAzllqlr+8+VsWAan8cSAmvvhcn84Ua+jJTEbnzXLQYxlm3oDMtOh4JzFHd0y2+
         W2CdYccBmN/AWjFzu3Wyy+a8K+Hr0Es/X+wYtpNsLC6eQrDnrfGft5WqmsE92nvPYYre
         ed7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gFYiHCtCMBPTnzOc5FacAZTSSsWRxO+aMV1lhIW9c4A=;
        b=CGvsWA2lfG3IFeftS5UOhC31T/3UmRORmVu+PxZDXVK7ARHPlondJ7PS+qdNcWiS1v
         2z1riQ9tY5vw8PC3LMrwIC8/TVS4ehNBRvpXzHz5YrXg6b7BsoIcv93LBDQTr+VYUvua
         J9u34R45LlaXHSDf3L46At2+IUc0IgnzQVUMs0XYjSqQwQcucSd4+FcTW4f/gpUK3wsx
         PPjXbwGHugZV6ZL1liAHXjDsXPJfvhKGTDtkm1nx5YeN5gZFtg/mNKb3zT0uaxg583Yq
         AUKgtnDBzNXNHWCvCTApLenXnd8Wo05C8CQXQtW3Q65CEZCvayJWk+4upI4YBwx+PTkA
         JTkg==
X-Gm-Message-State: AOAM533WX6smNhnLMjyDGiAmvVKEvHPAigqTqJnsJD1zGY1D84cVQ/bO
        /+jXjVQnq603FsMR7yWaG3Ui0UHVyPiWKsfWU0Y=
X-Google-Smtp-Source: ABdhPJwpScOm7bxiJmJnbvOrphT+j2Q+QAlQXIUGg5uVqwUQygWnzDTWCHHayI8QccyqyREkYjWjDp5gWcQWXx6Ukxo=
X-Received: by 2002:a5e:9618:: with SMTP id a24mr3613286ioq.27.1602873960045;
 Fri, 16 Oct 2020 11:46:00 -0700 (PDT)
MIME-Version: 1.0
References: <20201016173020.12686-1-jassisinghbrar@gmail.com> <1jh7quj9sa.fsf@starbuckisacylon.baylibre.com>
In-Reply-To: <1jh7quj9sa.fsf@starbuckisacylon.baylibre.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Fri, 16 Oct 2020 13:45:49 -0500
Message-ID: <CABb+yY3oghojLDAz2n8fio47X=we=mF=u8iA2zc7ApvcH7ySKA@mail.gmail.com>
Subject: Re: [PATCH] mailbox: avoid timer start from callback
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Da Xue <da@libre.computer>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jassi Brar <jaswinder.singh@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 1:38 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
>
> On Fri 16 Oct 2020 at 19:30, jassisinghbrar@gmail.com wrote:
>
> > From: Jassi Brar <jaswinder.singh@linaro.org>
> >
> > If the txdone is done by polling, it is possible for msg_submit() to start
> > the timer while txdone_hrtimer() callback is running. If the timer needs
> > recheduling, it could already be enqueued by the time hrtimer_forward_now()
> > is called, leading hrtimer to loudly complain.
> >
> > WARNING: CPU: 3 PID: 74 at kernel/time/hrtimer.c:932 hrtimer_forward+0xc4/0x110
> > CPU: 3 PID: 74 Comm: kworker/u8:1 Not tainted 5.9.0-rc2-00236-gd3520067d01c-dirty #5
> > Hardware name: Libre Computer AML-S805X-AC (DT)
> > Workqueue: events_freezable_power_ thermal_zone_device_check
> > pstate: 20000085 (nzCv daIf -PAN -UAO BTYPE=--)
> > pc : hrtimer_forward+0xc4/0x110
> > lr : txdone_hrtimer+0xf8/0x118
> > [...]
> >
> > This can be fixed by not starting the timer from the callback path. Which
> > requires the timer reloading as long as any message is queued on the
> > channel, and not just when current tx is not done yet.
> >
> > Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
> > ---
> >  drivers/mailbox/mailbox.c | 12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
> > index 0b821a5b2db8..a093a6ecaa66 100644
> > --- a/drivers/mailbox/mailbox.c
> > +++ b/drivers/mailbox/mailbox.c
> > @@ -82,9 +82,12 @@ static void msg_submit(struct mbox_chan *chan)
> >  exit:
> >       spin_unlock_irqrestore(&chan->lock, flags);
> >
> > -     if (!err && (chan->txdone_method & TXDONE_BY_POLL))
> > -             /* kick start the timer immediately to avoid delays */
> > -             hrtimer_start(&chan->mbox->poll_hrt, 0, HRTIMER_MODE_REL);
> > +     /* kick start the timer immediately to avoid delays */
> > +     if (!err && (chan->txdone_method & TXDONE_BY_POLL)) {
> > +             /* but only if not already active */
>
> It would solve the problem I reported as well but instead of running the
> check immediately (timer with value 0), we will have to wait for the
> next of the timer, it is already started. IOW, there might be a delay
> now. I don't know if this important for the mailbox - the existing
> comments in the code suggested it was.
>
That comment is for when the first message is queued on the channel,
which remains unimpacted.
So, do I have your tested/acked by ?

thnx,
