Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7227C282419
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 14:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725813AbgJCMln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 08:41:43 -0400
Received: from netrider.rowland.org ([192.131.102.5]:56145 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1725777AbgJCMln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 08:41:43 -0400
Received: (qmail 318963 invoked by uid 1000); 3 Oct 2020 08:41:42 -0400
Date:   Sat, 3 Oct 2020 08:41:42 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Rob Herring <robh@kernel.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
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
Message-ID: <20201003124142.GA318272@rowland.harvard.edu>
References: <20200929201701.GA1080459@bogus>
 <20200929220912.GF1621304@google.com>
 <20200930013229.GB194665@rowland.harvard.edu>
 <20200930124915.GA1826870@google.com>
 <CAL_JsqLq9ZJm_CMiqWwbQhgGeu_ac_j43pvk4+xCFueSbyL4wA@mail.gmail.com>
 <CAD=FV=WcDzgcHNn1+gH+gq_WEwpD0XXdJGm2fBVpAB=3fVbzZA@mail.gmail.com>
 <CAL_Jsq+Zi+hCmUEiSmYw=pVK472=OW1ZjLnkH1NodWUm8FA5+g@mail.gmail.com>
 <CAD=FV=WJrvWBLk3oLpv6Q3uY4w7YeQBXVdkpn+SAS5dnxp9-=Q@mail.gmail.com>
 <20201002183633.GA296334@rowland.harvard.edu>
 <CAL_JsqKHFA5RWz1SRLkR2JXydURL2pA+4C0+C+4SrJR_h4M0dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqKHFA5RWz1SRLkR2JXydURL2pA+4C0+C+4SrJR_h4M0dw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 02, 2020 at 05:58:22PM -0500, Rob Herring wrote:
> On Fri, Oct 2, 2020 at 1:36 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > Regardless of how the situation is represented in DT, there remains the
> > issue of where (i.e., in which driver module) the appropriate code
> > belongs.  This goes far beyond USB.  In general, what happens when one
> > sort of device normally isn't hooked up through a power regulator, so
> > its driver doesn't have any code to enable a regulator, but then some
> > system does exactly that?
> >
> > Even worse, what if the device is on a discoverable bus, so the driver
> > doesn't get invoked at all until the device is discovered, but on the
> > new system it can't be discovered until the regulator is enabled?
> 
> Yep, it's the same issue here with USB, MDIO which just came up a few
> weeks ago, MMC/SD which hacked around it with 'mmc-pwrseq' binding
> (not something I want to duplicate) and every other discoverable bus.
> What do they all have in common? The kernel's driver model being
> unable to cope with this situation. We really need a common solution
> here and not bus or device specific hack-arounds.

To me this doesn't seem quite so much to be a weakness of the kernel's 
driver model.

It's a platform-specific property, one that is not discoverable and 
therefore needs to be represented somehow in DT or ACPI or something 
similar.  Something that says "Device A cannot operate or be discovered 
until power regulator B is enabled", for example.

The decision to enable the power regulator at system startup would be 
kernel policy, not a part of the DT description.  But there ought to be 
a standard way of recognizing which resource requirements of this sort 
should be handled at startup.  Then there could be a special module (in 
the driver model core? -- that doesn't really seem appropriate) which 
would search through the whole DT database for resources of this kind 
and enable them.

The case that Matthias is working on is even more complicated 
because he wants to add a platform-specific sysfs attribute for 
controlling the power resource.  But I think that would be relatively 
easy to set up, if only we could guarantee that the power regulator 
would be enabled initially so that the hub can be discovered.

Alan Stern
