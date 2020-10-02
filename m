Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAF3C28177A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 18:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388077AbgJBQIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 12:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733260AbgJBQIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 12:08:51 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C0BC0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 09:08:50 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id j19so1126415pjl.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 09:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+fnkCRnu87XrPPwPAXvTK0+WH+kB4qR2/orTOS8Bb18=;
        b=VKY/ZwEEoMKuGn9NoyHtvpV5xd23RapB/8ROFjgdKqqPw4ud3Mb+2KEuqkBum0+F7W
         0ZVi7Z7XhuszSAxdDT+z53l99wQl/NeOqY70UPkqnWi/ufvolH510qMz7Ej0cPzjZRSQ
         yoPgg1SxaKyVrLFW8u57TsaCk5pNUD1oDOhcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+fnkCRnu87XrPPwPAXvTK0+WH+kB4qR2/orTOS8Bb18=;
        b=as4+t8gQYkQFab/cQh+U6tpW47mte3gD8BkWt0DMt8ZXcp+vEJFxhGBRWuAclQ/qYk
         oyxpq9fE0kXxz6f5h+0gMNbmwQx72WcU7vBBmBoKFfYBVB1uL490jOAzTW+86ketTGUf
         eqx5jHWhimFQ3xhvv+Bm44SkU3CVD0wNbi3PIMVeDiJDZnbBxEZjkUw/B/fcxXQQPLpg
         tSRPNA/EKkJjAfPFuPC3MIIjvHm2kJ9leDeObhsjbM+7kJJd/LKP1+t0/yAMyP45VgHB
         m3JInAC2FKFqnOPJsY7wv0FNGGhcHO82nspzrG0pjxdSY8wkaJaU1ft0MZMRo7UuX9OQ
         6JFg==
X-Gm-Message-State: AOAM531KrArv56i9J2x+kRlqyRdABdE/x5NBV3F9poeB/XMZe+XwbBPF
        hvr30staxUv27vBsR7XN3hCaAw==
X-Google-Smtp-Source: ABdhPJyc9LPKpmQnwick/WQtT8a3qWJMiSceUD3Ppt/TUKDZA99mJMpvjeCMOO7NGFJUOZPxKGWfbA==
X-Received: by 2002:a17:90a:1702:: with SMTP id z2mr3538485pjd.88.1601654929473;
        Fri, 02 Oct 2020 09:08:49 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id gk14sm2068634pjb.41.2020.10.02.09.08.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2020 09:08:48 -0700 (PDT)
Date:   Fri, 2 Oct 2020 09:08:47 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Rob Herring <robh@kernel.org>,
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
Message-ID: <20201002160847.GA2704892@google.com>
References: <20200929201701.GA1080459@bogus>
 <20200929220912.GF1621304@google.com>
 <20200930013229.GB194665@rowland.harvard.edu>
 <20200930124915.GA1826870@google.com>
 <CAL_JsqLq9ZJm_CMiqWwbQhgGeu_ac_j43pvk4+xCFueSbyL4wA@mail.gmail.com>
 <CAD=FV=WcDzgcHNn1+gH+gq_WEwpD0XXdJGm2fBVpAB=3fVbzZA@mail.gmail.com>
 <CAL_Jsq+Zi+hCmUEiSmYw=pVK472=OW1ZjLnkH1NodWUm8FA5+g@mail.gmail.com>
 <20201001012413.GA232049@rowland.harvard.edu>
 <20201001215412.GB2362632@google.com>
 <20201002012153.GA270859@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201002012153.GA270859@rowland.harvard.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 01, 2020 at 09:21:53PM -0400, Alan Stern wrote:
> On Thu, Oct 01, 2020 at 02:54:12PM -0700, Matthias Kaehlcke wrote:
> > Hi,
> > 
> > thanks for providing more insights on the USB hardware!
> 
> Sure.
> 
> > On Wed, Sep 30, 2020 at 09:24:13PM -0400, Alan Stern wrote:
> > > A hub that attaches only to the USB-3 data wires in a cable is not USB
> > > compliant.  A USB-2 device plugged into such a hub would not work.
> > > 
> > > But ports can be wired up in weird ways.  For example, it is possible
> > > to have the USB-3 wires from a port going directly to the host
> > > controller, while the USB-2 wires from the same port go through a
> > > USB-2 hub which is then connected to a separate host controller.  (In
> > > fact, my office computer has just such an arrangement.)
> > 
> > It's not clear to me how this case would be addressed when (some of) the
> > handling is done in xhci-plat.c We have two host controllers now, which one
> > is supposed to be in charge? I guess the idea is to specify the hub only
> > for one of the controllers?
> 
> I don't grasp the point of this question.  It doesn't seem to be
> relevant to the case you're concerned about -- your board isn't going to
> wire up the special hub in this weird way, is it?

When doing upstream development I try to look beyond my specific use case
and aim for solutions that are generally useful.

I don't know how common a configuration like the one on your office computer
is. If it isn't a fringe case it seems like we should support it if feasible.

> > > > Yes, I've been saying for some time we need a pre-probe. Or we need a
> > > > forced probe where the subsystem walks the DT nodes for the bus and
> > > > probes the devices in DT (if they're in DT, we know they are present).
> > > > This was the discussion only a few weeks ago for MDIO (which I think
> > > > concluded with they already do the latter).
> > > 
> > > This is why I suggested putting the new code into the xhci-platform
> > > driver.  That is the right place for doing these "pre-probes" of DT
> > > nodes for hubs attached to the host controller.
> > 
> > Reminder that the driver is not exclusively about powering the hub, but
> > also about powering it off conditionally during system suspend, depending
> > on what devices are connected to either of the busses. Should this also
> > be done in the xhci-platform driver?
> 
> It certainly could be.  The platform-specific xhci suspend and resume
> routines could power the hub on and off as needed, along with powering
> the host controller.
> 
> > Since we are talking about "pre-probes" I imagine the idea is to have a
> > USB device driver that implements the power on/off sequence (in pre_probe()
> > and handles the suspend/resume case. I already went through a variant of
> > this with an earlier version of the onboard_hub_driver, where suspend/resume
> > case was handled by the USB hub device. One of the problems with this was
> > that power must only be turned off after both USB hub devices have been
> > suspended. Some instance needs to be aware that there are two USB devices
> > and make the decision whether to cut the power during system suspend
> > or not, which is one of the reasons I ended up with the platform
> > driver. It's not clear to me how this would be addressed by using
> > "pre-probes". Potentially some of the handling could be done by
> > xhci-platform, but would that be really better than a dedicated driver?
> 
> _All_ of the handling could be done by xhci-plat.  Since the xHCI
> controller is the parent of both the USB-2 and USB-3 incarnations of
> the special hub, it won't get suspended until they are both in
> suspend, and it will get resumed before either of them.  Similarly,
> the power to the special hub could be switched on as part of the host
> controller's probe routine and switched off during the host
> controller's remove routine.
> 
> Using xhci-plat in this way would be better than a dedicated driver in
> the sense that it wouldn't then be necessary to make up a fictitious
> platform device and somehow describe it in DT.
> 
> The disadvantage is that we would end up with a driver that's
> nominally meant to handle host controllers but now also manages (at
> least in part) hubs.  A not-so-clean separation of functions.  But
> that's not terribly different from the way your current patch works,
> right?

Yes, this muddling of the xhci-plat code with the handling of hubs was
one of my concerns, but who am I to argue if you as USB maintainer see
that preferable over a dedicated driver. I suppose you are taking into
account that there will be a need for code for different hub models that
has to live somewhere (could be a dedicated file or directory).

And even if it is not my specific use case it would be nice to support
hubs that are part of a hierarchy and not wired directly to the host
controller. We don't necessarily have to implement all support for this
initially, but should have it in mind at least for the bindings.

Also we would probably lose the ability to use a sysfs attribute to
configure whether the hub should be always powered during suspend or
not. This could be worked around with a DT property, however DT
maintainers tend to be reluctant about configuration entries that
don't translate directly to the hardware.

I think at this point I should say that I can't personally commit to
implement such a solution in a foreseeable future due to other
commitments involved in shipping products. But I also want to make it
clear that as a project Chrome OS is interested in landing this
functionality upstream. I might be able to carve out some time, but it's
not certain. If not we will come back to this eventually, be it myself
or someone else on behalf of Chrome OS.
