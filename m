Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EACC72B8432
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 19:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbgKRSxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 13:53:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbgKRSxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 13:53:52 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A1BC0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 10:53:52 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id kk16so867949pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 10:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/EQtQALhCEqfL4DGAhnne0Mwd7FFhtVFNWFyL4AwZ5c=;
        b=KZojK7bEWDx5hLzKhd5MrNlmQvCB68Xnk6S2Q6YCJSkfRUARg97yNUwy03/QvCfMe+
         mcVZJOV1aImmFjNLZVPIu2YiNhBRbIWf/3JNg2ScWbszzsK/ifIpFhiGhUdKBsLPU0WV
         Xb2Wdc2pde+TVtwNHnqBsVcPxhZdVFoqMwdrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/EQtQALhCEqfL4DGAhnne0Mwd7FFhtVFNWFyL4AwZ5c=;
        b=E3GLYXL+S8RsVvAn2JVeA1MvPpJXCRXWkHQVnyPfUXdCwQjIb08bgociQSUL3ZO3Yu
         LaKfVcxqcLpLJzk1/j8FGy7vT/NkjomLcwgVDF0ySnfJeBEYaXfnfjc2C7wMn7NpmhPz
         RkZtL/R0v8xw6cLoKB19W5lly1TWVt0bowI+rVTU+msGaARdTq4SLxRiAGZTByEkHutQ
         wG0uZGGo0ls7WceTfvO1FrCrdw6bwcXFnGm4rqzHl5AVEMQCZkA8+IBcNSN7/aPdUtsO
         613bUr4GeTTCbOY5AjftpJNJYM00oyoyu3jCR6CgZv5I8VWuIX5I7nz0fIyi9snCtvti
         cCYQ==
X-Gm-Message-State: AOAM530JM/Kz7BETtHZLmUQIud4dKEvb6EEHY6J1jNzrxDOvchRagL5j
        ZBp5gvp0jLKtEzr1cn5F5lq2nw==
X-Google-Smtp-Source: ABdhPJw6gBV4r3Dwt4GFOmQuwUSgdqPlrkxHZck4DPp8tMoFpnM+59r0F5fRgJ+zWjgMqw5mWHBv8Q==
X-Received: by 2002:a17:90b:3512:: with SMTP id ls18mr473430pjb.70.1605725632000;
        Wed, 18 Nov 2020 10:53:52 -0800 (PST)
Received: from google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id t9sm3277973pjo.4.2020.11.18.10.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 10:53:51 -0800 (PST)
Date:   Wed, 18 Nov 2020 10:53:50 -0800
From:   Prashant Malani <pmalani@chromium.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Benson Leung <bleung@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [RFC PATCH 2/3] usb: typec: Add product_type sysfs attribute
 file for partners and cables
Message-ID: <20201118185350.GB3652649@google.com>
References: <20201118150059.3419-1-heikki.krogerus@linux.intel.com>
 <20201118150059.3419-3-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118150059.3419-3-heikki.krogerus@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heikki,

On Wed, Nov 18, 2020 at 06:00:58PM +0300, Heikki Krogerus wrote:
> USB Power Delivery Specification defines a set of product
> types for partners and cables. The product type is defined
> in the ID Header VDO, which is the first object in the
> response to the Discover Identity command.
> 
> This sysfs attribute file is only created for the partners
> and cables if the product type is really known in the
> driver. Some interfaces do not give access to the Discover
> Identity response from the partner or cable, but they may
> still supply the product type separately in some cases.
> 
> When the product type of the partner or cable is detected,
> uevent is also raised with PRODUCT_TYPE set to show the
> actual product type (for example PRODUCT_TYPE=host).
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

I tried this out with the following peripherals:
- Thunderbolt 3 active cable.
- Thunderbolt 3 passive cable.
- Dell WD19TB dock.
- Type C DisplayPort enabled monitor (which advertises as AMA).

For the above, the product_type seems to be getting parsed and displayed
correctly, so FWIW:

Tested-by: Prashant Malani <pmalani@chromium.org>

> ---
>  Documentation/ABI/testing/sysfs-class-typec |  55 ++++++++
>  drivers/usb/typec/class.c                   | 132 ++++++++++++++++++--
>  2 files changed, 180 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-typec b/Documentation/ABI/testing/sysfs-class-typec
> index b7794e02ad205..4c09e327c62be 100644
> --- a/Documentation/ABI/testing/sysfs-class-typec
> +++ b/Documentation/ABI/testing/sysfs-class-typec
> @@ -139,6 +139,42 @@ Description:
>  		Shows if the partner supports USB Power Delivery communication:
>  		Valid values: yes, no
>  
> +What:		/sys/class/typec/<port>-partner/product_type
> +Date:		December 2020
> +Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
> +Description:	USB Power Delivery Specification defines a set of product types
> +		for the partner devices. This file will show the product type of
> +		the partner if it is known. Dual-role capable partners will have
> +		both UFP and DFP product types defined, but only one that
> +		matches the current role will be active at the time. If the
> +		product type of the partner is not visible to the device driver,
> +		this file will not exist.
> +
> +		When the partner product type is detected, or changed with role
> +		swap, uvevent is also raised that contains PRODUCT_TYPE=<product
> +		type> (for example PRODUCT_TYPE=hub).
> +
> +		Valid values:
> +
> +		UFP / device role
> +		========================  ==========================
> +		undefined		  -
> +		hub			  PDUSB Hub
> +		peripheral		  PDUSB Peripheral
> +		psd			  Power Bank
> +		ama			  Alternate Mode Adapter
> +		vpd			  VCONN Powered USB Device
> +		========================  ==========================
> +
> +		DFP / host role
> +		========================  ==========================
> +		undefined		  -
> +		hub			  PDUSB Hub
> +		host			  PDUSB Host
> +		power_brick		  Power Brick
> +		amc			  Alternate Mode Controller
> +		========================  ==========================
> +
>  What:		/sys/class/typec/<port>-partner>/identity/
>  Date:		April 2017
>  Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
> @@ -202,6 +238,25 @@ Description:
>  		- type-c
>  		- captive
>  
> +What:		/sys/class/typec/<port>-cable/product_type
> +Date:		December 2020
> +Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
> +Description:	USB Power Delivery Specification defines a set of product types
> +		for the cables. This file will show the product type of the
> +		cable if it is known. If the product type of the cable is not
> +		visible to the device driver, this file will not exist.
> +
> +		When the cable product type is detected, uvevent is also raised
> +		with PRODUCT_TYPE showing the product type of the cable.
> +
> +		Valid values:
> +
> +		========================  ==========================
> +		undefined		  -
> +		active			  Active Cable
> +		passive			  Passive Cable
> +		========================  ==========================

There exists a /sys/class/typec/<port>-cable/type attribute (connected
to the "active" field in struct typec_cable [1]), which is supposed
to be populated by the Type C port driver. Won't the newly introduced
attribute duplicate the same information as "type"?

[1]
https://elixir.bootlin.com/linux/v5.10-rc4/source/include/linux/usb/typec.h#L170

Thanks,

-Prashant
