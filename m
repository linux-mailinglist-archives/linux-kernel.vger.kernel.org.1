Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFF3F2B5F44
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 13:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgKQMlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 07:41:47 -0500
Received: from mga14.intel.com ([192.55.52.115]:8373 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbgKQMlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 07:41:47 -0500
IronPort-SDR: Bd2/gJtsSLIoapTNURkklzfBM+7/X51L0ZUVoJ8XE9VeX2y+QbOQh/npt/k789kYCUnuxG49Ms
 WamXKMc6OObA==
X-IronPort-AV: E=McAfee;i="6000,8403,9807"; a="170131740"
X-IronPort-AV: E=Sophos;i="5.77,485,1596524400"; 
   d="scan'208";a="170131740"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 04:41:46 -0800
IronPort-SDR: /s1sCQ6RJLyT75isHNx8xUVNWaGwTDwdmX556y9yU/erI5XdHTLtJ4Chbq4JZnLQuVSXmB4G9S
 3VOodp9O4STw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,485,1596524400"; 
   d="scan'208";a="430466891"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 17 Nov 2020 04:41:44 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 17 Nov 2020 14:41:43 +0200
Date:   Tue, 17 Nov 2020 14:41:43 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, enric.balletbo@collabora.com
Subject: Re: [PATCH v3 03/11] usb: typec: Add plug num_altmodes sysfs attr
Message-ID: <20201117124143.GI3437448@kuha.fi.intel.com>
References: <20201116201150.2919178-1-pmalani@chromium.org>
 <20201116201150.2919178-4-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116201150.2919178-4-pmalani@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 12:11:42PM -0800, Prashant Malani wrote:
> Add a field to the typec_plug struct to record the number of available
> altmodes as well as the corresponding sysfs attribute to expose this to
> userspace.
> 
> This allows userspace to determine whether there are any
> remaining alternate modes left to be registered by the kernel driver. It
> can begin executing any policy state machine after all available
> alternate modes have been registered with the connector class framework.
> 
> This value is set to "-1" initially, signifying that a valid number of
> alternate modes haven't been set for the plug. The sysfs file remains
> hidden as long as the attribute value is -1.

Why couldn't we just keep it hidden for as long as the number of
alt modes is 0? If you already explained that, then I apologise, I've
forgotten.

> We re-use the partner attribute for number_of_alternate_modes since the
> usage and name is similar, and update the corresponding *_show() command
> to support both partner and plugs.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> ---
> 
> Changes in v3:
> - Re-arranged patch order and combined it with related series of
>   patches.
> 
> No version v2.
> 
>  Documentation/ABI/testing/sysfs-class-typec |  9 +++
>  drivers/usb/typec/class.c                   | 77 ++++++++++++++++++++-
>  include/linux/usb/typec.h                   |  1 +
>  3 files changed, 85 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-typec b/Documentation/ABI/testing/sysfs-class-typec
> index 73ac7b461ae5..29eccf5fb8ed 100644
> --- a/Documentation/ABI/testing/sysfs-class-typec
> +++ b/Documentation/ABI/testing/sysfs-class-typec
> @@ -204,6 +204,15 @@ Description:
>  		- type-c
>  		- captive
>  
> +What:		/sys/class/typec/<port>-<plug>/number_of_alternate_modes
> +Date:		November 2020
> +Contact:	Prashant Malani <pmalani@chromium.org>
> +Description:
> +		Shows the number of alternate modes which are advertised by the plug
> +		associated with a particular cable during Power Delivery discovery.
> +		This file remains hidden until a value greater than or equal to 0
> +		is set by Type C port driver.
> +
>  What:		/sys/class/typec/<port>-cable/identity/
>  Date:		April 2017
>  Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index c7412ddbd311..e68798599ca8 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -18,6 +18,7 @@ struct typec_plug {
>  	struct device			dev;
>  	enum typec_plug_index		index;
>  	struct ida			mode_ids;
> +	int				num_altmodes;
>  };
>  
>  struct typec_cable {
> @@ -536,9 +537,21 @@ static DEVICE_ATTR_RO(supports_usb_power_delivery);
>  static ssize_t number_of_alternate_modes_show(struct device *dev, struct device_attribute *attr,
>  					      char *buf)
>  {
> -	struct typec_partner *p = to_typec_partner(dev);
> +	struct typec_partner *partner;
> +	struct typec_plug *plug;
> +	int num_altmodes;
> +
> +	if (is_typec_partner(dev)) {
> +		partner = to_typec_partner(dev);
> +		num_altmodes = partner->num_altmodes;
> +	} else if (is_typec_plug(dev)) {
> +		plug = to_typec_plug(dev);
> +		num_altmodes = plug->num_altmodes;
> +	} else {
> +		return 0;
> +	}
>  
> -	return sysfs_emit(buf, "%d\n", p->num_altmodes);
> +	return sysfs_emit(buf, "%d\n", num_altmodes);
>  }
>  static DEVICE_ATTR_RO(number_of_alternate_modes);
>  
> @@ -726,11 +739,70 @@ static void typec_plug_release(struct device *dev)
>  	kfree(plug);
>  }
>  
> +static struct attribute *typec_plug_attrs[] = {
> +	&dev_attr_number_of_alternate_modes.attr,
> +	NULL
> +};
> +
> +static umode_t typec_plug_attr_is_visible(struct kobject *kobj, struct attribute *attr, int n)
> +{
> +	struct typec_plug *plug = to_typec_plug(kobj_to_dev(kobj));
> +
> +	if (attr == &dev_attr_number_of_alternate_modes.attr) {
> +		if (plug->num_altmodes < 0)
> +			return 0;
> +	}
> +
> +	return attr->mode;
> +}
> +
> +static struct attribute_group typec_plug_group = {
> +	.is_visible = typec_plug_attr_is_visible,
> +	.attrs = typec_plug_attrs
> +};
> +
> +static const struct attribute_group *typec_plug_groups[] = {
> +	&typec_plug_group,
> +	NULL
> +};
> +
>  static const struct device_type typec_plug_dev_type = {
>  	.name = "typec_plug",
> +	.groups = typec_plug_groups,
>  	.release = typec_plug_release,
>  };
>  
> +/**
> + * typec_plug_set_num_altmodes - Set the number of available plug altmodes
> + * @plug: The plug to be updated.
> + * @num_altmodes: The number of altmodes we want to specify as available.
> + *
> + * This routine is used to report the number of alternate modes supported by the
> + * plug. This value is *not* enforced in alternate mode registration routines.
> + *
> + * @plug.num_altmodes is set to -1 on plug registration, denoting that
> + * a valid value has not been set for it yet.
> + *
> + * Returns 0 on success or negative error number on failure.
> + */
> +int typec_plug_set_num_altmodes(struct typec_plug *plug, int num_altmodes)
> +{
> +	int ret;
> +
> +	if (num_altmodes < 0)
> +		return -EINVAL;
> +
> +	plug->num_altmodes = num_altmodes;
> +	ret = sysfs_update_group(&plug->dev.kobj, &typec_plug_group);
> +	if (ret < 0)
> +		return ret;
> +
> +	sysfs_notify(&plug->dev.kobj, NULL, "number_of_alternate_modes");
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(typec_plug_set_num_altmodes);
> +
>  /**
>   * typec_plug_register_altmode - Register USB Type-C Cable Plug Alternate Mode
>   * @plug: USB Type-C Cable Plug that supports the alternate mode
> @@ -776,6 +848,7 @@ struct typec_plug *typec_register_plug(struct typec_cable *cable,
>  	sprintf(name, "plug%d", desc->index);
>  
>  	ida_init(&plug->mode_ids);
> +	plug->num_altmodes = -1;
>  	plug->index = desc->index;
>  	plug->dev.class = typec_class;
>  	plug->dev.parent = &cable->dev;
> diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
> index bc6b1a71cb8a..54475323f83b 100644
> --- a/include/linux/usb/typec.h
> +++ b/include/linux/usb/typec.h
> @@ -130,6 +130,7 @@ int typec_partner_set_num_altmodes(struct typec_partner *partner, int num_altmod
>  struct typec_altmode
>  *typec_partner_register_altmode(struct typec_partner *partner,
>  				const struct typec_altmode_desc *desc);
> +int typec_plug_set_num_altmodes(struct typec_plug *plug, int num_altmodes);
>  struct typec_altmode
>  *typec_plug_register_altmode(struct typec_plug *plug,
>  			     const struct typec_altmode_desc *desc);
> -- 
> 2.29.2.299.gdc1121823c-goog

thanks,

-- 
heikki
