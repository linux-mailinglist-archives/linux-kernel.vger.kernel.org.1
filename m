Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 344DB2B814B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 17:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbgKRP4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 10:56:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:51424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726920AbgKRP4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 10:56:14 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF366247B8;
        Wed, 18 Nov 2020 15:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1605714972;
        bh=GELHucXkKa7G3QtQ8cSbwCgNnr50MKNdiCNGTna4zK0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p/2grwt89tBSwFvd8T1v6y71xnlybjf5sHdsiy2umfiSBcDmbfB9W081S9dnG917+
         haJTt4lD9S4ylXS0lhM+8WH0Gt5Je2atuYkuWbL9GgnJjTgTGIoku8GXX4WqSmiC32
         9xwoR+6TeyJv5v/xCCufP08cF0TwWHDWY/bzh+t0=
Date:   Wed, 18 Nov 2020 16:56:57 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [RFC PATCH 3/3] usb: typec: Expose Product Type VDOs via sysfs
Message-ID: <X7VESebL4CnS45hv@kroah.com>
References: <20201118150059.3419-1-heikki.krogerus@linux.intel.com>
 <20201118150059.3419-4-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118150059.3419-4-heikki.krogerus@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 06:00:59PM +0300, Heikki Krogerus wrote:
> From: Prashant Malani <pmalani@chromium.org>
> 
> Interim. ABI doc missing.
> 
> A PD-capable device can return up to 3 Product Type VDOs as part of its
> DiscoverIdentity Response (USB PD Spec, Rev 3.0, Version 2.0, Section
> 6.4.4.3.1). Add sysfs attribute to expose these to userspace.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> [ heikki: Only one instead of three attribute files ]
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>'
> ---
>  drivers/usb/typec/class.c | 41 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index 303f054181ff7..5e135678f5952 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -165,15 +165,55 @@ static ssize_t product_show(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RO(product);
>  
> +static ssize_t
> +product_type_vdo_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct usb_pd_identity *id = get_pd_identity(dev);
> +	size_t len = 0;
> +	int i;
> +
> +	for (i = 0; i < 3; i++) {
> +		if (!id->vdo[i])
> +			break;
> +		len += sysfs_emit(buf, "%08x ", id->vdo[i]);
> +	}
> +
> +	buf[len - 1] = '\n';
> +
> +	return len;
> +}

I don't understand what you are trying to print out here, documentation
would be helpful :)

> +
> +static struct device_attribute dev_attr_product_type_vdo = {
> +	.attr = {
> +		.name = "product_type",
> +		.mode = 0444,
> +	},
> +	.show = product_type_vdo_show,
> +};

DEVICE_ATTR_RO(product_type_vdo)?

Why are you calling it "product_type" and not with the "vdo"?

And you have to name it this, there's always __ATTR_RO(), never put a
mode in "raw" numbers for a sysfs file if at all possible.

thanks,

greg k-h
