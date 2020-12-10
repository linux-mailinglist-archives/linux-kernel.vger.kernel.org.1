Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4EAF2D59B1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 12:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbgLJLvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 06:51:08 -0500
Received: from mga01.intel.com ([192.55.52.88]:18779 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726278AbgLJLuy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 06:50:54 -0500
IronPort-SDR: cykVUgLnAr6+7Xq42wjXKGCyZwOxUoHazc0Iaet9gHgKE0nakq0j8vunoJ9qCIOTOx580a8h1z
 k6Nw+Q4XioDw==
X-IronPort-AV: E=McAfee;i="6000,8403,9830"; a="192553521"
X-IronPort-AV: E=Sophos;i="5.78,408,1599548400"; 
   d="scan'208";a="192553521"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2020 03:49:07 -0800
IronPort-SDR: jPCypRzsKXfV4SMRunI0pDp1JBR6gRn1RHnk7o3em3whYWAGccmzGUY52PuzTca0zN625w+BHY
 IYF9Kqb+G0CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,408,1599548400"; 
   d="scan'208";a="438306067"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 10 Dec 2020 03:49:03 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 10 Dec 2020 13:49:03 +0200
Date:   Thu, 10 Dec 2020 13:49:03 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     "open list:USB NETWORKING DRIVERS" <linux-usb@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benson Leung <bleung@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: typec: Add bus type for plug alt modes
Message-ID: <20201210114903.GA1594451@kuha.fi.intel.com>
References: <20201203030846.51669-1-pmalani@chromium.org>
 <20201208093734.GD680328@kuha.fi.intel.com>
 <CACeCKaehg=HTuQNLtQaJZWvTnOFYM9b1BWfM+WX_ebiZ-_i8JQ@mail.gmail.com>
 <20201209161356.GI680328@kuha.fi.intel.com>
 <CACeCKacdcGi_6VW7F9agN+bgRH7gAXLDxK7DngE=fPkYT-CWNQ@mail.gmail.com>
 <20201209171524.GK680328@kuha.fi.intel.com>
 <CACeCKafc6A-O09LrTsYgBTbmwVV0y-tEevj_Ci188WmT=hkjxg@mail.gmail.com>
 <CACeCKafbAOQdthkafd-QQizQ=1vy4e+4KeGHfLs7JnmgSrVv6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACeCKafbAOQdthkafd-QQizQ=1vy4e+4KeGHfLs7JnmgSrVv6Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09, 2020 at 03:47:17PM -0800, Prashant Malani wrote:
> On Wed, Dec 9, 2020 at 2:59 PM Prashant Malani <pmalani@chromium.org> wrote:
> >
> > Hi Heikki,
> >
> > On Wed, Dec 9, 2020 at 9:15 AM Heikki Krogerus
> > <heikki.krogerus@linux.intel.com> wrote:
> > >
> > > Hi Prashant,
> > >
> > > On Wed, Dec 09, 2020 at 08:22:52AM -0800, Prashant Malani wrote:
> > > > Hi Heikki,
> > > >
> > > > On Wed, Dec 9, 2020 at 8:14 AM Heikki Krogerus
> > > > <heikki.krogerus@linux.intel.com> wrote:
> > > > >
> > > > > On Tue, Dec 08, 2020 at 03:45:19PM -0800, Prashant Malani wrote:
> > > > > > Hi Heikki,
> > > > > >
> > > > > > Thanks a lot for looking at the patch.
> > > > > >
> > > > > > On Tue, Dec 8, 2020 at 1:37 AM Heikki Krogerus <heikki.krogerus@linux.intel.com> wrote:
> > > > > > >
> > > > > > > On Wed, Dec 02, 2020 at 07:08:47PM -0800, Prashant Malani wrote:
> > > > > > > > Add the Type C bus for plug alternate modes which are being
> > > > > > > > registered via the Type C connector class. This ensures that udev events
> > > > > > > > get generated when plug alternate modes are registered (and not just for
> > > > > > > > partner/port alternate modes), even though the Type C bus doesn't link
> > > > > > > > plug alternate mode devices to alternate mode drivers.
> > > > > > >
> > > > > > > I still don't understand how is the uevent related to the bus? If you
> > > > > > > check the device_add() function, on line 2917, kobject_uevent() is
> > > > > > > called unconditionally. The device does not need a bus for that event
> > > > > > > to be generated.
> > > > > >
> > > > > > My initial thought process was to see what is the difference in the adev device
> > > > > > initialization between partner altmode and plug altmode (the only difference I saw in
> > > > > > typec_register_altmode() was regarding the bus field).
> > > > > >
> > > > > > Yes, kobject_uevent() is called unconditionally, but it's return value isn't checked,
> > > > > > so we don't know if it succeeded or not.
> > > > > >
> > > > > > In the case of cable plug altmode, I see it fail with the following error[1]:
> > > > > >
> > > > > > [  114.431409] kobject: 'port1-plug0.0' (000000004ad42956): kobject_uevent_env: filter function caused the event to drop!
> > > > > >
> > > > > > I think the filter function which is called is this one: drivers/base/core.c: dev_uevent_filter() [2]
> > > > > >
> > > > > > static int dev_uevent_filter(struct kset *kset, struct kobject *kobj)
> > > > > > {
> > > > > >       struct kobj_type *ktype = get_ktype(kobj);
> > > > > >
> > > > > >       if (ktype == &device_ktype) {
> > > > > >               struct device *dev = kobj_to_dev(kobj);
> > > > > >               if (dev->bus)
> > > > > >                       return 1;
> > > > > >               if (dev->class)
> > > > > >                       return 1;
> > > > > >       }
> > > > > >       return 0;
> > > > > > }
> > > > > >
> > > > > > So, both the "if (dev->bus)" and "if (dev->class)" checks are failing here. In the case of partner alt modes, bus is set by the class.c code
> > > > > > so this check likely returns 1 in that case.
> > > > >
> > > > > OK. I understand the issue now. So I would say that the proper
> > > > > solution to this problem is to link the alt modes with the class
> > > > > instead of the bus. That is much smaller change IMO.
> > > >
> > > > Got it. Just to confirm that I understand correctly, do you mean:
> > > > 1. Only cable plug alt modes should be linked with the class instead of the bus.
> > > >
> > > > <or>
> > > >
> > > > 2. All alt modes (cable plug, partner, port) should be linked with the
> > > > class instead of the bus
> > > >
> > > > My initial interpretation is 1.) since the bus linkage would be
> > > > necessary to match alt mode drivers to partner alt mode devices.
> > > > But, my understanding of the bus code is limited so I could be wrong;
> > > > could you kindly clarify?
> > >
> > > We don't need to care about the bus here. A device can be part of a
> > > bus and a class at the same time. I don't think there is any reason to
> > > limit the class to only plug alt modes, so let's just assign it to all
> > > of them.
> >
> > I had actually tried this earlier, but here we run into errors.
> > If we always set the class, then "partner" altmode device creation
> > fails ("port" altmode creation will likely also fail, but I haven't
> > verified that)
> >
> > The issue is that if we set both "class" and "bus", the device_add()
> > [1] code tries to create the "subsystem" symlink in the altmode
> > device's sysfs entry twice.
> >
> > The first creation is in the call to device_add_class_symlinks()[2]
> > which creates a "subsystem" file [3]. Note that if "class" is not set,
> > this code doesn't execute.
> > Next is the call to bus_add_device() [4] which again tries to create
> > the "subsystem" symlink [5] and fails since it already exists; this
> > leads to failure.
> >
> > There are 2 solutions I can see:
> > 1. Only set class for cable plug alt modes (which won't have a bus
> > set). This will avoid the double "subsystem" sysfs file creation.
> > 2. Change the bus_add_device() code to:
> >     a. use the _nowarn() option of the symlink create function which
> > prevents the warn stack traces on -EEXIST error, and
> >     b. check for -EEXIST return value and don't fail if so.
> >
> > 2.) Sounds good to me, but I'm not sure if it's alright to continue if
> > a "subsystem" symlink already exists.
> 
> It looks like the "subsystem" name depends on the bus_type.name  and
> class.name (for bus and class respectively).
> So it is possible the two symlinks will not point to the same location
> (For example, the class for typec is "typec_mux"
> but the bus is simply "typec").
> 
> Given this, it sounds like option 1.) might be better, but I'll defer
> to your suggestions.

OK. Let's go with that option.

thanks,

-- 
heikki
