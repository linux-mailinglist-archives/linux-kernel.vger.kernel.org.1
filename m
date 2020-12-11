Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDEF2D6C34
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 01:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732702AbgLJXvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 18:51:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732765AbgLJXvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 18:51:00 -0500
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD051C061793
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 15:50:19 -0800 (PST)
Received: by mail-vs1-xe41.google.com with SMTP id j140so3858215vsd.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 15:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pjYy5Bl3/aduddVWQ9MWnVeXMprhMcZYGBH0P+DQDBo=;
        b=EXJ6gnsnrAQOJ/s129D2lg7EFMcZQkafhwpuLSAr5ElkjGMGSxKsTtraCwyE+l2N9c
         kH1m1fc0icv2IdakS3e/47ZEU4ULSZXsJhQj6QfkrDpc7Sc/cxQrpe/uB6tjJuB5BYZO
         KZDbNar5iD8fGfDvJNaWmDq0StcY/Z8b+Jrx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pjYy5Bl3/aduddVWQ9MWnVeXMprhMcZYGBH0P+DQDBo=;
        b=RqAys7pob868IYambM4e+6bXHDppKxOIuIkAf7Pe/LXoZsSwDLB2Fd5ZLF2PB7ri1y
         Gab9a+gVc3YeLNIuSha12Dyz4sg6PBg8aeSKCefBuCeknSYuu9nwrX3JlWRBs8GOuPpp
         FEmrWoxByvCkf/uDPxqhOA9LJmg98Nd3gE2x8rd14DZEdzRzjhk5fmdnwn4wjWwveKpo
         kmNIa2htiJxikuaGRbqcrnLCZBgcU4VyZbrI8brUKz9U4UGntK3J5I8qlsiu3DMPCrpG
         DHU7Ebc0359tjmFv1DwUt6JD10RGQTaGTMYEeePcujtu5L+sgWU8aWrBlSIy0aK3I+J/
         ylDw==
X-Gm-Message-State: AOAM531SaF/2xkAIiciwSFx6FItKnI46kih6ax+jL9bLCd0pSa0NeMpG
        4R29AD8kp33RQ6Phsd2g/k1zJ7AY3d5f8w==
X-Google-Smtp-Source: ABdhPJzeXX4uCr+O5dzR/kMRpCyZAS6XAi3k3HJD8KuFjJoIowEgGifk85lxxdZnFdnCoW+jBLbLKg==
X-Received: by 2002:a67:2e16:: with SMTP id u22mr5829727vsu.12.1607644218223;
        Thu, 10 Dec 2020 15:50:18 -0800 (PST)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id k64sm718250vsk.15.2020.12.10.15.50.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 15:50:17 -0800 (PST)
Received: by mail-ua1-f53.google.com with SMTP id s42so2295744uad.11
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 15:50:17 -0800 (PST)
X-Received: by 2002:ab0:2e99:: with SMTP id f25mr10916179uaa.104.1607644216565;
 Thu, 10 Dec 2020 15:50:16 -0800 (PST)
MIME-Version: 1.0
References: <20201203074459.13078-1-rojay@codeaurora.org> <CAD=FV=XKyXnjsM4iS-ydRWBnmYMojPOaYAdYhOkxkPTCQf0RLQ@mail.gmail.com>
 <160757022002.1580929.8656750350166301192@swboyd.mtv.corp.google.com>
 <CAD=FV=WtU3cnRe6pDKFMA9_0cnQFtSOyohY_bJwZObK+KrbhVQ@mail.gmail.com>
 <160764107797.1580929.14768824290834396298@swboyd.mtv.corp.google.com>
 <CAD=FV=WuQjKC6GHy8d2nuqS-fgsUfxYrJosg3eyC9JU1FPCcjw@mail.gmail.com> <160764316821.1580929.18177257779550490986@swboyd.mtv.corp.google.com>
In-Reply-To: <160764316821.1580929.18177257779550490986@swboyd.mtv.corp.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 10 Dec 2020 15:50:04 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WvG085orLqnvg9WUobL7iyxwgoxh-8RvOaRdi9rLeDUg@mail.gmail.com>
Message-ID: <CAD=FV=WvG085orLqnvg9WUobL7iyxwgoxh-8RvOaRdi9rLeDUg@mail.gmail.com>
Subject: Re: [PATCH] spi: spi-geni-qcom: Fix NULL pointer access in geni_spi_isr
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Roja Rani Yarubandi <rojay@codeaurora.org>,
        Mark Brown <broonie@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Akash Asthana <akashast@codeaurora.org>,
        msavaliy@qti.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Dec 10, 2020 at 3:32 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Doug Anderson (2020-12-10 15:07:39)
> > Hi,
> >
> > On Thu, Dec 10, 2020 at 2:58 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > > right? It will only ensure that other irq handlers have completed, which
> > > may be a problem, but not the only one.
> > >
> > > TL;DR: Peek at the irq status register in the timeout logic and skip it
> > > if the irq is pending?
> >
> > I don't have tons of experience with synchronize_irq(), but the
> > function comment seems to indicate that as long as the interrupt is
> > pending synchronize_irq() will do what we want even if the CPU that
> > should handle the interrupt is in an irqsoff section.  Digging a
> > little bit I guess it relies upon the interrupt controller being able
> > to read this state, but (hopefully) the GIC can?
>
> I didn't read synchronize_irq() more than the single line summary. I
> thought it would only make sure other irq handlers have finished, which
> is beside the point of some long section of code that has disabled irqs
> on CPU0 with local_irq_disable(). And further more, presumably the irq
> handler could be threaded, and then we could put a sufficiently large
> msleep() at the start of geni_spi_isr() and see the same problem?

As I understand it synchronize_irq():
1. If the interrupt is not running but is pending at a hardware level,
it'll wait.
2. If the interrupt is currently running it waits for it to finish.

That should handle all the cases you're talking about including
waiting for the threaded IRQ handler.  There's an explicit comment
about the threaded IRQ being accounted for in synchronize_irq():

https://elixir.bootlin.com/linux/v5.9/source/kernel/irq/manage.c#L134


> > If it doesn't work like I think it does, I'd be OK with peeking in the
> > IRQ status register, but we shouldn't _skip_ the logic IMO.  As long
> > as we believe that an interrupt could happen in the future we
> > shouldn't return from handle_fifo_timeout().  It's impossible to
> > reason about how future transfers would work if the pending interrupt
> > from the previous transfer could fire at any point.
>
> Right. I just meant skip the timeout handling logic. We'd have to go
> back to the timeout and keep waiting until the irq handler can run and
> complete the completion variable.
>
> I forgot that this is half handled in the spi core though. Peeking at
> m_irq doesn't look very easy to implement. It certainly seems like this
> means the timeout handler is busted and the diagram earlier could
> indicate that spi core is driving this logic from
> spi_transfer_one_message().

My assumption was that it was still OK (even if not perfect) to still
process it as a timeout.  I just want to really make sure a future
interrupt isn't going to show up.

If we want to try to do better, we can do timeout handling ourselves.
The SPI core allows for that.


> So why don't we check for cur_xfer being NULL in the rx/tx handling
> paths too and bail out there? Does the FIFO need to be cleared out in
> such a situation that spi core thinks a timeout happened but there's RX
> data according to m_irq? Do we need to read it all and throw it away? Or
> does the abort/cancel clear out the RX fifo?

I don't know for sure, but IMO it's safest to read anything that's in
the FIFO.  It's also important to adjust the watermark in the TX case.
The suggestions I provided in my original reply (#2 and #3) handle
this and are plenty simple.

As per my original reply, though, anything we do in the ISR doesn't
replace the changes we need to make to handle_fifo_timeout().  It is
very important that when handle_fifo_timeout() finishes that no future
interrupts for old transfers will fire.


-Doug
