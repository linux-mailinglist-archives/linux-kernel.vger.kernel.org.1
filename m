Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6AB2F03E3
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 22:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbhAIVuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 16:50:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbhAIVue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 16:50:34 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E0AC06179F
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jan 2021 13:49:54 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id j16so14930994edr.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jan 2021 13:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mdW7lcpi4bRxwXU3KgxbmWayFCxbAMXV2BJDMr28t4E=;
        b=vy5LHTUaY8UnAkNKJZKew2GItKTWBB/lbjETLHqVjJ+PKAnyPVJqcurMHNHHN91Bw8
         AHreos8Jw805wlux4iwOkRz8blrkbZ7qAU/muBsf4agmfmY0HVuvzqGFWYQAJNRZmMog
         NRWTIoWD7lVjm1uGQ1zgQHlpAQoGFuzbiJiiftpp8PUbH8Amjmmb1oJTZ6LvsVmJFDMX
         4ocISplhA/UL2MHbfQJ0Fb0O1q50zXF4TZzKQGjsdUvQfWmWFy4NIBe3XteoHOs3kREh
         1GSZQXJdRpWcPJqU+tdFnZI4/nt3k2E1OF2RT4pHMjZueWr/Ndu0XIZpyVt22mZRiQEe
         ECMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mdW7lcpi4bRxwXU3KgxbmWayFCxbAMXV2BJDMr28t4E=;
        b=Tylx7SU9gCVxLa3LL0I57WFzm0CJ4p2vIn1Nlw/59rNu6C/kPf2DxZ0pc/G950/aSF
         f4+wHQ+LwYZRDJj9GxsJgh024N6aXwVTSZ2Xjm3nAgUidCUWT5dF+X5piCFAGg81z8Ug
         K3dLILA1cSCOfLMeodMQ6AKGmg8+XfaBGoTZJFvEcoao8gX+kWUOEbyI9BPC+nOKIvvs
         EJEI4CloH3JIeoUs+2llhKPlkbbIK6ONcoM4QPIgROw52fOQAJ6aWCtj3m8MwdCKZlzR
         pTrQmj0aAm0iHrCWy4jlmq30D2uWO3AGUgENO52KOkhkTNReRwrDDvUP/XsNfpRpOPgB
         YZaw==
X-Gm-Message-State: AOAM531Kn0HcX52xzn+Vlba4yVWguBGcVweH5NA0+W+fxrsT4q981JN/
        rAL2OWIgY9LdqvFR/VP8AItWjzoRLYX7XPZeOb5A2w==
X-Google-Smtp-Source: ABdhPJxKfbCDHTWpI3BGP1KSuxZgSqIiP9CYlS/MoGPuiSvmg7WZf0mauE1jTMM+2cvhHZ0cZjjWkyHY6EQL4aEmS0A=
X-Received: by 2002:aa7:df0f:: with SMTP id c15mr9722278edy.354.1610228993223;
 Sat, 09 Jan 2021 13:49:53 -0800 (PST)
MIME-Version: 1.0
References: <20210105025839.23169-1-mike.ximing.chen@intel.com>
 <20210105025839.23169-5-mike.ximing.chen@intel.com> <X/dmB3q6QEd2aQdG@kroah.com>
 <SA2PR11MB5018670AEC81EA93598E1212D9AD0@SA2PR11MB5018.namprd11.prod.outlook.com>
 <X/lqcaLVb+PbbmWg@kroah.com>
In-Reply-To: <X/lqcaLVb+PbbmWg@kroah.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 9 Jan 2021 13:49:42 -0800
Message-ID: <CAPcyv4huRyakszL7JPpk6CCK=rRvBfra5vzjxwr4_ThvyxSxLg@mail.gmail.com>
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

On Sat, Jan 9, 2021 at 12:34 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sat, Jan 09, 2021 at 07:49:24AM +0000, Chen, Mike Ximing wrote:
> > > > +static int dlb_ioctl_arg_size[NUM_DLB_CMD] = {
> > > > + sizeof(struct dlb_get_device_version_args),
> > > > + sizeof(struct dlb_create_sched_domain_args),
> > > > + sizeof(struct dlb_get_num_resources_args)
> > >
> > > That list.
> > >
> > > Ugh, no.  that's no way to write maintainable code that you will be able
> > > to understand in 2 years.
> > >
> >
> > dlb_ioctl() was implemented with switch-case and real function calls previously.
> > We changed to the table/list implementation during a code restructure. I will move
> > back to the old implementation.
>
> Who said to change this?  And why did they say that?  Please go back to
> those developers and point them at this thread so that doesn't happen
> again...
>
> > > > +{
> > > > + struct dlb *dlb;
> > > > + dlb_ioctl_fn_t fn;
> > > > + u32 cmd_nr;
> > > > + void *karg;
> > > > + int size;
> > > > + int ret;
> > > > +
> > > > + dlb = f->private_data;
> > > > +
> > > > + if (!dlb) {
> > > > +         pr_err("dlb: [%s()] Invalid DLB data\n", __func__);
> > > > +         return -EFAULT;
> > >
> > > This error value is only allowed if you really do have a memory fault.
> > >
> > > Hint, you do not here.
> > >
> > > How can that value ever be NULL?
> > >
> >
> > It is targeted at some very rare cases, in which an ioctl command are called immediately after a device unbind (by a different process/application).
>
> And how can that happen?  If it really can happen, where is the lock
> that you are holding to keep that pointer from becoming "stale" right
> after you assign it?
>
> So either this never can happen, or your logic here for this type of
> thing is totally wrong.  Please work to determine which it is.

I would have preferred a chance to offer a reviewed-by on this set
before it went out (per the required process) to validate that the
feedback on the lifetime handling was properly addressed, it wasn't,
but lets deal with this on the list now.

The race to handle is the one identified by cdev_del():

 * NOTE: This guarantees that cdev device will no longer be able to be
 * opened, however any cdevs already open will remain and their fops will
 * still be callable even after cdev_del returns.

This means that the dlb->private_data is pointing to a live device, a
dying device, or NULL. Without revalidating to the dlb pointer under a
lock, or some other coordinated reference cout, it can transition
states underneath the running ioctl.

Greg, I'm thinking of taking a shot at a document, "botching up device
lifetimes",  in the same spirit as
Documentation/process/botching-up-ioctls.rst to lay out the different
schemes for revalidating driver private data in ioctls.

It strikes me that a helper like this might address many of the common patterns:

+/**
+ * get_live_device() - increment reference count for device iff !dead
+ * @dev: device.
+ *
+ * Forward the call to get_device() if the device is still alive. If
+ * this is called with the device_lock() held then the device is
+ * guaranteed to not die until the device_lock() is dropped.
+ */
+struct device *get_live_device(struct device *dev)
+{
+       return dev && !dev->p->dead ? get_device(dev) : NULL;
+}
+EXPORT_SYMBOL_GPL(get_live_device);

Alternatively, if device_lock() is too awkward for a driver it could
use its own lock and kill_device().

...am I off base thinking that cdev_del vs fops liveness is a
widespread problem worth documenting new design patterns?
