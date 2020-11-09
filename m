Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7F772AB253
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 09:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgKIIVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 03:21:41 -0500
Received: from mga04.intel.com ([192.55.52.120]:10121 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726127AbgKIIVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 03:21:41 -0500
IronPort-SDR: SQK8nSCUtXhY69jb39xP1V0HRN07K0I3wZl0rkSB7QwkDBXu/Psnhz5d0nVgMDpAn7kbD7HmDW
 3pxeWm6thlNQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9799"; a="167180726"
X-IronPort-AV: E=Sophos;i="5.77,463,1596524400"; 
   d="scan'208";a="167180726"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 00:21:41 -0800
IronPort-SDR: 1QHL9hl5i/AFL5m9rnjISD4M/EbsLnbNoQDPRvHfBv8CUSjc5dWVtuJuHlqqEj2tpfDamD6X4d
 Rz/t/yBYhx6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,463,1596524400"; 
   d="scan'208";a="427917472"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 09 Nov 2020 00:21:38 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 09 Nov 2020 10:21:38 +0200
Date:   Mon, 9 Nov 2020 10:21:38 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH v2 1/6] platform/chrome: cros_ec_typec: Make disc_done
 flag partner-only
Message-ID: <20201109082138.GC4062920@kuha.fi.intel.com>
References: <20201106184104.939284-1-pmalani@chromium.org>
 <20201106184104.939284-2-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106184104.939284-2-pmalani@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06, 2020 at 10:40:59AM -0800, Prashant Malani wrote:
> Change the disc_done flag, which indicates whether PD discovery is
> complete, to sop_disc_done instead, since we will process SOP and SOP'
> discovery data separately.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> 
> Changes in v2:
> - No changes.
> 
>  drivers/platform/chrome/cros_ec_typec.c | 19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index ce031a10eb1b..801c3d2c1fbd 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -57,8 +57,8 @@ struct cros_typec_port {
>  	/* Port alt modes. */
>  	struct typec_altmode p_altmode[CROS_EC_ALTMODE_MAX];
>  
> -	/* Flag indicating that PD discovery data parsing is completed. */
> -	bool disc_done;
> +	/* Flag indicating that PD partner discovery data parsing is completed. */
> +	bool sop_disc_done;
>  	struct ec_response_typec_discovery *sop_disc;
>  	struct list_head partner_mode_list;
>  };
> @@ -210,7 +210,7 @@ static void cros_typec_remove_partner(struct cros_typec_data *typec,
>  	typec_unregister_partner(port->partner);
>  	port->partner = NULL;
>  	memset(&port->p_identity, 0, sizeof(port->p_identity));
> -	port->disc_done = false;
> +	port->sop_disc_done = false;
>  }
>  
>  static void cros_unregister_ports(struct cros_typec_data *typec)
> @@ -727,18 +727,13 @@ static void cros_typec_handle_status(struct cros_typec_data *typec, int port_num
>  		return;
>  	}
>  
> -	if (typec->ports[port_num]->disc_done)
> -		return;
> -
>  	/* Handle any events appropriately. */
> -	if (resp.events & PD_STATUS_EVENT_SOP_DISC_DONE) {
> +	if (resp.events & PD_STATUS_EVENT_SOP_DISC_DONE && !typec->ports[port_num]->sop_disc_done) {
>  		ret = cros_typec_handle_sop_disc(typec, port_num);
> -		if (ret < 0) {
> +		if (ret < 0)
>  			dev_err(typec->dev, "Couldn't parse SOP Disc data, port: %d\n", port_num);
> -			return;
> -		}
> -
> -		typec->ports[port_num]->disc_done = true;
> +		else
> +			typec->ports[port_num]->sop_disc_done = true;
>  	}
>  }
>  

thanks,

-- 
heikki
