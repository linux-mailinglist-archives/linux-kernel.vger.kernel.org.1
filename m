Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 430462A02F4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 11:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgJ3KeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 06:34:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:60480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbgJ3KeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 06:34:00 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCE2520704;
        Fri, 30 Oct 2020 10:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604054039;
        bh=32k8pChigVQ1LBKD5dDPr5PYYPxaZv+rpoCaUkfIEyw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qIWKLH8GdD0RLyYzMu82nD5JHOcP5G2efrgItv6kXyPpajBMhA+4isW0MYZ8DR3eC
         xRuR1YefJU1UU2u+iJnu5ArmPpMEmdUZP78BJsuMgr1rx0h7Ehe6MjsZQhxCpDSfwV
         DuNS98iNldkfXzbRjSopvkYGKx8oVX7dhlLsbV34=
Date:   Fri, 30 Oct 2020 11:34:47 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Benson Leung <bleung@chromium.org>
Cc:     heikki.krogerus@linux.intel.com, bleung@kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmalani@chromium.org, bleung@google.com
Subject: Re: [PATCH] typec: Provide USB PD Specification Revision for cable
 and partner
Message-ID: <20201030103447.GA2195676@kroah.com>
References: <20201030044224.GA1269490@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201030044224.GA1269490@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 09:42:24PM -0700, Benson Leung wrote:
> The USB Power Delivery specification Section 6.2.1.1.5 outlines
> revision backward compatibility requirements starting from Revision 3.0.
> 
> The Port, the Cable Plug, and the Port Partner may support either revision
> 2 or revision 3 individually, and communication between ports, partners,
> and cables of different revisions are allowed under rules that the parties
> agree to communicate between each other using the lowest common operating
> revision.
> 
> This may mean that Port-to-Port operating revision comms may be different
> than Port-to-CablePlug operating revision comms. For example, it is
> possible for a R3.0 port to communicate with a R3.0 cable using R3.0
> messages, while the R3.0 port (in the same session) must communicate with
> a R2.0 partner using PD R2.0 messages only.
> 
> This change will introduce individual revision number tracking for cable
> and port partner so that the port can track them independently.
> 
> This will also enable future changes which change cable identifier
> decoding and visible sysfs nodes based on revision 2 or 3.
> 
> Signed-off-by: Benson Leung <bleung@chromium.org>
> ---
>  Documentation/ABI/testing/sysfs-class-typec |  8 +++++
>  drivers/usb/typec/class.c                   | 38 +++++++++++++++------
>  include/linux/usb/typec.h                   | 10 ++++++
>  3 files changed, 46 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-typec b/Documentation/ABI/testing/sysfs-class-typec
> index b834671522d6..740b226bb80e 100644
> --- a/Documentation/ABI/testing/sysfs-class-typec
> +++ b/Documentation/ABI/testing/sysfs-class-typec
> @@ -102,6 +102,14 @@ Description:
>  		Revision number of the supported USB Power Delivery
>  		specification, or 0 when USB Power Delivery is not supported.
>  
> +What:		/sys/class/typec/<port>-{partner|cable}/usb_power_delivery_revision
> +Date:		October 2020
> +Contact:	Benson Leung <bleung@chromium.org>
> +Description:
> +		Revision number of the supported USB Power Delivery
> +		specification of the port partner or cable, or 0 when USB Power
> +		Delivery is not supported.
> +
>  What:		/sys/class/typec/<port>/usb_typec_revision
>  Date:		April 2017
>  Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index 35eec707cb51..abae4cbe66d5 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -25,6 +25,7 @@ struct typec_cable {
>  	enum typec_plug_type		type;
>  	struct usb_pd_identity		*identity;
>  	unsigned int			active:1;
> +	u16				pd_revision; /* 0300H = "3.0" */
>  };
>  
>  struct typec_partner {
> @@ -33,6 +34,7 @@ struct typec_partner {
>  	struct usb_pd_identity		*identity;
>  	enum typec_accessory		accessory;
>  	struct ida			mode_ids;
> +	u16				pd_revision; /* 0300H = "3.0" */
>  };
>  
>  struct typec_port {
> @@ -146,6 +148,28 @@ static void typec_report_identity(struct device *dev)
>  	sysfs_notify(&dev->kobj, "identity", "product");
>  }
>  
> +static ssize_t usb_power_delivery_revision_show(struct device *dev,
> +						struct device_attribute *attr,
> +						char *buf)
> +{
> +	if (is_typec_partner(dev)) {
> +		struct typec_partner *partner = to_typec_partner(dev);
> +
> +		return sprintf(buf, "%d\n", (partner->pd_revision >> 8) & 0xff);
> +	} else if (is_typec_cable(dev)) {
> +		struct typec_cable *cable = to_typec_cable(dev);
> +
> +		return sprintf(buf, "%d\n", (cable->pd_revision >> 8) & 0xff);
> +	} else if (is_typec_port(dev)) {
> +		struct typec_port *p = to_typec_port(dev);
> +
> +		return sprintf(buf, "%d\n", (p->cap->pd_revision >> 8) & 0xff);

nit, you can use sysfs_emit() for the sprintf() calls in sysfs
attributes now.

> +	}
> +}
> +static DEVICE_ATTR_RO(usb_power_delivery_revision);
> +
> +
> +

2 extra blank lines are not needed :(

>  /* ------------------------------------------------------------------------- */
>  /* Alternate Modes */
>  
> @@ -535,6 +559,7 @@ static DEVICE_ATTR_RO(supports_usb_power_delivery);
>  static struct attribute *typec_partner_attrs[] = {
>  	&dev_attr_accessory_mode.attr,
>  	&dev_attr_supports_usb_power_delivery.attr,
> +	&dev_attr_usb_power_delivery_revision.attr,
>  	NULL
>  };
>  ATTRIBUTE_GROUPS(typec_partner);
> @@ -612,6 +637,7 @@ struct typec_partner *typec_register_partner(struct typec_port *port,
>  	ida_init(&partner->mode_ids);
>  	partner->usb_pd = desc->usb_pd;
>  	partner->accessory = desc->accessory;
> +	partner->pd_revision = desc->pd_revision;
>  
>  	if (desc->identity) {
>  		/*
> @@ -773,6 +799,7 @@ static DEVICE_ATTR_RO(plug_type);
>  static struct attribute *typec_cable_attrs[] = {
>  	&dev_attr_type.attr,
>  	&dev_attr_plug_type.attr,
> +	&dev_attr_usb_power_delivery_revision.attr,
>  	NULL
>  };
>  ATTRIBUTE_GROUPS(typec_cable);
> @@ -875,6 +902,7 @@ struct typec_cable *typec_register_cable(struct typec_port *port,
>  
>  	cable->type = desc->type;
>  	cable->active = desc->active;
> +	cable->pd_revision = desc->pd_revision;
>  
>  	if (desc->identity) {
>  		/*
> @@ -1240,16 +1268,6 @@ static ssize_t usb_typec_revision_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(usb_typec_revision);
>  
> -static ssize_t usb_power_delivery_revision_show(struct device *dev,
> -						struct device_attribute *attr,
> -						char *buf)
> -{
> -	struct typec_port *p = to_typec_port(dev);
> -
> -	return sprintf(buf, "%d\n", (p->cap->pd_revision >> 8) & 0xff);
> -}
> -static DEVICE_ATTR_RO(usb_power_delivery_revision);
> -
>  static ssize_t orientation_show(struct device *dev,
>  				   struct device_attribute *attr,
>  				   char *buf)
> diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
> index 6be558045942..2306d40e18a1 100644
> --- a/include/linux/usb/typec.h
> +++ b/include/linux/usb/typec.h
> @@ -162,6 +162,7 @@ struct typec_plug_desc {
>   * @type: The plug type from USB PD Cable VDO
>   * @active: Is the cable active or passive
>   * @identity: Result of Discover Identity command
> + * @pd_revision: USB Power Delivery Specification revision if supported
>   *
>   * Represents USB Type-C Cable attached to USB Type-C port.
>   */
> @@ -169,6 +170,8 @@ struct typec_cable_desc {
>  	enum typec_plug_type	type;
>  	unsigned int		active:1;
>  	struct usb_pd_identity	*identity;
> +	u16			pd_revision; /* 0300H = "3.0" */
> +
>  };
>  
>  /*
> @@ -176,15 +179,22 @@ struct typec_cable_desc {
>   * @usb_pd: USB Power Delivery support
>   * @accessory: Audio, Debug or none.
>   * @identity: Discover Identity command data
> + * @pd_revision: USB Power Delivery Specification Revision if supported
>   *
>   * Details about a partner that is attached to USB Type-C port. If @identity
>   * member exists when partner is registered, a directory named "identity" is
>   * created to sysfs for the partner device.
> + *
> + * @pd_revision is based on the setting of the "Specification Revision" field
> + * in the message header on the initial "Source Capabilities" message receieved
> + * from the partner, or a "Request" message received from the partner, depending
> + * on whether our port is a Sink or a Source.
>   */
>  struct typec_partner_desc {
>  	unsigned int		usb_pd:1;
>  	enum typec_accessory	accessory;
>  	struct usb_pd_identity	*identity;
> +	u16			pd_revision; /* 0300H = "3.0" */

No endian issues?  Where are you reading this data from?  How is it in
"native cpu" endian already?

thanks,

greg k-h
