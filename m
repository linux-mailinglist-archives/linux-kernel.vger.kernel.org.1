Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 299962ED08E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 14:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbhAGNVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 08:21:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:58096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728128AbhAGNVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 08:21:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 90B5C2065E;
        Thu,  7 Jan 2021 13:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610025634;
        bh=VJr6FZamdmy1K/mFU31CgN1qGuUyEOLL56Ue/i5GmcU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ThohcnooT8qscZgi1lsumJwGuncTLxh3yt7kyMmUahNJar9yl1Aem9tr1eWhxQ7gj
         kfbeJ90aIU/LwxRYSZehp9xNtkMYIBdhEiAs+cUr57ZJiOrYx0jG5k5NJh2GMaSfMW
         4brjGI0NtCCh1kqqW88m+LyOS0M2Vy+pdoUiPpdA=
Date:   Thu, 7 Jan 2021 14:21:54 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     "open list:USB NETWORKING DRIVERS" <linux-usb@vger.kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Benson Leung <bleung@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: typec: Send uevent for num_altmodes update
Message-ID: <X/cK8myUzKotH86j@kroah.com>
References: <20210107034904.4112029-1-pmalani@chromium.org>
 <X/bRstJuBYaLz4PK@kroah.com>
 <CACeCKaediXs81OUTogTWrqoZViP5rLqodO6nngeY2PLnWw=t+w@mail.gmail.com>
 <X/bpBFLIM91eZAEO@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X/bpBFLIM91eZAEO@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 07, 2021 at 11:57:08AM +0100, Greg KH wrote:
> On Thu, Jan 07, 2021 at 01:50:53AM -0800, Prashant Malani wrote:
> > Hi Greg,
> > 
> > Thanks for taking a look at the patch.
> > 
> > On Thu, Jan 7, 2021 at 1:16 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Wed, Jan 06, 2021 at 07:49:04PM -0800, Prashant Malani wrote:
> > > > Generate a change uevent when the "number_of_alternate_modes" sysfs file
> > > > for partners and plugs is updated by a port driver.
> > > >
> > > > Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > > Cc: Benson Leung <bleung@chromium.org>
> > > > Signed-off-by: Prashant Malani <pmalani@chromium.org>
> > > > ---
> > > >  drivers/usb/typec/class.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> > > > index ebfd3113a9a8..8f77669f9cf4 100644
> > > > --- a/drivers/usb/typec/class.c
> > > > +++ b/drivers/usb/typec/class.c
> > > > @@ -766,6 +766,7 @@ int typec_partner_set_num_altmodes(struct typec_partner *partner, int num_altmod
> > > >               return ret;
> > > >
> > > >       sysfs_notify(&partner->dev.kobj, NULL, "number_of_alternate_modes");
> > > > +     kobject_uevent(&partner->dev.kobj, KOBJ_CHANGE);
> > >
> > > Shouldn't the sysfs_notify() handle the "something has changed" logic
> > > good enough for userspace, as obviously someone is polling on the thing
> > > (otherwise we wouldn't be calling sysfs_notify...)
> > >
> > > The kobject itself hasn't "changed", but rather an individual attribute
> > > has changed.  We don't want to create uevents for every individual sysfs
> > > attribute changing values, do we?
> > 
> > Fair point. I noticed other attributes in this source file use a
> > similar approach (sysfs_notify + kobject_uevent)
> > and took guidance from there in an attempt to remain consistent
> > (though, of course, your point still stands).
> > 
> > I'm guessing it is for processes that rely on udev events
> > (subsystem=typec) rather than polling.
> > 
> > >
> > > What is preventing a normal "monitor the sysfs file" logic from working
> > > here for anyone who wants to know that the alternate modes have changed?
> > 
> > One limitation I can think of is that this sysfs file is hidden till
> > it has a valid value (i.e >= 0), so a user-space process might not
> > be able to poll on the file till it is visible (I suppose even then
> > one could poll on the parent).
> 
> If the file is being added at this point in time, then yes, it is ok to
> send a KOBJ_CHANGE event as that is needed.  Is that what is happening
> here?

In looking at the code more, yes, you are right, I'll go queue this up
now, thanks.

greg k-h
