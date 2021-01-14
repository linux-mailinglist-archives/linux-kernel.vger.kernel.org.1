Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C77A72F689F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 19:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbhANR7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:59:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727521AbhANR7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:59:11 -0500
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090EEC061757
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:58:31 -0800 (PST)
Received: by mail-vk1-xa2d.google.com with SMTP id k9so1557251vke.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5YdOaaHjca0rYPpPUAffL10YdPt1OqFdTLx234rktqs=;
        b=HiNnszXGd3KvwHl5TsEFq5Iqm36WlMI50MI7Np7EAgpZRcUf17UC4jUR+eUhbShJdO
         dvkDlSOAAi2Jzj4BwMRuQIjUPbJ/e9UAiTbPH3KexikDlisiTj4cPGD7fA72o8DFWugT
         X+/i7a3Ofta23WFwn8TlbR1PdrQmNUkpbodS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5YdOaaHjca0rYPpPUAffL10YdPt1OqFdTLx234rktqs=;
        b=pSqmpVYhJRRlwFyA+lRN0nxFEk/gFd+qW1OOYj4V4/PTDP2st7ZWZIDo33gObctbr4
         Bgjy5PNavHoWQ5JWHM5J0ikp6ByjNg5mt93TcXxQReqfkV2/ezLLDOd/S4WdlFy4nF8J
         Zr4KsufrSs2Tn1j5WsRAVxbPd8fjLmdwkaiWsf2mL1DkekArTxkEnNLumaZIK4O7WAXj
         sI3DzlaSm1BLX/3UMTPCBl6wDTRQapEo0LIhogSlX4Pz3CEBGVehn5oGN3Cn0NuHojQm
         ZOEvemOaBT1m6lQe71GVrpLQt7DIQ7yRo703QfWKRnVfcaAC7Y5M0YOAxTWfAaeuluZ3
         KbPg==
X-Gm-Message-State: AOAM533/x1e+iX/UcCsPLxi3sCVCtD87s3I4VB9xsSGU0ud1+UdIv7as
        P4Z1Z8NKhN6iH53R1d6tt61NwvfHV33wJw==
X-Google-Smtp-Source: ABdhPJwtT2xPGT6e6AeoXSjsFuUJKfWB2uvXqxbBBiCcdEvjY5KCP5KT0MLJiOYtipv4n343mPXExw==
X-Received: by 2002:a1f:a697:: with SMTP id p145mr7416885vke.23.1610647109839;
        Thu, 14 Jan 2021 09:58:29 -0800 (PST)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com. [209.85.221.169])
        by smtp.gmail.com with ESMTPSA id 66sm774934vsw.32.2021.01.14.09.58.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jan 2021 09:58:28 -0800 (PST)
Received: by mail-vk1-f169.google.com with SMTP id k9so1557212vke.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:58:28 -0800 (PST)
X-Received: by 2002:a1f:c305:: with SMTP id t5mr7529788vkf.7.1610647107578;
 Thu, 14 Jan 2021 09:58:27 -0800 (PST)
MIME-Version: 1.0
References: <20210108093339.v5.1.I3ad184e3423d8e479bc3e86f5b393abb1704a1d1@changeid>
 <20210108093339.v5.4.I7cf3019783720feb57b958c95c2b684940264cd1@changeid>
 <161060848425.3661239.17417977666663714149@swboyd.mtv.corp.google.com> <YAB8G137wfisfOqt@builder.lan>
In-Reply-To: <YAB8G137wfisfOqt@builder.lan>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 14 Jan 2021 09:58:15 -0800
X-Gmail-Original-Message-ID: <CAD=FV=V6O_16vdyU+d0gFeKUuS=sfGd1EKDZJt=NdAgp5osQjQ@mail.gmail.com>
Message-ID: <CAD=FV=V6O_16vdyU+d0gFeKUuS=sfGd1EKDZJt=NdAgp5osQjQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] pinctrl: qcom: Don't clear pending interrupts when enabling
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
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

On Thu, Jan 14, 2021 at 9:15 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> > > @@ -195,6 +201,20 @@ static int msm_pinmux_set_mux(struct pinctrl_dev *pctldev,
> > >         if (WARN_ON(i == g->nfuncs))
> > >                 return -EINVAL;
> > >
> > > +       /*
> > > +        * If an GPIO interrupt is setup on this pin then we need special
> > > +        * handling.  Specifically interrupt detection logic will still see
> > > +        * the pin twiddle even when we're muxed away.
> > > +        *
> > > +        * When we see a pin with an interrupt setup on it then we'll disable
> > > +        * (mask) interrupts on it when we mux away until we mux back.  Note
> > > +        * that disable_irq() refcounts and interrupts are disabled as long as
> > > +        * at least one disable_irq() has been called.
> > > +        */
> > > +       if (d && i != gpio_func &&
> > > +           !test_and_set_bit(d->hwirq, pctrl->disabled_for_mux))
> > > +               disable_irq(irq);
> >
> > Does it need to be forced non-lazy so that it is actually disabled at
> > the GIC? I'm trying to understand how the lazy irq disabling plays into
> > this. I think it's a don't care situation because if the line twiddles
> > and triggers an irq then we'll actually disable it at the GIC in the
> > genirq core and mark it pending for resend. I wonder if we wouldn't have
> > to undo the pending state if we actually ignored it at the GIC
> > forcefully. And I also worry that it may cause a random wakeup if the
> > line twiddles, becomes pending at GIC and thus blocks the CPU from
> > running a WFI but it isn't an irq that Linux cares about because it's
> > muxed to UART, and then lazy handling runs and shuts it down. Is that
> > possible?
> >
>
> I was about to write a question about why we should disable the IRQ
> through the irqchip framework, rather than just do it in the hardware
> directly.
>
> Which I think means that I came to the same conclusion as you, that if
> we have a pin masked to non-gpio, it will still wake the system up, just
> to actually disable the IRQ lazily.
>
> Is there a problem with leaving the irq framework to believe the IRQ is
> enabled while we disable the delivery in hardware?

Earlier I had it disabling in hardware, but doing it through the IRQ
framework has the advantage of doing refcounting for us and that saves
us complexity.  If we tweaked the hardware directly we'd have to worry
about this case:

a) Client muxes away the pin: we disable in hardware
b) Client tries to disable/mask the interrupt themselves.
c) Client tries to enable/unmask the interrupt themselves

...when we got the call for c) we'd have to realize that we're still
muxed away and we'd have to ignore their request.  Also, if the mux
back happened in step b) we'd have to know _not_ to unmask the
interrupt.  Trying to solve those corner cases adds complexity.  If we
just rely on the refcounting the complexity goes away.


-Doug
