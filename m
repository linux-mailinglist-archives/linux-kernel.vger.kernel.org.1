Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5C92AD613
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 13:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730117AbgKJMVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 07:21:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:35038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726737AbgKJMVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 07:21:12 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4631520665;
        Tue, 10 Nov 2020 12:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605010869;
        bh=5O/+CI9oML9AyzadbrSfhjTZaL+YWqtDDnnwjy3XEF4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fSVJptdx2qXkdBDrsFE5VgllZ2BeQpcRohVs8vf5CUTBNNPrbLbsbdRVwdWa+YY2f
         7ROnp0GOarFUZRQm7jBch+a7gJclV+N+LE8d6UMYtNK/rZdqJHoY1aa4U80Rds1kVI
         xwrQDzwEDGPhAEaM+0eMGt184mzTWCGr8WHGeMIk=
Date:   Tue, 10 Nov 2020 13:22:06 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Benson Leung <bleung@chromium.org>
Subject: Re: [PATCH v3 2/2] usb: typec: Expose Product Type VDOs via sysfs
Message-ID: <X6qF7hioVJyCm/Ps@kroah.com>
References: <20201023214328.1262883-1-pmalani@chromium.org>
 <20201023214328.1262883-2-pmalani@chromium.org>
 <20201110115453.GI1224435@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110115453.GI1224435@kuha.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 01:54:53PM +0200, Heikki Krogerus wrote:
> On Fri, Oct 23, 2020 at 02:43:28PM -0700, Prashant Malani wrote:
> > A PD-capable device can return up to 3 Product Type VDOs as part of its
> > DiscoverIdentity Response (USB PD Spec, Rev 3.0, Version 2.0, Section
> > 6.4.4.3.1). Add sysfs attributes to expose these to userspace.
> > 
> > Cc: Benson Leung <bleung@chromium.org>
> > Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > Signed-off-by: Prashant Malani <pmalani@chromium.org>
> > ---
> > 
> > Changes in v3:
> > - Split each product type VDO into a separate attribute.
> > - Changed sprintf() to sysfs_emit().
> > - Changed ABI documentation based on consolidation of identity VDO
> >   descriptions in the previous patch (1/2).
> > 
> > Changes in v2:
> > - Added sysfs_notify() call for the attribute.
> > - Added description for the attribute in
> >   Documentation/ABI/testing/sysfs-class-typec.
> > 
> >  Documentation/ABI/testing/sysfs-class-typec | 24 +++++++++++++++
> >  drivers/usb/typec/class.c                   | 33 +++++++++++++++++++++
> >  2 files changed, 57 insertions(+)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-class-typec b/Documentation/ABI/testing/sysfs-class-typec
> > index 0f839fd022f1..0ac144bc5927 100644
> > --- a/Documentation/ABI/testing/sysfs-class-typec
> > +++ b/Documentation/ABI/testing/sysfs-class-typec
> > @@ -205,6 +205,30 @@ Description:
> >  		will show 0 until Discover Identity command result becomes
> >  		available. The value can be polled.
> >  
> > +What:		/sys/class/typec/<port>-{partner|cable}/identity/product_type_vdo1
> > +Date:		October 2020
> > +Contact:	Prashant Malani <pmalani@chromium.org>
> > +Description:
> > +		1st Product Type VDO of Discover Identity command result.
> > +		The value will show 0 until Discover Identity command result becomes
> > +		available and a valid Product Type VDO is returned.
> > +
> > +What:		/sys/class/typec/<port>-{partner|cable}/identity/product_type_vdo2
> > +Date:		October 2020
> > +Contact:	Prashant Malani <pmalani@chromium.org>
> > +Description:
> > +		2nd Product Type VDO of Discover Identity command result.
> > +		The value will show 0 until Discover Identity command result becomes
> > +		available and a valid Product Type VDO is returned.
> > +
> > +What:		/sys/class/typec/<port>-{partner|cable}/identity/product_type_vdo3
> > +Date:		October 2020
> > +Contact:	Prashant Malani <pmalani@chromium.org>
> > +Description:
> > +		3rd Product Type VDO of Discover Identity command result.
> > +		The value will show 0 until Discover Identity command result becomes
> > +		available and a valid Product Type VDO is returned.
> > +
> >  
> >  USB Type-C port alternate mode devices.
> >  
> > diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> > index 35eec707cb51..a2c88594b044 100644
> > --- a/drivers/usb/typec/class.c
> > +++ b/drivers/usb/typec/class.c
> > @@ -122,10 +122,40 @@ static ssize_t product_show(struct device *dev, struct device_attribute *attr,
> >  }
> >  static DEVICE_ATTR_RO(product);
> >  
> > +static ssize_t product_type_vdo1_show(struct device *dev, struct device_attribute *attr,
> > +				      char *buf)
> > +{
> > +	struct usb_pd_identity *id = get_pd_identity(dev);
> > +
> > +	return sysfs_emit(buf, "0x%08x\n", id->vdo[0]);
> > +}
> > +static DEVICE_ATTR_RO(product_type_vdo1);
> > +
> > +static ssize_t product_type_vdo2_show(struct device *dev, struct device_attribute *attr,
> > +				      char *buf)
> > +{
> > +	struct usb_pd_identity *id = get_pd_identity(dev);
> > +
> > +	return sysfs_emit(buf, "0x%08x\n", id->vdo[1]);
> > +}
> > +static DEVICE_ATTR_RO(product_type_vdo2);
> > +
> > +static ssize_t product_type_vdo3_show(struct device *dev, struct device_attribute *attr,
> > +				      char *buf)
> > +{
> > +	struct usb_pd_identity *id = get_pd_identity(dev);
> > +
> > +	return sysfs_emit(buf, "0x%08x\n", id->vdo[2]);
> > +}
> > +static DEVICE_ATTR_RO(product_type_vdo3);
> > +
> >  static struct attribute *usb_pd_id_attrs[] = {
> >  	&dev_attr_id_header.attr,
> >  	&dev_attr_cert_stat.attr,
> >  	&dev_attr_product.attr,
> > +	&dev_attr_product_type_vdo1.attr,
> > +	&dev_attr_product_type_vdo2.attr,
> > +	&dev_attr_product_type_vdo3.attr,
> >  	NULL
> >  };
> >  
> > @@ -144,6 +174,9 @@ static void typec_report_identity(struct device *dev)
> >  	sysfs_notify(&dev->kobj, "identity", "id_header");
> >  	sysfs_notify(&dev->kobj, "identity", "cert_stat");
> >  	sysfs_notify(&dev->kobj, "identity", "product");
> > +	sysfs_notify(&dev->kobj, "identity", "product_type_vdo1");
> > +	sysfs_notify(&dev->kobj, "identity", "product_type_vdo2");
> > +	sysfs_notify(&dev->kobj, "identity", "product_type_vdo3");
> >  }
> 
> I've now come to the conclusion that this is not the correct approach.
> Instead, the whole identity, all six VDOs, should be supplied
> separately with a "raw" sysfs attribute file after all.
> 
> The three attribute files that we already have - so id_header,
> cert_stat and product - can always supply the actual VDO as is,
> regardless of the product type, so they are fine. But these new
> attribute files, product_type_vdoX, would behave differently as they
> supply different information depending on the product type. That just
> does not feel right to me.
> 
> So lets just add the "raw" sysfs attribute file. We can think about
> extracting some other details from the product type VDOs once the
> specification has settled down a bit and we can be quite certain that
> those details will always be available.
> 
> Would this be OK to you? I think we should be able to dump the data to
> the "raw" sysfs attribute file with something like hex_dump_to_buffer().

Does this mean that the value of the attributes depends on something
external to the device?  If so, how is userspace going to know how to
parse this any differently than the kernel could today?

And I say this as the maintainer of 'lsusb' which probably should start
getting support for the typec attributes that are being exposed here :)

thanks,

greg k-h
