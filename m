Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5713B2AD425
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 11:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729944AbgKJKwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 05:52:32 -0500
Received: from mga09.intel.com ([134.134.136.24]:58841 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbgKJKwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 05:52:31 -0500
IronPort-SDR: VXza8AhYx6a0yW0Z27G1psAAYCH2yl/8cbZc0qFe1A876ldryxMryfYuyAGN99T3nakQRy/88L
 uqWgKxOpzgPA==
X-IronPort-AV: E=McAfee;i="6000,8403,9800"; a="170106594"
X-IronPort-AV: E=Sophos;i="5.77,466,1596524400"; 
   d="scan'208";a="170106594"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 02:52:30 -0800
IronPort-SDR: qhGvdzwyj36pXd7OS41zJ5CU9vhv55PM3S53ZpIcWYG7eyDm13UFaCKqFLEiPhkJCxSrmOTRBu
 ke4qMD3u4uqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,466,1596524400"; 
   d="scan'208";a="428326157"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 10 Nov 2020 02:52:25 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 10 Nov 2020 12:52:25 +0200
Date:   Tue, 10 Nov 2020 12:52:25 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v3 1/2] usb: typec: Consolidate syfs ABI documentation
Message-ID: <20201110105225.GH1224435@kuha.fi.intel.com>
References: <20201023214328.1262883-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201023214328.1262883-1-pmalani@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 23, 2020 at 02:43:26PM -0700, Prashant Malani wrote:
> Both partner and cable have identity VDOs. These are listed separately
> in the Documentation/ABI/testing/sysfs-class-typec. Factor these out
> into a common location to avoid the duplication.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

I don't have a problem with this change. FWIW:

Acked-by: Heikki Krogerus <heikki.krogeurus@linux.intel.com>

> ---
> 
> Patch first introduced in v3.
> 
>  Documentation/ABI/testing/sysfs-class-typec | 59 ++++++---------------
>  1 file changed, 17 insertions(+), 42 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-typec b/Documentation/ABI/testing/sysfs-class-typec
> index b834671522d6..0f839fd022f1 100644
> --- a/Documentation/ABI/testing/sysfs-class-typec
> +++ b/Documentation/ABI/testing/sysfs-class-typec
> @@ -134,42 +134,6 @@ Description:
>  		Shows if the partner supports USB Power Delivery communication:
>  		Valid values: yes, no
>  
> -What:		/sys/class/typec/<port>-partner>/identity/
> -Date:		April 2017
> -Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
> -Description:
> -		This directory appears only if the port device driver is capable
> -		of showing the result of Discover Identity USB power delivery
> -		command. That will not always be possible even when USB power
> -		delivery is supported, for example when USB power delivery
> -		communication for the port is mostly handled in firmware. If the
> -		directory exists, it will have an attribute file for every VDO
> -		in Discover Identity command result.
> -
> -What:		/sys/class/typec/<port>-partner/identity/id_header
> -Date:		April 2017
> -Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
> -Description:
> -		ID Header VDO part of Discover Identity command result. The
> -		value will show 0 until Discover Identity command result becomes
> -		available. The value can be polled.
> -
> -What:		/sys/class/typec/<port>-partner/identity/cert_stat
> -Date:		April 2017
> -Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
> -Description:
> -		Cert Stat VDO part of Discover Identity command result. The
> -		value will show 0 until Discover Identity command result becomes
> -		available. The value can be polled.
> -
> -What:		/sys/class/typec/<port>-partner/identity/product
> -Date:		April 2017
> -Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
> -Description:
> -		Product VDO part of Discover Identity command result. The value
> -		will show 0 until Discover Identity command result becomes
> -		available. The value can be polled.
> -
>  
>  USB Type-C cable devices (eg. /sys/class/typec/port0-cable/)
>  
> @@ -196,17 +160,28 @@ Description:
>  		- type-c
>  		- captive
>  
> -What:		/sys/class/typec/<port>-cable/identity/
> +
> +USB Type-C partner/cable Power Delivery Identity objects
> +
> +NOTE: The following attributes will be applicable to both
> +partner (e.g /sys/class/typec/port0-partner/) and
> +cable (e.g /sys/class/typec/port0-cable/) devices. Consequently, the example file
> +paths below are prefixed with "/sys/class/typec/<port>-{partner|cable}/" to
> +reflect this.
> +
> +What:		/sys/class/typec/<port>-{partner|cable}/identity/
>  Date:		April 2017
>  Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
>  Description:
>  		This directory appears only if the port device driver is capable
>  		of showing the result of Discover Identity USB power delivery
>  		command. That will not always be possible even when USB power
> -		delivery is supported. If the directory exists, it will have an
> -		attribute for every VDO returned by Discover Identity command.
> +		delivery is supported, for example when USB power delivery
> +		communication for the port is mostly handled in firmware. If the
> +		directory exists, it will have an attribute file for every VDO
> +		in Discover Identity command result.
>  
> -What:		/sys/class/typec/<port>-cable/identity/id_header
> +What:		/sys/class/typec/<port>-{partner|cable}/identity/id_header
>  Date:		April 2017
>  Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
>  Description:
> @@ -214,7 +189,7 @@ Description:
>  		value will show 0 until Discover Identity command result becomes
>  		available. The value can be polled.
>  
> -What:		/sys/class/typec/<port>-cable/identity/cert_stat
> +What:		/sys/class/typec/<port>-{partner|cable}/identity/cert_stat
>  Date:		April 2017
>  Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
>  Description:
> @@ -222,7 +197,7 @@ Description:
>  		value will show 0 until Discover Identity command result becomes
>  		available. The value can be polled.
>  
> -What:		/sys/class/typec/<port>-cable/identity/product
> +What:		/sys/class/typec/<port>-{partner|cable}/identity/product
>  Date:		April 2017
>  Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
>  Description:
> -- 
> 2.29.0.rc1.297.gfa9743e501-goog

thanks,

-- 
heikki
