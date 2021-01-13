Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 713842F481C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 10:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbhAMJ5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 04:57:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:55550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726273AbhAMJ5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 04:57:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2228D2339D;
        Wed, 13 Jan 2021 09:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610531800;
        bh=/KkCTJPY/c8Vh4PTKslMvNrg7AuOgUOyxh2zz75yBKs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=udU6lri9ARoR0KEcksXJKXu4QVANYiG0EKgYRohrG/rTOWGpukl7LphEzeeXN5J8+
         N5r77ejVuGKK6qTUCeivRmMW2TnnI20MthXh8nE92xLH+7/diDDoBeCUVCi+Abb++J
         X+WW26qjl9IIf6+uSifqgaB9lKailFQ0WNjE+o98=
Date:   Wed, 13 Jan 2021 10:57:47 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Chen, Mike Ximing" <mike.ximing.chen@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v8 04/20] dlb: add device ioctl layer and first three
 ioctls
Message-ID: <X/7EG46Z20F8QFIX@kroah.com>
References: <20210105025839.23169-1-mike.ximing.chen@intel.com>
 <20210105025839.23169-5-mike.ximing.chen@intel.com>
 <X/dmB3q6QEd2aQdG@kroah.com>
 <SA2PR11MB5018670AEC81EA93598E1212D9AD0@SA2PR11MB5018.namprd11.prod.outlook.com>
 <X/lqcaLVb+PbbmWg@kroah.com>
 <CAPcyv4huRyakszL7JPpk6CCK=rRvBfra5vzjxwr4_ThvyxSxLg@mail.gmail.com>
 <X/sYSfac3GQ8SsqO@kroah.com>
 <CAPcyv4hGxLZGEkfnqdLfF-a1CzfEjLux-TBxXztbknFhEe9mYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hGxLZGEkfnqdLfF-a1CzfEjLux-TBxXztbknFhEe9mYA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 01:03:08PM -0800, Dan Williams wrote:
> On Sun, Jan 10, 2021 at 7:06 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Sat, Jan 09, 2021 at 01:49:42PM -0800, Dan Williams wrote:
> > > On Sat, Jan 9, 2021 at 12:34 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Sat, Jan 09, 2021 at 07:49:24AM +0000, Chen, Mike Ximing wrote:
> > > > > > > +static int dlb_ioctl_arg_size[NUM_DLB_CMD] = {
> > > > > > > + sizeof(struct dlb_get_device_version_args),
> > > > > > > + sizeof(struct dlb_create_sched_domain_args),
> > > > > > > + sizeof(struct dlb_get_num_resources_args)
> > > > > >
> > > > > > That list.
> > > > > >
> > > > > > Ugh, no.  that's no way to write maintainable code that you will be able
> > > > > > to understand in 2 years.
> > > > > >
> > > > >
> > > > > dlb_ioctl() was implemented with switch-case and real function calls previously.
> > > > > We changed to the table/list implementation during a code restructure. I will move
> > > > > back to the old implementation.
> > > >
> > > > Who said to change this?  And why did they say that?  Please go back to
> > > > those developers and point them at this thread so that doesn't happen
> > > > again...
> > > >
> > > > > > > +{
> > > > > > > + struct dlb *dlb;
> > > > > > > + dlb_ioctl_fn_t fn;
> > > > > > > + u32 cmd_nr;
> > > > > > > + void *karg;
> > > > > > > + int size;
> > > > > > > + int ret;
> > > > > > > +
> > > > > > > + dlb = f->private_data;
> > > > > > > +
> > > > > > > + if (!dlb) {
> > > > > > > +         pr_err("dlb: [%s()] Invalid DLB data\n", __func__);
> > > > > > > +         return -EFAULT;
> > > > > >
> > > > > > This error value is only allowed if you really do have a memory fault.
> > > > > >
> > > > > > Hint, you do not here.
> > > > > >
> > > > > > How can that value ever be NULL?
> > > > > >
> > > > >
> > > > > It is targeted at some very rare cases, in which an ioctl command are called immediately after a device unbind (by a different process/application).
> > > >
> > > > And how can that happen?  If it really can happen, where is the lock
> > > > that you are holding to keep that pointer from becoming "stale" right
> > > > after you assign it?
> > > >
> > > > So either this never can happen, or your logic here for this type of
> > > > thing is totally wrong.  Please work to determine which it is.
> > >
> > > I would have preferred a chance to offer a reviewed-by on this set
> > > before it went out (per the required process) to validate that the
> > > feedback on the lifetime handling was properly addressed, it wasn't,
> > > but lets deal with this on the list now.
> > >
> > > The race to handle is the one identified by cdev_del():
> > >
> > >  * NOTE: This guarantees that cdev device will no longer be able to be
> > >  * opened, however any cdevs already open will remain and their fops will
> > >  * still be callable even after cdev_del returns.
> > >
> > > This means that the dlb->private_data is pointing to a live device, a
> > > dying device, or NULL. Without revalidating to the dlb pointer under a
> > > lock, or some other coordinated reference cout, it can transition
> > > states underneath the running ioctl.
> >
> > But, that's only the case if this is the last cdev reference held here,
> > right?  How can a close be called if a filehandle is still open such
> > that an ioctl can be called?
> >
> > This should just be a "simple" char device operation, with no need to be
> > fancy or anything odd like that, right?  If not, then yes, this really
> > does need a real lock.
> >
> > > Greg, I'm thinking of taking a shot at a document, "botching up device
> > > lifetimes",  in the same spirit as
> > > Documentation/process/botching-up-ioctls.rst to lay out the different
> > > schemes for revalidating driver private data in ioctls.
> >
> > Sure, but again, it should be "simple" in that an ioctl can't be called
> > after close() happens.
> 
> Yes, for checking that file->private_data is not NULL it is sufficient
> to just assume that ioctl() can't be called after close().
> 
> That's not my concern though. The open race that cdev_del() does not
> address is ioctl() called after device-unbind. The open fd is never
> revoked and can live past device_unregister() in which case the ioctl
> needs to revalidate the device, or (not recommended) block unbind /
> driver-remove while open file descriptors are outstanding.

A cdev is to track the character device, so the open/close/ioctl issue
should not be relevant here.

Device unbind is totally different and has nothing to do with the
character device node, except where you are trying to tie the two
together.  And yes, you do have to be aware of that, but usually is it
quite simple.  Complex examples are the v4l layer where the distance
between the two devices is great, so the middle layer has to handle
things carefully.

For a "simple" driver like this one, there shouldn't be any issues and
it should be hard to get this wrong :)

> > > It strikes me that a helper like this might address many of the common patterns:
> > >
> > > +/**
> > > + * get_live_device() - increment reference count for device iff !dead
> > > + * @dev: device.
> > > + *
> > > + * Forward the call to get_device() if the device is still alive. If
> > > + * this is called with the device_lock() held then the device is
> > > + * guaranteed to not die until the device_lock() is dropped.
> > > + */
> > > +struct device *get_live_device(struct device *dev)
> > > +{
> > > +       return dev && !dev->p->dead ? get_device(dev) : NULL;
> > > +}
> > > +EXPORT_SYMBOL_GPL(get_live_device);
> >
> > Ick, no, that's still racy :(
> 
> Hence the comment about needing to synchronize with the driver doing
> device_unregister().

If you save off your device pointer properly on probe (i.e. you grab a
reference count as you "know" it is live), then you don't have any of
these races or need to synchronize.  So again, this should be hard to
get wrong, unless you have a "heavy" middle layer between the char
device node and the device structure.

> > And a cdev is not a "real" struct device, despite looking like one if
> > you squint at it.  The patches from Christoph should be merged soon that
> > remove the last remants of the logic that kind of looked like a struct
> > device operation (with a kobject), and after that, I will clean it out
> > to keep it from looking like it ties into the driver model entirely, as
> > many people get this wrong, because it does not.
> 
> Agree, but many drivers still tie cdev lifetime to a struct device.

True, and that's normally fine.  Do you have examples of where this is
wrong in the tree?

> > > Alternatively, if device_lock() is too awkward for a driver it could
> > > use its own lock and kill_device().
> > >
> > > ...am I off base thinking that cdev_del vs fops liveness is a
> > > widespread problem worth documenting new design patterns?
> >
> > It shouldn't be a problem, again, because who would be able to close a
> > char device node and still be able to call ioctl on it?  The VFS layer
> > should prevent that from happening, right?
> 
> Per above, unbind vs and revoking new ioctl() invocations is the concern.

Luckily unbind is a very rare occurance (with the exception of the
virtio drivers, who seem to love it and use it as their only user/kernel
api), so this shouldn't be an issue in normal operations of a system.

thanks,

greg k-h
