Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96F772A0673
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 14:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgJ3NbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 09:31:20 -0400
Received: from mga18.intel.com ([134.134.136.126]:4304 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbgJ3NbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 09:31:19 -0400
IronPort-SDR: 9RqpmY8ZUqJ2IZx8hJQ3LxT+gUSUOOzZQj1dJ8dLoemFQHm6UPBmL0YV3ujPVOWVDr23IvT2qF
 1k/+ZLSVs+9g==
X-IronPort-AV: E=McAfee;i="6000,8403,9789"; a="156379470"
X-IronPort-AV: E=Sophos;i="5.77,433,1596524400"; 
   d="scan'208";a="156379470"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 06:31:18 -0700
IronPort-SDR: hVA7IXgqAsOFJz8lElukhkMgmh2a/a0fanCp03tYQljYp4P+WJIjMv4XiHJ0IHXFqWjdfKVrbi
 FcI1Di18q3yQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,433,1596524400"; 
   d="scan'208";a="425345546"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 30 Oct 2020 06:31:14 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 30 Oct 2020 15:31:14 +0200
Date:   Fri, 30 Oct 2020 15:31:14 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, dzigterman@chromium.org,
        alevkoy@chromium.org, Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH v2 6/7] platform/chrome: cros_ec_typec: Parse partner PD
 ID VDOs
Message-ID: <20201030133114.GE2333887@kuha.fi.intel.com>
References: <20201029222738.482366-1-pmalani@chromium.org>
 <20201029222738.482366-7-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029222738.482366-7-pmalani@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 03:27:40PM -0700, Prashant Malani wrote:
> Use EC_CMD_TYPE_DISCOVERY to retrieve and store the discovery data for
> the port partner. With that data, update the PD Identity VDO values for
> the partner, which were earlier not initialized.
> 
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

FWIW:

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> 
> Changes in v2:
> - No changes
> 
>  drivers/platform/chrome/cros_ec_typec.c | 60 ++++++++++++++++++++++++-
>  1 file changed, 59 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index f578d0bfbe5a..f14550dac614 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -14,6 +14,7 @@
>  #include <linux/platform_data/cros_usbpd_notify.h>
>  #include <linux/platform_device.h>
>  #include <linux/usb/pd.h>
> +#include <linux/usb/pd_vdo.h>
>  #include <linux/usb/typec.h>
>  #include <linux/usb/typec_altmode.h>
>  #include <linux/usb/typec_dp.h>
> @@ -51,6 +52,7 @@ struct cros_typec_port {
>  
>  	/* Flag indicating that PD discovery data parsing is completed. */
>  	bool disc_done;
> +	struct ec_response_typec_discovery *sop_disc;
>  };
>  
>  /* Platform-specific data for the Chrome OS EC Type C controller. */
> @@ -298,6 +300,12 @@ static int cros_typec_init_ports(struct cros_typec_data *typec)
>  				port_num);
>  
>  		cros_typec_register_port_altmodes(typec, port_num);
> +
> +		cros_port->sop_disc = devm_kzalloc(dev, EC_PROTO2_MAX_RESPONSE_SIZE, GFP_KERNEL);
> +		if (!cros_port->sop_disc) {
> +			ret = -ENOMEM;
> +			goto unregister_ports;
> +		}
>  	}
>  
>  	return 0;
> @@ -582,6 +590,51 @@ static int cros_typec_get_mux_info(struct cros_typec_data *typec, int port_num,
>  				     sizeof(req), resp, sizeof(*resp));
>  }
>  
> +static int cros_typec_handle_sop_disc(struct cros_typec_data *typec, int port_num)
> +{
> +	struct cros_typec_port *port = typec->ports[port_num];
> +	struct ec_response_typec_discovery *sop_disc = port->sop_disc;
> +	struct ec_params_typec_discovery req = {
> +		.port = port_num,
> +		.partner_type = TYPEC_PARTNER_SOP,
> +	};
> +	int ret = 0;
> +	int i;
> +
> +	if (!port->partner) {
> +		dev_err(typec->dev,
> +			"SOP Discovery received without partner registered, port: %d\n",
> +			port_num);
> +		ret = -EINVAL;
> +		goto disc_exit;
> +	}
> +
> +	memset(sop_disc, 0, EC_PROTO2_MAX_RESPONSE_SIZE);
> +	ret = cros_typec_ec_command(typec, 0, EC_CMD_TYPEC_DISCOVERY, &req, sizeof(req),
> +				    sop_disc, EC_PROTO2_MAX_RESPONSE_SIZE);
> +	if (ret < 0) {
> +		dev_err(typec->dev, "Failed to get SOP discovery data for port: %d\n", port_num);
> +		goto disc_exit;
> +	}
> +
> +	/* First, update the PD identity VDOs for the partner. */
> +	if (sop_disc->identity_count > 0)
> +		port->p_identity.id_header = sop_disc->discovery_vdo[0];
> +	if (sop_disc->identity_count > 1)
> +		port->p_identity.cert_stat = sop_disc->discovery_vdo[1];
> +	if (sop_disc->identity_count > 2)
> +		port->p_identity.product = sop_disc->discovery_vdo[2];
> +
> +	/* Copy the remaining identity VDOs till a maximum of 6. */
> +	for (i = 3; i < sop_disc->identity_count && i < VDO_MAX_OBJECTS; i++)
> +		port->p_identity.vdo[i - 3] = sop_disc->discovery_vdo[i];
> +
> +	ret = typec_partner_set_identity(port->partner);
> +
> +disc_exit:
> +	return ret;
> +}
> +
>  static void cros_typec_handle_status(struct cros_typec_data *typec, int port_num)
>  {
>  	struct ec_response_typec_status resp;
> @@ -602,7 +655,12 @@ static void cros_typec_handle_status(struct cros_typec_data *typec, int port_num
>  
>  	/* Handle any events appropriately. */
>  	if (resp.events & PD_STATUS_EVENT_SOP_DISC_DONE) {
> -		dev_dbg(typec->dev, "SOP Discovery done for port: %d\n", port_num);
> +		ret = cros_typec_handle_sop_disc(typec, port_num);
> +		if (ret < 0) {
> +			dev_err(typec->dev, "Couldn't parse SOP Disc data, port: %d\n", port_num);
> +			return;
> +		}
> +
>  		typec->ports[port_num]->disc_done = true;
>  	}
>  }

thanks,

-- 
heikki
