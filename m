Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD6AB276A35
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 09:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbgIXHM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 03:12:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:37322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727092AbgIXHMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 03:12:25 -0400
Received: from localhost (unknown [84.241.198.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 346752396D;
        Thu, 24 Sep 2020 07:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600931543;
        bh=xwKaXA7Vnb/YPzGz5vjKNgAroAi33wbsqBR+jm64g2A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TGmBCEHsFzQpzrBT8foOOmGQAD+FBGas7N8gkqyx9BQJnDy2BLjrNnt5J+PA6sgzs
         N2LpD7b/aR6TDm6X6/iaIbfKHDt4az2QcFoAwli6H9q0bhr1Ys4HTJB/3vnqOU2jle
         vXp0Cr1/IqVSgL+I5vPC3W3yivGYwepYWMep2ADA=
Date:   Thu, 24 Sep 2020 09:12:13 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        =?utf-8?B?Qmxhxb4=?= Hrastnik <blaz@mxxn.io>,
        Dorian Stoll <dorian.stoll@tmsp.io>
Subject: Re: [RFC PATCH 6/9] surface_aggregator: Add dedicated bus and device
 type
Message-ID: <20200924071213.GA597212@kroah.com>
References: <20200923151511.3842150-1-luzmaximilian@gmail.com>
 <20200923151511.3842150-7-luzmaximilian@gmail.com>
 <20200923173308.GA3965283@kroah.com>
 <bdb02c89-2290-f53f-65a1-fd2b42fc98a2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdb02c89-2290-f53f-65a1-fd2b42fc98a2@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 11:12:49PM +0200, Maximilian Luz wrote:
> On 9/23/20 7:33 PM, Greg Kroah-Hartman wrote:
> > On Wed, Sep 23, 2020 at 05:15:08PM +0200, Maximilian Luz wrote:
> [...]
> 
> > Overall, nice work on this patch, the integration to the driver core
> > looks totally correct.  Great job.
> 
> Thanks!
> 
> > A few minor nits below:
> > 
> > > --- /dev/null
> > > +++ b/drivers/misc/surface_aggregator/bus.c
> > > @@ -0,0 +1,419 @@
> > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > +
> > 
> > No copyright?
> 
> As with the other files, I forgot to add that.
> 
> [...]
> 
> > > +int ssam_device_add(struct ssam_device *sdev)
> > > +{
> > > +	int status;
> > > +
> > > +	/*
> > > +	 * Ensure that we can only add new devices to a controller if it has
> > > +	 * been started and is not going away soon. This works in combination
> > > +	 * with ssam_controller_remove_clients to ensure driver presence for the
> > > +	 * controller device, i.e. it ensures that the controller (sdev->ctrl)
> > > +	 * is always valid and can be used for requests as long as the client
> > > +	 * device we add here is registered as child under it. This essentially
> > > +	 * guarantees that the client driver can always expect the preconditions
> > > +	 * for functions like ssam_request_sync (controller has to be started
> > > +	 * and is not suspended) to hold and thus does not have to check for
> > > +	 * them.
> > > +	 *
> > > +	 * Note that for this to work, the controller has to be a parent device.
> > > +	 * If it is not a direct parent, care has to be taken that the device is
> > > +	 * removed via ssam_device_remove(), as device_unregister does not
> > > +	 * remove child devices recursively.
> > > +	 */
> > > +	ssam_controller_statelock(sdev->ctrl);
> > > +
> > > +	if (READ_ONCE(sdev->ctrl->state) != SSAM_CONTROLLER_STARTED) {
> > 
> > You locked the state, why the READ_ONCE()?  Is taht needed?
> 
> At this point, no. I have, at some point, decided that, since I do
> access the state outside of that lock at some point (specifically when
> submitting the request in ssam_request_sync_submit() to detect mis-use
> of the AP), that I'm going to mark them all as READ_ONCE. Mostly
> because, due to that one check, I have to set the state via WRITE_ONCE.
> Note that that check accessing it outside of the lock is a very basic
> validity check and actually doesn't guarantee _anything_. Again, it's
> just there to try and spot bad API usage. Every actually valid access to
> the state should be locked, so the rest doesn't need the READ_ONCE. I
> can remove those if you want me to.

I would remove the ones you don't really need, but as you are doing this
also to show intent, that should be fine.

> > > +		ssam_controller_stateunlock(sdev->ctrl);
> > > +		return -ENXIO;
> > 
> > odd error value, why this one?
> 
> I generally use -ENXIO to indicate that the controller device is not
> present, has not been initialized yet, or is being/has been shut down.
> The error here will be caused by the controller going away (or having
> been suspended) after the device has been created and befor the device
> is added. I guess in case of shutdown, -ESHUTDOWN may be better, but
> then I'm not sure what to return when the controller is suspended.

Do you really need different error values?

Anyway, it's fine, that just seemed like an odd error for that case, but
any error is ok.


> > > +/**
> > > + * struct ssam_device_uid - Unique identifier for SSAM device.
> > > + * @domain:   Domain of the device.
> > > + * @category: Target category of the device.
> > > + * @target:   Target ID of the device.
> > > + * @instance: Instance ID of the device.
> > > + * @function: Sub-function of the device. This field can be used to split a
> > > + *            single SAM device into multiple virtual subdevices to separate
> > > + *            different functionality of that device and allow one driver per
> > > + *            such functionality.
> > > + */
> > > +struct ssam_device_uid {
> > > +	u8 domain;
> > > +	u8 category;
> > > +	u8 target;
> > > +	u8 instance;
> > > +	u8 function;
> > > +};
> > > +
> > > +/*
> > > + * Special values for device matching.
> > > + */
> > > +#define SSAM_ANY_TID		0xffff
> > > +#define SSAM_ANY_IID		0xffff
> > > +#define SSAM_ANY_FUN		0xffff
> > 
> > These are 16 bits, but the uid values above are 8 bits.  How does that
> > match up?
> 
> Those values are only intended for use with the SSAM_DEVICE() macro,
> where they are used to set the match flags. They're u16 so that they
> don't interfere with any potentially valid ID value (0x00 to 0xff). The
> lowest byte is specifically 0xff to make it easier to spot potential
> mis-use in the struct above, as that's an ID that, as far as I know,
> doesn't have any valid use (at least yet). They should never be used
> directly with the struct above, something I should probably clarify in
> the documentation.

Yes, documenting it would make more sense, the 8 vs. 16 threw me off
here.

thanks,

greg k-h
