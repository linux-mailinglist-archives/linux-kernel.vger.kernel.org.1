Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72C61285062
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 19:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbgJFRAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 13:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgJFRAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 13:00:00 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E09C0613D2
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 10:00:00 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id nl2so1650913pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 10:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=W+OwvA2XgottYqNbj2m2Re63qow6EKIPKlH3dYZhaIo=;
        b=TUIAHmCfa2ApU50+62vetEj4FJKpNKzLypA4i9rbCzgaXdTbMbdRYyWxgn2IVyarya
         5x3/C3Yi3bBsbRSj6p4s6lVWOVqK0vD2QiR5QLaB1SRy4DfpWziqXBRb5xHjSHOXP5Zm
         FQDevgm9fnFhCdpf+lBod5gAPIcXrbeV/XMlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W+OwvA2XgottYqNbj2m2Re63qow6EKIPKlH3dYZhaIo=;
        b=SrwkcOIdvm2qDEGdkZrDC4blDTMgHeJVPwiXqPFtDYtxIHEN95qSXiV48rq37B65eK
         Ew3x/BtFVtOeu0E1QzxYzbiB4/uN5OrgxO4Ha1Be2yGccBGYJTlh5seo25kaQ4SREzXT
         /O9mAToOa/EL0+aPv1hQTzdYlW18wU+sPE821b0wmwvuLDe/GT0r1ImU/Tw66psanCCH
         uLTDJJePOOUIroip08M6yAbR4O21qEvpZNdyshnap5tbT55/IpDMys2uKFQcJjx/vfgw
         Iaq30Ts79JBWeJy39SVYpKY0JhQNMRTEwT/fYMGl2Lx0Zg9px12NOAAj80c8DjoQFGoZ
         PtwA==
X-Gm-Message-State: AOAM531gwRQ/81QctDc6fIF1RhRBFGQbZt3V+eFUXHPrV9xmqsTrPQ8y
        g0yPn9vv+q8wZ6BBaryeFWJt9w==
X-Google-Smtp-Source: ABdhPJyXK9tnuldrWA9ft1+RbKXTOVvB4cSKziqBem1JndW/z49Cbi82Gcv89qsl0Sf8CbQwswqecw==
X-Received: by 2002:a17:902:ab88:b029:d3:b2d3:5708 with SMTP id f8-20020a170902ab88b02900d3b2d35708mr4029517plr.70.1602003599755;
        Tue, 06 Oct 2020 09:59:59 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id a11sm3332141pju.22.2020.10.06.09.59.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2020 09:59:59 -0700 (PDT)
Date:   Tue, 6 Oct 2020 09:59:57 -0700
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
Message-ID: <20201006165957.GA191572@google.com>
References: <20200930013229.GB194665@rowland.harvard.edu>
 <20200930124915.GA1826870@google.com>
 <CAL_JsqLq9ZJm_CMiqWwbQhgGeu_ac_j43pvk4+xCFueSbyL4wA@mail.gmail.com>
 <CAD=FV=WcDzgcHNn1+gH+gq_WEwpD0XXdJGm2fBVpAB=3fVbzZA@mail.gmail.com>
 <CAL_Jsq+Zi+hCmUEiSmYw=pVK472=OW1ZjLnkH1NodWUm8FA5+g@mail.gmail.com>
 <CAD=FV=WJrvWBLk3oLpv6Q3uY4w7YeQBXVdkpn+SAS5dnxp9-=Q@mail.gmail.com>
 <CAL_JsqLWmBCjrbs2D-d+9naJAKkNhDAbmRtqvCDY8jv=L_q-xA@mail.gmail.com>
 <CAD=FV=XkV2eGuPhpo-v4bYy12DVNtDAtjyzpKs7r6SOUZf6-sg@mail.gmail.com>
 <20201006004510.GD4135817@google.com>
 <20201006141820.GA416765@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201006141820.GA416765@rowland.harvard.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 06, 2020 at 10:18:20AM -0400, Alan Stern wrote:
> On Mon, Oct 05, 2020 at 05:45:10PM -0700, Matthias Kaehlcke wrote:
> > I did some prototyping, it seems a binding like this would work for
> > case a) or b):
> > 
> > &usb_1_dwc3 {
> >         hub_2_0: hub@1 {
> >                 compatible = "usbbda,5411";
> >                 reg = <1>;
> > 	};
> > 
> >         hub_3_0: hub@2 {
> >                 compatible = "usbbda,411";
> >                 reg = <2>;
> >                 vdd-supply = <&pp3300_hub>;
> > 		companion-hubs = <&hub_2_0>;
> >         };
> > };
> > 
> > It still requires specifying both hubs (which reflects the actual wiring).
> > Supporting something like "reg = <1 2>" seems more complex due to the need to
> > obtain the hub USB device at runtime (a DT node makes that trivial), possibly
> > this could be solved by adding new APIs.
> > 
> > In terms of implementation would I envision to keep a platform driver. This
> > would keep the hubby parts out of xhci-plat (except for populating the platform
> > devices), support systems with cascaded hubs and provide a device for the sysfs
> > attribute.
> 
> What will you do if a system has more than one of these power-regulated 
> hubs?  That is, how will the user know which platform device handles the 
> power control for a particular hub (and vice versa)?  You'd probably 
> have to create a pair of symlinks going back and forth in the sysfs 
> directories.

The platform device would use the same DT node as the USB device, hence the
sysfs path of the platform device could be derived from the DT.

> Wouldn't it be easier to put the power-control attribute directly in the 
> hub's sysfs directory (or .../power subdirectory)?

Not sure. In terms of implementation it would be more complex (but not rocket
science either), from a userspace perspective there are pros and cons.

A platform driver (or some other control instance) is needed anyway, to check
the connected devices on both hubs and cut power only after the USB devices
are suspended. With the sysfs attribute associated with the platform device
it wouldn't even be necessary to have a separate USB driver. The platform
driver would have to evaluate the sysfs attribute of the USB device(s), which
can be done but is a bit odd.

For a user it might be slightly simpler if they don't have to care about the
existence of a platform device (but it's just a matter of knowing). The
attribute must only be associated with one of the USB devices, which might
be confusing, however it would be messy if each hub had an attribute. The
attribute could be only associated with the 'primary hub', i.e. the one that
specifies 'vdd-supply' or other attributes needed by the driver.
