Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A03C42AB25B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 09:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgKII1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 03:27:43 -0500
Received: from mga05.intel.com ([192.55.52.43]:2548 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbgKII1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 03:27:43 -0500
IronPort-SDR: fSkMqY3SJCvmwxqcxpxhU89KCvJGkc/lz3P+2IQlckHKjmIzQf0ZVpmf8DAwJMiex9IxfFZHtE
 FZa98j4ua2WA==
X-IronPort-AV: E=McAfee;i="6000,8403,9799"; a="254474375"
X-IronPort-AV: E=Sophos;i="5.77,463,1596524400"; 
   d="scan'208";a="254474375"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 00:27:42 -0800
IronPort-SDR: Lj6pTrFm4NEjQGjSR9ul59SY//xesgg3qG0lyvUg/KmMKSN3GnTOorKx2hDTShHj8M0lWYnIzz
 g05b0aB7MWcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,463,1596524400"; 
   d="scan'208";a="427919571"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 09 Nov 2020 00:27:38 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 09 Nov 2020 10:27:38 +0200
Date:   Mon, 9 Nov 2020 10:27:38 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH v2 4/6] platform/chrome: cros_ec_typec: Register cable
Message-ID: <20201109082738.GF4062920@kuha.fi.intel.com>
References: <20201106184104.939284-1-pmalani@chromium.org>
 <20201106184104.939284-5-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106184104.939284-5-pmalani@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06, 2020 at 10:41:06AM -0800, Prashant Malani wrote:
> When the Chrome Embedded Controller notifies the driver that SOP'
> discovery is complete, retrieve the PD discovery data and register a
> cable object with the Type C connector class framework.
> 
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> 
> Changes in v2:
> - No changes.
> 
>  drivers/platform/chrome/cros_ec_typec.c | 67 +++++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
> 
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index 3c8ff07c8803..5e7f0b4ebbec 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -44,8 +44,11 @@ struct cros_typec_port {
>  	/* Initial capabilities for the port. */
>  	struct typec_capability caps;
>  	struct typec_partner *partner;
> +	struct typec_cable *cable;
>  	/* Port partner PD identity info. */
>  	struct usb_pd_identity p_identity;
> +	/* Port cable PD identity info. */
> +	struct usb_pd_identity c_identity;
>  	struct typec_switch *ori_sw;
>  	struct typec_mux *mux;
>  	struct usb_role_switch *role_sw;
> @@ -59,6 +62,7 @@ struct cros_typec_port {
>  
>  	/* Flag indicating that PD partner discovery data parsing is completed. */
>  	bool sop_disc_done;
> +	bool sop_prime_disc_done;
>  	struct ec_response_typec_discovery *disc_data;
>  	struct list_head partner_mode_list;
>  };
> @@ -213,6 +217,17 @@ static void cros_typec_remove_partner(struct cros_typec_data *typec,
>  	port->sop_disc_done = false;
>  }
>  
> +static void cros_typec_remove_cable(struct cros_typec_data *typec,
> +				    int port_num)
> +{
> +	struct cros_typec_port *port = typec->ports[port_num];
> +
> +	typec_unregister_cable(port->cable);
> +	port->cable = NULL;
> +	memset(&port->c_identity, 0, sizeof(port->c_identity));
> +	port->sop_prime_disc_done = false;
> +}
> +
>  static void cros_unregister_ports(struct cros_typec_data *typec)
>  {
>  	int i;
> @@ -224,6 +239,9 @@ static void cros_unregister_ports(struct cros_typec_data *typec)
>  		if (typec->ports[i]->partner)
>  			cros_typec_remove_partner(typec, i);
>  
> +		if (typec->ports[i]->cable)
> +			cros_typec_remove_cable(typec, i);
> +
>  		usb_role_switch_put(typec->ports[i]->role_sw);
>  		typec_switch_put(typec->ports[i]->ori_sw);
>  		typec_mux_put(typec->ports[i]->mux);
> @@ -600,6 +618,9 @@ static void cros_typec_set_port_params_v1(struct cros_typec_data *typec,
>  		if (!typec->ports[port_num]->partner)
>  			return;
>  		cros_typec_remove_partner(typec, port_num);
> +
> +		if (typec->ports[port_num]->cable)
> +			cros_typec_remove_cable(typec, port_num);
>  	}
>  }
>  
> @@ -679,6 +700,43 @@ static void cros_typec_parse_pd_identity(struct usb_pd_identity *id,
>  		id->vdo[i - 3] = disc->discovery_vdo[i];
>  }
>  
> +static int cros_typec_handle_sop_prime_disc(struct cros_typec_data *typec, int port_num)
> +{
> +	struct cros_typec_port *port = typec->ports[port_num];
> +	struct ec_response_typec_discovery *disc = port->disc_data;
> +	struct typec_cable_desc desc = {};
> +	struct ec_params_typec_discovery req = {
> +		.port = port_num,
> +		.partner_type = TYPEC_PARTNER_SOP_PRIME,
> +	};
> +	int ret = 0;
> +
> +	memset(disc, 0, EC_PROTO2_MAX_RESPONSE_SIZE);
> +	ret = cros_typec_ec_command(typec, 0, EC_CMD_TYPEC_DISCOVERY, &req, sizeof(req),
> +				    disc, EC_PROTO2_MAX_RESPONSE_SIZE);
> +	if (ret < 0) {
> +		dev_err(typec->dev, "Failed to get SOP' discovery data for port: %d\n", port_num);
> +		goto sop_prime_disc_exit;
> +	}
> +
> +	/* Parse the PD identity data, even if only 0s were returned. */
> +	cros_typec_parse_pd_identity(&port->c_identity, disc);
> +
> +	if (disc->identity_count != 0)
> +		desc.active = PD_IDH_PTYPE(port->c_identity.id_header) == IDH_PTYPE_ACABLE;
> +
> +	desc.identity = &port->c_identity;
> +
> +	port->cable = typec_register_cable(port->port, &desc);
> +	if (IS_ERR(port->cable)) {
> +		ret = PTR_ERR(port->cable);
> +		port->cable = NULL;
> +	}
> +
> +sop_prime_disc_exit:
> +	return ret;
> +}
> +
>  static int cros_typec_handle_sop_disc(struct cros_typec_data *typec, int port_num)
>  {
>  	struct cros_typec_port *port = typec->ports[port_num];
> @@ -746,6 +804,15 @@ static void cros_typec_handle_status(struct cros_typec_data *typec, int port_num
>  		else
>  			typec->ports[port_num]->sop_disc_done = true;
>  	}
> +
> +	if (resp.events & PD_STATUS_EVENT_SOP_PRIME_DISC_DONE &&
> +	    !typec->ports[port_num]->sop_prime_disc_done) {
> +		ret = cros_typec_handle_sop_prime_disc(typec, port_num);
> +		if (ret < 0)
> +			dev_err(typec->dev, "Couldn't parse SOP' Disc data, port: %d\n", port_num);
> +		else
> +			typec->ports[port_num]->sop_prime_disc_done = true;
> +	}
>  }
>  
>  static int cros_typec_port_update(struct cros_typec_data *typec, int port_num)
> -- 
> 2.29.1.341.ge80a0c044ae-goog

thanks,

-- 
heikki
