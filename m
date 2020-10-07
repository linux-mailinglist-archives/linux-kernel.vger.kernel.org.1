Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B29CE2855A9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 03:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgJGBAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 21:00:25 -0400
Received: from netrider.rowland.org ([192.131.102.5]:55839 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726860AbgJGBAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 21:00:24 -0400
Received: (qmail 438874 invoked by uid 1000); 6 Oct 2020 21:00:23 -0400
Date:   Tue, 6 Oct 2020 21:00:23 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Matthias Kaehlcke <mka@chromium.org>
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
Message-ID: <20201007010023.GA438733@rowland.harvard.edu>
References: <CAD=FV=WcDzgcHNn1+gH+gq_WEwpD0XXdJGm2fBVpAB=3fVbzZA@mail.gmail.com>
 <CAL_Jsq+Zi+hCmUEiSmYw=pVK472=OW1ZjLnkH1NodWUm8FA5+g@mail.gmail.com>
 <CAD=FV=WJrvWBLk3oLpv6Q3uY4w7YeQBXVdkpn+SAS5dnxp9-=Q@mail.gmail.com>
 <CAL_JsqLWmBCjrbs2D-d+9naJAKkNhDAbmRtqvCDY8jv=L_q-xA@mail.gmail.com>
 <CAD=FV=XkV2eGuPhpo-v4bYy12DVNtDAtjyzpKs7r6SOUZf6-sg@mail.gmail.com>
 <20201006004510.GD4135817@google.com>
 <20201006141820.GA416765@rowland.harvard.edu>
 <20201006165957.GA191572@google.com>
 <20201006171524.GB423499@rowland.harvard.edu>
 <20201006192536.GB191572@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006192536.GB191572@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 06, 2020 at 12:25:36PM -0700, Matthias Kaehlcke wrote:
> On Tue, Oct 06, 2020 at 01:15:24PM -0400, Alan Stern wrote:
> > You don't need a platform device or a new driver to do this.  The code 
> > can go in the existing hub driver.
> 
> Maybe. IIUC currently USB drivers don't support/use suspend_late. Could that
> be added? It would simplify matters, otherwise all hubs need to know their
> peers and check in suspend if they are the last hub standing, only then the
> power can be switched off. It would be simpler if a single instance (e.g. the
> hub with the DT entries) is in control.

Adding suspend_late would be a little painful.  But you don't really 
need it; you just need to make the "master" hub wait for its peer to 
suspend, which is easy to do.

And hubs would need to know their peers in any case, because you have to 
check if any devices attached to the peer have wakeup enabled.

> > Incidentally, the peering information is already present in sysfs, 
> > although it is associated with a device's port on its upstream hub 
> > rather than with the device itself.
> 
> That might also help the hub driver to determine its peers without needing the
> 'companion-hubs' property.

It wouldn't hurt to have that property anyway.  The determination of 
peer ports doesn't always work right, because it depends on information 
provided by the firmware and that information isn't always correct.

Alan Stern
