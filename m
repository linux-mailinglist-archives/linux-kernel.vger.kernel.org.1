Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D774129242D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 11:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729745AbgJSJCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 05:02:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:37796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728441AbgJSJCc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 05:02:32 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74E5F20874;
        Mon, 19 Oct 2020 09:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603098150;
        bh=28Umo+dUCWvTW7k3AsLzQcpGNBwHaFvS+CBJrNnSSW8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yMVaX4GYAZ6AhnXgePY4Geaqm1SWXzxUpTMiQorsb164+m56m9acj+K65LHWlEr9F
         +1ptwFBz6+J+M9Yqm5J/EITzckmeIW4zbOkDPhZpI5HZ/hErBw6zQ4A/0rsh8ru2nB
         Satx9Z0IO+Acvi1jj+UiEJp17canvOBbCz0c05E4=
Date:   Mon, 19 Oct 2020 11:03:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     Tom Rix <trix@redhat.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        lgoncalv@redhat.com, hao.wu@intel.com
Subject: Re: [PATCH 1/2] fpga: dfl: add driver_override support
Message-ID: <20201019090316.GA3237088@kroah.com>
References: <1602828151-24784-1-git-send-email-yilun.xu@intel.com>
 <1602828151-24784-2-git-send-email-yilun.xu@intel.com>
 <63d7730b-d9b8-c75d-16f6-3ebb507aabaa@redhat.com>
 <20201019040612.GA16172@yilunxu-OptiPlex-7050>
 <20201019085233.GB28746@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201019085233.GB28746@yilunxu-OptiPlex-7050>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 19, 2020 at 04:52:33PM +0800, Xu Yilun wrote:
> On Mon, Oct 19, 2020 at 12:06:13PM +0800, Xu Yilun wrote:
> > On Fri, Oct 16, 2020 at 09:21:50AM -0700, Tom Rix wrote:
> > > 
> > > On 10/15/20 11:02 PM, Xu Yilun wrote:
> > > > Add support for overriding the default matching of a dfl device to a dfl
> > > > driver. It follows the same way that can be used for PCI and platform
> > > > devices. This patch adds the 'driver_override' sysfs file.
> > > >
> > > > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > > > ---
> > > >  Documentation/ABI/testing/sysfs-bus-dfl | 28 ++++++++++++++---
> > > >  drivers/fpga/dfl.c                      | 54 ++++++++++++++++++++++++++++++++-
> > > >  include/linux/dfl.h                     |  2 ++
> > > >  3 files changed, 79 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/Documentation/ABI/testing/sysfs-bus-dfl b/Documentation/ABI/testing/sysfs-bus-dfl
> > > > index 23543be..db7e8d3 100644
> > > > --- a/Documentation/ABI/testing/sysfs-bus-dfl
> > > > +++ b/Documentation/ABI/testing/sysfs-bus-dfl
> > > > @@ -1,15 +1,35 @@
> > > >  What:		/sys/bus/dfl/devices/dfl_dev.X/type
> > > > -Date:		Aug 2020
> > > > -KernelVersion:	5.10
> > > > +Date:		Oct 2020
> > > > +KernelVersion:	5.11
> > > >  Contact:	Xu Yilun <yilun.xu@intel.com>
> > > >  Description:	Read-only. It returns type of DFL FIU of the device. Now DFL
> > > >  		supports 2 FIU types, 0 for FME, 1 for PORT.
> > > >  		Format: 0x%x
> > > >  
> > > >  What:		/sys/bus/dfl/devices/dfl_dev.X/feature_id
> > > > -Date:		Aug 2020
> > > > -KernelVersion:	5.10
> > > > +Date:		Oct 2020
> > > > +KernelVersion:	5.11
> > > >  Contact:	Xu Yilun <yilun.xu@intel.com>
> > > >  Description:	Read-only. It returns feature identifier local to its DFL FIU
> > > >  		type.
> > > >  		Format: 0x%x
> > > 
> > > These updates, do not match the comment.
> > > 
> > > Consider splitting this out.
> > 
> > I'm sorry it's a typo. The above code should not be changed.
> > 
> > > 
> > > > +
> > > > +What:           /sys/bus/dfl/devices/.../driver_override
> > > > +Date:           Oct 2020
> > > > +KernelVersion:  5.11
> > > > +Contact:        Xu Yilun <yilun.xu@intel.com>
> > > I am looking at description and trying to make it consistent with sysfs-bus-pci
> > > > +Description:    This file allows the driver for a device to be specified.
> > > 
> > > 'to be specified which will override the standard dfl bus feature id to driver mapping.'
> > 
> > Yes, it could be improved.
> > 
> > Actually now it is the "type" and "feature id" matching, the 2 fields
> > are defined for dfl_driver.id_table. In future for dfl v1, it may be
> > GUID matching, which will be added to id_table. So how about we make it
> > more generic:
> > 
> > 'to be specified which will override the standard ID table matching.'
> > 
> > > 
> > > 
> > > >  When
> > > > +                specified, only a driver with a name matching the value written
> > > > +                to driver_override will have an opportunity to bind to the
> > > > +                device. The override is specified by writing a string to the
> > > > +                driver_override file (echo dfl-uio-pdev > driver_override) and
> > > > +                may be cleared with an empty string (echo > driver_override).
> > > > +                This returns the device to standard matching rules binding.
> > > > +                Writing to driver_override does not automatically unbind the
> > > > +                device from its current driver or make any attempt to
> > > > +                automatically load the specified driver.  If no driver with a
> > > > +                matching name is currently loaded in the kernel, the device
> > > > +                will not bind to any driver.  This also allows devices to
> > > > +                opt-out of driver binding using a driver_override name such as
> > > > +                "none".  Only a single driver may be specified in the override,
> > > > +                there is no support for parsing delimiters.
> > > > diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> > > > index 511b20f..bc35750 100644
> > > > --- a/drivers/fpga/dfl.c
> > > > +++ b/drivers/fpga/dfl.c
> > > > @@ -262,6 +262,10 @@ static int dfl_bus_match(struct device *dev, struct device_driver *drv)
> > > >  	struct dfl_driver *ddrv = to_dfl_drv(drv);
> > > >  	const struct dfl_device_id *id_entry;
> > > >  
> > > > +	/* When driver_override is set, only bind to the matching driver */
> > > > +	if (ddev->driver_override)
> > > > +		return !strcmp(ddev->driver_override, drv->name);
> > > > +
> > > >  	id_entry = ddrv->id_table;
> > > >  	if (id_entry) {
> > > >  		while (id_entry->feature_id) {
> > > > @@ -303,6 +307,53 @@ static int dfl_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
> > > >  			      ddev->type, ddev->feature_id);
> > > >  }
> > > >  
> > > 
> > > I am looking at other implementations of driver_override* and looking for consistency.
> > > 
> > > > +static ssize_t driver_override_show(struct device *dev,
> > > > +				    struct device_attribute *attr, char *buf)
> > > > +{
> > > > +	struct dfl_device *ddev = to_dfl_dev(dev);
> > > > +	ssize_t len;
> > > > +
> > > > +	device_lock(dev);
> > > > +	len = sprintf(buf, "%s\n", ddev->driver_override);
> > > len = snprintf(buf, PAGE_SIZE ...
> > 
> > It is good to me.
> > 
> > Some bus drivers use snprintf, some use sprintf.
> > 
> > I think it is reasonable snprintf is used here, unlike %d, %u ... it is
> > uncertain for the output size of %s.
> 
> Sorry, I checked the Documentation/filesystems/sysfs.rst again and found
> I didn't remember it correctly.
> 
> The snprintf is must not be used, sprintf() or scnprintf() should be
> used. So I prefer sprintf() here, following other implementations.
> 
> sprintf() should be safe here, as we already limited the input of
> driver_override string to less then PAGE_SIZE on store().

As already mentioned, please use sysfs_emit() instead.

thanks,

greg k-h
