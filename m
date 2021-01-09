Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 013702EFEA6
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 09:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbhAIIei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 03:34:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:43160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbhAIIei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 03:34:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B698723A1C;
        Sat,  9 Jan 2021 08:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610181237;
        bh=/NVakth6QATJ6MZB9PLPUoh8525ch7muAAkUo+5vnFo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=smIBkVXlI1nr1nBFmaoCf2tI4bL3XgcefyQQdPoiQmDEjv2pLCVbWSTjzD7VYUkxc
         Epwe5lfOb4jp5dGZ2svNVVPqwnBPRyRjssLbGEAtbZf+dFdls7bxTUmiDMrY8T6YCf
         2rCxfknLXmA49hBI5KSxqKpynMkkod0qMlCp5mIs=
Date:   Sat, 9 Jan 2021 09:33:53 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Chen, Mike Ximing" <mike.ximing.chen@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v8 04/20] dlb: add device ioctl layer and first three
 ioctls
Message-ID: <X/lqcaLVb+PbbmWg@kroah.com>
References: <20210105025839.23169-1-mike.ximing.chen@intel.com>
 <20210105025839.23169-5-mike.ximing.chen@intel.com>
 <X/dmB3q6QEd2aQdG@kroah.com>
 <SA2PR11MB5018670AEC81EA93598E1212D9AD0@SA2PR11MB5018.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA2PR11MB5018670AEC81EA93598E1212D9AD0@SA2PR11MB5018.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 09, 2021 at 07:49:24AM +0000, Chen, Mike Ximing wrote:
> > > +static int dlb_ioctl_arg_size[NUM_DLB_CMD] = {
> > > +	sizeof(struct dlb_get_device_version_args),
> > > +	sizeof(struct dlb_create_sched_domain_args),
> > > +	sizeof(struct dlb_get_num_resources_args)
> > 
> > That list.
> > 
> > Ugh, no.  that's no way to write maintainable code that you will be able
> > to understand in 2 years.
> > 
> 
> dlb_ioctl() was implemented with switch-case and real function calls previously. 
> We changed to the table/list implementation during a code restructure. I will move
> back to the old implementation. 

Who said to change this?  And why did they say that?  Please go back to
those developers and point them at this thread so that doesn't happen
again...

> > > +{
> > > +	struct dlb *dlb;
> > > +	dlb_ioctl_fn_t fn;
> > > +	u32 cmd_nr;
> > > +	void *karg;
> > > +	int size;
> > > +	int ret;
> > > +
> > > +	dlb = f->private_data;
> > > +
> > > +	if (!dlb) {
> > > +		pr_err("dlb: [%s()] Invalid DLB data\n", __func__);
> > > +		return -EFAULT;
> > 
> > This error value is only allowed if you really do have a memory fault.
> > 
> > Hint, you do not here.
> > 
> > How can that value ever be NULL?
> >
> 
> It is targeted at some very rare cases, in which an ioctl command are called immediately after a device unbind (by a different process/application).

And how can that happen?  If it really can happen, where is the lock
that you are holding to keep that pointer from becoming "stale" right
after you assign it?

So either this never can happen, or your logic here for this type of
thing is totally wrong.  Please work to determine which it is.

> > > +#define DLB_DEVICE_VERSION(x) (((x) >> 8) & 0xFF)
> > > +#define DLB_DEVICE_REVISION(x) ((x) & 0xFF)
> > > +
> > > +enum dlb_revisions {
> > > +	DLB_REV_A0 = 0,
> > 
> > What is a "revision" and why do you care about it?
> 
> This is for different revisions of hardware. Each revision of hardware may have a slight different configuration/feature.

So what does this mean?  What are you going to do based on it?

> > > +/*
> > > + * DLB_CMD_GET_DEVICE_VERSION: Query the DLB device version.
> > > + *
> > > + *	Each DLB device version has its own unique ioctl API, but all share
> > > + *	this as the first command in their interface, which tells user-space
> > > + *	which API to use. The device revision is provided in case of any
> > > + *	hardware errata.
> > > + *
> > > + * Output parameters:
> > > + * - response.status: Detailed error code. In certain cases, such as if the
> > > + *	ioctl request arg is invalid, the driver won't set status.
> > > + * - response.id[7:0]: Device revision.
> > > + * - response.id[15:8]: Device version.
> > 
> > So userspace has to do different things depending on what the hardware
> > type is?  Why not make a totally different driver for new hardware
> > types if things are going to change in the future?
> > 
> 
> This comment is not correct (sorry about this).  There will be different 
> versions of  DLB hardware (of the same type). All DLB devices will have the same ioctl
> API and userspace interface.

Good, please fix then :)

thanks,

greg k-h
