Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C272E2A50B8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 21:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729286AbgKCUHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 15:07:23 -0500
Received: from netrider.rowland.org ([192.131.102.5]:40629 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1729160AbgKCUHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 15:07:22 -0500
Received: (qmail 1538831 invoked by uid 1000); 3 Nov 2020 15:07:16 -0500
Date:   Tue, 3 Nov 2020 15:07:16 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Wesley Cheng <wcheng@codeaurora.org>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org,
        Thinh.Nguyen@synopsys.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, jackp@codeaurora.org
Subject: Re: [PATCH 1/2] usb: dwc3: gadget: Allow runtime suspend if UDC
 unbinded
Message-ID: <20201103200716.GA1538425@rowland.harvard.edu>
References: <20201028234311.6464-1-wcheng@codeaurora.org>
 <20201028234311.6464-2-wcheng@codeaurora.org>
 <20201029010748.GA1303156@rowland.harvard.edu>
 <a47d78f3-0a11-9de8-dbea-ad745d496845@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a47d78f3-0a11-9de8-dbea-ad745d496845@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 03, 2020 at 11:02:25AM -0800, Wesley Cheng wrote:
> 
> 
> On 10/28/2020 6:07 PM, Alan Stern wrote:
> >> --- a/drivers/usb/dwc3/gadget.c
> >> +++ b/drivers/usb/dwc3/gadget.c
> >> @@ -1995,6 +1995,11 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
> >>  	unsigned long		flags;
> >>  	int			ret;
> >>  
> >> +	if (pm_runtime_suspended(dwc->dev)) {
> >> +		pm_request_resume(dwc->dev);
> >> +		return 0;
> >> +	}
> > 
> > Isn't this racy?  What happens if the controller was active but a 
> > runtime suspend occurs right here?
> > 
> > Alan Stern
> > 
> 
> Hi Alan,
> 
> Ah, yes you're right.  I was hoping that the PM runtime layer would be
> utilizing the spinlock when reading out the runtime status, but even
> then, we wouldn't be able to catch intermediate states with this API
> (i.e. RPM_RESUMING or RPM_SUSPENDING)
> 
> Tried a few different approaches, and came up with something like the
> following:
> 
> static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
> {
> ...
> 	ret = pm_runtime_get_sync(dwc->dev);
> 	if (!ret) {
> 		pm_runtime_put(dwc->dev);
> 		return 0;
> 	}
> 	...
> 	pm_runtime_put(dwc->dev);
> 
> 	return 0;
> }
> 
> I think this should be good to address your concern.  The only way we
> would be able to ensure that the runtime PM state doesn't enter
> idle/suspend is if we increment the usage count for the duration we're
> accessing the DWC3 registers.  With the synchronous PM runtime resume
> call, we can also ensure that no pending runtime suspends are executing
> in parallel while running this code.

That's correct.

> The check for the zero return value would be for avoiding running the
> DWC3 run stop sequence for the case where we executed the runtime PM
> resume, as the DWC3 runtime PM resume routine will set the run stop bit
> in there.

If you need to add an explanation of this subtle point in your email 
message, then you should add a similar explanation as a comment in the 
code.  And don't forget to check for ret < 0 (i.e., a resume error).

Alan Stern
