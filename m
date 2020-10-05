Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB6F7283C31
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 18:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbgJEQP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 12:15:28 -0400
Received: from netrider.rowland.org ([192.131.102.5]:57549 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727224AbgJEQP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 12:15:28 -0400
Received: (qmail 382715 invoked by uid 1000); 5 Oct 2020 12:15:27 -0400
Date:   Mon, 5 Oct 2020 12:15:27 -0400
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
Message-ID: <20201005161527.GI376584@rowland.harvard.edu>
References: <20200930013229.GB194665@rowland.harvard.edu>
 <20200930124915.GA1826870@google.com>
 <CAL_JsqLq9ZJm_CMiqWwbQhgGeu_ac_j43pvk4+xCFueSbyL4wA@mail.gmail.com>
 <CAD=FV=WcDzgcHNn1+gH+gq_WEwpD0XXdJGm2fBVpAB=3fVbzZA@mail.gmail.com>
 <CAL_Jsq+Zi+hCmUEiSmYw=pVK472=OW1ZjLnkH1NodWUm8FA5+g@mail.gmail.com>
 <CAD=FV=WJrvWBLk3oLpv6Q3uY4w7YeQBXVdkpn+SAS5dnxp9-=Q@mail.gmail.com>
 <20201002183633.GA296334@rowland.harvard.edu>
 <CAL_JsqKHFA5RWz1SRLkR2JXydURL2pA+4C0+C+4SrJR_h4M0dw@mail.gmail.com>
 <20201003124142.GA318272@rowland.harvard.edu>
 <20201005160655.GA4135817@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005160655.GA4135817@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 05, 2020 at 09:06:55AM -0700, Matthias Kaehlcke wrote:
> On Sat, Oct 03, 2020 at 08:41:42AM -0400, Alan Stern wrote:
> > The decision to enable the power regulator at system startup would be 
> > kernel policy, not a part of the DT description.  But there ought to be 
> > a standard way of recognizing which resource requirements of this sort 
> > should be handled at startup.  Then there could be a special module (in 
> > the driver model core? -- that doesn't really seem appropriate) which 
> > would search through the whole DT database for resources of this kind 
> > and enable them.
> 
> This might work for some cases that only have a single resource or multiple
> resources but no timing/sequencing requirements. For the more complex cases
> it would probably end up in something similar to the pwrseq series
> (https://lore.kernel.org/patchwork/project/lkml/list/?series=314989&state=%2A&archive=both),
> which was nack-ed by Rafael, Rob also expressed he didn't want to go
> down that road.
> 
> It seems to me that initialization of the resources needs to be done by
> the/a driver for the device, which knows about the sequencing requirements.
> Potentially this could be done in a pre-probe function that you brought up
> earlier.

One of the important points of my suggestion was that the resource init 
should be done _outside_ of the device's driver, precisely because the 
driver module might not even be loaded until the resources are set up 
and the device is discovered.

The conclusion is that we need to have code that is aware of some 
detailed needs of a specific device but is not part of the device's 
driver.  I'm not sure what the best way to implement this would be.

Alan Stern
