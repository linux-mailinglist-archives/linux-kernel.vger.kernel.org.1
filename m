Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B026E27F074
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 19:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731637AbgI3RZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 13:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731477AbgI3RZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 13:25:05 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3F6C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 10:25:05 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id e23so1346486vsk.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 10:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vW6nfGRTz/sTEP7gbvkvTgm0nzQPx/Ar8oJMubseyNA=;
        b=Wu+N1EEPQlezri0eilDt/EmQjVaPC7mh7e+xt53v7wvzU7vqg7jGKW/hrbLIJZOzbn
         g3TtmKm2I50xDw63us09VXc5c40L4V2/3Loek9Jn6kjZ6rG/H3Ik2yOu1TAaqjao0osQ
         ECY6OOhQr87v43ypSh1IWo+NJ7TRxnrhIMOx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vW6nfGRTz/sTEP7gbvkvTgm0nzQPx/Ar8oJMubseyNA=;
        b=SddtMTxHHPKEivbhUFHAkmEg2wbfqTDrDu/+QsH8HYMqCQBk5MjxRAh3jm+62ABI/0
         8WMhjRXHVVN0iSS1SnbrxlWKk5+M4AGVANGYrm8HiB/egz7i2anYqBFphOgv4DOmfUAi
         w4PxZeg9XmvRalsLCB26OlM46T/kAWSoLd8MFx8bRQ+4xzTcc4aB9EFFOO9ClYPSr5uw
         /z8gZy6LcuPZcPo5tC/n4t7FIBg6Nw6g+zJFVzIiGDsb2WAHjw7+k9ZYRbeb+/ZNWSp8
         Rtla0/mLXQJSRZKD0pdv1fzK8JENvT0U/8uEd44pxUlFsGn9roFXqLWCaBPzuKCBBJU4
         c4mA==
X-Gm-Message-State: AOAM531eeUVr5WNcPHY/Bay9G3FRa3E1XMJ1D5wGpUBSc554Oa063hiK
        RBHF1pjvLayIZGKZxINZaX1fcaKNcGcHGQ==
X-Google-Smtp-Source: ABdhPJxgCwIgMMRyTCf9uaw7lwBJtjHt591ELjODPf/38+nBSeCHhvkNXTCZvnzimF2oIt/cQDE9cA==
X-Received: by 2002:a67:d390:: with SMTP id b16mr2385024vsj.23.1601486704026;
        Wed, 30 Sep 2020 10:25:04 -0700 (PDT)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id y84sm315363vsc.33.2020.09.30.10.25.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2020 10:25:03 -0700 (PDT)
Received: by mail-ua1-f42.google.com with SMTP id g16so696598uan.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 10:25:03 -0700 (PDT)
X-Received: by 2002:ab0:2ea1:: with SMTP id y1mr2436125uay.104.1601486702629;
 Wed, 30 Sep 2020 10:25:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200929121610.16060-1-lukasz.luba@arm.com> <CAD=FV=UnNkjMiOc0DZE7+OM3-Kr1ZRynxSerdA=ifbyGiRa2Zw@mail.gmail.com>
 <a1d1fe2a-485f-a21e-2f91-9b609223aa5a@arm.com> <62540312-65a2-b6d9-86ce-b4deaaa913c1@codeaurora.org>
 <1f713ff6-32f6-4ea6-b7f7-4c61f097cf2a@arm.com> <b74a5907-47dc-6c3c-3da8-94959af07ea8@codeaurora.org>
In-Reply-To: <b74a5907-47dc-6c3c-3da8-94959af07ea8@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 30 Sep 2020 10:24:50 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V84RmTpKN50Rz-BJqccSme3T3yw=hT5KvYerx=X7aEsA@mail.gmail.com>
Message-ID: <CAD=FV=V84RmTpKN50Rz-BJqccSme3T3yw=hT5KvYerx=X7aEsA@mail.gmail.com>
Subject: Re: [PATCH 1/2] docs: Clarify abstract scale usage for power values
 in Energy Model
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Lukasz Luba <lukasz.luba@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dietmar.Eggemann@arm.com, Quentin Perret <qperret@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Sep 30, 2020 at 8:48 AM Rajendra Nayak <rnayak@codeaurora.org> wrote:
>
>
> On 9/30/2020 7:34 PM, Lukasz Luba wrote:
> >
> >
> > On 9/30/20 11:55 AM, Rajendra Nayak wrote:
> >>
> >> On 9/30/2020 1:55 PM, Lukasz Luba wrote:
> >>> Hi Douglas,
> >>>
> >>> On 9/30/20 12:53 AM, Doug Anderson wrote:
> >>>> Hi,
> >>>>
> >>>> On Tue, Sep 29, 2020 at 5:16 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
> >>>>>
> >>>>> The Energy Model (EM) can store power values in milli-Watts or in abstract
> >>>>> scale. This might cause issues in the subsystems which use the EM for
> >>>>> estimating the device power, such as:
> >>>>> - mixing of different scales in a subsystem which uses multiple
> >>>>>    (cooling) devices (e.g. thermal Intelligent Power Allocation (IPA))
> >>>>> - assuming that energy [milli-Joules] can be derived from the EM power
> >>>>>    values which might not be possible since the power scale doesn't have to
> >>>>>    be in milli-Watts
> >>>>>
> >>>>> To avoid misconfiguration add the needed documentation to the EM and
> >>>>> related subsystems: EAS and IPA.
> >>>>>
> >>>>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> >>>>> ---
> >>>>>   .../driver-api/thermal/power_allocator.rst          |  8 ++++++++
> >>>>>   Documentation/power/energy-model.rst                | 13 +++++++++++++
> >>>>>   Documentation/scheduler/sched-energy.rst            |  5 +++++
> >>>>>   3 files changed, 26 insertions(+)
> >>>>
> >>>> I haven't read through these files in massive detail, but the quick
> >>>> skim makes me believe that your additions seem sane.  In general, I'm
> >>>> happy with documenting reality, thus:
> >>>>
> >>>> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> >>>
> >>> Thank you for the review.
> >>>
> >>>>
> >>>> I will note: you haven't actually updated the device tree bindings.
> >>>> Thus, presumably, anyone who is specifying these numbers in the device
> >>>> tree is still supposed to specify them in a way that mW can be
> >>>> recovered, right?  Said another way: nothing about your patches makes
> >>>> it OK to specify numbers in device trees using an "abstract scale",
> >>>> right?
> >>>
> >>> For completeness, we are talking here about the binding from:
> >>> Documentation/devicetree/bindings/arm/cpus.yaml
> >>> which is 'dynamic-power-coefficient'. Yes, it stays untouched, also the
> >>> unit (uW/MHz/V^2) which then allows to have mW in the power
> >>> values in the EM.
> >>
> >> So for platforms where 'dynamic-power-coefficient' is specified in device tree,
> >> its always expected to be derived from 'real' power numbers on these platforms in
> >> 'real' mW?
> >
> > Yes, the purpose and the name of that binding was only for 'real'
> > power in mW.
> >
> >>
> >> Atleast on Qualcomm platforms we have these numbers scaled, so in essence it
> >> can't be used to derive 'real' mW values. That said we also do not have any of
> >> the 'platform might face potential issue of mixing devices in one thermal zone
> >> of two scales' problem.
> >
> > If you have these numbers scaled, then it's probably documented
> > somewhere in your docs for your OEMs, because they might assume it's in
> > uW/MHz/V^2 (according to the bindings doc). If not, they probably
> > realized it during the measurements and comparison (that the power in
> > EM is not what they see on the power meter).
> > This binding actually helps those developers who take the experiments
> > and based on measured power values, store derived coefficient.
> > Everyone can just measure in local setup and compare the results
> > easily, speaking the same language (proposing maybe a patch adjusting
> > the value in DT).
> >
> >>
> >> So the question is, can such platforms still use 'dynamic-power-coefficient'
> >> in device tree and create an abstract scale? The other way of doing this would
> >> be to *not* specify this value in device tree and have these values stored in the
> >> cpufreq driver and register a custom callback to do the math.
> >
> > But then we would also have to change the name of that binding.
> >
> > I'd recommend you the second way that you've described. It will avoid
> > your OEMs confusion. In your cpufreq driver you can simply register
> > to EM using the em_dev_register_perf_domain(). In your local
> > callback you can do whatever you need (read driver array, firmware,
> > DT, scale or not, etc).
> > The helper code in dev_pm_opp_of_register_em() is probably not suited
> > for your use case (when you don't want to share the real power of the
> > SoC).
>
> Got it, thanks for the clarification. I will get the cpufreq driver updated
> to use em_dev_register_perf_domain() with a custom callback and get rid of these
> values from device tree.

This sounds good.  ...except...

How exactly are boards supposed to provide their "sustainable-power"
number in this model?  As far as I'm aware, there's no place to
specify this board-specific file other than in device tree, and the
bindings [1] say that this value has to be in mW.  Lukasz: how do you
envision boards can provide "sustainable-power" in cases where the
energy model is in "abstract scale"?

[1] Documentation/devicetree/bindings/thermal/thermal-zones.yaml


-Doug
