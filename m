Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86AF02958AD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 08:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504679AbgJVG4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 02:56:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:56544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409801AbgJVG4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 02:56:49 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDA86223FB;
        Thu, 22 Oct 2020 06:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603349806;
        bh=oQrX9JONzoZLZpeWwQAFwiY9lPCmvEjjgBYcdIQ4GSA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VjngR2jFlBi8Y3GpV6WZYd5EI1nLEnttm85MYqh6OTB4rsA5pDt91qVjZ9/O4oYTe
         Qmo5Lt8xiXoqVg1mycAREaKe+zfvG6t7cD2V2IiAGGAm+yt0WyDQ8IN5XZVLYVoPyt
         xSJEU+So5I/nyDw8zAae32xDLWlAnm9ME0/K43Ys=
Date:   Thu, 22 Oct 2020 08:57:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Benson Leung <bleung@chromium.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v2] usb: typec: Expose Product Type VDOs via sysfs
Message-ID: <20201022065719.GA1440360@kroah.com>
References: <20201022061554.3418060-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201022061554.3418060-1-pmalani@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 11:15:54PM -0700, Prashant Malani wrote:
> A PD-capable device can return up to 3 Product Type VDOs as part of its
> DiscoverIdentity Response (USB PD Spec, Rev 3.0, Version 2.0, Section
> 6.4.4.3.1). Add a sysfs attribute to expose these to userspace.
> 
> Cc: Benson Leung <bleung@chromium.org>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> ---
> 
> NOTE: I didn't include Benson's Reviewed-by from v1, since this version
> introduced the sysfs_notify() call.
> 
> Changes in v2:
> - Added sysfs_notify() call for the attribute.
> - Added description for the attribute in
>   Documentation/ABI/testing/sysfs-class-typec.
> 
>  Documentation/ABI/testing/sysfs-class-typec | 17 +++++++++++++++++
>  drivers/usb/typec/class.c                   | 11 +++++++++++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-typec b/Documentation/ABI/testing/sysfs-class-typec
> index b834671522d6..16440a236b66 100644
> --- a/Documentation/ABI/testing/sysfs-class-typec
> +++ b/Documentation/ABI/testing/sysfs-class-typec
> @@ -170,6 +170,14 @@ Description:
>  		will show 0 until Discover Identity command result becomes
>  		available. The value can be polled.
>  
> +What:		/sys/class/typec/<port>-partner/identity/product_type_vdo
> +Date:		October 2020
> +Contact:	Prashant Malani <pmalani@chromium.org>
> +Description:
> +		Product Type VDOs part of Discover Identity command result. 3 values
> +		are displayed (for the 3 possible Product Type VDOs), one per line.

sysfs is "one value per file", not "one value per line".  This is not
ok.

> +		The values will show 0s until Discover Identity command result becomes
> +		available. The values can be polled.

It can be polled?  Did you try that?  I don't see the logic for that in
your patch.


>  
>  USB Type-C cable devices (eg. /sys/class/typec/port0-cable/)
>  
> @@ -230,6 +238,15 @@ Description:
>  		will show 0 until Discover Identity command result becomes
>  		available. The value can be polled.
>  
> +What:		/sys/class/typec/<port>-cable/identity/product_type_vdo
> +Date:		October 2020
> +Contact:	Prashant Malani <pmalani@chromium.org>
> +Description:
> +		Product Type VDOs part of Discover Identity command result. 3 values
> +		are displayed (for the 3 possible Product Type VDOs), one per line.
> +		The values will show 0s until Discover Identity command result becomes
> +		available. The values can be polled.

Why are you describing the same value in two different locations?

> +
>  
>  USB Type-C port alternate mode devices.
>  
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index 35eec707cb51..37fa4501e75f 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -122,10 +122,20 @@ static ssize_t product_show(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RO(product);
>  
> +static ssize_t product_type_vdo_show(struct device *dev, struct device_attribute *attr,
> +				     char *buf)
> +{
> +	struct usb_pd_identity *id = get_pd_identity(dev);
> +
> +	return sprintf(buf, "0x%08x\n0x%08x\n0x%08x\n", id->vdo[0], id->vdo[1], id->vdo[2]);

Note, for future sysfs stuff, always use sysfs_emit().

But again, this is not allowed as you have multiple values per a single
file.

thanks,

greg k-h
