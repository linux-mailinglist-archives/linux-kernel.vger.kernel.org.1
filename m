Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF712B8359
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 18:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbgKRRsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 12:48:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbgKRRsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 12:48:30 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DE4C0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 09:48:28 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id b63so1859377pfg.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 09:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HgAK5y0ic7imcSnfA2IT+7MZ20IGw6NqpjJTqo3NP7k=;
        b=muykQAmy0v84kFbjkDhGLQt375vOlyjnsV/PlTypndUs34ZtSEw07FG+AiIwAx6Gm5
         6MgD13+wYBWxITQpAF0hxyPgdFGpORt6iE/iw0PrYOrAS6lPF1zINU563LsVQaa9vDgF
         P0CAOL8XM3RxcXHC7EwMk9cXcHoK7bxvkB6vAVWN+upDfqUD4nKP6gExT8FrGHdNv6yV
         zabcaaYNo/1behO98GYjfgZeYUahBjuqaXyln9MHtoZEWFN62BSQk44FutwPVLMPYZiC
         83m6zlg/Xa0E30mG6H2zcDA4AKqu1BAF1KrNcUBZChKVyJmOG4Lk2epL8vz2PQFWl/xw
         B4Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HgAK5y0ic7imcSnfA2IT+7MZ20IGw6NqpjJTqo3NP7k=;
        b=YaMCxxV9fz3TQ6NYVNSTVeWUZ+R8Hv4sfB3pSS8haAuppWJW18x/4JvOPm5S8icQhM
         sgnOZtd0APo0Dql6dG3yttZIiNRKVcHyeXqRtLRvTwHvXiyuio6Q6dLDwQQdmikd3LPn
         5atkyVfv8iYye3oE28BX26tv/AflGF4+YFRi/UAgUn/jJ8JqdFQtYo7pNhKbkwP3PP99
         DFOwva3BEu8rHd79O2Fl7vxq5Rkmk4ZfKuYowIc2lIHrGSdGqTPjTYto5dV00XiRsz5r
         bwlHFPx6hY5fEGyMRIICIj7OE3HOrVpurR2NcwumwHieKqM8HhUNbl5Z2ftfkZh31sRi
         WyRQ==
X-Gm-Message-State: AOAM5327Wqk7dSQ0nqG+qdnFuuI8sq9sFmyqCBcF3QEyuHQZOM57gAhc
        4fbKRZ1x5dbXVKxb6x2C+PNAGA==
X-Google-Smtp-Source: ABdhPJxGxLl0XurCZ6h62K/qk1EwmdcjvC5EyUVR8hZfCFwx/Tz8cDuqunHWiIGpNEqdfkKA5VoLSw==
X-Received: by 2002:a63:c745:: with SMTP id v5mr8945627pgg.389.1605721707815;
        Wed, 18 Nov 2020 09:48:27 -0800 (PST)
Received: from google.com ([2620:15c:202:201:4a0f:cfff:fe66:e92e])
        by smtp.gmail.com with ESMTPSA id n72sm26739670pfd.202.2020.11.18.09.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 09:48:26 -0800 (PST)
Date:   Wed, 18 Nov 2020 09:48:21 -0800
From:   Benson Leung <bleung@google.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [RFC PATCH 2/3] usb: typec: Add product_type sysfs attribute
 file for partners and cables
Message-ID: <20201118174821.GA1966168@google.com>
References: <20201118150059.3419-1-heikki.krogerus@linux.intel.com>
 <20201118150059.3419-3-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
In-Reply-To: <20201118150059.3419-3-heikki.krogerus@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Heikki,

On Wed, Nov 18, 2020 at 06:00:58PM +0300, Heikki Krogerus wrote:
> USB Power Delivery Specification defines a set of product
> types for partners and cables. The product type is defined
> in the ID Header VDO, which is the first object in the
> response to the Discover Identity command.
>=20
> This sysfs attribute file is only created for the partners
> and cables if the product type is really known in the
> driver. Some interfaces do not give access to the Discover
> Identity response from the partner or cable, but they may
> still supply the product type separately in some cases.
>=20
> When the product type of the partner or cable is detected,
> uevent is also raised with PRODUCT_TYPE set to show the
> actual product type (for example PRODUCT_TYPE=3Dhost).
>=20
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  Documentation/ABI/testing/sysfs-class-typec |  55 ++++++++
>  drivers/usb/typec/class.c                   | 132 ++++++++++++++++++--
>  2 files changed, 180 insertions(+), 7 deletions(-)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-class-typec b/Documentation/=
ABI/testing/sysfs-class-typec
> index b7794e02ad205..4c09e327c62be 100644
> --- a/Documentation/ABI/testing/sysfs-class-typec
> +++ b/Documentation/ABI/testing/sysfs-class-typec
> @@ -139,6 +139,42 @@ Description:
>  		Shows if the partner supports USB Power Delivery communication:
>  		Valid values: yes, no
> =20
> +What:		/sys/class/typec/<port>-partner/product_type
> +Date:		December 2020
> +Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
> +Description:	USB Power Delivery Specification defines a set of product t=
ypes
> +		for the partner devices. This file will show the product type of
> +		the partner if it is known. Dual-role capable partners will have
> +		both UFP and DFP product types defined, but only one that
> +		matches the current role will be active at the time. If the
> +		product type of the partner is not visible to the device driver,
> +		this file will not exist.
> +
> +		When the partner product type is detected, or changed with role
> +		swap, uvevent is also raised that contains PRODUCT_TYPE=3D<product
> +		type> (for example PRODUCT_TYPE=3Dhub).
> +
> +		Valid values:
> +
> +		UFP / device role
> +		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +		undefined		  -
> +		hub			  PDUSB Hub
> +		peripheral		  PDUSB Peripheral
> +		psd			  Power Bank
> +		ama			  Alternate Mode Adapter
> +		vpd			  VCONN Powered USB Device

I have it on good authority that "vpd" is incorrectly categorized here,
and for future proofing, we'd better not introduce vpd as a product
type for UFP...

A vpd is actually more closely related to a "cable" than it is a "UFP."
A closer reading of the USB Type-C and USB PD specs will reveal that
VPDs can only ever appear as SOP' and not as SOP, so having its type
appear under UFP is a mistake.

In other words, the USB PD V3.0 R2.0 spec is wrong. A change has been
working its way through the spec committee to fix this, but it is not yet
published.

In order to reduce the amount of churn, I would recommend not
including vpd as a possible type until a new version of the spec (or the EC=
N)
is published.

Thanks,
Benson

> +		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +
> +		DFP / host role
> +		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +		undefined		  -
> +		hub			  PDUSB Hub
> +		host			  PDUSB Host
> +		power_brick		  Power Brick
> +		amc			  Alternate Mode Controller
> +		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +
>  What:		/sys/class/typec/<port>-partner>/identity/
>  Date:		April 2017
>  Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
> @@ -202,6 +238,25 @@ Description:
>  		- type-c
>  		- captive
> =20
> +What:		/sys/class/typec/<port>-cable/product_type
> +Date:		December 2020
> +Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
> +Description:	USB Power Delivery Specification defines a set of product t=
ypes
> +		for the cables. This file will show the product type of the
> +		cable if it is known. If the product type of the cable is not
> +		visible to the device driver, this file will not exist.
> +
> +		When the cable product type is detected, uvevent is also raised
> +		with PRODUCT_TYPE showing the product type of the cable.
> +
> +		Valid values:
> +
> +		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +		undefined		  -
> +		active			  Active Cable
> +		passive			  Passive Cable
> +		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +
>  What:		/sys/class/typec/<port>-cable/identity/
>  Date:		April 2017
>  Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index 35eec707cb512..303f054181ff7 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -11,6 +11,7 @@
>  #include <linux/mutex.h>
>  #include <linux/property.h>
>  #include <linux/slab.h>
> +#include <linux/usb/pd_vdo.h>
> =20
>  #include "bus.h"
> =20
> @@ -81,6 +82,30 @@ static const char * const typec_accessory_modes[] =3D {
>  	[TYPEC_ACCESSORY_DEBUG]		=3D "debug",
>  };
> =20
> +/* Product types defined in USB PD Specification R3.0 V2.0 */
> +static const char * const product_type_ufp[8] =3D {
> +	[IDH_PTYPE_UNDEF]		=3D "undefined",
> +	[IDH_PTYPE_HUB]			=3D "hub",
> +	[IDH_PTYPE_PERIPH]		=3D "peripheral",
> +	[IDH_PTYPE_PSD]			=3D "psd",
> +	[IDH_PTYPE_AMA]			=3D "ama",
> +	[IDH_PTYPE_VPD]			=3D "vpd",
> +};
> +
> +static const char * const product_type_dfp[8] =3D {
> +	[IDH_PTYPE_DFP_UNDEF]		=3D "undefined",
> +	[IDH_PTYPE_DFP_HUB]		=3D "hub",
> +	[IDH_PTYPE_DFP_HOST]		=3D "host",
> +	[IDH_PTYPE_DFP_PB]		=3D "power_brick",
> +	[IDH_PTYPE_DFP_AMC]		=3D "amc",
> +};
> +
> +static const char * const product_type_cable[8] =3D {
> +	[IDH_PTYPE_UNDEF]		=3D "undefined",
> +	[IDH_PTYPE_PCABLE]		=3D "passive",
> +	[IDH_PTYPE_ACABLE]		=3D "active",
> +};
> +
>  static struct usb_pd_identity *get_pd_identity(struct device *dev)
>  {
>  	if (is_typec_partner(dev)) {
> @@ -95,6 +120,24 @@ static struct usb_pd_identity *get_pd_identity(struct=
 device *dev)
>  	return NULL;
>  }
> =20
> +static const char *get_pd_product_type(struct device *dev)
> +{
> +	struct typec_port *port =3D to_typec_port(dev->parent);
> +	struct usb_pd_identity *id =3D get_pd_identity(dev);
> +	const char *ptype =3D NULL;
> +
> +	if (is_typec_partner(dev)) {
> +		if (port->data_role =3D=3D TYPEC_HOST)
> +			ptype =3D product_type_ufp[PD_IDH_PTYPE(id->id_header)];
> +		else
> +			ptype =3D product_type_dfp[PD_IDH_DFP_PTYPE(id->id_header)];
> +	} else if (is_typec_cable(dev)) {
> +		ptype =3D product_type_cable[PD_IDH_PTYPE(id->id_header)];
> +	}
> +
> +	return ptype;
> +}
> +
>  static ssize_t id_header_show(struct device *dev, struct device_attribut=
e *attr,
>  			      char *buf)
>  {
> @@ -139,11 +182,55 @@ static const struct attribute_group *usb_pd_id_grou=
ps[] =3D {
>  	NULL,
>  };
> =20
> +static void typec_product_type_notify(struct device *dev)
> +{
> +	const char *ptype;
> +	char *envp[2];
> +
> +	ptype =3D get_pd_product_type(dev);
> +	if (!ptype)
> +		return;
> +
> +	sysfs_notify(&dev->kobj, NULL, "product_type");
> +
> +	envp[0] =3D kasprintf(GFP_KERNEL, "PRODUCT_TYPE=3D%s", ptype);
> +	if (!envp[0])
> +		return;
> +
> +	envp[1] =3D NULL;
> +	kobject_uevent_env(&dev->kobj, KOBJ_CHANGE, envp);
> +	kfree(envp[0]);
> +}
> +
>  static void typec_report_identity(struct device *dev)
>  {
>  	sysfs_notify(&dev->kobj, "identity", "id_header");
>  	sysfs_notify(&dev->kobj, "identity", "cert_stat");
>  	sysfs_notify(&dev->kobj, "identity", "product");
> +	typec_product_type_notify(dev);
> +}
> +
> +static ssize_t
> +product_type_show(struct device *dev, struct device_attribute *attr, cha=
r *buf)
> +{
> +	const char *ptype;
> +
> +	ptype =3D get_pd_product_type(dev);
> +	if (!ptype)
> +		return 0;
> +
> +	return sysfs_emit(buf, "%s\n", ptype);
> +}
> +static DEVICE_ATTR_RO(product_type);
> +
> +static umode_t typec_product_type_attr_is_visible(struct kobject *kobj,
> +						  struct attribute *attr, int n)
> +{
> +	if (attr =3D=3D &dev_attr_product_type.attr)
> +		if (!get_pd_identity(kobj_to_dev(kobj)))
> +			return 0;
> +
> +	return attr->mode;
>  }
> =20
>  /* ---------------------------------------------------------------------=
---- */
> @@ -534,10 +621,20 @@ static DEVICE_ATTR_RO(supports_usb_power_delivery);
> =20
>  static struct attribute *typec_partner_attrs[] =3D {
>  	&dev_attr_accessory_mode.attr,
> +	&dev_attr_product_type.attr,
>  	&dev_attr_supports_usb_power_delivery.attr,
>  	NULL
>  };
> -ATTRIBUTE_GROUPS(typec_partner);
> +
> +static struct attribute_group typec_partner_group =3D {
> +	.is_visible =3D typec_product_type_attr_is_visible,
> +	.attrs =3D typec_partner_attrs,
> +};
> +
> +static const struct attribute_group *typec_partner_groups[] =3D {
> +	&typec_partner_group,
> +	NULL
> +};
> =20
>  static void typec_partner_release(struct device *dev)
>  {
> @@ -773,9 +870,19 @@ static DEVICE_ATTR_RO(plug_type);
>  static struct attribute *typec_cable_attrs[] =3D {
>  	&dev_attr_type.attr,
>  	&dev_attr_plug_type.attr,
> +	&dev_attr_product_type.attr,
> +	NULL
> +};
> +
> +static struct attribute_group typec_cable_group =3D {
> +	.is_visible =3D typec_product_type_attr_is_visible,
> +	.attrs =3D typec_cable_attrs,
> +};
> +
> +static const struct attribute_group *typec_cable_groups[] =3D {
> +	&typec_cable_group,
>  	NULL
>  };
> -ATTRIBUTE_GROUPS(typec_cable);
> =20
>  static void typec_cable_release(struct device *dev)
>  {
> @@ -1352,6 +1459,11 @@ const struct device_type typec_port_dev_type =3D {
>  /* --------------------------------------- */
>  /* Driver callbacks to report role updates */
> =20
> +static int partner_match(struct device *dev, void *data)
> +{
> +	return is_typec_partner(dev);
> +}
> +
>  /**
>   * typec_set_data_role - Report data role change
>   * @port: The USB Type-C Port where the role was changed
> @@ -1361,12 +1473,23 @@ const struct device_type typec_port_dev_type =3D {
>   */
>  void typec_set_data_role(struct typec_port *port, enum typec_data_role r=
ole)
>  {
> +	struct device *partner_dev;
> +
>  	if (port->data_role =3D=3D role)
>  		return;
> =20
>  	port->data_role =3D role;
>  	sysfs_notify(&port->dev.kobj, NULL, "data_role");
>  	kobject_uevent(&port->dev.kobj, KOBJ_CHANGE);
> +
> +	partner_dev =3D device_find_child(&port->dev, NULL, partner_match);
> +	if (!partner_dev)
> +		return;
> +
> +	if (to_typec_partner(partner_dev)->identity)
> +		typec_product_type_notify(partner_dev);
> +
> +	put_device(partner_dev);
>  }
>  EXPORT_SYMBOL_GPL(typec_set_data_role);
> =20
> @@ -1407,11 +1530,6 @@ void typec_set_vconn_role(struct typec_port *port,=
 enum typec_role role)
>  }
>  EXPORT_SYMBOL_GPL(typec_set_vconn_role);
> =20
> -static int partner_match(struct device *dev, void *data)
> -{
> -	return is_typec_partner(dev);
> -}
> -
>  /**
>   * typec_set_pwr_opmode - Report changed power operation mode
>   * @port: The USB Type-C Port where the mode was changed
> --=20
> 2.29.2
>=20

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCX7VeZQAKCRBzbaomhzOw
wo0iAP9EGBs3R438FkkgSOeUx3Elr6+n6K0WYsAHvEsyCZDgtQEA8N27j2fJ+l6U
JDjjWudtZiDPgLTfzbkx1S8Ny0yO8QM=
=OExU
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
