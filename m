Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9052F24A2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 02:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404834AbhALAZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 19:25:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404109AbhAKX1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 18:27:42 -0500
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71906C061794
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 15:27:01 -0800 (PST)
Received: by mail-oo1-xc2f.google.com with SMTP id x203so162602ooa.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 15:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tB2rgSrZ0/TN4TUmobV6789IGZfS+D3eOVRdkbfIw4A=;
        b=gLmdMP3rM3QqdYNwjCiq7RPeQJQwO1RTUW+XGOknX/BO81E17X9dd/cwFCFK0IFJz6
         BHupfxdBF6V+FBN7l9b+BbxOjrF9mXKxOv4tK99+6n2YGXNiCeltKdD9D3Jnopar7bfR
         3+4PqIVuTG+NTS/oBPnmqKVTxr2Hw5cui7BQn6wCzuC4e3Tx1eGAww3zGXdXtWIQ72ON
         9+xC9HjEN3oo+0td5z1O1XM6b1b605Mv5slYsI/I40YM7ImUH0V93aSgTqIG7HWgYJxC
         Cs7wnkiOGQKmVFEo54gNpH5bLF/AxjHxWDKne+v2WH8E2Qn+mq6YvyYTOq72Ib8m0qOq
         4gfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tB2rgSrZ0/TN4TUmobV6789IGZfS+D3eOVRdkbfIw4A=;
        b=tdVwKYgja09ujTdOLH2f0fXNv2dUU7MdQQzu0tBon0433GZNKf8UfbVtf1S0ZR6FR1
         IraK7yb5Fv1e7XtEuaaf58o7uEQtPWJHMYJU8V6qLg3AZ5OuysAHLOENYUvQes8MGts3
         DBT0+3vWaYw6YRluWHg0UkHmvFuqJCFFUDcPl1KFQo1qqWP+San3g22tRUWa79qIAHva
         V6tE0fRo3JinjrXVCqHGHjWclQWNqGVP2Du+ZKXGmm8wW/kjNILvHNKMHROPR2YW0J6+
         ZS002nhz3QzlN0xJKYxcsZ4Y2pHWa0PZDnh2z0jdnWbFmiX/s2a5VHJRFJSgl65VzB0s
         EcHA==
X-Gm-Message-State: AOAM530eSVqpBS0/wQe4eKhulnBnLBIFxCdhpAkfZ4xKyJrKcUUyc2ha
        SpMDmcZmhonr6YhkkNKJTBYh0A==
X-Google-Smtp-Source: ABdhPJw1CpfHZNtMFEYLL3Yz46P5y3QE+7nQ4Mgndu1jaANrtE4iVOkerk7U1IzWBdwjv2vGuBzR/A==
X-Received: by 2002:a4a:ddd2:: with SMTP id i18mr1065136oov.10.1610407620599;
        Mon, 11 Jan 2021 15:27:00 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id v23sm262849otj.68.2021.01.11.15.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 15:26:59 -0800 (PST)
Date:   Mon, 11 Jan 2021 17:26:57 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Kiran Gunda <kgunda@codeaurora.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: qcom: Clean up sc7180-trogdor voltage rails
Message-ID: <X/zewUR8Dc2Jf/MM@builder.lan>
References: <20201207143255.1.Ib92ec35163682dec4b2fbb4bde0785cb6e6dde27@changeid>
 <CAD=FV=VWEEP7xsD5-wBjtToB+Ke69vFXzvPoAoocWPyREdjjhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=VWEEP7xsD5-wBjtToB+Ke69vFXzvPoAoocWPyREdjjhw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 11 Jan 15:48 CST 2021, Doug Anderson wrote:

> Hi Bjorn,
> 
> On Mon, Dec 7, 2020 at 2:33 PM Douglas Anderson <dianders@chromium.org> wrote:
> >
> > For a bunch of rails we really don't do anything with them in Linux.
> > These are things like modem voltage rails that the modem manages these
> > itself and core rails (like IO rails) that are setup to just
> > automagically do the right thing by the firmware.
> >
> > Let's stop even listing those rails in our device tree.
> >
> > The net result of this is that some of these rails might be able to go
> > down to a lower voltage or perhaps transition to LPM (low power mode)
> > sometimes.
> >
> > Here's a list of what we're doing and why:
> >
> > * L1A - only goes to SoC and doesn't seem associated with any
> >   particular peripheral. Kernel isn't doing anything with
> >   this. Removing from dts. NET IMPACT: rail might drop from 1.2V to
> >   1.178V and switch to LPM in some cases depending on firmware.
> > * L2A - only goes to SoC and doesn't seem associated with any
> >   particular peripheral. Kernel isn't doing anything with
> >   this. Removing from dts. NET IMPACT: rail might switch to LPM in
> >   some cases depending on firmware.
> > * L3A - only goes to SoC and doesn't seem associated with any
> >   particular peripheral. Kernel isn't doing anything with
> >   this. Removing from dts. NET IMPACT: rail might switch to LPM in
> >   some cases depending on firmware.
> > * L5A - seems to be totally unused as far as I can tell and doesn't
> >   even come off QSIP. Removing from dts.
> > * L6A - only goes to SoC and doesn't seem associated with any
> >   particular peripheral (I think?). Kernel isn't doing anything with
> >   this. Removing from dts. NET IMPACT: rail might switch to LPM in
> >   some cases depending on firmware.
> > * L16A - Looks like this is only used for internal RF stuff. Removing
> >   from dts. NET IMPACT: rail might switch to LPM in some cases
> >   depending on firmware.
> > * L1C - Just goes to WiFi / Bluetooth. Trust how IDP has this set and
> >   put this back at 1.616V min.
> > * L4C - This goes out to the eSIM among other places. This looks like
> >   it's intended to be for SIM card and modem manages. NET IMPACT:
> >   rail might switch to LPM in some cases depending on firmware.
> > * L5C - This goes to the physical SIM.  This looks like it's intended
> >   to be for SIM card and modem manages. NET IMPACT: rail might drop
> >   from 1.8V to 1.648V and switch to LPM in some cases depending on
> >   firmware.
> >
> > NOTE: in general for anything which is supposed to be managed by Linux
> > I still left it all forced to HPM since I'm not 100% sure that all the
> > needed calls to regulator_set_load() are in place and HPM is safer.
> > Switching more things to LPM can happen in a future patch.
> >
> > ALSO NOTE: Power measurements showed no measurable difference after
> > applying this patch, so perhaps it should be viewed more as a cleanup
> > than any power savings.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> >  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 82 ++------------------
> >  1 file changed, 7 insertions(+), 75 deletions(-)
> 
> We've been running with this in the downstream tree since December 8th
> and nobody has yelled.  You can see <https://crrev.com/c/2573506>.  Is
> it a good time for it to land upstream?
> 

Sure thing, I will pick it up. Thanks for the ping!

Regards,
Bjorn
