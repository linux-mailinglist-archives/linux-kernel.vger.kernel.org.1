Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B58CA2AD41D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 11:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731114AbgKJKuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 05:50:19 -0500
Received: from mga04.intel.com ([192.55.52.120]:5635 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730751AbgKJKuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 05:50:19 -0500
IronPort-SDR: F6ozJGXUHb8OME3pEgKX7c3SqtaAl1i02/XeUyxJy+bIpblflpMTr7wVL8aO+HdysEiMbTzi5I
 RR4en+AU5HQw==
X-IronPort-AV: E=McAfee;i="6000,8403,9800"; a="167369971"
X-IronPort-AV: E=Sophos;i="5.77,466,1596524400"; 
   d="scan'208";a="167369971"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 02:50:19 -0800
IronPort-SDR: R4mRClaaVexvWM8Xzc9bwEJH8ERSXmXlauViygka+H/aSC/OWKd7d1O6fNbREzsz+WhyXKj+AS
 yv0P6qjVIo0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,466,1596524400"; 
   d="scan'208";a="428325868"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 10 Nov 2020 02:50:16 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 10 Nov 2020 12:50:15 +0200
Date:   Tue, 10 Nov 2020 12:50:15 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH v2 2/2] platform/chrome: cros_ec_typec: Set partner
 num_altmodes
Message-ID: <20201110105015.GF1224435@kuha.fi.intel.com>
References: <20201110061535.2163599-1-pmalani@chromium.org>
 <20201110061535.2163599-2-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110061535.2163599-2-pmalani@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 09, 2020 at 10:15:36PM -0800, Prashant Malani wrote:
> Set the number of altmodes available for a registered partner using the
> Type C connector class framework routine.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> 
> Changes in v2:
> - Patch introduced for the first time in v2.
> 
>  drivers/platform/chrome/cros_ec_typec.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index ce031a10eb1b..743a28426f98 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -621,6 +621,7 @@ static int cros_typec_register_altmodes(struct cros_typec_data *typec, int port_
>  	struct cros_typec_altmode_node *node;
>  	struct typec_altmode_desc desc;
>  	struct typec_altmode *amode;
> +	int num_altmodes = 0;
>  	int ret = 0;
>  	int i, j;
>  
> @@ -647,9 +648,16 @@ static int cros_typec_register_altmodes(struct cros_typec_data *typec, int port_
>  
>  			node->amode = amode;
>  			list_add_tail(&node->list, &port->partner_mode_list);
> +			num_altmodes++;
>  		}
>  	}
>  
> +	ret = typec_partner_set_num_altmodes(port->partner, num_altmodes);
> +	if (ret < 0) {
> +		dev_err(typec->dev, "Unable to set partner num_altmodes for port: %d\n", port_num);
> +		goto err_cleanup;
> +	}
> +
>  	return 0;
>  
>  err_cleanup:
> -- 
> 2.29.2.222.g5d2a92d10f8-goog

thanks,

-- 
heikki
