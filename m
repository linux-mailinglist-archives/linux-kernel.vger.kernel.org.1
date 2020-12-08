Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 632242D27DB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 10:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbgLHJjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 04:39:25 -0500
Received: from mga01.intel.com ([192.55.52.88]:3517 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727831AbgLHJjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 04:39:24 -0500
IronPort-SDR: RJGCzVcAxNlQricLjz/DfdP+9ItWBjQ4wrobbJRprvRGrx6Laaip7Yanyb3ViB2JHe6VI87AF7
 xvzf09HF7KOw==
X-IronPort-AV: E=McAfee;i="6000,8403,9828"; a="192145328"
X-IronPort-AV: E=Sophos;i="5.78,402,1599548400"; 
   d="scan'208";a="192145328"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 01:37:37 -0800
IronPort-SDR: ZLLqWybu4KNlwT0nEra2KW9AAi9SfnFfqpqzXJdn+3aobKyzkNBm4nS7myaqwoGh6IiPV0zit4
 L+35aKnD+L+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,402,1599548400"; 
   d="scan'208";a="437320455"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 08 Dec 2020 01:37:35 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 08 Dec 2020 11:37:34 +0200
Date:   Tue, 8 Dec 2020 11:37:34 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-usb@vger.kernel.org, gregkh@linuxfoundation.org,
        bleung@chromium.org, Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: typec: Add bus type for plug alt modes
Message-ID: <20201208093734.GD680328@kuha.fi.intel.com>
References: <20201203030846.51669-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203030846.51669-1-pmalani@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 07:08:47PM -0800, Prashant Malani wrote:
> Add the Type C bus for plug alternate modes which are being
> registered via the Type C connector class. This ensures that udev events
> get generated when plug alternate modes are registered (and not just for
> partner/port alternate modes), even though the Type C bus doesn't link
> plug alternate mode devices to alternate mode drivers.

I still don't understand how is the uevent related to the bus? If you
check the device_add() function, on line 2917, kobject_uevent() is
called unconditionally. The device does not need a bus for that event
to be generated.

Also, I don't understand how are the cable plug alt modes now
prevented from being bind to the alt mode drivers?

> Update the Type C bus documentation to mention that there
> are alternate mode devices for plugs as well.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  Documentation/driver-api/usb/typec_bus.rst | 6 +++---
>  drivers/usb/typec/class.c                  | 8 ++++++--
>  2 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/driver-api/usb/typec_bus.rst b/Documentation/driver-api/usb/typec_bus.rst
> index 21c890ae17e5..7874d2f37d9f 100644
> --- a/Documentation/driver-api/usb/typec_bus.rst
> +++ b/Documentation/driver-api/usb/typec_bus.rst
> @@ -15,9 +15,9 @@ modes by using the SVID and the mode number.
>  
>  :ref:`USB Type-C Connector Class <typec>` provides a device for every alternate
>  mode a port supports, and separate device for every alternate mode the partner
> -supports. The drivers for the alternate modes are bound to the partner alternate
> -mode devices, and the port alternate mode devices must be handled by the port
> -drivers.
> +or cable plug supports. The drivers for the alternate modes are bound to the
> +partner alternate mode devices, and the port alternate mode devices must be
> +handled by the port drivers.
>  
>  When a new partner alternate mode device is registered, it is linked to the
>  alternate mode device of the port that the partner is attached to, that has
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index 35eec707cb51..74061a699f16 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -478,8 +478,12 @@ typec_register_altmode(struct device *parent,
>  	if (!is_port)
>  		typec_altmode_set_partner(alt);
>  
> -	/* The partners are bind to drivers */
> -	if (is_typec_partner(parent))
> +	/*
> +	 * The partners are bind to drivers.
> +	 * Also set the bus field for plug alt modes so that the udev event occurs on device
> +	 * registration.
> +	 */
> +	if (is_typec_partner(parent) || is_typec_plug(parent))
>  		alt->adev.dev.bus = &typec_bus;
>  
>  	ret = device_register(&alt->adev.dev);
> -- 
> 2.29.2.454.gaff20da3a2-goog

thanks,

-- 
heikki
