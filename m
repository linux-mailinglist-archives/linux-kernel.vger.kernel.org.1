Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8B7A283FBD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 21:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729434AbgJETgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 15:36:12 -0400
Received: from netrider.rowland.org ([192.131.102.5]:45865 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1729302AbgJETgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 15:36:12 -0400
Received: (qmail 390590 invoked by uid 1000); 5 Oct 2020 15:36:11 -0400
Date:   Mon, 5 Oct 2020 15:36:11 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Matthias Kaehlcke <mka@chromium.org>
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
Message-ID: <20201005193611.GA389867@rowland.harvard.edu>
References: <CAL_JsqLq9ZJm_CMiqWwbQhgGeu_ac_j43pvk4+xCFueSbyL4wA@mail.gmail.com>
 <CAD=FV=WcDzgcHNn1+gH+gq_WEwpD0XXdJGm2fBVpAB=3fVbzZA@mail.gmail.com>
 <CAL_Jsq+Zi+hCmUEiSmYw=pVK472=OW1ZjLnkH1NodWUm8FA5+g@mail.gmail.com>
 <CAD=FV=WJrvWBLk3oLpv6Q3uY4w7YeQBXVdkpn+SAS5dnxp9-=Q@mail.gmail.com>
 <20201002183633.GA296334@rowland.harvard.edu>
 <CAL_JsqKHFA5RWz1SRLkR2JXydURL2pA+4C0+C+4SrJR_h4M0dw@mail.gmail.com>
 <20201003124142.GA318272@rowland.harvard.edu>
 <20201005160655.GA4135817@google.com>
 <20201005161527.GI376584@rowland.harvard.edu>
 <20201005191812.GB4135817@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005191812.GB4135817@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 05, 2020 at 12:18:12PM -0700, Matthias Kaehlcke wrote:
> On Mon, Oct 05, 2020 at 12:15:27PM -0400, Alan Stern wrote:
> > The conclusion is that we need to have code that is aware of some 
> > detailed needs of a specific device but is not part of the device's 
> > driver.  I'm not sure what the best way to implement this would be.
> 
> Wouldn't it be possible to load the module when the DT specifies that
> the device exists? For USB the kernel would need the VID/PID to identify
> the module, these could be extracted from the compatible string.

Loading a driver module whenever DT says a device exists?  Not a bad 
idea.  I don't know what would be involved, but no doubt it is possible.

Note that, except for a few special cases, the kernel identifies the 
appropriate driver for USB hubs not by the VID/PID but instead by the 
device class or interface class.  I suppose the compatible string could 
include that information too?

> Having the initialization code outside of the driver could lead to code
> duplication, since the driver might want to power the device down in
> certain situations (e.g. system suspend).

True.  On the other hand, how common do you think it would be for 
drivers not to want to mess with the power settings?

Alan Stern
