Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 953072AD415
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 11:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730029AbgKJKt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 05:49:26 -0500
Received: from mga04.intel.com ([192.55.52.120]:5585 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726462AbgKJKt0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 05:49:26 -0500
IronPort-SDR: 4r7Nf5fcEso5Q0C/DrmXwxO0fm6ddrEc+pOsSDDs7k3VONkm97mfYOZKNzai5tsLl5TK1ud8mr
 w+ZEeME4NnzQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9800"; a="167369891"
X-IronPort-AV: E=Sophos;i="5.77,466,1596524400"; 
   d="scan'208";a="167369891"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 02:49:24 -0800
IronPort-SDR: SdZQD6pT3dVhjbj7KEnlziioZ8S80kp8pOROHf0uUpYYoh+fzCiaM88wKp0BmW4QIQ5iw4lB5k
 UIAGTCAaggiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,466,1596524400"; 
   d="scan'208";a="428325751"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 10 Nov 2020 02:49:22 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 10 Nov 2020 12:49:21 +0200
Date:   Tue, 10 Nov 2020 12:49:21 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH v2 1/2] usb: typec: Add number of altmodes partner attr
Message-ID: <20201110104921.GE1224435@kuha.fi.intel.com>
References: <20201110061535.2163599-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110061535.2163599-1-pmalani@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 09, 2020 at 10:15:34PM -0800, Prashant Malani wrote:
> Add a user-visible attribute for the number of alternate modes available
> in a partner. This allows userspace to determine whether there are any
> remaining alternate modes left to be registered by the kernel driver. It
> can begin executing any policy state machine after all available
> alternate modes have been registered with the connector class framework.
> 
> This value is set to "-1" initially, signifying that a valid number of
> alternate modes haven't been set for the partner.
> 
> Also add a sysfs file which exposes this attribute. The file remains
> hidden as long as the attribute value is -1.
> 
> Cc: Benson Leung <bleung@chromium.org>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> 
> Changes in v2:
> - Added ABI/testing documentation entry for added sysfs file.
> - Changed name of the sysfs file to "number_of_alternate_modes" based on
>   review comments.
> - Added is_visible() logic suggested by Heikki in the comments of v1.
> - Updated commit message.
> 
> v1:
> https://lore.kernel.org/lkml/20200701003149.3101219-1-pmalani@chromium.org/
> 
>  Documentation/ABI/testing/sysfs-class-typec |  8 +++
>  drivers/usb/typec/class.c                   | 66 ++++++++++++++++++++-
>  include/linux/usb/typec.h                   |  1 +
>  3 files changed, 74 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-typec b/Documentation/ABI/testing/sysfs-class-typec
> index b834671522d6..73ac7b461ae5 100644
> --- a/Documentation/ABI/testing/sysfs-class-typec
> +++ b/Documentation/ABI/testing/sysfs-class-typec
> @@ -134,6 +134,14 @@ Description:
>  		Shows if the partner supports USB Power Delivery communication:
>  		Valid values: yes, no
>  
> +What:		/sys/class/typec/<port>-partner/number_of_alternate_modes
> +Date:		November 2020
> +Contact:	Prashant Malani <pmalani@chromium.org>
> +Description:
> +		Shows the number of alternate modes which are advertised by the partner
> +		during Power Delivery discovery. This file remains hidden until a value
> +		greater than or equal to 0 is set by Type C port driver.
> +
>  What:		/sys/class/typec/<port>-partner>/identity/
>  Date:		April 2017
>  Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index 35eec707cb51..c7412ddbd311 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -33,6 +33,7 @@ struct typec_partner {
>  	struct usb_pd_identity		*identity;
>  	enum typec_accessory		accessory;
>  	struct ida			mode_ids;
> +	int				num_altmodes;
>  };
>  
>  struct typec_port {
> @@ -532,12 +533,43 @@ static ssize_t supports_usb_power_delivery_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(supports_usb_power_delivery);
>  
> +static ssize_t number_of_alternate_modes_show(struct device *dev, struct device_attribute *attr,
> +					      char *buf)
> +{
> +	struct typec_partner *p = to_typec_partner(dev);
> +
> +	return sysfs_emit(buf, "%d\n", p->num_altmodes);
> +}
> +static DEVICE_ATTR_RO(number_of_alternate_modes);
> +
>  static struct attribute *typec_partner_attrs[] = {
>  	&dev_attr_accessory_mode.attr,
>  	&dev_attr_supports_usb_power_delivery.attr,
> +	&dev_attr_number_of_alternate_modes.attr,
> +	NULL
> +};
> +
> +static umode_t typec_partner_attr_is_visible(struct kobject *kobj, struct attribute *attr, int n)
> +{
> +	struct typec_partner *partner = to_typec_partner(kobj_to_dev(kobj));
> +
> +	if (attr == &dev_attr_number_of_alternate_modes.attr) {
> +		if (partner->num_altmodes < 0)
> +			return 0;
> +	}
> +
> +	return attr->mode;
> +}
> +
> +static struct attribute_group typec_partner_group = {
> +	.is_visible = typec_partner_attr_is_visible,
> +	.attrs = typec_partner_attrs
> +};
> +
> +static const struct attribute_group *typec_partner_groups[] = {
> +	&typec_partner_group,
>  	NULL
>  };
> -ATTRIBUTE_GROUPS(typec_partner);
>  
>  static void typec_partner_release(struct device *dev)
>  {
> @@ -570,6 +602,37 @@ int typec_partner_set_identity(struct typec_partner *partner)
>  }
>  EXPORT_SYMBOL_GPL(typec_partner_set_identity);
>  
> +/**
> + * typec_partner_set_num_altmodes - Set the number of available partner altmodes
> + * @partner: The partner to be updated.
> + * @num_alt_modes: The number of altmodes we want to specify as available.
> + *
> + * This routine is used to report the number of alternate modes supported by the
> + * partner. This value is *not* enforced in alternate mode registration routines.
> + *
> + * @partner.num_altmodes is set to -1 on partner registration, denoting that
> + * a valid value has not been set for it yet.
> + *
> + * Returns 0 on success or negative error number on failure.
> + */
> +int typec_partner_set_num_altmodes(struct typec_partner *partner, int num_altmodes)
> +{
> +	int ret;
> +
> +	if (num_altmodes < 0)
> +		return -EINVAL;
> +
> +	partner->num_altmodes = num_altmodes;
> +	ret = sysfs_update_group(&partner->dev.kobj, &typec_partner_group);
> +	if (ret < 0)
> +		return ret;
> +
> +	sysfs_notify(&partner->dev.kobj, NULL, "number_of_alternate_modes");
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(typec_partner_set_num_altmodes);
> +
>  /**
>   * typec_partner_register_altmode - Register USB Type-C Partner Alternate Mode
>   * @partner: USB Type-C Partner that supports the alternate mode
> @@ -612,6 +675,7 @@ struct typec_partner *typec_register_partner(struct typec_port *port,
>  	ida_init(&partner->mode_ids);
>  	partner->usb_pd = desc->usb_pd;
>  	partner->accessory = desc->accessory;
> +	partner->num_altmodes = -1;
>  
>  	if (desc->identity) {
>  		/*
> diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
> index 6be558045942..bc6b1a71cb8a 100644
> --- a/include/linux/usb/typec.h
> +++ b/include/linux/usb/typec.h
> @@ -126,6 +126,7 @@ struct typec_altmode_desc {
>  	enum typec_port_data	roles;
>  };
>  
> +int typec_partner_set_num_altmodes(struct typec_partner *partner, int num_altmodes);
>  struct typec_altmode
>  *typec_partner_register_altmode(struct typec_partner *partner,
>  				const struct typec_altmode_desc *desc);
> -- 
> 2.29.2.222.g5d2a92d10f8-goog

thanks,

-- 
heikki
