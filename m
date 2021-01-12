Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECF002F3D3C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437936AbhALVek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 16:34:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437102AbhALVD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 16:03:59 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE66C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 13:03:18 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id n26so5471358eju.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 13:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kyAioNlSGIIQ/AuniPPjAZdMMonEgt2e1RkZpeN7K0Q=;
        b=vsSoK4EPPEUJsEHLa0klNab/AezU5uoXqIRa6ftiQL9kQP7yE/kf/UnHQoWo+bo5eP
         ozXmxk8oEORyGfni6pAXxfh4I6ti5460MPOaP9YLqlrdsBKPdaWTsJWbt3GWBTgUcRfQ
         41iAv04DRBMsgvzD78+FbNXil8JyBfdVyTe1yqoBaQkjY74u8668MsO6W7gvQ4K3F6PS
         bIpCtPO4+BHtFq629x4myWyDhAzKhNC/QI8O2O+RiEgF82q9nlo6uN+Y3CWDdHm+UivK
         nJRhWa8SJftiX1fAvhzshHsHNN9AHYs5QaUoiYxj1yt2isr18Bsf1sO9QfRD/1zzO880
         esoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kyAioNlSGIIQ/AuniPPjAZdMMonEgt2e1RkZpeN7K0Q=;
        b=mRVuzrItFILFL3VgPQklzjQRmXTy7nxFNj4wjqNw5StpFdfKGF/+kJANkL3J4oRqyr
         VbuHosuJUdTbcJSoHGS3lIKE5iIbFVWhOVkM6rDHLwGKNKDblhfy9sxxFpRpygGQ7cjU
         MJyoHkHR3JZSVJZIFxReHj31f69lYl99a2PeiPdUezREqczzAZU6r+8T79YFzmgPeT6n
         k+Q6UY3d1ozcbKqtemtDCl6R97okFlTLPlT877UATg3/2AcbDAjXi8F6w3s+lqWcmhvp
         +44qNebDRAKqpDLNolazsVNuuka/P51uc42VR8c1ohHMkf/OZXzRyihvWS+adO6LaPk1
         zijQ==
X-Gm-Message-State: AOAM533SsClm5OXVuV43FXzs3eVSeJ3Xe3muUlBWuC54wuEVc8JBSHtP
        I9iizV28PM8xFB4z7iNGYEMllRzYG8LTW8XahDNh9R9b/1Q=
X-Google-Smtp-Source: ABdhPJysOp2r1aXZ6NXz92WcvEqKv8UrKUlkTqkXhIQn6hlsuAVBl6EL8lN+I253yLVldhsp8zAey2b6RREIDIh1+NI=
X-Received: by 2002:a17:906:4146:: with SMTP id l6mr466623ejk.341.1610485397262;
 Tue, 12 Jan 2021 13:03:17 -0800 (PST)
MIME-Version: 1.0
References: <20210105025839.23169-1-mike.ximing.chen@intel.com>
 <20210105025839.23169-5-mike.ximing.chen@intel.com> <X/dmB3q6QEd2aQdG@kroah.com>
 <SA2PR11MB5018670AEC81EA93598E1212D9AD0@SA2PR11MB5018.namprd11.prod.outlook.com>
 <X/lqcaLVb+PbbmWg@kroah.com> <CAPcyv4huRyakszL7JPpk6CCK=rRvBfra5vzjxwr4_ThvyxSxLg@mail.gmail.com>
 <X/sYSfac3GQ8SsqO@kroah.com>
In-Reply-To: <X/sYSfac3GQ8SsqO@kroah.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 12 Jan 2021 13:03:08 -0800
Message-ID: <CAPcyv4hGxLZGEkfnqdLfF-a1CzfEjLux-TBxXztbknFhEe9mYA@mail.gmail.com>
Subject: Re: [PATCH v8 04/20] dlb: add device ioctl layer and first three ioctls
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Chen, Mike Ximing" <mike.ximing.chen@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 10, 2021 at 7:06 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sat, Jan 09, 2021 at 01:49:42PM -0800, Dan Williams wrote:
> > On Sat, Jan 9, 2021 at 12:34 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Sat, Jan 09, 2021 at 07:49:24AM +0000, Chen, Mike Ximing wrote:
> > > > > > +static int dlb_ioctl_arg_size[NUM_DLB_CMD] = {
> > > > > > + sizeof(struct dlb_get_device_version_args),
> > > > > > + sizeof(struct dlb_create_sched_domain_args),
> > > > > > + sizeof(struct dlb_get_num_resources_args)
> > > > >
> > > > > That list.
> > > > >
> > > > > Ugh, no.  that's no way to write maintainable code that you will be able
> > > > > to understand in 2 years.
> > > > >
> > > >
> > > > dlb_ioctl() was implemented with switch-case and real function calls previously.
> > > > We changed to the table/list implementation during a code restructure. I will move
> > > > back to the old implementation.
> > >
> > > Who said to change this?  And why did they say that?  Please go back to
> > > those developers and point them at this thread so that doesn't happen
> > > again...
> > >
> > > > > > +{
> > > > > > + struct dlb *dlb;
> > > > > > + dlb_ioctl_fn_t fn;
> > > > > > + u32 cmd_nr;
> > > > > > + void *karg;
> > > > > > + int size;
> > > > > > + int ret;
> > > > > > +
> > > > > > + dlb = f->private_data;
> > > > > > +
> > > > > > + if (!dlb) {
> > > > > > +         pr_err("dlb: [%s()] Invalid DLB data\n", __func__);
> > > > > > +         return -EFAULT;
> > > > >
> > > > > This error value is only allowed if you really do have a memory fault.
> > > > >
> > > > > Hint, you do not here.
> > > > >
> > > > > How can that value ever be NULL?
> > > > >
> > > >
> > > > It is targeted at some very rare cases, in which an ioctl command are called immediately after a device unbind (by a different process/application).
> > >
> > > And how can that happen?  If it really can happen, where is the lock
> > > that you are holding to keep that pointer from becoming "stale" right
> > > after you assign it?
> > >
> > > So either this never can happen, or your logic here for this type of
> > > thing is totally wrong.  Please work to determine which it is.
> >
> > I would have preferred a chance to offer a reviewed-by on this set
> > before it went out (per the required process) to validate that the
> > feedback on the lifetime handling was properly addressed, it wasn't,
> > but lets deal with this on the list now.
> >
> > The race to handle is the one identified by cdev_del():
> >
> >  * NOTE: This guarantees that cdev device will no longer be able to be
> >  * opened, however any cdevs already open will remain and their fops will
> >  * still be callable even after cdev_del returns.
> >
> > This means that the dlb->private_data is pointing to a live device, a
> > dying device, or NULL. Without revalidating to the dlb pointer under a
> > lock, or some other coordinated reference cout, it can transition
> > states underneath the running ioctl.
>
> But, that's only the case if this is the last cdev reference held here,
> right?  How can a close be called if a filehandle is still open such
> that an ioctl can be called?
>
> This should just be a "simple" char device operation, with no need to be
> fancy or anything odd like that, right?  If not, then yes, this really
> does need a real lock.
>
> > Greg, I'm thinking of taking a shot at a document, "botching up device
> > lifetimes",  in the same spirit as
> > Documentation/process/botching-up-ioctls.rst to lay out the different
> > schemes for revalidating driver private data in ioctls.
>
> Sure, but again, it should be "simple" in that an ioctl can't be called
> after close() happens.

Yes, for checking that file->private_data is not NULL it is sufficient
to just assume that ioctl() can't be called after close().

That's not my concern though. The open race that cdev_del() does not
address is ioctl() called after device-unbind. The open fd is never
revoked and can live past device_unregister() in which case the ioctl
needs to revalidate the device, or (not recommended) block unbind /
driver-remove while open file descriptors are outstanding.

>
> > It strikes me that a helper like this might address many of the common patterns:
> >
> > +/**
> > + * get_live_device() - increment reference count for device iff !dead
> > + * @dev: device.
> > + *
> > + * Forward the call to get_device() if the device is still alive. If
> > + * this is called with the device_lock() held then the device is
> > + * guaranteed to not die until the device_lock() is dropped.
> > + */
> > +struct device *get_live_device(struct device *dev)
> > +{
> > +       return dev && !dev->p->dead ? get_device(dev) : NULL;
> > +}
> > +EXPORT_SYMBOL_GPL(get_live_device);
>
> Ick, no, that's still racy :(

Hence the comment about needing to synchronize with the driver doing
device_unregister().

>
> And a cdev is not a "real" struct device, despite looking like one if
> you squint at it.  The patches from Christoph should be merged soon that
> remove the last remants of the logic that kind of looked like a struct
> device operation (with a kobject), and after that, I will clean it out
> to keep it from looking like it ties into the driver model entirely, as
> many people get this wrong, because it does not.

Agree, but many drivers still tie cdev lifetime to a struct device.

>
> > Alternatively, if device_lock() is too awkward for a driver it could
> > use its own lock and kill_device().
> >
> > ...am I off base thinking that cdev_del vs fops liveness is a
> > widespread problem worth documenting new design patterns?
>
> It shouldn't be a problem, again, because who would be able to close a
> char device node and still be able to call ioctl on it?  The VFS layer
> should prevent that from happening, right?

Per above, unbind vs and revoking new ioctl() invocations is the concern.
