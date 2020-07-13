Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFFD321895C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 15:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729586AbgGHNmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 09:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729136AbgGHNmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 09:42:16 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC1FC061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 06:42:16 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id q15so13732734vso.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 06:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EBkLug3cPyoXl+ulMF1qw8Y1K3XzRcw29bM5tOQuRrQ=;
        b=bpcNa/zMls02QjpRksmgtZ/xkWZh7awnjLCkRUKaalbhfNMVFGrJyG4PRFgZCOYMbE
         gH3G/QWTynwQTMzUhTVNq1tCIBOY6Q9rlAicsboW1ELB7bjgPN+M3Huu2XrkQBWTvwWu
         vPRWoyOtm2asBJcULk9PcaX2rWGWZsF4vmgAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EBkLug3cPyoXl+ulMF1qw8Y1K3XzRcw29bM5tOQuRrQ=;
        b=X9WTQsnjZxJBflArscUXG52lfYtfDp9JaiHi5NJrJvEI3F6cVcX4lCl35iKuAolVNn
         3ZMP1jydB6RIbAE9ueoNHMAeA1HWNyBg/SVne37r1r5z0rIr7g2K7+Nq9WFkxOrkJk8h
         D3FrD6MBtTjAEJIyNnovx0wi40EyXXC4JNOVjLhGYLozj+lcP0jVQJySsGrVvpAtiRYg
         357t5z07MJtAcVo7Rsjpn3e7D/Id9p2J3znhAhER4XHbDCW5DTS79ucq9TheVNSxVMfr
         NAAeKEjvBZTNJpGASS7Z7wZHv4FO5iyHujjGwlD15zpCiDBnIGo1OqJ0pPQzXexVMCHP
         x2/g==
X-Gm-Message-State: AOAM531BqqDTbNU2G3Bo7wWnroy7xF4rxLE2Q5s+f2dmBf2RCCKHd6O1
        VWgPVcCQclosRhjUQOORMpB666qMItw=
X-Google-Smtp-Source: ABdhPJwxvxYkMYxhd/OG2XZaPmu+DSPTHUpLGedZ4o4/pNw1OO3ILtxFhYPbsyj6ZLLoUchGibG6VQ==
X-Received: by 2002:a67:fd1a:: with SMTP id f26mr9080027vsr.78.1594215735060;
        Wed, 08 Jul 2020 06:42:15 -0700 (PDT)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id r18sm517468vkf.49.2020.07.08.06.42.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 06:42:14 -0700 (PDT)
Received: by mail-vs1-f42.google.com with SMTP id q15so13732666vso.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 06:42:13 -0700 (PDT)
X-Received: by 2002:a05:6102:407:: with SMTP id d7mr42888100vsq.73.1594215733267;
 Wed, 08 Jul 2020 06:42:13 -0700 (PDT)
MIME-Version: 1.0
References: <1593762506-32680-1-git-send-email-rnayak@codeaurora.org>
 <CAD=FV=WyhJ6g0DZS=ysT-AyXJoiRX=UFE9fXY2NEHfuUHYUXCQ@mail.gmail.com>
 <20200706203805.GS388985@builder.lan> <c747043d-c69e-4153-f2ca-16f1fc3063c2@codeaurora.org>
 <CAD=FV=Xs9Z37hv=CPgLEALoSoX=Uyir0s=ker=YKecA+Lhy1Qg@mail.gmail.com> <56fb02df-372d-935a-cc39-c13289d65c0d@codeaurora.org>
In-Reply-To: <56fb02df-372d-935a-cc39-c13289d65c0d@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 8 Jul 2020 06:42:01 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VcBK02CS+ms0HtV0f_t7G7-0rzJ11xDKWdLanGVrx0QA@mail.gmail.com>
Message-ID: <CAD=FV=VcBK02CS+ms0HtV0f_t7G7-0rzJ11xDKWdLanGVrx0QA@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: qcom: sc7180: Make gpio28 non wakeup capable
 for google,lazor
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LinusW <linus.walleij@linaro.org>,
        Andy Gross <agross@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lina Iyer <ilina@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 7, 2020 at 10:29 PM Maulik Shah <mkshah@codeaurora.org> wrote:
>
> Hi,
>
> On 7/8/2020 4:33 AM, Doug Anderson wrote:
> > Hi,
> >
> > On Mon, Jul 6, 2020 at 9:52 PM Rajendra Nayak <rnayak@codeaurora.org> wrote:
> >>
> >> []..
> >>
> >>>>> @@ -1151,6 +1168,10 @@ static const struct msm_pinctrl_soc_data sc7180_pinctrl = {
> >>>>>
> >>>>>    static int sc7180_pinctrl_probe(struct platform_device *pdev)
> >>>>>    {
> >>>>> +       if (of_machine_is_compatible("google,lazor")) {
> >>>>> +               sc7180_pinctrl.wakeirq_map = sc7180_lazor_pdc_map;
> >>>>> +               sc7180_pinctrl.nwakeirq_map = ARRAY_SIZE(sc7180_lazor_pdc_map);
> >>>>> +       }
> >>>> As much as I want patches landed and things working, the above just
> >>>> doesn't feel like a viable solution.  I guess it could work as a short
> >>>> term hack but it's going to become untenable pretty quickly.
> >>> I second that.
> >>>
> >>>> As we
> >>>> have more variants of this we're going to have to just keep piling
> >>>> more machines in here, right?  ...this is also already broken for us
> >>>> because not all boards will have the "google,lazor" compatible.  From
> >>>> the current Chrome OS here are the compatibles for various revs/SKUs
> >>>>
> >>>> compatible = "google,lazor-rev0", "qcom,sc7180";
> >>>> compatible = "google,lazor-rev0-sku0", "qcom,sc7180";
> >>>> compatible = "google,lazor", "qcom,sc7180";
> >>>> compatible = "google,lazor-sku0", "qcom,sc7180";
> >>>> compatible = "google,lazor-rev2", "qcom,sc7180";
> >>>>
> >>>> ...so of the 5 boards you'll only match one of them.
> >>>>
> >>>>
> >>>> Maybe I'm jumping into a situation again where I'm ignorant since I
> >>>> haven't followed all the prior conversation, but is it really that
> >>>> hard to just add dual edge support to the PDC irqchip driver?  ...or
> >> FWIK, this is really a PDC hardware issue (with the specific IP rev that exists
> >> on sc7180) so working it around in SW could get ugly.
> > Ugh.  I guess it's ugly because the workaround would need to be in the
> > PDC driver but to properly do the workaround you need to be able to
> > read the state of the pin from the PDC driver?  ...and I guess you
> > can't do that with the PDC register space so you'd either need to
> > violate a layer or 3 of abstraction and snarf into the GPIO register
> > space from the PDC driver or you'd have to provide some sort of API
> > access from the PDC back down to the GPIO driver?
> >
> > --
> >
> > Actually, though, I'm still not sure why this would need to be in the
> > PDC driver.  Sure, you can't just magically re-use the existing
> > dual-edge emulation in pinctrl-msm.c, but you can add some new
> > dual-edge emulation for when your parent handles your interrupts,
> > can't you?  As per usually, I'm talking out of my rear end, but I
> > sorta imagine:
> >
> > 1. At the head of msm_gpio_irq_set_type() if you detect that
> > "skip_wake_irqs" is set and you're on an SoC with this hardware errata
> > then you do a loop much like the one in
> > msm_gpio_update_dual_edge_pos() except that instead of changing the
> > polarity with msm_writel_intr_cfg() you change the polarity with
> > "irq_chip_set_type_parent()".
> >
> > 2. At the head of msm_gpio_irq_ack() you make the same function call
> > if "skip_wake_irqs" is set and you're on an SoC with this hardware
> > errata.
> >
> > It doesn't feel all that ugly to me, assuming I'm understanding it
> > correctly.  ...or maybe you can tell me why it'd be harder than that?
> >
> >
> >>>> maybe it's just easier to change the pinctrl driver to emulate dual
> >>>> edge itself and that can work around the problem in the PDC?  There
> >>>> seem to be a few samples you could copy from:
> >>>>
> >>>> $ git log --oneline --no-merges --grep=emulate drivers/pinctrl/
> >>>> 3221f40b7631 pinctrl: mediatek: emulate GPIO interrupt on both-edges
> >>>> 5a92750133ff pinctrl: rockchip: emulate both edge triggered interrupts
> >>>>
> >>> pinctrl-msm already supports emulating dual edge, but my understanding
> >>> was that the problem lies in that somehow this emulation would have to
> >>> be tied to or affect the PDC driver?
> >> yes, thats correct, pinctrl-msm already supports it, the problem lies
> >> in the fact that PDC does not. This patch, infact was trying to fix the
> >> issue by removing all PDC involvement for gpio28 and making pinctrl-msm
> >> in charge of it.
> > If we're going to try to do this, I think we're stuck with one of these:
> >
> > 1. A really really long list that we keep jamming more boards into.
> >
> > 2. Add an entry at the top-level device tree compatible to all
> > affected boards _just_ for this purpose.  Seems ugly since we don't
> > need it for any other reasons.
> >
> > 3. Add some sort of property to the pinctrl node on these boards.
> > Seems ugly since conceivably this _could_ be worked around in
> > software.
> >
> > I don't really like any of those options, so I'm really hoping we can
> > find out how to get a workaround in...
> Hi Doug,
>
> The client driver here never uses/needs both the edges at a given time.
> Another option (clean & correct IMO) is to update the driver to request
> proper irq type its expecting.
>
> Lets take SD card detect GPIO for example, which uses dual edge interrupt.
> one edge (rising type) can be used as a card insert detect interrupt and
> another edge (falling type) may be used for card removal detect.
>
> The sequence of operations, IMO should be..
> 1. Driver request a rising type irq to start with (the one that detects
> card insertion)
> 2. once card insertion irq comes in, the driver should change the type
> to falling which is expected (to detect the card removal)
> 3. once card removal irq comes in, it can change type to rising edge (to
> detect another insertion)
> 4. above steps (2,3) continues
>
> if above sequence is followed from drivers using dual edge IRQ, we don't
> need any workaround.

You're saying that we should make the rest of Linux change to work
around the bug in your pinctrl driver?  I don't think that'll fly too
well with the maintainers of the other subsystems.  The
IRQ_TYPE_EDGE_BOTH define exists and we should support it.

Was there something wrong with my proof of concept patch?  Unless I
get swamped with other things, my plan was to try to make that more
real and post it unless someone told me why it was wrong...

-Doug
