Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2CA28525E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 21:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbgJFTZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 15:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbgJFTZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 15:25:39 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499D2C0613D2
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 12:25:39 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id j8so2081852pjy.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 12:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=H1S1hI//ma3FrCrBRy7TahA+GV00pTI+UDYuYZhYl2A=;
        b=ob6fTCeBTR795PxooQw1KGe059sDXLIl9lbcDbuvxoQKniAPqI6M3vfw7ml33E0DcA
         YQAnJnCd8Lr2T1RToppS2IMw1mIfDTd2vmJjz8wDCwvXAmTKAkDLbJ4IziD4qrj/XrXq
         m+DiCBLmVer2rn8x15SwdCCVR8cEhBjhcf99E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H1S1hI//ma3FrCrBRy7TahA+GV00pTI+UDYuYZhYl2A=;
        b=HHSFwKqiOOaxu3uyS+LASvgoZl1ABOhxgp3hMomY1Rw7CbNvm8EQEgKGnMI7YadnYX
         emEWGVrVuq0l5eNbGlUK78+addwbM63mrcTS0WSJUCOCBqhudXEmLNJhUX/jWgsWsTHD
         7p2cKJT/HKIn97m9izDiE3sbKF6Txs+qFR3MyGlWzvSd/lYrmqSH9/f1m2o4psxAfMLv
         H9sAz+DVoz4vVlyA+DaarXRiEqG7wXO3ygR/qeG5U9cvojeG7Jf8thZfGj4CyY1sWQjg
         6pxBG0wICmPja6PhlBSeMqrVXh2EHancjqsHMnaux4WssEflufnPNp74nuMxd8f/+VO2
         SAHQ==
X-Gm-Message-State: AOAM531Ow8UqJFj6cIrCvzzUaphF1vREZJ2x11iFqkYTt9MOr2rXXZFy
        jHR3TmahvK8dIx1so0wTB1XvKQ==
X-Google-Smtp-Source: ABdhPJzgB5N4X4KsJXjTcXOMMdQXiLuFRdlGTAyjj5WeOA2UuLcIgpWjx9Rw3qhPySO1kloU/HVS9g==
X-Received: by 2002:a17:902:b70d:b029:d2:6277:385f with SMTP id d13-20020a170902b70db02900d26277385fmr4672800pls.25.1602012338722;
        Tue, 06 Oct 2020 12:25:38 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id r6sm4731805pfq.11.2020.10.06.12.25.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2020 12:25:38 -0700 (PDT)
Date:   Tue, 6 Oct 2020 12:25:36 -0700
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
Message-ID: <20201006192536.GB191572@google.com>
References: <CAL_JsqLq9ZJm_CMiqWwbQhgGeu_ac_j43pvk4+xCFueSbyL4wA@mail.gmail.com>
 <CAD=FV=WcDzgcHNn1+gH+gq_WEwpD0XXdJGm2fBVpAB=3fVbzZA@mail.gmail.com>
 <CAL_Jsq+Zi+hCmUEiSmYw=pVK472=OW1ZjLnkH1NodWUm8FA5+g@mail.gmail.com>
 <CAD=FV=WJrvWBLk3oLpv6Q3uY4w7YeQBXVdkpn+SAS5dnxp9-=Q@mail.gmail.com>
 <CAL_JsqLWmBCjrbs2D-d+9naJAKkNhDAbmRtqvCDY8jv=L_q-xA@mail.gmail.com>
 <CAD=FV=XkV2eGuPhpo-v4bYy12DVNtDAtjyzpKs7r6SOUZf6-sg@mail.gmail.com>
 <20201006004510.GD4135817@google.com>
 <20201006141820.GA416765@rowland.harvard.edu>
 <20201006165957.GA191572@google.com>
 <20201006171524.GB423499@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201006171524.GB423499@rowland.harvard.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 06, 2020 at 01:15:24PM -0400, Alan Stern wrote:
> On Tue, Oct 06, 2020 at 09:59:57AM -0700, Matthias Kaehlcke wrote:
> > On Tue, Oct 06, 2020 at 10:18:20AM -0400, Alan Stern wrote:
> > > On Mon, Oct 05, 2020 at 05:45:10PM -0700, Matthias Kaehlcke wrote:
> > > > I did some prototyping, it seems a binding like this would work for
> > > > case a) or b):
> > > > 
> > > > &usb_1_dwc3 {
> > > >         hub_2_0: hub@1 {
> > > >                 compatible = "usbbda,5411";
> > > >                 reg = <1>;
> > > > 	};
> > > > 
> > > >         hub_3_0: hub@2 {
> > > >                 compatible = "usbbda,411";
> > > >                 reg = <2>;
> > > >                 vdd-supply = <&pp3300_hub>;
> > > > 		companion-hubs = <&hub_2_0>;
> > > >         };
> > > > };
> > > > 
> > > > It still requires specifying both hubs (which reflects the actual wiring).
> > > > Supporting something like "reg = <1 2>" seems more complex due to the need to
> > > > obtain the hub USB device at runtime (a DT node makes that trivial), possibly
> > > > this could be solved by adding new APIs.
> > > > 
> > > > In terms of implementation would I envision to keep a platform driver. This
> > > > would keep the hubby parts out of xhci-plat (except for populating the platform
> > > > devices), support systems with cascaded hubs and provide a device for the sysfs
> > > > attribute.
> > > 
> > > What will you do if a system has more than one of these power-regulated 
> > > hubs?  That is, how will the user know which platform device handles the 
> > > power control for a particular hub (and vice versa)?  You'd probably 
> > > have to create a pair of symlinks going back and forth in the sysfs 
> > > directories.
> > 
> > The platform device would use the same DT node as the USB device, hence the
> > sysfs path of the platform device could be derived from the DT.
> 
> That doesn't do the user (or a program the user is running) any good.  
> You can't expect them to go searching through the system's DT 
> description looking for this information.  All they know is the hub's 
> location in sysfs.
> 
> > > Wouldn't it be easier to put the power-control attribute directly in the 
> > > hub's sysfs directory (or .../power subdirectory)?
> > 
> > Not sure. In terms of implementation it would be more complex (but not rocket
> > science either), from a userspace perspective there are pros and cons.
> > 
> > A platform driver (or some other control instance) is needed anyway, to check
> > the connected devices on both hubs and cut power only after the USB devices
> > are suspended. With the sysfs attribute associated with the platform device
> > it wouldn't even be necessary to have a separate USB driver. The platform
> > driver would have to evaluate the sysfs attribute of the USB device(s), which
> > can be done but is a bit odd.
> 
> You don't need a platform device or a new driver to do this.  The code 
> can go in the existing hub driver.

Maybe. IIUC currently USB drivers don't support/use suspend_late. Could that
be added? It would simplify matters, otherwise all hubs need to know their
peers and check in suspend if they are the last hub standing, only then the
power can be switched off. It would be simpler if a single instance (e.g. the
hub with the DT entries) is in control.

> > For a user it might be slightly simpler if they don't have to care about the
> > existence of a platform device (but it's just a matter of knowing). The
> > attribute must only be associated with one of the USB devices, which might
> > be confusing, however it would be messy if each hub had an attribute. The
> > attribute could be only associated with the 'primary hub', i.e. the one that
> > specifies 'vdd-supply' or other attributes needed by the driver.
> 
> Okay.  Or you could always put it in the USB-2 hub.

Yes, some criteria like this.

> Incidentally, the peering information is already present in sysfs, 
> although it is associated with a device's port on its upstream hub 
> rather than with the device itself.

That might also help the hub driver to determine its peers without needing the
'companion-hubs' property.
