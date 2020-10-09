Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB1CC289C09
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Oct 2020 01:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbgJIXNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 19:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbgJIXNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 19:13:47 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D52C0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 16:13:46 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id a200so8093260pfa.10
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 16:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R6gKWk0XgYJ+bRnJwNiMBZzjtd7hCRQG5lPlBLNpIXg=;
        b=SvBHuBUELCUejxiMecoCCc4s6g/H5gNRiExeY5Is+T+5LzTbZxIEgmCj9P6gp9rWzN
         /kVobTkY+otVFfZ6XhrktP3GuZVzkcodQU4FnXs464qkoOVPELG4L9FfHo1yk42cjJk5
         EnMK8Oympvig2CRehaT+Oium1B2tLhdyhCa3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R6gKWk0XgYJ+bRnJwNiMBZzjtd7hCRQG5lPlBLNpIXg=;
        b=eG69nurM/XcB3nm8Hl5mn/CFdrSMqd2VLlw4X9vrbEnYz7asnxTpguwUeJUJQgcDbZ
         rwAJK/wBKBDZjCZtq9/9SDWTYfAarJKs1N/JcrdfVmDdW0HCXzfkgx5Owl7FvoCjZrtr
         n5+ye+ZW7Gpk8RQiVrVnloN6A6ZRyN4namAMwQq5GN8cMAA6r92zD84/K7QAvXu5FpMK
         nfTD9SSWki4tacvKuQ67zEfvaUABkeyXLLIF+1dL1rE920NjCVEEAYR5Zt3lGi9f1Ph6
         GhGz3iYuFf5NbuKRk+QrZBepkqajexZfPLAHwRS60xYe9kbZljA6cRgVTdhBHnv5T4IR
         ayJQ==
X-Gm-Message-State: AOAM530IqFqLgUmfZh70pNuR15uwbbQD20G1sitRHUoPtSiYCS8TDc0W
        nfNLq9zFUw+ss+fKvB7gf84hkA==
X-Google-Smtp-Source: ABdhPJzy8dpSt4depYawxqjmWVuoIHMAgsxXHG0jJxI96tFDpbhg+3/cQEJxcqVr55/jRvbazfFHrQ==
X-Received: by 2002:a63:dd4e:: with SMTP id g14mr5038012pgj.44.1602285226319;
        Fri, 09 Oct 2020 16:13:46 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id y5sm13316996pge.62.2020.10.09.16.13.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2020 16:13:45 -0700 (PDT)
Date:   Fri, 9 Oct 2020 16:13:43 -0700
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
Message-ID: <20201009231343.GC1292413@google.com>
References: <20201006192536.GB191572@google.com>
 <20201007010023.GA438733@rowland.harvard.edu>
 <20201007160336.GA620323@google.com>
 <20201007163838.GA457977@rowland.harvard.edu>
 <20201007172847.GB620323@google.com>
 <20201007192542.GA468921@rowland.harvard.edu>
 <20201007194229.GC620323@google.com>
 <20201007201732.GE468921@rowland.harvard.edu>
 <20201007214226.GA669360@google.com>
 <20201008140927.GB495091@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201008140927.GB495091@rowland.harvard.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 08, 2020 at 10:09:27AM -0400, Alan Stern wrote:
> On Wed, Oct 07, 2020 at 02:42:26PM -0700, Matthias Kaehlcke wrote:
> > On Wed, Oct 07, 2020 at 04:17:32PM -0400, Alan Stern wrote:
> > > The peering relation goes both ways, so it should be included in the 
> > > hub_2_0 description too.  Given that, the driver could check hub_2_0's 
> > > peer's DT description for the appropriate resources.
> > 
> > That mitigates the issue somewhat, however we still have to convince Rob that
> > both references are needed.
> 
> Strictly speaking, the peering relation applies to ports, not
> devices.  The representation in DT doesn't have to be symmetrical; as
> long as the kernel understands it, the kernel can set up its own
> internal symmetrical respresentation.
> 
> > > > All this mess can be avoided by having a single instance in control of the
> > > > resources which is guaranteed to suspend after the USB devices.
> > > 
> > > Yes.  At the cost of registering, adding a driver for, and making users 
> > > aware of a fictitious platform device.
> > 
> > Registration is trivial and the driver code will be needed anyway, I'm
> > pretty convinced that a separate platform driver will be simpler than
> > plumbing things into the hub driver, with the additional checks of who is
> > suspended or not, etc. If other resources like resets are involved there
> > could be further possible race conditions at probe time. Another issue is
> > the sysfs attribute. We said to attach it to the primary hub. What happens
> > when the primary hub goes away? I guess we could force unbinding the peers
> > as we did in the driver under discussion to avoid confusion/inconsistencies,
> > but it's another tradeoff.
> > 
> > My view of the pros and cons of extending the hub driver vs. having a platform
> > driver:
> > 
> > - pros
> >   - sysfs attribute is attached to a USB hub device
> >   - no need to register a platform device (trivial)
> >   - potentially more USB awareness (not clear if needed)
> > 
> > - cons
> >   - possible races involving resources between peer hubs during initialization
> >   - increased complexity from keeping track of peers, checking suspend order
> >     and avoiding races
> >   - peers are forced to unbind when primary goes away
> >   - need DT links to peers for all USB hubs, not only in the primary
> >   - pollution of the generic hub code with device specific stuff instead
> >     of keeping it in a self contained driver
> >   - sysfs attribute is attached to only one of the hubs, which is better than
> >     having it on both, but not necessarily better than attaching it to the
> >     platform device with the 'control logic'
> > 
> > So yes, there are tradeoffs, IMO balance isn't as clear as your comment
> > suggests.
> 
> Well, I guess I'm okay with either approach.

Thanks for being flexible.

I'm also open to the other approach, if you or others are convinced that a
platform device is a really bad idea.

> One more thing to keep in mind, though: With the platform device,
> there should be symlinks from the hubs' sysfs directories to the
> platform device (and possibly symlinks going the other way as well).

Ok, I hoped we could get away with no USB driver at all, but I think it will
be needed to create the symlinks (on its own the platform driver wouldn't notice
when the USB devices come and go). Anyway, it's a relatively thin layer of code,
so it's not too bad. With the new binding the USB devices still should be able
to find the platform device if it uses the same DT node as the primary USB hub.
