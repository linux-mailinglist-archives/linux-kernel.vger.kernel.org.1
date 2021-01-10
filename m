Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD502F07C4
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 16:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbhAJPHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 10:07:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:37816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbhAJPHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 10:07:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AA7F422AAC;
        Sun, 10 Jan 2021 15:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610291200;
        bh=hoTUt9ZrYm4NmySakqiOe2XqEm9HCeHdW7Jl1ytRo7o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AEqDCZKkbxmNDFt4m75czOUC5FmFi1k74H8uyCy4ZGmGectbJkR5gMksbB/pn+6lh
         BYwWOuhWIiRIJg6U3jeo3U1ZI3Bfw1nUEuJdW0X+nj8TJlpZ3iFq4lT1hmGz8YbEXT
         48oXFa5fUP3hNFsm5895woNHisXV8FicstVlJ7rU=
Date:   Sun, 10 Jan 2021 16:07:53 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Chen, Mike Ximing" <mike.ximing.chen@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v8 04/20] dlb: add device ioctl layer and first three
 ioctls
Message-ID: <X/sYSfac3GQ8SsqO@kroah.com>
References: <20210105025839.23169-1-mike.ximing.chen@intel.com>
 <20210105025839.23169-5-mike.ximing.chen@intel.com>
 <X/dmB3q6QEd2aQdG@kroah.com>
 <SA2PR11MB5018670AEC81EA93598E1212D9AD0@SA2PR11MB5018.namprd11.prod.outlook.com>
 <X/lqcaLVb+PbbmWg@kroah.com>
 <CAPcyv4huRyakszL7JPpk6CCK=rRvBfra5vzjxwr4_ThvyxSxLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4huRyakszL7JPpk6CCK=rRvBfra5vzjxwr4_ThvyxSxLg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 09, 2021 at 01:49:42PM -0800, Dan Williams wrote:
> On Sat, Jan 9, 2021 at 12:34 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Sat, Jan 09, 2021 at 07:49:24AM +0000, Chen, Mike Ximing wrote:
> > > > > +static int dlb_ioctl_arg_size[NUM_DLB_CMD] = {
> > > > > + sizeof(struct dlb_get_device_version_args),
> > > > > + sizeof(struct dlb_create_sched_domain_args),
> > > > > + sizeof(struct dlb_get_num_resources_args)
> > > >
> > > > That list.
> > > >
> > > > Ugh, no.  that's no way to write maintainable code that you will be able
> > > > to understand in 2 years.
> > > >
> > >
> > > dlb_ioctl() was implemented with switch-case and real function calls previously.
> > > We changed to the table/list implementation during a code restructure. I will move
> > > back to the old implementation.
> >
> > Who said to change this?  And why did they say that?  Please go back to
> > those developers and point them at this thread so that doesn't happen
> > again...
> >
> > > > > +{
> > > > > + struct dlb *dlb;
> > > > > + dlb_ioctl_fn_t fn;
> > > > > + u32 cmd_nr;
> > > > > + void *karg;
> > > > > + int size;
> > > > > + int ret;
> > > > > +
> > > > > + dlb = f->private_data;
> > > > > +
> > > > > + if (!dlb) {
> > > > > +         pr_err("dlb: [%s()] Invalid DLB data\n", __func__);
> > > > > +         return -EFAULT;
> > > >
> > > > This error value is only allowed if you really do have a memory fault.
> > > >
> > > > Hint, you do not here.
> > > >
> > > > How can that value ever be NULL?
> > > >
> > >
> > > It is targeted at some very rare cases, in which an ioctl command are called immediately after a device unbind (by a different process/application).
> >
> > And how can that happen?  If it really can happen, where is the lock
> > that you are holding to keep that pointer from becoming "stale" right
> > after you assign it?
> >
> > So either this never can happen, or your logic here for this type of
> > thing is totally wrong.  Please work to determine which it is.
> 
> I would have preferred a chance to offer a reviewed-by on this set
> before it went out (per the required process) to validate that the
> feedback on the lifetime handling was properly addressed, it wasn't,
> but lets deal with this on the list now.
> 
> The race to handle is the one identified by cdev_del():
> 
>  * NOTE: This guarantees that cdev device will no longer be able to be
>  * opened, however any cdevs already open will remain and their fops will
>  * still be callable even after cdev_del returns.
> 
> This means that the dlb->private_data is pointing to a live device, a
> dying device, or NULL. Without revalidating to the dlb pointer under a
> lock, or some other coordinated reference cout, it can transition
> states underneath the running ioctl.

But, that's only the case if this is the last cdev reference held here,
right?  How can a close be called if a filehandle is still open such
that an ioctl can be called?

This should just be a "simple" char device operation, with no need to be
fancy or anything odd like that, right?  If not, then yes, this really
does need a real lock.

> Greg, I'm thinking of taking a shot at a document, "botching up device
> lifetimes",  in the same spirit as
> Documentation/process/botching-up-ioctls.rst to lay out the different
> schemes for revalidating driver private data in ioctls.

Sure, but again, it should be "simple" in that an ioctl can't be called
after close() happens.

> It strikes me that a helper like this might address many of the common patterns:
> 
> +/**
> + * get_live_device() - increment reference count for device iff !dead
> + * @dev: device.
> + *
> + * Forward the call to get_device() if the device is still alive. If
> + * this is called with the device_lock() held then the device is
> + * guaranteed to not die until the device_lock() is dropped.
> + */
> +struct device *get_live_device(struct device *dev)
> +{
> +       return dev && !dev->p->dead ? get_device(dev) : NULL;
> +}
> +EXPORT_SYMBOL_GPL(get_live_device);

Ick, no, that's still racy :(

And a cdev is not a "real" struct device, despite looking like one if
you squint at it.  The patches from Christoph should be merged soon that
remove the last remants of the logic that kind of looked like a struct
device operation (with a kobject), and after that, I will clean it out
to keep it from looking like it ties into the driver model entirely, as
many people get this wrong, because it does not.

> Alternatively, if device_lock() is too awkward for a driver it could
> use its own lock and kill_device().
> 
> ...am I off base thinking that cdev_del vs fops liveness is a
> widespread problem worth documenting new design patterns?

It shouldn't be a problem, again, because who would be able to close a
char device node and still be able to call ioctl on it?  The VFS layer
should prevent that from happening, right?

thanks,

greg k-h
