Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4667286A63
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 23:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbgJGVm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 17:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728229AbgJGVm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 17:42:29 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16714C061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 14:42:29 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id h2so1689922pll.11
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 14:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VPr2xSkE7webAMYvxqazwYRAVTqd87A40boZ8jpSdls=;
        b=Rivqq03vqfYDv+ObWcmKYjHqymQ0ID0gRFkln8oRFXkJnjSnizrynwK62LUVequPXh
         EVzQyheFn8oi7h0KkrCc2lDH30yCByaoRbY/SVfSw78T5+RpNSRUGUCgUmoY1zxlo6wP
         1pmm0z0MrrL+Oq4xgXnwD3cawtdNsDHaFHy7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VPr2xSkE7webAMYvxqazwYRAVTqd87A40boZ8jpSdls=;
        b=oq1FwSv8IpsWcCFCT8yqcFPx3wAUSlJVeUCAVD4Yimj7JBlf+68cDuoSW7GhR3L48w
         CVljrtVZvDzuD+Z/J9jzcpuB707vND9dKqM0FhCmKdQkQuFHeFtbVwSnbl/hh7fuvGcS
         h26fmHPrZJjmd0rm6GvJAdHIy+MEQAQVE8R8lwEUkrcKLbMqzUwjmwPpS90k6Jy03ZVp
         UFsYQCj1FFWOrlcZD+LkUa1kIy3Yzf35cXNcwC2YwNH0VMCHiK0VbE+PE5tra6/lWZ2s
         ZLo7lHiy/oBM+3fDP5q2zwpGpZJSi36ddTTwH0mg61sBSirTfj+rmIFC4FHwtVs6w3rM
         xygA==
X-Gm-Message-State: AOAM531K0f/cXrQj41tCa4fvkajB+9+Y2nGxpbumb1b8XAdHnKfWjWlL
        jEK2EXoi3FpGKNf+nER86bR/Qw==
X-Google-Smtp-Source: ABdhPJw4UyfaVbCcqJu37x5gWAFucs5XrJToeS2kIda0rL5XZyWIJyiEYAq6+T2YVwqMoH3+fkB1Zw==
X-Received: by 2002:a17:902:b107:b029:d2:ab87:c418 with SMTP id q7-20020a170902b107b02900d2ab87c418mr4673288plr.40.1602106948614;
        Wed, 07 Oct 2020 14:42:28 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id u15sm4304310pfl.215.2020.10.07.14.42.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2020 14:42:27 -0700 (PDT)
Date:   Wed, 7 Oct 2020 14:42:26 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Doug Anderson <dianders@chromium.org>,
        Rob Herring <robh@kernel.org>,
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
Message-ID: <20201007214226.GA669360@google.com>
References: <20201006165957.GA191572@google.com>
 <20201006171524.GB423499@rowland.harvard.edu>
 <20201006192536.GB191572@google.com>
 <20201007010023.GA438733@rowland.harvard.edu>
 <20201007160336.GA620323@google.com>
 <20201007163838.GA457977@rowland.harvard.edu>
 <20201007172847.GB620323@google.com>
 <20201007192542.GA468921@rowland.harvard.edu>
 <20201007194229.GC620323@google.com>
 <20201007201732.GE468921@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201007201732.GE468921@rowland.harvard.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 04:17:32PM -0400, Alan Stern wrote:
> On Wed, Oct 07, 2020 at 12:42:29PM -0700, Matthias Kaehlcke wrote:
> > On Wed, Oct 07, 2020 at 03:25:42PM -0400, Alan Stern wrote:
> > > On Wed, Oct 07, 2020 at 10:28:47AM -0700, Matthias Kaehlcke wrote:
> > > > On Wed, Oct 07, 2020 at 12:38:38PM -0400, Alan Stern wrote:
> > > > > On Wed, Oct 07, 2020 at 09:03:36AM -0700, Matthias Kaehlcke wrote:
> > > > > > Ok, I wasn't sure if the hubs suspend asynchronously from each other. If they
> > > > > > do it should indeed not be a problem to have the "master" wait for its peers.
> > > > > 
> > > > > Well, order of suspending is selectable by the user.  It can be either 
> > > > > asynchronous or reverse order of device registration, which might pose a 
> > > > > problem.  We don't know in advance which of two peer hubs will be 
> > > > > registered first.  It might be necessary to introduce some additional 
> > > > > explicit synchronization.
> > > > 
> > > > I'm not sure we are understanding each other completely. I agree that
> > > > synchronization is needed to have the primary hub wait for its peers, that
> > > > was one of my initial concerns.
> > > > 
> > > > Lets use an example to clarify my secondary concern: a hub chip provides a
> > > > USB 3 and a USB 2 hub, lets say the USB 3 hub is the primary.
> > > > 
> > > > Here is some pseudo-code for the suspend function:
> > > > 
> > > > hub_suspend(hub)
> > > >   ...
> > > > 
> > > >   if (hub->primary) {
> > > >     device_pm_wait_for_dev(hub->peer)
> > > > 
> > > >     // check for connected devices and turn regulator off
> > > >   }
> > > > 
> > > >   ...
> > > > }
> > > > 
> > > > What I meant with 'asynchronous suspend' in this context:
> > > > 
> > > > Can hub_suspend() of the peer hub be executed (asynchronously) while the
> > > > primary is blocked on device_pm_wait_for_dev(),
> > > 
> > > Yes, that's exactly what would happen with async suspend.
> > > 
> > > >  or would the primary wait
> > > > forever if the peer hub isn't suspended yet?
> > > 
> > > That wouldn't happen.  device_pm_wait_for_dev is smart; it will return 
> > > immediately if neither device uses async suspend.  But in that case you 
> > > could end up removing power from the peer hub before it had suspended.
> > > 
> > > That's why I said you might need to add additional synchronization.  The 
> > > suspend routines for the two hubs could each check to see whether the 
> > > other device had suspended yet, and the last one would handle the power 
> > > regulator.  The additional synchronization is for the case where the two 
> > > checks end up being concurrent.
> > 
> > That was exactly my initial concern and one of the reasons I favor(ed) a
> > platform instead of a USB driver:
> 
> Clearly there's a tradeoff.
> 
> > > otherwise all hubs need to know their peers and check in suspend if they
> > > are the last hub standing, only then the power can be switched off.
> > 
> > To which you replied:
> > 
> > > you just need to make the "master" hub wait for its peer to suspend, which
> > > is easy to do.
> > 
> > However that apparently only works if async suspend is enabled, and we
> > can't rely on that.
> 
> Yes, I had forgotten about the possibility of synchronous suspend.  My 
> mistake.
> 
> > With the peers checking on each other you lose effectively the notion
> > of a primary.
> 
> Well, you can still want to put the sysfs power-control attribute file 
> into just one of the hubs' directories, and that one would be considered 
> the primary.  But I agree, it's a weak notion.
> 
> > Going back to the binding:
> > 
> >   &usb_1_dwc3 {
> >     hub_2_0: hub@1 {
> >       compatible = "usbbda,5411";
> >       reg = <1>;
> >     };
> > 
> >     hub_3_0: hub@2 {
> >       compatible = "usbbda,411";
> >       reg = <2>;
> >       vdd-supply = <&pp3300_hub>;
> >       companion-hubs = <&hub_2_0>;
> >     };
> >   };
> > 
> > How does 'hub_2_0' know that its peer is hub_3_0 and that it has a regulator
> > (and potentially other resources)?
> 
> The peering relation goes both ways, so it should be included in the 
> hub_2_0 description too.  Given that, the driver could check hub_2_0's 
> peer's DT description for the appropriate resources.

That mitigates the issue somewhat, however we still have to convince Rob that
both references are needed.

> > All this mess can be avoided by having a single instance in control of the
> > resources which is guaranteed to suspend after the USB devices.
> 
> Yes.  At the cost of registering, adding a driver for, and making users 
> aware of a fictitious platform device.

Registration is trivial and the driver code will be needed anyway, I'm
pretty convinced that a separate platform driver will be simpler than
plumbing things into the hub driver, with the additional checks of who is
suspended or not, etc. If other resources like resets are involved there
could be further possible race conditions at probe time. Another issue is
the sysfs attribute. We said to attach it to the primary hub. What happens
when the primary hub goes away? I guess we could force unbinding the peers
as we did in the driver under discussion to avoid confusion/inconsistencies,
but it's another tradeoff.

My view of the pros and cons of extending the hub driver vs. having a platform
driver:

- pros
  - sysfs attribute is attached to a USB hub device
  - no need to register a platform device (trivial)
  - potentially more USB awareness (not clear if needed)

- cons
  - possible races involving resources between peer hubs during initialization
  - increased complexity from keeping track of peers, checking suspend order
    and avoiding races
  - peers are forced to unbind when primary goes away
  - need DT links to peers for all USB hubs, not only in the primary
  - pollution of the generic hub code with device specific stuff instead
    of keeping it in a self contained driver
  - sysfs attribute is attached to only one of the hubs, which is better than
    having it on both, but not necessarily better than attaching it to the
    platform device with the 'control logic'

So yes, there are tradeoffs, IMO balance isn't as clear as your comment
suggests.
