Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC8142EEF3E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 10:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbhAHJMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 04:12:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:48656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727906AbhAHJMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 04:12:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E70522248;
        Fri,  8 Jan 2021 09:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610097131;
        bh=DZfi/I+2yXa4/m5ViwQoChMYe+Ckti6vA220I8dggV4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o++K5dKK+ctBEHmms2e/B1ounGtdhNSqrQ6j6DO50hwBrQh7MJrpOzMfvT/3SUOCS
         3tWht+wTZY/IQ8KsSo3NiyADAozYEJuaiKr2qxtC4baSIV6eon3dYefeHiW5gD7Ka4
         J2j6QymNlShZWTQ9tQ+kWiElFgtkmz+D/TNu80cc=
Date:   Fri, 8 Jan 2021 10:13:28 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <wcheng@codeaurora.org>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 2/3] usb: gadget: composite: Split composite reset and
 disconnect
Message-ID: <X/giOFJLsx2E3krg@kroah.com>
References: <1609283011-21997-1-git-send-email-wcheng@codeaurora.org>
 <1609283011-21997-3-git-send-email-wcheng@codeaurora.org>
 <87k0srcyq7.fsf@kernel.org>
 <37f3412c-9e91-eb1e-3974-bb16546b4b39@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37f3412c-9e91-eb1e-3974-bb16546b4b39@synopsys.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021 at 02:19:30AM +0000, Thinh Nguyen wrote:
> Hi Wesley,
> 
> Felipe Balbi wrote:
> > Hi,
> >
> > Wesley Cheng <wcheng@codeaurora.org> writes:
> >> +void composite_reset(struct usb_gadget *gadget)
> >> +{
> >> +	/*
> >> +	 * Section 1.4.13 Standard Downstream Port of the USB battery charging
> >> +	 * specification v1.2 states that a device connected on a SDP shall only
> >> +	 * draw at max 100mA while in a connected, but unconfigured state.
> > The requirements are different, though. I think OTG spec has some extra
> > requirements where only 8mA can be drawn max. You need to check for the
> > otg flag. Moreover, USB3+ spec has units of 150mA meaning the device
> > can't draw 100mA (IIRC).
> >
> 
> We see issue with this patch series. For our device running at SSP, the
> device couldn't recover from a port reset and remained in eSS.Inactive
> state.
> 
> This patch series is already in Greg's usb-testing. Please review and
> help fix it.

Should I just revert this?  I'll be glad to drop it.

thanks,

greg k-h
