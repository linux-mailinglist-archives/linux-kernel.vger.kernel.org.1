Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F28CA275FD6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 20:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgIWS3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 14:29:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:35418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726706AbgIWS3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 14:29:30 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A876F20791;
        Wed, 23 Sep 2020 18:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600885770;
        bh=0sHCuT8CFFsOMfyuRSNHC+d3cxslZeaYTJSCn7nGmYA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZWlA2OqYIx2gDAYSejgVz9J+pnSCY3GLFXaEeAXLhuFWTa3WXzlFit1nHKGvdaPCd
         6jSrpQoR8xuH8cQ9Eu7rJc5VT0w51ov7qUVGracWaov+Sr8V82Q7IGnPx6XLT0xzHg
         3QdiqHmdYd9e+S4XMHWQ5gEuRIfsTelWPG6LCIGU=
Date:   Wed, 23 Sep 2020 20:29:48 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        =?utf-8?B?Qmxhxb4=?= Hrastnik <blaz@mxxn.io>,
        Dorian Stoll <dorian.stoll@tmsp.io>
Subject: Re: [RFC PATCH 8/9] surface_aggregator: Add DebugFS interface
Message-ID: <20200923182948.GA107114@kroah.com>
References: <20200923151511.3842150-1-luzmaximilian@gmail.com>
 <20200923151511.3842150-9-luzmaximilian@gmail.com>
 <20200923161416.GA3723109@kroah.com>
 <7d571ed4-862e-cfbd-44d4-0fda25f03294@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d571ed4-862e-cfbd-44d4-0fda25f03294@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 08:03:38PM +0200, Maximilian Luz wrote:
> On 9/23/20 6:14 PM, Greg Kroah-Hartman wrote:
> > On Wed, Sep 23, 2020 at 05:15:10PM +0200, Maximilian Luz wrote:
> [...]
> 
> > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > 
> > Are you sure about -or-later?  I have to ask.
> 
> Fairly, unless there are any complications with integration of this code
> that I'm not aware of.

Nope, just have to ask :)

> > > +out:
> > > +	// always try to set response-length and status
> > > +	tmp = put_user(rsp.length, &r->response.length);
> > > +	if (!ret)
> > > +		ret = tmp;
> > 
> > Is that the correct error to return if put_user() fails?  Hint, I don't
> > think so...
> 
> So the -EFAULT returned by put_user should have precedence? I was aiming
> for "in case it fails, return with the first error".

-EFAULT trumps everything :)

> 
> [...]
> 
> > > +static long ssam_dbg_device_ioctl(struct file *file, unsigned int cmd,
> > > +				    unsigned long arg)
> > > +{
> > > +	switch (cmd) {
> > > +	case SSAM_DBG_IOCTL_GETVERSION:
> > > +		return ssam_dbg_if_getversion(file, arg);
> > 
> > Not needed, please drop.
> > 
> > > +
> > > +	case SSAM_DBG_IOCTL_REQUEST:
> > > +		return ssam_dbg_if_request(file, arg);
> > > +
> > > +	default:
> > > +		return -ENOIOCTLCMD;
> > 
> > Wrong error value.
> 
> I assume -ENOTTY would be correct/preferred then? Kernel doc suggests
> that either one of the two would be correct and essentially result in
> the same behavior.

-ENOTTY is the correct one, it will be turned into a different value
right before it gets back to userspace.

> > Listen, I'm all for doing whatever you want in debugfs, but why are you
> > doing random ioctls here?  Why not just read/write a file to do what you
> > need/want to do here instead?
> 
> Two reasons, mostly: First, the IOCTL allows me to execute requests in
> parallel with just one open file descriptor and not having to maintain
> some sort of back-buffer to wait around until the reader gets to reading
> the thing. I've used that for stress-testing the EC communication in the
> past, which had some issues (dropping bytes, invalid CRCs, ...) under
> heavy(-ish) load. Second, I'm considering adding support for events to
> this device in the future by having user-space receive events by reading
> from the device. Events would also be enabled or disabled via an IOCTL.
> That could be implemented in a second device though. Events were also my
> main reason for adding a version to this interface: Discerning between
> one that has event support and one that has not.

A misc device can also do this, much simpler, right?  Why not use that?

Oh, after fixing up the issues that Arnd pointed out of course :)

> > > +static void ssam_dbg_device_release(struct device *dev)
> > > +{
> > > +	// nothing to do
> > 
> > That's a lie, and the old documentation would allow me to make fun of
> > you for trying to work around the kernel's error messages here.
> > 
> > But I'll be nice and just ask, why do you think it is ok to work around
> > a message that someone has spent a lot of time and energy to provide to
> > you, saying that you are doing something wrong, by ignoring that and
> > providing an empty function?  Not kind...
> 
> Sorry about that, but may get a pointer to that particular message? This
> setup has been pretty much copied from existing kernel drivers (see
> /drivers/platform/x86/intel_pmc_core_pltdrv.c for one)

Oh wow, time to go yell at people, thanks for pointing that out...

> and I thought
> that I can get around having to dynamically allocate a platform device
> since it's guaranteed to be only there once.
> 
> There was no workaround or unkindness of any sorts intended.

See device_release() in drivers/base/core.c for the error message you
would have gotten that this empty function "works around".

> > > +}
> > > +
> > > +static struct platform_device ssam_dbg_device = {
> > > +	.name = SSAM_DBG_DEVICE_NAME,
> > > +	.id = PLATFORM_DEVID_NONE,
> > > +	.dev.release = ssam_dbg_device_release,
> > > +};
> > 
> > Dynamic structures that are static are, well, wrong :)
> 
> I assume the correct way would be to allocate the device dynamically and
> this holds for all devices?
> 
> Sorry if I'm asking such basic questions, but I have not found anything
> regarding this in the documentation, although I have to confess that I
> only skimmed over a larger part, so that's very likely my fault.
> 
> > I appreciate the initiative by creating a fake platform device and
> > driver to bind to that device.  But I don't think any of it is needed at
> > all, you have made your work a lot harder than you needed to here.  This
> > whole file can be _much_ smaller and simpler and not abuse the kernel
> > apis so badly :)
> 
> So just tack it onto the core driver? My intention was to keep it a bit
> more separate from the core, but adding it directly would indeed reduce
> the amount of code.

A simple misc device would make it very simple and easy to do instead,
why not do that?

thanks,

greg k-h
