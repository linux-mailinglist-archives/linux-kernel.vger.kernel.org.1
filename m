Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBCC2FF888
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 00:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbhAUXPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 18:15:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbhAUXPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 18:15:12 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BBEC06178A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 15:14:31 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id ox12so5075984ejb.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 15:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=30B5GvyEAtd1+3Z1C5zhQI/7AmKw65JFMaOZXB407e4=;
        b=ur6arfrhJqju67XcsyzqUPqGxazi10btYWnF8AfGgwmPypp2SXTtkhfNXenPCIQOtP
         6tOZMZiHkZofiJ/54VY/feW5Ob0zZanm4CAcIIboWi58/cPin6fCEsYTnlxVx5+LnVbM
         9it0uy+G06KMoKhM692k4lQxFV86AVRCMl+DgqHkUkAbw2GOPRcKuCexEpNG7D3WDfAQ
         kb5P1jpZoDvfZoJcPwYFxPaj0przTHPsu+9Nq252EY07dDSZLGIC2NcWaZH9L1KhD+o4
         qimx2jscGkLGQjEKHmxn3gLfu915g2JRkuDU4TXuVsq1mAK8zKuyOd5oGo/nuoAfvYte
         ycHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=30B5GvyEAtd1+3Z1C5zhQI/7AmKw65JFMaOZXB407e4=;
        b=T4jCNl0jaWlek0Nhe7horRbCTUN2kE6DvSLlKf6RHaSapkgjMSBcaVtoBDEm7htfZ8
         lmhW2aQL5ZD0WgmvPlS7NqPqr6PXxUBVYrGE4aLQldTewlVVvIgFpd+bJgPoOuZUC0Lc
         8wyTClGoc+AwuuttI9JkdLbygSVM2uy3XjCARxvOspXO/4+aaSxuhAKGwuizNqFRmJ4y
         JtrFhOOJ26TNGdWEI1ZIxXMFhzsxQnJXWL9ErQfRFqhXM8rYS7+SFETu70iNTtV1KdMG
         1KVownebzJc3p+7giBIeHYV5p5XVca4+tx5MBfrWETrb/iF2WYze2T3IsRVJVcv5CWIm
         rpqQ==
X-Gm-Message-State: AOAM532BKBM35Zz4S0QYMF7Q2Zr+rKAJ9czZbM2zPQx1KA08+Z6bst7I
        Oy+T9mH/5Rz2Lm4x5Cwyky/5et15vOkjac+WUbk9o9JQXGo=
X-Google-Smtp-Source: ABdhPJyqUyYoXGVd6qO1/k6K0pwdTQLstOkpQJDAtLesrQ2FaEDWIV3sF0wMYnMFm3sJnm1Wg++6gSuws3TnjVcwi7k=
X-Received: by 2002:a17:906:f919:: with SMTP id lc25mr1191169ejb.323.1611270870620;
 Thu, 21 Jan 2021 15:14:30 -0800 (PST)
MIME-Version: 1.0
References: <20210105025839.23169-1-mike.ximing.chen@intel.com>
 <20210105025839.23169-5-mike.ximing.chen@intel.com> <X/dmB3q6QEd2aQdG@kroah.com>
 <SA2PR11MB5018670AEC81EA93598E1212D9AD0@SA2PR11MB5018.namprd11.prod.outlook.com>
 <X/lqcaLVb+PbbmWg@kroah.com> <CAPcyv4huRyakszL7JPpk6CCK=rRvBfra5vzjxwr4_ThvyxSxLg@mail.gmail.com>
 <X/sYSfac3GQ8SsqO@kroah.com> <CAPcyv4hGxLZGEkfnqdLfF-a1CzfEjLux-TBxXztbknFhEe9mYA@mail.gmail.com>
 <X/7EG46Z20F8QFIX@kroah.com>
In-Reply-To: <X/7EG46Z20F8QFIX@kroah.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 21 Jan 2021 15:14:25 -0800
Message-ID: <CAPcyv4hytO3OnhpzKa2nKcqRhP-Gmei2LNhOTujx7Gn60wqrvQ@mail.gmail.com>
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

On Wed, Jan 13, 2021 at 1:56 AM Greg KH <gregkh@linuxfoundation.org> wrote:
[..]
> > That's not my concern though. The open race that cdev_del() does not
> > address is ioctl() called after device-unbind. The open fd is never
> > revoked and can live past device_unregister() in which case the ioctl
> > needs to revalidate the device, or (not recommended) block unbind /
> > driver-remove while open file descriptors are outstanding.
>
> A cdev is to track the character device, so the open/close/ioctl issue
> should not be relevant here.
>
> Device unbind is totally different and has nothing to do with the
> character device node, except where you are trying to tie the two
> together.  And yes, you do have to be aware of that, but usually is it
> quite simple.  Complex examples are the v4l layer where the distance
> between the two devices is great, so the middle layer has to handle
> things carefully.
>
> For a "simple" driver like this one, there shouldn't be any issues and
> it should be hard to get this wrong :)

It's trivial to trigger these problems in a bind/unbind test.

>
> > > > It strikes me that a helper like this might address many of the common patterns:
> > > >
> > > > +/**
> > > > + * get_live_device() - increment reference count for device iff !dead
> > > > + * @dev: device.
> > > > + *
> > > > + * Forward the call to get_device() if the device is still alive. If
> > > > + * this is called with the device_lock() held then the device is
> > > > + * guaranteed to not die until the device_lock() is dropped.
> > > > + */
> > > > +struct device *get_live_device(struct device *dev)
> > > > +{
> > > > +       return dev && !dev->p->dead ? get_device(dev) : NULL;
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(get_live_device);
> > >
> > > Ick, no, that's still racy :(
> >
> > Hence the comment about needing to synchronize with the driver doing
> > device_unregister().
>
> If you save off your device pointer properly on probe (i.e. you grab a
> reference count as you "know" it is live), then you don't have any of
> these races or need to synchronize.  So again, this should be hard to
> get wrong, unless you have a "heavy" middle layer between the char
> device node and the device structure.

Hold an fd open and continue to issue file_operations while the driver
is torn down.

> > > And a cdev is not a "real" struct device, despite looking like one if
> > > you squint at it.  The patches from Christoph should be merged soon that
> > > remove the last remants of the logic that kind of looked like a struct
> > > device operation (with a kobject), and after that, I will clean it out
> > > to keep it from looking like it ties into the driver model entirely, as
> > > many people get this wrong, because it does not.
> >
> > Agree, but many drivers still tie cdev lifetime to a struct device.
>
> True, and that's normally fine.  Do you have examples of where this is
> wrong in the tree?
>
> > > > Alternatively, if device_lock() is too awkward for a driver it could
> > > > use its own lock and kill_device().
> > > >
> > > > ...am I off base thinking that cdev_del vs fops liveness is a
> > > > widespread problem worth documenting new design patterns?
> > >
> > > It shouldn't be a problem, again, because who would be able to close a
> > > char device node and still be able to call ioctl on it?  The VFS layer
> > > should prevent that from happening, right?
> >
> > Per above, unbind vs and revoking new ioctl() invocations is the concern.
>
> Luckily unbind is a very rare occurance (with the exception of the
> virtio drivers, who seem to love it and use it as their only user/kernel
> api), so this shouldn't be an issue in normal operations of a system.

I agree it's a small window and an infrequently stressed window under
normal conditions. However, it's the same kind of problem that lead to
the need to teach /dev/mem to revoke existing mappings. It's the
synchronization that is needed in the device-dax layer when it is
switching modes from device-mmap-only to online-memory-hotplug the
synchronization with in-flight mmap is needed to avoid collisions. The
libnvdimm subsystem is a heavy user of bind/unbind for applying
different personalities in front of pmem.

I'll advise Mike to not worry about it, I don't want the resolution of
this debate to slow him down if you don't see an issue here.
