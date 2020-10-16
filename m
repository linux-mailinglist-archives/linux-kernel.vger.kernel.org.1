Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9827E290BDF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 20:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407178AbgJPSy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 14:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406782AbgJPSy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 14:54:59 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D75C061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 11:54:58 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id cm24so3535506edb.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 11:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=OBFJ5RfCXY9bpxl1TWGCyUY+dYqJSSwXVnmVFww6Des=;
        b=bkVHQhFML0mSWmvehN1DzB5vqdG7YlLmI0KDHoLbb/5+B/rdu79GY8TIfrA2ciP261
         C91zwYDMVuZMkHsVUilPL0yazA3dkF7E42VjFD2EXviznbjwW1P/kjOFQpRG2S+iFTpI
         wYG1Jrn9VVqRxdJqEMyt6jAhwdi475szMSRdNmXKmNQW3iTZPRyTeW3nuk0t0C3m3jpA
         +ZRr4ATDFD1eeJlhz74tNgl35yjjVPhdppKOmnBUy0SWfDeU2K4Oxmd9jjl67Wng8XOH
         P2KSTtlhfTp3aAuSzeKpubN44rtYEtSxamSZJHuQ1uU/2JlsZif6SE+ar3v1gccInOMB
         52KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=OBFJ5RfCXY9bpxl1TWGCyUY+dYqJSSwXVnmVFww6Des=;
        b=nNZuQtSnCqVU1ORMMkcdL0er/NFRUnRFPEb5Wdno3hWknFTSs+VHeSGGAul6gpSQd+
         6z69WdwQBTD90bz8FI5rTZ4YHIZ8ZCK9KvW4oSt2ctjzV4NI36MiXTgekTSApohuns1a
         8UrQt6aZ2Iuh38W4p6uSzjAZBWVW4FGOOtAncAqhf33MrKVbSzsGwvGKruwFmIktQKSI
         sTakAI6owXQkpmt8D351/XLFak8Mxj0OmY7topO+NPRdNHyQt2/Nf9qdE+kfbALTCfOI
         xi9fgXGMhrfnLaS2Pr69uJemtsoTmzKJe9lS4lqiVKfODcd1yg8Qk7zrzJd/Tmrmpe3s
         kaEQ==
X-Gm-Message-State: AOAM530lSp4enWu9J63W2VKNWnAuPRluphlXDa42XaTBNpGFx2yoVwtC
        adLmev5YAYWZMY5vqdDBDb37oQ==
X-Google-Smtp-Source: ABdhPJzSOaPwv6Mp9iJ+YDKakY+j87fCgJz/D0gy5zxV8nBfwtNHNXPwVTdQ4RVpzWD+YMZjr2nnTA==
X-Received: by 2002:a50:b745:: with SMTP id g63mr5595037ede.181.1602874497505;
        Fri, 16 Oct 2020 11:54:57 -0700 (PDT)
Received: from localhost (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.gmail.com with ESMTPSA id h17sm2527030ejf.98.2020.10.16.11.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 11:54:56 -0700 (PDT)
References: <20200923123916.1115962-1-jbrunet@baylibre.com> <20201015134628.GA11989@arm.com> <1jlfg7k2ux.fsf@starbuckisacylon.baylibre.com> <CABb+yY1-MBac0e6xQwWkHRo3bqJNMWb4xQzdaGdrYT=n5zRvtw@mail.gmail.com> <20201016085217.GA12323@arm.com> <1jk0vqk0ju.fsf@starbuckisacylon.baylibre.com> <CABb+yY0pDxQ7B+NPsEz325-_X2nSJngnfER7uOLVyoBLoH37cA@mail.gmail.com>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Ionela Voinescu <ionela.voinescu@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        "open list\:ARM\/Amlogic Meson..." 
        <linux-amlogic@lists.infradead.org>, Da Xue <da@libre.computer>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mailbox: cancel timer before starting it
In-reply-to: <CABb+yY0pDxQ7B+NPsEz325-_X2nSJngnfER7uOLVyoBLoH37cA@mail.gmail.com>
Date:   Fri, 16 Oct 2020 20:54:55 +0200
Message-ID: <1jft6ej91c.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri 16 Oct 2020 at 19:33, Jassi Brar <jassisinghbrar@gmail.com> wrote:

> On Fri, Oct 16, 2020 at 4:00 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
>>
>>
>> On Fri 16 Oct 2020 at 10:52, Ionela Voinescu <ionela.voinescu@arm.com> wrote:
>>
>> > On Thursday 15 Oct 2020 at 13:45:54 (-0500), Jassi Brar wrote:
>> > [..]
>> >> > >> --- a/drivers/mailbox/mailbox.c
>> >> > >> +++ b/drivers/mailbox/mailbox.c
>> >> > >> @@ -82,9 +82,13 @@ static void msg_submit(struct mbox_chan *chan)
>> >> > >>  exit:
>> >> > >>      spin_unlock_irqrestore(&chan->lock, flags);
>> >> > >>
>> >> > >> -    if (!err && (chan->txdone_method & TXDONE_BY_POLL))
>> >> > >> -            /* kick start the timer immediately to avoid delays */
>> >> > >> +    if (!err && (chan->txdone_method & TXDONE_BY_POLL)) {
>> >> > >> +            /* Disable the timer if already active ... */
>> >> > >> +            hrtimer_cancel(&chan->mbox->poll_hrt);
>> >> > >> +
>> >> > >> +            /* ... and kick start it immediately to avoid delays */
>> >> > >>              hrtimer_start(&chan->mbox->poll_hrt, 0, HRTIMER_MODE_REL);
>> >> > >> +    }
>> >> > >>  }
>> >> > >>
>> >> > >>  static void tx_tick(struct mbox_chan *chan, int r)
>> >> > >
>> >> > > I've tracked a regression back to this commit. Details to reproduce:
>> >> >
>> >> > Hi Ionela,
>> >> >
>> >> > I don't have access to your platform and I don't get what is going on
>> >> > from the log below.
>> >> >
>> >> > Could you please give us a bit more details about what is going on ?
>> >> >
>> >> > All this patch does is add hrtimer_cancel().
>> >> > * It is needed if the timer had already been started, which is
>> >> >   appropriate AFAIU
>> >> > * It is a NO-OP is the timer is not active.
>> >> >
>> >> Can you please try using hrtimer_try_to_cancel() instead ?
>> >>
>> >
>> > Yes, using hrtimer_try_to_cancel() instead works for me. But doesn't
>> > this limit how effective this change is? AFAIU, this will possibly only
>> > reduce the chances for the race condition, but not solve it.
>> >
>>
>> It is also my understanding, hrtimer_try_to_cancel() would remove a
>> timer which as not already started but would return withtout doing
>> anything if the callback is already running ... which is the original
>> problem
>>
> If we are running in the callback path, hrtimer_try_to_cancel will
> return -1, in which case we could skip hrtimer_start.
> Anyways, I think simply checking for hrtimer_active should effect the same.
> I have submitted a patch, of course not tested.

Yes it sloves this race but ...

If a race is possible between a timer callback rescheduling itself (which
is not that uncommon) and another thread trying to cancel it, maybe
there is something worth fixing in hrtimer ? Also, mailbox calls
hrtimer_cancel() in unregister ... are we confident this would work ?

Any fix is by me - yours avoid killing and restarting the timer :) but
it feels like we are working around an issue that might bite us back
later on.

>
> Thanks

