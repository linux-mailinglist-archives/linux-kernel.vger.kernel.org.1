Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8583E2C2726
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 14:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388011AbgKXN2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 08:28:11 -0500
Received: from mga01.intel.com ([192.55.52.88]:58987 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387889AbgKXN2K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 08:28:10 -0500
IronPort-SDR: 04aWintqWhdBA/ibIwdabfoJfB7bJ4CbfWMPr7ao624pMMk9kdRDBqhNBVfAG35ah8sDq7GiKM
 3JIVkXsmAzNg==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="190067497"
X-IronPort-AV: E=Sophos;i="5.78,366,1599548400"; 
   d="scan'208";a="190067497"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 05:28:09 -0800
IronPort-SDR: OK5R3P0+uTzwC2mY/C1V7GtkX1sJR9sV3RIKNW6GKsfSSmELnkT0MF7qXzeFQRIObkAoB4znWN
 3fUBbT49TcfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,366,1599548400"; 
   d="scan'208";a="432605943"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 24 Nov 2020 05:28:07 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 24 Nov 2020 15:28:06 +0200
Date:   Tue, 24 Nov 2020 15:28:06 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, Benson Leung <bleung@chromium.org>
Subject: Re: [PATCH v3 2/2] usb: typec: Expose Product Type VDOs via sysfs
Message-ID: <20201124132806.GD1008337@kuha.fi.intel.com>
References: <20201023214328.1262883-1-pmalani@chromium.org>
 <20201023214328.1262883-2-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201023214328.1262883-2-pmalani@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 23, 2020 at 02:43:28PM -0700, Prashant Malani wrote:
> A PD-capable device can return up to 3 Product Type VDOs as part of its
> DiscoverIdentity Response (USB PD Spec, Rev 3.0, Version 2.0, Section
> 6.4.4.3.1). Add sysfs attributes to expose these to userspace.
> 
> Cc: Benson Leung <bleung@chromium.org>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

I'm now fine with this as it is, no more objections. I'll send the
"type2 attribute patch separately.

I think you need to rebase this too, but FWIW:

Reviewed-by Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> 
> Changes in v3:
> - Split each product type VDO into a separate attribute.
> - Changed sprintf() to sysfs_emit().
> - Changed ABI documentation based on consolidation of identity VDO
>   descriptions in the previous patch (1/2).
> 
> Changes in v2:
> - Added sysfs_notify() call for the attribute.
> - Added description for the attribute in
>   Documentation/ABI/testing/sysfs-class-typec.
> 
>  Documentation/ABI/testing/sysfs-class-typec | 24 +++++++++++++++
>  drivers/usb/typec/class.c                   | 33 +++++++++++++++++++++
>  2 files changed, 57 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-typec b/Documentation/ABI/testing/sysfs-class-typec
> index 0f839fd022f1..0ac144bc5927 100644
> --- a/Documentation/ABI/testing/sysfs-class-typec
> +++ b/Documentation/ABI/testing/sysfs-class-typec
> @@ -205,6 +205,30 @@ Description:
>  		will show 0 until Discover Identity command result becomes
>  		available. The value can be polled.
>  
> +What:		/sys/class/typec/<port>-{partner|cable}/identity/product_type_vdo1
> +Date:		October 2020
> +Contact:	Prashant Malani <pmalani@chromium.org>
> +Description:
> +		1st Product Type VDO of Discover Identity command result.
> +		The value will show 0 until Discover Identity command result becomes
> +		available and a valid Product Type VDO is returned.
> +
> +What:		/sys/class/typec/<port>-{partner|cable}/identity/product_type_vdo2
> +Date:		October 2020
> +Contact:	Prashant Malani <pmalani@chromium.org>
> +Description:
> +		2nd Product Type VDO of Discover Identity command result.
> +		The value will show 0 until Discover Identity command result becomes
> +		available and a valid Product Type VDO is returned.
> +
> +What:		/sys/class/typec/<port>-{partner|cable}/identity/product_type_vdo3
> +Date:		October 2020
> +Contact:	Prashant Malani <pmalani@chromium.org>
> +Description:
> +		3rd Product Type VDO of Discover Identity command result.
> +		The value will show 0 until Discover Identity command result becomes
> +		available and a valid Product Type VDO is returned.
> +
>  
>  USB Type-C port alternate mode devices.
>  
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index 35eec707cb51..a2c88594b044 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -122,10 +122,40 @@ static ssize_t product_show(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RO(product);
>  
> +static ssize_t product_type_vdo1_show(struct device *dev, struct device_attribute *attr,
> +				      char *buf)
> +{
> +	struct usb_pd_identity *id = get_pd_identity(dev);
> +
> +	return sysfs_emit(buf, "0x%08x\n", id->vdo[0]);
> +}
> +static DEVICE_ATTR_RO(product_type_vdo1);
> +
> +static ssize_t product_type_vdo2_show(struct device *dev, struct device_attribute *attr,
> +				      char *buf)
> +{
> +	struct usb_pd_identity *id = get_pd_identity(dev);
> +
> +	return sysfs_emit(buf, "0x%08x\n", id->vdo[1]);
> +}
> +static DEVICE_ATTR_RO(product_type_vdo2);
> +
> +static ssize_t product_type_vdo3_show(struct device *dev, struct device_attribute *attr,
> +				      char *buf)
> +{
> +	struct usb_pd_identity *id = get_pd_identity(dev);
> +
> +	return sysfs_emit(buf, "0x%08x\n", id->vdo[2]);
> +}
> +static DEVICE_ATTR_RO(product_type_vdo3);
> +
>  static struct attribute *usb_pd_id_attrs[] = {
>  	&dev_attr_id_header.attr,
>  	&dev_attr_cert_stat.attr,
>  	&dev_attr_product.attr,
> +	&dev_attr_product_type_vdo1.attr,
> +	&dev_attr_product_type_vdo2.attr,
> +	&dev_attr_product_type_vdo3.attr,
>  	NULL
>  };
>  
> @@ -144,6 +174,9 @@ static void typec_report_identity(struct device *dev)
>  	sysfs_notify(&dev->kobj, "identity", "id_header");
>  	sysfs_notify(&dev->kobj, "identity", "cert_stat");
>  	sysfs_notify(&dev->kobj, "identity", "product");
> +	sysfs_notify(&dev->kobj, "identity", "product_type_vdo1");
> +	sysfs_notify(&dev->kobj, "identity", "product_type_vdo2");
> +	sysfs_notify(&dev->kobj, "identity", "product_type_vdo3");
>  }
>  
>  /* ------------------------------------------------------------------------- */
> -- 
> 2.29.0.rc1.297.gfa9743e501-goog

thanks,

-- 
heikki
