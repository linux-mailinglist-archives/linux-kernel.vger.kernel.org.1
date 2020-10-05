Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE2F42842F0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 01:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgJEX3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 19:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbgJEX3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 19:29:23 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA819C0613A7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 16:29:23 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 7so6912092pgm.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 16:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LDiL+GXcnPC606XYr7MZfMGhMR75HAM4qMR2Sb0HfTA=;
        b=S3+AkSBWwtsQFNLy3uqVSP4lipkdUBVRg1fZvuI5ASskDWc2bz8zQcXURV/gyyVd2i
         vCCJ0EkMb4ZYUbTCpoPqKRx371Np+eC+HrxiMq7wW4K1kmXE0czvamT2Y1iSPvlqtZgk
         79ARQ2WII4davW3ztGI790WmwW24Xb6hWeYug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LDiL+GXcnPC606XYr7MZfMGhMR75HAM4qMR2Sb0HfTA=;
        b=rleX/YexhYrBbHJEmE3P40I0g151GReDjUMYwkjP4IhtC6dXFgN6QU8yMwIugccAgt
         DzKKt6jEpvIqWYjJyoTOOKk0WQff0+4N7LaEiZ7Gw7/8wP5AR+igvFYczL7a9S0bQBbt
         +xNKluiJ8V06aK5JNT0A3RjBTazA6vxhfr4woAweQZBB1P7dRfzMwqbA+xjiCd4+Z8Ps
         mZ1RArvDB/McQvP9czwQUtFuJutaGOdpZLTIjvqXw+rS9dIlLGGLJDMmUmHdkBSjSpVu
         PjhdM6rIHhaceMdrFkdPm8E17W4RVTm8OrsKD0v4zscmjRIqRQB12DKS2qPr9yoHpE3v
         7dVg==
X-Gm-Message-State: AOAM532oz8DWaMDvwO0Z6xE1/GG7FmMTfUW1hKkqPQlioP8GA4J25nZB
        rKBTykng8iNItmGScykmvnIJpA==
X-Google-Smtp-Source: ABdhPJyHXUS9zry6LcXRyAaCbYLpYGpFNBPTbVuTG6k/SbIPOaAgrcWVQ8ab7Gkxqq+liezZAWv4XQ==
X-Received: by 2002:aa7:9823:0:b029:150:a96f:c8b7 with SMTP id q3-20020aa798230000b0290150a96fc8b7mr1883651pfl.34.1601940563110;
        Mon, 05 Oct 2020 16:29:23 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id y16sm1105109pfb.154.2020.10.05.16.29.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2020 16:29:22 -0700 (PDT)
Date:   Mon, 5 Oct 2020 16:29:21 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Doug Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Stephen Boyd <swboyd@chromium.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Peter Chen <peter.chen@nxp.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: usb: Add binding for discrete
 onboard USB hubs
Message-ID: <20201005232921.GC4135817@google.com>
References: <CAL_Jsq+Zi+hCmUEiSmYw=pVK472=OW1ZjLnkH1NodWUm8FA5+g@mail.gmail.com>
 <CAD=FV=WJrvWBLk3oLpv6Q3uY4w7YeQBXVdkpn+SAS5dnxp9-=Q@mail.gmail.com>
 <20201002183633.GA296334@rowland.harvard.edu>
 <CAL_JsqKHFA5RWz1SRLkR2JXydURL2pA+4C0+C+4SrJR_h4M0dw@mail.gmail.com>
 <20201003124142.GA318272@rowland.harvard.edu>
 <20201005160655.GA4135817@google.com>
 <20201005161527.GI376584@rowland.harvard.edu>
 <20201005191812.GB4135817@google.com>
 <20201005193611.GA389867@rowland.harvard.edu>
 <CAL_JsqK8V9PUCUD1iZQr52b28G39JraY=doZWzk0gNvu15qW-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAL_JsqK8V9PUCUD1iZQr52b28G39JraY=doZWzk0gNvu15qW-g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 05, 2020 at 02:59:04PM -0500, Rob Herring wrote:
> On Mon, Oct 5, 2020 at 2:36 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Mon, Oct 05, 2020 at 12:18:12PM -0700, Matthias Kaehlcke wrote:
> > > On Mon, Oct 05, 2020 at 12:15:27PM -0400, Alan Stern wrote:
> > > > The conclusion is that we need to have code that is aware of some
> > > > detailed needs of a specific device but is not part of the device's
> > > > driver.  I'm not sure what the best way to implement this would be.
> > >
> > > Wouldn't it be possible to load the module when the DT specifies that
> > > the device exists? For USB the kernel would need the VID/PID to identify
> > > the module, these could be extracted from the compatible string.
> >
> > Loading a driver module whenever DT says a device exists?  Not a bad
> > idea.  I don't know what would be involved, but no doubt it is possible.
> 
> MODULE_DEVICE_TABLE mostly as I mentioned in my other reply.
> 
> > Note that, except for a few special cases, the kernel identifies the
> > appropriate driver for USB hubs not by the VID/PID but instead by the
> > device class or interface class.  I suppose the compatible string could
> > include that information too?
> 
> We can go back to 1998 OpenFirmware and it's already there[1].
> 'usb,class9' for a hub. There's a few other variations defined.

That should work if the initialization is simple enough that the info in the
device tree is sufficient (e.g. switching a single regulator on), otherwise
a device specific compatible string would be needed.

> > > Having the initialization code outside of the driver could lead to code
> > > duplication, since the driver might want to power the device down in
> > > certain situations (e.g. system suspend).
> >
> > True.  On the other hand, how common do you think it would be for
> > drivers not to want to mess with the power settings?
> 
> I think in that case you'd generally want firmware to enable things
> and the kernel then does no power control.
> 
> We have ~1500 boards using DT and maybe ~10 with USB devices described
> in DT. So the whole thing is not common to begin with.

It's probably not very common, but might be more common than the DT suggests.
Many devices probably don't specify their hub(s) or other USB devices
explicitly when the initialization is done in firmware.

In case a generic solution for all types of devices and busses is not
required we would still need a driver to address at least the conditional
power down of a hub during system suspend.

Doug summarized the state of the discussion about the bindings for hubs
(https://lore.kernel.org/patchwork/patch/1313000/#1511757) maybe we should
continue from there?
