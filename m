Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAAC82D71E1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 09:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405548AbgLKIfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 03:35:48 -0500
Received: from mga18.intel.com ([134.134.136.126]:51781 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404032AbgLKIfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 03:35:06 -0500
IronPort-SDR: EHSe+FZHmLUjP8GSvTKne53i/yx7961yx1IYeEwNVsfJdsNRIYvUuvTbMpSTevVg1Cv3FOT3hc
 d2amAz+BatEw==
X-IronPort-AV: E=McAfee;i="6000,8403,9831"; a="162155225"
X-IronPort-AV: E=Sophos;i="5.78,410,1599548400"; 
   d="scan'208";a="162155225"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2020 00:33:18 -0800
IronPort-SDR: azO873SVSmNgTMKSAOmIanDhqmBW66vL+2M1QiwJqXjIoQxv2UQ/Ouu+RbAJ19QBHTGoKOoRgm
 GsUhCkNP3rMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,410,1599548400"; 
   d="scan'208";a="440614488"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 11 Dec 2020 00:33:15 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 11 Dec 2020 10:33:15 +0200
Date:   Fri, 11 Dec 2020 10:33:15 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-usb@vger.kernel.org, gregkh@linuxfoundation.org,
        bleung@chromium.org, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] usb: typec: Add class for plug alt mode device
Message-ID: <20201211083315.GE1594451@kuha.fi.intel.com>
References: <20201210211653.879044-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210211653.879044-1-pmalani@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 01:16:54PM -0800, Prashant Malani wrote:
> Add the Type C class for plug alternate mode devices which are being
> registered by the Type C connector class. This ensures that udev events
> get generated when the plug alt modes are registered.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> 
> Changes in v2:
> - Changed code to set the class member instead of bus.
> - Removed the alteration to typec_bus.rst since it's not longer
>   required.
> - Updated the commit message and subject to reflect the change in code.
> 
> v1: https://lore.kernel.org/linux-usb/20201203030846.51669-1-pmalani@chromium.org/
> 
>  drivers/usb/typec/class.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index 35eec707cb51..29d05b45cc9d 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -482,6 +482,10 @@ typec_register_altmode(struct device *parent,
>  	if (is_typec_partner(parent))
>  		alt->adev.dev.bus = &typec_bus;
>  
> +	/* Plug alt modes need a class to generate udev events. */
> +	if (is_typec_plug(parent))
> +		alt->adev.dev.class = typec_class;
> +
>  	ret = device_register(&alt->adev.dev);
>  	if (ret) {
>  		dev_err(parent, "failed to register alternate mode (%d)\n",
> -- 
> 2.29.2.576.ga3fc446d84-goog

thanks,

-- 
heikki
