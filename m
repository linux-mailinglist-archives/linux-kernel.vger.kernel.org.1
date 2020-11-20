Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B75A2BA340
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 08:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbgKTHcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 02:32:07 -0500
Received: from mga11.intel.com ([192.55.52.93]:57306 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbgKTHcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 02:32:06 -0500
IronPort-SDR: m2eJSOAYTOqwhStd0Ig++wVXNZy+In9J+KIf9KxV+bFjeGUE8w2unBrsFP/30pPF7MoSdbMcc5
 CfTDQLyp5VXA==
X-IronPort-AV: E=McAfee;i="6000,8403,9810"; a="167919019"
X-IronPort-AV: E=Sophos;i="5.78,355,1599548400"; 
   d="scan'208";a="167919019"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 23:32:06 -0800
IronPort-SDR: ULJnjNKfCKziAeKfcCmRHq72FkOG0Rr7/LX1SpEwVx69d0kes8bHHHJvwzdsEqPzZjMeIR53gs
 /K3WZlOJ78tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,355,1599548400"; 
   d="scan'208";a="431495180"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 19 Nov 2020 23:32:03 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 20 Nov 2020 09:32:01 +0200
Date:   Fri, 20 Nov 2020 09:32:01 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Keith Short <keithshort@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: Tolerate unrecognized
 mux flags
Message-ID: <20201120073201.GA4120550@kuha.fi.intel.com>
References: <20201106020305.767202-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106020305.767202-1-pmalani@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 05, 2020 at 06:03:05PM -0800, Prashant Malani wrote:
> On occasion, the Chrome Embedded Controller (EC) can send a mux
> configuration which doesn't map to a particular data mode. For instance,
> dedicated Type C chargers, when connected, may cause only
> USB_PD_MUX_POLARITY_INVERTED to be set. This is a valid flag combination
> and should not lead to a driver abort.
> 
> Modify the mux configuration handling to not return an error when an
> unrecognized mux flag combination is encountered. Concordantly, make the
> ensuing print a debug level print so as to not pollute the kernel logs.
> 
> Cc: Keith Short <keithshort@chromium.org>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

FWIW:

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/platform/chrome/cros_ec_typec.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index ce031a10eb1b..5b8db02ab84a 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -537,10 +537,9 @@ static int cros_typec_configure_mux(struct cros_typec_data *typec, int port_num,
>  		port->state.mode = TYPEC_STATE_USB;
>  		ret = typec_mux_set(port->mux, &port->state);
>  	} else {
> -		dev_info(typec->dev,
> -			 "Unsupported mode requested, mux flags: %x\n",
> -			 mux_flags);
> -		ret = -ENOTSUPP;
> +		dev_dbg(typec->dev,
> +			"Unrecognized mode requested, mux flags: %x\n",
> +			mux_flags);
>  	}
>  
>  	return ret;
> -- 
> 2.29.1.341.ge80a0c044ae-goog

thanks,

-- 
heikki
