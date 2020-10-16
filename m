Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E699029005A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 11:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394802AbgJPJAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 05:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394017AbgJPJAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 05:00:42 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3C1C061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 02:00:40 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id e22so2060898ejr.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 02:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=iB+QPH92mHXjVf31wrVpD9hY3E5/PzA4JTgfur7FThU=;
        b=wXy5eIvn1HY2VZDvfhHhh92E7KKD+T/lLU6bPSDc19eVJ4GXWhv/UJjTulrUaNv/WH
         rxvE8zjr4KT2rLGqZZSBkhe9QWHea2ahORcSg5usFyYFPeHSaJzZmidW1fMeOz9vpeEv
         Szn0nAVXtwAtsnkQ8XdfdzQnFVn4aGZvxgaNvVGt2x6F6oVRcC+OajWE2AVTYj/jeoJp
         OQ/cdoE4MbI1HOr0QxG8RM92wo2iY/NXxIIESZ2Eh7p4vIifkHvBeGNl7ejQC0O9/KCs
         tKgk5UYgs0FVUR2lqImvCjj4S2vU+wJhCvw+3OqDmgIX+U2BBVZfdKLm6tL1z6Qqt3Cl
         mf2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=iB+QPH92mHXjVf31wrVpD9hY3E5/PzA4JTgfur7FThU=;
        b=CvV0f9hxdRR4jVl2929P/2/i8P0IZkgqqLI2jfVDR+BBtPmk7+6ib3BY11F1XyoWEC
         FJqiSLY2BprhuhslYYLd57pWQ27aG2XoHRuC7ioOUhd24d0F0tTGLp7ZqOHM2llsr2tf
         FXLwaz2iyYr42s/kuX1If+wbnajYFNdhAfgWygAK7UmroVvtAcJIrRh3Z+FjZc7oyTpA
         02o0SpR6XbblF7LCP49ivaGNEQ3ZLAjzvr4rIMQhbHENGe5kfJAKM6qXP3QF/6FgSAeW
         YiZUv1QlRKL3UJhF9Cz4r9RAuDxhYzjo9r2O3mIkE4LeCfTeqzyBWBGfIv+FKSVvtLGx
         K66g==
X-Gm-Message-State: AOAM531updrLq3JC07MGFxcyUxXdzHTawVpUbkCVwM/EWX1v4L9kBjKH
        f+zCTlwEWh1VFoQs40Ts1eEizw==
X-Google-Smtp-Source: ABdhPJzUtemqqSmoJUsCCHlxelMMqqZjxqDcFeCbf5OyFCEHpXFqe511f4bCdUO1Wwe6uRKDksw7zA==
X-Received: by 2002:a17:906:3a97:: with SMTP id y23mr2680177ejd.250.1602838839150;
        Fri, 16 Oct 2020 02:00:39 -0700 (PDT)
Received: from localhost (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.gmail.com with ESMTPSA id dp1sm1157128ejc.74.2020.10.16.02.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 02:00:38 -0700 (PDT)
References: <20200923123916.1115962-1-jbrunet@baylibre.com> <20201015134628.GA11989@arm.com> <1jlfg7k2ux.fsf@starbuckisacylon.baylibre.com> <CABb+yY1-MBac0e6xQwWkHRo3bqJNMWb4xQzdaGdrYT=n5zRvtw@mail.gmail.com> <20201016085217.GA12323@arm.com>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Ionela Voinescu <ionela.voinescu@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        "open list\:ARM\/Amlogic Meson..." 
        <linux-amlogic@lists.infradead.org>, Da Xue <da@libre.computer>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mailbox: cancel timer before starting it
In-reply-to: <20201016085217.GA12323@arm.com>
Date:   Fri, 16 Oct 2020 11:00:37 +0200
Message-ID: <1jk0vqk0ju.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri 16 Oct 2020 at 10:52, Ionela Voinescu <ionela.voinescu@arm.com> wrote:

> On Thursday 15 Oct 2020 at 13:45:54 (-0500), Jassi Brar wrote:
> [..]
>> > >> --- a/drivers/mailbox/mailbox.c
>> > >> +++ b/drivers/mailbox/mailbox.c
>> > >> @@ -82,9 +82,13 @@ static void msg_submit(struct mbox_chan *chan)
>> > >>  exit:
>> > >>      spin_unlock_irqrestore(&chan->lock, flags);
>> > >>
>> > >> -    if (!err && (chan->txdone_method & TXDONE_BY_POLL))
>> > >> -            /* kick start the timer immediately to avoid delays */
>> > >> +    if (!err && (chan->txdone_method & TXDONE_BY_POLL)) {
>> > >> +            /* Disable the timer if already active ... */
>> > >> +            hrtimer_cancel(&chan->mbox->poll_hrt);
>> > >> +
>> > >> +            /* ... and kick start it immediately to avoid delays */
>> > >>              hrtimer_start(&chan->mbox->poll_hrt, 0, HRTIMER_MODE_REL);
>> > >> +    }
>> > >>  }
>> > >>
>> > >>  static void tx_tick(struct mbox_chan *chan, int r)
>> > >
>> > > I've tracked a regression back to this commit. Details to reproduce:
>> >
>> > Hi Ionela,
>> >
>> > I don't have access to your platform and I don't get what is going on
>> > from the log below.
>> >
>> > Could you please give us a bit more details about what is going on ?
>> >
>> > All this patch does is add hrtimer_cancel().
>> > * It is needed if the timer had already been started, which is
>> >   appropriate AFAIU
>> > * It is a NO-OP is the timer is not active.
>> >
>> Can you please try using hrtimer_try_to_cancel() instead ?
>> 
>
> Yes, using hrtimer_try_to_cancel() instead works for me. But doesn't
> this limit how effective this change is? AFAIU, this will possibly only
> reduce the chances for the race condition, but not solve it.
>

It is also my understanding, hrtimer_try_to_cancel() would remove a
timer which as not already started but would return withtout doing
anything if the callback is already running ... which is the original
problem


> Thanks,
> Ionela.
>
>> thanks

