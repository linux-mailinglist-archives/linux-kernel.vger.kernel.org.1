Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0A5325A19F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 00:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgIAWqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 18:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbgIAWqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 18:46:07 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6FAC061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 15:46:07 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id o184so1571785vsc.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 15:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fDDm7I6FV6Bqqr5usz7Hzdqdt8ambZ3kJcMzathm/Fw=;
        b=YmFrRabunY+wHuIzrsqFTd6yEBSh0pO/hiai7YfVLPckGRW5hL+SJHblXsstTEqRyo
         m6+h4ELMAsdKWdhcymJTML16NYn9qW6fVrlI+HNupVUyLWrpxOtYLcqW9v32VQ2wTewU
         xMa5tEwgA97rk8/MybDfgs/enICL02jbOzOpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fDDm7I6FV6Bqqr5usz7Hzdqdt8ambZ3kJcMzathm/Fw=;
        b=h3Nmx8QJe6xEGAe9HOpvPar+a/Nl5Y5C6jAO/YvYVHxpTh5hp0AlpgjcYHAO2hdiGQ
         d6vp58Exo2zOp/+I2JCWWsvjjqMUgpU9a9rwrIvTKNNQBZtvzw9oFWWrKV5t3eP+By0+
         TzOkG/hJL3VU83/y2cRRfojT+Gi6138cLSMB7bgNjpfgpQ5ZZKa4fSjbcqevxNwP+xfZ
         U1EBc4OwgTQyxiWtpr0oFnHq2s2lkmwGscue6RiFwbjaGLnVwNmfBAA7zNxV2qdZogr9
         cUGykQqbkLhJNOv/MrUHw19wKJeBIv/CNRJyuYMQqSbtLicv67tufFS8NmztozBnecH2
         UaBw==
X-Gm-Message-State: AOAM530krLDCOVIbk+8Lr/l8D0lGVwDsV2CCYCkxo+reLQjhalOfite2
        e0a1erCaAlONkx8vfLsVD0UKUnPmDbSXaQ==
X-Google-Smtp-Source: ABdhPJx83lmG+tVNcZ6LL0fJo5DXRffBWtRQO+XmSjbJTqtV0DBibTmR208ofX7E5dnIp+SET21sWw==
X-Received: by 2002:a67:eb53:: with SMTP id x19mr3770713vso.214.1599000365985;
        Tue, 01 Sep 2020 15:46:05 -0700 (PDT)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id e97sm296561uae.10.2020.09.01.15.46.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2020 15:46:05 -0700 (PDT)
Received: by mail-vs1-f47.google.com with SMTP id j185so1558068vsc.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 15:46:05 -0700 (PDT)
X-Received: by 2002:a05:6102:30a3:: with SMTP id y3mr3765414vsd.201.1599000364461;
 Tue, 01 Sep 2020 15:46:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200813113030.1.I89c33c4119eaffb986b1e8c1bc6f0e30267089cd@changeid>
 <20200901170745.GA3419728@google.com> <CAD=FV=Xv0FLtWWcQcRy7p2LPNdDtSjdarsvNHRHaLkWwABnwJw@mail.gmail.com>
 <20200901213319.GB3419728@google.com>
In-Reply-To: <20200901213319.GB3419728@google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 1 Sep 2020 15:45:52 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XDjsg314RGV1e5jRA+qa3s9LQWN8zk-ARZAQEjNeH8Kw@mail.gmail.com>
Message-ID: <CAD=FV=XDjsg314RGV1e5jRA+qa3s9LQWN8zk-ARZAQEjNeH8Kw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7180: Add 'sustainable_power' for CPU
 thermal zones
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Sep 1, 2020 at 2:33 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> Hi Doug,
>
> On Tue, Sep 01, 2020 at 01:19:10PM -0700, Doug Anderson wrote:
> > Hi,
> >
> > On Tue, Sep 1, 2020 at 10:07 AM Matthias Kaehlcke <mka@chromium.org> wrote:
> > >
> > > On Thu, Aug 13, 2020 at 11:30:33AM -0700, Matthias Kaehlcke wrote:
> > > > The 'sustainable_power' attribute provides an estimate of the sustained
> > > > power that can be dissipated at the desired control temperature. One
> > > > could argue that this value is not necessarily the same for all devices
> > > > with the same SoC, which may have different form factors or thermal
> > > > designs. However there are reasons to specify a (default) value at SoC
> > > > level for SC7180: most importantly, if no value is specified at all the
> > > > power_allocator thermal governor (aka 'IPA') estimates a value, using the
> > > > minimum power of all cooling devices of the zone, which can result in
> > > > overly aggressive thermal throttling. For most devices an approximate
> > > > conservative value should be more useful than the minimum guesstimate
> > > > of power_allocator. Devices that need a different value can overwrite
> > > > it in their <device>.dts. Also the thermal zones for SC7180 have a high
> > > > level of granularity (essentially one for each function block), which
> > > > makes it more likely that the default value just works for many devices.
> > > >
> > > > The values correspond to 1901 MHz for the big cores, and 1804 MHz for
> > > > the small cores. The values were determined by limiting the CPU
> > > > frequencies to different max values and launching a bunch of processes
> > > > that cause high CPU load ('while true; do true; done &' is simple and
> > > > does a good job). A frequency is deemed sustainable if the CPU
> > > > temperatures don't rise (consistently) above the second trip point
> > > > ('control temperature', 95 degC in this case). Once the highest
> > > > sustainable frequency is found, the sustainable power can be calculated
> > > > by multiplying the energy consumption per core at this frequency (which
> > > > can be found in /sys/kernel/debug/energy_model/) with the number of
> > > > cores that are specified as cooling devices.
> > > >
> > > > The sustainable frequencies were determined at room temperature
> > > > on a device without heat sink or other passive cooling elements.
> >
> > I'm curious: was this a bare board, or a device in a case?  Hrm, I'm
> > not sure which one would be worse at heat dissipation, but I would
> > imagine that being inside a plastic case might be worse?
>
> This was with a device in a plastic case.
>
> > > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > > ---
> > > > If maintainers think 'sustainable_power' should be specified at
> > > > device level (with which I conceptually agree) I'm fine with
> > > > doing that, just seemed it could be useful to have a reasonable
> > > > 'default' at SoC level in this case.
> > >
> > > Any comments on this?
> >
> > I'm not massively familiar with this area of the code, but I guess I
> > shouldn't let that stop me from having an opinion!  :-P
> >
> > * I would agree that it seems highly unlikely that someone would put
> > one of these chips in a device that could only dissipate the heat from
> > the lowest OPP, so having some higher estimate definitely makes sense.
> >
> > * In terms of the numbers here, I believe that you're claiming that we
> > can dissipate 768 mW * 6 + 1202 mW * 2 = ~7 Watts of power.
>
> No, I'm claiming it's 768 mW + 1202 mW = ~2 W.
>
> SC7180 has a 6 thermal zones for the 6 little cores and 4 zones for the
> 2 big cores. Each of these thermal zones uses either all little or all big
> cores as cooling devices, hence the power sustainable power of the
> individual zones doesn't add up. 768 mW corresponds to 6x 128 mW (aka all
> little cores at 1.8 GHz), and 1202 mW to 2x 601 mW (both big cores at 1.9 GHz).

Ah!  Thanks for explaining.


> > My memory
> > of how much power we could dissipate in previous laptops I worked on
> > is a little fuzzy, but that doesn't seem insane for a passively-cooled
> > laptop.  However, I think someone could conceivably put this chip in a
> > smaller form factor.  In such a case, it seems like we'd want these
> > things to sum up to ~2000 (if it would ever make sense for someone to
> > put this chip in a phone) or ~4000 (if it would ever make sense for
> > someone to put this chip in a small tablet).
>
> See above, the sustainable power with this patch only adds up to ~2000.
> It is possible though that it would be lower in a smaller form factor
> device.
>
> I'd be ok with posting something lower for SC7180 (it would be a guess
> though) and use the specific numbers in the device specific DT.

Given the advice in the bindings it seems like 2W should be fine.


> > It seems possible that,
> > to achieve this, we might have to tweak the
> > "dynamic-power-coefficient".  I don't know how much thought was put
> > into those numbers, but the fact that the little cores have a super
> > round 100 for their dynamic-power-coefficient makes me feel like they
> > might have been more schwags than anything.  Rajendra maybe knows?
>
> Yeah, it's possible that that was just an approximation
>
> > * I'm curious about the fact that there are two numbers here: one for
> > littles and one for bigs.  If I had to guess I'd say that since all
> > the cores are in one package so the contributions kinda need to be
> > thought of together, right?  If we're sitting there thermally
> > throttled then we'd want to pick the best perf-per-watt for the
> > overall package.  This is why your patch says we can sustain the
> > little cores at max and the big cores get whatever is left over,
> > right?
>
> It's derived from how Qualcomm specified the thermal zones and cooling
> devices. Any ("cpu") zone is either cooled by (all) big cores or by (all)
> little cores, but not a mix of them. In my tests I also saw that the big
> cores seemed to have little impact on the little ones. The little cores
> are at max because even running at max frequency the temperature in the
> 'little zones' wouldn't come close to the trip point.

OK, crazy.  I suppose that this makes sense,especially without a
heatsink and over a short burst of time.  I'd imagine that with a
heatsink things might look different, but trying to model everything
is impossible and seems like what't there works OK until someone can
say why it doesn't.  :-)


> > * Should we be leaving some room in here for the GPU?  ...or I guess
> > once we list it as a cooling device we'll have to decrease the amount
> > the CPUs can use?
>
> I don't know for sure, but judging from the CPU zones I wouldn't be
> surprised if the GPU was managed exclusively in the dedicated GPU
> thermal zones (I guess that's what 'gpuss0-thermal' and 'gpuss1-thermal'
> are). If that's not the case the values in the CPU zones can be
> adjusted when specific data is available.

Sounds good.


> > So I guess the tl; dr is:
> >
> > a) We should check "dynamic-power-coefficient" and possibly adjust.
>
> ok, lets see if Rajendra can check if there is room for tweaking.
>
> > b) I don't think the "conservative" by-default numbers should add up
> > to 7 Watts.  I could be convinced that this chip is not intended for
> > phones and thus we could have it add up to 4 Watts, but 7 Watts seems
> > too much.
>
> I suppose this is mostly addressed by my explications above, unless we
> think that 2 Watts in CPU power might still be too aggressive as a
> default.

With all your explanations, I'm happy to add:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

-Doug
