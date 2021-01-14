Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7542A2F68A7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 19:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729368AbhANR7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727866AbhANR7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:59:50 -0500
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18224C061793
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:59:10 -0800 (PST)
Received: by mail-vk1-xa2c.google.com with SMTP id j67so87942vkh.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cz0tsrbAp4J6l7RsEf2Pv8xlQn94CaKqh/df2X8z3kE=;
        b=ls5qH5qlMW2Ab+x10vTc3X6jxoMnABspbCHmjRxjVQRPjmX2mJQmhcvD1dNdXAHJ09
         xmQ3pdTTkICs7usutsqCC27+Ukz5AoWk9ASAhpF3wIpF89KDY/pThL5WllY43UFu1HHD
         b4aOg44rQtvC9/ZpPZesZ/0FRr78j7TzBnUyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cz0tsrbAp4J6l7RsEf2Pv8xlQn94CaKqh/df2X8z3kE=;
        b=lw5GqnSMgooNaF2et1C2M/webn7ln+WMj/PfpPkWsqvNiwcc0/XJFRZGsDfF8j0Dii
         iiSDRc4ffX8VeqbcfrR836tfDPQw03fb2WBdw3lCdCrpaG1W5mYcmCHkZHK7hmuKwC80
         8QnPyliyg7NxzSaDuBdxQoFPQr2EwuyHDzG5m9bHBHy1ftYxtDRwFdjssAztXRsPy9GL
         tpRxRN/cE17TpYBWV+Wp8VkqpRsMNCucJy8vt9CT+Rw4RzTt9M5ySr5rLq65t6QThrfC
         Xi16DRzasjUsFH5WnWCht1dF2BkyLSxOALV3qx1CumLhv5oDYK56uh0UqD/RUpi9x60R
         5Zyw==
X-Gm-Message-State: AOAM532EgzKmT2aVbqZKWM+afZ7cTbylq7Da6QCts/0F346TqMcsWnjY
        xtt/kbk7iaEJxgUYQbXCDlMgWfRLzzN+hQ==
X-Google-Smtp-Source: ABdhPJwTNyQyZJyl6xVj6uUBGLjeaghUKhRMc7Ql/csxhePsA9fwFAuEch6wrV/4yDVcWkXFtt31WA==
X-Received: by 2002:ac5:cca9:: with SMTP id p9mr7570601vkm.2.1610647148973;
        Thu, 14 Jan 2021 09:59:08 -0800 (PST)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id f9sm778967uad.4.2021.01.14.09.59.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jan 2021 09:59:08 -0800 (PST)
Received: by mail-ua1-f47.google.com with SMTP id j59so2041627uad.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:59:08 -0800 (PST)
X-Received: by 2002:ab0:35fa:: with SMTP id w26mr6652330uau.90.1610647147613;
 Thu, 14 Jan 2021 09:59:07 -0800 (PST)
MIME-Version: 1.0
References: <20210108093339.v5.1.I3ad184e3423d8e479bc3e86f5b393abb1704a1d1@changeid>
 <20210108093339.v5.4.I7cf3019783720feb57b958c95c2b684940264cd1@changeid> <161060848425.3661239.17417977666663714149@swboyd.mtv.corp.google.com>
In-Reply-To: <161060848425.3661239.17417977666663714149@swboyd.mtv.corp.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 14 Jan 2021 09:58:55 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Vg1PNVPhCH9GPX=F9-EHhSGF9NaXfui+rM4SQEtA=ZMA@mail.gmail.com>
Message-ID: <CAD=FV=Vg1PNVPhCH9GPX=F9-EHhSGF9NaXfui+rM4SQEtA=ZMA@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] pinctrl: qcom: Don't clear pending interrupts when enabling
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Jason Cooper <jason@lakedaemon.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Srinivas Ramana <sramana@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jan 13, 2021 at 11:14 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> > @@ -195,6 +201,20 @@ static int msm_pinmux_set_mux(struct pinctrl_dev *pctldev,
> >         if (WARN_ON(i == g->nfuncs))
> >                 return -EINVAL;
> >
> > +       /*
> > +        * If an GPIO interrupt is setup on this pin then we need special
> > +        * handling.  Specifically interrupt detection logic will still see
> > +        * the pin twiddle even when we're muxed away.
> > +        *
> > +        * When we see a pin with an interrupt setup on it then we'll disable
> > +        * (mask) interrupts on it when we mux away until we mux back.  Note
> > +        * that disable_irq() refcounts and interrupts are disabled as long as
> > +        * at least one disable_irq() has been called.
> > +        */
> > +       if (d && i != gpio_func &&
> > +           !test_and_set_bit(d->hwirq, pctrl->disabled_for_mux))
> > +               disable_irq(irq);
>
> Does it need to be forced non-lazy so that it is actually disabled at
> the GIC?

Yes, I think non-lazy is important.  Specifically at the end I assume
that I can clear the interrupt in hardware and it will go away and
Linux never saw it.  If it was lazy, it's possible Linux saw the
interrupt and has it marked with IRQS_PENDING.

Right now we get non-lazy because we have "disable" implemented, so it
works fine.  I can be explicit.  Do I add a call to
msm_gpio_irq_reqres() like:

  irq_set_status_flags(d->irq, IRQ_DISABLE_UNLAZY);

I'll wait for feedback if you think this is the right way to go before
sending the next version.


> I'm trying to understand how the lazy irq disabling plays into
> this. I think it's a don't care situation because if the line twiddles
> and triggers an irq then we'll actually disable it at the GIC in the
> genirq core and mark it pending for resend.

I think the marking as pending is a problem.  When we finally mux back
to GPIO we want to clear out anything that showed up while it was
muxed away and I'm not aware of a way to clear "IRQS_PENDING".


> I wonder if we wouldn't have
> to undo the pending state if we actually ignored it at the GIC
> forcefully. And I also worry that it may cause a random wakeup if the
> line twiddles, becomes pending at GIC and thus blocks the CPU from
> running a WFI but it isn't an irq that Linux cares about because it's
> muxed to UART, and then lazy handling runs and shuts it down. Is that
> possible?

I believe if the interrupt is masked at the GIC then it won't cause
wakeups.  Specifically to get wakeup stuff working we had to unmask
the interrupt at the GIC level.


> > +
> >         raw_spin_lock_irqsave(&pctrl->lock, flags);
> >
> >         val = msm_readl_ctl(pctrl, g);
> > @@ -204,6 +224,20 @@ static int msm_pinmux_set_mux(struct pinctrl_dev *pctldev,
> >
> >         raw_spin_unlock_irqrestore(&pctrl->lock, flags);
> >
> > +       if (d && i == gpio_func &&
> > +           test_and_clear_bit(d->hwirq, pctrl->disabled_for_mux)) {
> > +               /*
> > +                * Clear interrupts detected while not GPIO since we only
> > +                * masked things.
> > +                */
> > +               if (d->parent_data && test_bit(d->hwirq, pctrl->skip_wake_irqs))
> > +                       irq_chip_set_parent_state(d, IRQCHIP_STATE_PENDING, false);
>
> So if not lazy this could go away?

I don't think so.  If lazy we could have a pending interrupt tracked
in two places: in Linux and in the parent if this happened:
* disable_irq() - do nothing except mark that IRQ is disalbed.
* IRQ happened - track in Linux and actually disable (mask) the interrupt
* IRQ happened again - still tracked in Linux but now also latched in
hardware (but masked)

...so if it was lazy we'd need to clear the interrupt in two places.
With non-lazy we only have to clear the latch that happened in
hardware, right?

> Although I think this is to clear out
> the pending state in the GIC and not the PDC which is the parent.

Yeah, it clears the state that was latched in the GIC.  It just passes
through the PDC code on the way there.
