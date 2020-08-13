Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 711B5243C71
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Aug 2020 17:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgHMP0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Aug 2020 11:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbgHMP0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 11:26:52 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1F7C061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 08:26:51 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id 1so3107323vsl.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 08:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1s5slD5xTRFFbW+h5M8Mtfy1B797ut+y2+cHY1OmjLY=;
        b=WHqM+7gQMzNV59fPJeZs3rGKhbE9qM3WyS4WwK4osQC4YO4qDuGUt6LJ9FM8egQwUC
         VytnE4Zh2KYSkKeCXP4g/2ZrFQ0UTbqr49Ky7xXOH0E+VX1VQ7SHKP5HibHklBsLX0Lb
         zD8EqdHy3tjHuz3ZMqgWbofxY0x5cqC77Plqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1s5slD5xTRFFbW+h5M8Mtfy1B797ut+y2+cHY1OmjLY=;
        b=MrE3iIrDw7oPfSQMdTa7LmzHpSjE51xKqpAWXW5wwMr8T3EUEuE/wZNcVxSTlRJQGl
         kKVnWrS1aGCG+1iQ/awRY2BHVmthEtPHf+9v2cSaLB6JG/gJ/ems7266xOkkg3laomx4
         SvO+gGuHZijMjy6wriJ0Tz1lM5fhwuvlqpDR0YnMfD0IwHiiwbCO6Zp/R2D3jhqIAjGG
         9aa9Xjuzbtkn6soH/IgbxjarmFoNBPzJaqnRrnO6FZKr8CPzBVIfIotafW0q7jfa7I47
         8b6cuS7ycxoy9steCTbTbafKc5x0mHZ4n+mwN6vJdw1ackqrlBBdTPBw/kdRO+rHrbrO
         +SGA==
X-Gm-Message-State: AOAM530ao3hX/4GfriRIXpRAVtIPOTN23NfHTcUstXUfAbnM+Exhe2R2
        Ws3I9NumiI849sG5Uq2xoYnl+ncRQh8=
X-Google-Smtp-Source: ABdhPJyFMCM2JEXsHrt/1uzHmG9WZcyFRxGUSWwGirG7cUzQjuqdAAiCz90xDJJWZiJb5f4VLQPPFA==
X-Received: by 2002:a67:e9d6:: with SMTP id q22mr3650276vso.232.1597332410763;
        Thu, 13 Aug 2020 08:26:50 -0700 (PDT)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id j20sm613883ual.9.2020.08.13.08.26.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2020 08:26:49 -0700 (PDT)
Received: by mail-ua1-f52.google.com with SMTP id k18so638442uao.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 08:26:49 -0700 (PDT)
X-Received: by 2002:ab0:37d3:: with SMTP id e19mr3760000uav.64.1597332408240;
 Thu, 13 Aug 2020 08:26:48 -0700 (PDT)
MIME-Version: 1.0
References: <1595333413-30052-1-git-send-email-sumit.garg@linaro.org>
 <CAFA6WYMN=na4Pxnu1LYRVAAZRdV==5EwU-Vcq-QkRb_jaLiPmw@mail.gmail.com>
 <20200811135801.GA416071@kroah.com> <CAFA6WYMN8i96rEZuHLnskB+4k0o=K9vF1_we83P04h2BSoGjmQ@mail.gmail.com>
 <20200811145816.GA424033@kroah.com> <CAD=FV=UD=cTn6jwpYS-C-=1ORd-4azZ8ZiBR6om++2sMS1nmMg@mail.gmail.com>
 <CAFA6WYPBdOiVsKR_hSLpigN_1b9jimXKaqyRZjvKSx3xpAmLjA@mail.gmail.com>
 <CAD=FV=WccmFRkV4UUTLSYR9+7210h00Si=nG4tRs3BBuweA6ng@mail.gmail.com>
 <CAD=FV=V8UhQVQvcAp6XCmT3=6FYM=_zPELy4FTj4kMKUswaR8Q@mail.gmail.com> <CAFA6WYPxieH6ZTa_BFdaLuiwbqAs6r7eKmxG7ci4XtyRONGN7g@mail.gmail.com>
In-Reply-To: <CAFA6WYPxieH6ZTa_BFdaLuiwbqAs6r7eKmxG7ci4XtyRONGN7g@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 13 Aug 2020 08:26:36 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WGh-+GTsg3-UDr-Ht48n3sRqAJ76PJVFcFuJ1ruFEqOw@mail.gmail.com>
Message-ID: <CAD=FV=WGh-+GTsg3-UDr-Ht48n3sRqAJ76PJVFcFuJ1ruFEqOw@mail.gmail.com>
Subject: Re: [RFC 0/5] Introduce NMI aware serial drivers
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-serial@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
        Jiri Slaby <jslaby@suse.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Jason Wessel <jason.wessel@windriver.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Aug 13, 2020 at 2:25 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> > One other idea occurred to me that's maybe simpler.  You could in
> > theory just poll the serial port periodically to accomplish.  It would
> > actually probably even work to call the normal serial port interrupt
> > routine from any random CPU.  On many serial drivers the entire
> > interrupt handler is wrapped with:
> >
> > spin_lock_irqsave(&uap->port.lock, flags);
> > ...
> > spin_unlock_irqrestore(&uap->port.lock, flags);
> >
> > And a few (the ones I was involved in fixing) have the similar pattern
> > of using uart_unlock_and_check_sysrq().
> >
> > Any serial drivers following this pattern could have their interrupt
> > routine called periodically just to poll for characters and it'd be
> > fine, right?  ...and having it take a second before a sysrq comes in
> > this case is probably not the end of the world?
> >
>
> Are you proposing to have complete RX operation in polling mode with
> RX interrupt disabled (eg. using a kernel thread)?

No, I'm suggesting a hybrid approach.  Leave the interrupts enabled as
usual, but _also_ poll every 500 ms or 1 second (maybe make it
configurable?).  In some serial drivers (ones that hold the lock for
the whole interrupt routine) this polling function could actually be
the same as the normal interrupt handler so it'd be trivially easy to
implement and maintain.

NOTE: This is not the same type of polling that kgdb does today.  The
existing polling is really only intended to work when we're dropped
into the debugger.  This would be more like a "poll_irq" type function
that would do all the normal work the interrupt did and is really just
there in the case that the CPU that the interrupt is routed to is
locked up.


> > One nice benefit of this is that it would actually work _better_ on
> > SMP systems for any sysrqs that aren't NMI safe.  Specifically with
> > your patch series those would be queued with irq_work_queue() which
> > means they'd be blocked if the CPU processing the NMI is stuck with
> > IRQs disabled.
>
> Yes, the sysrq handlers which aren't NMI safe will behave similarly to
> existing IRQ based sysrq handlers.
>
> > With the polling mechanism they'd nicely just run on a
> > different CPU.
>
> It looks like polling would cause much CPU overhead. So I am not sure
> if that is the preferred approach.

Maybe now it's clearer that there should be almost no overhead.  When
dealing with a SYSRQ it's fine if there's a bit of a delay before it's
processed, so polling every 1 second is probably fine.

-Doug
